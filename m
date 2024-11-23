Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B13C466
	for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379286; cv=none; b=U53KOgFE9itvQfEobzais+pw0xEeqmW+ttiQlh6lwiU0lrjYIXd7RTbY5X+2JphctkKD6kKKZfQSVGZCoTyWBCe3DipkQ53Aa77KqT1+C7ZDaa2VA0hrQX+rVZ0Zm72gMav05IvrNLiICFAgNOGUBNJcf/0HE02JaW2U/muxQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379286; c=relaxed/simple;
	bh=Hfpsm7Dm5cJSRepa8NN+SMGAtq85+ZbmcuaZ4jHaTSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OclOujfVLP/L2LEVa750RZ/1e7CkLzWhj7Vrs0Hi/Pb7yMrl/XAcYg/q+nRyiIB6AYg8LLsMgtfwvuptUqilP6+4Zr7dbMDwQ1xP80NSYoH+om94x2t/uLWGdj1EWzqx1TH1F+mQer/kOsOXbSiUX2I1llVGJYTNAtiAl1m8GJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d27NlNY8; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d27NlNY8"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29666708da7so1998257fac.0
        for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732379284; x=1732984084; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aNCDq860HkAAYlcgr3Hf237auv/2Fo7g3rieZPO488=;
        b=d27NlNY894vnbbmIql9ueaziGsAnbmsVat5yRymnxBU4PSzY1nL8+jJ/AU5wm5AAC3
         P56HLH1VXf/2IdxWCndcm9FZ23UDRmtLkjw+NRcP58JBhRfWIZflf3g/Mnbnt+52J/7u
         HfI8p/2RsHSZ5KLOPaKEZNQzjhSbdplybYqT5Hi20LJ6DEKZuRvPUJMFt7dOJemmop35
         7ZqlXul5nfEk6eRgqxJ2x3FHaRJqdw+RgYkGvqzPDiyXZ/gP7FPocAwDrknd4zDorN8k
         1FNRiTgBBMo/I7lS3r0GKCV2AbDmMBjRgnChKVh2yBEl9ojC6nu9pH30MFe0wpXeBS3G
         GOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732379284; x=1732984084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aNCDq860HkAAYlcgr3Hf237auv/2Fo7g3rieZPO488=;
        b=nyOnholfsTh1tY0GBezCcaCD+ivoJGxwfuEt92YqReRdrsKJj+3hLsKtEQB731J0db
         2HEqfRJEdoUFaP/pxlhgv5QiOmlpN4jk0GhVQ4pyWBanGFMiJnwu4CX42jmn6vVxlMUh
         IQmFTA9OUdLShbv/S+0t81zK0OOHfzIQ9Lhuyr0GJWGnN1eIzcJ2yMtXP4msR03o55Ta
         nxA0XQS5UcSNvMYmciGEw9f/WsbLN2utUNjEpseTkfVwh/8O2vJeP29oc92Iashkpmda
         g9HJs0WqjnzOdS1FOz+6pmBDkYpbegSlC/K8jUVyVxDmMwYPkjkXPzLaUEyO44iJ2g60
         xXuA==
X-Forwarded-Encrypted: i=1; AJvYcCWLtWX9+eR6Y5POlNzWR6hPP1BlZ9wQGuPYslcA9MqV66eC6XIDWkN21uuuEQUZHjK6MIhWxg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxnil3Qpk9fow4T+NYsTM6f21ooPExAgVeQKSgMuRczmqwEUuME
	T6SbWKlkwei3BJ3w9xR0dzUzDFeMvVPyqbatHrgwmQKtSYvmHW4x
X-Gm-Gg: ASbGncuPoj6T8vmxUXbGAbKJpPZ1ZB9wQA+9Y9RtD7ksruUKTd2BXLjd77qCO7EquBK
	Na9pKKY69Gp4Us+Wfa7++SWvV2cD2f5zbnHdxVYNwPIsJeV+Qb9ZPKghQ00SKKPknpbS5VHitkU
	atvJiiGYzFybqWH6n7Too8Z1/P/BrGpA+F6gflC2O38v1YNfBCHNSRP3ksnAJCdLf6Plt0JG3N5
	FjMgFsoa6F0icLyMMLHL1SQj9Cpll6DKmTzKY9f+DGuRRO3Jv2Cjfdy1Fgum83H7R6/AtduqAJq
	xXH5CEPyEdwK4ho=
X-Google-Smtp-Source: AGHT+IGjIvqKbaBHCYW4Tac+FiTcMCCMWzqUJ5cqaefJrEMJ5b282VyvF04szR36shDn5ko06/vBWA==
X-Received: by 2002:a05:6870:ac0f:b0:277:f16a:97e8 with SMTP id 586e51a60fabf-29720e5f17emr6312559fac.38.1732379283838;
        Sat, 23 Nov 2024 08:28:03 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2971d67c79csm1455910fac.31.2024.11.23.08.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 08:28:02 -0800 (PST)
Message-ID: <facb4a14-63c5-466a-9898-46535d7a5430@gmail.com>
Date: Sat, 23 Nov 2024 10:28:01 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] qmi: sim: implement lock(LockPin method)
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1732352735-31944-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1732352735-31944-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 11/23/24 3:05 AM, Ivaylo Dimitrov wrote:
> ---
>   drivers/qmimodem/sim.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/qmimodem/uim.h |  1 +
>   2 files changed, 64 insertions(+)
> 

<snip>

> +
> +	switch (passwd_type) {
> +	case OFONO_SIM_PASSWORD_SIM_PIN:
> +		pin_id = 0x01;
> +		break;
> +	case OFONO_SIM_PASSWORD_SIM_PIN2:
> +		pin_id = 0x02;
> +		break;
> +	default:
> +		CALLBACK_WITH_CME_ERROR(cb, 4, cbd->data);

You forgot to add l_free(cbd) here, so I amended this commit to do that

Regards,
-Denis

