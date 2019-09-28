Content-Type: multipart/mixed; boundary="===============8634154580865207271=="
MIME-Version: 1.0
From: Tom Nguyen <tomirq@earthlink.net>
Subject: Re: [PATCH v3] qmimodem: support wake on SMS receive
Date: Sat, 28 Sep 2019 01:48:39 +0000
Message-ID: <1575757848.2114.1559744457699@wamui-aurora.atl.sa.earthlink.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8634154580865207271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>From: Denis Kenzior =

>
>Hi Tom,
>
>On 05/23/2019 01:15 PM, Tom Nguyen wrote:
>> Some modems, like Quectel EC25, support waking the host platform from a =
suspend state upon an SMS reception. Current SMS handling configures the mo=
dem to not save incoming messages. On platforms where the modem's interface=
s (eg, cdc-wdm, wwan, etc) disconnect on suspend and reconnect on resume, o=
Fono will re-initialize. This can cause lost messages upon resume because t=
he QMI indication is sent before oFono is ready.
>
>Note, the commit description should be broken up with no line longer =

>than 72 characters.
>
>> =

>> Changes to support suspend/resume with wake on SMS:
>> - On startup:
>>    1. Configure modem to save messages to NV and notify for class NONE.
>>    2. Delete all processed messages in modem memory to free space.
>>    3. Get list of unread messages, then get and delete each.
>> - After startup:
>>    1. Process message upon event indication and delete.
>>    2. Then check for possibly more messages to process.
>> ---
>>   drivers/qmimodem/sms.c | 327 ++++++++++++++++++++++++++++++++++++++++-=
--------
>>   drivers/qmimodem/wms.h |  77 +++++++++---
>>   2 files changed, 332 insertions(+), 72 deletions(-)
>> =

>
>So I can't seem to apply this patch:
>
>denkenz(a)localhost ~/ofono-master $ git am ~/merge/\[PATCH\ v3\]\ =

>qmimodem\:\ support\ wake\ on\ SMS\ receive.eml
>Applying: qmimodem: support wake on SMS receive
>error: corrupt patch at line 24
>Patch failed at 0001 qmimodem: support wake on SMS receive
>
>

Yikes, sorry about this. Apparently, there was a problem with my email. Som=
ehow, some line feeds got messed up and carriage return where there wasn't =
one. This caused that commit message problem, and some of the coding style =
problems you pointed out.

For my follow up patch, I've changed the commit message to be more descript=
ive of the root change. New title is "qmimodem: change msg class none to st=
ore/notify".

<snip>

