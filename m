Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3070CB3
	for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407926; cv=none; b=Azzkm8PCGwSs1fIuCpM3n3A8Kx2E2isDSNwL1zLfIzoQ9CLFPi0vLFThNWalVwTSVLJtQ+pKo1Qd7oXg2sVKzBrsC2jOdb9yuN1+7g3Bzn0436SaQc1U37DHk5XLWM8Hx8Pu+Iff6yUy7IB5eU7t4LWA0fqgVghHFW/brIZXUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407926; c=relaxed/simple;
	bh=KqxwqdvhI5JyEnvdxCSi8UJaqukCIoC6wP7m51JanL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dwXGwuL15wXjWxsMUakq7c5MbXZE2WrrEfQBMrrsLDPwRB/pGDSr8lGPZRHpnaokaLZkORy8ImfIuPdI24Q1JjRpo55N8tYmTs0isbdFiKc54MRo37PvBu+5uxf0Q1RrPQQ53p26JLQ8Uk4qi8frnb6SMOp5Iq5oGHVEorIwBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwgOr+Q+; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwgOr+Q+"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-229cbc52318so2192741fac.2
        for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 16:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711407924; x=1712012724; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfoPiql/VfyGUoozKl4Md6EqWN4wOcHW7I2coQjniak=;
        b=RwgOr+Q+ZKLY/TVr2tmHEp8AdopJY4Nyoup53LibRx05b/Vj8YJHci4ce0y5YRymIc
         BoeXe27bDcOJjsOCHSbp4YH6lnatCIeP7RTlm3wB2plURi35AFo+0IeYdBe6evMjPIeL
         36/kqjmxVXV/yYy0C+aPBlq7O7gCFBM4gz3jYT1qt4pJpDQCKIeiOcoHkc2k+2hqMGto
         PSy5vDeh9JYeYi/8wq2KOP+hiIgTGAZ5x3yjdAKByx90USpBUwN/62Md+Hwud/z8ueEh
         eIj6M7NlQEeBXzhWMB5woVH9GrB0gl/3FUweXO5MNTUf3i/fQq+6UbUGOKjbtWVYxxxD
         TCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711407924; x=1712012724;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfoPiql/VfyGUoozKl4Md6EqWN4wOcHW7I2coQjniak=;
        b=qX2P4SpOTbC1xhBpURNa/13iDg6kBzJAUe1sRIe0vLX3hMPQqSBKzLhT+lifSphBwe
         Da03ZZWkBnjIOiA/oAGS+WZhJ1MyGbQgCbF8DnuVK9Se+Mvzj02XZrE3GLPEWifzjPpz
         RaJjnHLPDQx31RuRhV6OfYWt2ZKaUQsMILjb538Q5jkwusGEmD3/X3nV7zyGpGDjCfhz
         pQ1WftDtD03jRDnkR3ua+Oruq90XDQkUjKIqvLyzUWo2+sCdB7vUU3VyRWiRT75pXjYP
         90CTjqdwa1rwp0yQ0JoRURRX7dtl8QQxeYKE2OqMYXYBuE1dZcg4ro1Bj6gLwSSWHwP1
         v0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXMZqdF1M+8SAWyBa+R2I8VEDopeLM8wEzC4d8OqBasWGjxsyIMjujMNmhCcRfbeRkJpN1ugQjSQh2KDwZFjKR4TL29WnM=
X-Gm-Message-State: AOJu0Yxxtd1SDyX+r+KZSWqD0a+Z2muMnpaberCH4XqArCobLBKIWO7/
	0/zEPD72/4ISvey+Vln7Vy/HL5J71ygwN1Wurr4p72cLcqLEvnFx
X-Google-Smtp-Source: AGHT+IHCzQCppKhUS/lW1OWG7JHzGd7iN7Fhlzu6mo2fb1AkYSH66nB+/OprlOeYTX8RG+tIaAaefA==
X-Received: by 2002:a05:6870:e0c8:b0:221:968d:fc9b with SMTP id a8-20020a056870e0c800b00221968dfc9bmr9652861oab.11.1711407924377;
        Mon, 25 Mar 2024 16:05:24 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l5-20020a544505000000b003c3d6e9f15fsm168601oil.24.2024.03.25.16.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 16:05:24 -0700 (PDT)
Message-ID: <3c148086-1baa-4a72-83b9-c3d0fe0a8b5a@gmail.com>
Date: Mon, 25 Mar 2024 18:05:23 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] [qmimodem][voicecall] Implement call dialing
Content-Language: en-US
To: Adam Pigg <adam@piggz.co.uk>, ofono@lists.linux.dev
References: <20240325221742.5931-1-adam@piggz.co.uk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240325221742.5931-1-adam@piggz.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 3/25/24 17:16, Adam Pigg wrote:
> Add voicecall dialling to the qmimodem driver
> Includes required infratructure and setup of the QMI services
> ---
>   drivers/qmimodem/voice.h     |  51 ++++
>   drivers/qmimodem/voicecall.c | 506 ++++++++++++++++++++++++++++++++++-
>   2 files changed, 555 insertions(+), 2 deletions(-)
> 

Hmm, have you rebased on top of git HEAD?

CI seems unable to apply this series

Run git-pw series apply 838112
Failed to apply patch:
Applying: Implement call dialing
error: sha1 information is lacking or useless (drivers/qmimodem/voicecall.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Patch failed at 0001 Implement call dialing
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Also, I can't do it manually on my end due to:

[denkenz@archdev ofono]$ git pw series apply 838112
Failed to apply patch:
Applying: Implement call dialing
.git/rebase-apply/patch:92: new blank line at EOF.
+
.git/rebase-apply/patch:652: new blank line at EOF.
+
error: 2 lines add whitespace errors.

Regards,
-Denis
