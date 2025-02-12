Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080C1D516D
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388090; cv=none; b=PiFQWblVItETiAenW3KdFzUX9Ei9F8e9PWAwFyJuWjS/Vm3qOk+tbg5GBWuHPM0joqwj/+SzQitEBk7ijuMHtFrg/OOTCA9GhvHzs3hrWZMgckI47V/C25fo+tcdjgYZV5TdMrOvs42CoQAaUMN4l77QwwBcRR3J5wTlG2tDMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388090; c=relaxed/simple;
	bh=xW+32q160HUbS5KqNKd7gp4PYhBjxlQ2cpOGQX9RxgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MAWPCmZ4l0WebuZ1LBndXvCFeHKeOig+xEZCNE1WSPrj7RTKTKguZVjzffVy5C7NnGYjospTWpLDzOweH+KHRPjJFeemoLjcXHP6Punj8IF2t/8O/n5JxYoWMDMA0NIpfnJCcSUJrjblNWO7zaKvumNqawkBLcnh2SUV+PAIJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZibjD7Nm; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZibjD7Nm"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f3d6fb7cceso17327b6e.1
        for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 11:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388088; x=1739992888; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmn2yCZyFzqDbz0x+Lkzy36XE00Sc3uqcJBJ415bK90=;
        b=ZibjD7NmYpbFypxU1O8TasDrvkeFmYLfvFM778QVc1Uhg2qkWwHprpzrXGFKWeytHc
         vB0tpuE4lJIj9pDMrQd8HH0Ut6vUCPRRYL8YLHI7D8sEhJd6xmENll0bcxTUks52TAFo
         2ACzahZ+QH9CSsdPT6/FgTlaKuv+x0bOdk5lv5nx4ejmgTAZikftUjett47NslErMAp/
         dww5cPuXtnpMW8n9kBQLgNeu7LbI2lnA71dVXaSyJeVPv3Z4/uqV01ijE1qb6Xp/EkGb
         oz8qQQpUfAtU5sFCvrwCcjrkSynGryJtgCl8aQ0e8EpxuBmtvU3N27m0G839xFX5JoHn
         y3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388088; x=1739992888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmn2yCZyFzqDbz0x+Lkzy36XE00Sc3uqcJBJ415bK90=;
        b=H0ZVmNx+Ye5ljxho137LVxeEgNfWSpVRQfPi9j0BpquRC+lS6/RydaV7inWCIZrHZH
         DoP/ZFsmg+yc/7QHwq4BV/z2pGNaslxStbpH5hoT3J12YOYrXSgZ+6eMDpWQ4NdFWFna
         ZCnG8UPMc3+/CKOXBGkRa7zdlk5KbjMpQZVCTM4hIqP3YvIl8L5T5e/5nRBq4zEeIGg6
         jMvWzRIdFKbFaQDibhypQfuSl5PZCKBDFUUBnUG6OP57RcdtMF/h0/1RFGnux6AdDRh6
         MxDfkDGa9It8C0mj3w9a58ptFNQHSmNDBvr86sAmXhGDQpadHUzbSINgHWd2qSecqf9o
         9vIw==
X-Forwarded-Encrypted: i=1; AJvYcCUcFtP+a/tY42CT3sGhbpuFqiYL4xMNpzGLeW7QYZW4XuPPNeoBkkp0MD/2ip37RxnQFZU1aQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze/7BdBkr2ZCsCQf85XUId1HDfYHNaBp1a1vPxRnbx6Y6Mvj0R
	clDd3345p3o8e9gOQBF8wgdqt0G8IOBeZ3w7qptlrjhv1e6kYjv9Yp84hQ==
X-Gm-Gg: ASbGncvdl36TzzN3ekTVkNCoPEAG7yh6jXuidSW/6zKsLwgoXHflJ1Ge+glB9DuSXkI
	8Um9j+xaTJyhIJMUmtbgneO2iKwHBTgmvHs7rITPRl+mOPso8XIMnpVEhjQ0G0E7Dx67zNLJsRv
	PAoFMEDNztB13XzdZXG31mkWhaoJZFR4KYYB+5GrWpZiVMi0ut9Oe1ysR+iDbY1iP9c49szsq/o
	1rUQTFbfPY9Zipp026AujPpgNBR7aY3UeTY7/fQnVubHleR2y9wbqYi0oTjPwnAqnmup0MNpOit
	h7i5ZS++Oeeb/cZCaiM+WGoUATNvujTpj2zY7DYdSVW5JpNmtFtbHVF0
X-Google-Smtp-Source: AGHT+IGUv7r43EbUBZDd53zTOigUvlwXm2robLTl90MUbpOD+TzDStddgboEf2mB6gII43/MiqVKkw==
X-Received: by 2002:a05:6808:250b:b0:3f1:c7ab:480 with SMTP id 5614622812f47-3f3d8e3f933mr212860b6e.27.1739388087941;
        Wed, 12 Feb 2025 11:21:27 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3f389ed47fbsm4552722b6e.18.2025.02.12.11.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 11:21:27 -0800 (PST)
Message-ID: <2672a62a-05b2-4720-8af9-f6272d5d7497@gmail.com>
Date: Wed, 12 Feb 2025 13:21:26 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] qmi: Added structure for device options.
To: Grant Erickson <gerickson@nuovations.com>, ofono@lists.linux.dev
References: <cover.1739339173.git.gerickson@nuovations.com>
 <92dd49e261569657414c1e43825cbe8928ace900.1739339173.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <92dd49e261569657414c1e43825cbe8928ace900.1739339173.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 2/11/25 11:52 PM, Grant Erickson wrote:
> Defines options that may alter the default behavior of the QMI driver
> for a specific, instantiated device.
> ---
>   drivers/qmimodem/qmi.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
> index 913035897ea4..3f60e90c015a 100644
> --- a/drivers/qmimodem/qmi.h
> +++ b/drivers/qmimodem/qmi.h
> @@ -76,6 +76,25 @@ enum qmi_qmux_device_quirk {
>   	QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT = 0x01
>   };
>   
> +/**
> + *	Defines options that may alter the default behavior of the QMI
> + *	driver for a specific, instantiated device.
> + */
> +struct qmi_qmux_device_options {
> +	/**
> +	 *	Device-specific "quirk".
> +	 */
> +	enum qmi_qmux_device_quirk quirks;
> +
> +	/**
> +	 *	If quirks has #QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT set, this
> +	 *	is the minimum period, in microseconds, in which back-to-back
> +	 *	QMI service requests may be sent to avoid triggering a
> +	 *	firmware lock up and hang.
> +	 */
> +	unsigned int min_req_period_us;

Why do you need both?  Isn't setting min_req_period_us non-zero enough?  Also, 
strictly speaking this may also apply to qrtr devices.  Maybe just add
bool qmi_qmux_device_set_request_throttle(device, us_time) ...?

> +};
> +
>   typedef void (*qmi_destroy_func_t)(void *user_data);
>   
>   struct qmi_service;

Regards,
-Denis
