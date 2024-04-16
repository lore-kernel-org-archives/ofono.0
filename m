Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259310A14
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293822; cv=none; b=b2+fojWFoJweYpJxInPjGRUTiJ/XS9vLTqaeTW17KrtExB3pYfzNe/5DO2Bqb7bH6ExUCVA0vQyt9TKJg5S4f9PvpLiKmAhwAvBc9DYzkmyq4/0al7EbmH0y19Q7m05L7KP9Q62mI1mdBWIqLkx8EweJmQ560epXDJP33q+IBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293822; c=relaxed/simple;
	bh=iHsdH57bFe8pCuZ7wSYxBVN8dBn19cKAVGZtlZdZXEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UQO7QQ7F2wicwje6qumbBNoSDDPCdbbx7xoj4PAixEUC8YzBZce4hScVzccUD3a8D9kyY2OiT+baOxmWQx4y17SFpDii445jinKkY9G4DJ/PTglgsOUrl3z0Z3pNZUaOrb8dJmihpjYb4o4YUK2MgRRvQptr6uP27ByHMODB86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNJ4/u/1; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNJ4/u/1"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6eb55942409so2890902a34.1
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713293820; x=1713898620; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drPjX3JFjqzwS7xUeEpsKcadjX9if3mrzPAsTV6L5jY=;
        b=XNJ4/u/1TU95DAYo/o5YoY/T0M9fvpGfj1cCcNnwPccutVb20RPTM2j1hAWJoqf5Or
         h7QuXhaU2X9sYIKJytgQttrVc/QabTnDT6NGmeurcm8wrCarWolVHrRMTPu0LnY/Tqec
         AYL9xMVxpmCaDxD0bdq9EqAUT/Is41uLqcv96I3+2xV27PeHoczsxj3SZoN/l9zJg32o
         nK0afTuUeujKyKJZG0NbDxm6zqitNrL2zAiHCH7woiXQP1BjBQ76+uAoHoX73v1Bt7W2
         ORMZkYqNcHoMDhE2N3NmczwRvyIrjrYrMAQRogkUaiEzaBTC7kWjyiqsWTArzT+xLJu2
         1ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293820; x=1713898620;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drPjX3JFjqzwS7xUeEpsKcadjX9if3mrzPAsTV6L5jY=;
        b=Xb6EtKWoGf2mVcCgLDishSsdRC1uY77Eu6vO6xyvjw1BCqdQZyAysEbMJ6PMj7YCkk
         U/njyj+4cnpXbZGCI+WeS7Ins1CV58C90Cy/gd5nXt96RrDQ4hnv0CiWa/VYdL70sMyn
         WkTZhFHXd8QUgvYSgRw8tKDRrz+O16FfIrThU3qozwYPNcLvHqX7ruSEis3vNUHNXgtw
         CHeRIVVQgJZD2eFcD1/rvCZzKolGgS5SGgmM1X5aT9qiFNKrNhkyru2wnDqnDZ2ctCO9
         GURaqjWZp1HuePAiSCqRmi03Li9JykQG7xCHhqWMizLHf+Sr0gx6F7HJ8a/lmPhaq5Q7
         xXsg==
X-Forwarded-Encrypted: i=1; AJvYcCX7F/8vOoc9K4T02mfq/JZ0Y2a8sUKFytmEARo3qeO0U0Gtoc/IZBvy5+2HvrEFMIBnwv3+WgplCz8Re0DV2ty2NnN46+g=
X-Gm-Message-State: AOJu0YyFovvAu6ApjuJwqK5SeltZVSSUKTFy9Ab5m6uCgww3xKU6pua/
	PIPXbDr4MEzJGG7A/ZIHB+G+NYMFri4PdmpaC47//ZNLtTfFzUbw
X-Google-Smtp-Source: AGHT+IE5P1irmAVRsTe/xc6tF/CVzIlDmskjinNfB3SJKVuni4uTr8709shsnjKa7V/Q4HcvwJfSGw==
X-Received: by 2002:a05:6808:1a:b0:3c5:ed36:ff96 with SMTP id u26-20020a056808001a00b003c5ed36ff96mr12766169oic.56.1713293819942;
        Tue, 16 Apr 2024 11:56:59 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a4-20020aca1a04000000b003c7119f4512sm872587oia.54.2024.04.16.11.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 11:56:59 -0700 (PDT)
Message-ID: <67c20c6e-2879-4e83-a371-6a1127d431dc@gmail.com>
Date: Tue, 16 Apr 2024 13:56:58 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] qmimodem: voicecall: Implement DTMF tones
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240413215318.12236-1-adam@piggz.co.uk>
 <20240413215318.12236-4-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240413215318.12236-4-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/13/24 16:53, Adam Pigg wrote:
