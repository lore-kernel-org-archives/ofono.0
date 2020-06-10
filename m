Content-Type: multipart/mixed; boundary="===============3247872157134446314=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] [qmimodem] Implement data capability bearer notify
Date: Tue, 09 Jun 2020 22:11:27 -0500
Message-ID: <e0aea3ce-53f1-498b-9eea-e52d7b0b60b1@gmail.com>
In-Reply-To: <20200609202113.632482-1-marius@ubports.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3247872157134446314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marius,

On 6/9/20 3:21 PM, Marius Gripsgard wrote:
> This implements data capability bearer notify to qmi modem.
> Since this is included in the serving system response this
> just adds a new data extraction for dc.
> ---
>   drivers/qmimodem/gprs.c | 29 +++++++++++++++++++++++++++++
>   drivers/qmimodem/nas.c  | 36 ++++++++++++++++++++++++++++++++++++
>   drivers/qmimodem/nas.h  | 23 +++++++++++++++++++++++
>   3 files changed, 88 insertions(+)
> =


Looks good, just couple of nitpicks:

> diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
> index 07adbe9a..0ba24da7 100644
> --- a/drivers/qmimodem/gprs.c
> +++ b/drivers/qmimodem/gprs.c
> @@ -68,6 +68,29 @@ static bool extract_ss_info(struct qmi_result *result,=
 int *status, int *tech)
>   	return true;
>   }
>   =

> +static bool extract_dc_info(struct qmi_result *result, int *bearer_tech)
> +{
> +	const struct qmi_nas_data_capability *dc;
> +	uint16_t len;
> +	int i;
> +
> +	DBG("");
> +
> +	dc =3D qmi_result_get(result, QMI_NAS_RESULT_DATA_CAPABILIT_STATUS, &le=
n);

Should this be CAPABILITY?

> +	if (!dc)
> +		return false;
> +
> +	*bearer_tech =3D -1;
> +	for (i =3D 0; i < dc->cap_count; i++) {
> +		DBG("radio tech in use %d", dc->cap[i]);
> +
> +		*bearer_tech =3D qmi_nas_cap_to_bearer_tech(dc->cap[i]);

I'm fine with this, but out of curiosity: can there be multiple of these?  =
Are =

they sorted somehow?

> +	}
> +
> +	return true;
> +}
> +
> +

No double empty lines please

>   static void get_lte_attach_param_cb(struct qmi_result *result, void *us=
er_data)
>   {
>   	struct ofono_gprs *gprs =3D user_data;
> @@ -188,6 +211,7 @@ static int handle_ss_info(struct qmi_result *result, =
struct ofono_gprs *gprs)
>   	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
>   	int status;
>   	int tech;
> +	int bearer_tech;
>   =

>   	DBG("");
>   =

> @@ -209,6 +233,11 @@ static int handle_ss_info(struct qmi_result *result,=
 struct ofono_gprs *gprs)
>   		data->last_auto_context_id =3D 0;
>   	}
>   =

> +	if (!extract_dc_info(result, &bearer_tech))
> +		return -1;

So bearer_tech is pretty much optional, are you sure you want to return an =
error =

here if the extraction fails?  Maybe something like:

if (extract_dc_info(result, &bearer_tech)
	ofono_grps_bearer_notify(gprs, bearer_tech);

would be a bit more conservative.

> +
> +	ofono_gprs_bearer_notify(gprs, bearer_tech);
> +
>   	return status;
>   }
>   =


Regards,
-Denis
--===============3247872157134446314==--

