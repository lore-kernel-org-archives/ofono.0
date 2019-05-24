Content-Type: multipart/mixed; boundary="===============4841865268694785413=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] qmimodem: support wake on SMS receive
Date: Fri, 24 May 2019 12:56:36 -0500
Message-ID: <5b9cbd4b-fbaf-fe46-3ca9-8865d2c10bfa@gmail.com>
In-Reply-To: <276382527.7616.1558635312492@wamui-eagle.atl.sa.earthlink.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4841865268694785413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On 05/23/2019 01:15 PM, Tom Nguyen wrote:
> Some modems, like Quectel EC25, support waking the host platform from a s=
uspend state upon an SMS reception. Current SMS handling configures the mod=
em to not save incoming messages. On platforms where the modem's interfaces=
 (eg, cdc-wdm, wwan, etc) disconnect on suspend and reconnect on resume, oF=
ono will re-initialize. This can cause lost messages upon resume because th=
e QMI indication is sent before oFono is ready.

Note, the commit description should be broken up with no line longer =

than 72 characters.

> =

> Changes to support suspend/resume with wake on SMS:
> - On startup:
>    1. Configure modem to save messages to NV and notify for class NONE.
>    2. Delete all processed messages in modem memory to free space.
>    3. Get list of unread messages, then get and delete each.
> - After startup:
>    1. Process message upon event indication and delete.
>    2. Then check for possibly more messages to process.
> ---
>   drivers/qmimodem/sms.c | 327 ++++++++++++++++++++++++++++++++++++++++--=
-------
>   drivers/qmimodem/wms.h |  77 +++++++++---
>   2 files changed, 332 insertions(+), 72 deletions(-)
> =


So I can't seem to apply this patch:

denkenz(a)localhost ~/ofono-master $ git am ~/merge/\[PATCH\ v3\]\ =

qmimodem\:\ support\ wake\ on\ SMS\ receive.eml
Applying: qmimodem: support wake on SMS receive
error: corrupt patch at line 24
Patch failed at 0001 qmimodem: support wake on SMS receive


> diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c index 1e9303=
9..081492b 100644
> --- a/drivers/qmimodem/sms.c
> +++ b/drivers/qmimodem/sms.c
> @@ -39,8 +39,15 @@ struct sms_data {
>   	struct qmi_service *wms;
>   	uint16_t major;
>   	uint16_t minor;
> +	struct qmi_wms_read_msg_id rd_msg_id;
> +	uint8_t msg_mode;
> +	bool msg_chk_all;
> +	bool msg_list_chk;
>   };
>   =

> +static void get_msg_list(struct ofono_sms *sms);
> +
> +

No double empty lines please

>   static void get_smsc_addr_cb(struct qmi_result *result, void *user_data=
)  {
>   	struct cb_data *cbd =3D user_data;
> @@ -334,21 +341,78 @@ error:
>   	g_free(cbd);
>   }
>   =

> +static void delete_msg_cb(struct qmi_result *result, void *user_data) {

Not our coding style.  Please refer to doc/coding-style.txt for details

> +	struct ofono_sms *sms =3D user_data;
> +	uint16_t err;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &err))
> +		DBG("Err: delete %d - %s", err, qmi_result_get_error(result));
> +	else {
> +		DBG("msg deleted");
> +
> +		/* check for more messages */
> +		get_msg_list(sms);
> +	}

We prefer that indenting is kept to a minimum, so this could be written as:

