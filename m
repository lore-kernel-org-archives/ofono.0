Content-Type: multipart/mixed; boundary="===============5458540562701514145=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCHv2 1/4] quectel: add dbus hardware interface
Date: Fri, 19 Jul 2019 12:22:35 +0200
Message-ID: <38a05c1d-69e5-d449-4de3-accbe3ffa5ed@geanix.com>
In-Reply-To: <20190719101914.122689-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5458540562701514145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 19/07/2019 12.19, Martin Hundeb=C3=B8ll wrote:
> For now the interface only exposes the modem supply voltage, but is
> added as a preparation for signaling power events.

This is obviously not true, since the API also exposes charge status and =

level on the UC15 modem.

Feel free to update the text to:

For now the interface only exposes Voltage, ChargeStatus, and =

ChargeLevel, but is added as preparation for signaling power events.


// Martin

> ---
> =

> Changes since v1:
>   * use and export int32_t for all three properties
>   * place dbus functions below close_serial()
>   * remove doc/ changes
>   * update comments for charge status and level
>   * unregister dbus api after canceling/unregister at chats
> =

>   plugins/quectel.c | 158 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 158 insertions(+)
> =

> diff --git a/plugins/quectel.c b/plugins/quectel.c
> index 9cac92fa..efdb7617 100644
> --- a/plugins/quectel.c
> +++ b/plugins/quectel.c
> @@ -37,6 +37,7 @@
>   #include <gattty.h>
>   =

>   #define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono.h>
>   #include <ofono/plugin.h>
>   #include <ofono/modem.h>
>   #include <ofono/devinfo.h>
> @@ -49,12 +50,16 @@
>   #include <ofono/gprs.h>
>   #include <ofono/gprs-context.h>
>   #include <ofono/log.h>
> +#include <ofono/dbus.h>
> +
> +#include <gdbus/gdbus.h>
>   =

>   #include <drivers/atmodem/atutil.h>
>   #include <drivers/atmodem/vendor.h>
>   =

>   static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
>   static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
> +static const char *cbc_prefix[] =3D { "+CBC:", NULL };
>   static const char *qinistat_prefix[] =3D { "+QINISTAT:", NULL };
>   static const char *cgmm_prefix[] =3D { "UC15", "Quectel_M95", "Quectel_=
MC60",
>   					NULL };
> @@ -95,6 +100,16 @@ struct quectel_data {
>   	struct l_gpio_writer *gpio;
>   };
>   =

> +struct dbus_hw {
> +	DBusMessage *msg;
> +	struct ofono_modem *modem;
> +	int32_t charge_status;
> +	int32_t charge_level;
> +	int32_t voltage;
> +};
> +
> +static const char dbus_hw_interface[] =3D OFONO_SERVICE ".quectel.Hardwa=
re";
> +
>   static void quectel_debug(const char *str, void *user_data)
>   {
>   	const char *prefix =3D user_data;
> @@ -227,6 +242,142 @@ static void close_serial(struct ofono_modem *modem)
>   		ofono_modem_set_powered(modem, false);
>   }
>   =

