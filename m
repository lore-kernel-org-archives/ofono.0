Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93BF14D458
	for <ofono@lists.linux.dev>; Wed, 27 Mar 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564372; cv=none; b=TDH60Hk44h+Xa6vc30MiYnpunppjLqE11n6Sr8q0bIKUHB3kpQsJIcPGYhq4AM1oZTniC5FQPlj9fYfkyirpGHKVz1XxiANtz2GWzL/TuAly8Lo11Fp5x2CwEpYPwaUXHCFjSZerXLfP6/D4/zIVM8sX2Ub6EH5r0p6DRYSie+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564372; c=relaxed/simple;
	bh=1v9+wKOGlUPmGSD7zS+IJkga2DxxlqJq74BKMzwezCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SXeIunCoXx5Bmjz4JO1osjb/q+VXzfORxySTBDFc8E9Kem/lI+mm1Z4DzjsYPKQyl+/yaFzWIY2bZOfgMIUZt8i83vduOvigFEr8qeyTKteJpaBxwsjjtqXLmI3osL43HjdW3R5ezWFp3UplJq7Gd5vHyyy/ahyzQ1qs22P6JuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9dViwIj; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9dViwIj"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a46abf093cso55085eaf.2
        for <ofono@lists.linux.dev>; Wed, 27 Mar 2024 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711564370; x=1712169170; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XztKfsIYOoYxt3pqmxenqz58rgeQ+7g94c9ouyldH/k=;
        b=Q9dViwIjq7unVC+puaLmxzcPlwZJ0j8/0ya2WTw9woBRmaEMUKTg0fellnvcYDCHln
         nlnoFgZQA+9mM0ARBBUNroQwk4ity/RIsyYtuN4wiZdwCy7WE/oX+/XPET0sdQMlH2NL
         dz81O3/xblHGwgVO9KimUWdZd2gUGRwY9grnmyrqkgndR4olRTcWp4RTW64ze7kYNk1X
         Iv20xtMtuJH6sqOMXCrmS5iYPUjCvgdXvmqASFrIHP3IesvBWoRRN77lSO49xwDUVFay
         JkA4zyuXKfUyrTpMJ+K7r2yJIAowYCYO0Dm0TQt1FRZotzb9TEZDnpH8pLNjSd46yduI
         4H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711564370; x=1712169170;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XztKfsIYOoYxt3pqmxenqz58rgeQ+7g94c9ouyldH/k=;
        b=UNWKVHjZzJTIHXMgCPfm5H7mTUhJEJTA/eA/VoYnj7r0XW8YykWGwCtY7vLbvtKwOg
         hUf92dZbSI97VG2adr+1pwO66s3Fy9mMCKLYTjpf+PpK2+UxnQ3F7qc0rdo9ZNWTULG+
         P/Dry/d2I4zkhteRFTDPK2JlMqahIPU4Fg/jI9vPcN9kuLgZnv628Kqrq3SIsd8J1FyL
         cYBzC6U7luAj9eI1krvIt752Z4+i090Ek7N1RJlYD9T3jcL9tAWB0FE4VbcLSEPCIqfp
         /31Hf2Ub9p2CCZTGcwcWTQM9BIcqA64xgwX5Vw69LJTayQq/JK4jzOF8ptiyx5vwnH+o
         yxDA==
X-Forwarded-Encrypted: i=1; AJvYcCXq/dcZWO/xqStfiQSzqtTO/KUWFhqfrfQBN1v1DT9V1OOc1viNqQ3ZWICgsO4FicgbFrt1TysmI/U6doX0Z9UNQsRiBjM=
X-Gm-Message-State: AOJu0Yxo45wstB84bdrAwk/b/eWccoYjJ7VC9s32hlRCv6myEb3gfSGs
	L8GO0LWLV77y4iPrY+GZ67nzsDpt83UN4KlFXi6GwUyoPkCL9QqGcgkBQDAC
