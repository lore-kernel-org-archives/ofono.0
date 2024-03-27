Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0512A144
	for <ofono@lists.linux.dev>; Wed, 27 Mar 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565356; cv=none; b=YZUIqDq3d4bg/4NNHOxKyQ2cC15Ve+dfvq/Ro1iqbzQeVvCUjjPbIPI2eer0Go25hICi9pAYV+dLjM903rLxImO8TRu8ndxz6CSyFBW+W42HlWvnAscjt7fej1IFwvNiwyZMPQA/wtbLrEKximg/mb+Lg8xl4hQPKdbxTtrEBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565356; c=relaxed/simple;
	bh=QF7Jpfv5bYRKFZbod6EiprP12691eTV4dMA3hDrmCJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b6YPfws1n34pXSICMGLjcvxIB3QVDPH9AGdy6Y12KxCWUu3/0ro1tu+8ODFxC+ThRuEnySZlLR5W4GZ8lSiSiepifqpLY2G0ssHL2L3kj9yAfnNRzAaYZ3CdNvlr1Ka4IEYDRmIKRCYh4WLoAWhAKyxwywovERy6mX7c8M+S7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cstOt5kg; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cstOt5kg"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3d859f8e6so127836b6e.3
        for <ofono@lists.linux.dev>; Wed, 27 Mar 2024 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711565353; x=1712170153; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3M8pi+Cohg6yr9N6QlMmLW1T2UoYcxTrW0tRpAl6p/M=;
        b=cstOt5kg9lhp+k2K6mO6W6JHmauqrjTkrJSUYGccCRujpi3jNuwnxNp4rchBQLTyl5
         fp81evjHw5/NCYdVtkIS2iOn2MpHSCnamAhl3vwSCUZe4/jVOnv9VqdFyIZONnObNOJn
         VL1EZDTeLmH+qRF2uB6bKteValPV1BMyaJ+Ud5NRJhbpRVpDipnvEwQhDySybNe9KKEl
         VKk3bS6kmC3HIkQX6AdsP65luFnqs3wjL5UyBvYfCZE1V0dr3AxefYd6hv8xmrTRCzuh
         wPCfGTPQqhoPtnIDxEQbEskLUkLXk9qmrKNTSs5LG3Pn9sztWm0aejrb+0rFPYrPBSqx
         p/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711565353; x=1712170153;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3M8pi+Cohg6yr9N6QlMmLW1T2UoYcxTrW0tRpAl6p/M=;
        b=LlTgTcQ2bHJKxrcxbw9h0Jli8FsG3k5cAHTMiMuB3Mxc/Hl6dxOTtwGQhy+bAxZTp7
         /zZKqif7vkZ0pXfc+aoimz1+BcnJDMQ+UNHmUzaliR3C83tpj9ROfrlegAgD9YKwRnV0
         9fSmK51UfFR8Fs1JD7NKW/tWpSaw61BvbVl7CQ+10/r9KvRRLekyZAyKG8nuy6nI+zbo
         CWrxDENndxF/psPP4Dhwo95DqXjDYhxi1/wBzOhxhQbBOmkIbdNybJGWYV5GwyiO0Vf9
         tfDXUmbyRvlX1EQUE84cuy8GQGbWy3qK352cZ9Obvtt5SHwnYv3Actkuq474sSBU1Oxr
         Yc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeIflyKiYVdJ//EhMKgV5ISfD3E/bJKFtx0wF2msdpK2/FkT1G1lP4DAGITZEWUtUX4UyEta649JNSpcQypAtx5EkO7XI=
X-Gm-Message-State: AOJu0YxD/Pr3Cc/SsGCCNmXISvJXGaiZKBMHu0O+xJI/Esg0piwtliZS
	kfeA420EsEp8ahiOfMdgWleqG/DaZInegsvO3OJBS2eQrp0EvASk
X-Google-Smtp-Source: AGHT+IEAgYeOzTfDRkwI5ol5nTdwbAZI8Zq2i63izjXz8pGm+CjFFS6Tiw+mcFTtIeuk+aN0e3vEFg==
X-Received: by 2002:a05:6808:f92:b0:3c3:7edd:bf84 with SMTP id o18-20020a0568080f9200b003c37eddbf84mr857666oiw.35.1711565353596;
        Wed, 27 Mar 2024 11:49:13 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t20-20020a056808159400b003c3da413c60sm682473oiw.28.2024.03.27.11.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 11:49:13 -0700 (PDT)
Message-ID: <bf102436-3ae7-42b5-b23c-5e6fcb87b150@gmail.com>
Date: Wed, 27 Mar 2024 13:49:12 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] [qmimodem][voicecall] Implement active call hangup
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240326102054.30946-1-adam@piggz.co.uk>
 <20240326102054.30946-3-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240326102054.30946-3-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 3/26/24 05:19, Adam Pigg wrote:
