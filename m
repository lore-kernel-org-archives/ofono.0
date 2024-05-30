Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21831B7E9
	for <ofono@lists.linux.dev>; Thu, 30 May 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053708; cv=none; b=ks1EbsTRqxtc24/g8jPM0/NEmnRsuQLXBCa0Ss5kCjn0s5wbHiPrsyV6zoZxKfNWL6zuKqlJaRkTNQMoWKepfsT2mAeBXPFk9OyKtFyYJus6h0sUwvIyPYD7trMBbiCOBYOAKmhe8LhNf8v/8jTsmFOcmJZbTcHiPH0iK1LIHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053708; c=relaxed/simple;
	bh=hz9v9NfzpJVwCQDXVWBNi3a+MgaJGTkFZYVS1xatelw=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hBAt2h9enGdTuHbxwlKtyYxfUbVdT5CWsNhIY1bF9sXyKOT4jqRs7RiybgR3OXul+4YvkxgNISZYiKu8WoFueNU5v/ih4PR9v8401k+R3Xi1kme7LR60muWajEOMlOoJFsE1NpKEE60HtHn9nHipjQbxLSxeVXFryzwRImeSfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKGAuhLI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKGAuhLI"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6519c6ec7bso41370066b.1
        for <ofono@lists.linux.dev>; Thu, 30 May 2024 00:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717053705; x=1717658505; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8/QAGThXXqRpgUxxoIaOU5K6OSx6jfN3zk+amiGP2A=;
        b=DKGAuhLIqoBq2edwh0uUQZJCF1ZfyAl7IgU0YwaqIouQo4M8hD60ziFovK5BVW+CMX
         hLSXZ9kNVZhqmbpxfmshp+7dT/c+/unql56SCLNFs9cjk/FWUBwxFqFlcTsK2S1KVI3k
         ja6BXPI3vmMfOE+BjfinYhhwBWR3MdXkGV6bREaCeeosev3/aAcui/4LHk172vXgBQuY
         qkaE815iwfYU4cy+LhK92ueUWgyD1EGb0HYaMkWgbFxKDKF6HJlRS9GFBnHoz3k1e4BU
         dguglAmpoEo8L0CVhJPTBJ1JrMF46O6DxkHZ1P7vw6+XiadEZpHLf70o0CUJOXa9lLXB
         o1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717053705; x=1717658505;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8/QAGThXXqRpgUxxoIaOU5K6OSx6jfN3zk+amiGP2A=;
        b=hO59jhf90aqgk8ASkqEpTCoOLP5j3jd2Ql7ETpTx6xzbtJim3Tz6GLmIMiFAu0ti2f
         9VRW5/h3hmjZq8VqiWKuXEt6B5yk49MoWYl+uUgHtkcLk+C/cxZ+zcxk8r52vtOP3943
         uATlRyM8GTG4c1dPzd7x62Qb1BhTV/xO//YTGGvVf+YcTfAbjyT7rIT/jjT0m5jj6rZ3
         w+lTb9fGVLXdPZNcsYp9Vx+yGrnyVYYwPwX5DaJLld9v5H4VaXUeDoFY8mEpzvp5w1pq
         bPceFNqy9XtI2x+3hwEZqPcg6CEHpY5kgj6djnM4hVprjTDHXoP9u1EV+IxgiCRAkVyA
         0S2g==
X-Gm-Message-State: AOJu0Yw2wvJg4pL1A4JAXLQumYvWdTmkxa1Ao6o1fZdo31m16HLuWNoT
	zRZ85J1BvzOmm8iPQpNv1GM97qhikMrZnKQo4awImvuFyFw5d0AyRMbSnw==
X-Google-Smtp-Source: AGHT+IEJNm/UauGsnkRIEucswM8kZrLwI2yRslMi8VNw3z4BEL8TvRcc7SxtXdICqhDloDiYnbSLWw==
X-Received: by 2002:a17:906:110b:b0:a62:ac5f:f95d with SMTP id a640c23a62f3a-a65e8d37203mr158710766b.14.1717053705086;
        Thu, 30 May 2024 00:21:45 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a626c81795esm793914066b.6.2024.05.30.00.21.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2024 00:21:44 -0700 (PDT)
Subject: Re: [PATCH] udevng: fix tty subsystem device on usb bus detection
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
References: <1717053338-2765-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <2743b75d-2d98-6dcc-32cb-b8a5727ef0d2@gmail.com>
Date: Thu, 30 May 2024 10:21:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1717053338-2765-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hmm, scratch that, it is still not correct.

I wonder if the logic change in check_device() made by cdd58360140a was 
needed at all. Perhaps that part shall be reverted and only additional 
check for mhi shall be added?

Regards,
Ivo

On 30.05.24 г. 10:15 ч., Ivaylo Dimitrov wrote:
> Fixes: cdd58360140a ("udevng: Add mhi subsystem detection")
> ---
>   plugins/udevng.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index d3ce3d5..891412d 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -2509,8 +2509,8 @@ static void check_device(struct udev_device *device)
>   	const char *subsystem = udev_device_get_subsystem(device);
>   	const char *bus = udev_device_get_property_value(device, "ID_BUS");
>   
> -	if (l_streq0(subsystem, "net")) {
> -		/* Handle USB-connected network devices in check_usb_device */
> +	if (l_streq0(subsystem, "net") || l_streq0(subsystem, "tty")) {
> +		/* Handle USB-connected net/tty devices in check_usb_device */
>   		if (l_streq0(bus, "usb"))
>   			check_usb_device(device);
>   		else
> 