> +static void dbus_hw_reply_properties(struct dbus_hw *hw)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(hw->modem);
> +	DBusMessage *reply;
> +	DBusMessageIter dbus_iter;
> +	DBusMessageIter dbus_dict;
> +
> +	DBG("%p", hw->modem);
> +
> +	reply =3D dbus_message_new_method_return(hw->msg);
> +	dbus_message_iter_init_append(reply, &dbus_iter);
> +	dbus_message_iter_open_container(&dbus_iter, DBUS_TYPE_ARRAY,
> +			OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +			&dbus_dict);
> +
> +	/*
> +	 * the charge status/level received from m95 and mc60 are invalid so
> +	 * only return those for the UC15 modem.
> +	 */
> +	if (data->model =3D=3D QUECTEL_UC15) {
> +		ofono_dbus_dict_append(&dbus_dict, "ChargeStatus",
> +					DBUS_TYPE_INT32, &hw->charge_status);
> +
> +		ofono_dbus_dict_append(&dbus_dict, "ChargeLevel",
> +					DBUS_TYPE_INT32, &hw->charge_level);
> +	}
> +
> +	ofono_dbus_dict_append(&dbus_dict, "Voltage", DBUS_TYPE_INT32,
> +				&hw->voltage);
> +
> +	dbus_message_iter_close_container(&dbus_iter, &dbus_dict);
> +
> +	__ofono_dbus_pending_reply(&hw->msg, reply);
> +}
> +
> +static void cbc_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct dbus_hw *hw =3D user_data;
> +	GAtResultIter iter;
> +
> +	DBG("%p", hw->modem);
> +
> +	if (!hw->msg)
> +		return;
> +
> +	if (!ok)
> +		goto error;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CBC:"))
> +		goto error;
> +
> +	/* the returned charge status is valid only for uc15 */
> +	if (!g_at_result_iter_next_number(&iter, &hw->charge_status))
> +		goto error;
> +
> +	/* the returned charge level is valid only for uc15 */
> +	if (!g_at_result_iter_next_number(&iter, &hw->charge_level))
> +		goto error;
> +
> +	/* now comes the millivolts */
> +	if (!g_at_result_iter_next_number(&iter, &hw->voltage))
> +		goto error;
> +
> +	dbus_hw_reply_properties(hw);
> +
> +	return;
> +
> +error:
> +	__ofono_dbus_pending_reply(&hw->msg, __ofono_error_failed(hw->msg));
> +}
> +
> +static DBusMessage *dbus_hw_get_properties(DBusConnection *conn,
> +						DBusMessage *msg,
> +						void *user_data)
> +{
> +	struct dbus_hw *hw =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(hw->modem);
> +
> +	DBG("%p", hw->modem);
> +
> +	if (hw->msg !=3D NULL)
> +		return __ofono_error_busy(msg);
> +
> +	if (!g_at_chat_send(data->aux, "AT+CBC", cbc_prefix, cbc_cb, hw, NULL))
> +		return __ofono_error_failed(msg);
> +
> +	hw->msg =3D dbus_message_ref(msg);
> +
> +	return NULL;
> +}
> +
> +static const GDBusMethodTable dbus_hw_methods[] =3D {
> +	{ GDBUS_ASYNC_METHOD("GetProperties",
> +				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
> +				dbus_hw_get_properties) },
> +	{}
> +};
> +
> +static void dbus_hw_cleanup(void *data)
> +{
> +	struct dbus_hw *hw =3D data;
> +
> +	DBG("%p", hw->modem);
> +
> +	if (hw->msg)
> +		__ofono_dbus_pending_reply(&hw->msg,
> +					__ofono_error_canceled(hw->msg));
> +
> +	l_free(hw);
> +}
> +
> +static void dbus_hw_enable(struct ofono_modem *modem)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D ofono_modem_get_path(modem);
> +	struct dbus_hw *hw;
> +
> +	DBG("%p", modem);
> +
> +	hw =3D l_new(struct dbus_hw, 1);
> +	hw->modem =3D modem;
> +
> +	if (!g_dbus_register_interface(conn, path, dbus_hw_interface,
> +					dbus_hw_methods, NULL, NULL,
> +					hw, dbus_hw_cleanup)) {
> +		ofono_error("Could not register %s interface under %s",
> +				dbus_hw_interface, path);
> +		l_free(hw);
> +		return;
> +	}
> +
> +	ofono_modem_add_interface(modem, dbus_hw_interface);
> +}
> +
>   static void cpin_notify(GAtResult *result, gpointer user_data)
>   {
>   	struct ofono_modem *modem =3D user_data;
> @@ -253,6 +404,8 @@ static void cpin_notify(GAtResult *result, gpointer u=
ser_data)
>   =

>   	g_at_chat_unregister(data->aux, data->cpin_ready);
>   	data->cpin_ready =3D 0;
> +
> +	dbus_hw_enable(modem);
>   }
>   =

>   static void cpin_query(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> @@ -650,6 +803,8 @@ static void cfun_disable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>   static int quectel_disable(struct ofono_modem *modem)
>   {
>   	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D ofono_modem_get_path(modem);
>   =

>   	DBG("%p", modem);
>   =

> @@ -659,6 +814,9 @@ static int quectel_disable(struct ofono_modem *modem)
>   	g_at_chat_cancel_all(data->aux);
>   	g_at_chat_unregister_all(data->aux);
>   =

> +	if (g_dbus_unregister_interface(conn, path, dbus_hw_interface))
> +		ofono_modem_remove_interface(modem, dbus_hw_interface);
> +
>   	g_at_chat_send(data->aux, "AT+CFUN=3D0", cfun_prefix, cfun_disable, mo=
dem,
>   			NULL);
>   =

>=20

--===============5458540562701514145==--

