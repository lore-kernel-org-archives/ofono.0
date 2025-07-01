Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6D2C859
	for <ofono@lists.linux.dev>; Tue,  1 Jul 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382180; cv=none; b=o7LhOZ5eB1dYAH/Z9VHqzL5DsM2jnNxu9ECoVsjSkYteHxp2evbfRDZjdJDyto785Pekq/KBrvLcFz6Gkdm8kIoclikr+6jyCVV8WDJ4iK+gd5P3Vl6zb1vwyBCbSvXhpcYL/poB1tTUHAM0M7duUitQw70Z+VSs9HLnLuGGlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382180; c=relaxed/simple;
	bh=yXXQHeydvlfAArq3oBqW31jkxL534P2xl6M1J9VhxKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uJejpNsiABGj4TLWthtypwClsJ/jZwoJg57r1FX6i2mIUBn7//Ve68jOrLK9vA3abVEDFTiIn4RzSt2pBK/LinUkv9mCg4isnNAnzsVcxwwQ33xxQBHq2Hqfl/iL/nttFSyD/Oo/W4SJitqeAfmlpTgqOGITLWq2ZdT8VK6QgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJuYI56k; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJuYI56k"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-611f48c6e30so457678eaf.0
        for <ofono@lists.linux.dev>; Tue, 01 Jul 2025 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382177; x=1751986977; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ks8dDVOoXuj8DTDxnAUGxC+R8r4FDwzKRfahdDxpU7w=;
        b=IJuYI56kDGJ1VLD/dcM2s4mjT8jv7RDTTzu0SqtUH9eqxJXQDhgXhRhAzO84JvGXUd
         WBdJmMGLXBXILz9NaTyow9U0TnYU9E5l+N9ANnxzBJAdI/otePzhTsLtVknsosxq3jjm
         6/L8c0znhSV91kW3f3i+Uih3dqkRRq5NAPZ8ds9b2aygEb0jueAwrv0XXdkkZjmGmMg5
         MetsmYZZCGdSUlZW2Ww+hIIIlCMJOfirXMq5GV/qwnfIQ6Skc4i5AlHmEOxHb62OUjm5
         l18Kjj1ADwUJ1mYn8UgCT7jcfHH6cpWJvzFM2YnDlBJSKGwxDXOwnKw2CiM2rtfItAOx
         NTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382177; x=1751986977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks8dDVOoXuj8DTDxnAUGxC+R8r4FDwzKRfahdDxpU7w=;
        b=O6FXKtabPfS7kKBazpvA6Lo9mmi7P7CYB4hEZHWlEnySSIjux2yNl08nq90V6cuu1w
         c/dU4Ndil42VHtbCMFDjJfJQ1kC64mEMxgJ9aFHiNzl1KLwaIpo3uflWlyHrEFpp/lRC
         lgs4Q2AydruOjUX3lna19nxK+mzYnse0DTTUmSaXzFDQiQwd/+RcfNW2/1eVZzfI9Nmi
         wEbcMK3T7oOipzsOCmcubaw+y4pOg2c9HMv1PekPu6FhiLd+15DUT/Fq8aO7oC79qi/D
         5gTvM0mBknvhhiZgIMJubHr+UkyjSmt2gmOgqDGR2ioFZGcCxQ1exBk3shfInU+3dfZ0
         K0xw==
X-Forwarded-Encrypted: i=1; AJvYcCVYBkXmdtdD+vkYcDDCc4dzBuXOjEVVwgt0shkQkU3kNkXcLRcx48W/LqWS6YGxz++hjRUnsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDwZnIYijvP5Xrf1R71ka0aq+8VEDDpcPnMqtYEE9OTPtnRkwa
	hgbf9CRQ2LskxMwhkyfng2EVpRsJdc5tqKlchmtddyrkgqz5glx3pCPkeA0BwQ==
X-Gm-Gg: ASbGnctrLQUKiSHxtNBz6xalvA8NdcpJ2d+VEHkXDDAanpNvDlmVdetUmMw/XDcHMBX
	wyOuORIjdgr+3/hSdX9SFNENl8MjkREidr6dyyY0osb/CS+RLbuNi+thR6XQLMwlS7yhkNs1AWB
	EYLl1Ds3qO1xr/LHsrORXlrvIsOAElpVBsoCID2U0H9WA5ytAKmViROPZWfumDjX6uRi0KtWfOj
	NSg6sWz1Y5RKUCs9Fc9QFgVn2Yoq+aY/4/HA2lCSAL8ZWOiyOyFHBFp4F9eX8cjNthlHjaxZ1Zu
	Mq4Ct8J0DSo4uGlB+CJNgijGeKYOBYmTH832BdHvCaMOA9D4IiJiLH+9kywmOnTjKRamZU8I1PH
	FkNhaEfhkJw3KHIqHGuMlMJGAT8E=
X-Google-Smtp-Source: AGHT+IFJ/KK1cMVTydQmhWY4IQ32r4nBsFF5aF++vJVz3+G6JJTrvaVPuatsupLaV5q1UTd5WzqG3g==
X-Received: by 2002:a05:6820:2112:b0:611:f244:dfa5 with SMTP id 006d021491bc7-611f244dfd8mr3371504eaf.2.1751382176857;
        Tue, 01 Jul 2025 08:02:56 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-611b85c7d84sm1389205eaf.37.2025.07.01.08.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 08:02:56 -0700 (PDT)
Message-ID: <6f5e3e42-bd90-4951-8ddd-f11f5d8c4765@gmail.com>
Date: Tue, 1 Jul 2025 10:02:55 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] doc: sim-api document ForbiddenPLMN
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
 <20250701-fplmn-v1-4-d7fe9c901b57@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250701-fplmn-v1-4-d7fe9c901b57@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 7/1/25 4:29 AM, Sean Nyekjaer wrote:
> ---
>   doc/sim-api.txt | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/doc/sim-api.txt b/doc/sim-api.txt
> index 419d8ec3ef17fc5b2876d1047249ab76bf608cce..a127ad55b358c082e853e15f52eead5bbbf5fae3 100644
> --- a/doc/sim-api.txt
> +++ b/doc/sim-api.txt
> @@ -227,3 +227,10 @@ Properties	boolean Present [readonly]
>   
>   			This property will range from 1 (default) to
>   			CardSlotCount (max) value.
> +
> +		array{string} ForbiddenPLMN

Maybe ForbiddenNetworks or ForbiddenNetworkOperators?  I like to not use 
all-caps acronyms in snake-case APIs.  We also use NetworkOperator in 
network-api.txt...

> +
> +			The list contains a list of forbidden PLMNs
> +			(Mobile Country Code (MCC) and Mobile Network Code (MNC)).

So you want to always be overwriting the entire list?  I guess that would work, 
but note that the modem can actually manage this file as well.  How would oFono 
know when this happened?  Does the modem send a SIM REFRESH via STK/CAT?  Does 
your vendor have any guidance here?

> +
> +			Max allowed elements in sim is 4.

This isn't really limited to 4, in fact it is variable length, see 3GPP 31.102, 
or the ETSI equivalent here:
https://www.etsi.org/deliver/etsi_ts/131100_131199/131102/18.04.00_60/ts_131102v180400p.pdf. 
  Section 4.2.16.

Either we only support the 'clear' operation, or we need to expose the length 
somehow.

Regards,
-Denis
