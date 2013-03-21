Content-Type: multipart/mixed; boundary="===============6996326647704454194=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/2] dun_gw: Add BlueZ 5 version
Date: Thu, 21 Mar 2013 10:21:32 -0500
Message-ID: <514B257C.8070303@gmail.com>
In-Reply-To: <1363093290-8723-2-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6996326647704454194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

On 03/12/2013 08:01 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> This patch adds initial implementation of the D-Bus Profile1
> interface and methods responsible for handling Bluetooth connections.
>
> The DUN GW profile interface is registered as soon as a GPRS capable
> modem is registered in oFono.
> ---
>   Makefile.am             |    3 +
>   plugins/bluez5.h        |    1 +
>   plugins/dun_gw_bluez5.c |  235 ++++++++++++++++++++++++++++++++++++++++=
+++++++
>   3 files changed, 239 insertions(+)
>   create mode 100644 plugins/dun_gw_bluez5.c
>

I applied this patch, but I had to fix a minor issue afterwards:

> +static DBusMessage *profile_new_connection(DBusConnection *conn,
> +						DBusMessage *msg, void *data)
> +{
> +	DBusMessageIter entry;
> +	const char *device;
> +	int fd;
> +	struct ofono_emulator *em;
> +	struct ofono_modem *modem;
> +
> +	DBG("Profile handler NewConnection");
> +
> +	if (dbus_message_iter_init(msg,&entry) =3D=3D FALSE)
> +		goto invalid;
> +
> +	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_OBJECT_PATH)
> +		goto invalid;
> +
> +	dbus_message_iter_get_basic(&entry,&device);
> +	dbus_message_iter_next(&entry);
> +
> +	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
> +		goto invalid;
> +
> +	dbus_message_iter_get_basic(&entry,&fd);
> +	dbus_message_iter_next(&entry);
> +
> +	if (fd<  0)
> +		goto invalid;
> +
> +	DBG("%s", device);
> +
> +	/* Pick the first powered modem */
> +	modem =3D modems->data;
> +	if (modem =3D=3D NULL) {

We should be checking for modems =3D=3D NULL, not modems->data

> +		close(fd);
> +		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
> +						".Rejected",
> +						"No voice call capable modem");

This was changed to read '...GPRS capable modem'.

> +	}
> +
> +	DBG("Picked modem %p for emulator", modem);
> +
> +	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_DUN);
> +	if (em =3D=3D NULL) {
> +		close(fd);
> +		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
> +						".Rejected",
> +						"Not enough resources");
> +	}
> +
> +	ofono_emulator_register(em, fd);
> +
> +	return dbus_message_new_method_return(msg);
> +
> +invalid:
> +	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
> +					"Invalid arguments in method call");
> +}
> +

Regards,
-Denis

--===============6996326647704454194==--

