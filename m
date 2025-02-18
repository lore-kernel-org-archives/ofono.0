Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D52309B5
	for <ofono@lists.linux.dev>; Tue, 18 Feb 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892572; cv=none; b=AKCnz/zcyoUkky6yUye5m4NUmhl1BcxlWG01I/anasfR6T5vjLQKkzLM2O5Ixa/OIQ+cfLUybHnEHpxUUL+mwYpPUZSk0NjSGO3z+Vvm5mbgWrN258al6uFmbkEiV5jeowJ9v/c72QeOpeELLdOdRr07eGbsqCG83WdQRYQ7e28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892572; c=relaxed/simple;
	bh=+IXt63pEPMVWiC3ZOAOQQdT/cbIb2ev4Pvd0vzskoeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tokktugTgQr3aw0cuvNbA/4d+45zFHmd8LJjiKQS6fBp50qMCYMqvm/lPJ8L5YRAiERPJ7km3dnqTNZDbWTlkBprOiwvjLDXEu72D+1iPs8PtSjajAbmuo3w0yOf1nVomMWuIpJw8GshRs9Im0Xy4zqP2zhn8XfnRPEs9TLjI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUf7SL8J; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUf7SL8J"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72726025fa5so594605a34.0
        for <ofono@lists.linux.dev>; Tue, 18 Feb 2025 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739892569; x=1740497369; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wqKfQGw8N70Xt8/NwBC4XgP6V9b9WsYTUAZFcWfxIyg=;
        b=GUf7SL8JKZ6k+5sGIHwPkE8bRD4dBq7CNJxwQ3T7Wq5Vzx3ZfJjW0mssN7qxiA1FDA
         6OepUSGMUzEWYJvisZ4G44eHg52NePnFb8hvVCAco8XA7bHvyoLE4flSlwFTk70FdOn+
         SaTJibatzXCNLxrNqVvXscLqwxwwqr9OkSbZzMoLfmTIrcU+NcoWaw2tycLf+93qGUnU
         meIx8+11x+4Q9R4s9yMSD1hOXxI2SQ4MD+6WVGaAZ0vDd2K6OY04xRzyqzzbK7tog68T
         HnaJFZaQRLhof2Nee7S1hajAuSxAH425Fe/E15UdY64SEYMW1xJmVFVAdv/Oh54xhu6p
         hBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892569; x=1740497369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqKfQGw8N70Xt8/NwBC4XgP6V9b9WsYTUAZFcWfxIyg=;
        b=dxaiMt72zHcMT2386j76/qjAWQ8vPqCdcnlcNabzultpBBRIZsI3E5U1I8x8gWEnLQ
         LjHNrrfqdL3qbXPv5//cLQFrm4tAGNVhAzHhiasU9nhVnc5tEmBPd7Mu5LESamT2j0Zn
         4zfSC2b+TR8q2gLhUmWI9J3g0wXvwQ30L2o6pGAc4CDaAvQM2K3EeXPtPLXTCPdTgCxT
         onT56znjFRmxQyXGFy2HZKNHZNU80Xs0f+xPAWoPDlAYTNN5GcgOaZuqkhMhpisHqjSU
         7DWv5k6UjbmGNQGsTBCkqEpmItODv96TSSQ6RLaRyObfllj82nbNPbmym3/To/Mk1mwV
         VhSA==
X-Forwarded-Encrypted: i=1; AJvYcCVoneOWa8KZ1qigM/slnGtzgyjpOM+eW+zvIUO7rVFmm1jhCyoDi3+1xvC3i8/LSdpFAzOlXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc6tM1wGxwjV7ctNufqIiya6Hoyrf5W5UbjzzyooSKz4r1ve4B
	Vx/EujspqjBPiCJGmfbt0VpuMprVTqrAEuUcouLtl0na8ItWUtKf
X-Gm-Gg: ASbGncvVPg3zdR6UtVcdTWswZd/rBXoOqjKF3bNLJkakm38rVxjgKP4t7LuN6OMHNCE
	IdXNtKm/QyEF0XVdKXJtDV0M0gddREIB5j5uxCnMwoCqMjEv40GGyvOcIIWContd2iEhSDekPCN
	/odpvUtPV+/J1NwDvia1NUWqdXp745W2vK1pIJt0To8T5v9Y3Jl20fmDSDMF17q1+ul/xetJIOi
	Zd2fCNvIvBKtuj4ttXxYCGeqZt2HJ0lR9ilpvvNY4CVNbusx2rfUhsizZ7mOKseBBGi9qv+gDrt
	wkfawMh0X5NJvIPrNuwUg6oP9eXLUQ3fgrAzpn/2qSsJmJZ96wBPFWO7