X-Google-Smtp-Source: AGHT+IGZrgnlrshUiUSiD3+pBKRiuwANPYA7qRkyimTjq8PJUltIVoVyl2qvcNZ+hM2UTG2LDQMhQg==
X-Received: by 2002:a05:6820:2904:b0:5a5:639a:2fb0 with SMTP id dp4-20020a056820290400b005a5639a2fb0mr496995oob.7.1711564369458;
        Wed, 27 Mar 2024 11:32:49 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bx8-20020a4ae908000000b005a4c3d44cadsm1228516oob.38.2024.03.27.11.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 11:32:49 -0700 (PDT)
Message-ID: <c9c9aef1-be51-48c5-b3c0-63cdc906f834@gmail.com>
Date: Wed, 27 Mar 2024 13:32:48 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] [qmimodem][voicecall] Implement call dialing
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240326102054.30946-1-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240326102054.30946-1-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 3/26/24 05:19, Adam Pigg wrote:
> Add voicecall dialling to the qmimodem driver
> Includes required infratructure and setup of the QMI services
> 
> Call State Handling
> ===================
> On initialisation, register the all_call_status_ind callback to be
> called for QMI_VOICE_IND_ALL_STATUS.  This will handle notificatiof of
> call status to the rest of the system
> 
> Dial Handling
> =============
> The dial function sets up the parameters for the QMI_VOICE_DIAL_CALL
> service.  The parameters are the number to be called and the call type,
> which is currently hard coded to be QMI_VOICE_CALL_TYPE_VOICE.  The
> dial_cb callback wi then be called and will receive the call-id.
> ---
>   drivers/qmimodem/voice.h     |  51 ++++
>   drivers/qmimodem/voicecall.c | 503 ++++++++++++++++++++++++++++++++++-
>   2 files changed, 553 insertions(+), 1 deletion(-)

Looking better! I have a bunch of feedback, but it is not exhaustive, so just be 
prepared for more rounds in the future :)

First minor thing is the commit naming conventions, oFono usually uses the 
following:
<modem driver>:<atom>: <description> or
<modem driver>: <description>

So in your case:

qmimodem: voicecall: Implement call dialing ... or
qmi: voice: Implement call dialing ... or
qmimodem: Implement call dialing

I find all three acceptable.

Another thing, please fix your editor not to indent to opening brace or mix tabs 
and spaces.  We only use tabs for indentation.  I'll point out a few examples later.

Your submission doesn't compile without warnings, so that's another thing to 
address for future submissions:

     drivers/qmimodem/voicecall.c:135:5: error: no previous declaration for 
'ofono_call_compare' [-Werror=missing-declarations]
       135 | int ofono_call_compare(const void *a, const void *b, void *data)
           |     ^~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:149:6: error: no previous declaration for 
'ofono_call_compare_by_status' [-Werror=missing-declarations]
       149 | bool ofono_call_compare_by_status(const void *a, const void *b)
           |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:157:6: error: no previous declaration for 
'ofono_call_compare_by_id' [-Werror=missing-declarations]
       157 | bool ofono_call_compare_by_id(const void *a, const void *b)
           |      ^~~~~~~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:165:6: error: no previous declaration for 
