Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348E2C6BD
	for <ofono@lists.linux.dev>; Fri, 26 Apr 2024 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714166798; cv=none; b=R8V49vho9Ca3yXhsua/1xyd0tONcCCdXM0JyTSlZkGsfrBRkVg3URvh53QT8jyiiwm26DBrtGSAA/8K90u1KBV8YwAWusBrsSaTuz0a8yOqi3arNoGU8XiBz/MQx+abVBBxQDoD+tMYM77JegPzKZASXDbKcW1LXaHBZrG0wMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714166798; c=relaxed/simple;
	bh=HjA0w5isYYqojizj6flF97v7ubjbc4zq5uLAy4bpcrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2UeJtjB4L0tr+hpQF8YTfa2bm35d7eqUz3m8g4OOQcdukJOImW730XxPxD6HIhjgveP+L9JifSoST6LtF2/utgz3kA2RNLxPXQyYyDjI6POGdCh1di9EXqUAw1RTE0NY04NwjcDJ+8n29FYC7252vT8FhgWjR3gB6t9xwZ+4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmIBhR66; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmIBhR66"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b5e74fa83so14884185e9.0
        for <ofono@lists.linux.dev>; Fri, 26 Apr 2024 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714166795; x=1714771595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meDhulYVtX+1OBiNctUYi/rz5LjDtclfaJMpMmgUBYU=;
        b=DmIBhR66FEVkeylryqNbYabkynHXCtV2Cj5Z+HkMz94TqQUgt9PR7wqv0dQM1yIO1N
         OUSFnuXAau2EYckG4aunI1ak6vD5+uKXs4KKCLwz0faQNBJ6X87CLDEypXSsr5M9iWZN
         uXEhwemtbVqC86ELGvrFHxopb/KWsHsA55QctdnHioFURfxAxdmIqEcG9HmR/9LiwKVi
         uZwbERIzPFiGDY0olASiAC0wy364ssckNC10CuXgBDEMKNLkkCQQkHd+Hev91TPnXdiV
         fFMxO18cbao2Oy3fJ78Q+/7z1YDFjJKMBaq8czWM3wVpKeQ8ordPzRs+edtqvid9oAXU
         qdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714166795; x=1714771595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meDhulYVtX+1OBiNctUYi/rz5LjDtclfaJMpMmgUBYU=;
        b=rSK8zUS1Lwid282TU9SHiTRgYr+6kmwSUPKhO9ST/SqB/QUHmH08TduiU7OnwMoZGx
         /vGmRnDh+lfzWtPp/zrkS9PL1pX51Sb2KL32zuy5uoUxieQ1hSWF1i9OvZPzn4vzwJPQ
         IQGopNnI43RLqXz2jcmmCj/dpWxLy1mCBdhghtLgXWLppqhOjlYSm+4oSs8nCkMDPX7/
         kDT0ZggMWG4GZMtJyJ+Ekafmidacv6Sk3v5I9JR/vov1SYL+0UB+0WUsQIsjjGi7FCM/
         gHHOu4aHrPsbtEYTm2UGQtiLWE3+JwlzV4NIQem5VW4syH8E0fJ1vl9HpCdqk2MA2vmN
         +2xg==
X-Gm-Message-State: AOJu0YwDpo+agaZjF48agUqaeFPTmCaZZ7evINWa46EKusdEYT7R3FZK
	SOW4QJgNhwNvzf9QqMmeAnLnMZtSPDf456tjEubwH4NPXplZMSRIwcyG6w==
X-Google-Smtp-Source: AGHT+IGnfhQIyaUQ+15BedUDx6X/4dBZf8G6PUHmbIEeTzJxq+7eS94E3baZyBxOC+YCjlWvr22eRg==
X-Received: by 2002:a05:600c:4f8e:b0:419:ec38:f34b with SMTP id n14-20020a05600c4f8e00b00419ec38f34bmr679528wmq.20.1714166794613;
        Fri, 26 Apr 2024 14:26:34 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c190a00b00418a9961c47sm32176756wmq.47.2024.04.26.14.26.34
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:26:34 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev
Subject: Re: [PATCH v6] qmimodem: voicecall: Implement DTMF tones
Date: Fri, 26 Apr 2024 22:26:33 +0100
Message-ID: <5571717.rdbgypaU67@adam-laptop-hp>
In-Reply-To: <20240426212235.2627-1-adam@piggz.co.uk>
References: <20240426212235.2627-1-adam@piggz.co.uk>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

