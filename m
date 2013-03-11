Content-Type: multipart/mixed; boundary="===============7601963679816526807=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 04/13] dundee: Initial GDBusClient for BlueZ 5
Date: Mon, 11 Mar 2013 18:08:45 +0100
Message-ID: <513E0F9D.6050207@monom.org>
In-Reply-To: <1362425590-26075-5-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7601963679816526807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 03/04/2013 08:33 PM, Paulo Borges wrote:
> This patch adds the callbacks to track additions and removals of
> BlueZ related interfaces and property changes in these interfaces.
> ---
>   dundee/bluez5.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   dundee/dundee.h |    2 ++
>   2 files changed, 62 insertions(+)
>
> diff --git a/dundee/bluez5.c b/dundee/bluez5.c
> index 6685b4c..40df700 100644
> --- a/dundee/bluez5.c
> +++ b/dundee/bluez5.c
> @@ -22,16 +22,76 @@
>   #include <config.h>
>   #endif
>
> +#include <stdint.h>
> +#include <sys/socket.h>
> +#include <gdbus.h>
> +
>   #include "dundee.h"
> +#include "plugins/bluez5.h"
> +
> +#define DUN_DT_PROFILE_PATH   "/bluetooth/profile/dun_dt"
> +
> +static GDBusClient *bluez;
> +
> +static void proxy_added(GDBusProxy *proxy, void *user_data)
> +{
> +	const char *path =3D g_dbus_proxy_get_path(proxy);
> +	const char *interface =3D g_dbus_proxy_get_interface(proxy);
> +
> +	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
> +		return;

In oFono, just use let the '=3D=3D FALSE' part away. The same applies for =

the rest of the series.


cheers,
daniel

--===============7601963679816526807==--