if (qmi_result_set_error(...) {
	DBG("...");
	return;
}

DBG("...");
get_msg_list(...);

> +}
> +
> +static void delete_msg(struct ofono_sms *sms, uint8_t tag) {
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +	struct qmi_param *param;
> +	qmi_result_func_t func =3D NULL;
> +
> +	DBG("");
> +
> +	param =3D qmi_param_new();
> +	if (param =3D=3D NULL)
> +		return;
> +
> +	qmi_param_append_uint8(param, QMI_WMS_PARAM_DEL_STORE,
> +				QMI_WMS_STORAGE_TYPE_NV);
> +
> +	if (tag =3D=3D QMI_WMS_MT_UNDEFINE) {
> +		DBG("delete read msg type %d ndx %d", data->rd_msg_id.type,
> +			data->rd_msg_id.ndx);
> +
> +		/* delete 1 msg */
> +		qmi_param_append_uint32(param, QMI_WMS_PARAM_DEL_NDX,
> +					data->rd_msg_id.ndx);
> +		func =3D delete_msg_cb;
> +	} else {
> +		DBG("delete msg tag %d mode %d", tag, data->msg_mode);
> +
> +		/* delete all msgs from 1 tag type */
> +		qmi_param_append_uint8(param, QMI_WMS_PARAM_DEL_TYPE, tag);
> +	}
> +
> +	qmi_param_append_uint8(param, QMI_WMS_PARAM_DEL_MODE, data->msg_mode);
> +
> +	if (qmi_service_send(data->wms, QMI_WMS_DELETE, param,
> +			func, sms, NULL) > 0)
> +		return;
> +
> +	qmi_param_free(param);
> +}
> +
>   static void raw_read_cb(struct qmi_result *result, void *user_data)  {
>   	struct ofono_sms *sms =3D user_data;
> -	const struct qmi_wms_raw_message* msg;
> -	uint16_t len;
> -	uint16_t error;
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +	const struct qmi_wms_raw_message *msg;
> +	uint16_t err;
>   =

> -	if (qmi_result_set_error(result, &error)) {
> -		DBG("Raw read error: %d (%s)", error,
> -			qmi_result_get_error(result));
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &err)) {
> +		DBG("Err: read %d - %s", err, qmi_result_get_error(result));
>   		return;
>   	}
>   =

>   	/* Raw message data */
> -	msg =3D qmi_result_get(result, 0x01, &len);
> +	msg =3D qmi_result_get(result, QMI_WMS_RESULT_READ_MSG, NULL);
>   	if (msg) {
>   		uint16_t plen;
>   		uint16_t tpdu_len;
> @@ -357,9 +421,153 @@ static void raw_read_cb(struct qmi_result *result, =
void *user_data)
>   		tpdu_len =3D plen - msg->msg_data[0] - 1;
>   =

>   		ofono_sms_deliver_notify(sms, msg->msg_data, plen, tpdu_len);
> +	} else
> +		DBG("Err: no data in type %d ndx %d", data->rd_msg_id.type,
> +			data->rd_msg_id.ndx);
> +
> +	/* delete read msg */
> +	delete_msg(sms, QMI_WMS_MT_UNDEFINE);
> +}
> +
> +static void raw_read(struct ofono_sms *sms, uint8_t type, uint32_t ndx)
> +{
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +	struct qmi_param *param;
> +
> +	DBG("");
> +
> +	param =3D qmi_param_new();
> +	if (param =3D=3D NULL)
> +		return;
> +
> +	data->rd_msg_id.type =3D type;
> +	data->rd_msg_id.ndx =3D ndx;
> +
> +	DBG("read type %d ndx %d", data->rd_msg_id.type, data->rd_msg_id.ndx);
> +
> +	qmi_param_append(param, QMI_WMS_PARAM_READ_MSG,
> +				sizeof(data->rd_msg_id), &data->rd_msg_id);
> +	qmi_param_append_uint8(param, QMI_WMS_PARAM_READ_MODE,
> +data->msg_mode);

This line should be indented more

> +
> +	if (qmi_service_send(data->wms, QMI_WMS_RAW_READ, param,
> +			raw_read_cb, sms, NULL) > 0)

Same here.  See doc/coding-style.txt item M4

> +		return;
> +
> +	qmi_param_free(param);
> +}
> +
> +static void get_msg_list_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct ofono_sms *sms =3D user_data;
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +	struct qmi_param *param;
> +	const struct qmi_wms_result_msg_list *list;
> +	uint32_t cnt =3D 0;
> +	uint16_t tmp;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &tmp)) {
> +		DBG("Err: get msg list %d - %s", tmp,
> +			qmi_result_get_error(result));
> +		goto done;
> +	}
> +
> +	list =3D qmi_result_get(result, QMI_WMS_RESULT_MSG_LIST, NULL);
> +	if (list =3D=3D NULL) {
> +		DBG("Err: get msg list empty");
> +		goto done;
> +	}
> +
> +	cnt =3D GUINT32_FROM_LE(list->cnt);
> +	DBG("msgs found %d", cnt);
> +
> +	for (tmp =3D 0; tmp < cnt; tmp++) {
> +		DBG("unread type %d ndx %d", list->msg[tmp].type,
> +			GUINT32_FROM_LE(list->msg[tmp].ndx));
> +	}
> +
> +	/* get 1st msg in list */
> +	if (cnt)
> +		raw_read(sms, list->msg[0].type,
> +				GUINT32_FROM_LE(list->msg[0].ndx));
> +	else
> +		data->msg_list_chk =3D false;

