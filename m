Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82BB1BC53
	for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819916; cv=none; b=ITP77ehzyKimH7ZlObRTmrw73JgvlzvXt5wAEyaoCQCVY3+N2Wlt3iqzxLGt0RJ0eiV+72kZ/2n7p7tdmyZSWamakCtHlkW0S9b98FMhA6ERapI6AT1gtvMN6x+AGGZPK8hiS7U0VEHO86Nnl+RBSWQBDWa2Jl0hLcti1FPYnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819916; c=relaxed/simple;
	bh=kOsONwl/32JzHZs++K037eR3lfPLNeZbRpsY6vNTkZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fLj7PWQmZIaVjl7wvZlKAoA2M4PJ9JAJBTe3gC4Uq1FjXmq0J61vQYXSh+A7Zh0wc/1NoVYGLGAAp6S10GBPubnQzOXFRU6/maabCKKF7E6giluNyekS5h+QM9Zeq9BIYga7NNt6euQBJ4lG0+OSWieNr4l4FBnFlZHy3tghPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I65SWcBH; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I65SWcBH"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22f746c56a2so2281917fac.0
        for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713819914; x=1714424714; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9xLxVzO4envn/YI0aeQ5x003lISrKvHcLvuTDMsrAU=;
        b=I65SWcBHQUaIVJnxsA3yDV49xH6sde7tUQrWONfGEtu4Ud2JGHh541K8ed8mi8Ttnd
         PL5QfwvVkYw88eHEcJ+fucXa9U0w2BX5PCO5MJjAuGzicC09Z7SWITopd4HsW5IB7FiE
         nlDZxWtDLMhyMf+kXgu8FXlbW3evXxPytjtKrD/PA7vBjuWISiIeng6wMr8HYz6lMcc4
         +NKWWy9wDyeqohw4JdKdeadkCpqcLzX0Qz0pyx1DtHYc/2oAYiXFodl2dkmcZQhjaX22
         F7IbX6zoipX3dYraj/FShbVL4Rvb1KfGJO5Hm+oXeHqJagiT/iRgi4lIhW2zFYgp+9d5
         AeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819914; x=1714424714;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9xLxVzO4envn/YI0aeQ5x003lISrKvHcLvuTDMsrAU=;
        b=hmJvYA3T1xyzRbeSVnoHV+eB2tuHRQI6yGb24dvWavcID+25Dulo40lTJPbS/ICvEX
         NPMLpLxC0kPECVDyktw8loiwBcIIP7hFX9X6D+T7oOS0ATQoheXrrcwvLqmxoN+lV8ym
         3CPswiJweZHUMlF/jYxqy99JS1cdQ1Y0z5jkCU1bYqvhugNPKV7yj9fFbat+peAgz3Ih
         8ZVW5ONBo3HiH5tj+Z1Cul5Nne1P8OBwkP8rVpiyjt7crQDWeAZp/NnEGlgn8WJGJd2g
         hSBWpGHrKEnw4vOk59sZrysx0AmquIggFqrdx6i+K9tv21yihQyk52Ux+XNdByCLJ1xZ
         1HOw==
X-Forwarded-Encrypted: i=1; AJvYcCXQq0GQfnzfJBUCxSQ9Lb33UOyrs/l3TC6Msjimfq3TzePlarB65ctVVSng4bmwy10PWt8/Jl3kDAwK9uuHwHIeiN8REUM=
X-Gm-Message-State: AOJu0YxsYnBcYVxJUq93tKFlp8QxswHh34+DUeiJeInpZEKKdVmLMfhY
	dgwpBPMLalkiJE4ujJgAPGJKFM4iVcy5+E6pDxJhikEphCS8pYF6xKWQTA==
X-Google-Smtp-Source: AGHT+IE2m+v8pRXih9YLQ9WvY7rmm3U8gNCs11hyUdYMrx6WbBSYCqAtfMNHn52RrwOdCq0Jv6f39w==
X-Received: by 2002:a05:6870:548f:b0:22e:c697:5769 with SMTP id f15-20020a056870548f00b0022ec6975769mr15476755oan.42.1713819914011;
        Mon, 22 Apr 2024 14:05:14 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id i21-20020a9d6515000000b006eb958c4b9asm1748113otl.30.2024.04.22.14.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 14:05:13 -0700 (PDT)
Message-ID: <76b4e613-11de-4849-abd9-6e41ec7498c8@gmail.com>
Date: Mon, 22 Apr 2024 16:05:13 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] qmimodem: voicecall: Implement call dialing
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240421194926.13149-1-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240421194926.13149-1-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/21/24 14:49, Adam Pigg wrote:
> Add voicecall dialling to the qmimodem driver
> Includes required infrastructure and setup of the QMI services
> 
> Call State Handling
> ===================
> On initialisation, register the all_call_status_ind callback to be
> called for QMI_VOICE_IND_ALL_STATUS.  This will handle notification of
> call status to the rest of the system
> 
> Dial Handling
> =============
> The dial function sets up the parameters for the QMI_VOICE_DIAL_CALL
> service.  The parameters are the number to be called and the call type,
> which is currently hard coded to be QMI_VOICE_CALL_TYPE_VOICE.  The
> dial_cb callback will then be called and will receive the call-id.
> 
> ---
> Changes in V4
> -merged qmi_voice_call_status and all_call_status_ind
> -several minor structure/formate changes
> 
> Changes in V5
> -renames ofono_call_compare_by_id to ofono_call_match_by_id
> -updated new_entry pointer to fix use-after-free in
> ofono_call_list_notify
> -Renamed several constants
> -in all_call_status_ind removed error label/gotos after restructuring
> -When creating the call list, ensure an upper bound of 16
> -Fix out-of-mound-read on remote number due to QMI string not being null
> terminated
> ---
> ---
>   drivers/qmimodem/voice.h     |  17 ++
>   drivers/qmimodem/voicecall.c | 426 ++++++++++++++++++++++++++++++++++-
>   2 files changed, 442 insertions(+), 1 deletion(-)
> 

I had the following when this patch was applied:

[denkenz@archdev ofono]$ make
make --no-print-directory all-am
   CC       drivers/qmimodem/voicecall.o
vdrivers/qmimodem/voicecall.c: In function ‘all_call_status_ind’:
drivers/qmimodem/voicecall.c:348:9: error: ISO C90 forbids mixed declarations 
and code [-Werror=declaration-after-statement]
   348 |         struct l_queue *calls = l_queue_new();
       |         ^~~~~~
drivers/qmimodem/voicecall.c:364:17: error: ISO C90 forbids mixed declarations 
and code [-Werror=declaration-after-statement]
   364 |                 char *tmp = l_strndup(remote_party->number, number_size);
       |                 ^~~~
icc1: all warnings being treated as errors

I fixed this up manually to declare calls & tmp in the variable block to avoid 
ISO C90 warning.

Patches 1-3 applied, thanks.

Regards,
-Denis