This version of the DTMF code goes back to V4, but adds in some of the changes 
in v5 to store the cb and data for the core ofono callback.

I have tested this with individual digits and a string of 10 digits 0-9 using 
the dbus api.

I have also ran this through valgrind, once in the normal path, and again 
running an AT command against the modem to reboot it into fastboot mode to 
simulate removal.  Both cases found no leaks.

Hopefully this is getting closer!

Thanks

Adam

On Friday 26 April 2024 22:22:03 BST Adam Pigg wrote:
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
> Changes in V5/V6
> -Store the core cb and cbd obejects in the voicall_data struct
> -Fix incorrect free calls
> ---
> ---
>  drivers/qmimodem/voice.h     |   6 ++
>  drivers/qmimodem/voicecall.c | 127 +++++++++++++++++++++++++++++++++++
>  2 files changed, 133 insertions(+)
> 
> diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
> index caedb079..92186b72 100644
> --- a/drivers/qmimodem/voice.h
> +++ b/drivers/qmimodem/voice.h
> @@ -53,6 +53,8 @@ enum voice_commands {
>  	QMI_VOICE_GET_ALL_CALL_INFO =		0x2f,
>  	QMI_VOICE_END_CALL =			0x21,
>  	QMI_VOICE_ANSWER_CALL =			0x22,
> +	QMI_VOICE_START_CONTINUOUS_DTMF =       0x29,
> +	QMI_VOICE_STOP_CONTINUOUS_DTMF =        0x2A,
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
> index 7c9326fe..0df65226 100644
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
> @@ -599,6 +603,127 @@ static void hangup_active(struct ofono_voicecall *vc,
> ofono_voicecall_cb_t cb, release_specific(vc, call->id, cb, data);
>  }
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
> +		CALLBACK_WITH_FAILURE(cb, cbd);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd);
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
> +		CALLBACK_WITH_FAILURE(cb, cbd);
> +		return;
> +	}
> +
> +	param = qmi_param_new();
> +
> +	if (!qmi_param_append_uint8(param, QMI_VOICE_DTMF_DATA, 0xff))
> +		goto error;
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_STOP_CONTINUOUS_DTMF, 
param,
> +			stop_cont_dtmf_cb, cbd, cb_data_unref) > 0) {
> +		cb_data_ref(cbd);
> +		return;
> +	}
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +	l_free(param);
> +}
> +
> +static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
> +				ofono_voicecall_cb_t cb, void 
*data)
> +{
> +	struct voicecall_data *vd = data;
> +	struct qmi_param *param;
> +	uint8_t param_body[2];
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +
> +	DBG("");
> +
> +	cbd->user = vc;
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
> +			start_cont_dtmf_cb, cbd, cb_data_unref) > 0)
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
> +	struct ofono_voicecall *vc = cbd->user;
> +	struct voicecall_data *vd = cbd->data;
> +
> +	DBG("");
> +
> +	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
> +			*vd->next_dtmf == 0) {
> +		if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
> +			CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd-
>send_dtmf_data);
> +		else
> +			CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd-
>send_dtmf_data);
> +
> +		l_free(vd->full_dtmf);
> +		vd->full_dtmf = NULL;
> +	} else {
> +		send_one_dtmf(vc,
> +				*(vd->next_dtmf++),
> +				send_one_dtmf_cb, vd);
> +	}
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
> +	vd->send_dtmf_data = data;
> +	vd->send_dtmf_cb = cb;
> +
> +	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, vd);
> +}
> +
>  static void create_voice_cb(struct qmi_service *service, void *user_data)
>  {
>  	struct ofono_voicecall *vc = user_data;
> @@ -656,6 +781,7 @@ static void qmi_voicecall_remove(struct ofono_voicecall
> *vc) qmi_service_free(data->voice);
> 
>  	l_queue_destroy(data->call_list, l_free);
> +	l_free(data->full_dtmf);
>  	l_free(data);
>  }
> 
> @@ -666,6 +792,7 @@ static const struct ofono_voicecall_driver driver = {
>  	.answer		= answer,
>  	.hangup_active  = hangup_active,
>  	.release_specific  = release_specific,
> +	.send_tones     = send_dtmf,
>  };
> 
>  OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)




