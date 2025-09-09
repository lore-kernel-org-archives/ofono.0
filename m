Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704982BB17
	for <ofono@lists.linux.dev>; Tue,  9 Sep 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431423; cv=none; b=QOqS+mmzjULBHeVX0Q/pNxSbj2sQgIuH1VfGJunYZ/XNVHpQZM6jnN7G4b5zLzamcLjoDyEsmW4yEZfS9OJ+OLquLBwqWLpt7frAn+69Ogib4WAlX1iyDKewTwYt+GUL09ecxNTQD92sopJfr1zQuLs2M9JVshDatyy84Ov9HR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431423; c=relaxed/simple;
	bh=Rbf/NQjMeSW0SbvAvMivkPC257V67FNkbSEZwS2hAEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QeBUT7b50q12e6Cnuhc/ijMomo6X0/gGk/gLlSQsB2t03c9dAxxTthRTEaH5aHN6dg6k+xmiAe05b8cyAGo6WQzSkLeErzS7nI9byM+B9mYmpO3C3ciJKeNvAswULi2hEBBlE7jqG30o67rlqGF/aZF9JYUS0MTzo4X4fxL7Cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg9Uq6E6; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg9Uq6E6"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-62190d14a96so840859eaf.3
        for <ofono@lists.linux.dev>; Tue, 09 Sep 2025 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757431421; x=1758036221; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3mlY9N5rgNCkW8BNrqMJ0FitClbwJWUClNS+O+YDvJI=;
        b=hg9Uq6E6Zq6ufD5w6ojBil04IloxFwHRFPftqgsRfdtnpU9JqVSJTYtc5dsC6947F4
         1kpMYitI5vimYFCzNW6NOGF2itCbhIfhynPFSeSZt4ff3C4X8vmxDhLRNBXPx9mpF0kB
         4ShCsRWhKZVEI4K0gb5NGjUYe/mBmMI79b/fxsCSvbOLo3Aj5ytnGu8oabY20TCghJTS
         jwN+/2E2pSuwVGJ/Fm954KRmALH03bh1B+39ibsaoCrYEO4wUl95qMG2QnAQw1Q8Eqtc
         SoYaGNAVQ8t8BgrZRlLKAYo4UOgeeJKHd1ls9CmddWOv/c0XtQ7rMf28BB59lVci8zBZ
         6HYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431421; x=1758036221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mlY9N5rgNCkW8BNrqMJ0FitClbwJWUClNS+O+YDvJI=;
        b=NFTdONdW/Ta9YsTUNr6p1h9ylrlNvk5qEl6R87NdXMUI8D8w9EzCJ5lAQS/CXoWtRV
         vx6u0yhMRc6SFvVsjBpczbl1GfrPM3pUvoYjhBWVzUNaWvQMxTcOW9g0lr/Qtv1kLZ1V
         DbBbCCSwzJUH6oYlil6mBKLnToTkTgi1AeWXD4hPFop4tnhiOq4woGDLmDmJQnkGJquD
         EogJ/fanyYjxtEVoQR6HZprKyPhJDKGRGV/tAzFkEqWdanQGm9Q7H+KV6i3/CWj4y+J3
         7w0xa7PIT+/F3mQV1GvopVb5pBFh7g3at6kZQxTDn/Ni1w9y8dAPxucyu1xql2eXFPjD
         db6g==
X-Forwarded-Encrypted: i=1; AJvYcCVO5EhD5IpXfY3qGktnJXkoEPLEDA4muqD+4D2qqgWMjJf0vblui1NRPn58Qp30I5Gz2EJuuA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6Qds5R0pFE7clTOAT9YBfY1wnY6wOIYMVxJofGtwOu3gQG0cI
	0tUTZaIpIN6U0lpG9pT3X1FztdM3kovHUGkOz9D6cJ4LkX29FxVsCKvN8F2yJg==
X-Gm-Gg: ASbGncu3bNZAijsuybuPXA/RhMsEcBA8LRAEaS3LVlJbnbrEhKNVSOcOaTVxdzywp+k
	ZZzxbvdcZ7+gj0BC4wEohzChsw8JgXn/oZr/cvO4QDRS7729MU0s2+s0YUFAWWdrp0MLpK2UJlb
	rzUA2xrMyOfLQlU3JFzzjuoAbK3ULje6dhIT6rzPegb5flbJVWt4w87AC2hisK6PcnSSGTtUQDY
	O+rv/UcRFMSjfhhz0/DmXVa4ePLcU3m0e7RdfVBcCcFpN3vqFUqZDrWgkVCrmyNyG9SLCCUDnMG
	E8PkkFsIxcdVl23tc1xgDRTuJZjjY6CQ8sit2pfXO9jc5zE9Ija5guqSTcNesCD7rQZ4sw8j9r9
	Kv4f8lKCvKP43YuJLwLoYGksny28rzQ1XRr3UqhRIz8s/mT3IQZDMXTLLYGYttlOoljWzMVJTep
	P+tGfDIJ/DlQ==
X-Google-Smtp-Source: AGHT+IGtHA5Ee0OiBN3gkWrsKmpv0EMJYXWmdH3KonzqV+RM6Cabd0pQIgojqenDpXG5nULwNzCZgw==
X-Received: by 2002:a05:6808:198f:b0:438:1b50:fd7e with SMTP id 5614622812f47-43b29a42c68mr5719481b6e.22.1757431421149;
        Tue, 09 Sep 2025 08:23:41 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-43b4a6293d2sm1100861b6e.2.2025.09.09.08.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 08:23:40 -0700 (PDT)
Message-ID: <e87a92d3-3e5b-4e5c-aab7-2310697b9fa7@gmail.com>
Date: Tue, 9 Sep 2025 10:23:39 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Quectel modem ceases working
To: Timo Ketola <timo.ketola@exertus.fi>, ofono@lists.linux.dev
References: <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Timo,

 > We have successfully used ofono with Quectel EG25-G modem in our iMX6
> Arm system. But now things break due to BuildRoot upgrade which upgrades
> ofono from 2.2 to 2.18. I have pinpointed the problem to commit
> 281b49763818, "gobi: ensure Set Data Format changes were applied".
> ofonod gives an error:
> 

Hard to say.  There has been quite a bit of changes between those versions and I 
don't have access to that particular hardware.

Can you provide a full debug log?  ofonod -n -d '*gobi*'

What kernel are you running?  Is the modem a USB device or directly connected to 
the SoC?  Assuming it is USB and the device gets detected at /dev/cdc-wdm0, what 
does the output of:
qmicli -d /dev/cdc-wdm0 --wda-get-data-format
look like?

Regards,
-Denis
