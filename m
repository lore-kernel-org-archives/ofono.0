Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6A32189
	for <ofono@lists.linux.dev>; Wed, 27 Mar 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564711; cv=none; b=ql+hZtjW4pAuVGLxp8od58iO1H6lqUoWQf1TgSJRaBlVivCcZJuwjLSHmsdOGrj5bsb727E4HpczLjPFEmfb8NiJuV1t/mTu06Ch2fTUmhldxY6V6mEGhSwTAawzGIuuvWaS12HNrJQBbeVh5oq4RG0E2NFr6xpTtkqgxmZe4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564711; c=relaxed/simple;
	bh=i+6sczoMYmOv+WRIyDMS8YtLkGMUU11kenqLS+mccWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C+QHQZMEcAz2U5U6tdbHCJQCgmu6YlAFa+jhYI4kvlAwlY7JKQhJm+v7fjpST2wRFl5neFiRggx6uO2dzD23O2ehpaCBr1ZSfRtiF1zJ1gKwZjkQwGWydz/K5D5KF4UQK5sIDUHM1e5HdV5r3n18I7+CJKgJ21+WHi0JRkV46+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+ng3Fgd; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+ng3Fgd"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a4d435a036so43789eaf.1
        for <ofono@lists.linux.dev>; Wed, 27 Mar 2024 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711564709; x=1712169509; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffOo6UQp/0C5ur6+hQVTZqAbfPrkhE/S9qtgWFTdVtw=;
        b=T+ng3FgdpK2x7pZl/en6hw1m/5Tb58Lb9OhCkd9EEr1HeZLoxYVHUNFPiJHfG7SbiV
         Vq/NdPGZi5qzPNUMZTy2LDSpgvN1rT4jHMHndwGrC1CjtRzlgWDJedp6ImD5TjSSz94A
         EHpQTF5K+KoaTw6B5rIu687LzGbloxajxRplbzs+7OCIHSbu1C77zk2j1ZvTVynUTSZO
         pSVSZJLh4qvBM+Fn/FojGfW5yq0/LPz3qk+Fv/YlKFoevJUWEPRfyQS0Tl9TiDAjEXac
         EmY3ALsdj4+tm8oovimq8U7qPB3axRWqfe+4VFbotVDm4Fm+IHBzCguqzEtwwIS1aVTV
         kP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711564709; x=1712169509;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffOo6UQp/0C5ur6+hQVTZqAbfPrkhE/S9qtgWFTdVtw=;
        b=Iwp39UtWJZNocUkB43A5ymSTthuk7qcvi5Vbu6r2+7mrOsqQ2oesq6iA2U556TNlUf
         k9d4Ra7sIkBD6OwyfPyyhtjX/DVXzYfbQQKLapZTjLg9Ag/M60A2y8Bbu0vcHkWjQn71
         tfi9oTw+LrzimOYqN4bxf9q79U+wzDHphwDQyVqbj4PCv2mGP2508A6/KmSOZWWAflcs
         Lp+rqSC6CPyxICLgpRqrzRk+a+nCBnk3qkOQUSjwc7vXB11s64r2lBwWqPyTCF2jirlJ
         XEnri3UrKw6NNdnevzskTq3u1/Vwjz6Er+ib6o4rrM3UTclC+lxk/nMD/QOoEDM/Eobf
         RSTA==
X-Forwarded-Encrypted: i=1; AJvYcCWcfW5aDFT+YgRVMi1hyXqk1A8cxiz0dNRJL2BM8eTiKlSkNVnIWxJGBB/k5js/6xJ1Ox/U2yl2fkyyvlRgYKKWxxp2fqg=
X-Gm-Message-State: AOJu0YwzxHjyYTgtcVGU28TMCZiWfp1ugs6ko/V0EVBkqQXtGkpIHHoq
	qaT8dVD4aYWyLew75cR+OPlubGoV6anlF9AFCfLGfk/DxOOI0qk0ACWD3aGz
X-Google-Smtp-Source: AGHT+IEQwRRzFts6Z73GwmTjgX5r9rO4QWh7d6zgU47XnKvtUEkrpQN01PIyU2diUDT4K8WVlbUOIA==
X-Received: by 2002:a05:6820:2781:b0:5a5:23fb:4487 with SMTP id dc1-20020a056820278100b005a523fb4487mr883560oob.2.1711564708768;
        Wed, 27 Mar 2024 11:38:28 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l1-20020a056830334100b006e67cf79aedsm2049946ott.64.2024.03.27.11.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 11:38:28 -0700 (PDT)
Message-ID: <5f877772-7335-49b7-b81b-9e1eddf098eb@gmail.com>
Date: Wed, 27 Mar 2024 13:38:27 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] [qmimodem][voicecall] Implement call answer
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240326102054.30946-1-adam@piggz.co.uk>
 <20240326102054.30946-2-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240326102054.30946-2-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 3/26/24 05:19, Adam Pigg wrote:
