Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E3243364
	for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446510; cv=none; b=nFWeCGFnzFoK59ZSd1A3uyA5bUVB29Q3Th+Wf7sWwfx/xcjiMNmhn9JyrbsIzsH/dYgjg3Bh69xDms102A+PNsaG6TwfQQB1CUJF00H8a9QqxpnzFHSgQEbqo9+T5fN2fIbQF0LIRkW79WuhPcprXsGHuCobjyqGEIu6oHcVGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446510; c=relaxed/simple;
	bh=wv37YDbqlBE9HpLIwuPOWSXg346y33JpOkUQAdfWqYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nF2jfIgYWg6eWmu6HGdxh1CZnVOLsxEUzXQ0tMvuKf/P8NWH4sjmIZzltIT/gAOdNQSH6TeCOVL3mTsA4C5X8SCQWC3Bu6wPHNtOvxMXrSL5aj6dlXQ9hPPkoGKYuduKAai7331M454vDzktbo06QIMiNZEdsgOqzlCHlzxOW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drrOcS7X; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drrOcS7X"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae3a604b43bso324555766b.0
        for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753446507; x=1754051307; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReNa9pkEAm9k2sG3VfcImE+OWNYur1faOo9evaipkuM=;
        b=drrOcS7X3+UDK/uTxy6mnL5q9T/ft4t1zIUeIEW8AwaobXsYx0Mw4Obf1vwiAPy9EM
         uCHy2Tp/ePbwNTrrzmARIg5NwwlFgSIDFasi1ArT3J56ThQbORklYvLqj2i/Y+oKmWsz
         oz+9dS1llr5J37QLbgKmWvauP/nnbIHctEI7dnsLSYmIGwMW5qYLvkx2tmyGEN0L5tHv
         pGoH3oObhO/Ngen7UL9gDAfNJ16JIlFwD5cMS1hSJ1CrZzaNAxwjQu34Kp0rfhi5gzGj
         N1kHCgTCFrwNdUSYVg+LiP1WUsJLE5MpmPkioQXaHwvd/3TdXFm6cBVtQt3Oi3svU5iZ
         jwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446507; x=1754051307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReNa9pkEAm9k2sG3VfcImE+OWNYur1faOo9evaipkuM=;
        b=MiFkflBr6q+KMBAlEI+c0D4xHen0FgYB3ePkuZtNQRWYxRS+EnkPuH012E/N0d63we
         4K7R2Sf15SFoKJUFeyVKVX5h+7NmCcVAsgoUCRxGtNeOl9pULJmkSgw4fycXbesUII+q
         J7/Rr7NYSUD0IF5qSoZy3ZVaShE/wQbNN2OxadN54IRvUTyb4Hsh3wkIsKPw9Or1QEzJ
         FsuNKf3zpXBeSxzBRgW3UPInWZkj6iWCksTYuKG9inUivb6bx7Ai2UNKdbS13gwp9avt
         UwSg6P0QjliHLKFQ4HUdLMayVqePenXjSH4J6jy83i7eIOp5pOBZ1Cgy8QnVsRtlZo3M
         oiVA==
X-Gm-Message-State: AOJu0YyYISmBGA3v/VWrhi0Mj0h8zSpH1orb2nMvs2qLhI1N5uS7A1y4
	YLfJH5Wrx8JxcBXiRCeqvv0lUP5tZc3d6QPzkZ+3d/feIeEaU4oPs4ICRQHgVQ==
X-Gm-Gg: ASbGncsGY6Vd+UwJt9NYuYq5x1m9uytMPfd3INNLeOxZLtRxVlOIa5rc4PuEDlbDdDk
	+LBxXrq0lQIXd6OD+RRikmZ7eoVBjsz+j5VG11CYRbafewfZQG1SDsEU3+1cBzObtdptDK/DuWF
	54K3gf72G2lq8T24W0TqqXaGD6l1+IARcsAIrHHu02b55Cg0w4n4FNHD+tBwn0dWXz74mMiJzaK
	LuoLMfGWtrggsKbMkNkyoQLJZbs2XCW1YKFKXJTWNZBFZZUIvpxh+Y8ro6+5vMQDIB9tqV2YZW8
	PMrCOJk9jtEORCZgLXpiUfm5IE18vNxfr9tNF8M3AiBNeijXw1CwjO5kMn5whmxcXfHqOq0yLtB
	rp/UPZdJa4y4J8j1aATLsXx5ts5ZcPmRZzNc=
X-Google-Smtp-Source: AGHT+IEPJr8a+mHvmd+cPIswwkdD4Lu+4IoGIWNDZPfHkvQEnY48plsReCc7Ryet+yBdlHxbkuw7Aw==
X-Received: by 2002:a17:907:e8e:b0:ae3:5d36:aa6b with SMTP id a640c23a62f3a-af61cd9d202mr216231466b.36.1753446506503;
        Fri, 25 Jul 2025 05:28:26 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-af47cd656e8sm265433366b.55.2025.07.25.05.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:28:26 -0700 (PDT)
Message-ID: <eaf6f232-030a-48f0-93af-9dcd296a5152@gmail.com>
Date: Fri, 25 Jul 2025 15:28:25 +0300
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] gobi: PERSIST_LOW_POWER instead of LOW_POWER when
 disabling modem
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com, absicsz@gmail.com, merlijn@wizzup.org
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
 <20250725121954.650668-2-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20250725121954.650668-2-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.07.25 г. 15:19 ч., Ivaylo Dimitrov wrote:
> We don't want modem to auto wake-up when

No idea when the other part of commit description dis-appeared, anyway, 
I can send v2 or just use:

"We don't want modem to auto wake-up when disabled"

Regards,
Ivo

> ---
>   plugins/gobi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index 52ead377..027c4dba 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -442,7 +442,7 @@ static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
>   	switch (data->oper_mode) {
>   	case QMI_DMS_OPER_MODE_ONLINE:
>   		param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
> -					QMI_DMS_OPER_MODE_LOW_POWER);
> +					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
>   		if (!param) {
>   			shutdown_device(modem);
>   			return;
> @@ -922,7 +922,7 @@ static int gobi_disable(struct ofono_modem *modem)
>   		goto out;
>   
>   	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
> -					QMI_DMS_OPER_MODE_LOW_POWER);
> +					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
>   	if (!param)
>   		return -ENOMEM;
>   
