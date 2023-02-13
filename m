Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA98F7C
	for <ofono@lists.linux.dev>; Mon, 13 Feb 2023 16:46:45 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-16346330067so15858427fac.3
        for <ofono@lists.linux.dev>; Mon, 13 Feb 2023 08:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/yGmwwIxDbYaOKd8QSaIn5nGwiTUlnlkV28h9331fQ=;
        b=ixb26+On+1njegpG6oyDHjcZmxicJQU0uvAgAI4aOLbHdJfxta8uK9+WeeEy8gTtb9
         KypvvoT4pEmwWzPubLHI25UZp4KZf105ewGMSofbZuYLIDHXuRdLRCyqKPwSjKxZmesz
         VTxfWjtbFhXn/ONzJi3b1XZK0v8SQ2iqLNYsi9VlCFq5nP041JeK9Id+nkfP+mEMt/aq
         84xkCFd7fK2+aDZO8g2GbnpzIcXZbWyH0+pTT9UjWvbtkuy9Uq9O1R/Y7VkOVIKR42Ba
         26+OkRl4k9mSztd5HQZGBstHJdbhzDA9EUdEZ05ZDZ0iAo5k5HjoM7pwA+zgUX8NqMYZ
         ALkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/yGmwwIxDbYaOKd8QSaIn5nGwiTUlnlkV28h9331fQ=;
        b=vgGxZnZiA9hJT00gAZR3uCddtCR/1tjFDIBSGfNVKU5VXwP1BFH6FIRrF51MIdC/4y
         Djrggh6EezEMYSGwG2ad/ROSUIZj1hXzqEKVvHlyWtrt1U7Y/9HbfrGfBrgIM6fTLskk
         /2l6G9F7ZraJ0gr48ET6Bi432ZgUo966lfigYpThI1d40tbhhymFbafYcMva0UN9G5XZ
         9CKnZSbgiVOO9D4ECb0iZVORhUmjFH+HIocx1O48e2STWWbjasSegwTZ45Sl5Ib4Y9vR
         w+nTzTKORMhJ3+RrxjE78HSHVWYd6Vj7QRmbdZU722sB7s4dj6k0MAANAVwwX6iDu8MT
         yrmw==
X-Gm-Message-State: AO0yUKXTnzTTZBGS8mO+IY/cUhH80wyMhR/CYZnvo1GSnW3vy41Im+jU
	6+y71H4PS+C2O9EK/hbRdpk=
X-Google-Smtp-Source: AK7set9uHGCUmSIq24w28U6F6rh5Ba1ovdLvkN8Uzp+Dzpe5jkCR1WucQA7LNEq5Ya3AfA2zT4+Wxg==
X-Received: by 2002:a05:6870:41cb:b0:16a:a4d5:4f7f with SMTP id z11-20020a05687041cb00b0016aa4d54f7fmr12247688oac.53.1676306804361;
        Mon, 13 Feb 2023 08:46:44 -0800 (PST)
Received: from [192.168.1.14] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ds41-20020a0568705b2900b0016db8833b2dsm3514922oab.52.2023.02.13.08.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 08:46:43 -0800 (PST)
Message-ID: <3699f2d8-73a6-4f30-df66-af4f395ff54d@gmail.com>
Date: Mon, 13 Feb 2023 10:46:39 -0600
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
To: Alexandru Ardelean <alex@shruggie.ro>, ofono@lists.linux.dev
Cc: patrick.frick@stihl.de, matthias.gruhler@stihl.de,
 mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
References: <20230211181105.7220-1-alex@shruggie.ro>
 <20230211181105.7220-3-alex@shruggie.ro>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230211181105.7220-3-alex@shruggie.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandru,

On 2/11/23 12:11, Alexandru Ardelean wrote:
> While trying to add LTE support to the Quectel BG95-M3 modem, we've run
> into a bit of a chicken-n-egg dilemma.
> 
> While ofono has enumerated (successfully) the GPRS contexts (from the
> modem), we got only one (IP), but it's not active.
> 

How did it do that?

> And trying to activate it, would yield a NotAttached error (via DBus).
> 
> The BG95-M3 modem supports Cat M1/Cat NB2/EGPRS LTE.
> 
> This situation would show up when trying to connect to an operator that
> only has "lte-cat-m1" tech (and nothing else). If it the operator would
> also advertise "gsm" tech, ofono would connect via "gsm".

I'm not really sure how lte-cat-m1 works.  With LTE the requirement was that for 
a successful network registration on LTE, a context had to be 'active'.  This 
can be an IP context or an IMS one, or any type really.  So just by merely being 
registered to LTE indicates that you're "attached".

Now, this whole attached business is really for UMTS and avoiding data roaming. 
With LTE and newer technologies we should really redesign the API.  But that is 
quite a bit of work and oFono is in maintenance-only mode at the moment.

> 
> Now, this could be a particularity of this modem (BG95-M3), in which case
> it may be an idea to add a hook into the quectel plugin/driver to check the
> attached status.
> 
> But for now, it seems that allowing the Attached state to be reported for
> any present GPRS contexts (even non-active), seems to work.

How do you figure that?  gprs->contexts can be populated via provisioning or 
D-Bus API.  So just the presence of these contexts means nothing for the 
attached status.

> 
> For EUTRAN, this behavior is still maintained.
> ---
>   src/gprs.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 

Regards,
-Denis

