Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ECD7EF03
	for <ofono@lists.linux.dev>; Thu, 28 Mar 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639081; cv=none; b=n8b2L0GhnpD35JVhaQ2/HcwJjyqmk1rUodCLUJGUdcbaH2R5K9ml4BP5/zXvmT15vEMUHNromW/E15csxOgO5e7cWF3WQ04X3DZ0jlJ32AGxjhJe9hE19grxIVKypmXwbTUL6h1+7VeAQstE7Fq6H9ojZzSrRp+YWPzVoC/fiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639081; c=relaxed/simple;
	bh=YPfNwydxrOZ3myFQOgn29LllE5V+YE/f+4O/lRb/+AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IvGhUJ2RgP9kxeI83youUHpDlfDI7cc3xgPd0Sk4zG89O0xdZEPY0QBQCavdEUlTcJPoSvVn/PdDoa0QLlaNko49FdNOetFYtk5+ilNKS/T5FjPxEHq+eo9IFDzSmr0dAck7L1u3QIiyqyEgDb9S3G6ZzffFqz8WTMiPTwkNpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPkrCNvh; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPkrCNvh"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e696ee8fa3so1126778a34.1
        for <ofono@lists.linux.dev>; Thu, 28 Mar 2024 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711639078; x=1712243878; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmxmi09RJAfK/H4ayEf73jQ+9m/Wu7kuhxTnBdNVKSY=;
        b=MPkrCNvhUs8rUefMsqWVPY1C9Ai0BB5IUJccy82S18LlitZR/3A0QcVpGNkEf1JZrr
         /NByYDHRqgcH8rrjuuTL2DVarK1RXvl3l2bsotT2oXtNj0ZjryQa5tLOJUoAk1bw/RrZ
         srbFigf+LjolgsBYykWxqjQCHSPX7v2KF9DG5eYolZZOWFjjC4ov13pL5X1kSeohqUvh
         XuEn7mf45D7qCJe/Yg8plQFmEKa+C/zXh1prbrP7F/+hQZ/fdDWAVupzFE8mT8EVYeCG
         9GwJdjNyqEvkwDaWdqjZ2Jhb1Y6UV9Ym+Sv7iBC54Bye3xftYsiqhBv94LeEYSmwosK3
         bV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639078; x=1712243878;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmxmi09RJAfK/H4ayEf73jQ+9m/Wu7kuhxTnBdNVKSY=;
        b=ZLRBr/Ti+P1azdPykgdTIjLqctDQOAYZ1OLISkzfRFkMoBIxyZklr3pFp2TBOrlNm/
         IeiHs++PWTrj0vCJhcb+DpHdA8ApMo1f0vQS1A18r/lMaSAnzYiPGysKrO6mj1/zv+ju
         D147C067p+Y3bfyHGWSAgeJ2WuPjaocAVMo+cjQoiPfh/kes5/jFfqIUkS3orXjRVVjy
         D/i4La0sv/ONAP2Z6LPclrAvx9np82bqH+/8ErNRyHBVhiJWgIIIKpc4oBdQXk4XmqMr
         /n/iyPPJXtEYQCze7YoxgPPFaj0RodPzRKOOmUjcByNbyvAP15hSCq7qUytJGyuwF7EX
         ztxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZoeZHbiKwJc7hHKCGW6oPhNeGorRSs348hsRGdJhaTcaL/Noqc948Oe61d2oKw+rGs2l2MJfVSukdneHwzMqNAVE8Hrw=
X-Gm-Message-State: AOJu0Yw5EawA+tf1SuVTztgPQB9HAiXwAoVReE1q0I22M9i1hQYv3hmq
	a8WdIf4tHvxjqLYMWTBWB6ngdCSZZAwB4+mOii4iyPLYCzRBsrf7fY5za4mI
X-Google-Smtp-Source: AGHT+IEevgqGIgXA92PjCrjOmMTw6mkJn0Yu1P24f3dhvjD4HyXkI0elMCq22Mo02Vat0xy34Ukn7Q==
X-Received: by 2002:a05:6830:1d55:b0:6e6:ffff:fc3f with SMTP id p21-20020a0568301d5500b006e6fffffc3fmr725381oth.10.1711639078466;
        Thu, 28 Mar 2024 08:17:58 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n9-20020a9d64c9000000b006e6c9a56591sm278379otl.19.2024.03.28.08.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 08:17:57 -0700 (PDT)
Message-ID: <a952ae20-b8b7-4725-b3e0-848f2b635525@gmail.com>
Date: Thu, 28 Mar 2024 10:17:56 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] atmodem: sim: when reading sim files, avoid
 incomplete result lines
Content-Language: en-US
To: Christophe Ronco <c.ronco@kerlink.fr>, ofono@lists.linux.dev
References: <20240328081157.4586-1-c.ronco@kerlink.fr>
 <20240328081157.4586-2-c.ronco@kerlink.fr>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240328081157.4586-2-c.ronco@kerlink.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christophe,

On 3/28/24 03:11, Christophe Ronco wrote:
> Modem ME310G1 sometimes add incomplete result lines to first AT+CRSM
> command. Example:
> AT+CRSM=192,12258
> +CRSM: 0
> +CRSM: 144,0,62178202412183022FE28A01058B032F06068002000A880110
> 
> OK
> 
> Parse all result lines starting with prefix until a line with at least sw1
> and sw2 parameters is found.
> ---
>   drivers/atmodem/sim.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 

<snip>

> @@ -117,11 +118,14 @@ static void get_response_common_cb(gboolean ok, GAtResult *result,
>   
>   	g_at_result_iter_init(&iter, result);
>   
> -	if (!g_at_result_iter_next(&iter, prefix))
> -		goto error;
> +	while (!nb_found) {
> +		if (!g_at_result_iter_next(&iter, prefix))
> +			goto error;
>   
> -	g_at_result_iter_next_number(&iter, &sw1);
> -	g_at_result_iter_next_number(&iter, &sw2);
> +		nb_found = g_at_result_iter_next_number(&iter, &sw1);
> +		if (nb_found)
> +			nb_found = g_at_result_iter_next_number(&iter, &sw2);
> +	}

I think you're going to need a comment in the code, there's no way anyone will 
understand what is happening here after a year or two.

Also consider a few other alternatives:

if (!g_at_result_iter_next(&iter, prefix))
	goto error;

/* Skip to last response, include comment as to why */
while (g_at_result_iter_next(&iter, prefix))
	;

... proceed as normal

Alternatively
const guint8 *response = NULL;

...

while (g_at_result_iter_next(&iter, prefix)) {
	if (!g_at_result_iter_next_number(&iter, &sw1))
		continue;

	/* validate sw1, can be 0x9* or 0x6* */
	if (!valid_sw1(...))
		continue;

	if (!g_at_result_iter_next(&iter, &sw2))
		continue;

	if (!g_at_result_iter_next_hexstring....) {
		cb(...)
		return;
	}
}

if (!response)
	goto error;

/* parse response */

>   
>   	if (!g_at_result_iter_next_hexstring(&iter, &response, &len) ||
>   			(sw1 != 0x90 && sw1 != 0x91 && sw1 != 0x92) ||

Regards,
-Denis
