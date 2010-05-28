Content-Type: multipart/mixed; boundary="===============9131582954683280855=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] Add bluetooth plugin skeleton.
Date: Fri, 28 May 2010 09:11:44 -0500
Message-ID: <201005280911.44961.denkenz@gmail.com>
In-Reply-To: <1274849503-18388-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9131582954683280855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> +#ifndef __BLUETOOTH_H
> +#define __BLUETOOTH_H

No ifdef guards please.

> +
> +#define	BLUEZ_SERVICE "org.bluez"
> +#define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
> +#define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
> +#define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
> +
> +#define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
> +#define DUN_GW_UUID	"00001103-0000-1000-8000-00805F9B34FB"

Lets start with just the HFP UUID until we add DUN.

> +
> +/* Profiles bitfield */
> +#define HFP_AG 0x01
> +#define DUN_GW 0x02

Same here.

> +
> +struct bluetooth_profile {
> +	const char *name;
> +	int (*create)(const char *device, const char *dev_addr, const char
>  *adapter_addr, const char *alias); +	void (*remove_all)();

This line has more than 80 characters

> +	void (*set_alias)(const char *device, const char *);
> +};
> +
> +int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile
>  *profile); +void bluetooth_unregister_uuid(const char *uuid);
> +
> +
> +#endif /* __BLUETOOTH_H */
> diff --git a/plugins/hfp.c b/plugins/hfp.c
> index e37c9fc..a49e4af 100644
> --- a/plugins/hfp.c
> +++ b/plugins/hfp.c
> @@ -45,17 +45,13 @@
> =

>  #include <ofono/dbus.h>
> =

> -#define	BLUEZ_SERVICE "org.bluez"
> -#define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
> -#define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
> -#define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
> +#include "bluetooth.h"
> +
>  #define	BLUEZ_GATEWAY_INTERFACE		BLUEZ_SERVICE ".HandsfreeGateway"
> =

>  #define HFP_AGENT_INTERFACE "org.bluez.HandsfreeAgent"
>  #define HFP_AGENT_ERROR_INTERFACE "org.bluez.Error"
> =

> -#define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
> -
>  #ifndef DBUS_TYPE_UNIX_FD
>  #define DBUS_TYPE_UNIX_FD -1
>  #endif
> =


Regards,
-Denis

--===============9131582954683280855==--

