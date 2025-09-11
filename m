Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1B733A028
	for <ofono@lists.linux.dev>; Thu, 11 Sep 2025 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601840; cv=none; b=dSIWz1RCcdKvOQS8nxiF3JmFePVALyyeFVGxqaCQdpPqrzDxfbVksdDOApx98RSB+I76k38xQ1FtkwL2b/7gkwBW8vp48HTEl8fffIf3yUUW3k/cU1W/RXScx6UiT3JMDaFbn3jgh9PTlE335iR1DzTF9n4DPklfKbXSPIiB8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601840; c=relaxed/simple;
	bh=lxpmJTwoB2YsPbnFudZ7z6deZ7QNM0nh/pSOJGfcYG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IQaGGtA2dcXWknTe0cRYtP6mNMOhRHXiXL4M3VLhWzwdArkv0Rv7VVgN59N2m/EIRqHoGxuNFDUWNnv19CrX+bc9I7I2td99N388naAehrvyqXCct0gVkmjR5aqmpmSaA30BT4Cub6nfXVqsK+Pbfni01fwcdMX3AAOi8YoQV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjJON5S3; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjJON5S3"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-621b50dca6eso300088eaf.2
        for <ofono@lists.linux.dev>; Thu, 11 Sep 2025 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757601837; x=1758206637; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqZhK6vYPJr8bbJwXpYeI2FnOTb/LabcPfG4yYund6k=;
        b=OjJON5S38uJU6s+spEwKalT9Aw5lbYeGUkoV3C8OMY2ARqI+PZMkz8/Jx1DRxskY4u
         vm7wO0sMWUBL6LSUO/lasLRxE6s1LrG2Fp8ZGKoaSRlvPs60+VobP/TRqbXMeIEp+in2
         1P7OCz0gJy5021rcGKfHpWUwXzG8sTNfCXUSzzSRyrXa3H1quFcejv+A2qjZ3PxHEz36
         os7g8s9/RurdAQsELcs6vk+AaGyKj5nbIzVcsFbCOjLt9Y/cA6jO3YhlP7TS7a23iy48
         fF7vchUvCmrszRjCNOgNBAHzHWd46nanzO5HT0ejzwbjvDzjm8JmTpdkr6o7JVkmS76e
         HZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601837; x=1758206637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqZhK6vYPJr8bbJwXpYeI2FnOTb/LabcPfG4yYund6k=;
        b=E/nrATAEGiebHSpbhfMHXLed8JmU4iPZLMLHdaNLvDWimK1eIpJ7J71JIGcVv1MC8D
         YvxAvMEO+0DuqBGb7fZ83AvAahaZfi37asXDtFn1kcdv5Qio4cj+YlFc8P/B0pk+RRKR
         oENBuwkgiwIuH2FLEeQO8guSR9gjvNJkCg6k9wV3+zT8C/6ci3yt7OpzSIC/leqrrbQk
         KgwSeHrk6UlsbIucGiB7U1Oe+hvQOA5Id1ULr1SsA7kMsHnp2hJYmUFVVCYdzNJuzwK9
         E64BgLvM7vrnA5EvknKcSUddDAgP3ce23h7jP6xFhWLqGeYoxjDTnlPWARf89M6wiGyH
         KwXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkXOPwGpz91yMibcYMgDDzsyocfnHnURqaJJl9SqlSvDJIIFWGEskam6F/PWTQkOfcPGsFOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyePaeP6GCe8DGHZTHSo08m/obpVcsvhbtiVtnkVVnTOCzzmYa+
	WDRyhXibnL311lvBO9JXfUtWf+vesFkwYNe9A91Y7i25CY4eTKnjdYN0FC7ssw==
X-Gm-Gg: ASbGnct78EhTE7UllD1tMnrbYpyUG/RkINLGSywMk5kyVm7Mmb3sSHHlZvky1CLTlGH
	yqgeCbgub2Xhc5TQOrUiOg5miLPgt64FXGoYAmowgffr+DcVXD54VUdSpWKlEuu5rdngp80T5Zt
	sqffSuakOmp4p9eHOCZx6DWfT3GWO5ExIY2qjf9giSdCRlPkwwMvFxUA7SdIt2SbepR9MoqPexY
	/BZAW8Ik6Jr16TGOmmKr++ghnroVyxfhujtOjGID3KuHbV5/6KkOfKwsTsaa8Prodvj7cR7dqOy
	FrHcSLeBkGNL9cadf2mubdwE57hX3trCQALjvU7CIC8mz0SO3csPrsciMbHTEze7bexaSz+Go/w
	DC1vOVdaNd+yYxMnq6brghtWH5r69wpw5D0dANPwVavCkjZlDvpKHEE3qNEWHr3AZ4QMuDUQTYK
	22ViFZCBl1mg==
X-Google-Smtp-Source: AGHT+IFvZF2L7Zglm72MvvZSb4vMXVBEoWJW55Pe5lwtYsYZ7as4f2fIchafFQcre1/BXm1h9OWj9w==
X-Received: by 2002:a05:6870:524d:b0:322:2712:c89d with SMTP id 586e51a60fabf-32262c73978mr7546557fac.11.1757601837312;
        Thu, 11 Sep 2025 07:43:57 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-32d358d5a3csm448341fac.25.2025.09.11.07.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 07:43:56 -0700 (PDT)
Message-ID: <fc280e2e-5707-44ab-956d-0bc7d9ff19d1@gmail.com>
Date: Thu, 11 Sep 2025 09:43:55 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Quectel modem ceases working
To: Timo Ketola <timo.ketola@exertus.fi>, ofono@lists.linux.dev
References: <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
 <e87a92d3-3e5b-4e5c-aab7-2310697b9fa7@gmail.com>
 <e400c04f-1550-4263-9f21-ce1476e12c80@exertus.fi>
 <379c6d32-28be-40ac-a055-0ebcf13613ea@gmail.com>
 <f5606785-6f7d-4363-93e0-39696bc30bed@exertus.fi>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <f5606785-6f7d-4363-93e0-39696bc30bed@exertus.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Timo,

On 9/11/25 7:45 AM, Timo Ketola wrote:
> Hi Denis,
> 
> On 10.9.2025 18.31, Denis Kenzior wrote:
>> You can try the following patch though and see if things work again.
> 
> Yes, it works! Thanks a lot!

Nice, thanks for testing.  I cleaned up the commit description and pushed it out.

> 
> Regarding longer term upgrade path, I'm completely on FM-broadcast-band
> (finnish idiom). Is it Qualcomm/Quectel FW or qmiwwan Linux driver that
> is the ultimate culprit here? Or is this modem completely deteriorating
> out of support?

My comment is mostly about the kernel version.  It is impractical for me to test 
changes on old kernels or to support legacy driver behavior.

Regards,
-Denis
