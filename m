Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46425A2AE
	for <ofono@lists.linux.dev>; Thu,  3 Jul 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564620; cv=none; b=jT9lC6gRUnG+mE2Udyj3bCUXgjsvYQwFZ8I/tts98UXKizB04VAS+D79s73tDQBAR3/Y/3w2VkoYgqeyn4A7Nrm/IWfERSvhR40/nbiPF8DZ6i8XibMcOVBxNUL/nabEAqyFkCrHZ52zk+BgplTwZIWEl+pAaYUQRbIoxV+4sVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564620; c=relaxed/simple;
	bh=OwQbc/pMmAo6sr6xq2jH7I9T8lMi2l1YDhXiK/oNk9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KHnpSpRjpj0CB/1zoC2x3rrk1Ee+aQTICbwFuEpl0Mgz4Ffla4Ikg/B+p/3eYJ8/GRFX4Le/mLqSBrOlJ8G5iC7JGVSPP+UHOaBXYz/jE7ZkvtTbHJaSAcVELm+Bb5HBq3XMZOJVOUWXGU/IXjpbzxm6xpVlgz4PRbp0n17CRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dtdchx4k; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dtdchx4k"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ea65f5a0easo115440fac.1
        for <ofono@lists.linux.dev>; Thu, 03 Jul 2025 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751564616; x=1752169416; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eMlFrbBKvInpfCREPWczpldvZDk8fZMRBRdUmzQ1T0I=;
        b=Dtdchx4kXWwVG60Hd/SZZqPyTENzyFu5t57XnLLBxBzyz814QqbNRFILvBzq2/gVNw
         Jlg37PfzYf/3cF8VMwnfUsSsTmm8SRuvEgvFcMseO2z9POrzvaLTgnn1p25VohmZgAt0
         FIV8aQlAMqQmKT3vvEF5Icd01nGgayrmbCGu5i56t6whO6o1L+IaUnvcu7YoUXTDCsJi
         KrZQCAbMIpEKz77PIDP+zCbz+Y6/wJxabULNY59aKmDnCKfByuhK58/bCQnJH8ErHjH/
         vU7wBgmpaH4UEZVz5dalaRaSYSuUWHiwu9xagZ2yxRquVW/5RhWQ6F37uaODJnKPwpil
         m6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751564616; x=1752169416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMlFrbBKvInpfCREPWczpldvZDk8fZMRBRdUmzQ1T0I=;
        b=tY42zK4mTaLHVQmx/FVotzFG5ayU3dctepfCMO+N+V3h44ioLrvY3XhEGA2osXuqRA
         xpNP1FtBWHqqUC5r2TnDtfIq/lUiet0hsBLNwBUN5njR4U9MpayIXIpFiibwDbXCbvE2
         rrUqW/4KKka1bmOpU/P3qrkuI1k/CTwx8mNQuzeNNBNfCbiorqO27iY+0KF/v2LH5E63
         J7hwSLnQZlMGrlvk7mji7E5EPQzDvL8WzIfWvYU8PVdOXrYVYW7AgSu/Ka0m+prPrQDP
         Urn8tKFyBESMkRkFcvMSIsL1pQ0PoC07EtfQVTAxfuopPbIN5apF4GMj80GGCchIdkyg
         7GoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxPqM31uyeQImmDpRbo4Mvjj5CV62bz8jHeSxM9jBuvnrhpbEFHpWlEEV19pMyGcvMNdIThQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqFzlMOwIcHa7jU3gqxZhp/gTeh0Ypqu+jOOPwekhvogRS/4pZ
	wAEFE5dSNUdSWIvWJ/5acTvQwr3oN9miiylUMvyeIIQ7nWySVtLae4VSN52bHA==
X-Gm-Gg: ASbGncs096oUn/GECti41YdeIx3z0L15S7hSuS6t2hkRHzs5Dfzv0XB4qTxwcV6bWe6
	pkWBZliI3Mmiv5sk9CgPYbVxyGy4juMrNefHLDl2mZG/Yrljn26NV3OknZrXUxeJD2DqRq4BGw8
	NNz7juC/IWfiI0KMwxvtTtGFYzj8Tpta7KVtSriO73uAYfiDCtA+yo1Xo2rEhMYpncpZdX7tw5v
	ZYEQfkJZz4OyfMMgQ+dyTKH1Ov32/81FZ8rmVI84svPtZaDHtAV+FoVWS+K5EdvZsW2bU27KYAK
	CtNYDAfW3O3kgBfQGgA5HyCohy5Q13OsLbaOYZF7oN4vCO/0x/nubeHGtdjIBTPbpbAqpWBpwIp
	RPLXJ0DURdHf9Db3VfgLuRaHmwJA=
X-Google-Smtp-Source: AGHT+IGh8dBVpvarVYjU3EgZmB9EZ1n1MWO+XiFSykaDZUwoKdWLPfeggfl2aWtcc7jA7RFn4FXHqw==
X-Received: by 2002:a05:6870:c14e:b0:2e9:8f40:9ea2 with SMTP id 586e51a60fabf-2f79024e3b6mr93206fac.7.1751564616138;
        Thu, 03 Jul 2025 10:43:36 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2f7901a35cesm15197fac.32.2025.07.03.10.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 10:43:35 -0700 (PDT)
Message-ID: <b5d9cd37-3660-4853-b8e4-1e8440c4b646@gmail.com>
Date: Thu, 3 Jul 2025 12:43:34 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] simutil: Add forbidden operator list fileid
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20250703-fplmn-v2-0-6eb6335a7b8c@geanix.com>
 <20250703-fplmn-v2-1-6eb6335a7b8c@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250703-fplmn-v2-1-6eb6335a7b8c@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 7/3/25 6:48 AM, Sean Nyekjaer wrote:
> Add the FPLMN both as a define and as a entry in the struct sim_ef_info.
> ---
>   src/simutil.c | 1 +
>   src/simutil.h | 1 +
>   2 files changed, 2 insertions(+)

<snip>

> diff --git a/src/simutil.h b/src/simutil.h
> index 91be5e2345d39bfe4f4f25f5f4c6b8dfd4e8c3ea..556412c4eaa089789092caa72fc3d8dd7ad5b00f 100644
> --- a/src/simutil.h
> +++ b/src/simutil.h
> @@ -40,6 +40,7 @@ enum sim_fileid {
>   	SIM_EFBDN_FILEID =			0x6F4D,
>   	SIM_EFCBMIR_FILEID =			0x6F50,
>   	SIM_EFEST_FILEID =			0x6F56,
> +	SIM_EF_PLMN_FILEID =			0x6F7B,

SIM_EF_FPLMN_FILEID?

>   	SIM_EFAD_FILEID =			0x6FAD,
>   	SIM_EFPHASE_FILEID =			0x6FAE,
>   	SIM_EFECC_FILEID =			0x6FB7,
> 

Regards,
-Denis
