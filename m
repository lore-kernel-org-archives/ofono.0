Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1E107AA
	for <ofono@lists.linux.dev>; Mon, 30 Oct 2023 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIxaAZl3"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5849fc56c62so2831361eaf.3
        for <ofono@lists.linux.dev>; Mon, 30 Oct 2023 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698676496; x=1699281296; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oyIkV6DKU5llxVFFTJ+2kHLaGZJVKBUuim08/YFHtzU=;
        b=QIxaAZl3DsENKx11IOD+wA0uR8TzDocnLaHTe/MK2sl7qbNRplfR4RSt4Q3c9j7Xas
         NRJbDVx5BQASwm8CUBcKek6xujttMG/0OxEii3LhoLGBR7Yh0rsgRx2vj7+RD9AIisXz
         7EPnU1R8gJEaovX3/J7NjUlWTEjLJGXO2olnLsCJ5Mcszo7OeEQF6hxti3k96ZzWFU7d
         Db/BjB9zpUmW8gYt4bUKjgWYDMCNBxs6eV2hQ2rEU356n1oBInzHlNWBkgo+nu443goj
         6C3zzanysD0Rm5r+MXwNBMsuZNUGPMq+/scHKoM4UrKxQhLJNksknWkK8OeXpwJtUIyQ
         oPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676496; x=1699281296;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyIkV6DKU5llxVFFTJ+2kHLaGZJVKBUuim08/YFHtzU=;
        b=iMHJthV6yyzBRkaUIvEBOlu24imCIfGfoGKQ8hwrUBAetGf2JKDvIjQfw03xBzjlr6
         4Pi1QL1AcgoPMgtkBXq2nviRwxmuRvETDp+Ck6jIBd3yY/a7z6ahWXFH8jn8nPFGo/CA
         ZucyXLpj87ZpRAcIKiVcxU1oX+Xb7apy2Xt4Bf/z7vxus8AsJWriveN0zAyKPTHOmErx
         biP4Ct81fPqe6K/iAuYxJN0p4GL5s1g2V4jIO7663nTlS/m4tT9FFReMqwiUT8Vx2Pkb
         f//1iOjlmROMpOq0gfwumwZgifehw0epg2mqz6/kMJMQU0jtlNJC35SgjRguPQ7ZFDVg
         aKQQ==
X-Gm-Message-State: AOJu0YwiZP3leIF4O+XDGqiS2YIXzYGAtFp5+Yv95+iwI2a9OX1SMNLd
	rwWZ9/rJTzSQtj92//vDXKrRfg6s54c=
X-Google-Smtp-Source: AGHT+IFFTKBQTDca6+h4KZ7s7xBN9qNrM72Rk2XDLtwF9rB8zPot/XE2jcexwByU7DhQcBWvJ4hULg==
X-Received: by 2002:a05:6820:1686:b0:581:ec87:edc0 with SMTP id bc6-20020a056820168600b00581ec87edc0mr11676819oob.9.1698676496156;
        Mon, 30 Oct 2023 07:34:56 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n2-20020a4ad622000000b0058151bd7bf5sm1761175oon.11.2023.10.30.07.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:34:55 -0700 (PDT)
Message-ID: <272f2080-8c0a-4016-b6a5-1e95cf3811cc@gmail.com>
Date: Mon, 30 Oct 2023 09:34:54 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Modem: Add Reboot and SwitchOff methods
Content-Language: en-US
To: Lyubimov Maxim <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <043f75988608c0ca35b862dea5c92c1e0c6f8f51.camel@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <043f75988608c0ca35b862dea5c92c1e0c6f8f51.camel@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 10/30/23 02:30, Lyubimov Maxim wrote:
> Hi Denis
> 
> Some modems have special commands to reboot and shutdown, I think it
> would be useful to add support for these commands to the modem
> management interface to be able to reboot or shutdown the modem,
> because some modems cannot be turned off by other means.

Can you elaborate further?  What is the difference between Reboot and Shutdown? 
When would one use one vs the other?

Note that Shutdown should already be covered by Modem.Powered = False.  Drivers 
are free to implement this in a way they best see fit.  See for example the 
really old calypso.c driver for the Neo Freerunner.  It writes to the GPIO port 
to physically shut down the modem.

Regards,
-Denis
