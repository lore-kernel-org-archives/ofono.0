Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D62219F9
	for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713729972; cv=none; b=ZQ720q7kPAFvBUxgQTMBw35whIoxAod+PuqNG46pTuh0cQXHuhshH5f8QsdppGM/yiMt/acJxKkE3GcaIIy7twMKsPkOMwGhG0aW5pGpMgb50BOEo+6w0g5f4owqaaB3PprdeegAC83ZWoyWroo4VDONSp4+dDwl4LyfQE8HqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713729972; c=relaxed/simple;
	bh=75e+i/atz6/C46ThvMDRW4Mktj91UHk/qbihBiyhVxM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAT1pFE3ODOrTNo9KuG4va3AtUicOHkMBk+TTnrSaeN9MChRtB23hUiA86XZzochuc/au/62CUU9r7W1z7KlkO7Ebj2E3Az+T9h/esq9nbgfJCf7WefuqXBldewQctgZKYmKXM0TpLTY6Qj1PMei3AYkB27irnqM/1WCshWC2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7WsuXOC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7WsuXOC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a4f291f80so2316725e9.1
        for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713729969; x=1714334769; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYN1gbGSALzueK9jW9/xA1wM8/5Bi5nb2jFQORX2iPQ=;
        b=h7WsuXOCIf955L6V6xrWbFxCPiOQ0Mj0F24UdV5Y/YYwxlUaD0mW02gOL5qxZgoiZr
         /lUlP7MQwMBstH9m5l5QOomoC6TUuH/GyD1QFS88hZdAtlJlxSOiojvaURFC6CMVNv6O
         kXzBj7S2095LeEfX5q+hTRBJ7mxp6FzZrjd/dmu3dZ9NZjMsN31Zj2Zk5ul3Mr5Csrq5
         Y5EEgOKp+ZHU5905olbtMCnmYKTa3V1qv6FdmEjNuqBi++1OMSQHnBGBYwaA9eOqar1t
         JKSeI29S25ztyhzflvrIW6+GY+zRpamdNgzQCtWdwUeWZv7pzFCq4stm9VnG7tqvdPRV
         CElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713729969; x=1714334769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYN1gbGSALzueK9jW9/xA1wM8/5Bi5nb2jFQORX2iPQ=;
        b=bwO2oNfp7gDbfcJs28NcdclcB4B7yR1SSgtYupOC20YyPkk0U6jj6bspavxPMWhRnp
         gU6LF/6DdWeuDbkjJMXlrhejVhiovq+Ij4wzaIc/f8RGNVc1hEt97y/b5wrHNtroCoUZ
         kkPFVCbOGxRUQ7rj6WPfV2SldGqAvVsqcQzl0NTCMdwTNxG/xTm5zvDNvEeYblX/G2rI
         JFCynf0c9XxJJTJz0uhWJ1bz8HnFEqLkp6nqeZ7koinEKw3wDtgYpbBleawMdSdKh59j
         FSmgJbvC3eIid+lFI+mxKkP0pXYXpA9t1I+Qk8I2cnomBFeVsNrktLTBrHG5KSPMYMbN
         QuRg==
X-Gm-Message-State: AOJu0Yxhdt7YyTl8ehuViPs/s1aRkiPT9meFw2tRhnlYgcdmpYxrf8Ya
	7ysLY5oTi9zRQaJDbkml2BNdYeoX+AkFYmMnc2SHIBPKLqUg0l5JLnwCLg==
X-Google-Smtp-Source: AGHT+IFTQ04UkkudabHrChTjIQeqxVWjQ5wVgOdcdR41NolrwP1Rn6GcAoPsmNceRy40Ivkb4ECa8w==
X-Received: by 2002:a05:600c:511b:b0:41a:2342:18b5 with SMTP id o27-20020a05600c511b00b0041a234218b5mr1819396wms.35.1713729968892;
        Sun, 21 Apr 2024 13:06:08 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c0a0900b0041668162b45sm17831790wmp.26.2024.04.21.13.06.08
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 13:06:08 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev
Subject: Re: [PATCH 4/4] qmimodem: voicecall: Implement DTMF tones
Date: Sun, 21 Apr 2024 21:06:03 +0100
Message-ID: <2260350.vFx2qVVIhK@adam-laptop-hp>
In-Reply-To: <20240421194926.13149-4-adam@piggz.co.uk>
References:
 <20240421194926.13149-1-adam@piggz.co.uk>
 <20240421194926.13149-4-adam@piggz.co.uk>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

This one took the longest, but I think I implemented it correctly as you 
suggested.  I have ran this through valgrind and didnt catch any leaks.

