Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE806AAB
	for <ofono@lists.linux.dev>; Sun, 29 Oct 2023 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDgEINpE"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2e4107f47so2794529b6e.2
        for <ofono@lists.linux.dev>; Sun, 29 Oct 2023 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698612079; x=1699216879; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BqnS/S3nC0CT5IhRhbyjZ0iSfUIkD0lISye8JRCPzI=;
        b=ZDgEINpEv1NmDkfVY7DJXc6lAQEvTuvbKgx25wO5d3oUxPSLpXpAjxVaUdxofNfHer
         IktYq8/5BNuxMxD3Z+RmqWvpVBlCRuFCNM/HIc1GggD0ce8WDKc8x2Dq0xDvBMP6Rgku
         WNKMk6r6zzsa06/ZZGSGY7wlDlB4QMzFoRbWBmzPkCNvEQl3pgpsKJQKnQPGpcWwU2Wk
         WztEYIrgZjcXHhB/PyDZIUcbKFdnL9kGiyRJ/zajvJhst9jio2c0n+mFmW/Zj1BZbUX5
         lSp1aI2hPvrgbtLn29K7oBywqV9bEuRts4BqMCec1l05IK7ASt0vbgdKguONDa5O5XZ2
         UeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698612079; x=1699216879;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BqnS/S3nC0CT5IhRhbyjZ0iSfUIkD0lISye8JRCPzI=;
        b=AI5LHJ0FB96WMBNAyAdM3LR07ly4TUBk37Ug61h/meLTpB84Qlf4R+DV8jXEe0EKNa
         YJKqPBCLQ1AiDul5Zs3XVgqFO2U+75yDYyYQlyqbL8nM26Nfk9PPECZlhW4uXATRqPKJ
         5WFAVGdr/66tlN9D9L0CKXFvfH1FyB1WVG+Qe3KUM+0Cu9qE6hKu2vxxcYhDSYjLS78K
         boZj/gMIvGQPhgeTmyEOvU0/O7bGVVJS+so3uEtjQmxiL3HUzavBJEBcS2qGMz+TnSDZ
         FClyy1nczeeF9UI8un6FHwNq6iVwqcKeNn98pGSZNeaEk2eH2qtAS8eP9jeZ0TeqVdwS
         YgFw==
X-Gm-Message-State: AOJu0YyqJdJb9T/VM3Xvi+6h5bX2SBa8PsBSa0sVAU52TOhy9gQ3J+7r
	QERg5JnVUclncoVJjypPHBAAebznFDw=
X-Google-Smtp-Source: AGHT+IHR9E2K9rqJIe4FNl6iFgYwiXFFav2cy39ij/4yuSH7sl7m3MyptqV4B5tyEDlDRDGsH7DktQ==
X-Received: by 2002:a05:6808:17a5:b0:3ae:126b:8c2b with SMTP id bg37-20020a05680817a500b003ae126b8c2bmr13353632oib.30.1698612078846;
        Sun, 29 Oct 2023 13:41:18 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 8-20020a544188000000b003af732a2054sm1149983oiy.57.2023.10.29.13.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 13:41:18 -0700 (PDT)
Message-ID: <f4832121-d043-463a-9803-aaaf06f69aad@gmail.com>
Date: Sun, 29 Oct 2023 15:41:16 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] plugins: adding support for the SIMCom A7605E-H
Content-Language: en-US
To: =?UTF-8?B?0JvRjtCx0LjQvNC+0LIg0JzQsNC60YHQuNC8?= <m.lyubimov@aqsi.ru>,
 ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-3-m.lyubimov@aqsi.ru>
 <2d194620-ed30-4763-aced-ca89b450132c@gmail.com>
 <497f810bce97564712e05c2633a45fe244d93481.camel@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <497f810bce97564712e05c2633a45fe244d93481.camel@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Максим,

On 10/27/23 04:01, Любимов Максим wrote:
> 
> 
> On 18/10/2023 в 20:42 -0500, Denis Kenzior wrote:
>> On 10/17/23 05:48, MaxLyubimov wrote:
>>> The udevng plugin has been modified to detect the SIMCom A7605E-H
>>> modem and the simcom_a76xx plugin has been added to work with it
>>> ---
>>>    plugins/simcom_a76xx.c | 323
>>> +++++++++++++++++++++++++++++++++++++++++
>>>    plugins/udevng.c       |  55 +++++++
>>
>> Please see HACKING, 'Submitting patches' section, item 3.
> 
> I deliberately divided the patch into several parts so that they
> affected only one directory, does this patch only affect the plugins
> directory or did I understand something wrong?

After having another look, please ignore my comment.  You're fine.

<snip>

>>> + *  Copyright (C) 2008-2011  Intel Corporation. All rights
>>> reserved.
>>> + *  Copyright (C) 2009  Collabora Ltd. All rights reserved.
>>> + *  Copyright 2018 Purism SPC
>>
>> Copyrights seem suspect?
> 
> I slightly modified the file plugins/sim7100.c, I left the copyright
> unchanged
> 

Ok, fair enough.

>>
>> In fact this looks 95% the same to plugins/simcom7100.c.  Can we
>> unify the two?
> 
> Simcom modems of the SIM7x00 and A76xx series are built on different
> chips, Qualcomm and ASR, respectively, so their functionality is very
> different. I may try to combine these plugins, so the commands are
> generally compatible. But I don’t have a SIM7x00 series modem, so I
> won’t be able to check the correctness of my modification. There is
> also a question about the name of the plugin, SIM7100 is the name of a
> series of modems, as well as A76xx, how to combine them in the name of
> one plugin?
> 

I would rename this driver to simcom.c and try your best to combine the two. 
Even if you somehow break the 7100, then someone with a 7100 can come in and 
complain.  We'll then fix it.  In fact, I think we even had a simcom.c before.

>>
>> Again, this block seems rather similar to what is in
>> setup_simcom.  Just the
>> interface numbers are different.  Please unify the two.
> 
> I divided the code to make it more readable, since setup_sim7x00
> configures qmi, which is not supported in simcom a76xx, and the
> setup_simcom function, as far as I understand, is not used because
> there is no modem driver named simcom. Which of these setup_sim7x00 or
> setup_simcom functions should I use to add a simcom a76xx?

Long term I think I want to get rid of QMI setup in all vendor setup functions. 
Almost always these are the same across all modems in QMI mode, just the 
interface numbers might be slightly different.  Probably just need to create a 
lookup table instead.

So for now, I would just modify the setup_simcom function with the A76xx details.

Regards,
-Denis