> The send_dtmf function sets up a call to send_one_dtmf, which will call
> the QMI_VOICE_START_CONTINUOUS_DTMF service function.  The parameters to
> this call are a hard coded call-id and the DTMF character to send.
> start_cont_dtmf_cb will then be called which will set up a call to
> QMI_VOICE_STOP_CONTINUOUS_DTMF to stop the tone.  Finally,
> stop_cont_dtmf_cb will check the final status.
> 
> ---
> Changes in V4
> -Removed unused enum
> -Minor formatting fixes
> -Ensure data->full_dtmf is free'd
> -Use cb_data_ref/unref between chains of dtmf calls
> ---
> ---
>   drivers/qmimodem/voice.h     |   6 ++
>   drivers/qmimodem/voicecall.c | 131 +++++++++++++++++++++++++++++++++++
>   2 files changed, 137 insertions(+)
> 

<snip>

> @@ -614,6 +616,133 @@ static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
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

This looks wrong.  When invoking QMI_VOICE_STOP_CONTINUOUS_DTMF, you use 
cb_data_unref as the destroy function.  The destroy invocation should take care 
of cbd.

> +}
> +
> +static void start_cont_dtmf_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	struct ofono_voicecall *vc = cbd->user;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	uint16_t error;
> +	struct qmi_param *param;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;

This is called with cbd, and hopefully in all cases cbd->ref == 1 at this point 
with the destroy callback being cb_data_unref.  Once this function returns, 
destroy is called and cbd is freed correctly.  This looks good.

> +	}
> +
> +	param = qmi_param_new();
> +
> +	if (!qmi_param_append_uint8(param, QMI_VOICE_DTMF_DATA, 0xff))
> +		goto error;
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_STOP_CONTINUOUS_DTMF, param,
> +			stop_cont_dtmf_cb, cbd, cb_data_unref) > 0) {
> +		cb_data_ref(cbd);
> +		return;

On the success path, we take another ref to cbd (so cbd->ref == 2).  Once we 
return, destroy is called and cbd->ref is back down to 1.

> +	}
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, cbd->data); > +	l_free(cbd);

On the error path, this isn't necessary at all.  cbd->ref should be 1, and once 
this function returns, cb_data_unref should free cbd.

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
> +	cb_data_ref(cbd);

No need to take a ref here, cb_data_new creates cbd with ref==1.

> +
> +	param = qmi_param_new();
> +
> +	param_body[0] = 0xff;
> +	param_body[1] = (uint8_t)dtmf;
> +
> +	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, sizeof(param_body),
> +			param_body))
> +		goto error;
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_START_CONTINUOUS_DTMF, param,
> +			start_cont_dtmf_cb, cbd, cb_data_unref) > 0)
> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	l_free(cbd);
> +	l_free(param);
> +}
> +

So you have two types of cb_data objects:
1. The one you create in send_dtmf() that contains the callback to ofono core
2. The one you create here that contains the callback to send_one_dtmf_cb and 
pointer to 1.

The 2nd cbd goes through the following callbacks:

send_one_dtmf -> ref: 1
start_cont_dtmf_cb -> take ref to 2 on success, in all cases unref is called 
when this function returns
stop_cont_dtmf -> ref: 1, unref is called when this function returns

Note that you still might leak the object in 1 if the DTMF is interrupted 
mid-execution.  For example upon voicecall atom removal.

> +static void send_one_dtmf_cb(const struct ofono_error *error, void *data)
> +{
> +	struct cb_data *cbd = data;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(cbd->user);
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +
> +	DBG("");
> +
> +	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
> +			*vd->next_dtmf == 0) {
> +		if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
> +			CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +		else
> +			CALLBACK_WITH_FAILURE(cb, cbd->data);
> +
> +		l_free(vd->full_dtmf);
> +		vd->full_dtmf = NULL;
> +		l_free(cbd);
> +	} else {
> +		send_one_dtmf(cbd->user,
> +				*(vd->next_dtmf++),
> +				send_one_dtmf_cb, data);
> +	}
> +}
> +
> +static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd = cb_data_new(cb, data);

Hmm, you alloc cb_data_new here which creates cbd with 1 ref

> +
> +	DBG("");
> +
> +	l_free(vd->full_dtmf);
> +	vd->full_dtmf = l_strdup(dtmf);
> +	vd->next_dtmf = &vd->full_dtmf[1];
> +
> +	cbd->user = vc;
> +
> +	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, cbd);

Then here, cbd is refed again.  There's likely a leak?

You're much safer storing 'cb' and 'data' inside struct voicecall_data (as 
send_dtmf_cb and send_dtmf_data).

> +}
> +
>   static void create_voice_cb(struct qmi_service *service, void *user_data)
>   {
>   	struct ofono_voicecall *vc = user_data;

Regards,
-Denis
