Content-Type: multipart/mixed; boundary="===============0859580680343283006=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 20/20] SMS: Implement D-Bus SMS-MSG::GetProperties
Date: Tue, 27 Jul 2010 12:18:48 -0500
Message-ID: <4C4F14F8.5080700@gmail.com>
In-Reply-To: <95963779354386a04005f5bf2067149d91a53969.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0859580680343283006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> +static DBusMessage *dbus_sms_msg_get_properties(
> +	DBusConnection * conn, DBusMessage *dbus_msg, void *_sms_msg)
> +{
> +	struct tx_queue_entry *sms_msg =3D _sms_msg;
> +	DBusMessage *reply;
> +	DBusMessageIter iter;
> +	DBusMessageIter dict;
> +	const char *str;
> +
> +	reply =3D dbus_message_new_method_return(dbus_msg);
> +	if (!reply)
> +		return NULL;

Empty line here

> +	dbus_message_iter_init_append(reply, &iter);
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +					 OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +					 &dict);

Empty line here

> +	str =3D ofono_sms_tx_state_to_string(sms_msg->state);
> +	ofono_dbus_dict_append(&dict, "TXState", DBUS_TYPE_STRING, &str);

Empty line here
> +	dbus_message_iter_close_container(&iter, &dict);

And one more here

Also, you might want to think about what other properties would be
useful here.  E.g. perhaps queue time, submission time, To address,
contents?

> +	return reply;
> +}
> +
> +

No double empty lines allowed.

>  /*
>   * Note that the D-Bus specific cleanups are taken care by the
>   * sms_msg_dbus_destroy() callback passed in dbus_sms_msg_send().
> @@ -564,6 +587,8 @@ static DBusMessage *dbus_sms_msg_cancel(
>  =

>  static
>  GDBusMethodTable sms_msg_methods[] =3D {
> +	{ "GetProperties",	"",	"a{sv}",
> +	  dbus_sms_msg_get_properties, G_DBUS_METHOD_FLAG_ASYNC },

Why exactly is this method ASYNC?

>  	{ "Cancel",		DBUS_TYPE_BOOLEAN_AS_STRING,	"",
>  	  dbus_sms_msg_cancel, 0 },
>  	{ }

Regards,
-Denis

--===============0859580680343283006==--

