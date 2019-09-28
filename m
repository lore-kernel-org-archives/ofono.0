Content-Type: multipart/mixed; boundary="===============3331238590479366011=="
MIME-Version: 1.0
From: Tom Nguyen <tomirq@earthlink.net>
Subject: Re: [PATCH v3] qmimodem: support wake on SMS receive
Date: Sat, 28 Sep 2019 01:48:39 +0000
Message-ID: <1507338948.2591.1559746007437@wamui-aurora.atl.sa.earthlink.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3331238590479366011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>From: Tom Nguyen
>
>Hi Denis,
>
>>From: Denis Kenzior =

>>
>>Hi Tom,
>>
>>On 05/23/2019 01:15 PM, Tom Nguyen wrote:
>>> Some modems, like Quectel EC25, support waking the host platform from a=
 suspend state upon an SMS reception. Current SMS handling configures the m=
odem to not save incoming messages. On platforms where the modem's interfac=
es (eg, cdc-wdm, wwan, etc) disconnect on suspend and reconnect on resume, =
oFono will re-initialize. This can cause lost messages upon resume because =
the QMI indication is sent before oFono is ready.
>>
>>Note, the commit description should be broken up with no line longer =

>>than 72 characters.
>>
>>> =

>>> Changes to support suspend/resume with wake on SMS:
>>> - On startup:
>>>    1. Configure modem to save messages to NV and notify for class NONE.
>>>    2. Delete all processed messages in modem memory to free space.
>>>    3. Get list of unread messages, then get and delete each.
>>> - After startup:
>>>    1. Process message upon event indication and delete.
>>>    2. Then check for possibly more messages to process.
>>> ---
>>>   drivers/qmimodem/sms.c | 327 ++++++++++++++++++++++++++++++++++++++++=
---------
>>>   drivers/qmimodem/wms.h |  77 +++++++++---
>>>   2 files changed, 332 insertions(+), 72 deletions(-)
>>> =


<snip>

>>>   static void event_notify(struct qmi_result *result, void *user_data) =
@@ -367,66 +575,72 @@ static void event_notify(struct qmi_result *result, v=
oid *user_data)
>>>   	struct ofono_sms *sms =3D user_data;
>>>   	struct sms_data *data =3D ofono_sms_get_data(sms);
>>>   	const struct qmi_wms_result_new_msg_notify *notify;
>>> -	const struct qmi_wms_result_message *message;
>>> -	uint16_t len;
>>>   =

>>>   	DBG("");
>>>   =

>>> -	notify =3D qmi_result_get(result, QMI_WMS_RESULT_NEW_MSG_NOTIFY, &len=
);
>>> +	notify =3D qmi_result_get(result, QMI_WMS_RESULT_NEW_MSG_NOTIFY, NULL=
);
>>>   	if (notify) {
>>> -		DBG("storage type %d index %d", notify->storage_type,
>>> -				GUINT32_FROM_LE(notify->storage_index));
>>> -	}
>>> +		/* route is store and notify */
>>> +		if (!qmi_result_get_uint8(result, QMI_WMS_RESULT_MSG_MODE,
>>> +				&data->msg_mode))
>>> +			DBG("msg mode not found, use mode %d", data->msg_mode);
>>> +
>>> +		DBG("msg type %d ndx %d mode %d", notify->storage_type,
>>> +			GUINT32_FROM_LE(notify->storage_index), data->msg_mode);
>>> +
>>> +		/* don't read if list is being processed, will find this msg */
>>> +		if (!data->msg_list_chk)
>>> +			raw_read(sms, notify->storage_type,
>>> +					GUINT32_FROM_LE(notify->storage_index));
>>
>>So I'm not familiar with QMI enough to truly know what is happening. =

>>But it looks like you are changing the logic slightly in this function. =

>>Before it would attempt to grab the QMI_WMS_RESULT_NEW_MSG_NOTIFY =

>>structure only for debug purposes, and instead attempt to grab the =

>>QMI_WMS_RESULT_MESSAGE in all cases.  If the QMI_WMS_RESULT_MESSAGE was =

>>not present, then the raw-read stuff would be triggered.  You're doing =

>>it slightly differently here.  It may be worth a comment.
>>
>>Also, it may be clearer if the introduction of raw_read and the =

>>refactoring of this function are done as a separate commit.
>>
>
>Hmm, looking at the "Quectel EC21" comment again, looks like the original =
code was done to address a quirk (ie, bug???) with that modem. I'll revert =
to reading both.
>
>But, per spec, the 2 message TLVs are mutually exclusive, depending on the=
 route action configuration. I'm referring to setting "new_list->route[0].a=
ction =3D" in get_routes_cb(). So, we shouldn't need to always read both si=
nce one is guaranteed to fail.
>
>Also, the original code, if somehow both "notify" and "message" are NULL, =
it'll erroneously use a null notify. I'll address this in the revert.
>

On 2nd thought, my change is still ok per that "Quectel EC21" comment. I'll=
 keep my changes and add comment to explain the 2 TLV that are being querie=
d. Also, I introduced raw_read because I need to pull QMI_WMS_RAW_READ out =
of event_notify to service both event_notify and the message list. So, I'd =
like to keep this in the same commit.

Thanks,
Tom

--===============3331238590479366011==--

