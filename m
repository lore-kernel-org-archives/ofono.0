Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199D38C
	for <ofono@lists.linux.dev>; Thu, 19 Oct 2023 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2dcUlim"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e993765c1bso4733859fac.3
        for <ofono@lists.linux.dev>; Wed, 18 Oct 2023 18:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697678942; x=1698283742; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vyK1KHZqUU/iZx0d102WDaBpGygjuk0uXy2F3d5EFY=;
        b=b2dcUlimg2dkZkcwtLCEJ96Mw2etFuPykp2qSy8hddRaOh832QIso5cYdbZfDzRtP1
         n8xq7sPqsR/ty8+0lz7E0D65roERpMeZwJdOTdAay2bOREgXNsVqaL87MZyUQRXkEtXd
         0KTkAXPUzNWgJOX9ET5dab1qC3ZWYHybXcCBQjVGuXOAVEfuG8vTIle4Hu3tSUy52oGm
         SoDfp0+cl75sJp8/awx+X2FTWG/va29+2sHYcf5OZIarNII2JbKTorzvIXTGd9WfQv3/
         BY0MCdLHVbMBLRgROgmw4lbaET8ja6MiHkXRsnJ3T107FAJqjYt5Nvv9RR0ZUykaif+r
         4u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697678942; x=1698283742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vyK1KHZqUU/iZx0d102WDaBpGygjuk0uXy2F3d5EFY=;
        b=ez+xzt/z38PVabvsTrb2ZUak4BmhngTmKHIA/XeIpxnLIFcezvmEaF6DKk6wPLmCdl
         eConma1cpDIpbrl7R1gTsxg47YcL9vOtK3JdiXZ32vcRkrNTMLXavcXWMl+otKmZBA0S
         2/NWnGgsQ96nc8q9MFX5aFbRzsd+l3TMNXEwBqd3hjJriwicMgtlkAVjPuBFGIrQ6isx
         uiciEHeJWbTaxrFlvc4sfKcT7L/Ph821nIvowdJbmBVl8TND2OmZKElgVdxzL7zJH0/v
         tAA60wkahjnOJsfp8MyyfXlvMzNi9muLkVx+c1iy6EHBQBByc65EdTkusabrOCgq13RK
         FNcA==
X-Gm-Message-State: AOJu0YzzqY2SIGq92QzhYW5PgrfQ/yXBxoam1tuGis8yNZD51ypnAy77
	+D/aKo2+yRd3uUJfP084+SCYE6Vnjms=
X-Google-Smtp-Source: AGHT+IGsrEXUTpr+igB0u2N/FRcJx6uH0VoQyXbLGS3KMVPxEoz1C9wFWIdi7r4pWkKOHOqiZ10EAw==
X-Received: by 2002:a05:6870:179f:b0:1e9:88c2:ba80 with SMTP id r31-20020a056870179f00b001e988c2ba80mr1220098oae.30.1697678942558;
        Wed, 18 Oct 2023 18:29:02 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h21-20020a056870d25500b001e96eba5abdsm941607oac.26.2023.10.18.18.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 18:29:02 -0700 (PDT)
Message-ID: <62d170cb-151d-4f72-81b8-419bede2c990@gmail.com>
Date: Wed, 18 Oct 2023 20:28:59 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] Skipping AT+CUAD sending for QUECTEL_EC2X vendor
Content-Language: en-US
To: MaxLyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
Cc: Sergei Golubtsov <sg@aqsi.ru>
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Max,

On 10/17/23 05:48, MaxLyubimov wrote:
> From: Sergei Golubtsov <sg@aqsi.ru>
> 
> This workarounds bug in EC200A firmware which leads to modem
> reset in case of usage of some SIM cards when sending the next
> command
> ---
>   drivers/atmodem/sim.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 

<snip>

> +
> +	/* QUECTEL EC2X reboots when executing the AT+CUAD command with SIM cards
> +	of some operators */

Note doc/coding-style.txt item M2.  Also note that this line is > 80 chars.  I 
fixed this for you.

> +	if (sd->vendor == OFONO_VENDOR_QUECTEL_EC2X)
> +		goto error;
> +
> +	cbd = cb_data_new(cb, data);
>   
>   	if (g_at_chat_send(sd->chat, "AT+CUAD", cuad_prefix,
>   			at_discover_apps_cb, cbd, g_free) > 0)

Applied, thanks.

Regards,
-Denis

