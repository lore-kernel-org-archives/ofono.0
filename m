Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAEA1649D3
	for <ofono@lists.linux.dev>; Thu, 18 Apr 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451276; cv=none; b=Z+p5OU83X+o9VyzoLpBEidJykbtOjOY3FitgLI/C0wVmZKdLQqDQkaOZ/xwC5iymsW8X1TIIwVahuwUvqkmGD+QUp3QCB/L7Ny28W6NqC74oon2s4qH4aPBsJL04Q2Qw5g3Yf+yPlIfHu90U8jQhJxIMH1uEz/GzRDNW0vKLuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451276; c=relaxed/simple;
	bh=lkri31ikQ98TWDMgSJ+6h6proXN4kG8ylZH01en9uas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+F5nzVHbmgv/jAfSfuAJGqLxjW77l8u88WiEU8GpGnaEcCnJAZI9yq4aQWeqpf0ZdYEQypcB2FHmWMHtQGGRzPAFewt8haMLOeMtlQlJNCRMKpHgJ3qYbfQ8dbbU/QIMviy9yRlHW2U4l7fx2MwaZVZJkkW91zhyOaAcVNZafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0RJ3r/Y; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0RJ3r/Y"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea2ac0c217so377652a34.1
        for <ofono@lists.linux.dev>; Thu, 18 Apr 2024 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713451274; x=1714056074; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUQ063GW8in7UDmpx2vdAli58z2gpZyrFu/AzZJuzGg=;
        b=X0RJ3r/YPsv8VS3tg07+iHC0hS0zajFX7UBGcirR+5v2eMAviQnNz42O7pvfZ2NYoT
         E2M2gt4/gjLt7XR7Wm+l99k9Mk0oPnXfsAV7x54p/fRfaJ7uvIHAaM1mKOERfC8ydSKY
         Mgj5b+KCCSJmC3JV/VCVK+IImUqBh9+/m64CV24uT7TEuuIHPvKt1KE0Hpw9YIFwm7tj
         VDttO5NZrHWPXhgiwppRvGSFsMqFUfhp1uBCsaVYwA5SQrRnKEF4rv08JbQhbHPzreAV
         lIiBRGA4DvtHpqdUTEQ2vqf4oxAKQMXlbHTWDcPqlJBTI7NvORAE4Uojtfk1/kcvxXkH
         9Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713451274; x=1714056074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUQ063GW8in7UDmpx2vdAli58z2gpZyrFu/AzZJuzGg=;
        b=egr5WBb+OEazyQDjwr+sJtQVVWSF4YN95UcwqGCWdbHmUIU9Gp0cPcwRI45RT8vORD
         lG+2HQGd+GAWTXREdDB8UVrqaw327pdU4avPqAOkzPX73YtxZO3CQ0m3tjyto/XBxu65
         jsDKYL135NK/wXKGPRdxMtbNElGuWpjF9pUIISrfBkyDsiVZ4alASiSVHS9rsHM781Pq
         r4horUJCAJjtD9UxI234+UJ86f6vHW2eD/n+LXS9GNdU12JcDHAjNO13+zCZWMAmWCsV
         EfbXvNMqG8M9W2xmT0Gh7xGHtyRzLSTr9PIT75FsGTLmKV4c0W1Rn+6b+jOuNxStCjar
         yKZg==
X-Forwarded-Encrypted: i=1; AJvYcCUj6IGLeX6AuCk55fXjiXoa+62cV/boZYKkWGy5C2s9bupJVElMtAR1bPTl4XVvn2TgyBJQuqPXCKDrwu+QCszNH9jcd+8=
X-Gm-Message-State: AOJu0YxG3+CRP37HCAyZ/IWzRK/hAfgTco2qoZZF80CtepH7UoUCQ3dv
	HSHg4yE2rg4odAvQ4zqV8Hh9C8mNqdeBSclWCu5Qr9aHe5ZcXaI2
X-Google-Smtp-Source: AGHT+IGxFz5oOXVbvzR8MyT/mfbg92tcaxNHTuddcZGvsNt6GjgqU8g16Qa+X86xzdreLj9Uf41xig==
X-Received: by 2002:a05:6830:19eb:b0:6eb:769d:bf09 with SMTP id p43-20020a05683019eb00b006eb769dbf09mr1158990otp.13.1713451273750;
        Thu, 18 Apr 2024 07:41:13 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id dj4-20020a0568303a8400b006eb77307f23sm347384otb.7.2024.04.18.07.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:41:13 -0700 (PDT)
Message-ID: <6a029dbd-76ff-4485-b37f-1a8ee97a9338@gmail.com>
Date: Thu, 18 Apr 2024 09:41:12 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] qmimodem: voicecall: Implement call dialing
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev
References: <20240413215318.12236-1-adam@piggz.co.uk>
 <e17d9cdb-03ee-4f1e-b2d4-1a5c02040777@gmail.com>
 <2693964.vuYhMxLoTh@adam-laptop-hp>
 <c450908a-d42f-4d09-b90f-26cba9dfd495@gmail.com>
 <0E7F2740-A440-40EE-AD31-3FA355B6B17E@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <0E7F2740-A440-40EE-AD31-3FA355B6B17E@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marcel,

> 
> if phone_number.number is a fixed size buffer, wouldn’t you just use snprintf
> instead. Or just use strncpy/stpncpy with a buffer size - 1.

No, because the source is not guaranteed to be null terminated.  That is why it 
has a size parameter.

Here's a good overview of all the most popular string copying methods and their 
advantages / disadvantages.

https://lwn.net/Articles/905777/

What is really needed is a function that takes both src and dst buffer sizes 
into consideration.  I'm not aware of one.

Regards,
-Denis
