Content-Type: multipart/mixed; boundary="===============5028525209565754173=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v2 2/3] gemalto: Implement HardwareMonitor method
Date: Tue, 16 May 2017 13:20:35 -0500
Message-ID: <3bd5451f-22f9-b7ed-3503-946fdcf87bcd@gmail.com>
In-Reply-To: <1494923922-8874-2-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5028525209565754173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 05/16/2017 03:38 AM, Vincent Cesson wrote:
> Use Gemalto commands ^SCTM and ^SBV to monitor temperature and voltage.
> Use a single method GetStatistics to read and return both values.
> ---
>  plugins/gemalto.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
>
> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 3798e09..9f67f17 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -53,6 +53,8 @@
>  #define HARDWARE_MONITOR_INTERFACE OFONO_SERVICE ".cinterion.HardwareMon=
itor"
>
>  static const char *none_prefix[] =3D { NULL };
> +static const char *sctm_prefix[] =3D { "^SCTM:", NULL };
> +static const char *sbv_prefix[] =3D { "^SBV:", NULL };
>
>  struct gemalto_hardware_monitor {
>  	DBusMessage *msg;
> @@ -155,13 +157,103 @@ static void cfun_enable(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>  						NULL);
>  }
>
> +static void gemalto_sctm_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	struct gemalto_data *data =3D user_data;
> +	GAtResultIter iter;
> +	DBusMessageIter dbus_iter;
> +	DBusMessageIter dbus_dict;
> +
> +	if (!ok)
> +		goto error;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "^SCTM:"))
> +		goto error;
> +
> +	if (!g_at_result_iter_skip_next(&iter))
> +		goto error;
> +
> +	if (!g_at_result_iter_skip_next(&iter))
> +		goto error;
> +
> +	if (!g_at_result_iter_next_number(&iter, &(data->hm->temperature)))

'()' are not needed around data->hm->temperature

> +		goto error;
> +
> +	dbus_message_iter_init_append(data->hm->msg, &dbus_iter);
> +
> +	dbus_message_iter_open_container(&dbus_iter, DBUS_TYPE_ARRAY,
> +			OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +			&dbus_dict);
> +
> +	ofono_dbus_dict_append(&dbus_dict, "Temperature",
> +			DBUS_TYPE_INT32, &data->hm->temperature);
> +
> +	ofono_dbus_dict_append(&dbus_dict, "Voltage",
> +			DBUS_TYPE_UINT32, &data->hm->voltage);
> +
> +	dbus_message_iter_close_container(&dbus_iter, &dbus_dict);
> +
> +	g_dbus_send_message(conn, data->hm->msg);
> +
> +	data->hm->msg =3D NULL;

or use __ofono_dbus_pending_reply to save a few steps.

> +
> +	return;
> +
> +error:
> +	g_dbus_send_error(conn, data->hm->msg, DBUS_ERROR_FAILED,
> +			"Unable to read temperature");
> +}
> +
> +static void gemalto_sbv_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	struct gemalto_data *data =3D user_data;
> +	GAtResultIter iter;
> +
> +	if (!ok)
> +		goto error;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "^SBV:"))
> +		goto error;
> +
> +	if (!g_at_result_iter_next_number(&iter, &(data->hm->voltage)))

'()' around data->hm->voltage are not needed

> +		goto error;
> +
> +	if (!g_at_chat_send(data->app, "AT^SCTM?", sctm_prefix, gemalto_sctm_cb,
> +			data, NULL))
> +		g_dbus_send_error(conn, data->hm->msg, DBUS_ERROR_FAILED,
> +				"Unable to read temperature");
> +
> +	return;
> +

I'm not sure distinguishing between voltage and temperature errors is =

useful.  So why why not:

if (g_at_chat_send(...) > 0)
	return;

> +error:
> +	g_dbus_send_error(conn, data->hm->msg, DBUS_ERROR_FAILED,
> +			"Unable to read voltage");

and change this to a generic failed message.  You can use =

__ofono_dbus_pending_reply.  This will have the benefit of setting =

hm->msg to NULL so that subsequent GetStatistics calls don't return 'busy'.

> +}
> +
>  static DBusMessage *hardware_monitor_get_statistics(DBusConnection *conn,
>  							DBusMessage *msg,
>  							void *user_data)
>  {
> +	struct gemalto_data *data =3D user_data;
> +
>  	DBG("");
>
> -	return __ofono_error_not_implemented(msg);
> +	if (data->hm->msg !=3D NULL)
> +		return __ofono_error_busy(msg);
> +
> +	if (!g_at_chat_send(data->app, "AT^SBV", sbv_prefix, gemalto_sbv_cb,
> +			data, NULL))
> +		return __ofono_error_failed(msg);
> +
> +	data->hm->msg =3D dbus_message_new_method_return(msg);
> +
> +	return NULL;
>  }
>
>  static const GDBusMethodTable hardware_monitor_methods[] =3D {
>

Regards,
-Denis

--===============5028525209565754173==--

