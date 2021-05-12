Content-Type: multipart/mixed; boundary="===============2376404588436680840=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: [PATCH v5 1/4] Detect SARA R4 QMI device
Date: Wed, 12 May 2021 09:55:33 +0200
Message-ID: <19a38925-618a-906b-6578-17b98122958c@kerlink.fr>
In-Reply-To: <20210512074053.6718-2-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2376404588436680840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I didn't go through the whole patch but I think you mixed 4 spaces with
tab.

The same problem exist in your 4 patches.

Best Regards,

Christophe

On 5/12/21 9:40 AM, Bing Jupiter wrote:
> ---
>  plugins/udevng.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 34ac1cc0..46bf5532 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1194,6 +1194,46 @@ static gboolean setup_ublox(struct modem_info *mod=
em)
>  	return TRUE;
>  }
>  =

> +static gboolean setup_ubloxqmi(struct modem_info *modem) {
> +	const char *qmi =3D NULL, *net =3D NULL, *gps =3D NULL, *aux =3D NULL;
> +	GSList *list;
> +
> +	DBG("%s", modem->syspath);
> +
> +	for (list =3D modem->devices; list; list =3D g_slist_next(list)) {
> +		struct device_info *info =3D list->data;
> +
> +		DBG("%s %s %s %s %s", info->devnode, info->interface,
> +				info->number, info->label, info->subsystem);
> +
> +		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0 &&
> +				g_strcmp0(info->number, "03") =3D=3D 0) {
> +			if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
> +				net =3D info->devnode;
> +			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
> +				qmi =3D info->devnode;
> +		}
> +	}
> +
> +	DBG("qmi=3D%s net=3D%s", qmi, net);
> +
> +	if (qmi =3D=3D NULL || net =3D=3D NULL)
> +		return FALSE;
> +
> +	DBG("qmi=3D%s net=3D%s", qmi, net);
> +
> +	ofono_modem_set_string(modem->modem, "Device", qmi);
> +	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
> +    ofono_modem_set_string(modem->modem, "Quirk", "SARAR4");
Here
> +
> +
> +	DBG("gps=3D%s aux=3D%s", gps, aux);
> +
> +	ofono_modem_set_driver(modem->modem, "gobi");
> +
> +	return TRUE;
> +}
> +
>  static gboolean setup_gemalto(struct modem_info* modem)
>  {
>  	const char *app =3D NULL, *gps =3D NULL, *mdm =3D NULL,
> @@ -1441,6 +1481,7 @@ static struct {
>  	{ "quectel",	setup_quectel	},
>  	{ "quectelqmi",	setup_quectelqmi},
>  	{ "ublox",	setup_ublox	},
> +    { "ubloxqmi",   setup_ubloxqmi  },
Here
>  	{ "gemalto",	setup_gemalto	},
>  	{ "xmm7xxx",	setup_xmm7xxx	},
>  	{ "mbim",	setup_mbim	},
> @@ -1850,6 +1891,7 @@ static struct {
>  	{ "ublox",	"cdc_ncm",	"1546", "110a"	},
>  	{ "ublox",	"rndis_host",	"1546", "1146"	},
>  	{ "ublox",	"cdc_acm",	"1546", "1146"	},
> +    { "ubloxqmi",   "qmi_wwan", "05c6", "90b2"  },
Here
>  	{ "gemalto",	"option",	"1e2d",	"0053"	},
>  	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
>  	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
--===============2376404588436680840==--

