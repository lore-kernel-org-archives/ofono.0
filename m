Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BDD299
	for <ofono@lists.linux.dev>; Sun, 29 Oct 2023 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBH2UUlP"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce29d1db6eso2395760a34.1
        for <ofono@lists.linux.dev>; Sun, 29 Oct 2023 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698613150; x=1699217950; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0zN6Bbh7HcbWz+CFnIAdo5ls9AWJjjP4kVR5Turat8=;
        b=IBH2UUlP1T+6djxlyWkudVE9trTfEceEfTRkSisQrCPpoLnVOGc9yJks+99mfk9ofJ
         2i0xvnMxOccKp9lcADzwsxPXqFEglbQ9cF/Bunohp9MQJEkSg+s/ysR0YndB5+CHkU5a
         8jZljAMdU7+qp7B9TsKCnEwz+WE8Vfum63P+Qv7vyMCZnTy6/uBQZJMguC9aEnaVa7Fo
         l7tJyGVaMOt+/idgP4bWPhTS9dgiIwKgrInJDT/FOTHbMr7fDKrcxEkg9syKQ77cLfgA
         Qx3Sby7aZvttKHHN9yJMU94prBuSd1nVgZrb5qFBG/0gmCGJPjrH0DnC7wXbtRNOXaBz
         I2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698613150; x=1699217950;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0zN6Bbh7HcbWz+CFnIAdo5ls9AWJjjP4kVR5Turat8=;
        b=eTsxMTz6uO7rgKzXWyr4YBqY1X46LTwlgLuCTobAkhdhULGGsG5F6BMLT3xoIPiQVg
         6gOa6ePjf7TAEAyvEwAL7efMhSfHYYlY2qiXxO+fvLlZqrwCQVnWurnTIaNaD0ZqAui9
         a+WtITyX4IIluz0MFmslvJG3fyxdv3kTZkOM4jww+MpxUdhX5WIcmDCBKlzKNXJSrLjn
         ntuX/9vABWdiolYvO4ZmnMe9sADntlN3SX4FZYWR72gMccUIXA5WRsCvUFzxjT7LwCMl
         4xry09y2L8ewW16Z4YSvt+x24dKaqb6xx3wS1h3JcEi9qcO3W0n+gQDrH4Qhgvxq7AUT
         FzTw==
X-Gm-Message-State: AOJu0YyUuO930Z4+IYDss7IEbwjM2FwRMEgz7BcXV8WGefFxALMnfRt2
	+pQStSamXc5Fa2W0a5/WXeoM/Ob5pW8=
X-Google-Smtp-Source: AGHT+IGxuhP438JD10/av2Rc+DdMrGqQLkiZSjzEaboVueEGzpcJdpqsLlLa31/F2+3pHkbV4ttTwQ==
X-Received: by 2002:a05:6808:f03:b0:3b2:f344:3a41 with SMTP id m3-20020a0568080f0300b003b2f3443a41mr4889329oiw.2.1698613150722;
        Sun, 29 Oct 2023 13:59:10 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f7-20020a05680814c700b003af6eeed9b6sm1151934oiw.27.2023.10.29.13.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 13:59:10 -0700 (PDT)
Message-ID: <d78baea0-813c-414d-bf8d-d9a06fbdb5fa@gmail.com>
Date: Sun, 29 Oct 2023 15:59:08 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] gatchat: added command completion by timeout
Content-Language: en-US
To: =?UTF-8?B?0JvRjtCx0LjQvNC+0LIg0JzQsNC60YHQuNC8?= <m.lyubimov@aqsi.ru>,
 ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-14-m.lyubimov@aqsi.ru>
 <4a003c7d-4cee-4111-8bed-2bb51e5f510b@gmail.com>
 <d9591456ec4294c216445b6b0b73d2b54d94c2e0.camel@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <d9591456ec4294c216445b6b0b73d2b54d94c2e0.camel@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Максим,

On 10/27/23 04:45, Любимов Максим wrote:
> On 18/10/2023 в 21:21 -0500, Denis Kenzior wrote:
>> So I think you're going to need to give a bit more context for how
>> this is
>> expected to work.  There are commands (on older modems) that can take
>> minutes to
>> complete.  This is why multiplexers were invented.  Now this is
>> probably quite
>> rare, but I imagine it can still happen.
> 
> This functionality was added because some modems sometimes do not
> respond to the command. Therefore, there is an endless wait for a
> response and blocking of other functions with a message that the action

Ok, but which modems?  Do you have an OFONO_AT_DEBUG log trace you can share?

Anyhow, at the very least you need to make this an opt-in feature.  As I pointed 
out, opting in *all* modem drivers into this functionality will break some of them.

> is still in progress. It was experimentally verified that if the
> command is repeated, the modem can immediately respond to it and there
> will be no blocking. What do you suggest to do if the modem does not
> respond to the command either after a minute, or after an hour, never?

Call the vendor and have them fix their firmware? :)  But seriously, how many 
commands are we talking about?  If it is one, then handle it specifically for 
that command.  If it is a dozen, create a utility function.

I'm not convinced adding this functionality directly to GAtChat is the right 
approach.  There is no such thing as 'AT command timeout' in V.250 specification 
or any other standard.  AT command cancellation as a concept exists, but it only 
works sometimes and only for some commands, and isn't what you're doing here 
from what I can tell.

What you're describing is vendor specific behavior and has to be treated as such.

> 
>> Also, what happens if the command times out?  You generate a
>> synthetic CME 100
>> error, but what then?
> 
> The function that sent the command must take action based on its
> operating logic, for example, repeat the command, or fail.
> 

Okay, so where is this code?

Regards,
-Denis