'ofono_call_list_dial_callback' [-Werror=missing-declarations]
       165 | void ofono_call_list_dial_callback(struct ofono_voicecall *vc,
           |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:193:6: error: no previous declaration for 
'ofono_call_list_notify' [-Werror=missing-declarations]
       193 | void ofono_call_list_notify(struct ofono_voicecall *vc,
           |      ^~~~~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:252:13: error: no previous declaration for 
'qmi_voice_call_state_name' [-Werror=missing-declarations]
       252 | const char *qmi_voice_call_state_name(enum qmi_voice_call_state value)
           |             ^~~~~~~~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:270:5: error: no previous declaration for 
'qmi_to_ofono_status' [-Werror=missing-declarations]
       270 | int qmi_to_ofono_status(uint8_t status, int *ret)
           |     ^~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:308:9: error: no previous declaration for 
'ofono_to_qmi_direction' [-Werror=missing-declarations]
       308 | uint8_t ofono_to_qmi_direction(enum call_direction ofono_direction)
           |         ^~~~~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:312:21: error: no previous declaration for 
'qmi_to_ofono_direction' [-Werror=missing-declarations]
       312 | enum call_direction qmi_to_ofono_direction(uint8_t qmi_direction)
           |                     ^~~~~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:472:1: error: no previous declaration for 
'qmi_voice_dial_call_parse' [-Werror=missing-declarations]
       472 | qmi_voice_dial_call_parse(struct qmi_result *qmi_result,
           | ^~~~~~~~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:571:18: error: no previous declaration for 
'qmi_voice_answer_call_parse' [-Werror=missing-declarations]
       571 | enum parse_error qmi_voice_answer_call_parse(
           |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c:660:1: error: no previous declaration for 
'qmi_voice_end_call_parse' [-Werror=missing-declarations]
       660 | qmi_voice_end_call_parse(struct qmi_result *qmi_result,
           | ^~~~~~~~~~~~~~~~~~~~~~~~
     drivers/qmimodem/voicecall.c: In function 'hangup_active':
     drivers/qmimodem/voicecall.c:743:23: error: comparison of integer 
expressions of different signedness: 'int' and 'long unsigned int' 
[-Werror=sign-compare]
       743 |         for (i = 0; i < L_ARRAY_SIZE(active); i++) {
           |                       ^

CI also reported some issues:

0001-Implement-call-dialing.patch:154: WARNING: externs should be avoided in .c 
files
0001-Implement-call-dialing.patch:165: WARNING: 'als' may be misspelled - 
perhaps 'also'?
0001-Implement-call-dialing.patch:238: WARNING: braces {} are not necessary for 
single statement blocks
0001-Implement-call-dialing.patch:292: WARNING: braces {} are not necessary for 
single statement blocks
0001-Implement-call-dialing.patch:310: WARNING: Macros with flow control 
statements should be avoided
0001-Implement-call-dialing.patch:437: WARNING: braces {} are not necessary for 
any arm of this statement
0001-Implement-call-dialing.patch:482: WARNING: 'informations' may be misspelled 
- perhaps 'information'?

Now, lets get to the review:

> 
> diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
> index 917e72f7..1a584f10 100644
> --- a/drivers/qmimodem/voice.h
> +++ b/drivers/qmimodem/voice.h
> @@ -15,6 +15,8 @@
>    *
>    */
>   
> +#include <stdint.h>
> +

This probably belongs in drivers/qmimodem/voicecall.c itself.  Rule of thumb is 
that internal headers such as wds.h, wms.h, voice.h etc should not have any 
system includes.

>   #define QMI_VOICE_PARAM_USS_DATA 0x01
>   
>   #define QMI_VOICE_PARAM_ASYNC_USSD_ERROR 0x10
> @@ -25,6 +27,9 @@
>   #define QMI_VOICE_PARAM_USSD_IND_DATA 0x10
>   #define QMI_VOICE_PARAM_USSD_IND_UCS2 0x11
>   
> +#define QMI_VOICE_IND_ALL_STATUS 0x2e
> +#define QMI_VOICE_GET_ALL_STATUS 0x2f

Probably belongs in voice_commands enum below.

> +
>   /* according to GSM TS 23.038 section 5
>    * coding group 1111, No message class, 8 bit data
>    */

<snip>

> +
> +enum qmi_voice_call_dial_param {
> +	QMI_VOICE_DIAL_CALL_NUMBER = 0x01,
> +	QMI_VOICE_DIAL_CALL_TYPE = 0x10

The other files inside qmimodem/ use #defines for this.  For example:

#define QMI_DMS_PARAM_REPORT_PIN_STATUS         0x12    /* bool */

Similarly, all RESULT TLVs have '_RESULT_' in the #define name.

Sticking to that convention would be more preferred.

An even more preferred approach would be to avoid definiting enumerations in the 
header file completely.  Typically the enumeration is only used in a single 
function, i.e. the parser or builder for the reqesult/request.  In that case, 
use a static const variable in the function itself.  See
drivers/qmimodem/network-registration.c, set_event_report_cb() for an example. 
The advantage of the above approach is that you have all relevant definitions 
very close to the actual use location and are not tripping over sentence sized 
enumeration names.

> +};
> +
> +enum qmi_voice_call_dial_return {
> +	QMI_VOICE_DIAL_RETURN_CALL_ID = 0x10
> +};
> +
> +enum qmi_voice_all_call_status_commands {

This enum is for the TLV types included in the result, no?  If so, see above 
about naming.

> +	QMI_VOICE_ALL_CALL_STATUS_CALL_INFORMATION = 0x01,
> +	QMI_VOICE_ALL_CALL_STATUS_REMOTE_NUMBER = 0x10
> +};
> +
> +enum qmi_voice_all_call_info_commands {
> +	QMI_VOICE_ALL_CALL_INFO_CALL_INFORMATION = 0x10,
> +	QMI_VOICE_ALL_CALL_INFO_REMOTE_NUMBER = 0x11
> +};
> +
> +enum qmi_voice_call_type {
> +	QMI_VOICE_CALL_TYPE_VOICE = 0x0,
> +	QMI_VOICE_CALL_TYPE_VOICE_FORCE,
> +};
> +
> +enum parse_error {
> +	NONE = 0,
> +	MISSING_MANDATORY = 1,
> +	INVALID_LENGTH = 2,
> +};
> +

Use errno.h for this:
err = 0 -> ok
err = -EINVAL or -EBADMSG -> missing mandatory
err = -EMSGSIZE -> invalid length

>   struct qmi_ussd_data {
>   	uint8_t dcs;
>   	uint8_t length;
> @@ -98,3 +148,4 @@ enum qmi_ss_reason {
>   	QMI_VOICE_SS_RSN_CLIP =			0x10,
>   	QMI_VOICE_SS_RSN_CLIR =			0x11
>   };
> +

No empty lines at EOF please, my git settings refuse to apply it.

<snip>

> @@ -35,8 +40,499 @@ struct voicecall_data {
>   	struct qmi_service *voice;
>   	uint16_t major;
>   	uint16_t minor;
> +	struct l_queue *call_list;
> +	struct voicecall_static *vs;

This member isn't used?

> +	struct ofono_phone_number dialed;
> +};
> +
> +struct qmi_voice_all_call_status_ind {
> +	bool call_information_set;
> +	const struct qmi_voice_call_information *call_information;
> +	bool remote_party_number_set;
> +	uint8_t remote_party_number_size;
> +	const struct qmi_voice_remote_party_number_instance
> +		*remote_party_number[16];
> +};
> +
> +enum parse_error
> +qmi_voice_call_status(struct qmi_result *qmi_result,
> +		      struct qmi_voice_all_call_status_ind *result);

This function isn't exported, so this declaration isn't necessary.

> +
> +struct qmi_voice_call_information_instance {
> +	uint8_t id;
> +	uint8_t state;
> +	uint8_t type;
> +	uint8_t direction;
> +	uint8_t mode;
> +	uint8_t multipart_indicator;
> +	uint8_t als;
> +} __attribute__((__packed__));
> +
> +struct qmi_voice_call_information {
> +	uint8_t size;
> +	struct qmi_voice_call_information_instance instance[0];
> +} __attribute__((__packed__));
> +
> +struct qmi_voice_remote_party_number_instance {
> +	uint8_t call_id;
> +	uint8_t presentation_indicator;
> +	uint8_t number_size;
> +	char number[0];
> +} __attribute__((__packed__));
> +
> +struct qmi_voice_remote_party_number {
> +	uint8_t size;
> +	struct qmi_voice_remote_party_number_instance instance[0];
> +} __attribute__((__packed__));
> +
> +struct qmi_voice_dial_call_arg {
> +	bool calling_number_set;
> +	const char *calling_number;
> +	bool call_type_set;
> +	uint8_t call_type;
> +};

This structure is not needed, get rid of it.

> +
> +struct qmi_voice_dial_call_result {
> +	bool call_id_set;
> +	uint8_t call_id;
>   };
>   
> +int ofono_call_compare(const void *a, const void *b, void *data)

static?

> +{
> +	const struct ofono_call *ca = a;
> +	const struct ofono_call *cb = b;
> +
> +	if (ca->id < cb->id)
> +		return -1;
> +
> +	if (ca->id > cb->id)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +bool ofono_call_compare_by_status(const void *a, const void *b)

static ?

> +{
> +	const struct ofono_call *call = a;
> +	int status = L_PTR_TO_INT(b);
> +
> +	return status == call->status;
> +}
> +
> +bool ofono_call_compare_by_id(const void *a, const void *b)

static?

> +{
> +	const struct ofono_call *call = a;
> +	unsigned int id = L_PTR_TO_UINT(b);
> +
> +	return (call->id == id);
> +}
> +
> +void ofono_call_list_dial_callback(struct ofono_voicecall *vc,

static void..

> +				   struct l_queue **call_list,

A single pointer is enough...

> +				   const struct ofono_phone_number *ph,
> +				   int call_id)
> +{
> +	struct ofono_call *call;
> +
> +	/* check if call_id already present */
> +	call = l_queue_find(*call_list, ofono_call_compare_by_id,
> +			    L_UINT_TO_PTR(call_id));
> +
> +	if (call) {
> +		return;
> +	}

See the CI complaining about this.  Single statement blocks don't need {}

> +
> +	call = l_new(struct ofono_call, 1);
> +	call->id = call_id;
> +
> +	memcpy(&call->called_number, ph, sizeof(*ph));
> +	call->direction = CALL_DIRECTION_MOBILE_ORIGINATED;
> +	call->status = CALL_STATUS_DIALING;
> +	call->type = 0; /* voice */
> +
> +	l_queue_insert(*call_list, call, ofono_call_compare, NULL);
> +
> +	ofono_voicecall_notify(vc, call);
> +}
> +
> +void ofono_call_list_notify(struct ofono_voicecall *vc,
> +			    struct l_queue **call_list, struct l_queue *calls) > +{
> +	struct l_queue *old_calls = *call_list;
> +	struct l_queue *new_calls = calls;
> +	struct ofono_call *new_call, *old_call;
> +	const struct l_queue_entry *old_entry, *new_entry;
> +
> +	uint loop_length =
> +		MAX(l_queue_length(old_calls), l_queue_length(new_calls));
> +
> +	old_entry = l_queue_get_entries(old_calls);
> +	new_entry = l_queue_get_entries(new_calls);
> +
> +	for (uint i = 0; i < loop_length; ++i) {
> +		old_call = old_entry ? old_entry->data : NULL;
> +		new_call = new_entry ? new_entry->data : NULL;
> +
> +		if (new_call && new_call->status == CALL_STATUS_DISCONNECTED) {
> +			ofono_voicecall_disconnected(
> +				vc, new_call->id,
> +				OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
> +
> +			l_queue_remove(calls, new_call);
> +			l_free(new_call);
> +			continue;
> +		}
> +
> +		if (old_call &&
> +		    (new_call == NULL || (new_call->id > old_call->id))) {
> +			ofono_voicecall_disconnected(
> +				vc, old_call->id,
> +				OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
> +		} else if (new_call && (old_call == NULL ||
> +					(new_call->id < old_call->id))) {
> +			DBG("Notify new call %d", new_call->id);
> +			/* new call, signal it */
> +			if (new_call->type == 0) {
> +				ofono_voicecall_notify(vc, new_call);
> +			}

No need for {}

> +		} else {
> +			if (memcmp(new_call, old_call, sizeof(*new_call)) &&
> +			    new_call->type == 0)

Please fix your editor, oFono uses tabs for indentation

> +				ofono_voicecall_notify(vc, new_call);
> +		}
> +		if (old_entry)
> +			old_entry = old_entry->next;
> +		if (new_entry)
> +			new_entry = new_entry->next;
> +	}
> +
> +	l_queue_destroy(*call_list, l_free);
> +	*call_list = calls;
> +}
> +

<snip>

> +int qmi_to_ofono_status(uint8_t status, int *ret)

There are two acceptable ways to return success/error status from functions:

bool -> false on error, true on success
int -> 0 is success, -ERRNO (-EINVAL) on error.

I suspect using bool here would be better

> +{
> +	int err = 0;
> +
> +	switch (status) {
> +	case QMI_VOICE_CALL_STATE_IDLE:
> +	case QMI_VOICE_CALL_STATE_END:
> +	case QMI_VOICE_CALL_STATE_DISCONNECTING:
> +		*ret = CALL_STATUS_DISCONNECTED;
> +		break;
> +	case QMI_VOICE_CALL_STATE_HOLD:
> +		*ret = CALL_STATUS_HELD;
> +		break;
> +	case QMI_VOICE_CALL_STATE_WAITING:
> +		*ret = CALL_STATUS_WAITING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_ORIG:
> +		*ret = CALL_STATUS_DIALING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_SETUP:
> +	case QMI_VOICE_CALL_STATE_INCOMING:
> +		*ret = CALL_STATUS_INCOMING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_CONV:
> +		*ret = CALL_STATUS_ACTIVE;
> +		break;
> +	case QMI_VOICE_CALL_STATE_CC_IN_PROG:
> +		*ret = CALL_STATUS_DIALING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_ALERTING:
> +		*ret = CALL_STATUS_ALERTING;
> +		break;
> +	default:
> +		err = 1;
> +	}
> +	return err;
> +}
> +

<snip>

> +enum parse_error
> +qmi_voice_call_status(struct qmi_result *qmi_result,
> +		      struct qmi_voice_all_call_status_ind *result)

Similar to the above comment, use an int return here

> +{
> +	int err = NONE;
> +	int offset;
> +	uint16_t len;
> +	bool status = true;
> +	const struct qmi_voice_remote_party_number *remote_party_number;
> +	const struct qmi_voice_call_information *call_information;
> +
> +	/* mandatory */
> +	call_information = qmi_result_get(
> +		qmi_result, QMI_VOICE_ALL_CALL_STATUS_CALL_INFORMATION, &len);
> +
> +	/* This is so ugly! but TLV for indicator and response is different */
> +	if (!call_information) {
> +		call_information = qmi_result_get(
> +			qmi_result, QMI_VOICE_ALL_CALL_INFO_CALL_INFORMATION,
> +			&len);
> +		status = false;
> +	}
> +
> +	if (call_information) {
> +		/* verify the length */
> +		if (len < sizeof(call_information->size))
> +			return INVALID_LENGTH;
> +
> +		if (len != call_information->size *
> +			sizeof(struct qmi_voice_call_information_instance) +
> +			sizeof(call_information->size)) {
> +			return INVALID_LENGTH;
> +		}
> +		result->call_information_set = 1;
> +		result->call_information = call_information;
> +	} else
> +		return MISSING_MANDATORY;
> +
> +	/* mandatory */
> +	remote_party_number = qmi_result_get(
> +		qmi_result,
> +		status ? QMI_VOICE_ALL_CALL_STATUS_REMOTE_NUMBER :
> +			 QMI_VOICE_ALL_CALL_INFO_REMOTE_NUMBER,
> +		&len);
> +
> +	if (remote_party_number) {
> +		const struct qmi_voice_remote_party_number_instance *instance;
> +		int instance_size =
> +			sizeof(struct qmi_voice_remote_party_number_instance);
> +		int i;
> +
> +		/* verify the length */
> +		if (len < sizeof(remote_party_number->size))
> +			return INVALID_LENGTH;
> +
> +		for (i = 0, offset = sizeof(remote_party_number->size);
> +		     offset <= len && i < 16 && i < remote_party_number->size;
> +		     i++) {
> +			if (offset == len) {
> +				break;
> +			} else if (offset + instance_size > len) {
> +				return INVALID_LENGTH;
> +			}
> +
> +			instance = (void *)remote_party_number + offset;
> +			result->remote_party_number[i] = instance;
> +			offset +=
> +				sizeof(struct qmi_voice_remote_party_number_instance) +
> +				instance->number_size;
> +		}
> +		result->remote_party_number_set = 1;
> +		result->remote_party_number_size = remote_party_number->size;
> +	} else
> +		return MISSING_MANDATORY;
> +
> +	return err;
> +}
> +
> +static void all_call_status_ind(struct qmi_result *result, void *user_data)
> +{
> +	struct ofono_voicecall *vc = user_data;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct l_queue *calls = NULL;
> +	int i;
> +	int size = 0;
> +	struct qmi_voice_all_call_status_ind status_ind;
> +
> +	calls = l_queue_new();

Might as well move initialization up to the definition.

> +
> +	DBG("");
> +	if (qmi_voice_call_status(result, &status_ind) != NONE) {
> +		DBG("Parsing of all call status indication failed");
> +		return;

You're leaking memory allocated to calls here.  If the queue contents are to be 
freed with l_free, you can do something like:

static void queue_destroy_free(void *p)
{
	struct l_queue *q = *(void **) p;
	l_queue_destroy(q, l_free);
}

_auto_(queue_desroy_free) struct l_queue *calls = l_queue_new() instead.

> +	}
> +
> +	if (!status_ind.remote_party_number_set ||
> +	    !status_ind.call_information_set) {

Another case of your editor indenting incorrectly

> +		DBG("Some required fields are not set");
> +		return;
> +	}
> +
> +	size = status_ind.call_information->size;
> +	if (!size) {
> +		DBG("No call informations received!");
> +		return;
> +	}
> +
> +	/* expect we have valid fields for every call */
> +	if (size != status_ind.remote_party_number_size) {
> +		DBG("Not all fields have the same size");
> +		return;
> +	}
> +
> +	for (i = 0; i < size; i++) {
> +		struct qmi_voice_call_information_instance call_info;
> +		struct ofono_call *call;
> +		const struct qmi_voice_remote_party_number_instance
> +			*remote_party = status_ind.remote_party_number[i];
> +		int number_size;
> +
> +		call_info = status_ind.call_information->instance[i];
> +		call = l_new(struct ofono_call, 1);
> +		call->id = call_info.id;
> +		call->direction = qmi_to_ofono_direction(call_info.direction);
> +
> +		if (qmi_to_ofono_status(call_info.state, &call->status)) {
> +			DBG("Ignore call id %d, because can not convert QMI state 0x%x to ofono.",
> +			    call_info.id, call_info.state);
> +			continue;

Leaking call here?

> +		}
> +		DBG("Call %d in state %s(%d)", call_info.id,
> +		    qmi_voice_call_state_name(call_info.state),
> +		    call_info.state);
> +
> +		call->type = 0; /* always voice */
> +		number_size = remote_party->number_size;
> +		if (number_size > OFONO_MAX_PHONE_NUMBER_LENGTH)
> +			number_size = OFONO_MAX_PHONE_NUMBER_LENGTH;
> +		strncpy(call->phone_number.number, remote_party->number,
> +			number_size);

Use l_strlcpy instead of strncpy.  Otherwise you must take care of null 
terminating.  Refer to man strncpy to understand why.

> +		/* FIXME: set phone_number_type */
> +
> +		if (strlen(call->phone_number.number) > 0)
> +			call->clip_validity = 0;
> +		else
> +			call->clip_validity = 2;
> +
> +		l_queue_push_tail(calls, call);
> +		DBG("%d", l_queue_length(calls));
> +	}
> +
> +	ofono_call_list_notify(vc, &vd->call_list, calls);

Leaking calls here even on the success path...

> +}
> +
> +enum parse_errorstatic int qmi_voice_dial..
> +qmi_voice_dial_call_parse(struct qmi_result *qmi_result,
> +			  struct qmi_voice_dial_call_result *result)
This structure and the corresponding definition seem useless if they're only 
used between dial_cb and this parser helper.  Inlining the contents inside 
dial_cb would seem to be cleaner.
> +{
> +	int err = NONE;
> +
> +	/* mandatory */
> +	if (qmi_result_get_uint8(qmi_result, QMI_VOICE_DIAL_RETURN_CALL_ID,
> +				 &result->call_id))
> +		result->call_id_set = 1;
> +	else
> +		err = MISSING_MANDATORY;
> +
> +	return err;
> +}
> +
> +static void dial_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	struct ofono_voicecall *vc = cbd->user;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	uint16_t error;
> +	struct qmi_voice_dial_call_result dial_result;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	if (qmi_voice_dial_call_parse(result, &dial_result) != NONE) {
> +		DBG("Received invalid Result");
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	if (!dial_result.call_id_set) {
> +		DBG("Didn't receive a call id");
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	DBG("New call QMI id %d", dial_result.call_id);
> +	ofono_call_list_dial_callback(vc, &vd->call_list, &vd->dialed,

You're passing vc to this function, it can easily obtain the call list via 
ofono_voicecall_get_data(vc);

> +				      dial_result.call_id); > +
> +	/* FIXME: create a timeout on this call_id */

What's this about?

> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +static void dial(struct ofono_voicecall *vc,
> +		 const struct ofono_phone_number *ph,
> +		 enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
> +		 void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct qmi_voice_dial_call_arg arg;

This structure doesn't seem to serve any purpose?  You can fill out the 
qmi_param information based solely on the passed in arguments.

> +	struct qmi_param *param = NULL;

Don't initialize variables unnecessarily.  The compiler will warn if you're 
using an uninitialized variable.

> +
> +	DBG("");
> +
> +	cbd->user = vc;
> +	arg.calling_number_set = true;
> +	arg.calling_number = phone_number_to_string(ph);
> +	memcpy(&vd->dialed, ph, sizeof(*ph));
> +
> +	arg.call_type_set = true;
> +	arg.call_type = QMI_VOICE_CALL_TYPE_VOICE;
> +
> +	param = qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	if (arg.calling_number_set) {
> +		if (!qmi_param_append(param, QMI_VOICE_DIAL_CALL_NUMBER,
> +				      strlen(arg.calling_number),
> +				      arg.calling_number)) {
> +			goto error;
> +		}
> +	}
> +
> +	if (arg.call_type_set)
> +		qmi_param_append_uint8(param, QMI_VOICE_DIAL_CALL_TYPE,
> +				       arg.call_type);
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_DIAL_CALL, param, dial_cb,
> +			     cbd, l_free) > 0) {
> +		return;
> +	}

No need for {}

> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	l_free(cbd);
> +	l_free(param);
> +}
> +
>   static void create_voice_cb(struct qmi_service *service, void *user_data)
>   {
>   	struct ofono_voicecall *vc = user_data;
> @@ -58,6 +554,9 @@ static void create_voice_cb(struct qmi_service *service, void *user_data)
>   
>   	data->voice = qmi_service_ref(service);
>   
> +	qmi_service_register(data->voice, QMI_VOICE_IND_ALL_STATUS,
> +			     all_call_status_ind, vc, NULL);
> +
>   	ofono_voicecall_register(vc);
>   }
>   
> @@ -70,6 +569,7 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
>   	DBG("");
>   
>   	data = l_new(struct voicecall_data, 1);
> +	data->call_list = l_queue_new();
>   
>   	ofono_voicecall_set_data(vc, data);
>   
> @@ -77,7 +577,6 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
>   					create_voice_cb, vc, NULL);
>   
>   	return 0;
> -
>   }
>   
>   static void qmi_voicecall_remove(struct ofono_voicecall *vc)
> @@ -98,7 +597,9 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
>   static const struct ofono_voicecall_driver driver = {
>   	.probe		= qmi_voicecall_probe,
>   	.remove		= qmi_voicecall_remove,
> +	.dial		= dial,
>   };
>   
>   OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
>   
> +

No empty lines at EOF please.
