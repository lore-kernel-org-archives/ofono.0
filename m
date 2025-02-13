Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFA35967
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412430; cv=none; b=TqjJtwYuC/dmi1XuffrCCBtwO5a2AG9YhF3+AE8/+/2EO35u7IZCcPURbjJ8pTbVaktMyr6JQr1zlxVQ12RCVR7Ci3nQjEnQa8K2llpvdGXLx3pjQcxLavK5j0YhKm7VB9A2tuLrxxg35zzz+sp6Iw6Fkv3PoTi48Ir7RCMndI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412430; c=relaxed/simple;
	bh=biKDlcoOT67/2Tx7NNku5Ji6eExoC4yBbopI3YYq1Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TLn6loqaKJZH7H7BRK6gkZ3W1A0p4v7TYNR9yffiARjdLfohAlT1JsLIcdP25E5PQIH1dcQBPEqBxt1t0PvQc6bIVfAtj8P63aSHvoQMu+7cpMs3PWCBrKn8nwRHU89NEyb4lVpfkYwX8maqcfH74rwLcxb7Lk2H3QZvRkCxs0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKcq7Tj7; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKcq7Tj7"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2b8d6040598so206998fac.1
        for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 18:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739412428; x=1740017228; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tqb2NWHFb+E7W6LvOtkBuGb4DOBVRVOThh2dbdLfoXA=;
        b=iKcq7Tj76DxNZtgQigRHm0xaUcFzavAJalxJYAZiNdcbelEKqmQxIv9/4FOZ9zk7RV
         p9UWuRyk/wP61JflbMD23OoATsqjQdbtu690H/GPr30jsqFF66YXihvGBmgygdHJtGkB
         zUhLSm8r03HNu3p6UIZaIuLJnmiRCEHRZjxIiT7U+l7c4OJxjmyGK5bPc9AL8du3ypXm
         VFqO9qXtMrJ9TKFMewXC76PV3VEI2Zu1mPaXFLSkj/8xHpEGOHKrxpzktkv3erT0v1yv
         oY9zd4bSp57ao//TveTSun0hg9b7NbmeiZRtuQ+n/v17gKcpC9aXgAbuWpCpSdwYGo+V
         RywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412428; x=1740017228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqb2NWHFb+E7W6LvOtkBuGb4DOBVRVOThh2dbdLfoXA=;
        b=tCpG+Ny2bP4BPISw+Kgi3CK4O2/Rf8j2xx3Zp+TuRuAEDUuMQZOALUiGFkYl6z1Rob
         7zqvuU3CgxMIFxB94qrhZb/zFE0T118oLnlo1KnibSF3Kl4fy+rdEQgtMrqG8gOl/0jS
         RAI1rMRJPrrD1XUfOKRXkFVNeJZulv87Brpk2y4FGRRFvSK74Zpdrg+wVTyrta2QKVCO
         sNMH83ljZdRhOCL1lGKUs1YPxkeNh4D6zpxsiV0mob3TMf4kqt3vIq76PHMr3iDYv8tH
         wG9NWLk2P78LSeHvBpKhEyA1eGyFd5+d/BrdHYr4zy8yZQUd0rgJ2SdIPLUUXrwMbbwb
         Q7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKUDrjItzMzf1kK4hDaWoaLlWOWm8vyGi96IW5UlhJBXUhHPZlWrTKJNVK8hmpaSmEj9Ha5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqeLjPa1srCyPiFs5OPqffgB4tokP5DNzafpXDSroUt5qXrL+k
	gUii/XQHKSgQqtzgBdPGmM8M72SY7hwjP4UJqyQL7mAEG3pzY+81R8KNVQ==
X-Gm-Gg: ASbGncv9k4IFQebmQwR3CO3lfsoG5u5kq5OWy2sV2rVk2Ge/+XxcfHArozJ2mARAatk
	cgKuhUyu/iWxTRWb4ppm5WiEyk7k5qKr0YzEz5bBFMfFoWRQcJhmSi8HKI7HbkzikvqZoya8j/1
	uBEx4pB69TTCB80m9q6BpzMEzOcHjqqRA4+yM+53vYcEoIAjMawq15ATPaXp8Y/yS+ABMxU3mS8
	EOztlYcvJb72GzV+IXgmgoqVKbuU99nPznStQlYvPX2i+N3nMltBK+UlY+kaZU7ZqM6K1Nmb8mr
	8Fw90ZSmscOoLLhwT6+7FpNfx0g8dCSL2OmHdeTNuGBvXlZd2BPPlhOp
