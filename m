Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43852745C2
	for <ofono@lists.linux.dev>; Thu,  4 Apr 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266385; cv=none; b=VUtojagMY+8KTkU4zjLuIXMtYHXqvsXKgUOf2nNxtEO59vs1wRK/rt1XdnmU8aNn5WTxJx5wMRPNaLRaGMMUlEiDdSwgNvl7UACsCsXk8vbXasGTUftXN3CG2W1AseanVOSyMNo4gpMdyvOPTfQTQ/Iy/VaaOzksmAKHW+JfhDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266385; c=relaxed/simple;
	bh=JGqFq3PQ7ToW1EuYz6b1yvwJvBa2Hb/gC1wO/XP/5CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f/dExEBol4pQKmlxe/TUqrEZJxI5cSWxSNCJi8gxtupt4U5KTEe5cHhb8mHjWJlFHs6OA9LlJwNmadHbEP6d32nABSOVKnWOqSGoYrWasW9CYNrk+0NsLPDbUvIAwy809dWIi3s04Dq7tT+X1u0m3sh9YyEZLHKTTfDoMGIQB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLD3AZIL; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLD3AZIL"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22a96054726so1218839fac.0
        for <ofono@lists.linux.dev>; Thu, 04 Apr 2024 14:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712266383; x=1712871183; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNySVZoifHWdRI1/lVBtg0CnxxmjkbzeMdqWW+Uzl0E=;
        b=TLD3AZILFgfrKYc0mc5AFplSJMTgWp8aNNjkUmvRsBwl/DzyYiOZYQBNVhdU9OP09g
         2P4ufEpkvZJU94Tx/86W5EFsVkdJQPRcE76qcFnsjumvtfsndImz/Ev1A9GJYO1X8MND
         sKE/1QgAY9/9Jv6I+gHyxywlQjPSL95E8d4rJ8tWmjnOQgQPrGRjmLjYhUtnzhg1Vhx7
         sIwPKwwLM3m8Wq75sFbUFEb274P9aBCKiga7I3o6qIM+ugRxbbbd+nhs9XYgg6yBuuZq
         0nhGM0BrDxEQfNqC+SIbVi5NjaQLyWJCn3oNaq9Bu4U18tRy2w2XPXgH2b3dBt3DhU/c
         sj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712266383; x=1712871183;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNySVZoifHWdRI1/lVBtg0CnxxmjkbzeMdqWW+Uzl0E=;
        b=u1Argij4PGPhv0oX/adGb4mLQYaNtz3+0LoyonrivoGRUuOOQpUK/ePKB+dluvpnVF
         ww7Ow9+cl2p03hGdkg6Prj907USBpkUtxb9HcFjC+ocwkEaDeAPoe8/Y/H7DNYomflDK
         pEQHJf56/HKCLYeGLoIgbB4XA9v+VAPmNXiZH0nucoTyzBg9Oxssgk0u2ia/3iGYJJ8i
         BIr/5Qkl1b0Tf4+1M6lct9/KZUzABxnSFzh0GaYo0N9sD8yJo3GbymMxakRnz6KTbPKj
         2Nic741DoOb/9wDVbAKPXdxZN07zPxhZf0BEwD4wuLcp+1Ti8/K84o/2hVyicGrPjYlc
         wIsw==
X-Forwarded-Encrypted: i=1; AJvYcCUHElXoCtb0zkDTBYXY2pHEhFpUgeR8iPp6EjUOJJnzXAlbo2kOCrv3kwjulBUxPvS1tfWHtdRdaH73V3jJsxaYkMj9Alk=
X-Gm-Message-State: AOJu0YyKZXFoK+hKDhA9+BQLu/1BmEPQ695tu3n0wosvMjWqI8izAtr6
	qU/PDXc5sg35fPy9DiJIeL38oEdu3F7xmb7Pyt+llB+PEz61PllV0ap6hWmJ
X-Google-Smtp-Source: AGHT+IH6tZoBD2uH9dn+nSOUUQN/CF4fRf8N9xBiNS/CNrdFmgkGywgv/vYlUSJaeppcxmW7PI8uwg==
X-Received: by 2002:a05:6870:f80b:b0:22e:c860:9a6a with SMTP id fr11-20020a056870f80b00b0022ec8609a6amr1713543oab.49.1712266383238;
        Thu, 04 Apr 2024 14:33:03 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id vp1-20020a056871a00100b0022a4444451dsm36416oab.13.2024.04.04.14.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 14:33:03 -0700 (PDT)
Message-ID: <fd97a5bd-b76b-4eaf-949a-e28ffb486868@gmail.com>
Date: Thu, 4 Apr 2024 16:33:02 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] qmimodem: voicecall: Implement DTMF tones
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240402212625.5348-1-adam@piggz.co.uk>
 <20240402212625.5348-4-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240402212625.5348-4-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/2/24 16:25, Adam Pigg wrote:
> The send_dtmf function sets up a call to send_one_dtmf, which will call
> the QMI_VOICE_START_CONTINUOUS_DTMF service function.  The paramters to

typo 'paramters'

