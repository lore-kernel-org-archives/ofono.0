Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D223C6
	for <ofono@lists.linux.dev>; Wed, 29 Nov 2023 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy3uk5dH"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6d84ddd642fso175510a34.0
        for <ofono@lists.linux.dev>; Tue, 28 Nov 2023 19:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701228758; x=1701833558; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIBSAjgXyxqRyOxPbQkxIa4ho+Ga7HlLaN/rATA4rSM=;
        b=Wy3uk5dHoina+nCrhv9jyRZ7AsuZjl0b2Rfrlns9Lihi3rOvWaDo/pt5gzL//3xY7w
         zLSgHjGQZuyWBxHhLVd1yIXpc+CeZwjcFShIGPO+IYOASt1o3JEeqp5LrMwWRX9tjcs7
         YptrX/hfaEpkiR6uCy62JdvYxQicsGTsTT4cpG19I9hdXlOQ4YODZQUMQRl9OoNn5X5Y
         jsHry7iDkZjHzH8etBan2+y2pG1RuQMwzhd3ChvH6+79AfR9V9fiB1tznM1wxPcxYplN
         tTM7GjhZjQHaSMEJDdyRcVh7c3pFG56JTsZE6UZJYB8bgDU0d3z+hcpZZahrFqt1CIoM
         E6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228758; x=1701833558;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIBSAjgXyxqRyOxPbQkxIa4ho+Ga7HlLaN/rATA4rSM=;
        b=I3kHnDOND+taB0GdcF6cn1vVfriIRLt2Qq9DP5hP1UMAvnN9OclB9kmo5omaRU1/CJ
         p8pC4gCBwJUdT4pyG91UWxhSwM6NhQF5gvnYkMIhcsGNgIlNGTijS0U4ZlND+vlQi2c/
         B5SojFp1HW4nGgfKbSPrqMfWNQyEp4hUr4hj0tllLzjOzWppalmej5QkF+sKaMsQFVfo
         cKWw4QDbKdgnYDUiZExcdLb9coMMxtOQp8q3zO3aTx0qNRT6Ky4g9y4Yq6cSLGOLuIIK
         GlxdEOT9KCvcb+JkqCTcAyBsqJibKqL73mmW9Ls3Bz8E2pTMwjcBUP3yte07G7Ae7tSI
         iXjA==
X-Gm-Message-State: AOJu0Yzeuj56JHBebLIBdfJHBskVGZ+y+wkyYbpZ52DHVPRKYXwMNv/0
	l9mhW3vl0ipK0VzuPVb9agA=
X-Google-Smtp-Source: AGHT+IHj2LWQNBH0UOuEHSN/V63yqP3ofRpzR4hn2j3q/43efR8cm5+8gs0LYkXQn43GKri9rH30nA==
X-Received: by 2002:a05:6830:1e16:b0:6d6:4e53:c81a with SMTP id s22-20020a0568301e1600b006d64e53c81amr20552008otr.29.1701228757782;
        Tue, 28 Nov 2023 19:32:37 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h14-20020a056830164e00b006ce2e1a6cb2sm1883297otr.44.2023.11.28.19.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 19:32:37 -0800 (PST)
Message-ID: <94c5ca3e-ec9b-46cc-bb1c-133b7836d551@gmail.com>
Date: Tue, 28 Nov 2023 21:32:36 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] isimodem: parse extra details from REG_STATUS_IND
Content-Language: en-US
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>, ofono@lists.linux.dev
References: <20231125201451.224574-1-absicsz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231125201451.224574-1-absicsz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sicelo,

On 11/25/23 13:50, Sicelo A. Mhlongo wrote:
> Extract additional operator information available in REG_STATUS_IND messages.
> These include mnc, mnc, and different variations of operator name.
> 
> Additionally, in case NET_OPER_NAME_READ_RESP is an error result, which happens
> with some operators, report the extracted information to core instead.
> ---
> Changes in v2:
>   - use l_strlcpy in place of strncpy
>   - replace early `return` statements with `break` in reg_status_ind_cb
>   - check abbrev, fn, and an for NULL
>   - add alt_method label for alternative operator name method in order to
>       resolve compilation issue involving nested ifs
> ---
>   drivers/isimodem/debug.c                |  1 +
>   drivers/isimodem/network-registration.c | 78 ++++++++++++++++++++++++-
>   drivers/isimodem/network.h              |  1 +
>   3 files changed, 77 insertions(+), 3 deletions(-)
> 

I re-flowed the commit description a bit just to make it look nicer in git log. 
Applied, thanks.

Regards,
-Denis

