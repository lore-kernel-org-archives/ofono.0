Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A83746A
	for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 15:23:03 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1718b32f589so1068707fac.5
        for <ofono@lists.linux.dev>; Fri, 17 Feb 2023 07:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XKnCTJNrSFXHn/do+vK55nQaPdMWn8srNfjDq5ipDA=;
        b=fOmq0p6ks8yREDGbblvJhMFCotKkw3dFbo/4nstXmTbYGKsgMR/N0MyfsBneoEHY4G
         MISQXgjCMPLOTO+VvuI+YYg16QbXG5XQ9UKHPD98U2cARdukhUv761/KK0TZ7FglhmtN
         LsEWKk19ysYcj3EV67aLmQZXuLKK3WLKQSsHiNYkGVKoQPd+EuUM7TqxuhSzbMirvHoY
         JQOXGvhguGRSS7h7WFM4xpckOZgm27CDygaiVi9s6l7jgK0HrFhg+6wihEtx405eQGHJ
         glGVpjCqWvZjI5Wo4UKwY89HSMLBJGVPqxTpaHDfYcvCIlTIOk8h4H0zCbBsjW71Nphy
         ER5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XKnCTJNrSFXHn/do+vK55nQaPdMWn8srNfjDq5ipDA=;
        b=UwLSVswIzRy+p4Ql0+gJdq9vQDRlx9uSqISBN5vinDa6NYaVhmbcI7f4aRY5crJUQS
         Ca+a3Qv+WhVVgm4sI6CwNaTy0e3vY3WcZ4yGcVWvbl1AN2o1W23bUPVBFRwaP3+hI28q
         BTS+fv/wyPXnBCPOirmjqEiitaFzxC/mfV8VTetrwLN60EFul0ssCdkLV10CuIIlXzwa
         MD76pBXI5R2i9lJUgHJ4QchDzpUDrtNyUi6sCbHyOp7whd9VQuq+pHSmHL+ZuhR6lVxk
         NF/M0o6KpPi0COAStMNo2VEPOLA2cY6J8rtgPSuxidx2/OMbwT1uOwqAM0QxdbbXykpL
         EpmA==
X-Gm-Message-State: AO0yUKVC4VLo7/RXlxXTYdPxhVxCwQUvRhU7AHlf8Fyw1TZ8uz6TxpUx
	xWM/nLWKRe6jM0LRbC7FC6eE+VEx9g+HNw==
X-Google-Smtp-Source: AK7set/Imu28HTPHI9+cTD3UUKUnMvTQVdzjfULuNg1nlbuNA6XgBH2oJnZskeDI0oxsO7EmN3B0VA==
X-Received: by 2002:a05:6870:5628:b0:16d:c495:9608 with SMTP id m40-20020a056870562800b0016dc4959608mr976906oao.8.1676647382955;
        Fri, 17 Feb 2023 07:23:02 -0800 (PST)
Received: from [192.168.1.12] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g23-20020a4a7557000000b0052008587b10sm1040594oof.44.2023.02.17.07.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 07:23:02 -0800 (PST)
Message-ID: <0f136da4-e5eb-95cb-729f-f19b2db067cf@gmail.com>
Date: Fri, 17 Feb 2023 09:22:59 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH 2/5] gprs: rework have_active_contexts() to check
 for non-active contexts
Content-Language: en-US
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: ofono@lists.linux.dev, patrick.frick@stihl.de, matthias.gruhler@stihl.de,
 mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
References: <20230211181105.7220-1-alex@shruggie.ro>
 <20230211181105.7220-3-alex@shruggie.ro>
 <3699f2d8-73a6-4f30-df66-af4f395ff54d@gmail.com>
 <CAH3L5QoTe__tq9geKgUWYdXSO=5YF+7ysAHiKCd-Pn6Pvr2o+Q@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAH3L5QoTe__tq9geKgUWYdXSO=5YF+7ysAHiKCd-Pn6Pvr2o+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandru,

On 2/17/23 09:03, Alexandru Ardelean wrote:
> On Mon, Feb 13, 2023 at 6:46 PM Denis Kenzior <denkenz@gmail.com> wrote:
>>
>> Hi Alexandru,
>>
>> On 2/11/23 12:11, Alexandru Ardelean wrote:
>>> While trying to add LTE support to the Quectel BG95-M3 modem, we've run
>>> into a bit of a chicken-n-egg dilemma.
>>>
>>> While ofono has enumerated (successfully) the GPRS contexts (from the
>>> modem), we got only one (IP), but it's not active.
>>>
>>
>> How did it do that?
> 
> So, we get the context via the AT+CGDCONT=? command
> 
> Feb 17 16:43:04 imow1 ofonod[31380]: Aux: > AT+CGDCONT=?\r
> Feb 17 16:43:04 imow1 ofonod[31380]: Aux: < \r\n+CGDCONT:
> (1-15),"IP",,,(0-2),(0-4),(0)\r\n+CGDCONT:
> (1-15),"PPP",,,(0-2),(0-4),(0)\r\n+CGDCONT:
> (1-15),"IPV6",,,(0-2),(0-4),(0)\r\n+CGDCONT:
> (1-15),"IPV4V6",,,(0-2),(0-4),(0)\r\n+CGDCONT:
> (1-15),"Non-IP",,,(0-2),(0-4),(0)\r\n\r\nOK\r\n
> 

That's a capability check.  It just lists the context types supported by this 
modem, not the actual context definitions themselves.  Querying of the defined 
contexts would in theory be performed via 'AT+CGDCONT?'.  But oFono doesn't do 
this, it grabs the context settings via provisioning or the D-Bus API.

> I'll be honest, I did not check that this is parsed correctly by
> ofono. I just assumed that this is correct.
> 
> When querying via DBus for the contexts
> 
> dbus-send --system --dest=org.ofono --type=method_call
> --reply-timeout=120000 --print-reply /quectel_0
> org.ofono.ConnectionManager.GetContexts
> 
> The output is
> 
> method return time=1676645265.639429 sender=:1.68 -> destination=:1.73
> serial=101 reply_serial=2
>     array [
>        struct {
>           object path "/quectel_0/context1"
>           array [
>              dict entry(
>                 string "Name"
>                 variant                   string "Internet"
>              )
>              dict entry(
>                 string "Active"
>                 variant                   boolean false
>              )
>              dict entry(
>                 string "Type"
>                 variant                   string "internet"
>              )
>              dict entry(
>                 string "Protocol"
>                 variant                   string "ip"
>              )
>              dict entry(
>                 string "AccessPointName"
>                 variant                   string "stihliaxx.tma.iot"
>              )
>              dict entry(
>                 string "Username"
>                 variant                   string ""
>              )
>              dict entry(
>                 string "Password"
>                 variant                   string ""
>              )
>              dict entry(
>                 string "AuthenticationMethod"
>                 variant                   string "chap"
>              )
>              dict entry(
>                 string "Settings"
>                 variant                   array [
>                    ]
>              )
>              dict entry(
>                 string "IPv6.Settings"
>                 variant                   array [
>                    ]
>              )
>           ]
>        }
>     ]
> 
> 

That looks like it is coming from a provisioning database.

Regards,
-Denis