So to me it looks like you're performing a message list, grabbing the =

first message to raw_read & delete, and upon deletion you're re-grabbing =

the message list.  Can you not grab all messages in succession without =

resorting to re-doing the list operation?

Or am I mis-reading the intent here?

> +
> +done:
> +	/* check other protocol if needed */
> +	if (data->msg_chk_all && (cnt =3D=3D 0)) {
> +		data->msg_chk_all =3D false;
> +		data->msg_mode =3D QMI_WMS_MESSAGE_MODE_GSMWCDMA;
> +		get_msg_list(sms);
> +	}
> +}
> +
> +static void get_msg_list(struct ofono_sms *sms) {
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +	struct qmi_param *param;
> +
> +	DBG("");
> +
> +	param =3D qmi_param_new();
> +	if (param =3D=3D NULL)
> +		return;
> +
> +	data->msg_list_chk =3D true;
> +
> +	/* query NOT_READ msg list */
> +	qmi_param_append_uint8(param, QMI_WMS_PARAM_STORAGE_TYPE,
> +				QMI_WMS_STORAGE_TYPE_NV);
> +	qmi_param_append_uint8(param, QMI_WMS_PARAM_TAG_TYPE,
> +				QMI_WMS_MT_NOT_READ);
> +	qmi_param_append_uint8(param, QMI_WMS_PARAM_MESSAGE_MODE,
> +				data->msg_mode);
> +
> +	if (qmi_service_send(data->wms, QMI_WMS_GET_MSG_LIST, param,
> +			get_msg_list_cb, sms, NULL) > 0)
> +		return;
> +
> +	qmi_param_free(param);
> +}
> +
> +static void get_msg_protocol_cb(struct qmi_result *result, void
> +*user_data) {

doc/coding-style.txt item M4

> +	struct ofono_sms *sms =3D user_data;
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +	uint16_t err;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &err) &&
> +			(err !=3D QMI_ERR_OP_DEVICE_UNSUPPORTED)) {
> +		DBG("Err: protocol %d - %s", err, qmi_result_get_error(result));
> +		return;
> +	}
> +
> +	if (err !=3D QMI_ERR_OP_DEVICE_UNSUPPORTED) {
> +		/* modem supports only 1 protocol */
> +		qmi_result_get_uint8(result, QMI_WMS_PARAM_PROTOCOL,
> +					&data->msg_mode);
>   	} else {
> -		DBG("No message data available at requested position");
> +		/* check both, start with 1 then switch to other */
> +		DBG("device supports CDMA and WCDMA msg protocol");
> +		data->msg_chk_all =3D true;
> +		data->msg_mode =3D QMI_WMS_MESSAGE_MODE_CDMA;
>   	}
> +
> +	/* check for messages */
> +	get_msg_list(sms);
> +}
> +
> +static void get_msg_protocol(struct ofono_sms *sms) {

Not our coding style...

> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +
> +	DBG("");
> +
> +	qmi_service_send(data->wms, QMI_WMS_GET_MSG_PROTOCOL, NULL,
> +				get_msg_protocol_cb, sms, NULL);
>   }
>   =

>   static void event_notify(struct qmi_result *result, void *user_data) @@=
 -367,66 +575,72 @@ static void event_notify(struct qmi_result *result, voi=
d *user_data)
>   	struct ofono_sms *sms =3D user_data;
>   	struct sms_data *data =3D ofono_sms_get_data(sms);
>   	const struct qmi_wms_result_new_msg_notify *notify;
> -	const struct qmi_wms_result_message *message;
> -	uint16_t len;
>   =

