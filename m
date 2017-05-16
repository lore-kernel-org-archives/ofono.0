Content-Type: multipart/mixed; boundary="===============5700357713344667093=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] qmimodem: receive & delete sms from NV storage on
 'Powered'
Date: Tue, 16 May 2017 13:06:30 -0500
Message-ID: <862a3a9c-e048-c4d1-4947-774ae8efb78b@gmail.com>
In-Reply-To: <20170516154940.13823-2-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5700357713344667093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 05/16/2017 10:49 AM, Alexander Couzens wrote:
> When the modem is powered download all message from the storage
> and delete them afterwards. This is required as certain modems
> (e.g. Gobi 2000) won't receive any further messages and generate
> a SMPP RP-Error 'Protocol error, unspecific'. Even those messages
> should not saved in the ME.
>
> This should also the case for newer modems, like the EC20, but they
> have a much bigger storage as it doesn't got noticed.
> Storage capacity: EC20: 255 msg, Gobi2000: 23 msg.
> ---
>  drivers/qmimodem/sms.c | 169 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  drivers/qmimodem/wms.h |  55 ++++++++++++++--
>  2 files changed, 219 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
> index 43bf22d1..4df65962 100644
> --- a/drivers/qmimodem/sms.c
> +++ b/drivers/qmimodem/sms.c
> @@ -334,6 +334,170 @@ error:
>  	g_free(cbd);
>  }
>
> +static void delete_message(struct ofono_sms *sms, uint32_t message_id)
> +{
> +	struct qmi_param *param =3D qmi_param_new();
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +
> +	if (!param)
> +		return;
> +
> +	DBG("remove message %08x", message_id);
> +
> +	qmi_param_append_uint8(param, QMI_WMS_PARAM_DELETE_STORAGE,
> +			       QMI_WMS_STORAGE_TYPE_NV);
> +	qmi_param_append_uint32(param, QMI_WMS_PARAM_DELETE_MESSAGE_INDEX,
> +			       message_id);
> +	qmi_param_append_uint8(param, QMI_WMS_PARAM_DELETE_MESSAGE_MODE,
> +			 QMI_WMS_MESSAGE_MODE_GSMWCDMA);
> +
> +	if (qmi_service_send(data->wms, QMI_WMS_DELETE_MESSAGE, param,
> +					NULL, NULL, NULL) > 0)
> +		return;

Okay, but pointless.  If you don't care about the return value might as =

well just don't wrap it in the 'if'

> +}
> +
> +struct read_message_data {
> +	struct ofono_sms *sms;
> +	uint32_t message_id;
> +};
> +
> +static void read_message_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct read_message_data *read_data =3D user_data;
> +	const struct qmi_wms_raw_message *message;
> +	uint16_t len;
> +	uint16_t plen;
> +
> +	message =3D qmi_result_get(result, QMI_WMS_PARAM_RAW_READ_MESSAGE, &len=
);
> +	if (!message)
> +		return;

You're leaking read_data here and a few other places below.  Please =

learn to use the destroy callback, that is what it is there for.

> +
> +	/* -1 when the payload length is 0 */
> +	if (sizeof(*message) - 1 > len)
> +		return;
> +

???

