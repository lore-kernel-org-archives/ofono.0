Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D0198E9B
	for <ofono@lists.linux.dev>; Wed, 30 Jul 2025 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753853058; cv=none; b=PTlmpaP1ceHCcxZwMDCgS+ZA2ArO/2tKtj/nmRYZdamkPoq42b9Hdw/xpU1p/zeZnLE8jZe/aGQXcsU4QFMqHJ/ySi04Jst0oYFXa68R3M+2iJvL7wyovl/DxOAc2ZLG0DDiXeGD/ppof7mGCnxq489OEj1RcWrPZrjmiPUwW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753853058; c=relaxed/simple;
	bh=8AuZ2mpTVvO7gOBYgQcR9f5PetXffenHufsnV6prTFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsi2uUXMLUCpuK6mjAQ4Yt89BPykDyWFxP7PdeFexWNDc44iDhSEzwCiLuAJWlOIxS747j+zjBTXZElWd3QXKVjE0/1GlJ43c5cQDK8M2zYLDQK67tKMnnWsGG6mnrS5NVj2h+iIroawtBj9HQelvty8bNuv/VVuIGeDI1ug548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOUgrWx6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOUgrWx6"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af66f444488so414425466b.0
        for <ofono@lists.linux.dev>; Tue, 29 Jul 2025 22:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753853055; x=1754457855; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPVv5PZbWO7xHwUoBTnqEshR3Qy2uIsSKJFGXmvfTIA=;
        b=bOUgrWx6ZtoJDMJ3SSf1jUh9I7ctxiTks2z9MPPTEVP05HJb6Tbe43fA5RhEcIEDYT
         sv9MuBatROy1HGi0xIVaAXHVkw7rj8J+4V0DzQi/Y4dZj4y++KvXBk9QaOAUq8960/Ts
         jed1C5WUvD6CL+3zDx46BGK6tQyC4LiWeMdG1J407MNz+6VpnB2WuEfMwg9dQrByDjQO
         aCGxxlAArFFCTdjrBkk4sFq0FUz9WmDZ5Ibr6Rg4xDoXjU67v+n9/9YOWAaZIXPYfECD
         SzyIQ4B80OLifk1D9nEPNWEk7LACDHtA+6pW+jR8GjU1oHV0B1Ob47ar6TV/6OqhzVsI
         SeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753853055; x=1754457855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPVv5PZbWO7xHwUoBTnqEshR3Qy2uIsSKJFGXmvfTIA=;
        b=wx9bgH2UwpogBd9STGiVqJedNqdZc0LJcZNhSfTS6WVN5oua+6XZ9g1HWd00DK0afp
         twOeLcbVlvrcUfP6bFattp3b4VFeG/ISmX5GHZaRgw5Kg0E9S/oH29DKRHzOR0kUM32j
         nxcKLCSa+NBoDuqh5pTZfdTkDE7h3CdFaEqKGVYrne4m5YawU8pGZSpokBzY3Y4v91MZ
         GB4b5Cb/oHCB6KexYroGe4PiX70h2shyv6pnhqwaK3HQkXE2I4CWp/6AlmPXd23b+twm
         mVhk0HlZHxOtg1gPeU6+19qE/YcI+puFbiZWvuQfCldRc8FWRoobMVrNyzgy9rK5EVcx
         Bong==
X-Forwarded-Encrypted: i=1; AJvYcCUCVrlIpGJwit2THaZKLBLsMYGV/6sNi6ozo89wuzM9ozPP3B1fkRLbDGNhTODYfzf4XUemdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzafzdLyDnN1pTjkJo75MASikKgW/fwBRoLKO4HqgGg4MbW1vX7
	Zr23KSBQgThR8nXsgBVA5w7z7VnNzL3MxX3QZ1MThr3Tylf4cN1PqczEhwvp9A==
X-Gm-Gg: ASbGncts7d22rYgVzMfv2KYEdKfQlGFV3tPdPTL8hEcTh3FS9m2iAoHSpi0MoY/rMQ8
	jlZMUqsYTW9rgJuSzYBwmbbRcWs15tEFQXyro+6sYeyWLpwF8A4IDH0QNdTwZpgWY/YCArzCLhY
	rmlgN5+dWNdW/4HCu3YeRl9e7l4GXJ1IJGVnLWwb7MY8VsGPMGa/UpVeSEIWEtkfWwd8yWa5Zg0
	BGfSWqEMzS5N/aRHO+grJ809qmEAbqj8PN4yGmiwmhXk3XYGzjaxTuhzZoDvvmbyK8JGFgxSuQi
	BJBp3rcuBLcBQpiOnjcjzlRem7qEsWygnpV2sNExaHotl9Pmm3IRL60ehdozUUreruwp29CkGoy
	V2HGZccoZRUDUIPOZsBaJsZ09q1Go80YJN2E=
X-Google-Smtp-Source: AGHT+IHd2e/wqJg7/cB9sF0tGXI+dPzAzI4tXKGapNfMSVYDLg7m9rx9zGvLfvsiKWo4aWC34DDtug==
X-Received: by 2002:a17:907:60c8:b0:ae0:b847:438 with SMTP id a640c23a62f3a-af8fd714674mr245361366b.21.1753853054678;
        Tue, 29 Jul 2025 22:24:14 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-af63585ff7esm689624866b.4.2025.07.29.22.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 22:24:14 -0700 (PDT)
Message-ID: <e16c7a5a-13fe-416a-9943-a028761ac861@gmail.com>
Date: Wed, 30 Jul 2025 08:24:13 +0300
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gobi: do not assume LTE is supported, detect it
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
 <20250729052132.779994-2-ivo.g.dimitrov.75@gmail.com>
 <c9d38d00-fb53-4f72-8087-9b81efc2d2f2@gmail.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <c9d38d00-fb53-4f72-8087-9b81efc2d2f2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30.07.25 г. 1:13 ч., Denis Kenzior wrote:
> Hi Ivo,
> 
> On 7/29/25 12:21 AM, Ivaylo Dimitrov wrote:
>> ---
>>   plugins/gobi.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> <snip>
> 
>> @@ -480,8 +480,17 @@ static void get_caps_cb(struct qmi_result 
>> *result, void *user_data)
>>           DBG("service capabilities %d", caps->data_capa);
>>           DBG("sim supported %d", caps->sim_supported);
>> -        for (i = 0; i < caps->radio_if_count; i++)
>> -                DBG("radio = %d", caps->radio_if[i]);
>> +    for (i = 0; i < caps->radio_if_count; i++) {
>> +        uint8_t iface = caps->radio_if[i];
>> +
>> +        DBG("radio = %d", iface);
>> +
>> +        if (iface & QMI_DMS_RADIO_IF_LTE)
> 
> QMI_DMS_RADIO_IF_* do not seem to be values that can be used in a 
> bitset, so I amended this line to use '==' instead of '&'.
> 

Ugh, right, how did I not see it.

Thanks!

>> +            data->features |= GOBI_LTE;
>> +    }
>> +
>> +    if (data->features & GOBI_LTE)
>> +        ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
>>       if (qmi_service_send(data->dms, QMI_DMS_GET_OPER_MODE, NULL,
>>                       get_oper_mode_cb, modem, NULL) > 0)
> 
> Regards,
> -Denis