>   	DBG("");
>   =

> -	notify =3D qmi_result_get(result, QMI_WMS_RESULT_NEW_MSG_NOTIFY, &len);
> +	notify =3D qmi_result_get(result, QMI_WMS_RESULT_NEW_MSG_NOTIFY, NULL);
>   	if (notify) {
> -		DBG("storage type %d index %d", notify->storage_type,
> -				GUINT32_FROM_LE(notify->storage_index));
> -	}
> +		/* route is store and notify */
> +		if (!qmi_result_get_uint8(result, QMI_WMS_RESULT_MSG_MODE,
> +				&data->msg_mode))
> +			DBG("msg mode not found, use mode %d", data->msg_mode);
> +
> +		DBG("msg type %d ndx %d mode %d", notify->storage_type,
> +			GUINT32_FROM_LE(notify->storage_index), data->msg_mode);
> +
> +		/* don't read if list is being processed, will find this msg */
> +		if (!data->msg_list_chk)
> +			raw_read(sms, notify->storage_type,
> +					GUINT32_FROM_LE(notify->storage_index));

So I'm not familiar with QMI enough to truly know what is happening. =

But it looks like you are changing the logic slightly in this function. =

Before it would attempt to grab the QMI_WMS_RESULT_NEW_MSG_NOTIFY =

structure only for debug purposes, and instead attempt to grab the =

QMI_WMS_RESULT_MESSAGE in all cases.  If the QMI_WMS_RESULT_MESSAGE was =

not present, then the raw-read stuff would be triggered.  You're doing =

it slightly differently here.  It may be worth a comment.

Also, it may be clearer if the introduction of raw_read and the =

refactoring of this function are done as a separate commit.

