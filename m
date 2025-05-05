Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1A25CC62
	for <ofono@lists.linux.dev>; Mon,  5 May 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461193; cv=none; b=Y6tNZJWRSh6dhobx8nmJ0yeXXV+g2ntzK4XEMW1MoDrqTKmUm4KEYtp8kWSoELbFD7+ZIkxRZt5qFhsl339TR53tlYzVws9gTZiurjyiGkQUDD7IeankCVfrJrqlZlmOiOu9Ku/SrTuSe+QIyTM6arTsIQWwnLaJcwK9ZxTpVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461193; c=relaxed/simple;
	bh=Pse2MsbAPm+0FA5LHHiMID5fq0hZ+ch87e76zDjjwOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=amb6DX9woDo8rtGF1U+0SV/93X6gTbWJ04qPxZvc2iD1LfG6/s5ZAf8Jty7uO8DfQ9kpx+s50I6mSpA2UFYNIV4Wtmdh0P4nk9JqS9skez9lgVazinOUFgBgLWEr2rZjOa2t+kYYfsKaH5sPgsX5EdLsq6FiNTsDNk3s/tv6/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVg4N3qa; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVg4N3qa"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2d09d495c6cso1197391fac.3
        for <ofono@lists.linux.dev>; Mon, 05 May 2025 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746461190; x=1747065990; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bV9VmcVzw8LrBpT7b6HUn1P9vFFS30IwGOGtAUaoYT4=;
        b=kVg4N3qaHFL4wMgndFzRepoUiUzfiejvicmUTjIvjT1Sk1wuao9jWZtZt5M29xzwaY
         fVmYCVnXjwY9rxCOEhaNUUdwVk4VUl65RTbMHvTS9oLMKLYmCYk5kCUGg1wHHEczkmkq
         aeCdDg8IVGWeKrmEU1HDEEzC9CXr1MU38vuGduAQSaBbgFkDHdKrbyHUFPdVXKweXIs7
         oRc6Yx2fse19rXFLS0kKrjWIZ8dSFpWs0GYiGhwB9uvW7LvjaaynnAFjsqRmuav1WPUf
         kyzqp015jN/VTiOCuhEMWrEX5k6bmQRBM2lUmkdwoCxqlDucrFm2Oh1vxCsKOb4RkftL
         ttQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746461190; x=1747065990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bV9VmcVzw8LrBpT7b6HUn1P9vFFS30IwGOGtAUaoYT4=;
        b=SzSyPDhVTaQ3Bp5a6iKqNh1fGPEK2OjPzg89Po90lc7L+hVU6GYJV30xKCpu4bheVU
         9gyfXsrB9TP9C2NypuKO+fLmU2/uXPo5UdoUW5mhmAlW9fa4p9eICPiPlLDq8U8Uomh+
         1+2dcUMSDv6KIOYFPVXZ35qVir4OniddVWYWv+s5OUES0wTCbF8iYv0QaCeQMlIvUw1j
         GKMiGdcZmF5WbABwaGaBMMC1HlEGL88HYzIYKYd4Ig9L30EPSDEcYSk5rCEU5MxR1YOs
         ya/n1BMeISima+hN6A0LUbrwtWfwBTsDZn7uvvR7m9bkk7t1XPdQylZtOKeInPn0XF0r
         gnvw==
X-Forwarded-Encrypted: i=1; AJvYcCUmgPU34+Y7eA4vWeKeUcYcmZLV4Sm/6IGfJlZw24WCjRR2zcHO29LOesHWqQH2FxY/e1V1SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzT2ZeaP4yXBCTGr5djY1diOs8w1hr3a5pYBN3GO66VPDCTH1UN
	WM6c7N2lj+wmRE6f8cWr7RTq7viG6IHltxvUcrX7mJrX18TcwGFfpiFUFQ==
X-Gm-Gg: ASbGncthlT/8sR4jHjZdPJ+H3WerIjZD+c/WrqaO5EcMTmmGsyXLudLfvTXSR41ZHIx
	PIBW7Eicw+UUxu6PG58kVYo0nFjeQqv1rMAcKxXgM2dXEEDxkjYAkoTFZM2vqUk7qpNAu2EjDro
	OC8AMjL7K1myGYMkJi0LLvLgm7jvdvsC0rZLeSYues+EJCGnNLebSCNUWG5KwHDKOq9y9q1mjwO
	25rdxOFsgKshLPVgsvcPlP7EKzM8BBp5NAiQkDcJ3+1z4nBspQY5HDNPYluiWB2z974Zx3cGkOC
	mpsJGsghyN9ktQ8hiVCr2N5wZgouuK/ABVZpGFXV0NGyEE77xPRYtfi2HAbKXn6DD0pEtA0JLfU
	j52Y35w==
