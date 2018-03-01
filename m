Content-Type: multipart/mixed; boundary="===============3855495100342207665=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] qmimodem: get LTE default bearer APN from modem
Date: Thu, 01 Mar 2018 09:02:11 -0600
Message-ID: <53051444-344e-a337-9ff3-bf2d1e2f46dd@gmail.com>
In-Reply-To: <20180301104804.24058-5-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3855495100342207665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/01/2018 04:48 AM, Jonas Bonn wrote:
> When an LTE modem registers with the network, a default bearer is
> automatically established.  The APN used for this bearer is taken from
> whatever default settings the modem has.
> =

> In order to properly set up the ofono context, we need to find out what
> APN the modem has used when negotiating this bearer.  Ideally, we would
> want to query the 'current settings', but those aren't available until
> start_net has been called and that's done in the gprs-context atom.  As
> such, we query the 'default settings' here under the assumption that
> that's what the modem will have used.

I don't recall exactly, but from what I remember the default attach APN =

is not guaranteed to be honored by the operator.  So the default attach =

settings used for the actual active context might be different.  It =

might be better to query those instead.

> =

> If we can't get the APN, we do what the AT driver does:  pretend the
> bearer wasn't established.  This is a reasonable fallback, currently,
> because connman can't handle zero-length APN's anyway; the previous
> approach of setting the APN to 'automatic' breaks connman badly when it
> needs to switch between LTE and non-LTE networks.
> ---
>   drivers/qmimodem/gprs.c | 90 ++++++++++++++++++++++++++++++++++++++++++=
++-----
>   1 file changed, 82 insertions(+), 8 deletions(-)
> =

> diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
> index a80d55fe..567e8925 100644
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

Just a nitpick, but why do you have the '*' in different places here?

>   };
>   =

>   static bool extract_ss_info(struct qmi_result *result, int *status, int=
 *tech)
> @@ -64,8 +68,57 @@ static bool extract_ss_info(struct qmi_result *result,=
 int *status, int *tech)
>   	return true;
>   }
>   =

> +static void get_default_settings_cb(struct qmi_result *result, void *use=
r_data)
> +{
> +	struct ofono_gprs* gprs =3D user_data;
> +	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
> +	char* apn =3D NULL;
> +	uint16_t error;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		ofono_error("Failed to query default settings: %hd", error);
> +		goto error;
> +	}
> +
> +	apn =3D qmi_result_get_string(result, QMI_WDS_RESULT_APN);
> +	if (!apn) {
> +		DBG("Default profile has no APN setting");
> +	}
> +
> +error:
> +	if (apn) {
> +		if (!data->last_auto_context_id) {
> +			data->last_auto_context_id =3D 1;
> +			ofono_gprs_cid_activated(gprs, 1, apn);
> +		}

Why is a success path under an error: label?  This really should be =

reworked to be more readable.

> +	} else {
> +		ofono_warn("LTE context activated but APN missing");
> +	}
> +}
> +

Regards,
-Denis

--===============3855495100342207665==--

