Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD29130AD2
	for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103259; cv=none; b=PkckBCP75A8Zv2S1kMdAIb3J/ZQIrJGFGNB5Qvc2fQGO0sA1wEYYRCmiUgUSjqhtYlKyYFGKXAaR/KjE2ZYtgvcIoZrSZvaHx+/4+vXC92ZcZUL3wMZx0qmF4b6FMdIeyy3C3mpPJHFjIs3z+JBmkPbAvaxX5T8inwAsYlKvKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103259; c=relaxed/simple;
	bh=XnXDRHY4rYTZpiLTMIJ26SB6yT4PqlWZDWmSsD75bpo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P+/JOQejEeyNeZe+W8v/ljkGc2zD7i5QUYXpTcpFtff5eV5/5YQglJjkw05yyhBtKoYPhAUrxt7YLDDvE2CLqCxY4xhVqVM03bZC5igmfERD2gs+PXi1WrIQ0lon8X+44BFxK88grt624hLEgHMa/H6PKIeQUyyzas/ii6xXhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tyu2GWlL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tyu2GWlL"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so157776966b.0
        for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 09:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708103256; x=1708708056; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrwQHeApJZKQTFpA47MdqfdMzzY9PSg1WP/S6Q2Mpcw=;
        b=Tyu2GWlLxiEbk47JsIrs2/H4dOH/ktXXQwbYWaZk7Eu7OEtUvftf1m9cg2xiqNG4pw
         s5qcctbOskQs1LDH7bbft+c0rbzl0+wu7AEr0R5f1xuOLXDame9znN2kKnt7QpjJWw9B
         6hAEJPNuDjMEEJr2zdEF9SSNnwmlyy6+LFpzBtV1YV0X85cDIUe8ZwJPo7KZQtP6ibBv
         r30Col4WscmCe48FxkPdWX5kMCG23byfT2PjPLRLvmAXBTppgunFi5u6U0m2S+CmsLcz
         ypujVlXNrh7//q/hl4nPScYWqO00sI8E0uppShTzDbrQObVOp1baOKdUx3pozwVGv9H9
         dsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103256; x=1708708056;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrwQHeApJZKQTFpA47MdqfdMzzY9PSg1WP/S6Q2Mpcw=;
        b=up3F7J2kRUNO+iIDHdgW2TGuM32CDp3XXq57WdIzSDKy+vtuyt+F2tz+wzODJ39GKV
         FVFaF8PkTNYU31s9bk5zP056RI+deY9GO81uyB4kJfmrcQ2f++bMuFzPdONTR6HVZG93
         2KFbYQkH5gH7uzo/GoqKFaZgkV0uT/eBn79+hmsBjU1Zq2EBvOsl6uW7omiROg38Yvkb
         6zyRzDbk7ZLjIF+v2v6dN1e6kqvo5na2BTE7XmcT3KIhsw7I1NZst/izqvhX6AoZCW6m
         JGlZmz4emSjbM8KgzEEDSiIrEBVRh1HbYj4FI5jgdU3mmZcaKeiO4xQKplHr6a+4QqzK
         dgbw==
X-Forwarded-Encrypted: i=1; AJvYcCXNhoNmWyRXwXRTaqIqWv17Cgeg3dFXPmXb7QVgc1V//39OCGfxIHAXDMpiAscmERIRbkIAQaQmP0YWVWU1KTYjgA3docY=
X-Gm-Message-State: AOJu0YxBj0IFPdkN55DHWCXaw2isZsPXRPCgZriNIBrRcX/HGNGb0kXD
	R3Q1Bkgz0VtuAOeW7dZUwI2FcSrmOSuHJIZkETcpEb0JYdf/MKlg/7yrUz04
X-Google-Smtp-Source: AGHT+IEtvJ864lZZowxS5pdhFUCP0qKT4kDERSta6mM3+6KCM07fuNI4LQQ+JNwlNOzaSvXBm6WmVA==
X-Received: by 2002:a17:906:b281:b0:a3d:d201:25cb with SMTP id q1-20020a170906b28100b00a3dd20125cbmr2215776ejz.6.1708103255730;
        Fri, 16 Feb 2024 09:07:35 -0800 (PST)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id kq9-20020a170906abc900b00a3cf2f71408sm131703ejb.152.2024.02.16.09.07.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Feb 2024 09:07:35 -0800 (PST)
Subject: Re: [PATCH 2/2] qmimodem: implement call-forwarding driver
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1707981467-2955-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1707981467-2955-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <7dc5103a-ec8b-47c7-9ddf-2be524701d20@gmail.com>
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <c4d9f7e9-2ce7-d59e-8a0b-ee65e866ec56@gmail.com>
Date: Fri, 16 Feb 2024 19:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7dc5103a-ec8b-47c7-9ddf-2be524701d20@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Denis,

On 15.02.24 г. 22:46 ч., Denis Kenzior wrote:
> Hi Ivaylo,
> 
> On 2/15/24 01:17, Ivaylo Dimitrov wrote:
>> ---
>>   Makefile.am                        |   3 +-
>>   drivers/qmimodem/call-forwarding.c | 352 
>> +++++++++++++++++++++++++++++++++++++
>>   drivers/qmimodem/voice.h           |   1 +
> 
> I fixed up a small whitespace warning flagged by CI:
> 0002-qmimodem-implement-call-forwarding-driver.patch:394: WARNING: 
> please, no space before tabs
> 

can I use checkpatch.pl from kernel scripts to verify the patches before 
sending?

<snip>

> 
>> +static void query_cb(struct qmi_result *result, void *user_data)
>> +{
>> +    struct cb_data *cbd = user_data;
>> +    ofono_call_forwarding_query_cb_t cb = cbd->cb;
>> +    const uint8_t *p;
>> +    uint8_t num;
>> +    uint16_t length;
>> +
>> +    DBG("");
>> +
>> +    if (qmi_result_set_error(result, NULL))
>> +        goto error;
>> +
>> +    /*
>> +     * we want extended info, because of the number type.
>> +     * FIXME - shall we fallback to 0x10 if there is no extended info?
>> +     */
>> +    p = qmi_result_get(result, 0x16, &length);
>> +    if (p) {
>> +        struct ofono_call_forwarding_condition *list;
>> +        const uint8_t *end = p + length;
>> +        int i;
>> +
>> +        num = *p++;
> 
> Can length be 0?  If so, feel free to send a fix :)
> 

Well, it should not be, but to be on the safe side I will send a fix.

<snip>


> 
> Applied, thanks.
> 

Thanks!

BTW, looking at the dbus call forwarding interface, I think we have 
issue in both org.ofono.SupplementaryServices and 
org.ofono.CallForwarding interfaces: We can have call forwarding that 
has phone number provisioned, but disabled. I don't see how that 
information is populated - if I read the docs properly, when a 
particular type of forwarding is disabled, the relevant property is an 
empty string, but that does not reflect the provisioned value. Not sure 
how can this be fixed without breaking the API. 
org.ofono.SupplementaryServices2 and org.ofono.CallForwarding2? Or 
additional properties, like VoiceUnconditionalNetwork (bool enabled, 
string phone_number). What do you think?

Regards,
Ivo

> Regards,
> -Denis
> 
