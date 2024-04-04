Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF71292CE
	for <ofono@lists.linux.dev>; Thu,  4 Apr 2024 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263430; cv=none; b=mwaqOtvlQ4GV29Y6dH0LDlBd0EOBloxousAEyJ8KaQJKIQvDh9lUhsEbUpUV2DZ7ySGarVXSmgRVhunkchwICov71nXsH4eGmuGiltZmvh9nBUhwhuj6iXbw5/DuqVU7gokLLMiIqRg2ZzMMUe7aAsp3+bEYZYF9/0BGfqE5LXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263430; c=relaxed/simple;
	bh=gyXWtxMxMrzmDslSDk3Pn+BDMR9pHH/r3NQXHfzP9yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FicrZLo62TYcLGiScDVOWDBNftilp12UbOK+kbWTVsGy91VN9w0CraYiPvcBymZfPRQeZ1+6DEff/AI08ag99Pw6V+lzXbuxOKnN4baB9g+LtCa3Wpxn5cYe5zJKdr+XBZuT3tahg7aW1VKUpGyYUdNGcCOgVoWVOCQrvulAREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4h+PEkv; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4h+PEkv"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22988692021so573008fac.1
        for <ofono@lists.linux.dev>; Thu, 04 Apr 2024 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712263428; x=1712868228; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wU4qqSFEL8gsC+z4I9jQ3mNRcDQXbJ9O0PPWoh6pFk=;
        b=h4h+PEkv+ZXBR++Me2ZjdLTZoPMv9so/TU4EoYQqQAWPcEhpE2VVDit5HMlKhhn5sR
         i0qbM82OjM9Mxy+59Ij4jwrhgaDO+Hi6i+rLdI3f79agc+yhEgX+7Fup0ry6lXDNiWAv
         hoQ+QjR7TwQ4d5JJO695qs8Vas5AuRTpBY7sGA815/+XP/WwzhR6d7DI2F8qgGGUVlFs
         m1gmyzCD2Ig8J6+rTZGEgvBftEUm/JvvKBK/e/TghxPyTv0QGvMu5R0pINWR38OK3c9A
         lyGk2JLugKtBoDhSUWLfaktarY9JoIkBc6ycHvYqV+GqPKLFr05Qkk+9qbs6E11cTKRA
         q6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263428; x=1712868228;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wU4qqSFEL8gsC+z4I9jQ3mNRcDQXbJ9O0PPWoh6pFk=;
        b=U+0MOvWHUSOlxTyd1hDIAvJAnBDfhjJlhIFiagKgvI2Csr0zRhNckeV3fZNp3zJBHN
         OLef8DqXApdvAT4lgiXJXiEuAzMGaiRfahbMppHMCgNa6o1mgDxSxSHglHtuJovHHuLK
         kuECttIrqsKDyDrTenyW9wqnAmXQQMybYBU24+M6ngsVDpo1TiiJgrQfiTfA58n6LZxf
         m/26pfTw0wPqVgHxwXeHphr2zImCyV9nlrZdHJvLfu4ytQpWvc0mXH7hVNtZFrsB1nlx
         8wKBaRRhdL/pcdUzXi2yrv0Q8ddQTocRSbsBWqaGd5nyeLZ4N+WjJYI0ojaCDb9s71N7
         Op5A==
X-Forwarded-Encrypted: i=1; AJvYcCXDPsQPGxqVDn1TEAItVKDinNq40ol8PPCM2dUIyJ/iBRbbQyefxmzSfJtJOzznILmp3m9ot6WDbCXxZZSpLitGw6ETxHo=
X-Gm-Message-State: AOJu0Ywh6ZbeGEC5QfbPRfGWy82tjrxDF5fmlyxlpR+HFpkrC2Y6Ppov
	R0bfsHG9mQffP7WlGmxA6tucVODE2GgjUoahA72Xc1CZZA/Ou6+b
X-Google-Smtp-Source: AGHT+IFE9EI2ZpEbOQIxblOqr1OKrtGwyPPl/NRovLG5sQru0HT52MK+m4510bKlSKwxe6sQDoGxUw==
X-Received: by 2002:a05:6870:1641:b0:22a:a01f:c90a with SMTP id c1-20020a056870164100b0022aa01fc90amr287108oae.21.1712263427946;
        Thu, 04 Apr 2024 13:43:47 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v14-20020a0568301bce00b006e8766a6670sm31764ota.17.2024.04.04.13.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 13:43:47 -0700 (PDT)
Message-ID: <d79f7d16-9c77-4359-833f-0d6b3c1f1b36@gmail.com>
Date: Thu, 4 Apr 2024 15:43:46 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] qmimodem: voicecall: Implement call dialing
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240402212625.5348-1-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240402212625.5348-1-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Adam,

