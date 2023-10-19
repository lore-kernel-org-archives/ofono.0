Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB64656
	for <ofono@lists.linux.dev>; Thu, 19 Oct 2023 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+rjfqLM"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ce291b5df9so112080a34.2
        for <ofono@lists.linux.dev>; Wed, 18 Oct 2023 18:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697680174; x=1698284974; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7ZRW05Kt4owBPNHCopWyWLOIP16h0qBshNEl2eo64w=;
        b=k+rjfqLMnTBLAcYDAPQuYi4ME8etTnwnS/4lNX4CRT3uIUwMQidEF6Hid47EgwAmzf
         e+7DjYcOZtPNJT1QyhAORmWtm97C9NVKGRNz+l53gqu/25K2/2CoH+YqvLcmuGyZxqkM
         iG1xw5h/5B0K135SFeFsH9akpcHcEfWNSh1JbKziwLVU8G79WNn7Loi0/OYm2K+Jcgss
         FO+UgtBde1OlcLBL1Zbr+QVNMKCwsNIXRJou4VOQI6bnHsG1MG8lFmkKznnF1tFWDzKS
         5Kspu0tTBlLc/IZGLQ9r8j6VkwmcSAnYdsekOxJCfiVKrWTVZQize6xaAbRmjs6ZT8HJ
         nHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697680174; x=1698284974;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7ZRW05Kt4owBPNHCopWyWLOIP16h0qBshNEl2eo64w=;
        b=F/iDHQCa3qOeljQCi9XN4zkp4nrYZPTcGLKv5DlwovPQVriguDVgZeGkhIFtYoiEKm
         RHqUpUpuJVypjO6Hu9yWFWG2p3rnL9g0nlAAGPudKbhTxk4YplNwjB6YjVQvflj34m4G
         r/kovQ0MlXQz4i1ik0gYEJzfejJsEAw6TdR3+LRzett5IQ7q1LXn3xNX2ltPMpdS9Rjb
         8fG7tmAAA3E8bZNmMJ66rX7QrfJT+Edt/vzPuj76K5oTtWd2J5GRsccIMnTENiGHlNQP
         qiZD19/Zu0/92efRan6p73s5vmPc5dJsU3SgbaEh07yStBMexs1WqnjeLhbi9+dA8MRS
         vBpw==
X-Gm-Message-State: AOJu0YxGzvF7rK+HHZyysO23++ipKSwpyxj9JLm8CIOFHOHUHDuaz9Mf
	JFsgjzIpn4llPMUGFUc+VzVf99Vx1ew=
X-Google-Smtp-Source: AGHT+IFzRdFOHCO4NlJLwG7/yWlpqIME0k3dYINuGTIoxYwSBqDVy32T02+rB48WgghCwtRsW7Bjgg==
X-Received: by 2002:a05:6830:13d0:b0:6c4:df0e:ed73 with SMTP id e16-20020a05683013d000b006c4df0eed73mr1087342otq.20.1697680173800;
        Wed, 18 Oct 2023 18:49:33 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e1-20020a056830200100b006c65f431799sm875041otp.23.2023.10.18.18.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 18:49:33 -0700 (PDT)
Message-ID: <e4875896-fc45-4064-ba27-e78c889f76b4@gmail.com>
Date: Wed, 18 Oct 2023 20:49:32 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] drivers: quectel: Add radio settings
Content-Language: en-US
To: MaxLyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-5-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231017104902.717947-5-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 10/17/23 05:48, MaxLyubimov wrote:
> ---
>   drivers/quectelmodem/radio-settings.c | 260 ++++++++++++++++++++++++++
>   1 file changed, 260 insertions(+)
>   create mode 100644 drivers/quectelmodem/radio-settings.c
> 

I combined this patch with patch 06, updated the author info and applied, thanks.

Regards,
-Denis

