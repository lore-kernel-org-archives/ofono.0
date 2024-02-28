Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F815B98B
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133976; cv=none; b=MwP3XPZr+F4Fg6Bk0jdvZdDsuB6EAe0aj3jW+LzI57nP4n0XmaMrr4FT/XTk8zuVkjy76m+NprCB/gVDvmU4vxNmfEN7v2T8z5s3KPA3Ud414FZ+em/dS5P4fKd7TY8eOHUA13C15J+UYZu+YAPgCh7g3xQH/gcaRCyek6jKtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133976; c=relaxed/simple;
	bh=vgpN9gd5PhIDYTtoRCht/i8XokDs9uLaBdQreb/MakU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Iko4qx43+u6hNjpEerYiiwu1/sWR0tI5I2MUYl1qg0ZHKBU2U0xDwCZzlBsudlCWUkTJsfdg0mjB3g8cQgDfpNE2r/eqrbadZBlvNRo5zIpvoy/vYGCGM/pen3nYOPvZVlOwzFR4SJBjFEFKYGhSAILaVJHdNsym+GYObXe0kDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IamsNXmx; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IamsNXmx"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a0932aa9ecso1664404eaf.3
        for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 07:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709133973; x=1709738773; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u75KamTN4gB7E8jKMIJzfryCe/NYOi/auBWN9eI0TSQ=;
        b=IamsNXmxLIkR8Pc8r6wRDd+Fpl7c5iZtz5ILpmWBH0kIMayo/j1bZNeDTwzuk3GGsB
         y0aMxgd2Lzxb+wRQ7ldhb8WfgvoMZRnFwKWfK0BAgR4AZFpwJzrAm4eF7iVPFAZx0rbO
         5D1jIK2HE5jGZtN4DD9ewjf0JdLPXRY4Hj+zoz7OYOhCbYHaaM1fW4zloeK27ppur6XH
         3wE+Q2akgmGTsj4+9Xdq1NgPpe5Axg01ExMrHSxUDIUP7Ij2Bv+8Pw3keLatn072HaSz
         0+wKE/ibwXgsQoBaBikqbhcbiRfZOmulvRj0WNFIHr7oO2xnVDv6539tJVvkNPhu08g2
         TIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709133973; x=1709738773;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u75KamTN4gB7E8jKMIJzfryCe/NYOi/auBWN9eI0TSQ=;
        b=wcSjNP6Yt9vxFHwzvod1gOPgw3XCz4SLj9DKWJCE3RN4KLMNruvTyclC/kwVVNeTw1
         2uvsuPdnisp3Y2ceDDkrIm3BqNVG3wg/Ta7RQg0vN3EOlXbu260oM7EIy1Dpu2DT00Lt
         8n0mXYvJDG8WrCl+q0hbbAlA2ZOvrUe9zhz50F3hz08j12EztZt8/OaVuoI/rzRh69Ca
         BRrul1zgIpWMnnTC+USoWB3bH3cuJo3H3Y0HswzBZYxbYyEUYV2ub6TtP//WPnr+SosV
         z/0gOX7hdzoKpy32IqTZbg1zebhtM8lvhxkAcj285LtW4KPs31vwpRg2wt8j/55qEZdN
         PzFA==
X-Gm-Message-State: AOJu0Yx2z8wP7Uqnol230/3uAbzOBjLzfsuTsOgFG7QSdKQZd30IdcFS
	g09l+58bOgZo2C49ZHIDkw4olCqB9NhWmOH5xNlv53w3RCCZm2SBH8PJkPOA
X-Google-Smtp-Source: AGHT+IG66HNLUpsKlGYW3e9zxKi3JHZsZEkgioh9k7diIOwGyA5ZWenx2RYfs+4reO0dYnsnn0sEEA==
X-Received: by 2002:a4a:4481:0:b0:5a0:7cf6:3704 with SMTP id o123-20020a4a4481000000b005a07cf63704mr8815111ooa.5.1709133973419;
        Wed, 28 Feb 2024 07:26:13 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b16-20020a4a3410000000b005a0aed6070csm740239ooa.19.2024.02.28.07.26.12
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 07:26:13 -0800 (PST)
Message-ID: <accb7ecf-a059-433c-b145-52c407d05da1@gmail.com>
Date: Wed, 28 Feb 2024 09:26:12 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmi: Support dynamic service information
Content-Language: en-US
To: ofono@lists.linux.dev
References: <20240227175739.1471333-1-denkenz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240227175739.1471333-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 11:57, Denis Kenzior wrote:
> On QMUX, service information is static.  It is obtained via a CTL
> request and remains static for the duration of the connection.  With
> QRTR, services can appear and disappear dynamically.  Support this by
> converting the existing version_list / version_count member into a
> queue.  struct qmi_version is now replaced by struct qmi_service_info
> with additional qrtr specific attributes.
> ---
>   drivers/qmimodem/qmi.c | 118 +++++++++++++++++++++++------------------
>   1 file changed, 66 insertions(+), 52 deletions(-)
> 

<snip>

Applied with the following change

> @@ -853,7 +881,7 @@ void qmi_device_free(struct qmi_device *device)
>   
>   	l_hashmap_destroy(device->service_list, service_destroy);
>   
> -	l_free(device->version_list);
> +	l_queue_destroy(device->service_infos, (l_queue_destroy_func_t) l_free);

This cast isn't necessary.

>   
>   	if (device->shutting_down)
>   		device->destroyed = true;

Regards,
-Denis
