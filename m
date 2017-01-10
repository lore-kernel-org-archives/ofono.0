Content-Type: multipart/mixed; boundary="===============7272720458731894560=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] qmimodem: get password state from modem
Date: Tue, 10 Jan 2017 11:19:40 -0600
Message-ID: <43856c43-f49b-9bb7-4106-4f62d30b291c@gmail.com>
In-Reply-To: <20170110083847.28309-2-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7272720458731894560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 01/10/2017 02:38 AM, Christophe Ronco wrote:
> Password state and number of retries asked to modem using
> QMI_UIM_GET_CARD_STATUS command rather than remembered after initial
> QMI_UIM_GET_CARD_STATUS command.
> ---
>  drivers/qmimodem/sim.c | 173 ++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 115 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
> index db012bcf..c4c79afe 100644
> --- a/drivers/qmimodem/sim.c
> +++ b/drivers/qmimodem/sim.c
> @@ -39,15 +39,20 @@
>  #define EF_STATUS_INVALIDATED 0
>  #define EF_STATUS_VALID 1
>
> +/* information from QMI_UIM_GET_CARD_STATUS command */
> +struct sim_status {
> +	uint8_t card_state;
> +	uint8_t app_type;
> +	uint8_t passwd_state;
> +	int retries[OFONO_SIM_PASSWORD_INVALID];
> +};
> +
>  struct sim_data {
>  	struct qmi_device *qmi_dev;
>  	struct qmi_service *dms;
>  	struct qmi_service *uim;
>  	uint32_t event_mask;
> -	uint8_t card_state;
>  	uint8_t app_type;
> -	uint8_t passwd_state;
> -	int retries[OFONO_SIM_PASSWORD_INVALID];
>  };
>
>  static int create_fileid_data(uint8_t app_type, int fileid,
> @@ -339,76 +344,50 @@ static void qmi_read_imsi(struct ofono_sim *sim,
>  	g_free(cbd);
>  }
>
> -static void qmi_query_passwd_state(struct ofono_sim *sim,
> -				ofono_sim_passwd_cb_t cb, void *user_data)
> -{
> -	struct sim_data *data =3D ofono_sim_get_data(sim);
> -
> -	DBG("passwd state %d", data->passwd_state);
> -
> -	if (data->passwd_state =3D=3D OFONO_SIM_PASSWORD_INVALID) {
> -		CALLBACK_WITH_FAILURE(cb, -1, user_data);
> -		return;
> -	}
> -
> -	CALLBACK_WITH_SUCCESS(cb, data->passwd_state, user_data);
> -}
> -
> -static void qmi_query_pin_retries(struct ofono_sim *sim,
> -				ofono_sim_pin_retries_cb_t cb, void *user_data)
> -{
> -	struct sim_data *data =3D ofono_sim_get_data(sim);
> -
> -	DBG("passwd state %d", data->passwd_state);
> -
> -	if (data->passwd_state =3D=3D OFONO_SIM_PASSWORD_INVALID) {
> -		CALLBACK_WITH_FAILURE(cb, NULL, user_data);
> -		return;
> -	}
> -
> -	CALLBACK_WITH_SUCCESS(cb, data->retries, user_data);
> -}
> -
> -static void card_setup(const struct qmi_uim_slot_info *slot,
> +static void get_card_status(const struct qmi_uim_slot_info *slot,
>  					const struct qmi_uim_app_info1 *info1,
>  					const struct qmi_uim_app_info2 *info2,
> -							struct sim_data *data)
> +					struct sim_status *sim_stat)
>  {
> -	data->card_state =3D slot->card_state;
> -	data->app_type =3D info1->app_type;
> +	sim_stat->card_state =3D slot->card_state;
> +	sim_stat->app_type =3D info1->app_type;
>
>  	switch (info1->app_state) {
>  	case 0x02:	/* PIN1 or UPIN is required */
> -		data->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PIN;
> +		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PIN;
>  		break;
>  	case 0x03:	/* PUK1 or PUK for UPIN is required */
> -		data->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PUK;
> +		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PUK;
> +		break;
> +	case 0x04:	/* Personalization state must be checked. */
> +		/* This is temporary, we could retry and get another result */
> +		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
>  		break;
>  	case 0x07:	/* Ready */
> -		data->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
> +		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
>  		break;
>  	default:
> -		data->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
> +		DBG("info1->app_state:0x%x: OFONO_SIM_PASSWORD_INVALID",
> +			info1->app_state);
> +		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
>  		break;
>  	}
>
> -	data->retries[OFONO_SIM_PASSWORD_SIM_PIN] =3D info2->pin1_retries;
> -	data->retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D info2->puk1_retries;
> +	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PIN] =3D info2->pin1_retries;
> +	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D info2->puk1_retries;
>
> -	data->retries[OFONO_SIM_PASSWORD_SIM_PIN2] =3D info2->pin2_retries;
> -	data->retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D info2->puk2_retries;
> +	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PIN2] =3D info2->pin2_retries;
> +	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D info2->puk2_retries;
>  }
>
> -static void get_card_status_cb(struct qmi_result *result, void *user_dat=
a)
> +static gboolean handle_get_card_status_result(
> +		struct qmi_result *result, struct sim_status *sim_stat)
>  {
> -	struct ofono_sim *sim =3D user_data;
> -	struct sim_data *data =3D ofono_sim_get_data(sim);
>  	const void *ptr;
>  	const struct qmi_uim_card_status *status;
>  	uint16_t len, offset;
>  	uint8_t i;
> -
> -	DBG("");
> +	gboolean res =3D FALSE;
>
>  	if (qmi_result_set_error(result, NULL))
>  		goto done;
> @@ -442,14 +421,98 @@ static void get_card_status_cb(struct qmi_result *r=
esult, void *user_data)
>  			index =3D GUINT16_FROM_LE(status->index_gw_pri);
>
>  			if ((index & 0xff) =3D=3D i && (index >> 8) =3D=3D n)
> -				card_setup(slot, info1, info2, data);
> +				get_card_status(slot, info1, info2, sim_stat);
>  		}
>  	}
>
>  done:
> +	return res;

