Content-Type: multipart/mixed; boundary="===============5458290480991002946=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] MC7430: Add send_passwd feature to qmimodem sim driver
Date: Tue, 03 Jan 2017 10:54:38 -0600
Message-ID: <bbe2809f-f6c8-46c0-1be0-1e411172fa6d@gmail.com>
In-Reply-To: <20170103105537.19063-2-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5458290480991002946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 01/03/2017 04:55 AM, Christophe Ronco wrote:
> drivers/qmimodem/sim.c
>  Add send_passwd feature to qmimodem smi driver.
>  Password state and number of retries asked using QMI_UIM_GET_CARD_STATUS=
 command
>  rather than remembered after initial QMI_UIM_GET_CARD_STATUS command.
>  Retry implemented for query_passwd_state if temporary error detected.
> drivers/qmimodem/uim.h
>  Add VERIFY_PIN message parameters

This really sounds like it should be broken into 3-4 commits.  One for =

each thing you're doing up above.

> ---
>  drivers/qmimodem/sim.c | 278 +++++++++++++++++++++++++++++++++++++++----=
------
>  drivers/qmimodem/uim.h |  11 ++
>  2 files changed, 232 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
> index f61466d5..9a01be2e 100644
> --- a/drivers/qmimodem/sim.c
> +++ b/drivers/qmimodem/sim.c
> @@ -39,17 +39,36 @@
>  #define EF_STATUS_INVALIDATED 0
>  #define EF_STATUS_VALID 1
>
> +/* max number of retry of commands that can temporary fail */
> +#define MAX_RETRY_COUNT 100
> +
> +enum get_card_status_result {
> +	GET_CARD_STATUS_RESULT_OK =3D	0, /* No error */
> +	GET_CARD_STATUS_RESULT_ERROR =3D	1, /* Definitive error */
> +	GET_CARD_STATUS_RESULT_TEMP_ERROR =3D	2 /* Temp error, a retry could wo=
rk */
> +};
> +
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
> +	uint32_t retry_count;
>  };
>
> +static void qmi_query_passwd_state(struct ofono_sim *sim,
> +				ofono_sim_passwd_cb_t cb, void *user_data);
> +
> +

No double empty lines please

>  static int create_fileid_data(uint8_t app_type, int fileid,
>  					const unsigned char *path,
>  					unsigned int path_len,
> @@ -339,76 +358,52 @@ static void qmi_read_imsi(struct ofono_sim *sim,
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
> +static gboolean get_card_status(const struct qmi_uim_slot_info *slot,
>  					const struct qmi_uim_app_info1 *info1,
>  					const struct qmi_uim_app_info2 *info2,
> -							struct sim_data *data)
> +					struct sim_status *sim_stat)
>  {
> -	data->card_state =3D slot->card_state;
> -	data->app_type =3D info1->app_type;
> +	gboolean need_retry =3D FALSE;
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
> +		/* This is temporary, we should retry */
> +		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
> +		need_retry =3D TRUE;
>  		break;
>  	case 0x07:	/* Ready */
> -		data->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
> +		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
>  		break;
>  	default:
> -		data->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
> +		DBG("info1->app_state:0x%x: OFONO_SIM_PASSWORD_INVALID", info1->app_st=
ate);
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
> +	return need_retry;
>  }
>
> -static void get_card_status_cb(struct qmi_result *result, void *user_dat=
a)
> +static enum get_card_status_result handle_get_card_status_result(
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
> +	enum get_card_status_result res =3D GET_CARD_STATUS_RESULT_ERROR;
>
>  	if (qmi_result_set_error(result, NULL))
>  		goto done;
> @@ -442,12 +437,184 @@ static void get_card_status_cb(struct qmi_result *=
result, void *user_data)
>  			index =3D GUINT16_FROM_LE(status->index_gw_pri);
>
>  			if ((index & 0xff) =3D=3D i && (index >> 8) =3D=3D n)
> -				card_setup(slot, info1, info2, data);
> +			{
> +				if(get_card_status(slot, info1, info2, sim_stat))
> +					res =3D GET_CARD_STATUS_RESULT_TEMP_ERROR; /* need retry */
> +				else
> +					res =3D GET_CARD_STATUS_RESULT_OK;
> +			}

This is not our coding style.  Please see the Linux Kernel coding style =

& our amendments in doc/coding-style.txt

>  		}
>  	}
>
>  done:
> -	switch (data->card_state) {
> +	return res;
> +}
> +
> +static void query_passwd_state_cb(struct qmi_result *result, void *user_=
data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_sim_passwd_cb_t cb =3D cbd->cb;
> +	struct ofono_sim *sim =3D cbd->user;
> +	struct sim_data *data =3D ofono_sim_get_data(sim);
> +	struct sim_status sim_stat;
> +	enum get_card_status_result res;
> +
> +	res =3D handle_get_card_status_result(result, &sim_stat);
> +	switch(res)
> +	{

Not our coding style

> +		case GET_CARD_STATUS_RESULT_OK:
> +			DBG("passwd state %d", sim_stat.passwd_state);
> +			data->retry_count =3D 0;
> +			CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state, cbd->data);
> +			break;
> +		case GET_CARD_STATUS_RESULT_TEMP_ERROR:
> +			data->retry_count++;
> +			if(data->retry_count > MAX_RETRY_COUNT) {
> +				DBG("Failed after %d attempts", data->retry_count);
> +				data->retry_count =3D 0;
> +				CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +			} else {
> +				usleep(20000);
> +				DBG("Retry command");
> +				qmi_query_passwd_state(sim, cb, cbd->data);
> +			}
> +			break;
> +		default:
> +		case GET_CARD_STATUS_RESULT_ERROR:
> +			DBG("Command failed");
> +			data->retry_count =3D 0;
> +			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +			break;
> +	}
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
> +	cbd->user =3D sim;
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
> +	if(handle_get_card_status_result(result, &sim_stat))
> +	{
> +		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> +	}
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
> +static void pin_send_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, NULL)) {
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +
> +static void qmi_pin_send(struct ofono_sim *sim, const char *passwd,
> +			ofono_sim_lock_unlock_cb_t cb, void *user_data)
> +{
> +	struct sim_data *data =3D ofono_sim_get_data(sim);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	int passwd_len;
> +	struct qmi_param *param;
> +	struct qmi_uim_param_message_info *info_data;
> +	unsigned char session_info_data[2];
> +
> +	DBG("");
> +
> +	if(!passwd)
> +		goto error;
> +	passwd_len =3D strlen(passwd);
> +	if(passwd_len <=3D 0 || passwd_len > 0xFF)
> +		goto error;
> +	=

> +

Double empty lines, mixed space/tab indentation.  Please fix this.

> +	param =3D qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	/* param info */
> +	info_data =3D alloca(2 + passwd_len);
> +	info_data->pin_id =3D 0x01; /* PIN 1 */
> +	info_data->length =3D (uint8_t)passwd_len;
> +	memcpy(info_data->pin_value, passwd, passwd_len);
> +	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_INFO, 2 + passwd_len, inf=
o_data);
> +	/* param Session Information */
> +	session_info_data[0] =3D 0x6;
> +	session_info_data[1] =3D 0x0;
> +	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_SESSION_INFO, 2, session_=
info_data);

