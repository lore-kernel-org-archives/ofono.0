Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445AF7F7E3
	for <ofono@lists.linux.dev>; Fri, 21 Jun 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983701; cv=none; b=ovbdLMK3rniNppcyKM51Hq3KMH9LEEhoIY+xVIRi8QWt5p+l4uZRMTEZdSh4dVgO/cGT501oAyFNAu+HqpgY1ks7YwXP6x9ZEPvJ6J2Pkdb22tbYSwqXWnCfTTKHB8IOHVgbxMTUuOaiuUawafsu4LDSqIMmT2pWmNOqdlbutm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983701; c=relaxed/simple;
	bh=0bmT9fUQOXBksvPk7KXa1ST1CusNvvtcSrPczndPbAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGdLs700cpDQ2BbjTr87LOkg3d12xPEXfg4Qq8hcvt4ijjB5cFIXYVLXxrQPDzEoGGAge8O3gO//dbFfzN/VPGoIWQLvvYWMzMhiuHC8iwTyhmAyHuTulmLw0iG08maVHGoMsjR1ZIwSbuHfN2/BIn5ZbmFhs2A+BDSvoabAOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODhC1/L3; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODhC1/L3"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d24a231342so1040769b6e.1
        for <ofono@lists.linux.dev>; Fri, 21 Jun 2024 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718983699; x=1719588499; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=teAlZKuaOPX+RBAtN4m0hTGnULBthYjiiRYMgHMhfy4=;
        b=ODhC1/L327bYkuK88FDhd4lyxoFl+ugGXFVD309dEFoeqdSRu+ZU4ZJcIerV1663u6
         zrVIUbxRaLWmwpnvcF8OAlKpq+FupcCT+qsv2qaIe2O2jJ9TrDaUB6jnKItOlZwKfbKx
         Na+DHEPv8Udr2dyHM2VKUf24akRZpHmhzxMtd1Adb7jcj/bLSN8pD2m9BRvxBdgnu94W
         B0lucth3MF/MWdfAeWXXeNmunOmAO6nuBzEdHFkFxv9oK6ZKgS32b7p4KHiTjYZ3ZNBJ
         WxCqQ9RcJ5WFq+60L45fOgJQXW3hPtDomujuu0sAdKH8zTtbV4FS/8WvDR86H2aClrH1
         SL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718983699; x=1719588499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=teAlZKuaOPX+RBAtN4m0hTGnULBthYjiiRYMgHMhfy4=;
        b=GvgbdlFzgTHGpJYxFWkBYWeruVu+L4zdLJmV/GtQxcGb12YiajsGh/7KPKhFwermxI
         UXCx10KgxN9gA7N7miK6FzwM4PlkkNouvmJiRUOphGr4IMH21nvYb60eL2+J3jPgiGd0
         z3CRyozRS9c4nWbDfzCnFL/pHPNX7Y/2v3uj632z4QH0bESkM+FR3u1wr7OUpZzg40vi
         UmT48ZErj56WXFiW5SJksgh8t+T66RIzkfnCTYlgDNOAmjqArmMes+DgFqjb9l1nrJp9
         EPVpiocy5CZ0GitO2OP41TKKuW59OiIwvmQ00i2tBspgt+I7rmAg367yqF3MMNaRa7nm
         /Zxw==
X-Gm-Message-State: AOJu0YziLQGmjwMSp/7K0uv7ZetNdpp1DwfASG5AweMhsrsXnLrbX9jM
	Zl7tObQCz9sygdzKxfEXgY5qpmkhdB/xc5xD8M2N5dgcS0KIpfL98FgYSw==
X-Google-Smtp-Source: AGHT+IEskgo9Q7BMOXK3EYuEj8VdAQIQnXxoMnEu6DVGNkuy4Ud+m7piR8GUJgNnXPT6tCMxVK0hEA==
X-Received: by 2002:a05:6808:f01:b0:3d2:2721:8a7e with SMTP id 5614622812f47-3d51ba0db1dmr9097445b6e.34.1718983699231;
        Fri, 21 Jun 2024 08:28:19 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3d5345a6016sm335227b6e.37.2024.06.21.08.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 08:28:18 -0700 (PDT)
Message-ID: <08f44992-5f54-42ed-afca-8c46ffff5282@gmail.com>
Date: Fri, 21 Jun 2024 10:28:17 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qmi: differentiate between lte-cat-m1 and lte-cat-nb1
To: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev, =?UTF-8?Q?Martin_Hundeb=C3=B8ll?=
 <martin@geanix.com>
References: <13BA976A-5959-4708-97F2-77285400EFB1@geanix.com>
 <1218dd9c-7d11-4024-9beb-dd72dc6d8e69@gmail.com>
 <wejfxratz363pxgqph6cn5qnyexcsaaucpmb4twiumhd36fbd3@rvl45njp5ffr>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <wejfxratz363pxgqph6cn5qnyexcsaaucpmb4twiumhd36fbd3@rvl45njp5ffr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sean,

>>
>>> It doesn’t look like the QMI standard is supporting this differentiation,
>>> I have also looked in libqmi and uqmi. Is this the correct assumption?
>>
>> No idea.  I assume it is supported, but may not have been exposed by libqmi.
> 
> The qmi interface returns QMI_NAS_NETWORK_RAT_LTE. Looks the same in
> libqmi and uqmi. No special cases for cat-m1 and nb1.
> 

libqmi and uqmi are based on the same json files, so not surprising, but they 
only have a subset of what QMI actually supports.  Who knows, maybe Qualcomm 
added some APIs for this somewhere along the line.  Someone with access to 
actual QMI specs would know.

>>
>>>
>>> Via AT commands, we can get the info:
>>> AT+QCSQ
>>> +QCSQ: "CAT-M1",-62,-88,168,-11
>>> AT+QNWINFO
>>> +QNWINFO: "CAT-M1","23801","LTE BAND 20",6350
>>>
>>> Guess we are in the same boat as the folks from "RFC - Add AT interface to qmi device” thread.
>>> We need to add the AT interface in the modem driver and in some way prefer the technology from the AT interface.
>>
>> There's nothing stopping the modem driver from initializing an AT port.  You
>> can do that today.  It can then report things like network registration
>> state on behalf of the netreg atom.  At least in theory.
> 
> By modem driver you mean drivers/ or plugins/ ?

plugins.  Atom drivers go into drivers/ and modem drivers go into plugins/. 
Horrible.  Something that needs to be fixed.

> Guess I would need to modify the gobi driver or add a quectelqmi one?
> 

Yep.

>>
>> How is M1/NB state reported?  Is there an unsolicited notification?
> 
> You would have to ask via AT+QCSQ or AT+QNWINFO.
> 

But these have to be polled?  Did 3GPP ever define any AT commands for this? 
Have you looked into 3GPP 27.007?  We would typically prefer to model the driver 
<-> core API on 3GPP AT commands, if possible.

> One more use-case I see is when we are testing with a unregistered simcard.
> Ofono via qmi reports the status as "searching", but AT+CREG? reports (the correct) +CREG: 0,3
> 3=Registration denied

I thought I saw a 'registration denied' equivalent in QMI, but you may be right.

Regards,
-Denis
