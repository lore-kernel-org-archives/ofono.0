Content-Type: multipart/mixed; boundary="===============4927433524259402484=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Thu, 27 May 2010 14:32:45 +0300
Message-ID: <1274959965.3755.492.camel@tucson.research.nokia.com>
In-Reply-To: <1274957690-4893-6-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4927433524259402484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-05-27 at 12:54 +0200, ext pasi.miettinen(a)ixonos.com wrote:
> diff --git a/src/sms.c b/src/sms.c
> index b4a5364..d079ece 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -400,6 +400,7 @@ static DBusMessage *sms_send_message(DBusConnection *=
conn, DBusMessage *msg,
>  	struct ofono_sms *sms =3D data;
>  	const char *to;
>  	const char *text;
> +	gboolean ask_status_report;
>  	GSList *msg_list;
>  	int ref_offset;
>  	struct tx_queue_entry *entry;
> @@ -407,13 +408,14 @@ static DBusMessage *sms_send_message(DBusConnection=
 *conn, DBusMessage *msg,
>  =

>  	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
>  					DBUS_TYPE_STRING, &text,
> +					DBUS_TYPE_BOOLEAN, &ask_status_report,
>  					DBUS_TYPE_INVALID))
>  		return __ofono_error_invalid_args(msg);
>  =

>  	if (valid_phone_number_format(to) =3D=3D FALSE)
>  		return __ofono_error_invalid_format(msg);
>  =

> -	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset);
> +	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset, ask_status_re=
port);
>  =

>  	if (!msg_list)
>  		return __ofono_error_invalid_format(msg);
> @@ -453,7 +455,7 @@ static GDBusMethodTable sms_manager_methods[] =3D {
>  							G_DBUS_METHOD_FLAG_ASYNC },
>  	{ "SetProperty",	"sv",	"",		sms_set_property,
>  							G_DBUS_METHOD_FLAG_ASYNC },
> -	{ "SendMessage",	"ss",	"",		sms_send_message,
> +	{ "SendMessage",	"ssb",	"",		sms_send_message,
>  							G_DBUS_METHOD_FLAG_ASYNC },
>  	{ }
>  };

I don't like this being an argument to SendMessage(). I think it needs
to be exposed, but as a property instead. Is there a use case for
setting this per message? I think majority of current phones either
provide a global setting for this, or set it on by default.

Cheers,
Aki


--===============4927433524259402484==--

