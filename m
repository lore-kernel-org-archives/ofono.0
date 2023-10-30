Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E65179BA
	for <ofono@lists.linux.dev>; Mon, 30 Oct 2023 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAV1uQex"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1efa01323b4so1386447fac.3
        for <ofono@lists.linux.dev>; Mon, 30 Oct 2023 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698676202; x=1699281002; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMbuscUa93lqigo5m4/xk7UFuhkta4J+gfrnE3mCjrc=;
        b=IAV1uQex/fARB6FnzFWEWA8tKzBaep0+6FT3L1XpP/v24BO+Y2m4WXLGvJwrwZfjyD
         T/lgCjx5lnZ9O4tJx98qlVBeQoH4PXSHT3XQxqkhDqKVQb38NH6Bz5O2YL30hB6YwzG0
         cY366PaXiQlT4LEguFNQAYU+WYMFy+gPdNEO5KOdWBCAQf/IF12C8W3SjluNQ8W0xtfn
         /ump70mKInLEC7nOf0f1KVM4f8wzeyDbvIpMTJm3UUqqNSQ/AYz6V2LIZFEdyPg2To9y
         EOpgk7d8VjCxT8y09ZxGeL+XcFT2g0XlPSckPonGf2Nw9jfSfaUlt1hXyf5hymGcAJMK
         s6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676202; x=1699281002;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMbuscUa93lqigo5m4/xk7UFuhkta4J+gfrnE3mCjrc=;
        b=H+hUdkH2+8fj0pKUEdJcmSWVn1Vq091oLSEIZYJHpBesW6fW0q51YozeNZkSkpTi1m
         J19dwT20oc7Bo5a/QfI/J+2NE3959opi6IcXqs9+L9Gk3awE44fk14CxttY1KZO1VPuT
         s1AHnjdOH/l968+UqEU9FREEB0uYZG8uMl7o5UMgqekSGuf/7K++zJwnkybxxrwyPTHl
         6MnLKrc1dMkbizHbKlFR7uSd1er5xRK8BZQrGPDVJOOeLmeVmuXvguV3e6Thj4lsc441
         1CGXnzkLxZMC1aJIGVKK2cci3jxUGGE/PTubL4Df5gPOayFwExrO1sdPYkLZOBRzWtZs
         Jttg==
X-Gm-Message-State: AOJu0YxZakkcsnefM+mahPcwaspGJ4er7LM+1qwf0I575iiw09456ac8
	51t27OTBG63hH15riUGwxT+rMoycnzg=
X-Google-Smtp-Source: AGHT+IEstCBYCo73kYh5wLu73a2PQ4E7gLXIb64VJGRT+FSV6//xb4jDYu3hFL3EINdbha04ItZ+5A==
X-Received: by 2002:a05:6871:5c47:b0:1e9:e76c:2706 with SMTP id os7-20020a0568715c4700b001e9e76c2706mr13933814oac.52.1698676201995;
        Mon, 30 Oct 2023 07:30:01 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id jq1-20020a05687c30c100b001c02f12abd0sm1598863oac.38.2023.10.30.07.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:30:01 -0700 (PDT)
Message-ID: <a96bcf59-705b-45cd-b734-72c5378eb482@gmail.com>
Date: Mon, 30 Oct 2023 09:29:59 -0500
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
 <d78baea0-813c-414d-bf8d-d9a06fbdb5fa@gmail.com>
 <681f57cc7909dcbd58b6fa273d11cd96904b5eb5.camel@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <681f57cc7909dcbd58b6fa273d11cd96904b5eb5.camel@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Максим,

>>
>> Ok, but which modems?  Do you have an OFONO_AT_DEBUG log trace you
>> can share?
> 
> Similar behavior is observed on simcom modems. There are no logs yet,
> but it clearly shows that there is no response to the command.

A log would be useful to help me understand what is happening.

> 
>> Anyhow, at the very least you need to make this an opt-in
>> feature.  As I pointed
>> out, opting in *all* modem drivers into this functionality will break
>> some of them.
> 
> I can suggest adding a property to the modem driver data that will
> enable this function for it.

Sure, that's fine.

> 
> Multiple commands that are sent over an interface shared with a PPP
> connection. I have a suspicion that when switching from data
> transmission to command processing, the modem does not process AT
> commands through this interface. But the time frame for this switch is
> not clear.

Most devices come setup with 2-3 pre-multiplexed AT command ports.  Most modem 
drivers without a high-speed network interface follow the following pattern:
- One AT command port for most AT commands, always active (Modem)
- One AT command port for PPP.  This port is used to send CGDCONT/CGDATA 
commands and is suspended for the duration of the PPP session (Data)

Are you saying that when the PPP session is ended (NO CARRIER sent?) then 
subsequent commands sent to the Data port time out?  Or what is happening?

>> What you're describing is vendor specific behavior and has to be
>> treated as such.
> 
> How to properly handle a lack of response to a command? Should I add a
> property to the modem driver to enable this feature in GAtChat? Or
> should we separately process the lack of response for those commands
> for which such modem behavior was observed?

I'd like to better understand the problem before offering solutions.  What you 
outline above are all possible strategies.

Regards,
-Denis
