Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B093F1BC2F
	for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819645; cv=none; b=cho/1kcw6LniR1qggUcaA+K8dt6kM2gB27Ny9y8m0mr83iTOXDVnK5PxmlnNbHhegqnB/D9WkNXjBkh5IL1qpR8t0n/WNIjjb2x9ajXg6TsJ+oNgBNTlYKrOMPUqbywu8E4aZhiEd9hlyRQKYUcnIMwoxiXAWsz+nhWZROW5DSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819645; c=relaxed/simple;
	bh=04AU3FD3agklLPYEyrkzQKjX6t7TYCmjPYgckyGAPPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jDT6D4etrgEank/KwGjl+vTA2iE/6zaMTIDiRl/ig/A2qTaDcardVP0RjMG18e3iD8uHLAbTMj2zt6kEoStXxaEwwi5Eoj/GN41t7FtH1rI/zHQ7411J2s6JOnr1E9Vl8xoaXL5K9Oio/jdS6VaAhwrNRlBpVXCCv8EyqgcH024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljVw61by; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljVw61by"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa2a74c238so3137972eaf.3
        for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713819643; x=1714424443; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upqKs4Dh0xvgk1coEn2l1ZEcofW56TbUqGb7hiBMDSg=;
        b=ljVw61byuBabOHxgLezaVZYsvI/47BFMS+TUeWzq9TqgruqOVLNpHQl5RwlkjFyeOK
         CzLbCT8H2+bvd3ilqcCWJK8Z2hiRrMfP4vZ5RgVKDOEnaV3T5tpS3jk3IFmzJn/R1fpR
         fdaCGcz3M4OKWPLP9igd2kpDK32gOeZ72kQdQcSVvlchFoy10AqhGgWo0HEdNDlNDsTf
         nZnbiu3KXl5oCDCaExvFyati7QSf2xWzGfCh5bY5k+pNXl3ghraDCe1eum4DjiScc1bn
         WBcIGr0pGSpCvpy/QYQIrj3XpCb3Dts7E5+jdNmpqsCB+q3OVu+29OCIeOOCZ9dcj4Xh
         lywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819643; x=1714424443;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upqKs4Dh0xvgk1coEn2l1ZEcofW56TbUqGb7hiBMDSg=;
        b=kdyuVT2DYQM4rY6vesCLVtJC+Xa/ltllgocCBcbmajJ2Y9F3lQM+mmujb3kAjNrpOB
         vmdnK133RIv+0Lky0/hxaj4T7ZXYMQVd62h47o/f9uZSLPKEDlbrZxSGM7+bIJBjzvtl
         wEEn8wtAuPwjMnNBv28VMb3OZsgGJHbH5rmmS6xJYFCBrCgtInLi5EthJZKevvj/tO9D
         xod39qiPbqltyehRlaiKOm/kXsgJouJ6VmRuC4K1EG442QjCeKlN04XnIPhmskYpZRxo
         yTM1I6G/TeDooxwF54PKwydevHtL4Jke9DhO2DEj5Q1GjSFoklUHh2JqIzKrnaqkLXOz
         Nxew==
X-Forwarded-Encrypted: i=1; AJvYcCX25rce74S5PNFbffFm3oDQC2Sf+S+0FcdnvmJjnNVY9CRJHGb9qRCca1vMRVCSjuA//1EgsFiQMa7VvUApxTqmdwz0bKw=
X-Gm-Message-State: AOJu0YzbZG0HNl1F1kehXAzTElGQgiUWhV0/OkHDnfGwfvHZKEOk/cvi
	KkYZ923Ndd9dvVhaZ6n1bW8mAdz/k3QHI7Ui38bIQrLNXdOkoP1SREeucQ==
X-Google-Smtp-Source: AGHT+IGc0f/PdSSAS7OxZr5ucClhvdI0WwDmkwCAzoMOrGTyikf3JMvDwGIOQzTAPUBvO5iMWGNnuA==
X-Received: by 2002:a4a:57c1:0:b0:5aa:4a0c:d99e with SMTP id u184-20020a4a57c1000000b005aa4a0cd99emr11778274ooa.8.1713819642808;
        Mon, 22 Apr 2024 14:00:42 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 185-20020a4a06c2000000b005a49df78628sm2201095ooj.39.2024.04.22.14.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 14:00:42 -0700 (PDT)
Message-ID: <159a23ff-bd7d-44bc-b723-6dbb08aef6d9@gmail.com>
Date: Mon, 22 Apr 2024 16:00:41 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] qmimodem: voicecall: Implement DTMF tones
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240421194926.13149-1-adam@piggz.co.uk>
 <20240421194926.13149-4-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240421194926.13149-4-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/21/24 14:49, Adam Pigg wrote:
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
>   drivers/qmimodem/voice.h     |   6 ++
>   drivers/qmimodem/voicecall.c | 114 +++++++++++++++++++++++++++++++++++
>   2 files changed, 120 insertions(+)
> 

<snip>

> @@ -605,6 +609,114 @@ static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
>   	release_specific(vc, call->id, cb, data);
>   }
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
> +		CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd->send_dtmf_data);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd->send_dtmf_data);

This calls back into oFono core unconditionally.  Doesn't this imply that you're 
handling only a single DTMF character?

> +}
> +

<snip>

> +static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
> +				ofono_voicecall_cb_t cb, void *data)

Both cb and data are not saved anywhere and are only used on the error path. 
The initial invocation in send_dtmf() also passes in NULL for data...

So again, I think this implies only a request which uses a single DTMF tone 
character would work?

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
> +	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, sizeof(param_body),
> +			param_body))
> +		goto error;
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_START_CONTINUOUS_DTMF, param,
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
> +				send_one_dtmf_cb, vd->send_dtmf_data);

This function doesn't seem to be invoked?

> +}
> +

<snip>

Regards,
-Denis

