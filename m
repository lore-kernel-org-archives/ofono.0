Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3A1946BC
	for <ofono@lists.linux.dev>; Tue, 29 Jul 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827203; cv=none; b=GiRD4xYyWsLUrTl3fy31xIITbUxaI1uZrhFyVj5zLQGk6oGIS5kaApgGbQ4V3ljInxtBxAtHXlmxBqOKwQokQHr8qIs5Y/59P2J1KohPiXIlIO0IknxjqfV8kxyTu71YqOAqQdghKB2MVQoDhRKqSl/W7bmfh0hm0HryyHZAQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827203; c=relaxed/simple;
	bh=01WCHAQx2+CFwJUDQgvTRNSOdH5h/TaGqD7NWifa4S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nqy69/Fp0qQf4mohOb3Et9d28GyyqM5+5xo6mxJJ5sPKPK98OaZ/hEzMvCuGjbMbK6hjQp5bThwsd3P5TTiPGC/zwzM2JFrAw0kIONxvUHXluSC5/TQ/a4w0v1Dp0vgFiBzWruODkIG3Y8t/LlNRCfwnKvX76YC3XPWSucznIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbbQcWPE; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbbQcWPE"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30063371404so1745247fac.1
        for <ofono@lists.linux.dev>; Tue, 29 Jul 2025 15:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753827201; x=1754432001; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxVp2YRjs+hzCI8O/e7+xb/hFFhZo618n2Z0CkSleSk=;
        b=XbbQcWPE/6f4xAaOrDVfdGIfz7Yr6RXkasjf1m5P3Y4YNMX5CTIR8FfGRKiWC16YxA
         xQZlqM1mnOLb/jQrqWNTwIp0MZpCCeu+lsXLnFIdlhB97r65oCMTS8DoEDIK1UIWkugU
         XeErEV59SSNniSRBSEuZT+W9qbO4FG7eOAL5WwjxHgz9EPNHQEsEqKCMTXHI8+rcDMaw
         S6DMFX5EMlp9ayiqfXb9yvTbOMAY27SgwAiQINglSNvgrUeP532Cs//LrFoTPHc02Zex
         cQ8khBZ4IHcs+BOcTdec3U5bo7xrMwvOeU8C5BY6pZmgimGeMhAdRiqJY5cYTlKgZROQ
         rc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753827201; x=1754432001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxVp2YRjs+hzCI8O/e7+xb/hFFhZo618n2Z0CkSleSk=;
        b=Z8FIJ9PNWsy3w0Z5d39ypW8vFonp4LTULDogVAga+o7mekeQv5+1uvLECMnR/x7Sf3
         sy+rJSROwCNpxu3ELJ6z3Wd8Pt2eQC8Qe1s407qArgNVx6y7dPX05mxiwIx/7ZyCWEix
         HqrH9HfzspGPE1LNdP+NPMHNUa1Oixw87HOBXvji0oGseZtDHnsikGGXVoHhvQg7z2hW
         /FAJUAmrFM23DpxqvAboYTiC7uaZhPfRFG2B3j5hL5UHnpBLDQ7GbjAg7zlcZiA0FSYM
         VeNLaz1AdlB7ZOLKykJgiJ48CVwmeAcAo/dBfMgWYTpY7lz108HForyjPUa3+3qwbKfB
         y7qA==
X-Forwarded-Encrypted: i=1; AJvYcCUDGhj3ehfjWc/rz1XyOB0EpJxxEpOXgkz0Rf/P8FrhqC8JaT7HnoF7hCfxADmX3NdVj9nbdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyL7c1f0AF5GJtS1bZF2u3DUO9cxXK5vS0W56m4hrxVjdxQLRCi
	bCJ3oAVhopHMRaEOfp78FjqKFwbkgS9rmU0A2tXKWyr/IQpTNYC5PHLS
X-Gm-Gg: ASbGncvFQ8SpE92+wlykH0FlJK8BhuHpaslng8E9pi3TakLB3RkarDMmi9eNv/xplyP
	Kk/YnTYl38Qs7Zz4PNCGP/8nGx7FX39LRXj1JsKTRsoN9Kf54TJULcB4XA9axIwEZb3oY/DXoek
	N+QVyoKeB/3VLj9jOdIV0YN0C6JqiW24qRXBM2PClnZVAZ9xBOjdNUSllm8ief7Pb7vuvXKsuJ8
	rnzNKAKee9rV/9O7YHkYDe071HfHAAst5HvGzybEfnalkoJjiKaDgeoy2GPCgrxUaVNnwQZkKSH
	ndRWddOx80hwi7BjqDfaJTeXE1ty5xZladhMaLOMcTR886cewojSg0i1yzGUTKi71CLzEdtKqZ6
	tCo5s1GfsGgPLci6V+G6AtgWd36s/UCXQCX5bcq9CCi3yJoamDyzyEQHh92mBxxvxhcZ/a0JaNu
	s=
X-Google-Smtp-Source: AGHT+IHyhO2mNGfjBXzOegq8ttAwxfrYvQOHMSdzNSUPOSHYIKjQ3xJdDPOZuKkbnPkVERic/Z4QHQ==
X-Received: by 2002:a05:6870:8e17:b0:2df:787a:d8f9 with SMTP id 586e51a60fabf-30785ce06d3mr678180fac.26.1753827201209;
        Tue, 29 Jul 2025 15:13:21 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-30713239fd4sm2556208fac.13.2025.07.29.15.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 15:13:20 -0700 (PDT)
Message-ID: <c9d38d00-fb53-4f72-8087-9b81efc2d2f2@gmail.com>
Date: Tue, 29 Jul 2025 17:13:19 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gobi: do not assume LTE is supported, detect it
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
 <20250729052132.779994-2-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250729052132.779994-2-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 7/29/25 12:21 AM, Ivaylo Dimitrov wrote:
> ---
>   plugins/gobi.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)

<snip>

> @@ -480,8 +480,17 @@ static void get_caps_cb(struct qmi_result *result, void *user_data)
>           DBG("service capabilities %d", caps->data_capa);
>           DBG("sim supported %d", caps->sim_supported);
>   
> -        for (i = 0; i < caps->radio_if_count; i++)
> -                DBG("radio = %d", caps->radio_if[i]);
> +	for (i = 0; i < caps->radio_if_count; i++) {
> +		uint8_t iface = caps->radio_if[i];
> +
> +		DBG("radio = %d", iface);
> +
> +		if (iface & QMI_DMS_RADIO_IF_LTE)

QMI_DMS_RADIO_IF_* do not seem to be values that can be used in a bitset, so I 
amended this line to use '==' instead of '&'.

> +			data->features |= GOBI_LTE;
> +	}
> +
> +	if (data->features & GOBI_LTE)
> +		ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
>   
>   	if (qmi_service_send(data->dms, QMI_DMS_GET_OPER_MODE, NULL,
>   					get_oper_mode_cb, modem, NULL) > 0)

Regards,
-Denis
