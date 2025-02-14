Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AC15749C
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546987; cv=none; b=bzFZQ51Cw52lIauibIK1bXufOn16Wn5FnNNurR+uDWVXFSuyAOzhQzEHqCqxgNf0Y3IFKC3QyY0oURhgmxqt3A5R4/5Rk1tnSlR6yswY/80IbqNCf/xFTPJ3C/aASoxmMhdnonXI27mmJ4iuuRO7/8GGj89YzGWFvbPyYXyPV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546987; c=relaxed/simple;
	bh=vPPXcWTpzMa0AshoZt1kk8+jdhEUi+hIrhEuM1AxMDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N4jo99F/2OiXeoqtMHEqwe6hoisotLZ9fnMNNZzdDdMWjPpWSPp05WSVVtNYgqqNh84NECQ/woop0i2mF1tng37x1ccpF/TzKxG5xjOWVnqClLpA8dNEbyyP/2T1m8Qg7iCD7fOpodiS+NEvnDFkGwnzj/nJTf/YDS58Du9B03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEhvwvI5; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEhvwvI5"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-726ed7a316cso1225926a34.2
        for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 07:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739546984; x=1740151784; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ax66SL5P70iubyrnw8N7LqqVxcH2zDAkInhZFfR1HSg=;
        b=cEhvwvI5VqdEdKiEAwaJo6QkIrWXDxWTwQvTToEidlMk8MH8Na76CjT+IAC7xyXVUb
         RUZaecVQNX2LTfCZCxFNfaV81YgClyoxyoHM7XTIpF8TkDf2es4gBwxWb0QscLpjwVZQ
         5u+2iF+WWLC9QWkOA0nFmyzcOxl+CAiAbLrxeLS6YnOVe7iDo6EPpvCh+W5OttKrWSUI
         gvk8jsdzux4o9BxFi2mlkrIwD2YovGDVvLWLeriRJvqJccnoTFBZqtdCCwsMbwNI5egh
         VkeMvP13Df7CLpvqbmHL6I8uSBGSxlmh5CbtK00et9rK4SutQ4lJM66Iqc+RXsKX8r5A
         a89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546984; x=1740151784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax66SL5P70iubyrnw8N7LqqVxcH2zDAkInhZFfR1HSg=;
        b=K/qvt88ho9XpnbMGQSP/HDZR4BYqAJB4GyoaSA0+ecxrCxeD5LbNeYPiV9Y1sY2pGL
         6DBJDqyLHZxf+WDHj3KW5kts28In4j5BenWzohb/MBEvR3Z6M+aF/LQKiU825bUsFQMI
         AHwXva6LVMSNZgu3GzGXHiRc5ZMoTE9RAk+T47CG5MqZBJVPKxaySLoQd/2N70K/87ux
         7sEv7kspJJu8l4aQDi2+R7igx9oPTzdm9RjxQinTNi4747wjiLTS14mDGHaTM9CpTBF1
         PrHSaLjjGP9FBX5HmkfmMP72giA3dfiBbvC0+tCbz5htrnAj2P7B+MXf9Kl/pDGVbMnW
         GFjw==
X-Forwarded-Encrypted: i=1; AJvYcCVuLjh4sUMYpM7sirC7OV7pz5ugWa6p/TiXLHdooQG1fiaXerfi78ExEHqQ4qZc30nnW2SKTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJycAS6nuNa4yCAif1aPK+2NZJkNGZezsiNsqMsNWpXJQMHnL1
	LxSWiYLUk8mhpAOMn5LeOtJ9ZVtb8MJb+CueOGafyhJ4teOUh+6yV++78A==
X-Gm-Gg: ASbGncvKEbc331lF43dGhjJZEIlv9YbZFCcQnsa+mxenvLvGXo45z33Zl/hhFfT5xvp
	dwIL+u7IM41zHpT+35PWdWjIrX10PuoHFz0DxuYUOH+zm771WBBWhkn4qJOlnPBsANhFmzhkjob
	5yZJxMnP5h1xUrcHeoFmdmbb8YKzM9u/zE5W+HNjcOaAk1rVQek8M8ofQUkLAoaRsXrd0upiSxN
	wYgfRowb1/xI5ZADX3rVZ5WjYkUlFhMuc3d+hEIoiAnwd2iMbRJg44STn/jDorGqTnMKBpQZnvy
	bwARVy6OMMQm5QXHQamQVfPwfFCfmSWGnJTs8A23i0b1kO8H/OgTUNAk
X-Google-Smtp-Source: AGHT+IF9VPTf7O2sFytfyqrI2lSt43thiomyKxKM55HR81AHX38Z0XfuHYZJyrgxlhwJed7stpVrkw==
X-Received: by 2002:a05:6830:349c:b0:727:dd8:ed01 with SMTP id 46e09a7af769-7270dd8eddbmr1231202a34.21.1739546983830;
        Fri, 14 Feb 2025 07:29:43 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-727104af7d6sm79119a34.65.2025.02.14.07.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 07:29:43 -0800 (PST)
Message-ID: <bee3deed-8285-4452-9c14-c40b60c06ade@gmail.com>
Date: Fri, 14 Feb 2025 09:29:42 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] qmi: Implement QMI service request rate limiting
 in 'can_write_data'.
To: Grant Erickson <gerickson@nuovations.com>, ofono@lists.linux.dev
References: <cover.1739509438.git.gerickson@nuovations.com>
 <31c04f926af6ddfe0e244c2d6b0999ee9442659a.1739509438.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <31c04f926af6ddfe0e244c2d6b0999ee9442659a.1739509438.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

 >   struct qmi_qmux_device {
> @@ -653,8 +665,25 @@ static bool can_write_data(struct l_io *io, void *user_data)
>   {
>   	struct qmi_transport *transport = user_data;
>   	struct qmi_request *req;
> +	const bool throttle_enabled = transport->min_req_period_us > 0;
> +	uint64_t now = 0;

I think this is still wrong?  There's a reason why we have doc/coding-style.txt 
item M7.

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

Consider the starting condition:

- last_req_sent_time_us -> zero
- throttle_enabled -> true

We don't enter into this if(), 'now' is still zero.

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
> +

throttle_enabled is true, we set last_req_sent_time_us to 0.  In effect your 
throttling doesn't work...?

>   	if (l_queue_length(transport->req_queue) > 0)
>   		return true;
>   

Regards,
-Denis
