Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D855E4C
	for <ofono@lists.linux.dev>; Fri, 31 May 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717176440; cv=none; b=juYY/wYWVwVa0VxTTyk9/7vGfRAKUsJVdGLXesdcCxN5jiGgOG2zFWTk26/uI7SZyZTk8EYwxrluZBoCYndI1FMl6lcsZUK64eimSRfqVSQ38e6e9zGrEqxpJnUtnHSGYVyqWSc3FialWkYeNpmGiEBbyKPmnPIjfMwAZAu6Eow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717176440; c=relaxed/simple;
	bh=QlKQOEutI75jZPOyiJY0ItaCILKrh6XoGhMVXw7NeOM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XHEh+7bAA5XvkbzqD83e9hk6JSXoHLt02wMHtAjxchl1QuJ7N6vtHgCTojWpSdnGGyf/s3kMD15KVZncaWcSNGVZ1cX4mdpSLOD5xIoXwbNh7g8Bx+6NRtORJGnCSlfGvhtjw+9586pCnnFbLCPsyeR1idTH3zqNA0qbEWochN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TanV0Got; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TanV0Got"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so2786146a12.3
        for <ofono@lists.linux.dev>; Fri, 31 May 2024 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717176437; x=1717781237; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92kqMgrKB2qOmInm57nL+aWlnKcIitZxl1OwA8PaGWk=;
        b=TanV0Gott6nud7gas0gAasAqpq3auaCVoUm2UFnM+Yu2LZPSd7uwtkLY++pu04GmNO
         DSPT9FAdSKyeoFho1lPTQ7YErElEjBmDsud3z+I9MI9p1DyKwUdv0aUHvwSQ5WyqCSc4
         C43UKUlIBojMOCwJw149H3OKi/CPdN8zlIStFzTD5SO7hKSjD8ZCEw1fBVgy3BPZGSi8
         EYVUVKP/fmuE8j4722JFuWstrYBWDdk+/VPS8nhQXRlyobCEgU+oyjuOtLgVR6qFi0ss
         ulSwqsOFMO25iHX60rlVbRJhahhXUqw8GtO1PUOd6HMKvBAlsUc6Ltn5gcXG/rxyNHFs
         dbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717176437; x=1717781237;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92kqMgrKB2qOmInm57nL+aWlnKcIitZxl1OwA8PaGWk=;
        b=EWtt7K37uQDiTki3TmpUJQ8B0FQqeBvVe0S13zgh/TsSGaLOGh1pujmxgOlesTwLKY
         YPZ4t8WV2Kl/vv6ksROq4p2kN3wchPjGlgr+3jSzKo9sgR8xQXuYgMoaLHpgWN0pptQN
         h+gPgs8k0ag9FkEi77lWdV+YbICzPf4JbVEKJmyBjX0Oc3iE1FYfs5pKx5YdafFnabyw
         Q5nc88z6n8YBMg+uNCfsq94STOlkhJArmxgseCvXWxPNzO3hpxClXAyyANWYhoOWTX4R
         GCOYRKmXBuc5kIPktwQV7g8yL3Zw4SS6tajACheV23nvOIWeTW+BHEE4VRz5pHBrURcl
         088Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8wF/gzeWrUmag4KTXnmIM79ow+7b2Az3TolGRHOl91MPpN/UDh9MTKQws3J1v7iva++VLQPCm3KPxh/E4UNFNHnLtTG8=
X-Gm-Message-State: AOJu0YxJGyYxImLn8QSJMysuAoZa+bRjTMyuoiTb9ooMTuQCaeccJOtk
	SI/JTl4z+eiG07qtIv6Bl3PJWbJW+E2gfRlZVzJbmCIghi1rbok1LEgOHA==
X-Google-Smtp-Source: AGHT+IF0Xmc07PCsNfq/B+Z/x8guQICucFQQkhAodphpMIdRcUVNKWwOQoTK/gCF9bnTKPmnGpeEiQ==
X-Received: by 2002:a50:9359:0:b0:578:e202:137 with SMTP id 4fb4d7f45d1cf-57a364b52aamr2131388a12.20.1717176436810;
        Fri, 31 May 2024 10:27:16 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d45esm1233075a12.62.2024.05.31.10.27.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2024 10:27:16 -0700 (PDT)
Subject: Re: [PATCH 2/2] udevng: Fix detection of USB attached tty devices
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
References: <20240530152513.279243-1-denkenz@gmail.com>
 <20240530152513.279243-2-denkenz@gmail.com>
 <b0e4aed1-302a-0d4f-b466-7fd7b999275a@gmail.com>
 <24df8380-b6fe-4f86-bb20-49815ef58c1f@gmail.com>
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <9c24ae17-a355-fcf6-887c-b54af9e86c95@gmail.com>
Date: Fri, 31 May 2024 20:27:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <24df8380-b6fe-4f86-bb20-49815ef58c1f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Denis,

On 31.05.24 г. 18:52 ч., Denis Kenzior wrote:
> Hi Ivo,
> 
>>> -
>>> +    /* Handle USB-connected devices in check_usb_device */
>>> +    if (l_streq0(bus, "usb")) {
>>> +        check_usb_device(device);
>>>           return;
>>>       }
>>> -    if (l_streq0(subsystem, "usb") || l_streq0(subsystem, "usbmisc"))
>>
>> Is it possible (in theory) that we have 'usb' subsystem device that is 
>> not on USB bus? If yes, then you shouldn't drop l_streq0(subsystem, 
>> "usb") check.
> 
> I hope not.  What i've seen is subsystem 'usbmisc' devices not setting 
> ID_BUS to 'usb', which is a bit weird.  Hence the 'usbmisc' check below.
> 
> I think we do not care about usb subsystem devices, only the leafs:
>      - usbmisc (cdc-acm)
>      - tty (ttyUSB...)
>      - net
> 

I see. Well, the $subject patch is fixing my USB Quectel not being 
recognized, so in case tags are used, you can add my:

Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Thanks and regards,
Ivo


P.S. It is not that I forgot about call forwarding API change, it is 
just that I was very busy with my RL job. Will implement it as soon as I 
have few spare days.
