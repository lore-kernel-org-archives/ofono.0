Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4D289E2D
	for <ofono@lists.linux.dev>; Thu, 26 Jun 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950699; cv=none; b=dyXjRSQ7EwvSzYImVg9CBNljV+oteTiNWFbqnd3Xu+zyEon/+LX2XerWVDsgVX3sSuAc7ky0v3s8y9lqtD2Q1iwWXwdXTnJ7gJP+VcGdtXZufKMRwNraqnR02BE2hxE00onvz8TGmzrEoDSU0KfXZ3tkV11cnVg/nPrXshjurAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950699; c=relaxed/simple;
	bh=j54AFsNXWN/PAnKWBDdxulRC9UGmY1XTV3XaaL1Faxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=klTmC98d8lBkAkPe/FcGsBHDksGe2VcxJi2hWlu314nQSpPkkyAtadxqShO141cD5vJZjBu4oGqTBfHoHfXRtoPW3lRsKoSx/jICX8khyVP3nHruVQMCPzeiKBInfsCMf1qECZ3jyp01hpJisIIG9gqpF6na3WuftFXKwP5gzRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs8f/8PC; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs8f/8PC"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40b31468da3so49697b6e.0
        for <ofono@lists.linux.dev>; Thu, 26 Jun 2025 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750950696; x=1751555496; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTj0Q074/EvorQzMfGcvPKuWxmakTuY412mseSwrjJg=;
        b=gs8f/8PCimlM9oa/CxwUn9YNZEgqx0TcR0xrf5PL1/EeMgUeG2fJftIMB2iDoo+m52
         snwvmm9V4mmjhuTmd+ypJ6/z+PGk1TRz7pO5ThGemkflQMAQIwvetRpMi2KLIKtq8Ilp
         mIZOj0fyG/yPEjmKOxFosk/ZrBTLjvL13/nTFcZ58keT8qAuNFc6J5ZDoMXlakV8JObZ
         NAbnPHld7vxkJqXVrIFkOXlqHj1fmEfEBeQRy99s9BuSyocekuYxVC5cZMKxRs250y0J
         G3HDbHTBZLIatAuJH4CqA5svNX5a/ulYFQ7WDFepelNBFtNE5r81QpXPW5Na0K6dDn0i
         GOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750950696; x=1751555496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTj0Q074/EvorQzMfGcvPKuWxmakTuY412mseSwrjJg=;
        b=GKg1APaMX2SrLQ8U4kpDfjs8E11PsFmHlzezcRrN911DdXmr7nV6oIEnKMANjPBk43
         /XFrcEY8mcuI7k5BrZbIFMeywyZpqJZElLpN9DQxMkE7QT1tYP7eDfqX5wux6VkcIpR2
         vnpPXvde6QPGlM/ImFokKgnrbZhxagIbEIvheqHANzWIaayaDzrbSnqbvRiVaRJuA23o
         QyRXYi/RNySHcSMB/sv9rjKxopJW6qOK5cWcGjX3/6+XoKiVCn9rqjnR9PGxGFweD3PF
         nyusFtzFidWpxrgZ6cjhLQedUwFLQb6FFoHq+UC0oNcSYs/8IGnssCxBCXUoyCj++vVA
         OKgg==
X-Forwarded-Encrypted: i=1; AJvYcCVXE4mKuB/xEqz/uPtELamZ7q5RRIXu4G+2MXb0gr1et6VfxMmpI6dAFYfTT6E6kYbBwPf1kw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzvtwjl5eD1oq7JFHSPvDtMGAeA5QNfIWsH2sVLHVdcuypCVCGr
	iBd7Qm1thJEufoOda++lcvyghNfvBvLChy3ehrUZF2ldBbs6p7qCnnBEFIrNOQ==
X-Gm-Gg: ASbGncsRemJIiCUFCay+c39s3fiCCf4PusTQfS4rm98PhRhzMQzbv2GgFNAueYP75GH
	DNpzA9fbTSQdfrMwK4pPjfYw6YLKInupCZS7yieDoZBFFe6LiAKCuJMFyBgWERUEmL0Tpj0f8AN
	taANtU8IlHmg9aAICEsSI4hRg4cTB6z0qRaAyOMk3mK+X9FtI0pDysEAvpiPuYz5JNJ+9rNDCyL
	qwHOTC0rIL/2XnYlgHrOUugYvlUQsN88j5zWVh3dqx8FnKCF+RoJx4Q01+XhteBQOCfir+nhTUg
	S7z2yqtNRyG0YoceFA2Jk+QzAvDIiEs3N2l8HKmmoo8zTGBV/Hm/bCcDow0fmXwhSTaeh1lcBV2
	O+g+meNKtSKxIfLZX7dIvELuVgxc=
X-Google-Smtp-Source: AGHT+IEMS/mMwomk7Bt9sG00Psyp5TlhiEaJhZLn5/Ibe3xQDM60BVHtwgeCCf7hi8HgIiu9E/+rxg==
X-Received: by 2002:a05:6808:4f6a:b0:401:cd6d:25e2 with SMTP id 5614622812f47-40b05a92998mr6541674b6e.4.1750950696407;
        Thu, 26 Jun 2025 08:11:36 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-40ac6c1310bsm2543997b6e.2.2025.06.26.08.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 08:11:36 -0700 (PDT)
Message-ID: <3d248eee-86eb-4e92-bfbd-7b736545c0cb@gmail.com>
Date: Thu, 26 Jun 2025 10:11:34 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmi: avoid free of non heap object
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20250626081625.1362728-1-sean@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250626081625.1362728-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 6/26/25 3:16 AM, Sean Nyekjaer wrote:
> qmux_create_client_timeout() free's a non heap object, avoid calling
> __request_free() and inline free_request() instead.
> 
> In function 'l_free',
>      inlined from '__request_free' at drivers/qmimodem/qmi.c:293:3,
>      inlined from 'qmux_create_client_timeout' at drivers/qmimodem/qmi.c:1427:2:
> ell/util.c:124:9: warning: 'free' called on pointer 'user_data_6(D)' with nonzero offset 28 [-Wfree-nonheap-object]
>    124 |         free(ptr);
>        |         ^

Hmm, what tool is producing this output?

> ---
>   drivers/qmimodem/qmi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index 5d2553c5..4468761a 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -1424,7 +1424,9 @@ static void qmux_create_client_timeout(struct l_timeout *timeout,
>   
>   	/* remove request from queues */
>   	find_control_request(qmux, req->super.tid);
> -	__request_free(&req->super);
> +
> +	if (req->super.free_request)
> +		req->super.free_request(&req->super);

This must be some sort of false positive.  In qmi_qmux_device_create_client() we 
always set .free_request, so __request_free will never take the l_free() branch.

The question is whether a compiler is producing this output or some static 
analysis tool?

>   }
>   
>   static void qmux_create_client_callback(struct qmi_request *r,

Regards,
-Denis
