Content-Type: multipart/mixed; boundary="===============2038166322141170933=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 3/6] Support for basic SMS Status Report.
Date: Fri, 04 Jun 2010 12:01:21 -0500
Message-ID: <201006041201.21504.denkenz@gmail.com>
In-Reply-To: <1275650257-30593-4-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2038166322141170933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> ---
>  src/sms.c |  110
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++- =

1 files
>  changed, 109 insertions(+), 1 deletions(-)
> =

> diff --git a/src/sms.c b/src/sms.c
> index 618e035..14748c6 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -553,6 +553,75 @@ static void dispatch_text_message(struct ofono_sms
>  *sms, }
>  }
> =

> +static void dispatch_sms_delivery_report(struct ofono_sms *sms,
> +					const enum sms_st *st,
> +					const struct sms_address *raddr,
> +					const struct sms_scts *scts,
> +					const struct sms_scts *dt)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(sms->atom);
> +	DBusMessage *signal;
> +	DBusMessageIter iter;
> +	DBusMessageIter dict;
> +	char buf[128];
> +	time_t ts;
> +	struct tm remote;
> +	struct tm local;
> +	const char *str =3D buf;
> +
> +	if (!st) {
> +		DBG("status unavailable");
> +		return;
> +	}
> +
> +	signal =3D dbus_message_new_signal(path, OFONO_SMS_MANAGER_INTERFACE,
> +						"IncomingStatusReport");
> +
> +	if (!signal)
> +		return;
> +
> +	/*Start assembling dbus-message*/
> +	dbus_message_iter_init_append(signal, &iter);
> +
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +						&dict);
> +
> +	/*This is the time when sender sent the message*/
> +	ts =3D sms_scts_to_time(scts, &remote);
> +	localtime_r(&ts, &local);
> +
> +	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &local);
> +	buf[127] =3D '\0';
> +	ofono_dbus_dict_append(&dict, "LocalSentTime", DBUS_TYPE_STRING, &str);
> +
> +	/*This is the time when the message was delivered to the recipient*/
> +	ts =3D sms_scts_to_time(dt, &remote);
> +	localtime_r(&ts, &local);
> +
> +	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &local);
> +	buf[127] =3D '\0';
> +	ofono_dbus_dict_append(&dict, "LocalDeliverTime",
> +					DBUS_TYPE_STRING, &str);
> +
> +	/*Status*/
> +	if (*st =3D=3D 0x00) {
> +		str =3D sms_address_to_string(raddr);
> +		ofono_dbus_dict_append(&dict, "delivered",
> +					DBUS_TYPE_STRING, &str);
> +	} else {
> +		str =3D sms_address_to_string(raddr);
> +		ofono_dbus_dict_append(&dict, "undeliverable",
> +					DBUS_TYPE_STRING, &str);
> +	}
> +
> +	/*dbus-message assembled*/
> +	dbus_message_iter_close_container(&iter, &dict);
> +
> +	g_dbus_send_message(conn, signal);
> +}
> +

We tend to do things bottom up here, so this patch should really come last =
and =

merged with changes from Patch 5.

Regards,
-Denis

--===============2038166322141170933==--

