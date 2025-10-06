Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6782D46B4
	for <ofono@lists.linux.dev>; Mon,  6 Oct 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758971; cv=none; b=k0nKCfYgirNvD5vtdey9JhhAxivh0TZof39IWE6h/ge94hQzhd4QcCM+Pdf1j0itUup9kCcDo3N6qdyZkvm75Pr7YDNeuzqvv1Sng716m1eU5H+5HP9aWZpOG7xsSLm/3ZTDq/zyUK/p5zE4jd6MlHOqkNamjxYSLKa3sS3XCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758971; c=relaxed/simple;
	bh=F22wpLTA2DH7QgmCCyZ57MhSUiUgWQY0jkX24SMRfqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L2UxYyPrCPvaaxRzkM1EuEQzb1OBB3Fi3V9e7qn7caBXyyv0AqdM9TUaml8FlmIrkvIWL7ELuCAE/c5C7iA4vRXuTZ1VRCCHogOdrbHWPW8Q6I6nFgITEz76ZHt/msE6Goj6rCrfiLUZroIG8ev2Mb5FhjBxEVxstJymeM9/NcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILCPhJS4; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILCPhJS4"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-642d3310780so2588037eaf.0
        for <ofono@lists.linux.dev>; Mon, 06 Oct 2025 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759758968; x=1760363768; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcJbvORnZJA6jmaLTsPlK+kERv1sJYqzAuPU4RELm3E=;
        b=ILCPhJS4csevdB2MxCKONv+BIokXO1HNrtqSgThJMaQ0i+0zDdhpA78OtsVHzeId74
         a6aptF0/4ZL6+c+g6DfnN1XhCOPQc6C9E9SaeWKx8kYPFCTrtuugPqa3EJWZXxEZ9sZJ
         +tOD9mlueQEHJ/T+wLUVwZ6PAbU/YgSHr0hFMtvPsI6g6eJbRqFNMeGnXJAiMbo81sfo
         4G0eYI3lXCPtv3MhVrWsdIOJilPag6tSHxohgEdR9YmBWonah1H337Rc0CidaPLdEi3J
         U1XvyA++3fhkBg4LeaC2UPGA4ohAylNjoscqDf/zRcz8HCv+eUvwPEDSTmYn+v9hToim
         B/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759758968; x=1760363768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcJbvORnZJA6jmaLTsPlK+kERv1sJYqzAuPU4RELm3E=;
        b=ey6Q8MbBRuWErm6WrPE7oJ/FKoWxQdr85epnMLeYElnZD+FV18D6zO8B9bR3UZfnLC
         qKQIBq3MXyZH0XD6+5LScIUaZFpPlBsuLn7O4vq1ZVf89s3/DQ8c9h/rvwxE/HLLDLAq
         6TvxnfB/NseXoY66V86HYkiCXFMwVTyn80yeShEdj88hHWSsJ7LIk0iSe2m88EzOBKaA
         MM2w3XykAXwDX4u7TCmPWQU+RpSjOmYchZfoaEXgkVQvnzcukKNajk2GpY3b2dr6xLG4
         fSQh6SW1dO+00qNg05vuhLz7Myw5mSYeANWUI3rcxhCE+BaFkARU26wjRLWZBMhtprg6
         szCw==
X-Forwarded-Encrypted: i=1; AJvYcCX10bLraJRRF5lLDyGAZE4z6q8KyrIsDdVyfkays7Eo86dFriuAiPKpiKPmhkw9QfchqY1dtg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/eUuNebJcwEDwYPRdML6sYLhNjxLn5dyDhjvVY8royixbAtrs
	yuoAnmTMs3o/1vY/1ZxLkk4SeoVboQJtEQU/h/HwzNG+j4u2PlxR8awH
X-Gm-Gg: ASbGncuO067lU+qjBpo6rwfE+6sS5u4k8+Il5STEcWdncQiI+G5tDN3PAYXlQDI23eN
	LVizcqPmBQ591SGU3EmG9lS5LP3CiHDu0/hSBrx9/MN54r5IdJgVKinzC+ul49HQq4pv+H0v3XV
	oj/ZIh7i22bVaN05WLaLjgY/4ONBy4Yj0ty7mjpXwrMLHHLaaf6OuNuQHrfaEBio2RV58IQ9iLg
	8uqI+CpE5iSKhBToRhF2N/wIswRZG+B1KCGWkLLsH0m6Rwel2m6MPSK0ehdjo10jW7q5agD6gVp
	ZhkjaBp3sMB/JuM5L21lnyYQpbQgEebB+wGZcpFKkm75oatl/1eYaQF5mGezFeEGrVeGNAUPRsg
	wEAkX5pBVzcGpHh4d/TktM4G01KWME5V7xcQR7JMOpoi14ET/qyS69i9pP1iI/z2mJUAKA4gYHN
	ZHR83aLYBR+tpitl3sbE/lDLtDYWZJ8NlYmA==
