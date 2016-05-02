Content-Type: multipart/mixed; boundary="===============4482711615157153553=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] Add support for Sierra MC73xx QMI modems
Date: Mon, 02 May 2016 10:20:00 -0500
Message-ID: <57277020.8020900@gmail.com>
In-Reply-To: <1462200163-15827-3-git-send-email-m.chaplet@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4482711615157153553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 05/02/2016 09:42 AM, Martin Chaplet wrote:
> Udevng layer is changed in order to support Sierra QMI modems like MC73cx=
x.
> Identically to Huawei modems, these modems are parsed by setup_sierra.
> If QMI interface is detected, the Gobi modem driver is selected.
> In order to keep setup function as light as possible, real interface
> matching is done by udev rule.

This is a bit unusual.  ofono.rules is now only used with the old =

plugins/udev.c detection logic.  udev.c is only really used for =

serial-based devices, not USB.

Can we add the logic directly to udevng.c and not depend on ofono.rules?

>
> Unfortunately, MC73xx chips seem to have a broken QMI UIM interface.
> The qmimodem-legacy is so forced in setup function.
> ---
>   plugins/ofono.rules | 10 ++++++++++
>   plugins/udevng.c    | 25 ++++++++++++++++++++++---
>   2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 3ed9f16..4c5e0e3 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -16,6 +16,16 @@ KERNEL=3D=3D"shrm0", ENV{OFONO_DRIVER}=3D"u8500"
>
>   LABEL=3D"ofono_isi_end"
>
> +# Tag QMI devices
> +SUBSYSTEM=3D=3D"usbmisc", KERNEL=3D=3D"cdc-wdm*", ENV{OFONO_LABEL}=3D"qm=
i"
> +
> +# Sierra MC73xx (wwan0 is buggy, AT interface is ttyUSB2)
> +ENV{ID_MODEL}!=3D"MC73*", GOTO=3D"sierra_end"
> +SUBSYSTEM=3D=3D"net", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0a", ENV{OFONO_LAB=
EL}=3D"net"
> +SUBSYSTEM=3D=3D"tty", ENV{ID_USB_INTERFACE_NUM}=3D=3D"00", ENV{OFONO_LAB=
EL}=3D"diag"
> +SUBSYSTEM=3D=3D"tty", ENV{ID_USB_INTERFACE_NUM}=3D=3D"03", ENV{OFONO_LAB=
EL}=3D"modem"
> +LABEL=3D"sierra_end"
> +
>   SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"
>   ENV{DEVTYPE}!=3D"usb_device", GOTO=3D"ofono_end"
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 9643b0a..409ff22 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -219,7 +219,7 @@ static gboolean setup_gobi(struct modem_info *modem)
>
>   static gboolean setup_sierra(struct modem_info *modem)
>   {
> -	const char *mdm =3D NULL, *app =3D NULL, *net =3D NULL, *diag =3D NULL;
> +	const char *mdm =3D NULL, *app =3D NULL, *net =3D NULL, *diag =3D NULL,=
 *qmi =3D NULL;
>   	GSList *list;
>
>   	DBG("%s", modem->syspath);
> @@ -230,7 +230,15 @@ static gboolean setup_sierra(struct modem_info *mode=
m)
>   		DBG("%s %s %s %s", info->devnode, info->interface,
>   						info->number, info->label);
>
> -		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
> +		if (g_strcmp0(info->label, "modem") =3D=3D 0)
> +			mdm =3D info->devnode;
> +		else if (g_strcmp0(info->label, "net") =3D=3D 0)
> +			net =3D info->devnode;
> +		else if (g_strcmp0(info->label, "diag") =3D=3D 0)
> +			diag =3D info->devnode;
> +		else if (g_strcmp0(info->label, "qmi") =3D=3D 0)
> +			qmi =3D info->devnode;
> +		else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
>   			if (g_strcmp0(info->number, "01") =3D=3D 0)
>   				diag =3D info->devnode;
>   			if (g_strcmp0(info->number, "03") =3D=3D 0)
> @@ -242,11 +250,20 @@ static gboolean setup_sierra(struct modem_info *mod=
em)
>   		}
>   	}
>
> +	if (qmi !=3D NULL && net !=3D NULL) {
> +		ofono_modem_set_driver(modem->modem, "gobi");
> +		/* Fixup SIM interface for Sierra QMI devices */
> +		ofono_modem_set_string(modem->modem, "Simdriver", "qmimodem-legacy");

Lets do something like:

ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);

> +		goto done;
> +	}
> +
>   	if (mdm =3D=3D NULL || net =3D=3D NULL)
>   		return FALSE;
>
> -	DBG("modem=3D%s app=3D%s net=3D%s diag=3D%s", mdm, app, net, diag);
> +done:
> +	DBG("modem=3D%s app=3D%s net=3D%s diag=3D%s qmi=3D%s", mdm, app, net, d=
iag, qmi);
>
> +	ofono_modem_set_string(modem->modem, "Device", qmi);
>   	ofono_modem_set_string(modem->modem, "Modem", mdm);
>   	ofono_modem_set_string(modem->modem, "App", app);
>   	ofono_modem_set_string(modem->modem, "Diag", diag);
> @@ -1096,6 +1113,8 @@ static struct {
>   	{ "hso",	"hso"				},
>   	{ "gobi",	"qmi_wwan"			},
>   	{ "gobi",	"qcserial"			},
> +	{ "sierra",	"qmi_wwan",	"1199"		},
> +	{ "sierra",	"qcserial",	"1199"		},
>   	{ "sierra",	"sierra"			},
>   	{ "sierra",	"sierra_net"			},
>   	{ "option",	"option",	"0af0"		},
>

Regards,
-Denis

--===============4482711615157153553==--