Many lines > 80 characters.  Please fix this accordingly.

> +
> +	if (qmi_service_send(data->uim, QMI_UIM_VERIFY_PIN, param,
> +					pin_send_cb, cbd, g_free) > 0)
> +		return;
> +
> +error:
> +	qmi_param_free(param);
> +
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
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
> +	if(handle_get_card_status_result(result, &sim_stat))
> +		goto done;
> +
> +done:
> +	data->app_type =3D sim_stat.app_type;
> +	switch (sim_stat.card_state) {
>  	case 0x00:	/* Absent */
>  	case 0x02:	/* Error */
>  		break;
> @@ -543,12 +710,8 @@ static int qmi_sim_probe(struct ofono_sim *sim,
>
>  	data =3D g_new0(struct sim_data, 1);
>
> -	data->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
> -
> -	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
> -		data->retries[i] =3D -1;
> -
>  	data->qmi_dev =3D device;
> +	data->retry_count =3D 0;
>
>  	ofono_sim_set_data(sim, data);
>
> @@ -590,6 +753,7 @@ static struct ofono_sim_driver driver =3D {
>  	.read_imsi		=3D qmi_read_imsi,
>  	.query_passwd_state	=3D qmi_query_passwd_state,
>  	.query_pin_retries	=3D qmi_query_pin_retries,
> +	.send_passwd		=3D qmi_pin_send,
>  };
>
>  void qmi_sim_init(void)
> diff --git a/drivers/qmimodem/uim.h b/drivers/qmimodem/uim.h
> index 8f123e7d..cd10e684 100644
> --- a/drivers/qmimodem/uim.h
> +++ b/drivers/qmimodem/uim.h
> @@ -25,6 +25,8 @@
>  #define QMI_UIM_WRITE_RECORD		35	/* Write a record */
>  #define QMI_UIM_GET_FILE_ATTRIBUTES	36	/* Get file attributes */
>
> +#define QMI_UIM_VERIFY_PIN		38	/* Verify PIN */
> +
>  #define QMI_UIM_EVENT_REGISTRATION	46	/* Register for indications */
>  #define QMI_UIM_GET_CARD_STATUS		47	/* Get card status */
>
> @@ -91,3 +93,12 @@ struct qmi_uim_file_attributes {
>  	uint16_t raw_len;
>  	uint8_t raw_value[0];
>  } __attribute__((__packed__));
> +
> +/* Verify PIN parameter */
> +#define QMI_UIM_PARAM_MESSAGE_SESSION_INFO	0x01
> +#define QMI_UIM_PARAM_MESSAGE_INFO	0x02
> +struct qmi_uim_param_message_info {
> +	uint8_t pin_id;
> +	uint8_t length;
> +	uint8_t pin_value[0];
> +} __attribute__((__packed__));
>

Regards,
-Denis

--===============5458290480991002946==--

