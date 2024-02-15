Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9F132461
	for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029824; cv=none; b=lbCrBia4v+q6ic3S1OLyM7zYaQwXX1xsfmgLBuXR0xztp4cHkLQUR6e8HEC5bKHWDwfxvilVwUvuRuDtJbcSSt2v2mPv+dcgTIpeyTatAXDyKzDh9U7949flal6zEE6P/v49irCQ2fdW+xQs/MUapcga/1NYEPs3gSXwR0vtgK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029824; c=relaxed/simple;
	bh=Gj1iijUWJ20RabWJNCByc8L+BhXaoxE6OLuJ8rCuXIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8dXywTpXL1lTrsHbEa24eKxD7GUf6OV5bkHEbkIypa85TQh7P6tTxfC+ibP7XmXNRxo1z1lTETqWhbbdCu1150K5UUpyayDEPRM2Lx7x2hH0COXaLJGu5Hs27ibspFqd+XCP+lxxUBmD2jeHeRWVzn52kABF3132A7hRCu3I1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj8XsSxe; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj8XsSxe"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-204235d0913so742204fac.1
        for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 12:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708029822; x=1708634622; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q53xUBWRTEgJuZZYQ1wbH/Fpxw5h7Qawip3ubF5HRnE=;
        b=Vj8XsSxeEsc95P8xJGI8veeAwojtlwjdA5VHXRBXAQjeuk3msRcuX/coFKuLX84zVt
         Fj+9je3cwVoiK4fYgyUDkbWVLHXcW7IChzG1/I/y/4fIFd97SRtb2UIgWdBMFRBTlTo0
         lKYTAzDjfYjM/XwfIziz3ttEPBVimB4BiuVooqxutC1LIFSCTgLICvq28DKeOkgMGGY6
         NA+RFrvSmNfRqqFqv76dlvI8gJwiuBTsccZqj7cBQ+hGllMPHstujK6PndVV1mEEL82s
         EjVnJHubtPW8VSIi821GWVo3/MVQylhX8Wb2t9YqJx+//5zqJfjFSTTv334knfDISNWD
         LtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708029822; x=1708634622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q53xUBWRTEgJuZZYQ1wbH/Fpxw5h7Qawip3ubF5HRnE=;
        b=QwE37ssAM5EE6hNqO9Bmi4HlQDIPllOwQUmtGbWyotu2iYzNRXfpJpZwy78X7Hakia
         vITdyJKlDF2MxvGgL9DNpA50/xjnRBzQB2irQVk7MIYqNmheUMTEcnUuySx2k6uuuhhx
         8oEeToe2grtXthcO7jVM5msy2cpEOW4r9CyHaPd1FR1XtKlCrr0o1p6bmX1B49BPFOEa
         Dauq4LTdpm4k5VIwqNf0xw21BxVqKEWpfo25VcUE+Sh9WAa3VKnpfQ1V5NCwcoebE06u
         L57OtIp1+qtxEIDgzk0rwpIAA1P3xuk2bnvBE15iDb6hfm6/iGIlGn3YPLsuqSQv00d4
         tBJg==
X-Forwarded-Encrypted: i=1; AJvYcCVY2wiAimT8U912kF2Hwlv+dBpBxrBpT7am5ZDWM+gPiHKaCmgKDfdlxdnRz5R7q7Aav3+amLPShGBEjUiLwxg1C11P104=
X-Gm-Message-State: AOJu0Yz/oUGLlG0cXmhA6I7I9rh8tP5bzJqbDBavA7S+IeGBowIPkdaM
	AO+T/hXkBJsXypgDM7E1FtTTU56xM/o8E/ldfqtTnKUeA2QBeVqU
X-Google-Smtp-Source: AGHT+IGCm9mIjWC9w3G3tszQg1OOJowSFQDV4Zlk1272696KNjEIl903evVyxldxCHycTr0EMFQxBw==
X-Received: by 2002:a05:6871:79a:b0:21a:3627:efe1 with SMTP id o26-20020a056871079a00b0021a3627efe1mr2830277oap.25.1708029822134;
        Thu, 15 Feb 2024 12:43:42 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id nx16-20020a056870be9000b0021e50e58a1csm216958oab.4.2024.02.15.12.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 12:43:41 -0800 (PST)
Message-ID: <19cfb16c-fcfe-4d32-bbf3-42b71cd0035b@gmail.com>
Date: Thu, 15 Feb 2024 14:43:40 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qmimodem: implement call-barring driver
Content-Language: en-US
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1707981467-2955-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1707981467-2955-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1707981467-2955-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivaylo,

On 2/15/24 01:17, Ivaylo Dimitrov wrote:
> ---
>   Makefile.am                     |   3 +-
>   drivers/qmimodem/call-barring.c | 264 ++++++++++++++++++++++++++++++++++++++++
>   drivers/qmimodem/qmi.c          |   1 +
>   drivers/qmimodem/voice.h        |   2 +

CI flagged one small whitespace issue here, which I fixed:
0001-qmimodem-implement-call-barring-driver.patch:322: WARNING: please, no space 
before tabs

>   plugins/gobi.c                  |   2 +
>   5 files changed, 271 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/qmimodem/call-barring.c
> 

<snip>

> +
> +static uint8_t lock_code_to_reason(const char *lock)
> +{
> +	if (!strcmp(lock, "AO"))
> +		return QMI_VOICE_SS_RSN_ALL_OUTGOING;
> +	else if (!strcmp(lock, "OI"))
> +		return QMI_VOICE_SS_RSN_OUT_INT;
> +	else if (!strcmp(lock, "OX"))
> +		return QMI_VOICE_SS_RSN_OUT_INT_EXT_TO_HOME;
> +	else if (!strcmp(lock, "AI"))
> +		return QMI_VOICE_SS_RSN_ALL_IN;
> +	else if (!strcmp(lock, "IR"))
> +		return QMI_VOICE_SS_RSN_IN_ROAMING;
> +	else if (!strcmp(lock, "AB"))
> +		return QMI_VOICE_SS_RSN_BAR_ALL;
> +	else if (!strcmp(lock, "AG"))
> +		return QMI_VOICE_SS_RSN_BAR_ALL_OUTGOING;
> +	else if (!strcmp(lock, "AC"))
> +		return QMI_VOICE_SS_RSN_BAR_ALL_IN;
> +	else {
> +		DBG("Unknown lock code %s", lock);
> +		return 0;
> +	}

Also, checkpatch warned here:
0001-qmimodem-implement-call-barring-driver.patch:89: WARNING: else is not 
generally useful after a break or return

Wasn't really worth fixing, but generally the following form is preferred:

if (!strcmp(...))
	return...;

if (!strcmp(...))
	return...;

DBG("Unknown...");
return ...;

> +}
> +

Applied, thanks!

Regards,
-Denis

