Content-Type: multipart/mixed; boundary="===============0681394792423197541=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH v3 2/2] udevng: add Telit LE910 V1 support
Date: Fri, 24 Mar 2017 16:56:59 +0100
Message-ID: <82eb62ba-6cb6-5653-5068-8611f5332b7c@southpole.se>
In-Reply-To: <1490367106-8401-3-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0681394792423197541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

I'm working on support for the Quectel UC21 and have some similar =

patches to what you have below.  Based on that experience, here are some =

comments:

On 03/24/2017 03:51 PM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Tested with LE910-SVG and Verizon.
> ---
>   plugins/udevng.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 2279bbe..3b15064 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -182,14 +182,15 @@ static gboolean setup_gobi(struct modem_info *modem)
>   	const char *qmi =3D NULL, *mdm =3D NULL, *net =3D NULL;
>   	const char *gps =3D NULL, *diag =3D NULL;
>   	GSList *list;
> +	gboolean telit =3D FALSE;
>   =

>   	DBG("%s", modem->syspath);
>   =

>   	for (list =3D modem->devices; list; list =3D list->next) {
>   		struct device_info *info =3D list->data;
>   =

> -		DBG("%s %s %s %s", info->devnode, info->interface,
> -						info->number, info->label);
> +		DBG("%s %s %s %s %s", info->devnode, info->interface,
> +					info->number, info->label, info->subsystem);

Put this DBG message change in a separate patch.  It's a good idea and I =

did the same thing in my tree, but it's unrelated to the telit support.

>   =

>   		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
>   			if (info->number =3D=3D NULL)
> @@ -199,10 +200,18 @@ static gboolean setup_gobi(struct modem_info *modem)
>   			else if (g_strcmp0(info->number, "01") =3D=3D 0)
>   				diag =3D info->devnode;
>   			else if (g_strcmp0(info->number, "02") =3D=3D 0)
> -				mdm =3D info->devnode;
> +				if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
> +					net =3D info->devnode;
> +				else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0) {
> +					telit =3D TRUE;
> +					qmi =3D info->devnode;
> +				} else
> +					mdm =3D info->devnode;
>   			else if (g_strcmp0(info->number, "03") =3D=3D 0)
>   				gps =3D info->devnode;
> -		}
> +		} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0)
> +			if (g_strcmp0(info->number, "04") =3D=3D 0)
> +				mdm =3D info->devnode;
>   	}

I need almost exactly the same code for the UC21, but the endpoints are =

different.  What we'll end up with if we do this is an enormous tree of =

cases that all span multiple interfaces, endpoints, and subsystems.  =

Because of that, I'm not sure that setup_gobi is the right place to be =

putting this.

The Sierra 7xxx modem does something similar, but uses setup_sierra to =

attach the endpoints and then defers to the gobi driver with:

ofono_modem_set_driver(modem->mode, "gobi"); /* around line 270... in =

setup_sierra */

I suspect that that's a better approach.  I think using setup_gobi makes =

little sense because it doesn't provide a clear association to the =

hardware vendor and the devices from different vendors don't have a =

common configuration.

setup_telit makes some assumptions about endpoint 2 that you might not =

want to muck about with... in my opinion, doing a setup_telit_le910() is =

not horrid, and better than making a mess of setup_gobi.

>   =

>   	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
> @@ -215,6 +224,12 @@ static gboolean setup_gobi(struct modem_info *modem)
>   	ofono_modem_set_string(modem->modem, "Diag", diag);
>   	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
>   =

> +	if (telit) {
> +		/* Telit LE910 V1 modems */
> +		ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
> +		ofono_modem_set_boolean(modem->modem, "AlwaysOnline", TRUE);
> +	}
> +
>   	return TRUE;
>   }
>   =

> @@ -1168,6 +1183,7 @@ static struct {
>   	{ "mbm",	"cdc_ether",	"0930"		},
>   	{ "mbm",	"cdc_ncm",	"0930"		},
>   	{ "hso",	"hso"				},
> +	{ "gobi",	"option",	"1bc7", "1201"	},
I don't understand why you are setting "option" here... does the device =

not use qmi_wwan?

/Jonas


--===============0681394792423197541==--

