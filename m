Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2178F5F
	for <ofono@lists.linux.dev>; Mon, 13 Feb 2023 16:20:51 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-15fe106c7c7so15714605fac.8
        for <ofono@lists.linux.dev>; Mon, 13 Feb 2023 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9gkSLEPHRh3dEg/xFuMKHrwFvimFbindWCMasC3pxI=;
        b=S9Vo0WbavGFD2B4qI4CpSLENmiqFzb9BAgOfQhwQHUdmC+lTgwjZU/n0dktEE/Iu9B
         VU71dto4QFg6GuMxqippm9Bnrht0098FILE3G1Hs+ao971abH/BcgQyPFP8FKfaO1cuD
         wSCltf2Nj363O2HEv+ED50RVTT9GD//x57yda0qCpu0FXbtox9IdBdm7NHT2DZezmYD2
         lCALNrRI3g1zwo88qmXq8dlx6fRRrEzM283c8GSI1z84PKFl9sBMjpc7SfSJYq2kJ1vp
         kUe5H+vSnGiOrlElKPst3DSPJp9XnBBMemr7jgT7NqJ0cMf7cUZ0AGS6TBS0h5kvFyox
         1Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9gkSLEPHRh3dEg/xFuMKHrwFvimFbindWCMasC3pxI=;
        b=vxNbHO48VHubw4nCmjbQhxRJ7GJeMkLRRM7SA+n3V8+8v+EPrS7SScjXLujMZiFUci
         NZO8JisUJMEr3Y3mP/qLkPHKVj9hTmA5EQPAM4OIGmQpTqxMt4wqu+YR8RUAahgkZROP
         9TzOUOq1cXsEKOE7/8Y61un6nkw6eunQKiyzI0zVIdY3/Vrj0Vp7D+eML95hp4CbtTi6
         waLS/unfAok4ia1S5O4Wz4a6KVr74QvpK3xf0aNWg8avEqskpefBUrXNpHy3mfFqTb0R
         u31Ki52agw5r3mTys5U9wJ/vYUU6R8QH/AS9ueomAHY1V9k8xCeL6iV2US+9i1GCwTCO
         De/g==
X-Gm-Message-State: AO0yUKW+ji9RGT6ivYAMjycAUwmBiZ7FQHCmd9+u2cNunBJIBsYcpUjH
	QJ73uH0w7iFl21PUFU4BEicjYnCMHDd4PQ==
X-Google-Smtp-Source: AK7set9kX5+EzkO0EKlOJ5YvPKxrazVwwJaWnRqc8JZXdPik7WwItVOuGQNtNXz/zSd/KZ7LYpBnwA==
X-Received: by 2002:a05:6870:2115:b0:163:4a10:827e with SMTP id f21-20020a056870211500b001634a10827emr18181639oae.16.1676305250951;
        Mon, 13 Feb 2023 08:20:50 -0800 (PST)
Received: from [192.168.1.14] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b7-20020a056870918700b0016b0369f08fsm3967191oaf.15.2023.02.13.08.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 08:20:50 -0800 (PST)
Message-ID: <31bee957-b337-2ae5-687a-217e3c25b437@gmail.com>
Date: Mon, 13 Feb 2023 10:20:47 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] docs: update ofono mailing list
Content-Language: en-US
To: Alexandru Ardelean <alex@shruggie.ro>, ofono@lists.linux.dev
References: <20230211181850.8597-1-alex@shruggie.ro>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230211181850.8597-1-alex@shruggie.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandru,

On 2/11/23 12:18, Alexandru Ardelean wrote:
> I've re-sent some patches to 'ofono@lists.linux.dev' and it worked.
> Initially, my patches/emails got denied by the email server (when sending
> to ofono@ofono.org).
> 
> Checking 'https://lore.kernel.org/ofono/' it seems that my patches went
> through, so it looks like the docs could use with an update.
> 
> The websites are not changed, as http://ofono.org redirects to
>     https://git.kernel.org/pub/scm/network/ofono/ofono.git
> ---
>   HACKING             | 2 +-
>   README              | 2 +-
>   doc/ofono-paper.txt | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