On Sunday 21 April 2024 20:49:06 BST you wrote:
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
> 
> Changes in V5
> -Store the cb and cbd obejects in the voicall_data  struct
> ---
> ---
>  drivers/qmimodem/voice.h     |   6 ++
>  drivers/qmimodem/voicecall.c | 114 +++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
> 
> diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
> index caedb079..961fe19f 100644
> --- a/drivers/qmimodem/voice.h
> +++ b/drivers/qmimodem/voice.h
> @@ -53,6 +53,8 @@ enum voice_commands {
>  	QMI_VOICE_GET_ALL_CALL_INFO =		0x2f,
>  	QMI_VOICE_END_CALL =			0x21,
>  	QMI_VOICE_ANSWER_CALL =			0x22,
> +	QMI_VOICE_START_CONTINUOUS_DTMF =	0x29,
> +	QMI_VOICE_STOP_CONTINUOUS_DTMF =	0x2A,
>  	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
>  	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
>  	QMI_VOICE_GET_CALL_WAITING =		0x34,
> @@ -85,6 +87,10 @@ enum qmi_voice_call_state {
>  	QMI_VOICE_CALL_STATE_SETUP
>  };
> 
> +enum qmi_voice_call_dtmf_param {
> +	QMI_VOICE_DTMF_DATA = 0x01,
> +};
> +
>  struct qmi_ussd_data {
>  	uint8_t dcs;
>  	uint8_t length;
> diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
> index 6b80f576..f51452e5 100644
> --- a/drivers/qmimodem/voicecall.c
> +++ b/drivers/qmimodem/voicecall.c
> @@ -42,6 +42,10 @@ struct voicecall_data {
>  	uint16_t minor;
>  	struct l_queue *call_list;
>  	struct ofono_phone_number dialed;
> +	char *full_dtmf;
> +	const char *next_dtmf;
> +	ofono_voicecall_cb_t send_dtmf_cb;
> +	struct cb_data *send_dtmf_data;
>  };
> 
>  struct qmi_voice_call_information_instance {
> @@ -605,6 +609,114 @@ static void hangup_active(struct ofono_voicecall *vc,
> ofono_voicecall_cb_t cb, release_specific(vc, call->id, cb, data);
>  }
> 
> +static void stop_cont_dtmf_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct voicecall_data *vd = user_data;
> +	uint16_t error;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd-
>send_dtmf_data);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd->send_dtmf_data);
> +}
> +
> +static void start_cont_dtmf_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct voicecall_data *vd = user_data;
> +	uint16_t error;
> +	struct qmi_param *param;
> +
> +	DBG("");
> +
> +	param = qmi_param_new();
> +
> +	if (qmi_result_set_error(result, &error))
> +		goto error;
> +
> +	if (!qmi_param_append_uint8(param, QMI_VOICE_DTMF_DATA, 0xff))
> +		goto error;
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_STOP_CONTINUOUS_DTMF, 
param,
> +			stop_cont_dtmf_cb, vd, NULL) > 0)
> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd->send_dtmf_data);
> +	l_free(param);
> +}
> +
> +static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
> +				ofono_voicecall_cb_t cb, void 
*data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct qmi_param *param = NULL;
> +	uint8_t param_body[2];
> +
> +	DBG("");
> +
> +	param = qmi_param_new();
> +
> +	param_body[0] = 0xff;
> +	param_body[1] = (uint8_t)dtmf;
> +
> +	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, 
sizeof(param_body),
> +			param_body))
> +		goto error;
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_START_CONTINUOUS_DTMF, 
param,
> +			start_cont_dtmf_cb, vd, NULL) > 0)
> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	l_free(param);
> +}
> +
> +static void send_one_dtmf_cb(const struct ofono_error *error, void *data)
> +{
> +	struct cb_data *cbd = data;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(cbd->user);
> +	ofono_voicecall_cb_t cb = vd->send_dtmf_cb;
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
> +	} else
> +		send_one_dtmf(cbd->user,
> +				*(vd->next_dtmf++),
> +				send_one_dtmf_cb, vd-
>send_dtmf_data);
> +}
> +
> +static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +
> +	DBG("");
> +
> +	l_free(vd->full_dtmf);
> +	vd->full_dtmf = l_strdup(dtmf);
> +	vd->next_dtmf = &vd->full_dtmf[1];
> +
> +	vd->send_dtmf_data = data;
> +	vd->send_dtmf_cb = cb;
> +
> +	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, NULL);
> +}
> +
>  static void create_voice_cb(struct qmi_service *service, void *user_data)
>  {
>  	struct ofono_voicecall *vc = user_data;
> @@ -664,6 +776,7 @@ static void qmi_voicecall_remove(struct ofono_voicecall
> *vc) qmi_service_unref(data->voice);
> 
>  	l_queue_destroy(data->call_list, l_free);
> +	l_free(data->full_dtmf);
>  	l_free(data);
>  }
> 
> @@ -674,6 +787,7 @@ static const struct ofono_voicecall_driver driver = {
>  	.answer		= answer,
>  	.hangup_active  = hangup_active,
>  	.release_specific  = release_specific,
> +	.send_tones	= send_dtmf,
>  };
> 
>  OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)




