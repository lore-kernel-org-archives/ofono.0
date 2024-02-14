Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB42141996
	for <ofono@lists.linux.dev>; Wed, 14 Feb 2024 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953660; cv=none; b=nr13+nEi7dYUZPWxOiRQve/NCuyl3wzPkjKqVQiH5DeTcNYhic90d4JymR0YK1q4QbrU276IVt8hpZs9dOMj90ZzBjf4q/PMyUFHPgV48I5fsMI4h4ZKs6Wmno5BJMB3omojC1R8EhOMk1K87b79OeT377tIQtBqqjAZdPL6p1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953660; c=relaxed/simple;
	bh=/9yBG9WeDm80nPSQB2K/6j9uXj3/EicROEl7XmHQLH4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jWwf42zolDdWXUY6HcOLqDKNPEn2GlMXZ/uxHhoWaXrLU6pEkLT0pWwMpeUPTNY0tw6Zi009VFUZC+1hw+PPAxKI1RSNyNReijcEkbyFXTcJG8a9cH145SGeR7AakoZJVbQuA1QxDJsvC/WOcIxjhHLZEx9kI/XDzltAXHidQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axD52pVu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axD52pVu"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563a772606aso137742a12.0
        for <ofono@lists.linux.dev>; Wed, 14 Feb 2024 15:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707953655; x=1708558455; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7voPaNCM1Me2DDuaBp+mH8TiYJM3+RJdIGKYTzp9d4A=;
        b=axD52pVuE+tumSJnlwaffxU2iYH0f3OOdU5NuFhTOTPa2r88OoW1tiVNHqYglP+32n
         rKkq+pavtqhDlUZtJHUrKLlvYDavTC0SgwvdNGqGw/QD4A6hwlMCxsJGJx7ez2RtPQx1
         C9qtgRW57XeKENqsINYCs5mu3LG/oNzF+/m3z/GjMjdbNKaO/yYx0hhHe5RBVvs0Gdcd
         dDAYCuGiIimQdVqqNratDq4qBM+w5fyjLLw7Ae+vx7CImlshd5fmPXd5AtKPWZ+izDfB
         2clvPi/sBHGMPHJmHCfsttKyKdtact6+j8QZJznRvUMX96Q5IvPvK0OE7X/dxO223I3R
         CGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707953655; x=1708558455;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7voPaNCM1Me2DDuaBp+mH8TiYJM3+RJdIGKYTzp9d4A=;
        b=rR8IfmHOpJ1gm6kO0vYPIal82lfzlTNxeTAcKlq0nPWWjLlHVoVJmSlF6YBldG+xSk
         OGybB1Ws7gSQRqAbwveswsOz7n6npVNZUJ6C2w7526ual2zCLIJqO6GFdZ52+Jd4e6Xx
         fEofKJxqqpJ0cHyWFzZQoNCROyKeDgLAeULefwk93t5AdHHza5lPwR2fN/5mqIbAlCiM
         TpHDvOx6auu3JAENv4PKegpu29jwXCdhTw8kVaJDOAgPl8ilC0N5wQfSLxFgQ+cXPn2D
         yzvGYREPieupao+Zc/vWzmqHAOOJf8H193bi8EJiLqjE/gNQ7qNUWe6UJXsfVWkykWze
         jCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX89x9il1hnLAlue9XvYwIsk6loJJiy5DFNdEQpthON0K5IIWPhNkGQrk7RsKzAQYvHS8apwSiYigjeCEa3P8pgOV2DS78=
X-Gm-Message-State: AOJu0YzX7TKFQsc7MlZqMnGC+edlP1ZdqaqqBjucJSCRD0bDQVFm0cFQ
	Dt4zVWDf5lZCa7NUDi68HH0GboY2CHIvHk8FEjIJMZTchWNy1ORk
X-Google-Smtp-Source: AGHT+IFePnVqPKI+kwaZ4NIdsvpTenmTnwSuZrKVYvOe7sWTknUZVoJLKqX6nxTmBGnbm/ZwrPXyLA==
X-Received: by 2002:aa7:d812:0:b0:55f:6a35:b541 with SMTP id v18-20020aa7d812000000b0055f6a35b541mr93303edq.14.1707953654889;
        Wed, 14 Feb 2024 15:34:14 -0800 (PST)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id d22-20020a50cd56000000b0056387e8b63csm12602edj.90.2024.02.14.15.34.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2024 15:34:14 -0800 (PST)
Subject: Re: [PATCH] qmimodem: implement CallSettings
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com
References: <1707892328-16334-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <a5f8fe01-aaf3-422d-8fde-64c8a5ae13f8@gmail.com>
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <9b8597dd-8ff4-8d4a-48c5-8b9c951fcb76@gmail.com>
Date: Thu, 15 Feb 2024 01:34:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a5f8fe01-aaf3-422d-8fde-64c8a5ae13f8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Denis,

On 15.02.24 г. 1:10 ч., Denis Kenzior wrote:
> Hi Ivaylo,
> 
> On 2/14/24 00:32, Ivaylo Dimitrov wrote:
>> ---
>>   Makefile.am                      |   3 +-
>>   drivers/qmimodem/call-settings.c | 346 +++++++++++++++++++++++++++++++
>>   drivers/qmimodem/voice.h         |  45 +++-
>>   plugins/gobi.c                   |   5 +-
>>   4 files changed, 392 insertions(+), 7 deletions(-)
>>   create mode 100644 drivers/qmimodem/call-settings.c
>>
> 
> oFono CI is still a bit of a WIP, but it flagged the following:
> 
> 0001-qmimodem-implement-CallSettings.patch:288: ERROR: do not use 
> assignment in if condition
> 0001-qmimodem-implement-CallSettings.patch:300: ERROR: do not use 
> assignment in if condition
> 0001-qmimodem-implement-CallSettings.patch:305: ERROR: do not use 
> assignment in if condition
> 

Oh, will make sure to not do that in future patches (CallBarring and 
CallForwarding are ready, will fix coding style and will send them as 
soon as I have some spare time)

> I went ahead and fixed these up and made a few other minor whitespace 
> cleanups. Note that we only use tabs for indentation.
> 

Noted.

> Applied, thanks!
>

Thanks and regards,
Ivo

> Regards,
> -Denis
> 
