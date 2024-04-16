Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B355135A59
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291703; cv=none; b=XuGYQVXFtfI5jfpHhmdpVLj9/BoGex+7vV10ZgDzWLRPLN0HGPvwL8dqFMEUi6FXhNFZTcDgF5s68kFZ9JxFVEqlEN+jI3KsiHUSs1lug7rNggogJG3hoGz4V3tkRt1mxMD7PnYsweRkZaZCYshoEkNUcV8g/fLEIxS5FLFABgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291703; c=relaxed/simple;
	bh=aKMmd+eo0YNrv8mZ2AGEsb0VffZTTgCzro5SKLi4XRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PF3Bh1k7lwScuIduIzJacm9AHD1Nl0pxo5c/HcHf/F3el8UMFDlC+KJnTl4Np1Z8+u4Qbg6Ag+70v8vvhq9065PgtvHCe1Zf7V7EKPNoMe93qMw6tWibeYZ9XDu4VEmBUdBma1KHfW2T2IFYeJqBZEU+a0+iDilGWRyzvI5QVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+qeAdji; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+qeAdji"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa25e99414so3164823eaf.3
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713291701; x=1713896501; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LXOTe8fmhM4Qk0oJcDclyjl65engdULV7e9Ot99oqI=;
        b=H+qeAdjid6TOXhy8/3Xx8V2QfMHjr8hmBFAozaJChf2vm6UGhtyyr5Ucf3jYl1gq9g
         SSPjyiGDWfBww2/lPDQ0yx81xe2nd6HEhUsHa2R8PbMpfFEy5KkxLjT0nieK9VhhVnfy
         DL3AwPuw21N1aEL0bKK1/er5cVCMDcctIeBcNGfUFDv2UE46TH/q8V2U7oYVCI7PVrFf
         8Pozlig47UiR85KL1iIaDkSBNm9QViZQDwPPqFccgvITLFIOc1f7r3C1YjTHKdfNgZxl
         bNEe0pSg1uCmBRwffmeN4HqxZRBBI+h5yzojcBdMMwFwrfkL9Dtew5m/DJEaSzX68M2o
         MUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713291701; x=1713896501;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LXOTe8fmhM4Qk0oJcDclyjl65engdULV7e9Ot99oqI=;
        b=ESQNLIr1L8FPfxBLBXdyKbGRY4On48BgVFx0W8PPG9HSLRO9/8qrH183fX08UZdkWk
         BniB2pEV0WMX/2zcNGAlQsZezxSGXqYlIzBEejsLHd1///8ptA+lfGftoi7Pf0nEySI7
         NluvXDM58pmOqv54s8NQFJdK/XaCTJNImYbEKG3wS7VA+pbqoVm+YfLX7k/j3DuMHDx7
         f54FEsnALhkyvgh4/6WD9HLUeKyjwHU2o3WUNE/iZ7DRVN5F1pTT0rPxIUimQRQgrHU6
         3I66le+Ga47qp1HtRYofXnNT3/14fivWWt1TRes0xdgs6NQqHI7mWH127H10Wi7dz0aG
         PC5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbEQq8IFtfTPzrfbT/twKX50JeKKWlkfNqMDIXj3KMqdnuREo7kr5XvJ5C625y2mH2QyhqTO5Ut41Nti6vU6+XscXIT3o=
X-Gm-Message-State: AOJu0YxGD9GFQ9HlvhC7kw4n6AagALQGohalpnh3+wVvQc66u1KNeTY0
	IEbAQHehPWiKzQRLV9vVc/nqvPlAul/3mhaJoc6erThGa1MBRw6MrElYzA==
X-Google-Smtp-Source: AGHT+IH+ifWbbR695i3ojmW8QoTNvJyJHQ+KST7trG2eRkHRUsglAm020uOwxfGCan1nbSssAq+0+Q==
X-Received: by 2002:a4a:abce:0:b0:5ac:9f40:16a with SMTP id o14-20020a4aabce000000b005ac9f40016amr7387372oon.5.1713291701571;
        Tue, 16 Apr 2024 11:21:41 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bi10-20020a05682008ca00b005aa77c0fe49sm2655516oob.24.2024.04.16.11.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 11:21:41 -0700 (PDT)
Message-ID: <2d7d6605-af0e-43d7-95e5-0d6a6e62fc34@gmail.com>
Date: Tue, 16 Apr 2024 13:21:40 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] qmimodem: voicecall: Implement active call hangup
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240413215318.12236-1-adam@piggz.co.uk>
 <20240413215318.12236-3-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240413215318.12236-3-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/13/24 16:53, Adam Pigg wrote:
> hangup_active iterates the current list of calls, looking for the first
> active call and then calls release_specific.  This then sets up the
> parameters for a call to QMI_VOICE_END_CALL, with the only parameters
> being the call-id.
> 
> end_call_cb will then be called and will parse out the call-id and check
> for success.
> 
> ---
> Changes in V4
> -Minor rework to hangup_active
> -Removed unnescessary changes
> ---
> ---
>   drivers/qmimodem/voice.h     |  1 +
>   drivers/qmimodem/voicecall.c | 82 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 83 insertions(+)
> 

<snip>

> @@ -534,6 +534,86 @@ error:
>   	l_free(param);
>   }
>   
> +static void end_call_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	uint16_t error;
> +	uint8_t call_id;
> +
> +	static const uint8_t QMI_VOICE_END_RETURN_CALL_ID = 0x10;

RESULT_CALL_ID

> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	if (qmi_result_get_uint8(result, QMI_VOICE_END_RETURN_CALL_ID, &call_id))
> +		DBG("Received end call result with call id %d", call_id);
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +static void release_specific(struct ofono_voicecall *vc, int id,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd;
> +	struct qmi_param *param = NULL;
> +
> +	static const uint8_t QMI_VOICE_END_CALL_ID = 0x01;

PARAM_CALL_ID

> +
> +	DBG("");
> +
> +	param = qmi_param_new();
> +	cbd = cb_data_new(cb, data);
> +	cbd->user = vc;
> +
> +	if (!qmi_param_append_uint8(param, QMI_VOICE_END_CALL_ID, id))
> +		goto error;
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_END_CALL, param, end_call_cb,
> +			cbd, l_free) > 0)
> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	l_free(cbd);
> +	l_free(param);
> +}
> +

Rest of this patch LGTM.

Regards,
-Denis

