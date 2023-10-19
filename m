Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C5A38C
	for <ofono@lists.linux.dev>; Thu, 19 Oct 2023 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCXEIwoB"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b2f507c03cso320414b6e.2
        for <ofono@lists.linux.dev>; Wed, 18 Oct 2023 18:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697679058; x=1698283858; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPv+WrnW/g0nIODkQ9OX5C20TtSgxxC3hHXig6XCIq0=;
        b=PCXEIwoBmdN5HYCHCIJ8DUUSRrRI4qKUgDmmiN/t7zY0iV0MzA1/DHvK9sLiBlJFKJ
         Sfrm/0Skttfz84sdAYZfhowg/yiyynyuv77JJEfi8XM0fcdvuNKWqzFjKbZQS6dCtAUW
         y/on2zpHRRlGHB7PpNgk0n0h/w3nkgLEBhtQg5PXOyDnBe+Gk71L+pBvtRRRxdd1IcSu
         Th7wYJgXDWY8cuvoe4gPx0W8C+EUUAdbPAma121174bJjFzx02pX9jxfjG9uHp/rwd+v
         SBbkubL51rWonGHJjg5PAHwLVpbMNAIgsLD9OJ4D2Csrtpls+JxH6K2UN8EPkNVgGMTj
         d3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697679058; x=1698283858;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPv+WrnW/g0nIODkQ9OX5C20TtSgxxC3hHXig6XCIq0=;
        b=bjtNI38wTgC0yQQgYvgTMNVz9Vpr+MfwCIda/J7LILjmh8g5ZnB3FNuISZu7Q4wrVc
         Bc7vOWV9GSxWUZk8UpiN4XlRW8P9AnZaUTTnEzBq+C0oqaTt+YIZRo85RY6FkqR3HCbV
         a1HwN5gSOVQ/IHsD0EPqyJOvggCjZb+51uNSQDz4PO0LLQBy+HNfcbnZBN/YdytVm/+u
         yODjVRLveZ/R8xWcFB1ZSUAgCOdRw4qjsQeu7QWeDLfl3BFBkHwLFyoircywGtuO2Jc8
         bLb2tSeS0/pVm0pe0Gs7XZD1PwoxFiK+nY8c/o/fgOEnVVXAZUe+uxTen6RWbenY1J6k
         8euQ==
X-Gm-Message-State: AOJu0Yy5dvW+ZAKQ9fu6LitgUU8/kGj7X8Ck3PGhKT7yAWSYrDqhgxGf
	IlvmsFGX0IGB6ZTzYEGUeHAuTkcMtXg=
X-Google-Smtp-Source: AGHT+IFVMtOENrXv5hTZJYtrpNEeBJr1+VXDfuneXMoamOfjEXmu0c4BUv4Ik/wn5DL16aCp1O84ZA==
X-Received: by 2002:a05:6808:3097:b0:3a8:5ff0:6b52 with SMTP id bl23-20020a056808309700b003a85ff06b52mr970390oib.15.1697679058525;
        Wed, 18 Oct 2023 18:30:58 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bk39-20020a0568081a2700b003b2e3e0284fsm646156oib.53.2023.10.18.18.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 18:30:58 -0700 (PDT)
Message-ID: <bf40fdd6-e09a-4151-b5c8-24e5553c147f@gmail.com>
Date: Wed, 18 Oct 2023 20:30:55 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] drivers: adding support for the SIMCom A7605E-H
Content-Language: en-US
To: MaxLyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-2-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231017104902.717947-2-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 10/17/23 05:48, MaxLyubimov wrote:
> The features of the SIMCom A7605E-H modem are taken into account in the atmodem driver
> ---
>   drivers/atmodem/gprs.c               |  59 ++++++-
>   drivers/atmodem/sim.c                |   7 +-
>   drivers/simcommodem/radio-settings.c | 236 +++++++++++++++++++++++++++
>   3 files changed, 298 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/simcommodem/radio-settings.c
> 

This patch fails because you're trying to add a file that already exists 
upstream (radio-settings.c)

Regards,
-Denis