> +	} else {
> +		const struct qmi_wms_result_message *message;
>   =

> -	message =3D qmi_result_get(result, QMI_WMS_RESULT_MESSAGE, &len);
> -	if (message) {
> -		uint16_t plen;
> +		message =3D qmi_result_get(result, QMI_WMS_RESULT_MESSAGE, NULL);
> +		if (message) {
> +			/* route is either transfer only or transfer and ACK */
> +			uint16_t plen;
>   =

> -		plen =3D GUINT16_FROM_LE(message->msg_length);
> +			plen =3D GUINT16_FROM_LE(message->msg_length);
>   =

> -		DBG("ack_required %d transaction id %u", message->ack_required,
> +			DBG("ack_required %d transaction id %u",
> +				message->ack_required,
>   				GUINT32_FROM_LE(message->transaction_id));
> -		DBG("msg format %d PDU length %d", message->msg_format, plen);
> +			DBG("msg format %d PDU length %d",
> +				message->msg_format, plen);
>   =

> -		ofono_sms_deliver_notify(sms, message->msg_data, plen, plen);
> -	} else {
> -		/* The Quectel EC21, at least, does not provide the
> -		 * message data in the event notification, so a 'raw read'
> -		 * needs to be issued in order to query the message itself
> -		 */
> -		struct qmi_param *param;
> -
> -		param =3D qmi_param_new();
> -		if (!param)
> -			return;
> -
> -		/* Message memory storage ID */
> -		qmi_param_append(param, 0x01, sizeof(*notify), notify);
> -		/* The 'message mode' parameter is documented as optional,
> -		 * but the Quectel EC21 errors out with error 17 (missing
> -		 * argument) if it is not provided... we default to 3GPP
> -		 * here because that's what works for me and it's not clear
> -		 * how to actually query what this should be otherwise...
> -		 */
> -		/* Message mode */
> -		qmi_param_append_uint8(param, 0x10,
> -				QMI_WMS_MESSAGE_MODE_GSMWCDMA);
> -
> -		if (qmi_service_send(data->wms, QMI_WMS_RAW_READ, param,
> -					raw_read_cb, sms, NULL) > 0)
> -			return;
> -
> -		qmi_param_free(param);
> +			ofono_sms_deliver_notify(sms, message->msg_data,
> +							plen, plen);
> +		}
>   	}
>   }
>   =

>   static void set_routes_cb(struct qmi_result *result, void *user_data)  {
>   	struct ofono_sms *sms =3D user_data;
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
>   =

>   	DBG("");
>   =

>   	ofono_sms_register(sms);
> +
> +	/*
> +	 * Modem storage is limited. As a fail safe, delete processed messages
> +	 * to free device memory to prevent blockage of new messages.
> +	 */
> +	data->msg_mode =3D QMI_WMS_MESSAGE_MODE_CDMA;
> +	delete_msg(sms, QMI_WMS_MT_READ);
> +	delete_msg(sms, QMI_WMS_MO_SENT);
> +	data->msg_mode =3D QMI_WMS_MESSAGE_MODE_GSMWCDMA;
> +	delete_msg(sms, QMI_WMS_MT_READ);
> +	delete_msg(sms, QMI_WMS_MO_SENT);
> +
> +	/*
> +	 * Subsystem initialized, now start process to check for unread
> +	 * messages. First, query msg protocol/mode. If modem supports both
> +	 * modes, then check messages for both modes since there's no way to
> +	 * query which mode is active.
> +	 */
> +	get_msg_protocol(sms);
>   }
>   =

>   static void get_routes_cb(struct qmi_result *result, void *user_data) @=
@ -445,7 +659,7 @@ static void get_routes_cb(struct qmi_result *result, voi=
d *user_data)
>   		goto done;
>   =

>   	list =3D qmi_result_get(result, QMI_WMS_RESULT_ROUTE_LIST, &len);
> -        if (!list)
> +	if (!list)

Generally we prefer pure style fixes to be done separately.  Makes =

things easier to review.

>   		goto done;
>   =

>   	num =3D GUINT16_FROM_LE(list->count);
> @@ -468,8 +682,8 @@ static void get_routes_cb(struct qmi_result *result, =
void *user_data)
>   	new_list->count =3D GUINT16_TO_LE(1);
>   	new_list->route[0].msg_type =3D QMI_WMS_MSG_TYPE_P2P;
>   	new_list->route[0].msg_class =3D QMI_WMS_MSG_CLASS_NONE;
> -	new_list->route[0].storage_type =3D QMI_WMS_STORAGE_TYPE_NONE;
> -	new_list->route[0].action =3D QMI_WMS_ACTION_TRANSFER_AND_ACK;
> +	new_list->route[0].storage_type =3D QMI_WMS_STORAGE_TYPE_NV;
> +	new_list->route[0].action =3D QMI_WMS_ACTION_STORE_AND_NOTIFY;
>   =

>   	param =3D qmi_param_new();
>   	if (!param)
> @@ -478,9 +692,9 @@ static void get_routes_cb(struct qmi_result *result, =
void *user_data)
>   	qmi_param_append(param, QMI_WMS_PARAM_ROUTE_LIST, len, new_list);
>   	qmi_param_append_uint8(param, QMI_WMS_PARAM_STATUS_REPORT, 0x01);
>   =

> -        if (qmi_service_send(data->wms, QMI_WMS_SET_ROUTES, param,
> -                                        set_routes_cb, sms, NULL) > 0)
> -                return;
> +	if (qmi_service_send(data->wms, QMI_WMS_SET_ROUTES, param,
> +		set_routes_cb, sms, NULL) > 0)
> +		return;

This change seems superfluous?  And also the new code is against our =

coding style.

>   =

>   	qmi_param_free(param);
>   =

> @@ -524,6 +738,9 @@ static void create_wms_cb(struct qmi_service *service=
, void *user_data)
>   =

>   	data->wms =3D qmi_service_ref(service);
>   =

> +	memset(&data->rd_msg_id, 0, sizeof(data->rd_msg_id));
> +	data->msg_mode =3D QMI_WMS_MESSAGE_MODE_GSMWCDMA;
> +
>   	qmi_service_register(data->wms, QMI_WMS_EVENT,
>   					event_notify, sms, NULL);
>   =


Regards,
-Denis

--===============4841865268694785413==--