This function seems to always return false...

> +}
> +
> +static void query_passwd_state_cb(struct qmi_result *result,
> +					void *user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_sim_passwd_cb_t cb =3D cbd->cb;
> +	struct sim_status sim_stat;
> +
> +	DBG("");
> +
> +	if (handle_get_card_status_result(result, &sim_stat)) {
> +		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +		return;
> +	}

So this if-condition is never encountered...

> +
> +	CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state, cbd->data);
> +}
> +
> +static void qmi_query_passwd_state(struct ofono_sim *sim,
> +				ofono_sim_passwd_cb_t cb, void *user_data)
> +{
> +	struct sim_data *data =3D ofono_sim_get_data(sim);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +
> +	DBG("");
> +
> +	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
> +					query_passwd_state_cb, cbd, g_free) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +
> +	g_free(cbd);
> +}
> +
> +static void query_pin_retries_cb(struct qmi_result *result, void *user_d=
ata)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
> +	struct sim_status sim_stat;
> +
> +	DBG("");
> +
> +	if (handle_get_card_status_result(result, &sim_stat)) {

as above

> +		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, sim_stat.retries, cbd->data);
> +}
> +
> +static void qmi_query_pin_retries(struct ofono_sim *sim,
> +				ofono_sim_pin_retries_cb_t cb, void *user_data)
> +{
> +	struct sim_data *data =3D ofono_sim_get_data(sim);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +
> +	DBG("");
> +
> +	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
> +					query_pin_retries_cb, cbd, g_free) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> +
> +	g_free(cbd);
> +}
> +
> +static void get_card_status_cb(struct qmi_result *result, void *user_dat=
a)
> +{
> +	struct ofono_sim *sim =3D user_data;
> +	struct sim_data *data =3D ofono_sim_get_data(sim);
> +	struct sim_status sim_stat;
> +
> +	DBG("");
> +
> +	if (handle_get_card_status_result(result, &sim_stat)) {
> +		data->app_type =3D 0; /* Unknown */
> +		ofono_sim_register(sim);
> +		return;
> +	}
> +
>  	ofono_sim_register(sim);

I don't understand what happens here.  Is it really the intent to always =

call ofono_sim_register?  If so, the logic should probably be modified =

to reflect that.

>
> -	switch (data->card_state) {
> +	switch (sim_stat.card_state) {
>  	case 0x00:	/* Absent */
>  	case 0x02:	/* Error */
>  		break;
> @@ -536,17 +599,11 @@ static int qmi_sim_probe(struct ofono_sim *sim,
>  {
>  	struct qmi_device *device =3D user_data;
>  	struct sim_data *data;
> -	int i;
>
>  	DBG("");
>
>  	data =3D g_new0(struct sim_data, 1);
>
> -	data->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
> -
> -	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
> -		data->retries[i] =3D -1;
> -
>  	data->qmi_dev =3D device;
>
>  	ofono_sim_set_data(sim, data);
>

Regards,
-Denis

--===============7272720458731894560==--

