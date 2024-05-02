Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74B13C684
	for <ofono@lists.linux.dev>; Thu,  2 May 2024 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658654; cv=none; b=UdCgLa5rjIi5z2WTtT2ncWF82+VVzXaM2X4XLAXaaZu0PwtAj7X4wyFx3VagcMjHxeTsEWUuUej3ER8qBW9edcFjwgr5127QDXLZU4hH26CpeIm8HfZB5dpW2UgEJ7ID/tSlPpXEclYDdD+yr5239ZL/jW0AUX0IJVoZhv8Dwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658654; c=relaxed/simple;
	bh=RHFHQlvAwIgAM4qeVCysOZOyyAwiZ0k046U1JqopR/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J259CBdZifUQFsiV60oPX/1lTeYVxRZHQnBo4J5+I4QL/KjW6a4/SXHOO567JYRgYjzNyKKd884vKoozXowzFM4qFcDn//1Eyk9rdnTl8Qj861Zf0VZiYotY+E/qxk/F9s6ciXaiF4a7S/pDFYQqGAzrasY1Gc6/OzTyTI9ZMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZO3mzf+; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZO3mzf+"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ee3231d95eso980791a34.0
        for <ofono@lists.linux.dev>; Thu, 02 May 2024 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714658652; x=1715263452; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EVfVN7Ums45n2UwvX7Pgn0CYnceXp5afryOAAERkWlo=;
        b=BZO3mzf+qpOLPgrlGQf+v297P2EZZ5+QMl1z6Gt55n53y4UqrBzOz+wBYoyvsze/VB
         EX81gXmtwQEKfqVCjuru5fseqR7NmcWbh8s1oP2sD9XbtTKRWqHqL9Ag7hKC4lPv15o6
         jfFv4YAtf0/KAzpTm/F0l/UpqjUQD8EP4Q4f+Zm8HiVo87AFq4H12Uk7hWmZ7JWz3e+T
         Xh5lnP3Fx3zVTmNWrhzYdO3DOpwmyfHvwYeq+l6hZhUrHJ2bbA06jvjw1SS6xQOEJGbH
         NQbRu4bDFI3bPNIDpadxMdPQYT4UY2tL82t2ozSmt9+rKr+bears8zNRmQlvQbE53bJY
         7iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714658652; x=1715263452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVfVN7Ums45n2UwvX7Pgn0CYnceXp5afryOAAERkWlo=;
        b=ZWpHZI6d9qkXwjFA7dj41Hzp0wciPPAv+4ecIcgIqto+ALT7e2JHR6WoZkRzl8rTJe
         SKo1cOA3CaIFeu92PZPfSo28aIB6QwSnIiccy7FR1IcrYVNaAEhusL0Ua9tFceUY0MoR
         4pQYPM80Uyqci6n17xBxJBwfrP99tqs6B4IlOf9kNSZbOIOY8tjCF6pj72Lpnm2/THR+
         Azq1tyv+vNRP8HL2UZ7dvehyfDmA7G9t4a6zsPRoJMe6uo1N2lOyVsb0dA8mudmjsfB6
         El2FAtAj5ewSsojcN5S8TdpmhXfKRNZIicX4u1wMbrOb4OFfnF2gEAsxaBinrPqBKUMe
         DQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHE9kIRgqscY3jvKkYlEtDx6AqQnAFr3VCtO7gbuKKAQjgTCjytaIcLDnVOb+Id1ts5cjL+0HVD53aWXtaivwcIjdM5QI=
X-Gm-Message-State: AOJu0YyMGk6+EgG8S1N4VcASFCrWUd/y1+TSyR92UHzJ1PjQ6Vzr352I
	x7pB5cIWIhKnpm4vbAn3vUdDGgTWcLMHZQ0+3gRwg/DWnj2rg9enCvMF2A==
X-Google-Smtp-Source: AGHT+IFIfEc0MBPMTiOHiO0yoRxoajEYCf261qcCmjZaWc6uajMa90GbFC2fH1yEQQ39Mc9syni7VA==
X-Received: by 2002:a9d:674c:0:b0:6ef:881b:82e5 with SMTP id w12-20020a9d674c000000b006ef881b82e5mr1093819otm.15.1714658651879;
        Thu, 02 May 2024 07:04:11 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cs11-20020a056830678b00b006ef8c06a8d9sm198861otb.34.2024.05.02.07.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 07:04:11 -0700 (PDT)
Message-ID: <1dff212d-a996-4782-841f-9811a75b7a00@gmail.com>
Date: Thu, 2 May 2024 09:04:10 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] sim7100: query device model during enable
To: =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>,
 ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
References: <20240430115234.180185-1-martin@geanix.com>
 <20240430115234.180185-3-martin@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240430115234.180185-3-martin@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 4/30/24 6:52 AM, Martin Hundebøll wrote:
> Adding support for more simcom modems in the sim7100 driver requires
> certain variants handlings based on the present modem model.
> 
> Default to an "unknown" variant to keep the existing behaviour, and
> introduce the A76XX model to use when later adding support for the A7672
> vartiant.
> ---
>   plugins/sim7100.c | 43 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 40 insertions(+), 3 deletions(-)
> 

Nice series!  Thanks you.  This patch was applied as well:

> +
> +	if (!ok) {
> +		ofono_error("%s: failed to query model", ofono_modem_get_path(modem));

I amended here to avoid > 80 char line.

> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}

Regards,
-Denis
