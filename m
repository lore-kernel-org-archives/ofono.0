Content-Type: multipart/mixed; boundary="===============5037591977156861514=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v2 1/4] SARA R4 QMI support
Date: Wed, 24 Feb 2021 09:49:06 +0100
Message-ID: <ee7b5b4c-ce71-f132-d3e2-6d75fe01b86e@norrbonn.se>
In-Reply-To: <20210224083924.3480-2-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5037591977156861514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jupiter,

Please add a description to your patch.  Something along these lines:

This adds support for the uBlox SARA-R4 modem.

Unlike other uBlox devices, this modem is actually a Qualcomm part and =

therefore supports the QMI protocol.  For that reason, this doesn't just =

jack into the usual uBlox modem framework.

The modem has a quirk in that it fails to reconnect to the network if a =

NAS detach is issued when connectivity is lost; therefore, we need to =

add some 'vendor' handling to the QMI gprs atom to account for this.

This has been tested... how?

Hope that helps,
Jonas

On 24/02/2021 09:39, Bing Jupiter wrote:
> ---
>   plugins/udevng.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 34ac1cc0..9941145f 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1194,6 +1194,45 @@ static gboolean setup_ublox(struct modem_info *mod=
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
> +	ofono_modem_set_string(modem->modem, "Quirk", "SARAR4");
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
> @@ -1441,6 +1480,7 @@ static struct {
>   	{ "quectel",	setup_quectel	},
>   	{ "quectelqmi",	setup_quectelqmi},
>   	{ "ublox",	setup_ublox	},
> +	{ "ubloxqmi",   setup_ubloxqmi  },
>   	{ "gemalto",	setup_gemalto	},
>   	{ "xmm7xxx",	setup_xmm7xxx	},
>   	{ "mbim",	setup_mbim	},
> @@ -1850,6 +1890,7 @@ static struct {
>   	{ "ublox",	"cdc_ncm",	"1546", "110a"	},
>   	{ "ublox",	"rndis_host",	"1546", "1146"	},
>   	{ "ublox",	"cdc_acm",	"1546", "1146"	},
> +	{ "ubloxqmi",   "qmi_wwan", "05c6", "90b2"  },
>   	{ "gemalto",	"option",	"1e2d",	"0053"	},
>   	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
>   	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
>=20
--===============5037591977156861514==--

