Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7615B992
	for <ofono@lists.linux.dev>; Fri,  9 Aug 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217229; cv=none; b=T/GNw7xqckjGc8vjb/E6QMUHd1lDP/w2icwJDE32Z25KCmgK1wlpPtflW2kWDeR1dKTi5EBWmNHjMXFHxX8cl0E+A7ELrcMu/eBPPg26PeNLKQlcniDf0Mnc/G6S84XwDHeatwjrtD20SrDHrwmUblikK0wk0ZFC9/zXbdRetjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217229; c=relaxed/simple;
	bh=kBwkUweyQPq7o/UzcDsWtvUQfRArCVUMRQR/krpVXEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i8NSpqQaNs0SCUbBvVJRG8JAGaEZeUeUvDrGFXmW5W9HFtoQQ8LL5MagARYX19Nla1PrKw6ZitlN9igaTGpfvqirdAdEA0KUtlPSjwRzNBxuIWKzazA6ILC0RNZYv2AXe3yzZ96BQbfZA0ScCl842bG6Z/AS7CXvuKhGm6X8cd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVHDgAc1; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVHDgAc1"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70949118d26so1517835a34.0
        for <ofono@lists.linux.dev>; Fri, 09 Aug 2024 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723217226; x=1723822026; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1tcr2rL7K47ulMAHBXQb4jnOEk4KVVY1ATPErMV1AC0=;
        b=gVHDgAc1eBBo/URm0Txvq+/wi1/bWQ8jJYypGc4pK/QuvwncbLDYsqdn5mj5QnWctB
         71LsJxr2BSjB7Ep62WNFUjsjhtrxJKhyHNxAqqQhPzSPNPh/NEo15VdC/BFDgKqt34iG
         jx+veloLyqyW8dFI4gqOD5Jf7W+8FumdFhtD0o7/W7+/C+zSfVSZ0OaLaOZvNos3AbL/
         NBvIO9NY9vLu034j2kyNm088RtETAgLEvxEiayNM1mC7bdUjhGzrgypp6h+AnhM0QUoH
         HIFPIBbPSwa4u091aaaL3+ZaVvEZL5I23tgTX/uRsPzyOgYADAFokbDuSuWXUPUtzWgl
         ZmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217226; x=1723822026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tcr2rL7K47ulMAHBXQb4jnOEk4KVVY1ATPErMV1AC0=;
        b=Wkr2Om3tzbhS/1idQtgftq+0n8CUv+krVBDmrQbGvF5ZJpsxjL+q1ETFSfpdoKw4Rj
         4Zz4smDrvRxTJb1U1Zq3iUxJ0kaeAXDJ2dbNrTcDgwGoxTYJ4uYNbcmLC/J1AlGhqR6N
         3ov7qXtm/ILe2Zir/PL+hEIZihAHNXAscZEkTaOZNrDjYV7eWV5CicynD5rw+7vAUkCa
         TloP6zVbxkqNeNfikw2IM9Kiu6DnO82YIjd0VTJd4wQcqehAX1tCFzFpu/GtWPH5qp4P
         zUimXioRpJkaHVdMXDbJg7KRRslQlEXSv/UhG98tX73SS8kFFMuV5l1GRYuPTQU+gB7t
         OJMg==
X-Forwarded-Encrypted: i=1; AJvYcCW0mcXJmYTcKmV4J/LVOFZq9FfsKEe7++qJHDE2wDTX5kCcjzOWVossSE2vNXAPtUzeMpStGUs3DAP2WBxV9txmrRxTfGM=
X-Gm-Message-State: AOJu0Yw9F9JNe0Tuw6gOMSYgyrcCe650hLvMnAuy0EIPy3U2uAF4SqQj
	AgZbRAHcsvgX8aXWeex4lbTuJAkOfHhzfeQJLeiYwcQHyI0GiDq6lareqA==
X-Google-Smtp-Source: AGHT+IHZlejK8vGns8IVNULOwWC2mH4kJcsFBr93BuH408etnbyCn8l8GkSHSM4ohbBSiS9GYlNQ8g==
X-Received: by 2002:a05:6830:630b:b0:703:6d5a:84a9 with SMTP id 46e09a7af769-70b7487a1e6mr2560668a34.26.1723217226558;
        Fri, 09 Aug 2024 08:27:06 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70a3a750d08sm6322016a34.62.2024.08.09.08.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 08:27:06 -0700 (PDT)
Message-ID: <81655272-5b31-4694-bdaf-2a36b4ee04d5@gmail.com>
Date: Fri, 9 Aug 2024 10:27:05 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smsutil: check that user data length fits in internal
 buffer
To: Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>, ofono@lists.linux.dev
References: <20240809111213.853665-1-j.lemetayer@kerlink.fr>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240809111213.853665-1-j.lemetayer@kerlink.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean-Marie,

On 8/9/24 6:12 AM, Jean-Marie Lemetayer wrote:
> This addresses CVE-2023-2794.
> ---
>   src/smsutil.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/src/smsutil.c b/src/smsutil.c
> index 39f0ecc6..7f065d9d 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -773,6 +773,9 @@ static gboolean decode_deliver(const unsigned char *pdu, int len,
>   	if ((len - offset) < expected)
>   		return FALSE;
>   
> +	if (expected > sizeof(out->deliver.ud))
> +		return FALSE;
> +

This doesn't compile cleanly:

Fedora (glibc) clang optimized
==============================
Configure: PASS
Build: FAIL
     src/smsutil.c:776:15: error: comparison of integers of different signs: 
'int' and 'unsigned long' [-Werror,-Wsign-compare]
       776 |         if (expected > sizeof(out->deliver.ud))
           |             ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~
     1 error generated.
     make[1]: *** [Makefile:4073: src/smsutil.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2383: all] Error 2

Fedora (glibc) clang debug
==========================
Configure: PASS
Build: FAIL
     src/smsutil.c:776:15: error: comparison of integers of different signs: 
'int' and 'unsigned long' [-Werror,-Wsign-compare]
       776 |         if (expected > sizeof(out->deliver.ud))
           |             ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~
     1 error generated.
     make[1]: *** [Makefile:4073: src/smsutil.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2383: all] Error 2

Alpine (musl) gcc debug
=======================
Configure: PASS
Build: FAIL
     src/smsutil.c: In function 'decode_deliver':
     src/smsutil.c:776:22: error: comparison of integer expressions of different 
signedness: 'int' and 'long unsigned int' [-Werror=sign-compare]
       776 |         if (expected > sizeof(out->deliver.ud))
           |                      ^
     cc1: all warnings being treated as errors
     make[1]: *** [Makefile:4073: src/smsutil.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2383: all] Error 2

Regards,
Denis
