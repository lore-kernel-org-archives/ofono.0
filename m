Content-Type: multipart/mixed; boundary="===============6914541209377602044=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v5 4/4] Detect SARA R4 QMI device
Date: Wed, 12 May 2021 11:27:55 +0200
Message-ID: <3c640684-a7c7-6ece-1543-02d1dad1b9d2@norrbonn.se>
In-Reply-To: <20210512074053.6718-5-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6914541209377602044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

This patch is fine, with one little fix below.

Patch message:

All QMI devices are currently piggy-backing on the 'gobi' driver to set =

up the QMI atoms.  For the SARA R4, this works with the addition of a quirk.

This patch adds the handling of a SARA R4 quirk to the 'gobi' driver.

On 12/05/2021 09:40, Bing Jupiter wrote:
> ---
>   plugins/gobi.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> =

> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index 9b5d7cff..5472dd83 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -47,6 +47,7 @@
>   #include <ofono/location-reporting.h>
>   #include <ofono/log.h>
>   #include <ofono/message-waiting.h>
> +#include <drivers/atmodem/vendor.h>
>   =

>   #include <drivers/qmimodem/qmi.h>
>   #include <drivers/qmimodem/dms.h>
> @@ -496,9 +497,17 @@ static void gobi_post_online(struct ofono_modem *mod=
em)
>   	struct gobi_data *data =3D ofono_modem_get_data(modem);
>   	struct ofono_gprs *gprs;
>   	struct ofono_gprs_context *gc;
> +    const char* quirk;
> +    unsigned int vendor =3D 0;
>   =

>   	DBG("%p", modem);
>   =

> +    quirk =3D ofono_modem_get_string(modem, "Quirk");
> +    if (quirk) {

Probably should have done:

if (quirk && !strcmp(quirk, "SARAR4")) {

/Jonas


> +	    DBG("Debug: vendor =3D OFONO_VENDOR_UBLOX_SARA_R4");
> +        vendor =3D OFONO_VENDOR_UBLOX_SARA_R4;
> +    }
> +
>   	if (data->features & GOBI_NAS) {
>   		ofono_netreg_create(modem, 0, "qmimodem", data->device);
>   		ofono_netmon_create(modem, 0, "qmimodem", data->device);
> @@ -508,7 +517,7 @@ static void gobi_post_online(struct ofono_modem *mode=
m)
>   		ofono_ussd_create(modem, 0, "qmimodem", data->device);
>   =

>   	if (data->features & GOBI_WDS) {
> -		gprs =3D ofono_gprs_create(modem, 0, "qmimodem", data->device);
> +		gprs =3D ofono_gprs_create(modem, vendor, "qmimodem", data->device);
>   		gc =3D ofono_gprs_context_create(modem, 0, "qmimodem",
>   							data->device);
>   =

>=20
--===============6914541209377602044==--

