Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA723A562
	for <ofono@lists.linux.dev>; Tue, 30 Sep 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246485; cv=none; b=HeQlxzKOO86U1cES4EJe1FrUQiAFpjNazbsSpIo9zdKNmAopeVCXgtK2CbJ0/tyBi2l/Qh6QzRUO9SY8qSuXZzrkvBJKmzW9GL10dWTcG9bVSyG7ElrMHlk9HOYzOb4NdKx0z7Q9PHQv+4WbbD3Ad0Fiev21SV6DGXd3mjsegeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246485; c=relaxed/simple;
	bh=MPx9CInPyD01hq+pF6lmNWqGT9BODpz1anr968rsdgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ObERxY/f7SFgGjFULU8v3+/RhycPVYX9262s0b3N9QAFPG4yZLn+AWpRle6nmUdM2/dNAaB8qZuekZx9GMWbsuo+RC4XMJCaCt1E3PJZoUQ62k2yzZotuivPADm0NyFmZ4O79mEW56GfX3JxOLA3J2d6waAFgw1DLbCOqrF6nB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJgvIEea; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJgvIEea"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7b06f879d7bso5057a34.0
        for <ofono@lists.linux.dev>; Tue, 30 Sep 2025 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759246483; x=1759851283; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=747FYAeZ59bbiV5d9Ebc6oRTOXRFeNsOO6YASGb/1b8=;
        b=eJgvIEeaFRql/yVCRn0P/6fPp47RR+OOopD3bD4v4Mg7UsMUGMJ0uzGVJavlRGPrU9
         g5zSdXn6j1VMD+qIsGoLLWXKiX+UbzTaDVZnm5Mwo16Zmy+srJPddDtuuvz6covShEug
         rl95/D7ejEWiDrk3YFH4Ttrxl4v9eCsCJq/dz+yHME3VDjNFnIISXW2PR8giBacJ55xl
         S/QWGm9VAbeGHZ5uhJ1JlGnPe6JwTCo5Np85esvNWnLZUVV7bEpWvRyO/uwrVBae+R/T
         eM2BdULyLmece01QB5GTqlRJGBeMBqrp7zEDDQta7+iPjv15GAWKm+frco89HVNpz3qd
         SmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759246483; x=1759851283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=747FYAeZ59bbiV5d9Ebc6oRTOXRFeNsOO6YASGb/1b8=;
        b=bD7KUAkfd6QCt5xr33uox5TNL+9imb/YLnjE9kLu5KBce1KaK3lnvvBLyVP6VVBHxL
         49jdCklLG6YGvc3V5YRCaSw0p30IfXopZoOCdvDRLfSWdBS8CRuk/NqZiJ0kYX94nq+C
         GsOphH39efe4C1oWHGD67y2vFLr2nxNUET8BNrZLM6keU2qzlaUXPL8XDHzLabFt07Po
         GUpFRT5lKtPsXhk9h18KPRWHqqJmDMf86ps156Sm4lxMDWbIPsCmWQpW5TmV4hSqPgfz
         jVpDypJppcra9DpCdcSQRMhWSoDeWfECOGPGqCk+Z2ug8zpQqADXb0/AKYF4niGQGL02
         ocdw==
X-Forwarded-Encrypted: i=1; AJvYcCWulDCycf36PjcOkm/fkNCSoDWTZHqHOrfd/LXvD+a1xjHMeQMySiYxS1lcIuX1dK3QYpRaoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcxtJydSahkNYdOLQqLRhqLrEdQ4okqbsbZxxehmpZYb1EKPHW
	iSLN7pp6QianNkgseI6uo+osTrRSTRb7g7FQuP5zQcgdi0yq9iTtNFXY
X-Gm-Gg: ASbGnct5HQI0k6WCSsOCEjndmAjRpzeSA6sCl4yy04sRVXRya1AzPX5KVOzlQxRkg3K
	mfoFbkWrfGXdLSIFFKRKbS6quJyFQjcvzzk24N9hFvHjoHcPpzqnz7USPhVkfUCs1wdGqOJ+XQw
	QZaPIm8B3h9fD24BafOkVtImixow755h8b4ib1b4pav7Zsl2+YhKorkvTOgASh2QENSoF+Js+UO
	REogg/oqtaxm2eMwZJtZjVjT41kC4YrEgRUhWtI3rpa9xUtHhIebBUsNey4oEgoPgWHkhFPHJnS
	yhAe0Vqiphn1RT68gMlgt2CvREkL4TtYpf246V0lvPQbnWcraqwFQTMziTfyx68DfXzkLydEl/d
	ypoO9w7MUk6YkYNITp9uuepyHoa4uegzov+DHEieZ2yfia+XDaq8JZOVXQTZdoDzghwr3ui2TOd
	zrPcUYGK7CUe5bBnDNMbCxDTznaQyyPJoD1gNsPJVGpWAD
X-Google-Smtp-Source: AGHT+IEtX+I9FQ2+ix8udtfGhOuyuNBCwwwXU1xqmjkT/Ju5QvlLWNoI8wdNm8UcS3OXYCFX2R8Cgw==
X-Received: by 2002:a05:6808:211d:b0:437:d0a7:e7aa with SMTP id 5614622812f47-43fa395f4c8mr176144b6e.19.1759246482565;
        Tue, 30 Sep 2025 08:34:42 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-43f5123bd55sm2715328b6e.26.2025.09.30.08.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 08:34:42 -0700 (PDT)
