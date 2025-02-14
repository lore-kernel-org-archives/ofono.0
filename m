Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B921C8622
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567287; cv=none; b=i0OwnvdqxjjrgtNOztptkpqYpNZp+SkiDZ29OxMQRV3MJipcyQ4ZK5KaT1dsRJQpKvpZrrh5vvTBM5xYLRDmRII4feoefW+TlfGwTp/54RC7ZUQ9LM4uDy+O1K0kTgYW7gnqpixbG7Wiqyp2jy9CSKnt4fX2TMwzfKjaq/FsexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567287; c=relaxed/simple;
	bh=aa7w9nEDDV+dC/b4Dk4TZv7tGfgvuaDb5sMuITB3M08=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NbE84wL8i08BvHyLcevb+qeUuszW7bMu9gBUYmGhVb/U+0JWu0YvXxkIIf/kQ8fuftiy1+f20bvAIH9wudQ1NrXG8XZyGVCv4C9Mhee3jdYOVOWAibnjh7HfvaJksuoP5PEVFrhawSnGTpK42MyRpSBYNkVBOw8KjXgCT3uRgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpCLjEl6; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpCLjEl6"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-721d213e2aeso738608a34.3
        for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 13:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739567284; x=1740172084; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4DTE1RY/oOG4pUdku4pRefnLMVqpQhLFnG79RW3VtA=;
        b=VpCLjEl6AcCRXdK2PAZ8+MtD1YT3PN7/jLU9kkWFS3yD3j6OA//fEcg5XkaXLjsSTW
         c+TB1qmXsClb6W01P5FzqdH3qyVNl/0J6fKRkyeIczVrWLshAtLzbwc5CwXsUeLiqkEw
         RHnuDozjeC03ytoY3/GILLu4HasiMbLXxZzW/cAW+IPV/x7K5xwnwsGnB/CPOVYCH48g
         ZXPvWFdSGXapjdy3bY//5I6lovJe/Vx1OoinuSI1t7rF4iwkWYXgMVrvDbpm3nEvMRYI
         d4yjVxrJvHmcJvY2Os3rUp+Ut5qpJQoj4ZZWK46TTji820AMr4cMwwQXCUzHyeHz3Opo
         ZW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567284; x=1740172084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4DTE1RY/oOG4pUdku4pRefnLMVqpQhLFnG79RW3VtA=;
        b=InQa02TpQJ7MF9XqTOUSdccrkethxKYcEIG6EZX5H/PBHpE6gbq7byiTI87NuP1ifk
         q8GCviyN3QpHFziil/cJjioEeNb0q67z/SNKf6o7TXRAAGjekQFN+NFIkoKXqTCmYsIS
         ONF8laT+dLZHKDiOc02AdZ6IzW54HfFbV9kUwQ47nWsod7pkMHBDu8uVYKPE4+pJE41l
         jHXCCeW/2UfOyGTMAx2DTe/0qnZ6EqqpKZ4nDu2sNLp9n8OP7epz6c+h2KjisHOCnsei
         CK7f9HSnH91WUIUrUxt9J2vM2OuZ0KgTyjMIQDGgzHvpsLdD+loG/v0TZoQEXnqG7VSz
         qIuw==
X-Forwarded-Encrypted: i=1; AJvYcCUXiCJhCw+vGhrTwYJduya2EGsNE5GUKOzgEeKMGi2OdXa/7cbQzaggKiRTqKoHUdbnZfvMAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPauxARxnu9Iqg1aO6sikwSUHNu4aq22+PxUhBTwz6QVnxi983
	1QgnNmcGIPcP2BTemJLvo30Mn0G+TFHQf4H3nA3XkumZQDPDF1QZ
X-Gm-Gg: ASbGncvBqkENXimzu64ytmCmCNXRjmeGAdUC7XcIozQVC43/uGcN364zxY+y/dkul8k
	Iup/G6Od9Y8GPPRpZ3xPN7QUwDr05nFlOz/RlIiz+z5XseQM6lkgfebAFhyGPR+piX8fpXhsykt
	ikvsBd+pOsJzinZjFiyOWRCf+syY91YY+qJF6l1ZKEuBaRI8qQ2YS3d/vaIwIMBaC72cwudB9X5
	yP/iszhws6cS6yHhu8UnQSJ31v/dF51zekHeyVyuA93bbY0VIuKzhUPIGpSIAJZPIjDU44o+iU1
	YAJVQV9ezfi7HJ9j6EodYlBummWonsi3DbkoHWZNBtBOIKrB2kbACh1z
X-Google-Smtp-Source: AGHT+IE8cDSeij7h3uQvLWUb7t7VUUVZZYfbj6bQ+oxCx2V+mmYmikdr1GHCHcr4K+0NWnqAf8IpEQ==
X-Received: by 2002:a05:6870:a552:b0:29e:37af:c2d7 with SMTP id 586e51a60fabf-2bc99aa832emr353763fac.16.1739567283887;
        Fri, 14 Feb 2025 13:08:03 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2b95a6bf5e4sm1951914fac.33.2025.02.14.13.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 13:08:03 -0800 (PST)
Message-ID: <0fc81066-67e8-4e8a-858d-e92784d72912@gmail.com>
Date: Fri, 14 Feb 2025 15:08:02 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] qmi: Implement QMI service request rate limiting
 in 'can_write_data'.
To: Grant Erickson <gerickson@nuovations.com>, ofono@lists.linux.dev
References: <cover.1739553712.git.gerickson@nuovations.com>
 <35556cf3af8ce161ab6e178bdf4615ee94407bc6.1739553712.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <35556cf3af8ce161ab6e178bdf4615ee94407bc6.1739553712.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 2/14/25 11:22 AM, Grant Erickson wrote:
> Determine if we need to rate-limit QMI services requests to a
> transport-specific minimum request period. If so, return true so that
> the queue can be retried again later.
> 
> Adds the following data members to 'qmi_transport':
> 
>    * Minimum request period
>      - The minimum period, in microseconds, for back-to-back QMI
>        service requests.
> 
>    * Last request time
>      - Time, in microseconds, when the last QMI service request was
>        sent.
> 
> to support the implementation.
> ---
>   drivers/qmimodem/qmi.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 

The CI doesn't like this version either:

Alpine (musl) gcc optimized
===========================
Configure: PASS
Build: FAIL
     drivers/qmimodem/qmi.c: In function 'can_write_data':
     drivers/qmimodem/qmi.c:701:50: error: 'now' may be used uninitialized 
[-Werror=maybe-uninitialized]
       701 |                 transport->last_req_sent_time_us = now;
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
