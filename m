Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089415217C
	for <ofono@lists.linux.dev>; Wed, 27 Mar 2024 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567905; cv=none; b=YF0i8VYUPARRq+GqO3tO8I4wwnD08H0hqUZ7Y/DwR62FVkQOo3KKtf+7CjfodQFaghyf7BueXEDuUp4KitJpnJYqAk8D9PGosuaelopWGd/iHa2t0VIQCq75VIBPYLUD3zLxtlqN6ZxjD+q1XY3735OR/zJKVeitw33LaeRonJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567905; c=relaxed/simple;
	bh=PtWawDNoGRPC04uOomejMfGyhVKWldixQeyw/+EqQC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZS/5BEbZybBh3YXpqDb4Mp257mLYMgzkKYuVeUca5Iv3McvGKMRu79SpaFWQGOHij/41hmS8JsZNRBOaO22gTro9NdDt+n9onpornPikcEH6PCQsUynsKWvgqNAcz+dctsgy5avtZNt0c3RPLU09lUeiQ3tbIE7h27oqX0jNgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkBvhPM0; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkBvhPM0"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c3ae53f662so122990b6e.3
        for <ofono@lists.linux.dev>; Wed, 27 Mar 2024 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711567903; x=1712172703; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wfu30z85H7yM2hHD6yGfEIuBuYx9JL9PBorSdW9Om/8=;
        b=dkBvhPM08lqlSWfR0GxXmOurGGLxbcrYY05TbgF0GbY8IJsCMgB+hHkWwG4vU82wq9
         AIUnFvGJOsIOK4fuJyLd9utO5layO7Q9zE3MP0exbzxeJDdew1IwXl5hsp1hSl/8LKak
         xX1hJ06XCZxUFYSHfAMIXcLzYuPrNDndUsh+caJiI1CPCOAq65s+Ca96u0CEoHNKlma+
         JQP5cTpTao+7Nq79g/b2OEdkaJo2uX9rvKybypHxNtii0gnfZy2nQ149fz9livdc7ruT
         U03kyvct2hqHWeu+qopRBc22aG9flLOgmEUCZIaEm6A+snHALjdHl5i8UsXXR2HqeP2S
         vJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711567903; x=1712172703;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfu30z85H7yM2hHD6yGfEIuBuYx9JL9PBorSdW9Om/8=;
        b=d9kxIdWQTYvwGQkWaB/eKSbJCuwbNS4lTFj1thmm04hsqZrgxnNuzacL8zShyjDoBG
         gnLOsLxXE+Alk3cQRFP8wWOY7Pl7yh3oVPigegC++t3cmcNDT5GihDm12VVP3smeFoSO
         RJnIy1zEbzsfhrAYTvg2sofnQh3of8tsr5tuq/QLzhG7hKUlG4BKdVAOjD7ZElM37rWG
         1N1NprC0+SCBRv6dj5tXnj5et5rJRPvA5GHOcz7s+CKr2ZWgSdT2cCrXirLxlKh2VYbO
         vvUZh14pI2fR8aY9ws0IaGDQWiKrlszKOKfP9ACOnmROv0AjqUGrd5ta2y3KzQ1URJTa
         Dapw==
X-Forwarded-Encrypted: i=1; AJvYcCXesRMo1iR5QzpkuVDhXAaT7FUm+ESSQlUXHtYP1xuEGIF2g6uFFjA+bYdri6agYim6OrZzZHK2FpvSiqhS73AzDNRpSK0=
X-Gm-Message-State: AOJu0YzHZ8Va5Rfy1mon1rrwoXniAaXjzG3epvjLw+/UbLCYdSlUYmn7
	fcr2fFF9kS6iL+e4nkzkLKi8GB7kzsU1omhk0vh3yFnjag17oWpsIktg/sBf
X-Google-Smtp-Source: AGHT+IHgbeJnD1dfVq9FbBQsomeBWZSXUoGw1bz3W8OQ26kyH+mj3mpODL6tgHApd7o4JRQMa776UQ==
X-Received: by 2002:a05:6808:3c8b:b0:3c3:9a11:c1b7 with SMTP id gs11-20020a0568083c8b00b003c39a11c1b7mr1302394oib.5.1711567901875;
        Wed, 27 Mar 2024 12:31:41 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id eo10-20020a056808440a00b003c37bb555c3sm2019372oib.22.2024.03.27.12.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:31:41 -0700 (PDT)
Message-ID: <14194773-71a3-47e5-b1e8-70e0c77ce304@gmail.com>
Date: Wed, 27 Mar 2024 14:31:40 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] [qmimodem][voicecall] Implement DTMF tones
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240326102054.30946-1-adam@piggz.co.uk>
 <20240326102054.30946-4-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240326102054.30946-4-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 3/26/24 05:19, Adam Pigg wrote:
> The send_dtmf function sets up a call to send_one_dtmf, which will call
> the QMI_VOICE_START_CONTINUOUS_DTMF service function.  The paramters to
> this call are a hard coded call-id and the DTMF character to send.
> start_cont_dtmf_cb will then be called which will set up a call to
> QMI_VOICE_STOP_CONTINUOUS_DTMF to stop the tone.  Finally,
> stop_cont_dtmf_cb will check the final status.
> ---
>   drivers/qmimodem/voice.h     |   6 ++
>   drivers/qmimodem/voicecall.c | 154 +++++++++++++++++++++++++++++++++++
>   2 files changed, 160 insertions(+)
> 