> this call are a hard coded call-id and the DTMF character to send.
> start_cont_dtmf_cb will then be called which will set up a call to
> QMI_VOICE_STOP_CONTINUOUS_DTMF to stop the tone.  Finally,
> stop_cont_dtmf_cb will check the final status.
> ---
>   drivers/qmimodem/voice.h     |  12 ++++
>   drivers/qmimodem/voicecall.c | 131 +++++++++++++++++++++++++++++++++++
>   2 files changed, 143 insertions(+)
> 

<snip>

> +
> +enum parse_error {
> +	NONE = 0,
> +	MISSING_MANDATORY = 1,
> +	INVALID_LENGTH = 2,
> +};
> +

This enum isn't used?

>   struct qmi_ussd_data {
>   	uint8_t dcs;
>   	uint8_t length; > diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
> index 627719a8..4bdb64b7 100644
> --- a/drivers/qmimodem/voicecall.c
> +++ b/drivers/qmimodem/voicecall.c
> @@ -42,6 +42,8 @@ struct voicecall_data {
>   	uint16_t minor;
>   	struct l_queue *call_list;
>   	struct ofono_phone_number dialed;
> +	char *full_dtmf;
> +	char *next_dtmf;

next_dtmf can probably be a const char *.

>   };
>   
>   struct qmi_voice_all_call_status_ind {
> @@ -652,6 +654,134 @@ static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
>   	release_specific(vc, call->id, cb, data);
>   }
>   
> +static void stop_cont_dtmf_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +
> +	uint16_t error;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +	l_free(cbd);

Why is cbd freed only on the success path?  It looks like you're trying to reuse 
the cbd object between START and STOP commands.  Something like this, right?

cbd = l_new(..);
START_DTMF(cbd, start_callback);
start_callback: STOP_DTMF(cbd, stop_callback)
stop_callback: l_free(cbd)

The problem is that start_callback or stop_callback might never be invoked due 
to modem being un-plugged for example.  This is what the destroy callback is 
for, it makes sure to free the user data even if the callback is never called. 
Destroy callback is also invoked after invocation of the actual callback.

So you have two ways of carrying cbd between multiple qmi_send() instances:

1. cb_data_ref/cb_data_unref
2. Storing the 'send_dtmf' callback and callback data in struct voicecall_data

For 1, see drivers/qmimodem/sim.c query_passwd_state_retry()

For 2, you'd store the send_dtmf 'cb' and userdata inside struct voicecall_data 
and use 'vc' as userdata to qmi_send instead of cbd.

> +}
> +
> +static void start_cont_dtmf_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	struct ofono_voicecall *vc = cbd->user;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	uint16_t error;
> +	struct qmi_param *param = NULL;

Do not initialize unnecessarily.  The compiler is pretty good about warnings 
when an uninitialized variable is being used.

> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	param = qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	if (!qmi_param_append_uint8(param, QMI_VOICE_DTMF_DATA, 0xff))
> +		goto error;
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_STOP_CONTINUOUS_DTMF, param,
> +			     stop_cont_dtmf_cb, cbd, NULL) > 0)

See above about the use of cbd and destroy function

> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +	l_free(cbd);
> +	l_free(param);
> +}
> +
> +static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
> +				ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct qmi_param *param = NULL;
> +	uint8_t param_body[2];
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +
> +	DBG("");
> +
> +	cbd->user = vc;
> +
> +	param = qmi_param_new();
> +	if (!param)
> +		goto error;

No need for this check

> +
> +	param_body[0] = 0xff;
> +	param_body[1] = (uint8_t)dtmf;
> +
> +	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, sizeof(param_body),
> +			      param_body)) {
> +		goto error;
> +	}

No need for {}

> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_START_CONTINUOUS_DTMF, param,
> +			     start_cont_dtmf_cb, cbd, NULL) > 0) {

See above for discussion of cbd and destroy functions

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
> +static void send_one_dtmf_cb(const struct ofono_error *error, void *data)
> +{
> +	struct cb_data *cbd = data;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(cbd->user);
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +
> +	DBG("");
> +
> +	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
> +	    *vd->next_dtmf == 0) {
> +		if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
> +			CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +		else
> +			CALLBACK_WITH_FAILURE(cb, cbd->data);
> +
> +		l_free(vd->full_dtmf);

vd->full_dtmf = NULL;

> +		l_free(cbd);
> +	} else {
> +		send_one_dtmf(cbd->user,
> +				*(vd->next_dtmf++),
> +				send_one_dtmf_cb, data);
> +	}
> +}
> +
> +static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
> +		      ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +
> +	DBG("");
> +
> +	vd->full_dtmf = l_strdup(dtmf);

Should you be freeing full_dtmf first?  Just in case the previous dtmf request 
failed mid-way?

Make sure to free full_dtmf in .remove(), just in case the modem is pulled when 
the DTMF chars are being processed.

> +	vd->next_dtmf = &vd->full_dtmf[1];
> +
> +	cbd->user = vc;
> +
> +	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, cbd);
> +}
> +
>   static void create_voice_cb(struct qmi_service *service, void *user_data)
>   {
>   	struct ofono_voicecall *vc = user_data;

<snip>

Regards,
-Denis