> hangup_active iterates the current list of calls, looking for the first
> active call and then calls release_specific.  This then sets up the
> parameters for a call to QMI_VOICE_END_CALL, with the only paramters
> being the call-id.
> 
> end_call_cb will then be called and will parse out the call-id and check
> for success.
> ---
>   drivers/qmimodem/voice.h     |   9 +++
>   drivers/qmimodem/voicecall.c | 113 +++++++++++++++++++++++++++++++++++
>   2 files changed, 122 insertions(+)
> 

Reported by CI:
0003-Implement-active-call-hangup.patch:8: WARNING: 'paramters' may be 
misspelled - perhaps 'parameters'?
0003-Implement-active-call-hangup.patch:124: WARNING: braces {} are not 
necessary for single statement blocks

<snip>

> diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
> index 7c6bc113..4ef8adc1 100644
> --- a/drivers/qmimodem/voicecall.c
> +++ b/drivers/qmimodem/voicecall.c
> @@ -107,6 +107,16 @@ struct qmi_voice_answer_call_result {
>   	uint8_t call_id;
>   };
>   
> +struct qmi_voice_end_call_arg {
> +	bool call_id_set;
> +	uint8_t call_id;
> +};
> +
> +struct qmi_voice_end_call_result {
> +	bool call_id_set;
> +	uint8_t call_id;
> +};

Again, totally unneeded structures.

> +
>   int ofono_call_compare(const void *a, const void *b, void *data)
>   {
>   	const struct ofono_call *ca = a;
> @@ -631,6 +641,107 @@ error:
>   	l_free(param);
>   }
>   
> +enum parse_error
> +qmi_voice_end_call_parse(struct qmi_result *qmi_result,
> +			 struct qmi_voice_end_call_result *result)
> +{
> +	int err = NONE;
> +
> +	/* optional */
> +	if (qmi_result_get_uint8(qmi_result, QMI_VOICE_END_RETURN_CALL_ID, &result->call_id))
> +		result->call_id_set = 1;
> +

inline this in the end_call_cb

> +	return err;
> +}
> +
> +static void end_call_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	uint16_t error;
> +	struct qmi_voice_end_call_result end_result;
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	if (qmi_voice_end_call_parse(result, &end_result) != NONE) {

This function doesn't actually fail, so again, is this block even needed?

> +		DBG("Received invalid Result");
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +static void release_specific(struct ofono_voicecall *vc, int id,
> +		     ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct qmi_voice_end_call_arg arg;
> +	struct qmi_param *param = NULL;
> +
> +	DBG("");
> +	cbd->user = vc;
> +
> +	arg.call_id_set = true;
> +	arg.call_id = id;

Fill out qmi_param directly, no need for this intermediate arg structure.

> +
> +	param = qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	if (arg.call_id_set) {
> +		if (!qmi_param_append_uint8(param, QMI_VOICE_END_CALL_ID, arg.call_id)) {
> +			goto error;
> +		}
> +	}
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_END_CALL, param, end_call_cb, cbd, l_free) >
> +	    0) {
> +		return;
> +	}
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	l_free(cbd);
> +	l_free(param);
> +}
> +
> +static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
> +			  void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct ofono_call *call;
> +	enum call_status active[] = {
> +		CALL_STATUS_ACTIVE,
> +		CALL_STATUS_DIALING,
> +		CALL_STATUS_ALERTING,
> +		CALL_STATUS_INCOMING,
> +	};
> +	int i;
> +
> +	DBG("");
> +	for (i = 0; i < L_ARRAY_SIZE(active); i++) {
> +		call = l_queue_find(vd->call_list, ofono_call_compare_by_status,
> +				    L_INT_TO_PTR(active[i]));
> +
> +		if (call)
> +			break;
> +	}

Might be easier to do something like:

const struct l_queue_entry *entry;

for (entry = l_queue_get_entries(vd->call_list); entry; entry = entry->next) {
	struct ofono_call *call = entry->data;

	if (L_IN_SET(call->status, CALL_STATUS_ACTIVE,
			CALL_STATUS_DIALING,
			CALL_STATUS_ALERTING,
			CALL_STATUS_INCOMING)) {
		release_specific(vc, call->id, cb, data);
		return;
	}
}

DBG("Can not find...");
CALLBACK_WITH_FAILURE(...);

> +
> +	if (call == NULL) {
> +		DBG("Can not find a call to hang up");
> +		CALLBACK_WITH_FAILURE(cb, data);
> +		return;
> +	}
> +
> +	release_specific(vc, call->id, cb, data);
> +}
> +
>   static void create_voice_cb(struct qmi_service *service, void *user_data)
>   {
>   	struct ofono_voicecall *vc = user_data;
> @@ -697,6 +808,8 @@ static const struct ofono_voicecall_driver driver = {
>   	.remove		= qmi_voicecall_remove,
>   	.dial		= dial,
>   	.answer		= answer,
> +	.hangup_active  = hangup_active,
> +	.release_specific  = release_specific,
>   };
>   
>   OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)

Regards,
-Denis
