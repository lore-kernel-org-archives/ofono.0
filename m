Content-Type: multipart/mixed; boundary="===============6007560992141080990=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp: create modem for new devices paired on runtime
Date: Mon, 01 Feb 2010 11:49:47 -0600
Message-ID: <201002011149.48212.denkenz@gmail.com>
In-Reply-To: <1265045427-14794-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6007560992141080990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> It listens the Paired property to create a modem to the recently paired
> devices.
> ---
>  plugins/hfp.c |   60
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 files =

changed,
>  59 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/hfp.c b/plugins/hfp.c
> index 0e2e359..2141078 100644
> --- a/plugins/hfp.c
> +++ b/plugins/hfp.c
> @@ -594,6 +594,55 @@ static gboolean adapter_added(DBusConnection
>  *connection, DBusMessage *message, return TRUE;
>  }
> =

> +static gboolean paired_added(DBusConnection *connection, DBusMessage
>  *message, +				void *user_data)
> +{
> +	DBusError err;
> +	const char *device, *paired;
> +	DBusMessageIter iter, variant;
> +	int ret, value;
> +
> +	dbus_error_init(&err);
> +
> +	if (dbus_message_get_args(message, &err, DBUS_TYPE_STRING,
> +				 &paired, DBUS_TYPE_INVALID) =3D=3D FALSE) {
> +		if (dbus_error_is_set(&err) =3D=3D TRUE) {
> +			ofono_error("%s", err.message);
> +			dbus_error_free(&err);
> +		}
> +
> +		return FALSE;
> +	}
> +
> +	if (strcmp(paired, "Paired"))
> +		return TRUE;
> +
> +	dbus_message_iter_init(message, &iter);

Why can't we do something like?
dbus_message_iter_init();
if (dbus_message_iter_get_arg_type(&iter) !=3D STRING)
	return;

dbus_message_iter_get_basic(&iter, &property);
if (g_str_equal(property, "Paired") =3D=3D FALSE)
	return;

I really don't like mixing the two ways of parsing the message and this way =

seems cleaner.

> +	if (dbus_message_iter_get_arg_type(&iter) =3D=3D DBUS_TYPE_STRING) {
> +
> +		if (!dbus_message_iter_next(&iter))
> +			return FALSE;
> +
> +		dbus_message_iter_recurse(&iter, &variant);
> +		dbus_message_iter_get_basic(&variant, &value);
> +
> +		if (!value)
> +			return TRUE;
> +	}

You might want to check the second argument is indeed a DBUS_TYPE_VARIANT a=
nd =

the value of the variant is what you're expecting.

We really need to make a function for this in gdbus.

Regards,
-Denis

--===============6007560992141080990==--

