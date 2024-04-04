Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087322EE4
	for <ofono@lists.linux.dev>; Thu,  4 Apr 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264322; cv=none; b=ZUDqjCoHBApAqCK1OqzXU9hx+GPocqWCzf7AcAU1xlFjLolQ6Eb16V4d/QC1gPDYzUnk2as/NmfeWCom4VOkQYwGN8mK5JRD65IMCpxIF+tJmDTCKnEapsxYJYMMOHI9i19JixcENw5Uj/K+ThbZGHNvy7XTm1hj47E2pHA4c3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264322; c=relaxed/simple;
	bh=v7LHkyFkYXaizak6fOMOR38dNJ8W96H98KMWkaYjtCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c0As+hwHz820mhD9myXB/3YCqIf0cV21+vHZVP2X492JgDviVEAwRYmMLJ3321n4pRalpHRSP1YFvLx9WJkblmgPxeWW/EyfhQVDssmj7+Ggm1568DZIjyKUHPcHhGDd7m2Qwr4+3fWvUuvxZHbPVpz9TbE+B7H7Rl5KOiSfiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZVGEzu6; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZVGEzu6"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4b35ff84eso840630eaf.2
        for <ofono@lists.linux.dev>; Thu, 04 Apr 2024 13:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712264320; x=1712869120; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrJfhPp3tWBKQ9qOhXJy5uHK9uftcUvX/BmnGT9uVHE=;
        b=GZVGEzu6OAsDCeXOrTyV/o+wQaAIqLgitboE1jTV6am37HpiUnxbrOkq/OEA7ocWk4
         25bvlBbjUtvKnv3+RCRZilCoDXudYxn4AFF2z3oaipEehTBEOb4RYZfK/9MfcCP8Ab+6
         Lf1x77lKWwwXW5j/BY3o+xGT43//3xzQzYcfsioAt3D9zUcdHKweTyYnIdJYOFWTWgkA
         4mscNCV62RUN9p5WizGC2IZzzf+oZhGMq4plj0fH2iAtFVrpg05fzshZ5EUOdOo7Lvyl
         mpYNMSf5/2ywwL9Xekt6/kk+ht0ClXaqmkAl8BgyZp2oRazQ8MtzK51aPJjXX/ErcUSO
         SGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712264320; x=1712869120;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrJfhPp3tWBKQ9qOhXJy5uHK9uftcUvX/BmnGT9uVHE=;
        b=hIWGp7a/qbJ95dr3u3V9TRjpOPqnRG2ShtEIsx5pVhRtfZ7IUMtEzd2R9LhR2JK79I
         BdOuSLhX0IX1sA1+QraRaaNRH4gt0GYP65Gbb85MdNrIc0+9FlQ2UgYUnxESoUojB0dq
         jGH6H4WRNncV9hc7k83/KnqH6D4PrUrh+GLsnZNE0139ElWiv3pL+KOTaCyZEqVorX3N
         QR10kNFVYJDcyIbD0P67w2H/1vEVIANpIB4jsW9S9jS6MfFTeEklBw5jBRXRrs2dsuTT
         L3Eo6Qtf4f3L+F+bdmj8KLkGXx0c8rzHmMpyXvXExo/dQ/Y1MgE/gkvb9ezAWl4B9dQ5
         q0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVBopeRTd+ujCh1Blu9+AJzFKTHhVS5tQv8UvSMLwcPeEJNvWQEz8bQgVZGcU9ELf8ecqESK6UL6iIDZkteqQbNSXgVF4=
X-Gm-Message-State: AOJu0YytRwE37KQimxPhyFFB/ieGPr43TGOoto+Z61J+JfYNIjeZufFW
	JfxYQUlGuD0khtuCq28/wpEXtccV6Y87nRLpKoqY7UvJLmR82+wB
X-Google-Smtp-Source: AGHT+IHjVCCSvVqk/200HSyX+aFzmkVn15cNd0wPNiPfSppd5awTJzJb+gUye27hlcJT/+7u5tWE5g==
X-Received: by 2002:a05:6820:1904:b0:5a9:d53a:4859 with SMTP id bk4-20020a056820190400b005a9d53a4859mr4038781oob.0.1712264320412;
        Thu, 04 Apr 2024 13:58:40 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q6-20020a4a4b06000000b005a1bc9b380esm3966ooa.24.2024.04.04.13.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 13:58:40 -0700 (PDT)
Message-ID: <41cb372a-416f-400b-b955-e02d1f340121@gmail.com>
Date: Thu, 4 Apr 2024 15:58:39 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] qmimodem: voicecall: Implement call answer
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240402212625.5348-1-adam@piggz.co.uk>
 <20240402212625.5348-2-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240402212625.5348-2-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/2/24 16:25, Adam Pigg wrote:
> The answer function set up the parameters for a call to the service
> function QMI_VOICE_ANSWER_CALL.  The only parameter is the call-id.
> anser_cb will then be called which retrieves the call-id and checks

typo, 'anser_cb'

> the status of the result.
> ---
>   drivers/qmimodem/voice.h     |  1 +
>   drivers/qmimodem/voicecall.c | 65 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 66 insertions(+)
> 

<snip>

> +static void answer(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct ofono_call *call;
> +	struct qmi_param *param = NULL;

I would delay initialization of cbd until after qmi_param_new()

> +
> +	static const uint8_t QMI_VOICE_ANSWER_CALL_ID = 0x01;
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
> +		DBG("Can not find a call to pick up");
> +		goto error;

That way you can just return here.

> +	}
> +
> +	param = qmi_param_new();
> +	if (!param)
> +		goto error;

qmi_param_new can't fail (l_new aborts on failure), so this if check isn't needed.

> +
> +	if (!qmi_param_append_uint8(param, QMI_VOICE_ANSWER_CALL_ID,
> +		call->id))

doc/coding-style.txt item M4

> +		goto error;
> +
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_ANSWER_CALL, param,
> +		answer_cb, cbd, l_free) > 0)

as above

> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	l_free(cbd);
> +	l_free(param);
> +}
> +

<snip>

Regards,
-Denis

