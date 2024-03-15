Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0738399
	for <ofono@lists.linux.dev>; Fri, 15 Mar 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510963; cv=none; b=XmxT1Mx+yOeTkWr/xf/osWBIY4xey7uDy6nFX77Xn6N/6hkbxUL+P7UMx2k4STjx5isQ2MYTS1JWd943X0mmdRtY17amQzgGbOFRdjE0aB1c/q7UozuvspO6nupRP49+wmeMo287KApJb9jl3Ij/hkbttd+pKDNL1vkzKjazJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510963; c=relaxed/simple;
	bh=fRLp6HgOvrpMwL5rQdmSArr1Kz0Vos7/eFTNgfqaelE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dfCPAYTaNK6DsuoyI5ZIOYsHsLzlC6c0YvIodXP5vSe0HJfbcL+ufA4odh47TIdfQWkQn6Sjz1TlIv2b0FBlwmk3kbWGwK3eKq3fbcBC9CIhajmtr2xecSV6jy+sNsgl/4dqJ/Ptl2T+GHp2B27kJayn2fSimSEY6HVgk93g8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiljodUb; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiljodUb"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c25eaad717so1046112b6e.2
        for <ofono@lists.linux.dev>; Fri, 15 Mar 2024 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710510961; x=1711115761; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VaZ9HlPBeT82GjCZU527Ki/p0Qo/pAyneWIno2D+nt8=;
        b=RiljodUboqcS9cHWLrDLqglZYfeWEgYWJfnt4C8lmOBEG7sZFZx7OPmJ9AzXKabKpm
         FYoK5IQqm+zU8hN2i+u4lHyhXLm2CwTqgWhAczMtTSeZ2zGJZhLL8cpL+Eq3KpMWnJWk
         EXFC0J54H+kX0iGzrWZtuWZQY+vyj5Yv6YklyI67V+vy+IAr1PZfCnh6aG2ldpQ8ZnGC
         Gk4SNMeRZniHzOvvNNqBg8fdZMaI5EJQxh8Y7xSJUapDkH1ENubGDkD3sLvZJ5RuOTRi
         sXSC0DTXB0DC2DXbMCVOl0LXJO16FqpeXWMUhbAQgMHwrLWo0xembNNNBlGgvk9tGpV5
         yY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710510961; x=1711115761;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaZ9HlPBeT82GjCZU527Ki/p0Qo/pAyneWIno2D+nt8=;
        b=gdkOcG5KiSVSsYkqOnm9MPgSsRR9cOCGbgp79DvF3J4WTxGAqeCF2umolAHBJZpwLf
         vrp+qlcFQno5RtZuXDX6ZpW3wT4GXINtH16tX7HfO2v1xCj2DbzSaVZxdpDfAvPXY0ga
         YONfDktEzsK7URq0oV3MY98m54Ictu/2+HQKBV6B7oQGdsRaOpz5nDVOrzzTZv90K8kY
         vGP9nTQiaPEy1ThRf5l63ZhFfMJJDfEmjPSyKRgNNefpl3pnTSjVy/COHa0C8US8JcgV
         wo408o4N43K1ONHujq7vdfouus7gaxEiLiNOYOO/1+/o4beNx/M/V2c/IcvRbuYjZDX1
         7IKA==
X-Forwarded-Encrypted: i=1; AJvYcCUv5Ux4SQl1NmKcW5m6SaBoTDy0wdtW2p4s/Ka1G4Ys6TUMS1syo2seUhavdroI3o8S1Ds/7PloiNLSljXGBZFz1aHpWdc=
X-Gm-Message-State: AOJu0YwRBQ71Ui1rptdjfIT22kHDOgf9dlQc1Krd1BaIdws0ZhwPHRMo
	95v2ZWCfMLZCgDG/20PqhFKjpUrOKk4Arj53nPEH95QWEViV+3Me
X-Google-Smtp-Source: AGHT+IEn4NE3TMhKBvJBy928BTadX7NDk+ODluaMky1UW2VjP9+gPcN2setvMDkniwu6jrbpPzChJg==
X-Received: by 2002:a05:6808:4c89:b0:3c2:35c8:529f with SMTP id lt9-20020a0568084c8900b003c235c8529fmr3975515oib.52.1710510961554;
        Fri, 15 Mar 2024 06:56:01 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id be35-20020a05680821a300b003c362c5ee6bsm516794oib.52.2024.03.15.06.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 06:56:01 -0700 (PDT)
Message-ID: <472c1fd1-45c4-4721-a0df-76a60ccc3944@gmail.com>
Date: Fri, 15 Mar 2024 08:56:00 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible ofono patches
Content-Language: en-US
To: piggz1@gmail.com, ofono@lists.linux.dev
References: <scd9r5.saa0vh.2sch1i-qmf@smtp.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <scd9r5.saa0vh.2sch1i-qmf@smtp.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 3/13/24 02:59, piggz1@gmail.com wrote:
> Hi all
> 
> A few weeks ago, i started a personal project to try to rebase the jolla ofonalo dbus api's and changes ontop of current ofono.  I am writing about it here https://www.piggz.co.uk/sites/pgz/blog
> 

Nice!

> My current work is against 2.5 with patches that are somewhat working with my pinephone. My tree of individual patches is available at https://github.com/piggz/ofono-upstream/tree/main/rpm
> 
> I wondered if anyone would care to scan over them and provide feedback as to whether any are suitable to upatream into ofono.  I appreciate not all will be, but with some rework, others may be of interest.

Hard to say since the commits lack any context information for _why_ the given 
code exists and what problem it is trying to solve.  Perhaps Jolla can help with 
that?

Also, I'd like to eradicate the use of glib in favor of ell in oFono, starting 
with qmi modem driver (which is now 99.9% glib free).  To this end, my 
preference is not to accept any new code that is glib based unless there's a 
strong reason to do so.

> 
> There is a working voicecall implementation for qmimodem, which includes a refactored call-list implementation.  Many of the others add dbus interfaces for sailfish so may not be interesting.

The voicecall driver is definitely something I'd take upstream and can help 
shepherd along.

Regards,
-Denis
