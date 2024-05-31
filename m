Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96CB7D071
	for <ofono@lists.linux.dev>; Fri, 31 May 2024 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135808; cv=none; b=luHwX531oM00CDvXR+HNVNKsLqnAS27Hld/P7rnE6tlpV1cYRL0MYf1WHDKTMKIiIUsxHGseoW3Osf6fEX2O3Q4t0wbrNZFjuCAeT59uvnYFHbNOk17+ij2pfxW6HZVRi1Ztm5rWwiGxIJFJvsXXRAeOrMlnlHTqKLGZBVQM+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135808; c=relaxed/simple;
	bh=oX+alEJVym+TksVXdd3Uwm4z8zLiJwd/JYgefFeGCyc=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IOK+rof3O4tn5HIfe3tqa7ZKxvaPKgbvkuImfmRuk35QcJChfeIJY9cNZxEHEHAW1wCn3QIsS8gDwBB5A6WNaDIoL08OsYL6g7HwHHuk+rAFa5lzCTIHzx9Yk8sDXqTPhJd+gvrKYKoRvnQx8qS0cOXlXnyMepIEc68vHe/3P+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS4ubov8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS4ubov8"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57857e0f45eso1887535a12.0
        for <ofono@lists.linux.dev>; Thu, 30 May 2024 23:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717135805; x=1717740605; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RrxxpozV/f8wz0Obu7Ric2A/ObnEQuhOBTkXHLRO8Q=;
        b=TS4ubov8VppcKvtSzE8nbuur3HYYsp7td1yZddZjuTWQlIWqBqq1KYQ0/o1i3p0oWo
         SSatLgif6oWmf1tTM1NNYLSXBM83IVmM/ylypH22ilkUWNwJL2ZRCQ5fh1k1sJtnOtbL
         TxkEcfHhrumljgLPUwFYt2EywoyHaeqVJQWwihctE1K8/A1a9+RyA504qMbtRt0zwIum
         ykAOwPuwPztovbCQXC+mj1LsmDyqKX2yp4PgXKE3YsdKb3VEn+BOkfzGATaTSn/tpxa0
         RoSHezqR/YSUQ+7Rtcdun8x7ooxjsJI+Hestd2M5dcRYldotsYUgXxUHhYZNDunTCPRx
         /POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717135805; x=1717740605;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RrxxpozV/f8wz0Obu7Ric2A/ObnEQuhOBTkXHLRO8Q=;
        b=hjY4bSAcvhKUI9ABqoZYX80Dw7FhlG773wbbt1jGint7q9mPp72tjuhBlwFVzVJean
         9EttuQ3vG3BI9W9rhuPOA08OmOJ/ndluIAEzFNOrtQxOl/KFTHSpeRjK+vZ+dnUU7j0h
         vUV8UzuaEnaTLiJngnyDFPeIT4bXHKwl3Wqd1hiVLZuByeDEPdmSYd9CLxAjoIDfj4UX
         ikLfjY4tn9rB+EJQLvksnZA76MZPC40GITDApfk4caVviyU8kNr7Wt1i5Zg25MrLn9Sr
         wU5P/xi8tAxXH00U6nAMnMpVfod0WVTtQNzH059vNwnOovN8cWzo/EJuZ9EKHQHEef82
         v6Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXYFaVsxLaRxaUajoQrQAIzmx+G8+RHOqlNpGDAzhoM6xrndRnSVWlhdGTPRmvAnavdhnRdSJUcOMWdi9idWBrsk1F/3c4=
X-Gm-Message-State: AOJu0Yx8ifoiiO2Q9pnbqN6XZ0+d8n4dZTkBw2WMC6Ai7XtSdQj3gNfN
	WMTTsn0z0qvPlwX/JBi9ciC8pY+RWnalvWLtluTRkt9O0q87uxLKy157yw==
X-Google-Smtp-Source: AGHT+IFMjRLNoSRd6JsjdfMQSrnsFhEJLc86B3Uc5tS3CibYR6IbLi1HFvKWCaHAYlNSyb1IEyr6xw==
X-Received: by 2002:a50:a414:0:b0:579:7b6c:5ab3 with SMTP id 4fb4d7f45d1cf-57a364e3615mr691601a12.22.1717135804999;
        Thu, 30 May 2024 23:10:04 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b993b5sm613814a12.15.2024.05.30.23.10.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2024 23:10:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] udevng: Fix detection of USB attached tty devices
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
References: <20240530152513.279243-1-denkenz@gmail.com>
 <20240530152513.279243-2-denkenz@gmail.com>
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <b0e4aed1-302a-0d4f-b466-7fd7b999275a@gmail.com>
Date: Fri, 31 May 2024 09:09:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240530152513.279243-2-denkenz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi,

On 30.05.24 г. 18:25 ч., Denis Kenzior wrote:
> devices on the USB bus, that are part of the tty subsystem were not
> forwarded to check_usb_device.
> 
> Fixes: cdd58360140a ("udevng: Add mhi subsystem detection")
> Reported-By: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   plugins/udevng.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 07c87eb8aa08..87969461ac5b 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -2510,17 +2510,16 @@ static void check_device(struct udev_device *device)
>   	const char *subsystem = udev_device_get_subsystem(device);
>   	const char *bus = udev_device_get_property_value(device, "ID_BUS");
>   
> -	if (l_streq0(subsystem, "net")) {
> -		/* Handle USB-connected network devices in check_usb_device */
> -		if (l_streq0(bus, "usb"))
> -			check_usb_device(device);
> -		else
> -			check_net_device(device);
> -
> +	/* Handle USB-connected devices in check_usb_device */
> +	if (l_streq0(bus, "usb")) {
> +		check_usb_device(device);
>   		return;
>   	}
>   
> -	if (l_streq0(subsystem, "usb") || l_streq0(subsystem, "usbmisc"))

Is it possible (in theory) that we have 'usb' subsystem device that is 
not on USB bus? If yes, then you shouldn't drop l_streq0(subsystem, 
"usb") check.

> +	/* Check the rest based on the subsystem */
> +	if (l_streq0(subsystem, "net"))
> +		check_net_device(device);
> +	else if (l_streq0(subsystem, "usbmisc"))
>   		check_usb_device(device);
>   	else if (l_streq0(subsystem, "pci"))
>   		check_pci_device(device);
> 

Regards,
Ivo
