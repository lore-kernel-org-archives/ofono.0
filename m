Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291E1DA27
	for <ofono@lists.linux.dev>; Wed, 14 Feb 2024 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952212; cv=none; b=GkbeBO6IBFqXnlHL0z6wuNDdTUdTQJIfeVCrRJhDIjBQhBxs6rbSH8BjolR5GuHGjbFK3lTd/yPt+YcS9yMqWMmdZwSERjw+QzBNx8Ac+MeJp3l5jkdv2Ts0CY3ybSy3eJuzBxfDLrtAauMBIguWKwm0Gcy/mBav65t+SVlEqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952212; c=relaxed/simple;
	bh=2mlCdwTwy3pGZZf6K0ogMaodQf4EHpy9BpJRutmSA0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0KBsE2qR0EQdPnKSuJYR6mA952EDGD805lf0mSL9wDNszz8le2AhnZceRXRiBrj8owNGldGEuklqLyPbkpRmgRYIZEtNzUOpZhSbHTw/6x7IrNzpiO0PDa4TIo1MeJYgz6jM9LsZQPtWD+I77ZzdDLWJ+EqKmMkHHi0HKo80qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDX61BKx; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDX61BKx"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd72353d9fso235080b6e.3
        for <ofono@lists.linux.dev>; Wed, 14 Feb 2024 15:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707952209; x=1708557009; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDLJkUVXcxv/XUC+9Yw7/EhFC/vkookj8kEYWIOpbvI=;
        b=YDX61BKx9mbLvZbcd+kAj2BLUER32Rbpu02OBkLR7WjmD8jYtzlO6c3tKvNI3t6eat
         RoeZvtTe/YvHmRVtdcnFAEqFPy0yMsk4BgoJYd1hu1jdVqxl3+kvq7Q0AEZ4yE9bpZi1
         JB6y+IxpEGTtNukRhfssNDKYIdamTbzGISqZdN7rDVM8wjgnkDGb7iQpFn0nJ1Bzaskn
         ZOrHkL0en8i+i46XUtLfonb6hMevjOib/9F7rrO4IE8Q4acqgQP5wyU6RVEAeyddpvr+
         yWj9M8bt7HmovsaBP3XC67kfziZbgii7DUZDyZVSIUyke34vlS/n8ebsx/r9Dyc7wE9S
         qYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952209; x=1708557009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDLJkUVXcxv/XUC+9Yw7/EhFC/vkookj8kEYWIOpbvI=;
        b=wxyPQqG2a0YhG8cg53j3xcXL2OEu3gCurTLzRWiFkgBCioegAXQrhEPI6OECefDt/6
         FcMgXa/KE0W+le87sXsz+Vxkv5TbGePxNhyaDvhKytmU3NbUvp88PFft5ZTJ0dz/T2ql
         +NuuQ6fYrd0MrlYqn9pluWI4iAk6vy9DFkKt01aQ6IUJuBFwJcJu6xjE64MQMMw2of8M
         f3qBx4igNVbFw4q1M0S9EH85gc10ypH+XeBTrbhflbdioIL7jThvOLNSlsiGOmxXnnzH
         aEm9U043AJh4nli1fuRSKwBdpc6AwNx7BfS6m+QqJZ6jjAgbYu+DYtcgCqd35gLmG+Om
         cakQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+Bj+uiPLJfdL1VAOnKNHABU39Tws7czLFIDrxsXs14fish66KLqEGN9X96BrC9KI+MjDu/V1JRAt91R/PO7FGJ0hORs=
X-Gm-Message-State: AOJu0YyZQwrJflviHv/roA3AcfQFAEec3wxtuCPCYp2bjUXWgN5Xtrbs
	y4ytTF35z4v8mPbDIBvkfelp8vDGGuDdM2wGM2gBUJ2ZCJ/+IULG
X-Google-Smtp-Source: AGHT+IF5u3HRO284AI7QkIiOhCKLuyYDSFTGhc3rt9AavmRv1UrPUJdSv86yS+MJBv2ADrz2LqmEIA==
X-Received: by 2002:a05:6808:1292:b0:3c0:3428:230c with SMTP id a18-20020a056808129200b003c03428230cmr310653oiw.32.1707952209498;
        Wed, 14 Feb 2024 15:10:09 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b19-20020a056808011300b003be5eb79182sm15752oie.49.2024.02.14.15.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 15:10:09 -0800 (PST)
Message-ID: <a5f8fe01-aaf3-422d-8fde-64c8a5ae13f8@gmail.com>
Date: Wed, 14 Feb 2024 17:10:08 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmimodem: implement CallSettings
Content-Language: en-US
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com
References: <1707892328-16334-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1707892328-16334-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivaylo,

On 2/14/24 00:32, Ivaylo Dimitrov wrote:
> ---
>   Makefile.am                      |   3 +-
>   drivers/qmimodem/call-settings.c | 346 +++++++++++++++++++++++++++++++
>   drivers/qmimodem/voice.h         |  45 +++-
>   plugins/gobi.c                   |   5 +-
>   4 files changed, 392 insertions(+), 7 deletions(-)
>   create mode 100644 drivers/qmimodem/call-settings.c
> 

oFono CI is still a bit of a WIP, but it flagged the following:

0001-qmimodem-implement-CallSettings.patch:288: ERROR: do not use assignment in 
if condition
0001-qmimodem-implement-CallSettings.patch:300: ERROR: do not use assignment in 
if condition
0001-qmimodem-implement-CallSettings.patch:305: ERROR: do not use assignment in 
if condition

I went ahead and fixed these up and made a few other minor whitespace cleanups. 
Note that we only use tabs for indentation.

Applied, thanks!

Regards,
-Denis

