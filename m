Content-Type: multipart/mixed; boundary="===============8195200219906635242=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/3] qmimodem: get LTE default bearer APN from modem
Date: Fri, 02 Mar 2018 10:40:21 -0600
Message-ID: <9ae66995-fdf1-3b71-2d61-56aa330692f6@gmail.com>
In-Reply-To: <20180302151221.18063-4-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8195200219906635242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/02/2018 09:12 AM, Jonas Bonn wrote:
> When an LTE modem registers with the network, a default bearer is
> automatically established.  The APN used for this bearer is taken from
> whatever default settings the modem has.
> =

> The LTE atom takes cares of setting up the default context/profile with
> the APN to use.  From there, a default bearer will be established when
> the modem registers with the network.  This results in a call to 'Get
> LTE Attach Parameters' which tells us what APN the gateway negotiated
> with us.
> =

> If we can't get the APN, we do what the AT driver does:  pretend the
> bearer wasn't established.  This is a reasonable fallback, currently,
> because connman can't handle zero-length APN's anyway; the previous
> approach of setting the APN to 'automatic' breaks connman badly when it
> needs to switch between LTE and non-LTE networks.
> ---
>   drivers/qmimodem/gprs.c | 162 +++++++++++++++++++++++++++++++++++++++++=
++++---
>   1 file changed, 153 insertions(+), 9 deletions(-)
> =

> diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
> index a80d55fe..115305df 100644
> --- a/drivers/qmimodem/gprs.c
> +++ b/drivers/qmimodem/gprs.c
> @@ -29,12 +29,16 @@
>   =

>   #include "qmi.h"
>   #include "nas.h"
> +#include "wds.h"
>   =

>   #include "src/common.h"
>   #include "qmimodem.h"
>   =

>   struct gprs_data {
> +	struct qmi_device* dev;
>   	struct qmi_service *nas;
> +	struct qmi_service *wds;
> +	unsigned int last_auto_context_id;

'*' inconsistency here

>   };
>   =

>   static bool extract_ss_info(struct qmi_result *result, int *status, int=
 *tech)
> @@ -64,8 +68,124 @@ static bool extract_ss_info(struct qmi_result *result=
, int *status, int *tech)
>   	return true;
>   }
>   =

> +static void get_lte_attach_param_cb(struct qmi_result *result, void *use=
r_data)
> +{
> +	struct ofono_gprs* gprs =3D user_data;
> +	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
> +	char* apn =3D NULL;

char *apn;

Do not initialize this unnecessarily, let the compiler & valgrind figure =

out if we have uninitialized variables being used.

> +	uint16_t error;
> +	uint8_t iptype;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		ofono_error("Failed to query LTE attach params: %hd", error);
> +		goto noapn;
> +	}
> +
> +	/* APN */
> +	apn =3D qmi_result_get_string(result, 0x10);
> +	if (!apn) {
> +		DBG("Default profile has no APN setting");
> +		goto noapn;
> +	}
> +
> +	if (qmi_result_get_uint8(result, 0x11, &iptype)) {
> +		ofono_info("LTE attach IP type: %hhd", iptype);
> +	}

no {} please

> +
> +	ofono_gprs_cid_activated(gprs, data->last_auto_context_id, apn);
> +

Are you leaking apn here?

> +	return;
> +
> +noapn:
> +	data->last_auto_context_id =3D 0;
> +	ofono_error("LTE bearer established but APN not set");
> +}
> +
> +static void get_default_profile_cb(struct qmi_result *result, void *user=
_data)
> +{
> +	struct ofono_gprs* gprs =3D user_data;
> +	struct gprs_data *data =3D ofono_gprs_get_data(gprs);

again '*' weirdness

> +	uint16_t error;
> +	uint8_t index;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		ofono_error("Get default profile error: %hd", error);
> +		goto error;
> +	}
> +
> +	/* Profile index */
> +	if (!qmi_result_get_uint8(result, 0x01, &index)) {
> +		ofono_error("Failed query default profile");
> +		goto error;
> +	}
> +
> +	DBG("Default profile index: %hhd", index);
> +
> +	data->last_auto_context_id =3D index;
> +
> +	/* Get LTE Attach Parameters */
> +	if (qmi_service_send(data->wds, 0x85, NULL,
> +				get_lte_attach_param_cb, gprs, NULL) > 0)
> +		return;
> +
> +error:
> +	data->last_auto_context_id =3D 0;
> +	ofono_error("LTE bearer established but APN not set");
> +}
> +
> +/*
> + * Query the settings in effect on the default bearer.  These may be
> + * implicit or may even be something other than requested as the gateway
> + * is allowed to override whatever was requested by the user.
> + */
> +static void get_lte_attach_params(struct ofono_gprs* gprs)
> +{
> +	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
> +	struct {
> +		uint8_t type;
> +		uint8_t family;
> +	} __attribute((packed)) p =3D {
> +		.type =3D 0,   /* 3GPP */
> +		.family =3D 0, /* embedded */
> +	};
> +	struct qmi_param* param;
> +

and again

> +	DBG("");
> +
> +	if (data->last_auto_context_id !=3D 0)
> +		return; /* Established or in progress */
> +
> +	/* Set query in progress */
> +	data->last_auto_context_id =3D -1;
> +
> +	/* First we query the default profile in order to find out which
> +	 * context the modem has activated.
> +	 */
> +	param =3D qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	/* Profile type */
> +	qmi_param_append(param, 0x1, sizeof(p), &p);
> +
> +	/* Get default profile */
> +	if (qmi_service_send(data->wds, 0x49, param,
> +				get_default_profile_cb, gprs, NULL) > 0)
> +		return;
> +
> +	qmi_param_free(param);
> +
> +error:
> +	ofono_warn("Unable to query LTE APN... will not activate context");
> +}
> +
>   static int handle_ss_info(struct qmi_result *result, struct ofono_gprs =
*gprs)
>   {
> +	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
>   	int status;
>   	int tech;
>   =


The rest looks fine.

Regards,
-Denis

--===============8195200219906635242==--

