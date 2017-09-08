Content-Type: multipart/mixed; boundary="===============2596658529393144509=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] qmi: provide AvailableTechnologies in radio-settings
Date: Fri, 08 Sep 2017 09:50:13 -0500
Message-ID: <4961b9d7-d276-f63e-64da-520b2594d4b5@gmail.com>
In-Reply-To: <20170908024733.32135-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2596658529393144509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/07/2017 09:47 PM, Jonas Bonn wrote:
> This provides the list of available technologies in the radio-settings
> atom.  The list is queried by the DMS Get Capabilities method; ofono
> takes care of caching the available technologies for us so we don't need
> to worry about this method being called excessively.
> ---
> =

> I forgot to edit the commit message in the first submission.  Here's a
> patch with a correct description.
> /Jonas
> =

>   drivers/qmimodem/radio-settings.c | 77 ++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 77 insertions(+)
> =

> diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-s=
ettings.c
> index 3a2b068..5e76bc5 100644
> --- a/drivers/qmimodem/radio-settings.c
> +++ b/drivers/qmimodem/radio-settings.c
> @@ -29,11 +29,13 @@
>   =

>   #include "qmi.h"
>   #include "nas.h"
> +#include "dms.h"
>   =

>   #include "qmimodem.h"
>   =

>   struct settings_data {
>   	struct qmi_service *nas;
> +	struct qmi_service *dms;
>   	uint16_t major;
>   	uint16_t minor;
>   };
> @@ -150,6 +152,78 @@ static void qmi_set_rat_mode(struct ofono_radio_sett=
ings *rs,
>   	g_free(cbd);
>   }
>   =

> +static void get_caps_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_radio_settings_available_rats_query_cb_t cb =3D cbd->cb;
> +	const struct qmi_dms_device_caps *caps;
> +	unsigned int available_rats;
> +	uint16_t len;
> +	uint8_t i;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, NULL))
> +		goto error;
> +
> +	caps =3D qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, &len);
> +	if (!caps)
> +		goto error;
> +
> +	available_rats =3D 0;
> +        for (i =3D 0; i < caps->radio_if_count; i++) {

I fixed up the whitespace weirdness here

> +		switch (caps->radio_if[i]) {
> +		case QMI_DMS_RADIO_IF_GSM:
> +			available_rats |=3D OFONO_RADIO_ACCESS_MODE_GSM;
> +			break;
> +		case QMI_DMS_RADIO_IF_UMTS:
> +			available_rats |=3D OFONO_RADIO_ACCESS_MODE_UMTS;
> +			break;
> +		case QMI_DMS_RADIO_IF_LTE:
> +			available_rats |=3D OFONO_RADIO_ACCESS_MODE_LTE;

and added a break; here.

And applied this patch.  Thanks!

Regards,
-Denis

--===============2596658529393144509==--