On 4/2/24 16:25, Adam Pigg wrote:
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
>   drivers/qmimodem/voice.h     |  17 ++
>   drivers/qmimodem/voicecall.c | 479 ++++++++++++++++++++++++++++++++++-
>   2 files changed, 495 insertions(+), 1 deletion(-)
> 

<snip>

Couple of general comments:

- There's still an empty line @ EOF in this commit, please fix that.
- After applying just this patch, compilation fails:

[denkenz@archdev ofono]$ make
make --no-print-directory all-am
   CC       drivers/qmimodem/voicecall.o
drivers/qmimodem/voicecall.c: In function ‘all_call_status_ind’:
drivers/qmimodem/voicecall.c:355:32: error: unused variable ‘vd’ 
[-Werror=unused-variable]
   355 |         struct voicecall_data *vd = ofono_voicecall_get_data(vc);
       |                                ^~
drivers/qmimodem/voicecall.c: At top level:
drivers/qmimodem/voicecall.c:262:16: error: ‘ofono_to_qmi_direction’ defined but 
not used [-Werror=unused-function]
   262 | static uint8_t ofono_to_qmi_direction(enum call_direction ofono_direction)
       |                ^~~~~~~~~~~~~~~~~~~~~~
drivers/qmimodem/voicecall.c:97:13: error: ‘ofono_call_compare_by_status’ 
defined but not used [-Werror=unused-function]
    97 | static bool ofono_call_compare_by_status(const void *a, const void *b)
       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [Makefile:4094: drivers/qmimodem/voicecall.o] Error 1
make: *** [Makefile:2402: all] Error 2

Ideally, each patch should compile and run cleanly to help with 'git bisect'.

<snip>

> +
> +static bool ofono_call_compare_by_status(const void *a, const void *b)
> +{
> +	const struct ofono_call *call = a;
> +	int status = L_PTR_TO_INT(b);
> +
> +	return status == call->status;
> +}
> +

This function belongs in patch 2.  It isn't used in this commit and is causing a 
compiler warning / error.

<snip>

> +static uint8_t ofono_to_qmi_direction(enum call_direction ofono_direction)
> +{
> +	return ofono_direction + 1;
> +}

This function isn't used, get rid of it

<snip>

> +static int qmi_voice_call_status(struct qmi_result *qmi_result,
> +					struct qmi_voice_all_call_status_ind *result)

Right now you have this function producing an intermediate structure which 
points to memory owned by struct qmi_result and is only valid as long as 
qmi_result is valid.  all_call_status_ind() then converts this intermediate 
structure into an l_queue with ofono_call objects.  The intermediate structure 
is never needed after or used elsewhere.  No other caller uses this intermediate 
structure.

Have you thought about having this function return an allocated l_queue with 
ofono_call objects as contents instead and getting rid of struct 
qmi_voice_all_call_status_ind completely?

> +{
> +	int offset;
> +	uint16_t len;
> +	bool status = true;
> +	const struct qmi_voice_remote_party_number *remote_party_number;
> +	const struct qmi_voice_call_information *call_information;
> +
> +	static const uint8_t QMI_VOICE_ALL_CALL_STATUS_CALL_INFORMATION = 0x01;
> +	static const uint8_t QMI_VOICE_ALL_CALL_STATUS_REMOTE_NUMBER = 0x10;
> +	static const uint8_t QMI_VOICE_ALL_CALL_INFO_CALL_INFORMATION = 0x10;
> +	static const uint8_t QMI_VOICE_ALL_CALL_INFO_REMOTE_NUMBER = 0x11;
> +
> +	/* mandatory */
> +	call_information = qmi_result_get(
> +		qmi_result, QMI_VOICE_ALL_CALL_STATUS_CALL_INFORMATION, &len);
> +
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
> +			return -EMSGSIZE;
> +
> +		if (len !=
> +			call_information->size *
> +			sizeof(struct qmi_voice_call_information_instance) +
> +			sizeof(call_information->size))
> +			return -EMSGSIZE;

doc/coding-style.txt item M4

> +
> +		result->call_information_set = 1;
> +		result->call_information = call_information;
> +	} else
> +		return -EBADMSG;

Easier to bail early and not nest or need the if condition:

if (!call_information)
	return -EBADMSG;

if (len < sizeof(call_information->size))
	return -EMSGSIZE;

