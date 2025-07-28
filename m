Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25859CA5A
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721309; cv=none; b=mmTnIdf6ugX0VE0+GoJGDkrUL6iEYOXu4t3DGSZS23iFWX1z+S9FJpPHyPXJobwFCKmlsK5Fa4uFXGO83UVuQAT3Hj3nK1USX9otd76ST/b2krJU94JUTCNNUh1uEkEKwVRx476M947jwiHSwveJ/kO0zF3cJjVBLUZAIsoCdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721309; c=relaxed/simple;
	bh=XnvRBuh1bXrE5m4t5wftbUx9D41ujgzu8JCaR4Psd80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPGFuUjteKargUIW0G6UVcP4Mgdz3oW4AShlgCl/a+4t37o2AE9HlXB7khOR4DxfA27prL+JEkINFv7uiD2m0Dvq5zP+sUHGmUTfsM3ir4uCb4WzekZSyZG7qe16iBbnF9uAtDDP7/fgfXYXFNe0EDufIdxyX4eYgI+eYTu/Rxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYdGMGxH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYdGMGxH"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6148e399effso7765404a12.2
        for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753721306; x=1754326106; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sw9QljWJO67mxYcEsWm7ywNzALB2MkGgdc0UijP3qAc=;
        b=RYdGMGxHhwaTID22brHC8rgPNPfKQ29vU24GKssMiysj/neIt/4dLtfK4Mywy7JlKJ
         7sCIpxupW1wQlapivQ+JMrohjokwm9z2Qm4DRIunsb+1uAXA0KFnibX05/Xiu0NirUIK
         C3xj6C4C2G4hzzaHZj3hifekgRz4GEGNsSEv3LRlxRF5sY1COh04P5RV6HXG2o0LIeyV
         4ntDfayg3HhVp09w9R/f7gQwplY43t5C700Zo4VsFhr8rG9z8244CvADXpX/TVzpR3Bu
         FnhG1XU4wCW3QfxpyLBBqZ9BOaM2O5nm8eo7mVPfvFJt//NgbemCBHDVhn00FI0+2V79
         SQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753721306; x=1754326106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw9QljWJO67mxYcEsWm7ywNzALB2MkGgdc0UijP3qAc=;
        b=jT3YU+fzT9yWprOp3AXDLNII5vFtTtEsPTdlLqJ0OUO/Xu/LscqVJgG0wpks74Exmn
         9XHN0ZU9Yw9z3tH5/uK74R8sFXRJb0EnUVWWb3Fhjlv2ZSzcXTo/j8JZ4ZV1DwaOzZlh
         PGuGtQjGwk6Q/m5XXkV9Oo4wsim761JoWmeaJcvbA3dyAF+cTbL/w63ZYKmP3l53k/c3
         GiICT50zcyIryojYvHX3goNBmrbr3UpdNcmr6pg10tuSEJZOj5wuizp7B6OXKzXiv4na
         ND9xkNiYpDd7Xi6u5Vr5CD1DzB/mLuQWAUvKZxiEVjCc3TBAJCVr+6l1UpHpxsiovkLL
         2R9g==
X-Forwarded-Encrypted: i=1; AJvYcCWNjiazcxWIXoxK5GcwxQ14fbrMpag5pM3JkVfAW1uMjmPxgDnJxXtKiUfFfMcvRJ5x6LCZuA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8mZ6rPNh2RzFbzG4q7juYvIwkNT6zCpMA8Lzd5Xus8NqHFekU
	QiauCElPA1F7HKWFIkIImul9j1HsaQlIyGo2pGDRzpIQ6KTT+FNjeX/5
X-Gm-Gg: ASbGncsHjd7jVN8vS56LMZdaZi/NkyXAW2VBfmJ1+9T6BxmiJs0wUKRHkPlLGVpWPYa
	l6/TnPUaVCTmGm67pvZIm7HXZPG2sFrWkkDlSH23yX2Ihq6XRfB0eKlLHkNhyBYKdHhLvP6QOJp
	J+UiNUQcYZk7cwOmoJbHuzIschb0P5J3hDGTNmbLPD2Ux3bLYyDjXqj95WAZLS2Xla1C5ZJ2e6Z
	AMsLe9G5IB9hRnE9t/UBPo61uLSTAvuEYXDqCQ6JIgeBC/njdYdnMOclT7FrQLYpVCuiSV20foA
	y0POTUh3XWHuL0Ul82pV1aZ6lMWeKMc6etQDi6c+dIadTyX684KMWwca4sRhckPRzUZFxtrcWpK
	pnEjJjYR3kgbnNiigU4jIPu2cYkSYzdCpRr4=
X-Google-Smtp-Source: AGHT+IE6ifoR1AiwGNhaNEdWzr0gLbyv1miVtyRZvBMqAhUmMEU5x82fRux0C+A5XdfiCCWjlhoE1A==
X-Received: by 2002:a17:906:6bcc:b0:af6:5e95:2809 with SMTP id a640c23a62f3a-af65e95286bmr392610666b.58.1753721305959;
        Mon, 28 Jul 2025 09:48:25 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-af635b427aesm448403766b.145.2025.07.28.09.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 09:48:25 -0700 (PDT)
Message-ID: <d3b0c7ae-308e-4685-8b90-c154e89863f6@gmail.com>
Date: Mon, 28 Jul 2025 19:48:24 +0300
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] gobi: PERSIST_LOW_POWER instead of LOW_POWER when
 disabling modem
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
 <20250725121954.650668-2-ivo.g.dimitrov.75@gmail.com>
 <63de4b6f-9af8-4bfb-b97e-8d5c7d53e53a@gmail.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <63de4b6f-9af8-4bfb-b97e-8d5c7d53e53a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,


On 28.07.25 г. 17:39 ч., Denis Kenzior wrote:
> Hi Ivo,
> 
> On 7/25/25 7:19 AM, Ivaylo Dimitrov wrote:
>> We don't want modem to auto wake-up when
>> ---
>>   plugins/gobi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/plugins/gobi.c b/plugins/gobi.c
>> index 52ead377..027c4dba 100644
>> --- a/plugins/gobi.c
>> +++ b/plugins/gobi.c
>> @@ -442,7 +442,7 @@ static void get_oper_mode_cb(struct qmi_result 
>> *result, void *user_data)
>>       switch (data->oper_mode) {
>>       case QMI_DMS_OPER_MODE_ONLINE:
>>           param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
>> -                    QMI_DMS_OPER_MODE_LOW_POWER);
>> +                    QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
> 
> Not so sure about this.  In the past we've had problems with some QMI 
> modems either not honoring this mode, or turning off entirely (my memory 
> is fuzzy here).   Perhaps we can make this an attribute as well and let 
> hardware detection logic set the low power mode to use?  Similar to how 
> you handle LTE capability in patch 5?

I see. Ok, will send a new series without already merged patches and 
with this (and the other change requested) implemented.

> 
>>           if (!param) {
>>               shutdown_device(modem);
>>               return;
>> @@ -922,7 +922,7 @@ static int gobi_disable(struct ofono_modem *modem)
>>           goto out;
>>       param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
>> -                    QMI_DMS_OPER_MODE_LOW_POWER);
>> +                    QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
>>       if (!param)
>>           return -ENOMEM;
> 
> Regards,
> -Denis

Thanks and regards,
Ivo
