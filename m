Content-Type: multipart/mixed; boundary="===============6072371090068821611=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 2/3] Add dun_enable() function
Date: Mon, 02 Aug 2010 22:24:02 +0800
Message-ID: <33AB447FBD802F4E932063B962385B3528D48144@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1280455753-24523-2-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6072371090068821611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Padovan,

Gustavo F. Padovan wrote:
> dun_enable() is called by setting the Powered property to true.
> It creates a rfcomm link throught the BlueZ Serial API.
> ---
>  drivers/dunmodem/dunmodem.h |    1 +
>  plugins/bluetooth.h         |    1 +
>  plugins/dun.c               |   61
>  +++++++++++++++++++++++++++++++++++++++++- 3 files changed, 61
> insertions(+), 2 deletions(-) =

> =

> diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
> index 6bbf7b9..16eb9e7 100644
> --- a/drivers/dunmodem/dunmodem.h
> +++ b/drivers/dunmodem/dunmodem.h
> @@ -23,6 +23,7 @@
> =

>  struct dun_data {
>  	char *dun_path;
> +	const char *rfcomm;
>  };
> =

>  #endif
> diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
> index 09e6efa..c20b36d 100644
> --- a/plugins/bluetooth.h
> +++ b/plugins/bluetooth.h
> @@ -22,6 +22,7 @@
>  #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
>  #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
>  #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
> +#define	BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
> =

>  #define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
>  #define DUN_GW_UUID	"00001103-0000-1000-8000-00805F9B34FB"
> diff --git a/plugins/dun.c b/plugins/dun.c
> index 9b4288e..7dc8422 100644
> --- a/plugins/dun.c
> +++ b/plugins/dun.c
> @@ -25,6 +25,7 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <errno.h>
> +#include <gdbus.h>
>  #include <glib.h>
>  #include <ofono.h>
> =

> @@ -138,10 +139,66 @@ static void dun_remove(struct ofono_modem
>  	*modem) ofono_modem_set_data(modem, NULL);
>  }
> =

> +static void dun_connect_reply(DBusPendingCall *call, gpointer
> user_data) +{
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
> +
> +	if (!dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &dev,
> +				DBUS_TYPE_INVALID))
> +		goto done;
> +
> +	data->rfcomm =3D dev;
> +
> +	dbus_error_init(&derr);
> +	if (!dbus_set_error_from_message(&derr, reply))
> +		goto done;
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
> +
> +	ofono_modem_set_powered(modem, FALSE);
> +
> +	dbus_error_free(&derr);
> +
> +done:
> +	ofono_modem_set_powered(modem, TRUE);

You might want to power on modem before jumping to this label. If there's a=
ny error
from dbus, you power off but then power on the modem again. It's wrong.

> +	dbus_message_unref(reply);
> +}
> +
>  static int dun_enable(struct ofono_modem *modem)
>  {
> -	DBG("%p", modem);
> -	return 0;
> +	struct dun_data *data =3D ofono_modem_get_data(modem);
> +	int status;
> +	const char *uuid =3D DUN_GW_UUID;
> +
> +	status =3D bluetooth_send_with_reply(data->dun_path,
> +					BLUEZ_SERIAL_INTERFACE, "Connect",
> +					dun_connect_reply, modem, NULL,
> +					15, DBUS_TYPE_STRING, &uuid,
> +					DBUS_TYPE_INVALID);

Shall we define a macro like DBUS_TIMEOUT instead of hard code 15 seconds?
What do you think?

> +	if (status < 0)
> +		return -EINVAL;
> +
> +	return -EINPROGRESS;
>  }
> =

>  static int dun_disable(struct ofono_modem *modem)



Regards,
Zhenhua

--===============6072371090068821611==--

