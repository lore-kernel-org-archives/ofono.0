Content-Type: multipart/mixed; boundary="===============3625416507761641780=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/3] gprs: Quectel EC21 does not understand AT+CPSB
Date: Tue, 11 Aug 2020 10:55:35 -0500
Message-ID: <16f2773a-49c6-4318-8dea-36b1b9ebdd1d@gmail.com>
In-Reply-To: <20200811114217.370049-3-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3625416507761641780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 8/11/20 6:42 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> The Quectel EC21 modem does not understand the AT+CPSB command, so
> aquire the current packet switched bearer from CGREG URC.
> ---
>   drivers/atmodem/gprs.c | 32 ++++++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index b637f733..5583d6fa 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -40,6 +40,7 @@
>   #include "gatresult.h"
>   =

>   #include "atmodem.h"
> +#include "common.h"
>   #include "vendor.h"
>   =

>   #define MAX_CONTEXTS 255
> @@ -98,6 +99,29 @@ static void list_contexts_data_unref(gpointer user_dat=
a)
>   	g_free(ld);
>   }
>   =

> +static int act_to_bearer(int act)
> +{
> +	switch (act) {
> +		case 0:
> +		case 1:
> +			return PACKET_BEARER_GPRS;
> +		case 2:
> +			return PACKET_BEARER_UMTS;
> +		case 3:
> +			return PACKET_BEARER_EGPRS;
> +		case 4:
> +			return PACKET_BEARER_HSDPA;
> +		case 5:
> +			return PACKET_BEARER_HSUPA;
> +		case 6:
> +			return PACKET_BEARER_HSUPA_HSDPA;
> +		case 7:
> +			return PACKET_BEARER_EPS;
> +		default:
> +			return PACKET_BEARER_NONE;
> +	}
> +};
> +

oFono driver interface is based on 27.007.  So that means values defined in =

27.007 do not need to be 'converted'.  You can simply feed them in directly=
 if =

they follow 27.007.

To me this looks like a no-op.  Is there a non-obvious reason why this code=
 is =

needed?

>   static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
>   {
>   	struct cb_data *cbd =3D user_data;
> @@ -342,11 +366,11 @@ static void at_gprs_list_active_contexts(struct ofo=
no_gprs *gprs,
>   static void cgreg_notify(GAtResult *result, gpointer user_data)
>   {
>   	struct ofono_gprs *gprs =3D user_data;
> -	int status;
> +	int status, tech;
>   	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
>   =

>   	if (at_util_parse_reg_unsolicited(result, "+CGREG:", &status,
> -				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
> +				NULL, NULL, &tech, gd->vendor) =3D=3D FALSE)
>   		return;
>   =

>   	/*
> @@ -372,6 +396,8 @@ static void cgreg_notify(GAtResult *result, gpointer =
user_data)
>   	}
>   =

>   	ofono_gprs_status_notify(gprs, status);
> +	if (gd->vendor =3D=3D OFONO_VENDOR_QUECTEL_EC2X)
> +		ofono_gprs_bearer_notify(gprs, act_to_bearer(tech));

To follow up from above, any reason not to omit act_to_bearer() here?

>   }
>   =

>   static void cgev_notify(GAtResult *result, gpointer user_data)
> @@ -624,6 +650,8 @@ static void gprs_initialized(gboolean ok, GAtResult *=
result, gpointer user_data)
>   		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
>   						NULL, NULL, NULL);
>   		break;
> +	case OFONO_VENDOR_QUECTEL_EC2X:
> +		break;
>   	default:
>   		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
>   						FALSE, gprs, NULL);
> =


Regards,
-Denis
--===============3625416507761641780==--

