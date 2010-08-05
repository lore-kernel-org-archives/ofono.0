Content-Type: multipart/mixed; boundary="===============1665534835530588286=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] Add dun_enable() function
Date: Thu, 05 Aug 2010 10:42:07 -0500
Message-ID: <4C5ADBCF.80804@gmail.com>
In-Reply-To: <1280917334-4519-3-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1665534835530588286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> +static void dun_connect_reply(DBusPendingCall *call, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct dun_data *data =3D ofono_modem_get_data(modem);
> +	const char *dev;
> +	DBusError derr;
> +	DBusMessage *reply, *msg;
> +
> +	reply =3D dbus_pending_call_steal_reply(call);
> +
> +	if (ofono_modem_get_powered(modem))
> +		goto done;

I prefer you don't do this check above.  If the core isn't doing
something right I want things to crash right away.

> +
> +	if (!dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &dev,
> +				DBUS_TYPE_INVALID))
> +		goto done;

That seems wrong, you need to tell the core powering up failed.  This
should be treated as an error.

> +
> +	data->rfcomm =3D g_strdup(dev);
> +
> +	dbus_error_init(&derr);
> +	if (!dbus_set_error_from_message(&derr, reply)) {
> +		ofono_modem_set_powered(modem, TRUE);
> +		goto done;
> +	}

Checking for D-Bus Error should be done before grabbing the reply
arguments, especially since you never free rfcomm above.

> +
> +	DBG("Connect reply: %s", derr.message);
> +
> +	if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) {
> +		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
> +				data->dun_path,
> +				BLUEZ_SERIAL_INTERFACE, "Disconnect");
> +		if (!msg)
> +			ofono_error("Disconnect failed");
> +		else
> +			g_dbus_send_message(connection, msg);
> +	}

I'm not sure this part is really necessary.  How can we trigger a
condition where this function fails but the tty device is created?

> +
> +	ofono_modem_set_powered(modem, FALSE);
> +
> +	dbus_error_free(&derr);

Might want to localize dbus_error_free() to the same area where it is
being used.  Makes the code easier to read.

> +
> +done:
> +	dbus_message_unref(reply);
> +}
> +
>  static int dun_enable(struct ofono_modem *modem)
>  {
> -	DBG("%p", modem);

Might want to leave the DBG in there.

> -	return 0;
> +	struct dun_data *data =3D ofono_modem_get_data(modem);
> +	int status;
> +	const char *uuid =3D DUN_GW_UUID;
> +
> +	status =3D bluetooth_send_with_reply(data->dun_path,
> +					BLUEZ_SERIAL_INTERFACE, "Connect",
> +					dun_connect_reply, modem, NULL,
> +					DBUS_TIMEOUT, DBUS_TYPE_STRING, &uuid,
> +					DBUS_TYPE_INVALID);
> +
> +	if (status < 0)
> +		return -EINVAL;
> +
> +	return -EINPROGRESS;
>  }
>  =

>  static int dun_disable(struct ofono_modem *modem)

Regards,
-Denis

--===============1665534835530588286==--