CI says:

0004-Implement-DTMF-tones.patch:7: WARNING: 'paramters' may be misspelled - 
perhaps 'parameters'?
0004-Implement-DTMF-tones.patch:110: WARNING: braces {} are not necessary for 
single statement blocks
0004-Implement-DTMF-tones.patch:114: WARNING: braces {} are not necessary for 
single statement blocks
0004-Implement-DTMF-tones.patch:177: WARNING: braces {} are not necessary for 
any arm of this statement

<snip>

> diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
> index 4ef8adc1..ab4bd655 100644
> --- a/drivers/qmimodem/voicecall.c
> +++ b/drivers/qmimodem/voicecall.c
> @@ -117,6 +117,21 @@ struct qmi_voice_end_call_result {
>   	uint8_t call_id;
>   };
>   
> +struct send_one_dtmf_cb_data {
> +	const char *full_dtmf;
> +	const char *next_dtmf;
> +	struct ofono_voicecall *vc;
> +};
> +
> +struct qmi_voice_start_cont_dtmf_arg {
> +	uint8_t call_id;
> +	uint8_t dtmf_char;
> +};
> +
> +struct qmi_voice_stop_cont_dtmf_arg {
> +	uint8_t call_id;
> +};
> +

The two arg structures can be removed, they don't really serve any purpose.

>   int ofono_call_compare(const void *a, const void *b, void *data)
>   {
>   	const struct ofono_call *ca = a;
> @@ -742,6 +757,144 @@ static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
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
> +}
> +
> +static void start_cont_dtmf_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	struct ofono_voicecall *vc = cbd->user;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct qmi_voice_stop_cont_dtmf_arg arg;
> +	uint16_t error;
> +	struct qmi_param *param = NULL;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	arg.call_id = 0xff;
> +
> +	param = qmi_param_new();
> +	if (!param) {
> +		goto error;
> +	}
> +
> +	if (!qmi_param_append_uint8(param, QMI_VOICE_DTMF_DATA, arg.call_id)) {
> +		goto error;
> +	}
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_STOP_CONTINUOUS_DTMF, param,
> +			     stop_cont_dtmf_cb, cbd, NULL) > 0) {
> +		return;
> +	}
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +	l_free(param);
> +}
> +
> +static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
> +			  ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct qmi_voice_start_cont_dtmf_arg arg;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct qmi_param *param = NULL;
> +	uint8_t param_body[2];
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +
> +	DBG("");
> +
> +	arg.call_id = 0xff;
> +	arg.dtmf_char = (uint8_t)dtmf;
> +
> +	cbd->user = vc;
> +
> +	param = qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	param_body[0] = arg.call_id;
> +	param_body[1] = arg.dtmf_char;
> +
> +	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, sizeof(param_body),
> +			      param_body)) {
> +		goto error;
> +	}
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_START_CONTINUOUS_DTMF, param,
> +			     start_cont_dtmf_cb, cbd, NULL) > 0) {
> +		return;
> +	}
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
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	struct send_one_dtmf_cb_data *send_one_dtmf_cb_data = cbd->user;
> +
> +	DBG("");
> +
> +	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
> +	    *send_one_dtmf_cb_data->next_dtmf == 0) {
> +		if (error->type == OFONO_ERROR_TYPE_NO_ERROR) {
> +			CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +		} else {
> +			CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		}

If any DTMF fails, you should return an error right away, cleaning up regardless.

Then, if it is the last entry, callback with success and cleanup.

Otherwise, send the next DTMF.

> +		l_free((void *)send_one_dtmf_cb_data->full_dtmf);
> +		l_free(send_one_dtmf_cb_data);
> +		l_free(cbd);
> +	} else {
> +		send_one_dtmf(send_one_dtmf_cb_data->vc,
> +			      *(send_one_dtmf_cb_data->next_dtmf++),
> +			      send_one_dtmf_cb, data);
> +	}
> +}
> +
> +static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
> +		      ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct send_one_dtmf_cb_data *send_one_dtmf_cb_data =
> +		l_new(struct send_one_dtmf_cb_data, 1);
> +
> +	DBG("");
> +
> +	send_one_dtmf_cb_data->full_dtmf = l_strdup(dtmf);

full_dtmf is declared const.  How are you freeing the string?

> +	send_one_dtmf_cb_data->next_dtmf = &send_one_dtmf_cb_data->full_dtmf[1];
> +	send_one_dtmf_cb_data->vc = vc;
> +	cbd->user = send_one_dtmf_cb_data;

cb_data is not setup to destroy cbd->user on unref.  So it is likely this 
structure is leaked on some of the code paths.  This is something we can add, 
for example by introducing a destroy member to struct cb_data.  However, it may 
be far easier to just put dtmf information into voicecall_data.

Have you looked into using 'Burst DTMF' instead of Start/Stop Continuous DTMF? 
Looks like that one takes a string.  Might be an easier implementation.

> +
> +	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, cbd);
> +}
> +
>   static void create_voice_cb(struct qmi_service *service, void *user_data)
>   {
>   	struct ofono_voicecall *vc = user_data;
> @@ -810,6 +963,7 @@ static const struct ofono_voicecall_driver driver = {
>   	.answer		= answer,
>   	.hangup_active  = hangup_active,
>   	.release_specific  = release_specific,
> +	.send_tones	= send_dtmf,
>   };
>   
>   OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)

Regards,
-Denis