X-Google-Smtp-Source: AGHT+IEoqLxa79j20WEQal1mFcHBqClMw8EhxzYDKY1HQ+G0xHCHgTN1pRr0M0osLHosvMjVVvo2fA==
X-Received: by 2002:a05:6870:b52a:b0:2b8:92f0:ba5d with SMTP id 586e51a60fabf-2b8fa99a7aemr870420fac.8.1739412427903;
        Wed, 12 Feb 2025 18:07:07 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2b9548200d1sm187358fac.3.2025.02.12.18.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 18:07:07 -0800 (PST)
Message-ID: <5e8f1d1d-01d3-4577-b17d-c565e93f9e0d@gmail.com>
Date: Wed, 12 Feb 2025 20:07:06 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] qmi: Implement QMI service request rate limiting
 in 'can_write_data'.
To: Grant Erickson <gerickson@nuovations.com>, ofono@lists.linux.dev
References: <cover.1739406657.git.gerickson@nuovations.com>
 <d2b56b2248111502169c4639329ad8f2fa5715dd.1739406657.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <d2b56b2248111502169c4639329ad8f2fa5715dd.1739406657.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 2/12/25 6:33 PM, Grant Erickson wrote:
> Determine if we need to rate-limit QMI services requests to a
> transport-specific minimum request period. If so, return true so that
> the queue can be retried again later.
> 
> Adds the following data members to 'qmi_transport':
> 
>    * Minimum request period
>      - The minimum period, in microseconds, for back-to-back QMI
>        service requests.
> 
>    * Last request time
>      - Time, in microseconds, when the last QMI service request was
>        sent.
> 
> to support the implementation.
> ---
>   drivers/qmimodem/qmi.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index bbe6440abe0f..ace83044138a 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -92,6 +92,18 @@ struct qmi_transport {
>   	const struct qmi_transport_ops *ops;
>   	struct debug_data debug;
>   	bool writer_active : 1;
> +
> +	/**
> +	 *  If specified via qmi_qmux_device_options, the minimum period
> +	 *  for back-to-back QMI service requests.
> +	 */
> +	unsigned int min_req_period_us;
> +
> +	/**
> +	 *  The time, in microseconds, when the last QMI service request
> +	 *  was sent.
> +	 */
> +	uint64_t last_req_sent_time_us;
>   };
>   
>   struct qmi_qmux_device {
> @@ -653,8 +665,25 @@ static bool can_write_data(struct l_io *io, void *user_data)
>   {
>   	struct qmi_transport *transport = user_data;
>   	struct qmi_request *req;
> +	const bool throttle_enabled = transport->min_req_period_us > 0;
> +	uint64_t now;
> +	uint64_t delta;
>   	int r;
>   
> +	/*
> +	 * Determine if we need to rate-limit commands to a
> +	 * transport-specific minimum request period. If so,
> +	 * return true so that the queue can be retried again
> +	 * later.
> +	 */
> +	if (throttle_enabled && transport->last_req_sent_time_us != 0) {
> +		now = l_time_now();
> +		delta = l_time_diff(now, transport->last_req_sent_time_us);
> +
> +		if (delta < transport->min_req_period_us)
> +			return true;
> +	}
> +
>   	req = l_queue_pop_head(transport->req_queue);
>   	if (!req)
>   		return false;
> @@ -665,6 +694,9 @@ static bool can_write_data(struct l_io *io, void *user_data)
>   		return false;
>   	}
>   
> +	if (throttle_enabled)
> +		transport->last_req_sent_time_us = now;

Pretty sure this won't work and gcc will complain.  Compilers are still not 
great at tying together multiple conditionals...  You might still be better off 
keeping this inside the if() you added above...

Also, don't you need last_req_sent_time_us to be initialized to be non-zero 
somehow?  Otherwise it is dumb luck that last_req_sent_time_us is set to 
anything the first time (probably garbage data)

Confirmed.  CI complains:

Alpine (musl) gcc optimized
===========================
Configure: PASS
Build: FAIL
     drivers/qmimodem/qmi.c: In function 'can_write_data':
     drivers/qmimodem/qmi.c:698:50: error: 'now' may be used uninitialized 
[-Werror=maybe-uninitialized]
       698 |                 transport->last_req_sent_time_us = now;
           |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
     drivers/qmimodem/qmi.c:669:18: note: 'now' was declared here
       669 |         uint64_t now;
           |                  ^~~
     cc1: all warnings being treated as errors
     make[1]: *** [Makefile:4090: drivers/qmimodem/qmi.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2405: all] Error 2

> +
>   	if (l_queue_length(transport->req_queue) > 0)
>   		return true;
>   

Regards,
-Denis