> The answer function set up the parameters for a call to the service
> function QMI_VOICE_ANSWER_CALL.  The only parameter is the call-id.
> anser_cb will then be called which retrieves the call-id and checks
> the status of the result.
> ---
>   drivers/qmimodem/voice.h     |  9 ++++
>   drivers/qmimodem/voicecall.c | 99 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 108 insertions(+)
> 

Some CI reported info:

0002-Implement-call-answer.patch:122: WARNING: Prefer using '"%s...", __func__' 
to using 'answer', this function's name, in a string

> diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
> index 1a584f10..9c31297b 100644
> --- a/drivers/qmimodem/voice.h
> +++ b/drivers/qmimodem/voice.h
> @@ -54,6 +54,7 @@ enum qmi_ussd_user_required {
>   /* QMI service voice. Using an enum to prevent doublicated entries */
>   enum voice_commands {
>   	QMI_VOICE_DIAL_CALL =			0x20,
> +	QMI_VOICE_ANSWER_CALL =			0x22,
>   	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
>   	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
>   	QMI_VOICE_GET_CALL_WAITING =		0x34,
> @@ -110,6 +111,14 @@ enum qmi_voice_call_type {
>   	QMI_VOICE_CALL_TYPE_VOICE_FORCE,
>   };
>   
> +enum qmi_voice_call_answer_param {
> +	QMI_VOICE_ANSWER_CALL_ID = 0x01,
> +};
> +
> +enum qmi_voice_call_answer_return {
> +	QMI_VOICE_ANSWER_RETURN_CALL_ID = 0x10,
> +};
> +

See earlier feedback about param / result defines / enums.

>   enum parse_error {
>   	NONE = 0,
>   	MISSING_MANDATORY = 1,
> diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
> index 55c7009a..7c6bc113 100644
> --- a/drivers/qmimodem/voicecall.c
> +++ b/drivers/qmimodem/voicecall.c
> @@ -97,6 +97,16 @@ struct qmi_voice_dial_call_result {
>   	uint8_t call_id;
>   };
>   
> +struct qmi_voice_answer_call_arg {
> +	bool call_id_set;
> +	uint8_t call_id;
> +};
> +
> +struct qmi_voice_answer_call_result {
> +	bool call_id_set;
> +	uint8_t call_id;
> +};
> +

Likely these structures are not needed.

>   int ofono_call_compare(const void *a, const void *b, void *data)
>   {
>   	const struct ofono_call *ca = a;
> @@ -533,6 +543,94 @@ error:
>   	l_free(param);
>   }
>   
> +enum parse_error qmi_voice_answer_call_parse(
> +	struct qmi_result *qmi_result,
> +	struct qmi_voice_answer_call_result *result)
> +{
> +	int err = NONE;
> +
> +	/* optional */
> +	if (qmi_result_get_uint8(qmi_result, QMI_VOICE_ANSWER_RETURN_CALL_ID, &result->call_id))
> +		result->call_id_set = 1;

Just inline this inside answer_cb()

> +
> +	return err;
> +}
> +
> +static void answer_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	uint16_t error;
> +	struct qmi_voice_answer_call_result answer_result;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	/* TODO: what happens when calling it with no active call or wrong caller id? */
> +	if (qmi_voice_answer_call_parse(result, &answer_result) != NONE) {

That function doesn't actually return an error, so is this code block even needed?

> +		DBG("Received invalid Result");
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +static void answer(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct qmi_voice_answer_call_arg arg;

No need for this, fill out qmi_param directly.

> +	struct ofono_call *call;
> +	struct qmi_param *param = NULL;
> +
> +	DBG("");
> +
> +	cbd->user = vc;
> +
> +	call = l_queue_find(vd->call_list,
> +					ofono_call_compare_by_status,
> +					L_UINT_TO_PTR(CALL_STATUS_INCOMING));
> +
> +	if (call == NULL) {
> +		DBG("Can not find a call to answer");
> +		goto error;
> +	}
> +
> +	arg.call_id_set = true;
> +	arg.call_id = call->id;
> +
> +	param = qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	if (arg.call_id_set) {
> +		if (!qmi_param_append_uint8(
> +			param,
> +			QMI_VOICE_ANSWER_CALL_ID,
> +			arg.call_id))
> +			goto error;
> +	}
> +
> +	if (qmi_service_send(vd->voice,
> +		QMI_VOICE_ANSWER_CALL,
> +		param,
> +		answer_cb,
> +		cbd,
> +		l_free) > 0)

See doc/coding-style.txt item M4.

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
> @@ -598,6 +696,7 @@ static const struct ofono_voicecall_driver driver = {
>   	.probe		= qmi_voicecall_probe,
>   	.remove		= qmi_voicecall_remove,
>   	.dial		= dial,
> +	.answer		= answer,
>   };
>   
>   OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)

Regards,
-Denis
