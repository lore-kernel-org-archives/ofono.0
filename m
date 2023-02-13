Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C18F5F
	for <ofono@lists.linux.dev>; Mon, 13 Feb 2023 16:27:42 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id c15so10649978oic.8
        for <ofono@lists.linux.dev>; Mon, 13 Feb 2023 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=di9IH3M28PXEaIlQuktduHXJ0sp3sSClOH/OQSB+3G0=;
        b=Sq/nmpT+SI1YftYUsVcLLkpVamIi/nnlmHCWWAT/fEIkL0bcFG5TuHtJT1yz+k3GEI
         J+cPnCv0uaVv2VP60lqXBgq2MRH8CK3Sk759QBZ4mPiAzf8d1V4oF0cX+3HJwc8MEMyM
         p6VwfgVdi7HIyBol/1PuvNkauzqfg2P2MVSiwgQeZDnsAbtMcnWDx2bZW2DaLFMo1W85
         d5C5TyPsJgYZL1SYOXYRdm1a7oa+uq2tol8bST0rDUan8n68Vfc1EYvK83HoNsl4FCVK
         VeP0h961/PoKv5sJZK/L9S8q4hVUnkigUTxT9pucKw6rcdOUXl8MrUA0KPmm59D5p7y7
         14SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di9IH3M28PXEaIlQuktduHXJ0sp3sSClOH/OQSB+3G0=;
        b=ygOTzKphicPct4Z2QCtIQBQS4GMeuBMYxKrKWL4Yrw14zSIty6RRSKs75K8Bcocqbk
         eGNu/1h7XkfNBSyyKnnlk3k7bhwStiWfNeEj4XyCS3F0fz17zA7h3s4DEfRf1SLYW7XQ
         kxYqde06RuG7ZVHCxDJdsV4oG49GQR//I60ZiBQE35wXYCV7fMiOtpQkFuuiMTt6pl2l
         6TN3GzM5BD2XUP4qCHGQiDxbI9cNllUBR+qKyTTAjVBzzj8BOiX1v38KNKVdbKRQNPsK
         KpADiH4Aljsc6zU4Gx2fSvGAZNFAwVP5PpA6018nIVGbKplMXC4o1AEBBQcVgM1rKZ+c
         1r2Q==
X-Gm-Message-State: AO0yUKU6wpdeSjMEuNSjb6FEWJXgeREi44L6XtyjSU1VDOlJiN2+WZoM
	BV1vTk6RMrZGMLotcGn5ifA=
X-Google-Smtp-Source: AK7set9Ij10E0pqhueZw8MFVOKdgt2wPP+iDde32FiiW5jE4/VPwKmjofLqLpH5UKBhllqbdl7NDMA==
X-Received: by 2002:a05:6808:616:b0:364:862d:29c5 with SMTP id y22-20020a056808061600b00364862d29c5mr11443902oih.26.1676305661370;
        Mon, 13 Feb 2023 08:27:41 -0800 (PST)
Received: from [192.168.1.14] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r63-20020acaf342000000b0037d7c3cfac7sm2471434oih.15.2023.02.13.08.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 08:27:40 -0800 (PST)
Message-ID: <4c80ab10-a640-682c-f397-b48509a204ee@gmail.com>
Date: Mon, 13 Feb 2023 10:27:39 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH 1/5] atmodem: gprs-context: fix ATD99 init for
 modems with no slave channel
Content-Language: en-US
To: Alexandru Ardelean <alex@shruggie.ro>, ofono@lists.linux.dev
Cc: patrick.frick@stihl.de, matthias.gruhler@stihl.de,
 mircea.caprioru@flowkernel.ro, stephanie.altenburg@stihl.de
References: <20230211181105.7220-1-alex@shruggie.ro>
 <20230211181105.7220-2-alex@shruggie.ro>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230211181105.7220-2-alex@shruggie.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandru,

On 2/11/23 12:11, Alexandru Ardelean wrote:
> From: Mircea Caprioru <mircea.caprioru@flowkernel.ro>
> 
> Patch 476fab4ea ("atmodem: Add support for NW DEACT notifications on slave
> channel") has added a check to make sure we have a slave channel before
> registering for "+CGEV:" notifications.
> 
> Patch 8e929df4f ("atmodem: use ATD99 to enter data state when needed") has
> added the ATD99 detection after the slave channel check.
> 
> In our case, when we get a modem with no slave channels, the ATD99
> detection will not get triggered and modems will use the AT+CGDATA="PPP"
> method for connecting to the internet (when ATD99 would be supported).
> 
> This patch moves the check a bit lower in the code and removes the
> early-return, to avoid for any potential future errors.

So how exactly do you detect context deactivations?  The "atmodem" grps-context 
driver is really not setup to work without a second port that is available for 
AT commands.

> ---
>   drivers/atmodem/gprs-context.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
> index f9f3c0ab..efc3fe94 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -449,10 +449,6 @@ static int at_gprs_context_probe(struct ofono_gprs_context *gc,
>   
>   	ofono_gprs_context_set_data(gc, gcd);
>   
> -	chat = g_at_chat_get_slave(gcd->chat);
> -	if (chat == NULL)
> -		return 0;
> -
>   	switch (vendor) {
>   	case OFONO_VENDOR_SIMCOM_SIM900:
>   		gcd->use_atd99 = FALSE;
> @@ -462,7 +458,9 @@ static int at_gprs_context_probe(struct ofono_gprs_context *gc,
>   						at_cgdata_test_cb, gc, NULL);
>   	}
>   
> -	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
> +	chat = g_at_chat_get_slave(gcd->chat);
> +	if (chat != NULL)
> +		g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);

I think this goes over 80 characters / line.

>   
>   	return 0;
>   }

Regards,
-Denis