X-Google-Smtp-Source: AGHT+IEeecH4B0T63yDjhNrnRl6cgZZhuOniFxefChgRVq5KhBrl1zVdBOTZXA/86QXaHeSWS6CG4Q==
X-Received: by 2002:a05:6808:4490:b0:3f4:ad6:519e with SMTP id 5614622812f47-3f40ad6532cmr1706053b6e.31.1739892569591;
        Tue, 18 Feb 2025 07:29:29 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3f40920efcfsm432932b6e.2.2025.02.18.07.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:29:29 -0800 (PST)
Message-ID: <55b93069-f7a4-4cbd-8fc5-16160addeb01@gmail.com>
Date: Tue, 18 Feb 2025 09:29:27 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add QMI Device Service Request Rate-limit Option
To: Grant Erickson <gerickson@nuovations.com>, ofono@lists.linux.dev
References: <cover.1739822462.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <cover.1739822462.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 2/17/25 2:01 PM, Grant Erickson wrote:
> Certain modems, among them the Quectel Wireless Solutions Co.,
> Ltd. (2c7c) BG96 CAT-M1/NB-IoT modem (0296), have a firmware issue
> where they can lock up and hang (not responding to subsequent
> commands) due to high QMI service request arrival rates.
> 
> QMI service request rate limiting is achieved by:
> 
> 1. Adding a new, optional options structure to qmi_qmux_device_new
>     that has its rate-limit "quirk" and minimum request period fields
>     set when the modem "RequestThrottleTimeUs" integer property is set.
> 
> 2. Adding logic to the QMI driver that, when a minimum request period
>     is set, limits the QMI service request rate accordingly.
> 
> (1) and (2) are used by the udevng and gobi plugins such that when the
> modem vendor and model match 2c7c/0296, then the option to rate limit
> QMI service requests is set to no more than one every 2,000 us.
> 
> Grant Erickson (7):
>    qmi: Added enumeration for device quirk flags.
>    qmi: Added structure for device options.
>    qmi: Added device options parameter to 'qmi_qmux_device_new'.
>    qmi: Implement QMI service request rate limiting in 'can_write_data'.
>    qmi: Handle request rate limit option in 'qmi_qmux_device_new'.
>    udevng: Set the QMI minimum service request period for Quectel BG96
>      modems.
>    gobi: Pass QMI qmux device options to 'qmi_qmux_device_new'.
> 
>   drivers/qmimodem/qmi.c | 51 +++++++++++++++++++++++++++++++++++++++++-
>   drivers/qmimodem/qmi.h | 40 ++++++++++++++++++++++++++++++++-
>   plugins/gobi.c         | 22 +++++++++++++++++-
>   plugins/udevng.c       | 14 ++++++++++++
>   4 files changed, 124 insertions(+), 3 deletions(-)
> 

Alpine (musl) gcc debug
=======================
Configure: PASS
Build: FAIL
     drivers/qmimodem/qmi.c: In function 'can_write_data':
     drivers/qmimodem/qmi.c:701:1: error: unknown option after '#pragma GCC 
diagnostic' kind [-Werror=pragmas]
       701 | _Pragma("GCC diagnostic ignored \"-Wconditional-uninitialized\"")
           | ^~~~~~~
     drivers/qmimodem/qmi.c:701:1: note: did you mean '-Wno-uninitialized'?
     cc1: all warnings being treated as errors
     make[1]: *** [Makefile:4090: drivers/qmimodem/qmi.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2405: all] Error 2

Fedora (glibc) clang debug+sanitizers
=====================================
Configure: PASS
Build: PASS
Unit: PASS
Distcheck: PASS

Alpine (musl) gcc optimized
===========================
Configure: PASS
Build: FAIL
     drivers/qmimodem/qmi.c: In function 'can_write_data':
     drivers/qmimodem/qmi.c:701:1: error: unknown option after '#pragma GCC 
diagnostic' kind [-Werror=pragmas]
       701 | _Pragma("GCC diagnostic ignored \"-Wconditional-uninitialized\"")
           | ^~~~~~~
     drivers/qmimodem/qmi.c:701:1: note: did you mean '-Wno-uninitialized'?
     drivers/qmimodem/qmi.c:703:50: error: 'now' may be used uninitialized 
[-Werror=maybe-uninitialized]
       703 |                 transport->last_req_sent_time_us = now;
           |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
     drivers/qmimodem/qmi.c:669:18: note: 'now' was declared here
       669 |         uint64_t now;
           |                  ^~~
     cc1: all warnings being treated as errors
     make[1]: *** [Makefile:4090: drivers/qmimodem/qmi.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2405: all] Error 2

Regards,
-Denis
