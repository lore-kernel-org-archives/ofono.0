Content-Type: multipart/mixed; boundary="===============7762472316144946599=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v5 1/4] Detect SARA R4 QMI device
Date: Wed, 12 May 2021 11:17:09 +0200
Message-ID: <c084fde1-4d2e-8ae7-4308-46a0002921ab@norrbonn.se>
In-Reply-To: <20210512074053.6718-2-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7762472316144946599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 12/05/2021 09:40, Bing Jupiter wrote:

A comment along these lines might be appropriate:

Unlike other uBlox, the SARA R4 is actually a Qualcomm part and supports =

the QMI protocol mostly as implemented in ofono.  The AT command set for =

this modem does not correspond to that used by other uBlox modems; =

furthermore, it is quirky to a degree that it doesn't really play well =

with ofono.

This patch adds support for the uBlox SARA R4 modem as a QMI device.

/Jonas


> ---
>   plugins/udevng.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 34ac1cc0..46bf5532 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1194,6 +1194,46 @@ static gboolean setup_ublox(struct modem_info *mod=
em)
>   	return TRUE;
>   }
>   =

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
> +
> +
> +	DBG("gps=3D%s aux=3D%s", gps, aux);
> +
> +	ofono_modem_set_driver(modem->modem, "gobi");
> +
> +	return TRUE;
> +}
> +
>   static gboolean setup_gemalto(struct modem_info* modem)
>   {
>   	const char *app =3D NULL, *gps =3D NULL, *mdm =3D NULL,
> @@ -1441,6 +1481,7 @@ static struct {
>   	{ "quectel",	setup_quectel	},
>   	{ "quectelqmi",	setup_quectelqmi},
>   	{ "ublox",	setup_ublox	},
> +    { "ubloxqmi",   setup_ubloxqmi  },
>   	{ "gemalto",	setup_gemalto	},
>   	{ "xmm7xxx",	setup_xmm7xxx	},
>   	{ "mbim",	setup_mbim	},
> @@ -1850,6 +1891,7 @@ static struct {
>   	{ "ublox",	"cdc_ncm",	"1546", "110a"	},
>   	{ "ublox",	"rndis_host",	"1546", "1146"	},
>   	{ "ublox",	"cdc_acm",	"1546", "1146"	},
> +    { "ubloxqmi",   "qmi_wwan", "05c6", "90b2"  },
>   	{ "gemalto",	"option",	"1e2d",	"0053"	},
>   	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
>   	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
>=20
--===============7762472316144946599==--

