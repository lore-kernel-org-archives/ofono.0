Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1E381AA
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925300; cv=none; b=f3KqqTVg5MB8buRXCBPQ3FmrqTtT0DTCQKD7lbNpMiM9BL0UPLL7hR+IC6ZpPIXVhgLVAuuOTVRmXrXJalgs8TBnWVCVEo9OwfGPjR/QkAJErBzf5VTYV5fHNzwSCGNE2+KwggIS3vbiEwtOJtVgQcgQIXufNsSiIOuuBSlUAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925300; c=relaxed/simple;
	bh=LQVDEWDUNxWeARys7cxnFZLkbhq7bQziNkaTpwq7ntw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2eHHorB5yGxa4tQsXw+6ItPpRERQhBQjTc3L+56ZN00B+hIK39uca+491iaVgLSiK8KuUpDEebJfG9PG8L14xeRhzFqewaWTz9j5yEVnjkcw4Xt/qB4AnjPWcWUHX683hP+m/sH60+rUWHmNxsCZFPzspzQGjMtgpPoe39Gm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEPmKk2t; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEPmKk2t"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa69251292dso563214166b.2
        for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 05:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733925296; x=1734530096; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mrk5WsXmebiM5XJAjVxQJuOcZ0VC10zCq341GxTdTck=;
        b=PEPmKk2tQ1Xjt09xEEZJ3a6x+2Hn65PzNx5Tfc/2rshAuq+6zhftTLXJCQykZO+yrq
         9a6tW1taLO3Aq4MqjsbmZZRgod+RDm9UELY/zUkaRbn1yqs+x6kQ5lxOm3aHpnZaLwiW
         MqCM7wUtKnd1tSHH2wNn3Wet7D+C/5lfLIfAGTa3lpiv8GJBA/KURmbmb/LU3rweBYup
         R0aI3QyoGdV8Gk8RhHt/5kwp1rM/VWTeMdsVPbE3kUvZNCNY97R3LpJVIMLkJcj6NDq4
         w8f3acQXD4GY9MKrvdv6vmu8spyIVEq87ey7v9vMBh+GCes/6+HScZIlgtCS4vWogp9X
         pCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925296; x=1734530096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mrk5WsXmebiM5XJAjVxQJuOcZ0VC10zCq341GxTdTck=;
        b=euBu39cwN7NI0fsX6I1s66U0aOs2qdvB2+9wcbbvjkUeVKIuRzEzyzVUptEs9bUGlC
         cDFAf7zVn7ilAHeY5aN7wg0wGcWOmST1yHZeXitp0mXmKh3LI7ni1uzZksnYMtnWzxWQ
         kChyhJfhLlRdvX7Ob0mz8lD/zH+lbWikjUvUmSx+3sdQyQwnx6NpsZvO0ogvKCboenYs
         W724pqWCztLe+IXCXMds34FvQT/hWfrS1m1t8Nc2KLy1Pm+PHqYd0XdoKkSKqmpvKsP4
         2yZGvxOTE1DzPIyxMD6aqjYjmOcLrX7BLLdzkz/woQCpSszUJnBHnwLm1T98KlwxW+fY
         bqyA==
X-Forwarded-Encrypted: i=1; AJvYcCXVd2q7l6FnZ9uLNxczrylP3qW/PW0p8IK/uNMkY0ux0II2MiH3WBAlsPKuw8dQhcwEPbFQPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOhrU7q4ti6wVTADHJsv7V5qgAJh5RNmYNj/Uh4YnIbMjfUPGU
	WJUVVn+7tuh5j1oVFiViyaHylfnl01rQ67Zy9nSrlCIvn0a7HqIVln6dAg==
X-Gm-Gg: ASbGnctnDLiesr7YSObcaLO7P3UBhykEUbDklMkFky+UY+NZiZ6JSxc7sQK1T2hYb4Q
	E4UYSau5faeM+ZrySPqIJiy8/Xq6Ija811z/o4aHL9s3fRabIJUid3E5VzLd+Hf8U4H2d/oxWz0
	1drcFGC5Xc5tuPwEY9Aji7wXfZvTLd3zUW8PSWcXLKUhrZzgbg0CRxwyQODwcTdtjP90KA39deI
	PnG4Op5X763S5dczjmIGSEBDx1IrD1vOBXeArNx7qgX41nnnnNi7XmQp9WqkaHTk9c=
X-Google-Smtp-Source: AGHT+IE7bBJr6cKY/U09ZSANKyNPTDuCdIDmxg6O82YpzK9sft52I2SCnSki4jgrZ/RUEjjI0h5scQ==
X-Received: by 2002:a17:906:9c2:b0:aa6:40a4:b13 with SMTP id a640c23a62f3a-aa6b14fefc8mr248196166b.59.1733925296278;
        Wed, 11 Dec 2024 05:54:56 -0800 (PST)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa69f67ab64sm292680266b.204.2024.12.11.05.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 05:54:55 -0800 (PST)
Message-ID: <0579e270-d57d-40bb-af96-011e463e1538@gmail.com>
Date: Wed, 11 Dec 2024 15:54:54 +0200
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmi: radio-settings: Do not unconditionally try to enable
 unsupported modes
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20241207172050.191314-1-ivo.g.dimitrov.75@gmail.com>
 <acedcbad-dd01-4423-9fb7-3c90081ca5a7@gmail.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <acedcbad-dd01-4423-9fb7-3c90081ca5a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,


On 11.12.24 г. 7:13 ч., Denis Kenzior wrote:

> 
> This looks like copy-paste of get_caps_cb.  Lets avoid that by invoking 
> QMI_DMS_GET_CAPS during probe().  See below.
> 

I was looking into doing it during probe, somehow missed 
OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE flag. Now I see.

...

+    if (rsd->rat_mode_any || !get_rat_mode_any(rs, mode, cb, user_data))
> 
> So your intent here is to query the radio capabilities first if they 
> haven't been queried before?  If so, then the typical pattern is to do 
> this during probe(), before calling ofono_radio_settings_register().  
> See qmimodem/lte.c for an example.
> 

Exactly(the intent), but will do it like in lte.c

...

>>       available_rats = 0;
>> +
>>       for (i = 0; i < caps->radio_if_count; i++) {
>>           switch (caps->radio_if[i]) {
>>           case QMI_DMS_RADIO_IF_GSM:
>>               available_rats |= OFONO_RADIO_ACCESS_MODE_GSM;
>> +            rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_GSM;
>>               break;
>>           case QMI_DMS_RADIO_IF_UMTS:
>>               available_rats |= OFONO_RADIO_ACCESS_MODE_UMTS;
>> +            rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_UMTS;
>>               break;
>>           case QMI_DMS_RADIO_IF_LTE:
>>               available_rats |= OFONO_RADIO_ACCESS_MODE_LTE;
>> +            rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_LTE;
>>               break;
>>           }
>>       }
> 
> Wouldn't it be easier to simply do
> rsd->rat_mode_any = available_rats?
> 

No, because available_rats are of type OFONO_RADIO_ACCESS_TYPE_XXX, 
while rat_mode_any is of type QMI_NAS_RAT_MODE_PREF_XXX

Will send v2 with the above issues fixed.

Regards,
Ivo