> +	plen =3D GUINT16_FROM_LE(message->count);
> +	if (plen + 4 > len)
> +		return;
> +
> +	switch (message->message_tag) {
> +	case QMI_WMS_MESSAGE_TAG_TYPE_MT_NOT_READ:
> +	case QMI_WMS_MESSAGE_TAG_TYPE_MT_READ:
> +		ofono_sms_deliver_notify(read_data->sms,
> +						message->data,
> +						plen,
> +						TPDU_UNKNOWN_WITH_SC);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	delete_message(read_data->sms, read_data->message_id);
> +	g_free(read_data);
> +}
> +
> +static void read_delete_message(struct ofono_sms *sms, uint32_t message_=
id)
> +{
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +	struct qmi_wms_result_new_msg_notify read_message;
> +	struct qmi_param *param =3D NULL;
> +	struct read_message_data *read_data =3D NULL;
> +
> +	DBG("");
> +
> +	read_data =3D g_try_new0(struct read_message_data, 1);
> +	if (!read_data)
> +		return;

Not our style.  See doc/coding-style.txt item M1.  Also, we have deemed =

it acceptable to use g_new0 for small allocations, so just make your =

life simple.

> +	read_data->sms =3D sms;
> +	read_data->message_id =3D message_id;
> +
> +	param =3D qmi_param_new();
> +	if (!param)
> +		goto err;
> +
> +	read_message.storage_index =3D GUINT32_TO_LE(message_id);
> +	read_message.storage_type =3D QMI_WMS_STORAGE_TYPE_NV;
> +
> +	if (!qmi_param_append(param, QMI_WMS_PARAM_RAW_READ_MESSAGE_ID,
> +			       sizeof(read_message), &read_message))
> +		goto err;

Not our style

> +	if (!qmi_param_append_uint8(param, QMI_WMS_PARAM_RAW_READ_MESSAGE_MODE,
> +			 QMI_WMS_MESSAGE_MODE_GSMWCDMA))
> +		goto err;
> +
> +	if (qmi_service_send(data->wms, QMI_WMS_RAW_READ, param,
> +					read_message_cb, read_data, NULL) > 0)
> +		return;

As above

> +err:
> +	qmi_param_free(param);
> +	g_free(read_data);
> +}
> +
> +static void get_msg_list_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct ofono_sms *sms =3D user_data;
> +	const struct qmi_wms_message_list *list;
> +	uint16_t len;
> +	uint32_t num;
> +	int i;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, NULL))
> +		return;
> +
> +	list =3D qmi_result_get(result, QMI_WMS_RESULT_MESSAGE_LIST, &len);
> +	if (!list)
> +		return;
> +
> +	num =3D GUINT32_FROM_LE(list->count);
> +	if (num * sizeof(*list->message) + 4 > len) {
> +		DBG("invalid length of the message list");
> +		return;
> +	}
> +
> +	DBG("found %d messages", num);
> +
> +	for (i =3D 0; i < num; i++) {
> +		uint32_t index =3D GUINT32_FROM_LE(list->message[i].memory_index);
> +
> +		DBG("message %d tags %d", index, list->message[i].message_tag);
> +		/* read messages, delete the message in the callback */
> +		read_delete_message(sms, index);
> +	}
> +}
> +
> +static void list_messages(struct ofono_sms *sms, enum qmi_wms_message_ta=
g tag)
> +{
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +	struct qmi_param *param;
> +
> +	DBG("");
> +
> +	param =3D qmi_param_new();
> +	if (!param)
> +		return;
> +
> +	if (!qmi_param_append_uint8(param,
> +				QMI_WMS_PARAM_LIST_MESSAGE_STORAGE_TYPE,
> +				QMI_WMS_STORAGE_TYPE_NV))
> +		goto err;
> +
> +	if (!qmi_param_append_uint8(param, QMI_WMS_PARAM_LIST_MESSAGE_MODE,
> +			       QMI_WMS_MESSAGE_MODE_GSMWCDMA))
> +		goto err;
> +
> +	if (!qmi_param_append_uint8(param, QMI_WMS_PARAM_LIST_MESSAGE_TAG, tag))
> +		goto err;
> +
> +	if (qmi_service_send(data->wms, QMI_WMS_GET_MSG_LIST, param,
> +				get_msg_list_cb, sms, NULL) > 0)
> +		return;
> +err:
> +	qmi_param_free(param);
> +}
> +
> +
>  static void event_notify(struct qmi_result *result, void *user_data)
>  {
>  	struct ofono_sms *sms =3D user_data;
> @@ -369,6 +533,10 @@ static void set_routes_cb(struct qmi_result *result,=
 void *user_data)
>
>  	DBG("");
>
> +	list_messages(sms, QMI_WMS_MESSAGE_TAG_TYPE_MT_READ);
> +	list_messages(sms, QMI_WMS_MESSAGE_TAG_TYPE_MT_NOT_READ);
> +	list_messages(sms, QMI_WMS_MESSAGE_TAG_TYPE_MO_SENT);
> +	list_messages(sms, QMI_WMS_MESSAGE_TAG_TYPE_MO_NOT_SENT);
>  	ofono_sms_register(sms);
>  }
>
> diff --git a/drivers/qmimodem/wms.h b/drivers/qmimodem/wms.h
> index dae86c17..fde2cbc1 100644
> --- a/drivers/qmimodem/wms.h
> +++ b/drivers/qmimodem/wms.h
> @@ -24,6 +24,8 @@
>  #define QMI_WMS_SET_EVENT		1	/* Set new message conditions */
>
>  #define QMI_WMS_RAW_SEND		32	/* Send a raw message */
> +#define QMI_WMS_RAW_READ		34	/* Read a raw message */
> +#define QMI_WMS_DELETE_MESSAGE		36	/* Delete a message */
>
>  #define QMI_WMS_GET_MSG_LIST		49	/* Get list of messages from the device=
 */
