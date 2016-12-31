Content-Type: multipart/mixed; boundary="===============3027959188041555736=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] MC7430: add read_imsi feature to qmimodem sim driver
Date: Fri, 30 Dec 2016 18:34:19 -0600
Message-ID: <9d42e024-c2d4-0a8d-4926-fa9a7f040c5b@gmail.com>
In-Reply-To: <20161228150402.15660-3-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3027959188041555736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 12/28/2016 09:04 AM, Christophe Ronco wrote:
> drivers/qmimodem/sim.c
>  Add read_imsi feature to this driver. This is based on DMS service.
>  This is mandatory to be able to use this driver for GPRS connection
> plugins/gobi.c
>  DMS feature is needed for SIM driver (to be able to read IMSI)

Its been a while since I looked into QMI.  Marcel did most of the work, =

but I remember the basics.  So correct me if some of my understanding is =

incorrect.

My understanding was that the legacy driver was used for modems that =

didn't support the UIM service.  Since UIM doesn't have a dedicated IMSI =

getter, we added support to read EFimsi directly via low-level SIM =

reads.  See commit bc38ef91cd35935dc7a0d6eec31d9880e39a6bd5

This worked on a bunch of QMI based devices, so I have to assume that =

this fails on Sierra?  If so, then this probably should be quirked to be =

Sierra-specific behavior.  E.g. via a mechanism similar to =

drivers/atmodem/vendor.h

> ---
>  drivers/qmimodem/sim.c | 83 ++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  plugins/gobi.c         |  2 +-
>  2 files changed, 79 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
> index fa7bef58..f61466d5 100644
> --- a/drivers/qmimodem/sim.c
> +++ b/drivers/qmimodem/sim.c
> @@ -30,6 +30,7 @@
>  #include <ofono/sim.h>
>
>  #include "qmi.h"
> +#include "dms.h"
>  #include "uim.h"
>
>  #include "qmimodem.h"
> @@ -39,6 +40,8 @@
>  #define EF_STATUS_VALID 1
>
>  struct sim_data {
> +	struct qmi_device *qmi_dev;
> +	struct qmi_service *dms;
>  	struct qmi_service *uim;
>  	uint32_t event_mask;
>  	uint8_t card_state;
> @@ -295,6 +298,47 @@ error:
>  	g_free(cbd);
>  }
>
> +static void get_imsi_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_sim_imsi_cb_t cb =3D cbd->cb;
> +	char *str;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, NULL)) {
> +		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> +		return;
> +	}
> +
> +	str =3D qmi_result_get_string(result, QMI_DMS_RESULT_IMSI);
> +	if (!str) {
> +		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
> +
> +	qmi_free(str);
> +}
> +
> +static void qmi_read_imsi(struct ofono_sim *sim,
> +				ofono_sim_imsi_cb_t cb, void *user_data)
> +{
> +	struct sim_data *data =3D ofono_sim_get_data(sim);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +
> +	DBG("");
> +
> +	if (qmi_service_send(data->dms, QMI_DMS_GET_IMSI, NULL,
> +					get_imsi_cb, cbd, g_free) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> +
> +	g_free(cbd);
> +}
> +
>  static void qmi_query_passwd_state(struct ofono_sim *sim,
>  				ofono_sim_passwd_cb_t cb, void *user_data)
>  {
> @@ -464,11 +508,30 @@ static void create_uim_cb(struct qmi_service *servi=
ce, void *user_data)
>  		return;
>
>  error:
> -	qmi_service_unref(data->uim);
> +	qmi_service_unref(data->dms);
>
>  	ofono_sim_remove(sim);

ofono_sim_remove will call .remove method.  So this is likely to cause a =

crash since uim and dms have already been unref-ed.

>  }
>
> +static void create_dms_cb(struct qmi_service *service, void *user_data)
> +{
> +	struct ofono_sim *sim =3D user_data;
> +	struct sim_data *data =3D ofono_sim_get_data(sim);
> +	struct qmi_param *param;
> +
> +	DBG("");
> +
> +	if (!service) {
> +		ofono_error("Failed to request DMS service");
> +		ofono_sim_remove(sim);
> +		return;
> +	}
> +
> +	data->dms =3D qmi_service_ref(service);
> +
> +	qmi_service_create(data->qmi_dev, QMI_SERVICE_UIM, create_uim_cb, sim, =
NULL);
> +}
> +
>  static int qmi_sim_probe(struct ofono_sim *sim,
>  				unsigned int vendor, void *user_data)
>  {
> @@ -485,9 +548,12 @@ static int qmi_sim_probe(struct ofono_sim *sim,
>  	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
>  		data->retries[i] =3D -1;
>
> +	data->qmi_dev =3D device;
> +
>  	ofono_sim_set_data(sim, data);
>
> -	qmi_service_create(device, QMI_SERVICE_UIM, create_uim_cb, sim, NULL);
> +	qmi_service_create_shared(device, QMI_SERVICE_DMS,
> +						create_dms_cb, sim, NULL);
>
>  	return 0;
>  }
> @@ -500,9 +566,15 @@ static void qmi_sim_remove(struct ofono_sim *sim)
>
>  	ofono_sim_set_data(sim, NULL);
>
> -	qmi_service_unregister_all(data->uim);
> -
> -	qmi_service_unref(data->uim);
> +	if (data->uim) {
> +		qmi_service_unregister_all(data->uim);
> +		qmi_service_unref(data->uim);
> +		data->uim =3D NULL;
> +	}
> +	if (data->dms) {
> +		qmi_service_unregister_all(data->dms);
> +		qmi_service_unref(data->dms);
> +	}
>
>  	g_free(data);
>  }
> @@ -515,6 +587,7 @@ static struct ofono_sim_driver driver =3D {
>  	.read_file_transparent	=3D qmi_read_transparent,
>  	.read_file_linear	=3D qmi_read_record,
>  	.read_file_cyclic	=3D qmi_read_record,
> +	.read_imsi		=3D qmi_read_imsi,
>  	.query_passwd_state	=3D qmi_query_passwd_state,
>  	.query_pin_retries	=3D qmi_query_pin_retries,
>  };
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index 6a789411..84a98279 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c

This should be in a separate patch, see HACKING, 'Submitting patches' =

section

> @@ -420,7 +420,7 @@ static void gobi_pre_sim(struct ofono_modem *modem)
>
>  	ofono_devinfo_create(modem, 0, "qmimodem", data->device);
>
> -	if (data->features & GOBI_UIM)
> +	if ((data->features & GOBI_UIM) && (data->features & GOBI_DMS))
>  		sim_driver =3D "qmimodem";
>  	else if (data->features & GOBI_DMS)
>  		sim_driver =3D "qmimodem-legacy";
>

Regards,
-Denis

--===============3027959188041555736==--

