Content-Type: multipart/mixed; boundary="===============2136549269244839008=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v5 3/4] Detect SARA R4 QMI device
Date: Wed, 12 May 2021 11:23:31 +0200
Message-ID: <b849f2c8-21ed-1355-4a84-cfa193cc67e7@norrbonn.se>
In-Reply-To: <20210512074053.6718-4-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2136549269244839008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The SARA R4 modem detaches permanently from the network when the NAS =

Detach action is called.  This is problematic because ofono calls Detach =

when network connectivity is temporarily lost resulting in the modem =

never attempting to reattach again when the network once again becomes =

available.

In testing it was discovered, that the call to Attach doesn't appear to =

be required either.

This patch adds a quirk to the QMI GPRS atom to not call the NAS =

attach/detach actions for the uBlox SARA R4 device.

This has been tested on several SARA R4 devices that are running in =

long-term connectivity tests.  With this patch, the modem reconnects as =

the network comes and goes; without the patch, the modem goes idle the =

first time network connectivity is lost.

/Jonas

On 12/05/2021 09:40, Bing Jupiter wrote:
> ---
>   drivers/qmimodem/gprs.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> =

> diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
> index 896a9e4c..fa20b809 100644
> --- a/drivers/qmimodem/gprs.c
> +++ b/drivers/qmimodem/gprs.c
> @@ -26,6 +26,7 @@
>   #include <ofono/log.h>
>   #include <ofono/modem.h>
>   #include <ofono/gprs.h>
> +#include <drivers/atmodem/vendor.h>
>   =

>   #include "qmi.h"
>   #include "nas.h"
> @@ -35,6 +36,7 @@
>   #include "qmimodem.h"
>   =

>   struct gprs_data {
> +    unsigned int vendor;
>   	struct qmi_device *dev;
>   	struct qmi_service *nas;
>   	struct qmi_service *wds;
> @@ -284,6 +286,13 @@ static void qmi_set_attached(struct ofono_gprs *gprs=
, int attached,
>   =

>   	DBG("attached %d", attached);
>   =

> +    if (data->vendor =3D=3D OFONO_VENDOR_UBLOX_SARA_R4) {
> +	    DBG("Debug vendor =3D OFONO_VENDOR_UBLOX_SARA_R4");
> +        CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +        g_free(cbd);
> +        return;
> +    }
> +
>   	if (attached)
>   		action =3D QMI_NAS_ATTACH_ACTION_ATTACH;
>   	else
> @@ -406,6 +415,7 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
>   	DBG("");
>   =

>   	data =3D g_new0(struct gprs_data, 1);
> +    data->vendor =3D vendor;
>   =

>   	ofono_gprs_set_data(gprs, data);
>   =

>=20
--===============2136549269244839008==--

