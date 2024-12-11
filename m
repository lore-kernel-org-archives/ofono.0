Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743914C97
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896154; cv=none; b=ZTST0n/eNtveTx0yeaKv49oVBNmyj4HUR05NbPCqv/O+NUTfECQtrpeGjkq56H+TbLvZmRicHYRKQF6hDvUcTzhM8W3sjf6voR510Yx7a72GTLVzw7pyKAcFkoyZD9ku+1kQbsCnMvzip5O+omETpYinMkE4iKGwJ2KYVEOgzy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896154; c=relaxed/simple;
	bh=2J2B6Amc/ZUNjRYszNEaB2jhAQatCM7xM1giQ8YSOBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPmxJRUVuMJYNQsuD3enEkOh7eQbfc+VSBS9oFSLKFhWlZfiFn2yrUzFsCKg79sjwL3xiRwDEo9GrytbN2Z3rt1j6invVpUK65TVzCkz4AP6LJZ+VZO4cGGac+g4LKu39VTG8RevGT4OaSLkUUN0jtbKod0dk7vXjVe5XHOXHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/ssODLP; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/ssODLP"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71deb3745easo709925a34.3
        for <ofono@lists.linux.dev>; Tue, 10 Dec 2024 21:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733896152; x=1734500952; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjl53amH8PNvFGOJ6HrKWxpgAd0l51Cc/ejNBBXOV7I=;
        b=Y/ssODLPgXMh1kOaGjSRBk9U5EVx1vcqcasvrew4Mr6K3V4+d3Ejk1hRL7VZv3+ATz
         a9K0gbOQz0q0Rdjt8YJtnPqMq85gkfvMdBUP+Jy4kkIDUo0Gks/Eh1peL9eJeK0tgirZ
         ftK6xo06lkvfkJQSJ3JeqX6imoJo/2zlGZ4By3vxVJSqiaK/ZVxCCGHBGmQxKfRlf+NH
         zjTpIM3YUu2W6r370i7/2o7IeMOAuKIgwDKudWvlPDGHlVuXN6tbCKuRzZ7cqsSG6MEz
         BezOarDxWQrqoL3znEeJxMmakbx2PwR9jYZRKJdNj+z9xVhy0vOiJvld/cSLMwHOLhxj
         h9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733896152; x=1734500952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjl53amH8PNvFGOJ6HrKWxpgAd0l51Cc/ejNBBXOV7I=;
        b=PqDgW+k+pUpaFL4cgiuaSkWFvSc7iIe6TixhtaPhlMwVmTUYZOR7W78R+el87ly4mw
         ERiHBdUsh4vSZdlg0HyWzE/Nq+Z/fM5Y1FO7ScQ0+naBQeP+y2TOISaMw009tR7Sar7T
         YS+8PPUgZtCoocIRzhr5kQojvRhwucQ6Zpr3LkWY9WogAsiOUNSyjAhId5Qo7ahdHSEq
         OJEvi3ht5T4BE4GJvT95ayfNrB3h2FbQmSKEZHIp5qWxLK/KfPFoUVjyQraq/GHIsbNa
         6hsVtmiWGW/ibenLAbwZMbbaCkMzp/HpBhlKrvmCm1gu7EyRHQ2XUHUF6iejNz/tlYYC
         ZSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ4qLUObJtIc9VxxL/FVlD7T3FMfcTGh26m6qlauNdT43e/mDJ0m5/IaIwZhEVzhXCrpRmPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfCvELoaYHX3avdYUg2W1TBC0DyP5o0d3tmSQ+gj2IH7yjsZIT
	s2TD3FazOYFFYv5oVRq+8qcPh2Xp8qbke4XTEiOsW/HJ44JRVffM
X-Gm-Gg: ASbGncs6ixMPMmw5LHApYPy4t7B6Hav55lQC7illhic6pLTy7rM4flSeXd898jsbs3x
	3U11K7/Zqud2nk9Ro4fvUYU1s7GH+dtAdL0cvpaX3K0MRTSWTb1Zwr6yZxb1WmwrKIW6Ho32U4C
	0lB5GyFS28AZt8oSEtNKtG1mRMGNTGR8BM/+NiqId7acgd1pDq1mYrOOElMUL+kgoysKD9pQX8x
	Lbeh4v5l+d9VSXRq3HoEs5JGeT4NcTW+yYE+SWvFKNnD5r0wIWhefGhv1JEGPWK1tShLgNILElO
	XqmiTQuTuqLYkNDKm8I=
X-Google-Smtp-Source: AGHT+IF3C+PLa8ih0KbG3KZMfcI8aaiie2+0Jqs8SXZ9JemzN2m3Bu6ZCfKVOH3t3p4jqWvvmy/6Aw==
X-Received: by 2002:a05:6830:6e91:b0:71e:1c5:4f77 with SMTP id 46e09a7af769-71e19b2e439mr1025567a34.20.1733896152495;
        Tue, 10 Dec 2024 21:49:12 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-71dee9d6036sm1631030a34.50.2024.12.10.21.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 21:49:12 -0800 (PST)
Message-ID: <4bc4e74b-9f31-45ba-b913-39a65d7653d6@gmail.com>
Date: Tue, 10 Dec 2024 23:49:10 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmi: gprs: query for tethered default profile instead of
 embedded
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20241207183551.198810-1-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241207183551.198810-1-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 12/7/24 12:35 PM, Ivaylo Dimitrov wrote:
> At least the modem in Motorola Droid 4 returns error if embedded 3gpp
> profile is queried, however, it does not error if tethered one is used.
> qmicli uses same when doing --wds-get-default-profile-number=3gpp

Okay, but what about lte.c that does the same query?

> ---
>   drivers/qmimodem/gprs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
> index 27060f9f..49259234 100644
> --- a/drivers/qmimodem/gprs.c
> +++ b/drivers/qmimodem/gprs.c
> @@ -418,7 +418,7 @@ static int qmi_gprs_probev(struct ofono_gprs *gprs,
>   		uint8_t family;
>   	} __attribute((packed)) p = {
>   		.type = QMI_WDS_PROFILE_TYPE_3GPP,
> -		.family = QMI_WDS_PROFILE_FAMILY_EMBEDDED,
> +		.family = QMI_WDS_PROFILE_FAMILY_TETHERED,
>   	};
>   	struct qmi_param *param = qmi_param_new();
>   

Regards,
-Denis