X-Google-Smtp-Source: AGHT+IFz5Q6hKoIK2BLCBYRzYvvVyg7ZD6hqVDxVtl+mQhTY/gocgQtyo0iCic3OoFG1hQD5hIF50g==
X-Received: by 2002:a05:6870:55c9:b0:2c2:4e19:1cdf with SMTP id 586e51a60fabf-2dae862bb55mr4549335fac.25.1746461190378;
        Mon, 05 May 2025 09:06:30 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-731d350a513sm1595282a34.67.2025.05.05.09.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 09:06:29 -0700 (PDT)
Message-ID: <802f94b3-a288-4c6a-a8c8-df2fe8f4c116@gmail.com>
Date: Mon, 5 May 2025 11:06:28 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] mbimmodem: add support for MBIM extensions * With
 MBIMEx 3.0, arguments for activating GPRS changed. Update as needed.
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>,
 ofono@lists.linux.dev
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
 <20250504191931.7078-3-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250504191931.7078-3-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muhammad,

On 5/4/25 2:19 PM, Muhammad Asif wrote:
> ---
>   drivers/mbimmodem/gprs-context.c | 59 ++++++++++++++++++++++++--------
>   drivers/mbimmodem/mbim.c         | 55 +++++++++++++++++++++++++++++
>   drivers/mbimmodem/mbim.h         |  7 ++++
>   3 files changed, 107 insertions(+), 14 deletions(-)
> 

<snip>

> @@ -253,6 +258,11 @@ struct mbim_device {
>   	struct message_assembly *assembly;
>   	struct l_idle *close_io;
>   
> +	uint8_t mbim_version_major;
> +	uint8_t mbim_version_minor;
> +	uint8_t mbimex_version_major;
> +	uint8_t mbimex_version_minor;
> +

In the current design, mbim_device doesn't really manage such state.  This 
belongs in plugins/mbim.c instead.

>   	bool is_ready : 1;
>   	bool in_notify : 1;
>   };
> @@ -875,6 +885,22 @@ static bool close_read_handler(struct l_io *io, void *user_data)
>   	return true;
>   }
>   
> +static void parse_mbim_version(struct mbim_message *message, void *user_data)
> +{
> +	struct mbim_device *device = user_data;
> +	uint16_t mbim_version = 0, mbimex_version = 0;
> +
> +	if (mbim_message_get_error(message) != 0)
> +		return;
> +
> +	mbim_message_get_arguments(message, "qq", &mbim_version, &mbimex_version);
> +
> +	device->mbim_version_major = mbim_version >> 8;
> +	device->mbim_version_minor = mbim_version & 0xFF;
> +	device->mbimex_version_major = mbimex_version >> 8;
> +	device->mbimex_version_minor = mbimex_version & 0xFF;
> +}
> +

The version should be obtained similar to how capabilities are obtained.

>   struct mbim_device *mbim_device_new(int fd, uint32_t max_segment_size)
>   {
>   	struct mbim_device *device;
> @@ -1035,6 +1061,35 @@ bool mbim_device_set_ready_handler(struct mbim_device *device,
>   	return true;
>   }
>   
> +void mbim_device_get_version(struct mbim_device *device)
> +{
> +	// Version is formatted as (major version) << 8 | (minor version)
> +	const int mbim_version = 1 << 8 | 0;

nit: static const?

> +
> +	// Always open with MBIMEx 3, devices not supporting it will fallback to MBIMEx 2
> +	const int mbimex_version = 3 << 8 | 0;

nit: ditto, also please use C style comments

> +
> +	struct mbim_message *message = mbim_message_new(mbim_ms_basic_connect_extensions,
> +					MBIM_CID_MS_BASIC_CONNECT_EXTENSIONS_VERSION,
> +					MBIM_COMMAND_TYPE_QUERY);
> +
> +	mbim_message_set_arguments(message, "qq",
> +								mbim_version,
> +								mbimex_version);
> +
> +	// For some reason, sending a message will return an error code, even if valid
> +	mbim_device_send(device, 0, message,
> +						parse_mbim_version, device, NULL);

Hmm, this is suspicious.  mbim_device_send should never fail, unless the device 
isn't open.

> +}
> +
> +bool mbim_device_check_mbimex_version(struct mbim_device *device,
> +					int version_major, int version_minor)

The naming needs some work?  Perhaps mbim_device_mbimex_version_at_least()? 
However, since mbim_device doesn't really manage this part, consider using a 
modem property instead?  Or pass the mbimex version to the atom driver directly. 
  See for example how QMI drivers do this with the new 'probev' driver method.

> +{
> +	return (device->mbimex_version_major > version_major) ||
> +			((device->mbimex_version_major == version_major) &&
> +			(device->mbimex_version_minor >= version_minor));
> +}
> +
>   uint32_t mbim_device_send(struct mbim_device *device, uint32_t gid,
>   				struct mbim_message *message,
>   				mbim_device_reply_func_t function,

Regards,
-Denis
