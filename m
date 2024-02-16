Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F513329D
	for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103640; cv=none; b=RmeHmMhMLnVO0tgwdcpdb5VmIrKglo4OWWS4qrK4joqU6pTzleXz8wisBfZztB8ZKfFmwslrOLThYCmbc/uOvFLCK3JZTBwSgp0m75B8LHfsWxDxhKPISpf4DX+kqqJZqW1EnSDxT01tJfyq2DY0vJdF/7f60UZFYuXOHuQB+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103640; c=relaxed/simple;
	bh=Fjx9zZDA/d1Tl+E1+Fn1se1nlVR2yPmzQvdkgQz75GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQnqoXRUp9xSseGsPGoez+iaLONl/ccmpNtgZUGaZcYr74PhmPA5+G+maijDHRfCpAt1O7f+u3yHbsqIoGSc9MmYwn2hbNLy9RQDpR/EWgw9dTpRtnrVMXOIN33HLRfSStzjiVLZk8IPrcEe7aLQ3OEgDnvg6mRWXDS9SP7fnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPAxB1t+; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPAxB1t+"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e2e58feaefso836800a34.2
        for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 09:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708103638; x=1708708438; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyYkQjgez3BU1mCiH4V0ME6C851zG41Wyas0EuT86kY=;
        b=YPAxB1t+nM6/g7eSPkawSoDF/GIzhQsa1HJOg3RGAgFRQ8HimB1Bksm7KF/PKyVX2W
         cmaU0el3d2WQRnTGd+7aXQmS1/LCMiV7LatLeTCBsN8jXKVsk+L4ZAAf9VzEAdwQjtIS
         N7V22dHNCrEFXcrRJRBhoDIUY+SFXhp+MZ7qvs/7ars4vIzMe2gKV7NMyCakOYmb/jjl
         +F2Ca43rb0D53SNmouoyABSrXIdWHIVlk2Ng0cJqcWp/4ooHD7dDKM6P2kgYzQJOsack
         3aPkDpLiwhB0d/57GnQzfIOKw5YjMLMZgylxHZIyI/M7Ot0+ffXuScwUkw6nPJsY08D0
         1iqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103638; x=1708708438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyYkQjgez3BU1mCiH4V0ME6C851zG41Wyas0EuT86kY=;
        b=RNQZ+Mva/poOeR0q/9tRBi6r9Q7EP4JT0/q6dg4pxlfjYJ62V3Xbjaq7fwhjsY3Xqr
         TxlaRcQBkFL9v3at+WBLUOsBh8Ex4JlTkOLkBPBnWWPCQrLV1sg5vzRV8geaDlJhEr8y
         cyJgBKyTvu6bjXrd+cRgD46b0XsWVmgI41DM3cWS3t0W7JoFS4Olm2IXsZr4dr94EVCC
         gkIbSP3uVD5/KZFWDg9r+C5FZSh9eWZWE+nwd8eWEWuDb11/8eEqQ1fRHej79mtbqgKu
         dUMnZUXgHgNxdP60oJJ4BZaTW0oiJxIk4WugxCWtOmhM7QCeU+5+a29Gup20Sjth1LA7
         Mckw==
X-Forwarded-Encrypted: i=1; AJvYcCX3Ht0NboojshhIBSnZFUz7brz4ToeZIMA7fmIEdoYxD2rorfmW03GKRj4NtNWSH1ORtaOPFtt1xtqkUxHt2smXDaA5He4=
X-Gm-Message-State: AOJu0YweWYLRcAiMOG1hAO5MrsrSnxKE6fykhYDWXa6NOUzKuJcSzNka
	cUvFko0IDY18Bh0ak5GBxxyrfmlUcwzPWohBSdCccqI6+OGRcsuo
X-Google-Smtp-Source: AGHT+IHcoTrDHcmyy0fclR3aF2RJT1DspCDYQBa2ffahUQ0M+KqldCvUdM3zuhMWyv3YfJhWN4r3cg==
X-Received: by 2002:a05:6830:1e78:b0:6e2:ee50:c1e6 with SMTP id m24-20020a0568301e7800b006e2ee50c1e6mr5241554otr.17.1708103638203;
        Fri, 16 Feb 2024 09:13:58 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r2-20020a9d5cc2000000b006e12266433csm52732oti.27.2024.02.16.09.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 09:13:57 -0800 (PST)
Message-ID: <0f9ee157-6fcb-4042-860f-124a8c4335bc@gmail.com>
Date: Fri, 16 Feb 2024 11:13:56 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qmimodem: implement call-forwarding driver
Content-Language: en-US
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1707981467-2955-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1707981467-2955-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <7dc5103a-ec8b-47c7-9ddf-2be524701d20@gmail.com>
 <c4d9f7e9-2ce7-d59e-8a0b-ee65e866ec56@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <c4d9f7e9-2ce7-d59e-8a0b-ee65e866ec56@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivaylo,

>>
>> I fixed up a small whitespace warning flagged by CI:
>> 0002-qmimodem-implement-call-forwarding-driver.patch:394: WARNING: please, no 
>> space before tabs
>>
> 
> can I use checkpatch.pl from kernel scripts to verify the patches before sending?

Yes, of course.  That is what the CI uses.

> 
> Thanks!
> 
> BTW, looking at the dbus call forwarding interface, I think we have issue in 
> both org.ofono.SupplementaryServices and org.ofono.CallForwarding interfaces: We 
> can have call forwarding that has phone number provisioned, but disabled. I 
> don't see how that information is populated - if I read the docs properly, when 
> a particular type of forwarding is disabled, the relevant property is an empty 
> string, but that does not reflect the provisioned value. Not sure how can this 

My memory is fuzzy here, let me look into the relevant docs.  This may be a 
limitation of the AT command spec, i.e. 27.007 or so?

> be fixed without breaking the API. org.ofono.SupplementaryServices2 and 
> org.ofono.CallForwarding2? Or additional properties, like 
> VoiceUnconditionalNetwork (bool enabled, string phone_number). What do you think?

Given that oFono is now 2.x, I think breaking APIs is an option, especially 
since there are few users of CallForwarding.  Introducing API versioning might 
also work, but lets see if we can get away without it.

Regards,
-Denis
