Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BDF165FA5
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714597288; cv=none; b=XCmfiIw9lVwYktxU7A8DIrvUFFOFfC3qbFtVfOm4cxHY2FNBMGliBKNMtf2swjblRaLm294w+ThuxAsHAI9lLTSTm50zNyi6/7IFc1SV/6jd2qWnSMzvn5ThCMVTU4jy0EJ22eyTbde/CiUFP5Wxliln2xFGlBKLCXB9GRSkYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714597288; c=relaxed/simple;
	bh=H2WszG0L8DEUYIyoP2cYxLqDwW/KCaKfVU9p/ctiPNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K5K4iPcsvOsAZ5n/EjkGbll9dpkvqaIqieH1/RIvEfqJWjz/hFUGdGEJLThBBkTjNEQ+HbZaAO9XHEngCD1waMSIloLgVedh6xgcBfwNR8fjdf4ZNcBf/TUcPKsrNEmPsGz6WEM2dQOd0D03oFp+zrp+A3FJwQf+CQf8Nb1IzGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdA4PqyW; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdA4PqyW"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c74b27179dso4177010b6e.1
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714597286; x=1715202086; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNiR3JzG5U72+fuyXNEm8dfz7ipbm4xvVw7m77QvEyE=;
        b=RdA4PqyWyxDW2AcTyjKd1fKEM1Zk+T+mTtBJ5vH95HLBL9qxEF9sj/CU5W8JjRNuwU
         BkLLeM/nOYI3NWxwqrtfKKVD0nbxcLh+W2XnwkkfOlaq2xwrBS60rWLHgRLh1fT/Qkyo
         NcEV2QRiMxBri9BEx2k6AjRyhW4dYJkZCfmG7xMe6T3cu0tdk66XGYKGc+lOiDfSGb2/
         /vq9BjBvv1YpwO5iUU+qQPz1Cv1ZerNal5rOjUfJhXZpy01vIEnopHRkM5Lxjoh4K15h
         Ubs5XJF/TrOHLvbjmVmRWQHUOaXVTMEHqSF0qE/acLUfrKMYlwIvJhX3Uyd4KmJsGI7t
         3h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714597286; x=1715202086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNiR3JzG5U72+fuyXNEm8dfz7ipbm4xvVw7m77QvEyE=;
        b=NkVru0iG7j7XqHMygx6WCzyhNHOzL6P8JCngpzTUDzQx1jMNMFBVa7aK5+vskzfHsT
         9PvadMqX40HaYqDfQNzR0/7gSJmt5C/DmLj6Hid4sRLGO0Khj6jVWLLnxxRBjS1jYrcV
         TUouU3bh6bvredeGB+iVEYq2Uuuivno5TKpcxVdugovgOFXVdzedJoFFlbybphfOhz16
         SPEwMmJve5C4nHm9rT3u9OkLgfF3fL2tssLmeau+xuTg3yxtJL/l3vLnWBcpJ5EiZd1i
         shVnCHSD1v5tKGkuPcyiMnZ1EfnxogIz8luyHBMkGxqgfN3eRExbZwR0IRHj2rNoEHSc
         tqKg==
X-Forwarded-Encrypted: i=1; AJvYcCUcXsamBrcBCCQIMatZu6+IME321+W8TMa1UUKkLYUCu1/MScs0pL/MEPWdc1h7kq8V7PiGtuGYW5dj7CM3SONmStmIXQQ=
X-Gm-Message-State: AOJu0YzBC3Q2D0X8M1+tk3Qss3bq7wTdIgvjavXQsisUZNFubjlmL1BW
	zqrQLANLlOjHiavSxjgs/ZL2qzE0WgMpYDZClrM2lMHO0GeT5b3o
X-Google-Smtp-Source: AGHT+IGZw1XSATgDx0z4IOz5rLvtvcGPaPAWcp/pM9aDQpAI45OxnXYS7NcI3TsSgxaBg2jXoqLt1Q==
X-Received: by 2002:a05:6808:2129:b0:3c8:646a:fbb4 with SMTP id r41-20020a056808212900b003c8646afbb4mr4908888oiw.42.1714597286300;
        Wed, 01 May 2024 14:01:26 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id es11-20020a056808278b00b003c748842829sm3621336oib.4.2024.05.01.14.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 14:01:26 -0700 (PDT)
Message-ID: <42fea483-2770-45bc-9744-7063174b9ca7@gmail.com>
Date: Wed, 1 May 2024 16:01:24 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC - Add AT interface to qmi device
To: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev
References: <2269874.vFx2qVVIhK@adam-laptop-hp>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2269874.vFx2qVVIhK@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 4/30/24 4:49 PM, Adam Pigg wrote:
> Hi
> 
> I would appreciate views on this patch I need for the Pinephone modem.  This
> adds code to the gobi plugin and qmi_device to get a handle to the GAtChat Aux
> interface.  The voicecall and sms drivers can then use this interface to
> trigger call/sms notification.

 From an architectural perspective this is unfortunate.  QMI atom drivers 
(drivers/qmimodem/*) should not know anything about AT command drivers 
(drivers/atmodem/*) or GAtChat and vice versa.  Doing so keeps dependencies to a 
minimum and allows oFono to be compiled without AT/ISI/RIL/MBIM support for example.

For modem drivers, I can see the need / usecase of driving both QMI and AT / 
whatever ports together simultaneously.  Such modem drivers would then depend on 
both QMI / AT / whatever support being available.

> 
> This is done in addition to the QMI interface, because it seems that
> _sometimes_ the modem does not always send the QMI notification, or it is
> missed due to the phone being in a deep sleep state.  The AT interface is
> always triggered.

Have you considered simply using AT commands for calls and SMS?

Regards,
-Denis
