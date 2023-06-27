Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF4A23
	for <ofono@lists.linux.dev>; Tue, 27 Jun 2023 02:03:30 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1b0138963ffso2829946fac.0
        for <ofono@lists.linux.dev>; Mon, 26 Jun 2023 19:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687831409; x=1690423409;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXRbFfElGOAvJe3wAPC9Cy4xvEvJBBAvd5e2W52sbzQ=;
        b=mLPDF4rYsPz64CWptgLKPDKwHnIPIhLGI/ekvErVFTNudc59kq7F1YBOMYZxtI0hgZ
         vYXEyDgh1TI65Sr8QY82N5F6YPwCfl6UKF+1MBkJa62pAmzLe3Z63xY7KR43bKtWtzBw
         2y2prUOuow/B80I/HBrerMkTIFIAI4f80sLEgmpTKuBt8cSR9K5ti1P5tJYqjZvpZ+qT
         gNrwuNWb0xrfIoYAb/RkhYKE/79BEXR7tqy8lgHY/rCUmZDVz0LoJvcJHrk7H7nvYXQH
         2PEpUmAU/Q2OWFIRlgQErpCbz3YdgNhHU9H8eGgNOi+JucN8rthHkc4SxcBWdYE8mcTT
         Aosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687831409; x=1690423409;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXRbFfElGOAvJe3wAPC9Cy4xvEvJBBAvd5e2W52sbzQ=;
        b=PKppSDJOl8duC9uaf3ecymdAo6/FWVUlciAlsaxm/BVdiBgGuX4YXUqEHXfvQgVTw9
         VQhurJfp+WU+yZpVJPK1UFI/f1OiXhgI2S3PnSv3SSTlJnEXFNRfgbC+DI8TfKox+YU9
         Xqt34xibZ/Hjkc9hIAfDV2HV58oHPfLnXHQX+8q33vrIsLI4boiJboXnaAOQnpfmaYhT
         CBV0pGrfzD6gi+8fPz6ayjffabrIDhBPyao04vFWfSLjhekLnBD7UfBC+Gog0F6IaMBx
         bxlpPUoWQnaMZLIZTqDL29yX8CS1I4xNBVn/VD06AABRVpre39M5VndVDuxpM/JtW9lB
         nCdg==
X-Gm-Message-State: AC+VfDyW4oEls/DlIp6foaeZU8l+O41IokzqUJRkE5Lu53bb3D9CpQnl
	hLllHLcyryXRFwDmu4nOWJFKZtMG+uY=
X-Google-Smtp-Source: ACHHUZ6Ii6mv2ch+LvI5iDg7T4RnXasAPyypMLSvnE5ZCJlV2GCMiq4lA+G3JwifgOSrd8EQ0GgUBA==
X-Received: by 2002:a05:6870:3446:b0:1b0:2a7f:5887 with SMTP id i6-20020a056870344600b001b02a7f5887mr5715741oah.49.1687831409443;
        Mon, 26 Jun 2023 19:03:29 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id pu4-20020a0568709e8400b001a66a48a68asm4372417oab.57.2023.06.26.19.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 19:03:28 -0700 (PDT)
Message-ID: <ac04efc6-4e0b-1d76-4016-eaaf5be80b4e@gmail.com>
Date: Mon, 26 Jun 2023 20:54:19 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Ofono: adding support for the SIMCom A7605E-H
Content-Language: en-US
To: =?UTF-8?B?0JvRjtCx0LjQvNC+0LIg0JzQsNC60YHQuNC8?= <m.lyubimov@aqsi.ru>,
 ofono@lists.linux.dev
References: <2af6ef8c3d5c9437da480e59d4012c81a0f66b6f.camel@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2af6ef8c3d5c9437da480e59d4012c81a0f66b6f.camel@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Максим,

On 6/22/23 04:24, Любимов Максим wrote:
> Hello Denis Kenzior
> 

Sorry for the late reply, was traveling last week.

> I'm working on adding SIMCom A7605E-H (A7602E-H) modem support to
> ofono. By now, I have prepared a version of the modem driver that works
> according to the manufacturer's recommendations. But there is a problem

Great!

> related to the functioning of the PPP connection. After activating the
> context in ofono, the PPP connection is established, and the /dev/ppp0

It is 2023, didn't think I'd hear the term 'PPP' again :)

> device appears on the system. But when I send a ping to an external
> server, after a few replies (1-100), the replies from the server stop
> coming.

So the IPCP is brought up successfully.  Sometimes these devices want DHCP to be 
run on the link or they assume there's nothing on the other side?

> 
> The manufacturer provides instructions for the modem, which describes
> the procedure for setting up a PPP connection through pppd. By
> following this instruction, the connection is stable and ping responses
> are not interrupted.

But hmm, you say pppd works just fine..

> 
> I checked if the previously sent commands to the modem from ofono
> affect the stability of the connection. To do this, I launched ofono,
> in which all the procedures for polling and configuring the modem were
> carried out. The context in ofono was not active. Next, I started pppd
> with a script written according to the manufacturer's recommendations,
> so the context activation was performed using pppd from the place where
> ofono would have done it. After that, the /dev/ppp0 device also
> appeared in the system, but the ping responses from the server come
> steadily. Therefore, we can conclude that the problem lies in the
> implementation of the PPP protocol in ofono, which for some reason is
> incompatible with the SIMCom A7605E-H modem.

You may want to post the pppd script, though I have honestly not used pppd in 
10+ years.

> 
> How would you comment on this situation and in what direction would you
> advise moving to solve this problem?

I would capture the pppd negotiation in PCAP and do the same with oFono (see 
g_at_ppp_set_recording()).  You can also try gatchat/gsmdial which performs most 
of the same basic steps as the atmodem gprs-context driver and can (optionally, 
with a command line argument) capture PCAPs  directly.

Then we can try and compare what might be different between the two.

Regards,
-Denis