>  #define QMI_WMS_SET_ROUTES		50	/* Set routes for message memory storage =
*/
> @@ -55,16 +57,61 @@ struct qmi_wms_param_message {
>  } __attribute__((__packed__));
>  #define QMI_WMS_RESULT_MESSAGE_ID		0x01	/* uint16 */
>
> -/* Get list of messages from the device */
> -#define QMI_WMS_PARAM_STORAGE_TYPE		0x01	/* uint8 */
> -#define QMI_WMS_PARAM_MESSAGE_MODE		0x11	/* uint8 */
> -
>  #define QMI_WMS_STORAGE_TYPE_UIM		0
>  #define QMI_WMS_STORAGE_TYPE_NV			1
>  #define QMI_WMS_STORAGE_TYPE_UNKNOWN		2
>
>  #define QMI_WMS_MESSAGE_MODE_GSMWCDMA		1
>
> +#define QMI_WMS_RESULT_MESSAGE_LIST		0x01
> +struct qmi_wms_message_list {
> +	uint32_t count;
> +	struct {
> +		uint32_t memory_index;
> +		uint8_t message_tag;
> +	} __attribute__((__packed__)) message[0];
> +} __attribute__((__packed__));
> +
> +enum qmi_wms_message_tag {
> +	QMI_WMS_MESSAGE_TAG_TYPE_MT_READ     =3D 0x00,
> +	QMI_WMS_MESSAGE_TAG_TYPE_MT_NOT_READ =3D 0x01,
> +	QMI_WMS_MESSAGE_TAG_TYPE_MO_SENT     =3D 0x02,
> +	QMI_WMS_MESSAGE_TAG_TYPE_MO_NOT_SENT =3D 0x03
> +};
> +
> +/* read a message */
> +enum qmi_wms_param_read_message_req {
> +	QMI_WMS_PARAM_RAW_READ_MESSAGE_ID	=3D 0x01,
> +	QMI_WMS_PARAM_RAW_READ_MESSAGE_MODE	=3D 0x10,
> +};
> +enum qmi_wms_param_read_message_res {
> +	QMI_WMS_PARAM_RAW_READ_MESSAGE	=3D 0x01,
> +};
> +struct qmi_wms_raw_message {
> +	uint8_t message_tag;

msg_tag

> +	uint8_t message_format;

msg_format

> +	uint16_t count;

Should this not be msg_length to be consistent with =

qmi_wms_param_message and qmi_wms_result_message

> +	uint8_t data[0];
> +} __attribute__((__packed__));
> +
> +/* delete a message */
> +enum qmi_wms_params_delete_req {
> +	QMI_WMS_PARAM_DELETE_STORAGE		=3D 0x01,
> +	QMI_WMS_PARAM_DELETE_MESSAGE_INDEX	=3D 0x10,
> +	QMI_WMS_PARAM_DELETE_MESSAGE_MODE	=3D 0x12,
> +};
> +
> +/* Get list of messages from the device response */
> +enum qmi_wms_params_list_message_req {
> +	QMI_WMS_PARAM_LIST_MESSAGE_STORAGE_TYPE	=3D 0x01,
> +	QMI_WMS_PARAM_LIST_MESSAGE_TAG		=3D 0x11,
> +	QMI_WMS_PARAM_LIST_MESSAGE_MODE		=3D 0x12,
> +};
> +
> +enum qmi_wms_params_list_message_res {
> +	QMI_WMS_PARAM_LIST_MESSAGE_LIST		=3D 0x01,
> +};
> +
>  /* Get routes for message memory storage */
>  #define QMI_WMS_RESULT_ROUTE_LIST		0x01
>  #define QMI_WMS_PARAM_ROUTE_LIST		0x01
>

Regards,
-Denis

--===============5700357713344667093==--