Message-ID: <26b9ed81-db18-4876-a8b8-c9595150a311@gmail.com>
Date: Tue, 30 Sep 2025 10:34:40 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Quectel EC21 with internal GSM MUX
To: Christian Meusel <christian.meusel@posteo.de>, ofono@lists.linux.dev
References: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 9/25/25 9:55 AM, Christian Meusel wrote:
> Hello,
> 
> I'm updating an embedded Linux system and reached the point where most things work but I'm still struggling with getting a Quectel EC21 back into operation.
> 
> I updated from Linux 5.12 with oFono 1.34 to Linux 6.1 with oFono 2.18. I also switched from using n_gsm as GSM MUX to oFono's internal MUX because n_gsm does not seem to receive responses from the modem when transitioning from plain AT to GSM MUX-ing on the serial line in Kernel 6.1. I can tell more of that story upon request, but I'm trying to cut the effort for debugging and fixing by using oFono's MUX for the moment.

If the kernel isn't getting responses, highly likely oFono won't either.  Did 
something change at the driver level? Have you tried git bisect?

> 
> For a Quectel M95 this is the end of the story as I can use a cellular data connection again.
> 
> But this is not the case for a Quectel EC21 in the same setup. After adding a delay for the modem to switch into GSM MUX mode, communication stalls after the first message from setup_aux [1] from plugins/quectel.c, I can see the first of the AT commands issued from this function on the wire, an OK response from the modem is received, and then communications stalls. None of the other commands appears on the wire. The other commands got queued according to further instrumentation of g_at_chat_send.
> 
>      Sep 25 14:45:48 target ofonod[4030]: ../../../../../../workspace/sources/ofono/plugins/quectel.c:ate_cb() 0x4f6400
>      Sep 25 14:45:48 target ofonod[4030]: at_chat_send_common: enqueued "AT+CMUX=0,0,5,127,10,3,30,10,2", len is 1
>      Sep 25 14:45:48 target ofonod[4030]: UART: > AT+CMUX=0,0,5,127,10,3,30,10,2\r
>      Sep 25 14:45:48 target ofonod[4030]: UART: < \r\n
>      Sep 25 14:45:48 target ofonod[4030]: UART: < OK\r\n

Not familiar with this hardware.  Is this a USB modem?  How many AT ports does 
it have?

>      Sep 25 14:45:48 target ofonod[4030]: ../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_cb() 0x4f6400
>      Sep 25 14:45:49 target ofonod[4030]: ../../../../../../workspace/sources/ofono/src/modem.c:get_modem_property() modem 0x4f6400 property Mux
>      Sep 25 14:45:49 target ofonod[4030]: ../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_activation_delay_cb() 0x4f6400
>      Sep 25 14:45:49 target ofonod[4030]: ../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_gatmux() 0x4f6400
>      Sep 25 14:45:49 target ofonod[4030]: ../../../../../../workspace/sources/ofono/plugins/quectel.c:create_chat() 0x4f6400
>      Sep 25 14:45:49 target ofonod[4030]: ../../../../../../workspace/sources/ofono/plugins/quectel.c:create_chat() 0x4f6400
>      Sep 25 14:45:49 target ofonod[4030]: ../../../../../../workspace/sources/ofono/plugins/quectel.c:identify_model() 0x4f6400
>      Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common: enqueued "AT+CGMM", len is 1
>      Sep 25 14:45:49 target ofonod[4030]: Aux: > AT+CGMM\r
>      Sep 25 14:45:49 target ofonod[4030]: Aux: < \r\nEC21\r\n\r\nOK\r\n

Looks like it has multiple pre-multiplexed ports.  Why do you need multiplexing 
in this case?  I've also never seen / heard a modem support CMUX when it is 
already pre-multiplexed, but maybe such combinations do exist.

>      Sep 25 14:45:49 target ofonod[4030]: ../../../../../../workspace/sources/ofono/plugins/quectel.c:cgmm_cb() 0x4f6400 ok 1
>      Sep 25 14:45:49 target ofonod[4030]: ../../../../../../workspace/sources/ofono/plugins/quectel.c:cgmm_cb() 0x4f6400 model EC21
>      Sep 25 14:45:49 target ofonod[4030]: ../../../../../../workspace/sources/ofono/plugins/quectel.c:setup_aux() 0x4f6400
>      Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common: enqueued "ATE0; &C0; +CMEE=1", len is 1
>      Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common: enqueued "AT+QURCCFG="urcport","uart1"", len is 2
>      Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common: enqueued "AT+CFUN?", len is 3
>      Sep 25 14:45:49 target ofonod[4030]: Aux: > ATE0; &C0; +CMEE=1\r
>      Sep 25 14:45:49 target ofonod[4030]: Aux: < \r\nOK\r\n
>      Sep 25 14:45:54 target ofonod[4030]: Aux: < \r\nNORMAL POWER DOWN\r\n
>      Sep 25 14:45:54 target ofonod[4030]: Modem: < \r\nPOWERED DOWN\r\n
>      Sep 25 14:45:54 target ofonod[4030]: Aux: < \r\nPOWERED DOWN\r\n
> 
> I'm digging into oFono's codebase for the first time. In setup_aux, I'm seeing g_at_chat_send-ing multiple requests in a row and g_at_chat_send-ing without a callback for the first time. Is this supposed to work or might this be the cause of the current "roadblock" on my way?

You can invoke g_at_chat_send however you like, even one after the other in the 
same function.  The underlying implementation still uses a command queue, so 
commands will be sent only when the modem channel is idle, or after receiving a 
final response from the modem (ERROR, OK, etc)

Regards,
-Denis
