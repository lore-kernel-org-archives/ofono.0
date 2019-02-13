Content-Type: multipart/mixed; boundary="===============3399224950354589412=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] xmm7modem: Change in xmm7mode plugin for multiple PDP
Date: Wed, 13 Feb 2019 08:39:12 -0600
Message-ID: <ecea2e60-74ac-993f-18d4-90ca1092cba7@gmail.com>
In-Reply-To: <1549972295-2217-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3399224950354589412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 02/12/2019 05:51 AM, Antara Borwankar wrote:
> Made changes in xmm7modem plugin to allow mutiple PDP context
> activation and to assign correct network interface to the
> activated PDP context.
> ---
>   plugins/udevng.c  | 15 ++++++++++++++-
>   plugins/xmm7xxx.c | 28 ++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+), 1 deletion(-)
> =


I split this patch up into two commits, and applied.  I did tweak a few =

things, see below:

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index ff6e1fc..ce8cdee 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1179,7 +1179,7 @@ static gboolean setup_gemalto(struct modem_info* mo=
dem)
>   =

>   static gboolean setup_xmm7xxx(struct modem_info *modem)
>   {
> -	const char *mdm =3D NULL, *net =3D NULL;
> +	const char *mdm =3D NULL, *net =3D NULL, *net2 =3D NULL, *net3 =3D NULL;
>   	GSList *list;
>   =

>   	DBG("%s %s\n", __DATE__, __TIME__);
> @@ -1200,6 +1200,10 @@ static gboolean setup_xmm7xxx(struct modem_info *m=
odem)
>   			} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
>   				if (g_strcmp0(info->number, "06") =3D=3D 0)
>   					net =3D info->devnode;
> +				if (g_strcmp0(info->number, "08") =3D=3D 0)
> +					net2 =3D info->devnode;
> +				if (g_strcmp0(info->number, "0a") =3D=3D 0)
> +					net3 =3D info->devnode;
>   			}
>   		} else {
>   			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> @@ -1220,6 +1224,15 @@ static gboolean setup_xmm7xxx(struct modem_info *m=
odem)
>   	ofono_modem_set_string(modem->modem, "Modem", mdm);
>   	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
>   =

> +	if (net2)
> +		ofono_modem_set_string(modem->modem, "NetworkInterface2", net2);
> +
> +	if (net3)
> +		ofono_modem_set_string(modem->modem, "NetworkInterface3", net3);
> +
> +	ofono_modem_set_string(modem->modem, "CtrlPath", "/USBCDC/0");
> +	ofono_modem_set_string(modem->modem, "DataPath", "/USBHS/NCM/");
> +
>   	return TRUE;
>   }
>   =

> @@ -1282,6 +1283,33 @@ static void xmm7xxx_post_online(struct ofono_modem=
 *modem)
>   	if (gprs && gc)
>   		ofono_gprs_add_context(gprs, gc);
>   =

> +	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> +	ofono_gprs_context_set_interface(gc, interface);

Since ofono_gprs_context_set_interface doesn't perform NULL check on gc, =

I put this and other instances behind the if (gprs && gc) statement

Regards,
-Denis

--===============3399224950354589412==--

