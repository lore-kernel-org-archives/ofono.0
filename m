Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA58132483
	for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106208; cv=none; b=dH7BBA5GutP8X9c+pIIpC9DQ+0+r4gcMYNZS4bBbi26YISOFoKGScpgMoOx0snezPLFyQSkBb9LWDxvLhvZYf54PSDXQzCgkMFa4mVo7mxyTw4XipzyB3+8opSem1hA1/wiDdcbFqkjqG0PCvZVOltXm4cr7bIOsRepUISPWFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106208; c=relaxed/simple;
	bh=pLubXLPWNuxJUgBZuWa6gZGmBH1yHRZqPYhLR8M+Qj4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NP6WZrtPIstPGsJWjfn2GaEJiqw+BG2QmfUKTpBVVw9w+cJVBWiEm+lKwXC24mU8poaGKxH2RnxzTE5HDSEMSWOcib6IuwydrpEDa/S7oB2zXvi4dHkxwO6SC/WlwbDaC2b5GxBsz3bvyUHnCJvtiOyGCAFwOugLwxYydkaAck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fivzwtUx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fivzwtUx"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563fc2d6980so1028668a12.0
        for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 09:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106205; x=1708711005; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnKL/Bl/0WLkRWJTOoSmTlV+haqQsKKDeHbCGoRxGDM=;
        b=fivzwtUxNO0XYBuZckQWKOe9/Tk1HOiRp61yMrlOcUM4IqqCeFuQ60qPUI5OcC1JGK
         U0r0naWoj2M2FMZlswDa6o1JmWXfejzYSF8WACcjUBwiX3SpeJuERXDi476EqXFv6OEs
         YV3eGmz+iLskIg78lZ1QfJmF5ZG2lETsU944ipSywg08vPomPdGpZIIwOE/QGs4gE+uu
         qETwkEcQvtBtTZL9hfD7WSbXNrFEBTIFqHkf31SCfDfgbJDhyBOCloVd4utQFEvqTc7S
         oc6djSyJmZfixBBSFT5IeGyRFHq0bTAs5U3TORYIqD5/gqPGjSuGq7VFdfp9IGAbfTC6
         SKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106205; x=1708711005;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnKL/Bl/0WLkRWJTOoSmTlV+haqQsKKDeHbCGoRxGDM=;
        b=WIj5TdzYAbUug2MzeDtHg1lVYlkbn43x4TnLObCHsCbhfzD4FrvvMFWfaSJz5qhzve
         liI9tCc0llPInZS33Qm+FHL1pJdBrDuNxBTQZ0RNkmLw8BIKcyczKTm0gzDoIINHdR2R
         HbIyUXqDXVPrKeqyXHiiO2CgahrK4IDOuL5/oQQpB0tw+aWpv6K1J1D4Upu8tDEvL6hD
         0nRT4876r8AdVdrcMdKaOVNB09quHD8Ky9gDHR9Pt5zkJimA8Hrw4+Uzg9pbyi+xctLT
         LOq9t91ppNGyDi+xP+Ej7Xf7swwaoUDrVjiTBR1pIo9WBnyzf8rRI2SFyu23deso24OD
         bQmw==
X-Forwarded-Encrypted: i=1; AJvYcCWmFm0rcFt7U9D76MNWCA6qt815wcyMt9QBzK02lELEZScU+Eyu4KVhujxtuE+36XHwDTblfdtORJK50HwAlojIaxJ1HDY=
X-Gm-Message-State: AOJu0YyGbgu9GAf/Vl5r2zpJkMpwj83UWvG7U6ip01M33yYhtMDcjR0J
	Yrfb8J13peaqbWvCnF/PTlj8nEpgG+Ax6qJgKa+ErOVaFyN4YsvB
X-Google-Smtp-Source: AGHT+IE4n37fht42iAgNExlgu1FTQ5xwDAg7UqerbXKPJHFJEFuAskznTdgT1xVTQP+i+MkkgwM6vA==
X-Received: by 2002:a17:906:b791:b0:a3d:5271:2b2d with SMTP id dt17-20020a170906b79100b00a3d52712b2dmr4052262ejb.65.1708106204791;
        Fri, 16 Feb 2024 09:56:44 -0800 (PST)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id dt14-20020a170907728e00b00a3cbbaf5981sm186230ejc.51.2024.02.16.09.56.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Feb 2024 09:56:44 -0800 (PST)
Subject: Re: [PATCH 2/2] qmimodem: implement call-forwarding driver
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1707981467-2955-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1707981467-2955-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <7dc5103a-ec8b-47c7-9ddf-2be524701d20@gmail.com>
 <c4d9f7e9-2ce7-d59e-8a0b-ee65e866ec56@gmail.com>
 <0f9ee157-6fcb-4042-860f-124a8c4335bc@gmail.com>
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <adfd3b78-68ba-87c1-ddf2-0a938b08396b@gmail.com>
Date: Fri, 16 Feb 2024 19:56:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0f9ee157-6fcb-4042-860f-124a8c4335bc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Denis and thanks for the prompt reply!

On 16.02.24 г. 19:13 ч., Denis Kenzior wrote:
> Hi Ivaylo,
> 
>>>
>>> I fixed up a small whitespace warning flagged by CI:
>>> 0002-qmimodem-implement-call-forwarding-driver.patch:394: WARNING: 
>>> please, no space before tabs
>>>
>>
>> can I use checkpatch.pl from kernel scripts to verify the patches 
>> before sending?
> 
> Yes, of course.  That is what the CI uses.
> 

Ok, great.

>>
>> Thanks!
>>
>> BTW, looking at the dbus call forwarding interface, I think we have 
>> issue in both org.ofono.SupplementaryServices and 
>> org.ofono.CallForwarding interfaces: We can have call forwarding that 
>> has phone number provisioned, but disabled. I don't see how that 
>> information is populated - if I read the docs properly, when a 
>> particular type of forwarding is disabled, the relevant property is an 
>> empty string, but that does not reflect the provisioned value. Not 
>> sure how can this 
> 
> My memory is fuzzy here, let me look into the relevant docs.  This may 
> be a limitation of the AT command spec, i.e. 27.007 or so?
> 

Not really, according to 
https://www.etsi.org/deliver/etsi_ts/127000_127099/127007/15.02.00_60/ts_127007v150200p.pdf 
+CCFC provides status and optional phone number/type. And at least the 
EC20 around me provides phone numbers for disabled forwarding.

>> be fixed without breaking the API. org.ofono.SupplementaryServices2 
>> and org.ofono.CallForwarding2? Or additional properties, like 
>> VoiceUnconditionalNetwork (bool enabled, string phone_number). What do 
>> you think?
> 
> Given that oFono is now 2.x, I think breaking APIs is an option, 
> especially since there are few users of CallForwarding.  Introducing API 
> versioning might also work, but lets see if we can get away without it.
> 

I don't know if SFOS guys will be happy with breaking the API :) .

Regards,
Ivo