>> +static void get_msg_list_cb(struct qmi_result *result, void *user_data)
>> +{
>> +	struct ofono_sms *sms =3D user_data;
>> +	struct sms_data *data =3D ofono_sms_get_data(sms);
>> +	struct qmi_param *param;
>> +	const struct qmi_wms_result_msg_list *list;
>> +	uint32_t cnt =3D 0;
>> +	uint16_t tmp;
>> +
>> +	DBG("");
>> +
>> +	if (qmi_result_set_error(result, &tmp)) {
>> +		DBG("Err: get msg list %d - %s", tmp,
>> +			qmi_result_get_error(result));
>> +		goto done;
>> +	}
>> +
>> +	list =3D qmi_result_get(result, QMI_WMS_RESULT_MSG_LIST, NULL);
>> +	if (list =3D=3D NULL) {
>> +		DBG("Err: get msg list empty");
>> +		goto done;
>> +	}
>> +
>> +	cnt =3D GUINT32_FROM_LE(list->cnt);
>> +	DBG("msgs found %d", cnt);
>> +
>> +	for (tmp =3D 0; tmp < cnt; tmp++) {
>> +		DBG("unread type %d ndx %d", list->msg[tmp].type,
>> +			GUINT32_FROM_LE(list->msg[tmp].ndx));
>> +	}
>> +
>> +	/* get 1st msg in list */
>> +	if (cnt)
>> +		raw_read(sms, list->msg[0].type,
>> +				GUINT32_FROM_LE(list->msg[0].ndx));
>> +	else
>> +		data->msg_list_chk =3D false;
>
>So to me it looks like you're performing a message list, grabbing the =

>first message to raw_read & delete, and upon deletion you're re-grabbing =

>the message list.  Can you not grab all messages in succession without =

>resorting to re-doing the list operation?
>
>Or am I mis-reading the intent here?
>

You understand correctly. I've changed it to grab the list, read/delete eac=
h until list is done, then grab list again to check for empty before switch=
ing to event indication. I don't see a way to issue one read request to get=
 all the messages.

<snip>

>>   static void event_notify(struct qmi_result *result, void *user_data) @=
@ -367,66 +575,72 @@ static void event_notify(struct qmi_result *result, vo=
id *user_data)
>>   	struct ofono_sms *sms =3D user_data;
>>   	struct sms_data *data =3D ofono_sms_get_data(sms);
>>   	const struct qmi_wms_result_new_msg_notify *notify;
>> -	const struct qmi_wms_result_message *message;
>> -	uint16_t len;
>>   =

>>   	DBG("");
>>   =

>> -	notify =3D qmi_result_get(result, QMI_WMS_RESULT_NEW_MSG_NOTIFY, &len);
>> +	notify =3D qmi_result_get(result, QMI_WMS_RESULT_NEW_MSG_NOTIFY, NULL);
>>   	if (notify) {
>> -		DBG("storage type %d index %d", notify->storage_type,
>> -				GUINT32_FROM_LE(notify->storage_index));
>> -	}
>> +		/* route is store and notify */
>> +		if (!qmi_result_get_uint8(result, QMI_WMS_RESULT_MSG_MODE,
>> +				&data->msg_mode))
>> +			DBG("msg mode not found, use mode %d", data->msg_mode);
>> +
>> +		DBG("msg type %d ndx %d mode %d", notify->storage_type,
>> +			GUINT32_FROM_LE(notify->storage_index), data->msg_mode);
>> +
>> +		/* don't read if list is being processed, will find this msg */
>> +		if (!data->msg_list_chk)
>> +			raw_read(sms, notify->storage_type,
>> +					GUINT32_FROM_LE(notify->storage_index));
>
>So I'm not familiar with QMI enough to truly know what is happening. =

>But it looks like you are changing the logic slightly in this function. =

>Before it would attempt to grab the QMI_WMS_RESULT_NEW_MSG_NOTIFY =

>structure only for debug purposes, and instead attempt to grab the =

>QMI_WMS_RESULT_MESSAGE in all cases.  If the QMI_WMS_RESULT_MESSAGE was =

>not present, then the raw-read stuff would be triggered.  You're doing =

>it slightly differently here.  It may be worth a comment.
>
>Also, it may be clearer if the introduction of raw_read and the =

>refactoring of this function are done as a separate commit.
>

Hmm, looking at the "Quectel EC21" comment again, looks like the original c=
ode was done to address a quirk (ie, bug???) with that modem. I'll revert t=
o reading both.

But, per spec, the 2 message TLVs are mutually exclusive, depending on the =
route action configuration. I'm referring to setting "new_list->route[0].ac=
tion =3D" in get_routes_cb(). So, we shouldn't need to always read both sin=
ce one is guaranteed to fail.

Also, the original code, if somehow both "notify" and "message" are NULL, i=
t'll erroneously use a null notify. I'll address this in the revert.

<snip>

>>   static void get_routes_cb(struct qmi_result *result, void *user_data) =
@@ -445,7 +659,7 @@ static void get_routes_cb(struct qmi_result *result, vo=
id *user_data)
>>   		goto done;
>>   =

>>   	list =3D qmi_result_get(result, QMI_WMS_RESULT_ROUTE_LIST, &len);
>> -        if (!list)
>> +	if (!list)
>
>Generally we prefer pure style fixes to be done separately.  Makes =

>things easier to review.
>

Understood, I'll revert this.

<snip>

>> @@ -478,9 +692,9 @@ static void get_routes_cb(struct qmi_result *result,=
 void *user_data)
>>   	qmi_param_append(param, QMI_WMS_PARAM_ROUTE_LIST, len, new_list);
>>   	qmi_param_append_uint8(param, QMI_WMS_PARAM_STATUS_REPORT, 0x01);
>>   =

>> -        if (qmi_service_send(data->wms, QMI_WMS_SET_ROUTES, param,
>> -                                        set_routes_cb, sms, NULL) > 0)
>> -                return;
>> +	if (qmi_service_send(data->wms, QMI_WMS_SET_ROUTES, param,
>> +		set_routes_cb, sms, NULL) > 0)
>> +		return;
>
>This change seems superfluous?  And also the new code is against our =

>coding style.
>

Oops, I screwed up on fixing its indent. Will revert this per above comment.

>>   =

>>   	qmi_param_free(param);
>>   =

>> @@ -524,6 +738,9 @@ static void create_wms_cb(struct qmi_service *servic=
e, void *user_data)
>>   =

>>   	data->wms =3D qmi_service_ref(service);
>>   =

>> +	memset(&data->rd_msg_id, 0, sizeof(data->rd_msg_id));
>> +	data->msg_mode =3D QMI_WMS_MESSAGE_MODE_GSMWCDMA;
>> +
>>   	qmi_service_register(data->wms, QMI_WMS_EVENT,
>>   					event_notify, sms, NULL);
>>   =

>
>Regards,
>-Denis

--===============8634154580865207271==--