...

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
> +			return -EMSGSIZE;
> +
> +		for (i = 0, offset = sizeof(remote_party_number->size);
> +			offset <= len && i < 16 && i < remote_party_number->size;
> +			i++) {
> +			if (offset == len)
> +				break;
> +			else if (offset + instance_size > len)
> +				return -EMSGSIZE;
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
> +		return -EBADMSG;

Same here:

if (!remote_party_number)
	return -EBADMSG;

if (len < ...)

for (...)

See doc/coding-style.txt item O2

> +
> +	return 0;
> +}
> +
> +static void all_call_status_ind(struct qmi_result *result, void *user_data)
> +{
> +	struct ofono_voicecall *vc = user_data;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct l_queue *calls = l_queue_new();
> +	int i;
> +	int size = 0;
> +	struct qmi_voice_all_call_status_ind status_ind;
> +
> +	DBG("");

doc/coding-style.txt Item M1

> +	if (qmi_voice_call_status(result, &status_ind) != 0) {

nit: Prefer < 0 check for functions that return -errno.

> +		DBG("Parsing of all call status indication failed");
> +		goto error;
> +	}
> +
> +	if (!status_ind.remote_party_number_set ||
> +	    !status_ind.call_information_set) {

Incorrect indentation

> +		DBG("Some required fields are not set");
> +		goto error;
> +	}
> +
> +	size = status_ind.call_information->size;
> +	if (!size) {
> +		DBG("No call informations received!");
> +		goto error;
> +	}
> +
> +	/* expect we have valid fields for every call */
> +	if (size != status_ind.remote_party_number_size) {
> +		DBG("Not all fields have the same size");
> +		goto error;
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
> +				call_info.id, call_info.state);
> +			l_free(call);
> +			continue;
> +		}
> +		DBG("Call %d in state %s(%d)", call_info.id,
> +			qmi_voice_call_state_name(call_info.state),
> +			call_info.state);
> +
> +		call->type = 0; /* always voice */
> +		number_size = remote_party->number_size + 1;
> +		if (number_size > OFONO_MAX_PHONE_NUMBER_LENGTH)
> +			number_size = OFONO_MAX_PHONE_NUMBER_LENGTH;
> +		l_strlcpy(call->phone_number.number, remote_party->number,
> +				number_size);
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
> +	ofono_call_list_notify(vc, calls);
> +
> +	return;
> +error:
> +	l_queue_destroy(calls, l_free);
> +}
> +
> +static void dial_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	struct ofono_voicecall *vc = cbd->user;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	uint16_t error;
> +	uint8_t call_id;
> +	bool call_id_set = false;
> +
> +	static const uint8_t QMI_VOICE_DIAL_RESULT_CALL_ID = 0x10;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	if (qmi_result_get_uint8(result, QMI_VOICE_DIAL_RESULT_CALL_ID,
> +					&call_id))
> +		call_id_set = true;
> +	else {
> +		DBG("Received invalid Result");
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	if (!call_id_set) {
> +		DBG("Didn't receive a call id");
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}

This if looks like a dead branch.  The only way call_id_set is false here is if 
qmi_result_get_uint8 earlier failed.  In fact, the above section can be 
rewritten as:

if (!qmi_result_get_uint8(...)) {
	ofono_error("No call id in dial result");
	CALLBACK_WITH_FAILURE(...);
	return;
}

No need for call_id_set variable either.

> +
> +	DBG("New call QMI id %d", call_id);
> +	ofono_call_list_dial_callback(vc, call_id);
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +

<snip>

> +static void dial(struct ofono_voicecall *vc,
> +			const struct ofono_phone_number *ph,
> +			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
> +			void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct qmi_param *param;
> +	const char *calling_number = phone_number_to_string(ph);
> +
> +	static const uint8_t QMI_VOICE_DIAL_CALL_NUMBER = 0x01;
> +	static const uint8_t QMI_VOICE_DIAL_CALL_TYPE = 0x10;
> +	static const uint8_t QMI_VOICE_CALL_TYPE_VOICE = 0x00;
> +
> +	DBG("");
> +
> +	cbd->user = vc;
> +	memcpy(&vd->dialed, ph, sizeof(*ph));
> +
> +	param = qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	if (!qmi_param_append(param, QMI_VOICE_DIAL_CALL_NUMBER,
> +				strlen(calling_number), calling_number)) {
> +		goto error;
> +	}

No need for {}

> +
> +	qmi_param_append_uint8(param, QMI_VOICE_DIAL_CALL_TYPE,
> +				QMI_VOICE_CALL_TYPE_VOICE);
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_DIAL_CALL, param, dial_cb,
> +				cbd, l_free) > 0)
> +		return;
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

<snip>

> @@ -92,13 +566,16 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
>   
>   	qmi_service_unref(data->voice);
>   
> +	l_queue_destroy(data->call_list, l_free);
>   	l_free(data);
>   }
>   
>   static const struct ofono_voicecall_driver driver = {
>   	.probe		= qmi_voicecall_probe,
>   	.remove		= qmi_voicecall_remove,
> +	.dial		= dial,
>   };
>   
>   OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
>   
> +

Empty line at EOF I mentioned earlier is here

Regards,
-Denis
