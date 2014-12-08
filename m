Content-Type: multipart/mixed; boundary="===============7719250605739633884=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] include: Add method to list RATs to radio-settings
Date: Sun, 07 Dec 2014 22:24:55 -0600
Message-ID: <54852817.5050501@gmail.com>
In-Reply-To: <1417797991-19700-3-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7719250605739633884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 12/05/2014 10:46 AM, Alfonso Sanchez-Beato wrote:
> ---
>   include/radio-settings.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/include/radio-settings.h b/include/radio-settings.h
> index 1d0ca3e..d7481b3 100644
> --- a/include/radio-settings.h
> +++ b/include/radio-settings.h
> @@ -35,6 +35,9 @@ enum ofono_radio_access_mode {
>   	OFONO_RADIO_ACCESS_MODE_LTE	=3D 3,
>   };
>
> +/* Set this to latest in ofono_radio_access_mode + 1 */
> +#define OFONO_RADIO_ACCESS_MODE_LAST (OFONO_RADIO_ACCESS_MODE_LTE + 1)
> +

I would actually change radio_access_mode into a bit field, that way the =

available access modes can be passed as an unsigned integer.

e.g. something like:

OFONO_RADIO_ACCESS_MODE_ANY =3D 0,
OFONO_RADIO_ACCESS_MODE_GSM =3D 0x1,
OFONO_RADIO_ACCESS_MODE_UMTS =3D 0x2,
OFONO_RADIO_ACCESS_MODE_LTE =3D 0x4,

>   enum ofono_radio_band_gsm {
>   	OFONO_RADIO_BAND_GSM_ANY,
>   	OFONO_RADIO_BAND_GSM_850,
> @@ -80,6 +83,11 @@ typedef void (*ofono_radio_settings_fast_dormancy_quer=
y_cb_t)(
>   						ofono_bool_t enable,
>   						void *data);
>
> +typedef void (*ofono_radio_settings_modem_rats_query_cb_t)(
> +						const struct ofono_error *error,
> +						const ofono_bool_t rats[],
> +						void *data);
> +

Then this becomes:

typedef void (*ofono_radio_settings_available_rats_query_cb_t)(
				const struct ofono_error *error,
				unsigned int available_rats,
				void *data);

>   struct ofono_radio_settings_driver {
>   	const char *name;
>   	int (*probe)(struct ofono_radio_settings *rs, unsigned int vendor,
> @@ -107,6 +115,9 @@ struct ofono_radio_settings_driver {
>   				ofono_bool_t enable,
>   				ofono_radio_settings_fast_dormancy_set_cb_t,
>   				void *data);
> +	void (*query_modem_rats)(struct ofono_radio_settings *rs,
> +				ofono_radio_settings_modem_rats_query_cb_t cb,
> +				void *data);

name this query_available_rats please.

>   };
>
>   int ofono_radio_settings_driver_register(
>

Regards,
-Denis

--===============7719250605739633884==--

