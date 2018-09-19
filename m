Content-Type: multipart/mixed; boundary="===============3405525268007024622=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] sim800: add udev detection
Date: Wed, 19 Sep 2018 11:46:34 -0500
Message-ID: <87d6a98b-e80c-1f82-3c40-93d6ddc13e3d@gmail.com>
In-Reply-To: <1537302987-12592-2-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3405525268007024622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/18/2018 03:36 PM, Cl=C3=A9mentViel wrote:
> From: clem <vielclement@gmail.com>
> =

> ---
>   plugins/udevng.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 02d049e..9a1be6a 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -710,6 +710,53 @@ static gboolean setup_telitqmi(struct modem_info *mo=
dem)
>   	return TRUE;
>   }
>   =

> +static gboolean setup_sim800(struct modem_info *modem)
> +{
> +	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *diag =3D NULL;
> +	GSList *list;
> +
> +	DBG("%s", modem->syspath);
> +
> +	for (list =3D modem->devices; list; list =3D list->next) {
> +		struct device_info *info =3D list->data;
> +
> +		DBG("%s %s %s %s", info->devnode, info->interface,
> +			info->number, info->label);
> +
> +		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
> +			DBG("setting aux as info->devnode");
> +			aux =3D info->devnode;
> +			if (mdm !=3D NULL)
> +			break;
> +		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
> +			mdm =3D info->devnode;
> +			if (aux !=3D NULL)
> +			break;
> +		} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0) {
> +			if (g_strcmp0(info->number, "00") =3D=3D 0)
> +				mdm =3D info->devnode;
> +			else if (g_strcmp0(info->number, "01") =3D=3D 0)
> +				gps =3D info->devnode;
> +			else if (g_strcmp0(info->number, "02") =3D=3D 0)
> +				aux =3D info->devnode;
> +			else if (g_strcmp0(info->number, "03") =3D=3D 0)
> +				mdm =3D info->devnode;
> +		}
> +	}
> +

So I'm confused now.  If sim800 is a serial device, why do you have all =

this here?  Shouldn't this be handled by setup_serial_modem ?

> +	DBG("modem=3D%s aux=3D%s gps=3D%s diag=3D%s", mdm, aux, gps, diag);
> +
> +	if (mdm =3D=3D NULL) {
> +		DBG("modem did not set up");
> +		return FALSE;
> +	}
> +
> +	ofono_modem_set_string(modem->modem, "Device", mdm);
> +	ofono_modem_set_string(modem->modem, "Modem", mdm);
> +
> +	return TRUE;
> +}
> +
>   /* TODO: Not used as we have no simcom driver */
>   static gboolean setup_simcom(struct modem_info *modem)
>   {
> @@ -1282,6 +1329,7 @@ static struct {
>   	{ "telit",	setup_telit,	"device/interface"	},
>   	{ "telitqmi",	setup_telitqmi	},
>   	{ "simcom",	setup_simcom	},
> +	{ "sim800",     setup_sim800    },
>   	{ "sim7100",	setup_sim7100	},
>   	{ "zte",	setup_zte	},
>   	{ "icera",	setup_icera	},
> @@ -1654,6 +1702,7 @@ static struct {
>   	{ "alcatel",	"option",	"1bbb", "0017"	},
>   	{ "novatel",	"option",	"1410"		},
>   	{ "zte",	"option",	"19d2"		},
> +	{ "sim800",     "option",       "05c6", "9000"  },
>   	{ "simcom",	"option",	"05c6", "9000"	},
>   	{ "sim7100",	"option",	"1e0e", "9001"	},
>   	{ "telit",	"usbserial",	"1bc7"		},
> =


Regards,
-Denis

--===============3405525268007024622==--

