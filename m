Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830524634E
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932292; cv=none; b=twiN308KPb3dQK1/ua+b55YmXO+3YnqQ+A3LjhJQ8JJHLQOoIoEv+kkzrCwwiEnwlvWsPXuS6dLyKV+119lL7IrdlpCNIUjihLrRdYf8hYu3e4VuUQwQuEgYih+EWXuewkxUB8cKDNffMZBgXVpNYu97bL265t256KVau4JdUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932292; c=relaxed/simple;
	bh=heMul/wLg182sv6woWK2TYaiHzZU6fXG14uM2/ylIM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMcDArEQEFHfgqHzbkSlLMCJrxYhDgfgSaTOYS29u7qBAfqRgyUvaPuaEk7uKBRtscqibbLkIQaWPvJeH3YrSU184YNe4EgadVVnhCmRIlgh4w3SZSZ0BukS7rnSu1dYi74traBtxp6ZgAdOlZiaLivKBbNhc5Cbzu12kCw7rqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InGfUGq3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InGfUGq3"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so8323021a12.0
        for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932289; x=1734537089; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcI89Bzbn0dHL7zpa/Vpt4/wevtrl/an89x41GcJeag=;
        b=InGfUGq3oF1hWyAb+K2SiGSh+ENGwALR1jitZFgoqaobNsMKdsv5Krsz1MLJk5d2iW
         RZbAsCMgvGdlFlJtT0WhmwB5W7XFuaRG3ybg9WAjYRnfRVTQloPNahNPTTx2+88xopkn
         55P0+rrhRO/2d4MiCsshQCIqSdUxS59FIxDG4Vs7KR4flwjYz9diu/uwrhTjpFnkRaRV
         t/io4lRi+LLE66QUCugBD7BPjkmZR6vZAVyYUPeSQPut/0I7688Qa5eKTTTZ0Yw3a/kE
         VlViBoaXOmxy6eOU2Z6lxZrBW8JzWMhDqhNHUmUIpPCO6PZCdMX4E3qjiaOQTpf2ChnD
         B3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932289; x=1734537089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcI89Bzbn0dHL7zpa/Vpt4/wevtrl/an89x41GcJeag=;
        b=Wr+Vd44HP+RYOUAxEPsWpfj3nbskeG9bSB+AAZxpB1Dky5finpYzP/l6wFo75FfKI8
         q9N6oiN+jTxxo0n3/kxEESEWZEZ2gIspOr3c8MjWM+MIFxxIN4UdJTWjx/lbHIF3uVad
         /jCmpAHtgR7vThIDrMwAYrVN+82p+FLofo623CBlhmFIsVxXgBidUoGVcWvF2pLR2I7d
         ey1z87McPvU4BPSNXEalQUjENTU0sYqx6KD1xkT7EIfs66N6p96H6IJtTKWMCF1TxQl6
         q3Y5miZjcFiupTnaAOz2qtosYxqYoLNi+GSsR6h9vO0gnDMPd/4zVp1rGxpNehV9F3b4
         ufSA==
X-Forwarded-Encrypted: i=1; AJvYcCWt4U8u/TJvZna0JtJ9E/7FAXq8/Fny1Qh9AmGS8+NLWGt/RWRh0gn3cKohQfotd/SgXzj2xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXxX2zWR2BtLhIXDKQnO9xKSHkIQhJ7EguopduZ651deKCT6Ey
	fF9RZiGrRTNrLsGvHMQyydPRtgMgc0Z6fKdffK4cm2EkYYbkbjaP
X-Gm-Gg: ASbGncvV9BYdFwQPZUe2t9tmBHw6WH6C3TlneWlK0mYd5k0BufP+NvMD8KvNq8jMUKy
	xOIfwlr2uSzmAbZx2MID2CSwJHSFZz8H1TUlyfumlv5EC1wrnZIbxiW8TkdbSShksv2x3JNKlim
	DF9dmCxnVnlMviVisr9TI7S7oIcIJnoyYKWIRyTI/db6jGWpkBhKIXnZ2b/fdV8m8ykQiU2mIVY
	c2hJk7jJ43djSheiYVpVwVHpbfiPZmDw23b1hbohHNyG3OP5xiVX9UblrWZ1WN3Odk=
X-Google-Smtp-Source: AGHT+IEw4VlCpAy3Dz0ROZm1GbaQrLZ47BBff5zNQZjmhcb+/BiRbqCCNqnrCbB9XWz98R6B5UF0ng==
X-Received: by 2002:a05:6402:4310:b0:5d2:73b0:81ef with SMTP id 4fb4d7f45d1cf-5d43316aa58mr3311109a12.22.1733932289076;
        Wed, 11 Dec 2024 07:51:29 -0800 (PST)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608faesm9197569a12.44.2024.12.11.07.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 07:51:28 -0800 (PST)
Message-ID: <713dbce1-cac3-4cfe-9848-af2582592e36@gmail.com>
Date: Wed, 11 Dec 2024 17:51:27 +0200
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qmi: call-forwarding: fallback to basic forwarding
 info if no extended
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20241208113410.251171-1-ivo.g.dimitrov.75@gmail.com>
 <20241208123946.255405-1-ivo.g.dimitrov.75@gmail.com>
 <f7e7e80b-84e8-4873-8cf4-3e66ad4760bd@gmail.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <f7e7e80b-84e8-4873-8cf4-3e66ad4760bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11.12.24 г. 7:27 ч., Denis Kenzior wrote:

...

> 
> const void *p;
> 

I'd better not, see below.

>>       uint8_t num;
>> +    const uint8_t *end;
>>       uint16_t length;
>> -
>> +    struct ofono_call_forwarding_condition *list = NULL;
> 
> A nicer way might be:
> _auto_(l_free) struct ofono_call_forwarding_condition *list = NULL;
> 
>> +    int i;
>> +    bool extended = false;
>>       DBG("");
>>       if (qmi_result_set_error(result, NULL))
>>           goto error;
>>       /*
>> -     * we want extended info, because of the number type.
>> -     * FIXME - shall we fallback to 0x10 if there is no extended info?
>> +     * we want extended info if any, because of the number type.
>>        */
>>       p = qmi_result_get(result, 0x16, &length);
>> -    if (p && length) {
>> -        struct ofono_call_forwarding_condition *list;
>> -        const uint8_t *end = p + length;
>> -        int i;
>> +    if (p && length)
>> +        extended = true;
>> +    else
>> +        p = qmi_result_get(result, 0x10, &length);
>> -        num = *p++;
>> +    if (!extended && (!p || !length))
>> +        goto error;
>> -        list = l_new(struct ofono_call_forwarding_condition, num);
>> +    end = p + length;

void * arithmetic, UB last time I checked, unless you are absolutely 
sure compilers will do the right thing we'd better keep it like that. p 
is used all over the place as const uint8_t *, I am not sure there is 
elegant way of converting it to void * without casts.

Will send v2 with fix for the above clang error and using _auto_.

Thanks,
Ivo