X-Google-Smtp-Source: AGHT+IFOtJDMuVmPBntc4x/hK9c1cPbL2m/OjTNlB/lD9QHwU9B+07POKyTL1LjEdaWfAXMBDIYQgw==
X-Received: by 2002:a05:6870:f10a:b0:314:9689:a467 with SMTP id 586e51a60fabf-3b11fe17c5cmr6567849fac.23.1759758968039;
        Mon, 06 Oct 2025 06:56:08 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-3ab94d983adsm4048101fac.27.2025.10.06.06.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:56:07 -0700 (PDT)
Message-ID: <53399cca-6444-46d9-8250-7d909d8511af@gmail.com>
Date: Mon, 6 Oct 2025 08:56:06 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Quectel EC21 with internal GSM MUX
To: =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>,
 Christian Meusel <christian.meusel@posteo.de>, ofono@lists.linux.dev
References: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
 <936c9eeeb421fd6f215bd7dc1e26fb9cf00d9f3e.camel@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <936c9eeeb421fd6f215bd7dc1e26fb9cf00d9f3e.camel@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 10/6/25 8:15 AM, Martin Hundebøll wrote:
> On Thu, 2025-09-25 at 14:55 +0000, Christian Meusel wrote:
> 
> <snip>
> 
>>      Sep 25 14:45:48 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/plugins/quectel.c:ate_cb()
>> 0x4f6400
>>      Sep 25 14:45:48 target ofonod[4030]: at_chat_send_common:
>> enqueued "AT+CMUX=0,0,5,127,10,3,30,10,2", len is 1
>>      Sep 25 14:45:48 target ofonod[4030]: UART: >
>> AT+CMUX=0,0,5,127,10,3,30,10,2\r
>>      Sep 25 14:45:48 target ofonod[4030]: UART: < \r\n
>>      Sep 25 14:45:48 target ofonod[4030]: UART: < OK\r\n
>>      Sep 25 14:45:48 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_cb()
>> 0x4f6400
>>      Sep 25 14:45:49 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/src/modem.c:get_modem_prope
>> rty() modem 0x4f6400 property Mux
>>      Sep 25 14:45:49 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_acti
>> vation_delay_cb() 0x4f6400
>>      Sep 25 14:45:49 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_gatm
>> ux() 0x4f6400
>>      Sep 25 14:45:49 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/plugins/quectel.c:create_ch
>> at() 0x4f6400
>>      Sep 25 14:45:49 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/plugins/quectel.c:create_ch
>> at() 0x4f6400
>>      Sep 25 14:45:49 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/plugins/quectel.c:identify_
>> model() 0x4f6400
>>      Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common:
>> enqueued "AT+CGMM", len is 1
>>      Sep 25 14:45:49 target ofonod[4030]: Aux: > AT+CGMM\r
>>      Sep 25 14:45:49 target ofonod[4030]: Aux: <
>> \r\nEC21\r\n\r\nOK\r\n
>>      Sep 25 14:45:49 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/plugins/quectel.c:cgmm_cb()
>> 0x4f6400 ok 1
>>      Sep 25 14:45:49 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/plugins/quectel.c:cgmm_cb()
>> 0x4f6400 model EC21
>>      Sep 25 14:45:49 target ofonod[4030]:
>> ../../../../../../workspace/sources/ofono/plugins/quectel.c:setup_aux
>> () 0x4f6400
>>      Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common:
>> enqueued "ATE0; &C0; +CMEE=1", len is 1
>>      Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common:
>> enqueued "AT+QURCCFG="urcport","uart1"", len is 2
>>      Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common:
>> enqueued "AT+CFUN?", len is 3
>>      Sep 25 14:45:49 target ofonod[4030]: Aux: > ATE0; &C0; +CMEE=1\r
>>      Sep 25 14:45:49 target ofonod[4030]: Aux: < \r\nOK\r\n
>>      Sep 25 14:45:54 target ofonod[4030]: Aux: < \r\nNORMAL POWER
>> DOWN\r\n
>>      Sep 25 14:45:54 target ofonod[4030]: Modem: < \r\nPOWERED
>> DOWN\r\n
>>      Sep 25 14:45:54 target ofonod[4030]: Aux: < \r\nPOWERED DOWN\r\n
> 
> I think these "POWER" notification from the modem are the culprit. We
> carry the attached patch in our setup to avoid those messages stalling
> the AT parser.

But they come exactly 5 seconds after the initial power up sequence.

> 
> I must admit that past me would have written a better commit message,
> but here we are :/

But these URCs seem fine?  They have both initial and trailing \r\n and no 
trailing spaces?

> 
> With that said: Why does the modem choose to power down? Is
> someone/something toggling the power-up GPIO to the modem?

The 5 second timing is suspicious.  oFono core does set a timer and will invoke 
a .disable() if .enable() doesn't succeed in a given time.  But the default 
timeout is 20 seconds (see src/modem.c DEFAULT_POWERED_TIMEOUT)

Regards,
-Denis
