Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA910EA
	for <ofono@lists.linux.dev>; Thu, 19 Oct 2023 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuaBxVFc"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ce2aa642c6so39044a34.1
        for <ofono@lists.linux.dev>; Wed, 18 Oct 2023 19:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697681615; x=1698286415; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lidIw+gSVpP54WqEtBCPv/D3PiRwoVB805jrB7uTLmc=;
        b=MuaBxVFcmYUYC3iedCYidIJuGr0q4kEaPybIKoJO44rvWQ04mRRm0+V7FonxYHVZw2
         0hv+7lg1jOLBYqyLA7viOVVG1ZUGNjJq5nvjX7jjcPQeX+61ksXo/jDNEKWPGOKJkAv0
         TrsIWDkwXBKivCGDuWwvKg8ztfUm8Rw89fl3M0LGCGm01szaIMNY7CX+wbCGRaWk2xor
         Zs1sFESRSJYMHf0Lrq49PvLhN+MZdgV5oMB9lx/61Acu1Thtly1O6jV/1mvOv9n1Al4+
         8cK+uAMtC7fmLYxn4T14c7FzGqMvxUM9J78nxvQFwyz2/FIrJmeny1x5WkWwQnZ+cCD5
         O5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697681615; x=1698286415;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lidIw+gSVpP54WqEtBCPv/D3PiRwoVB805jrB7uTLmc=;
        b=ouBu8R4pldFQnQ+5PfYnGdtV/5yiySRbEEsuog4dgqQA1Zd8cZzCV6OeboUYnfZQZ9
         zUl9B9V4cbtKGCxJLu8mMHXHoVQpSqaDfpPsfjDlvDSOI09eEeemfi6LdTnuKYJo+wEX
         eXnb6tv4P1za9dHMGP+MCd+RXx6ELLTJbkqJKXMU+9FcNp5ovwWKlwVvqRkmATvF/+e4
         WSvCgEMmuWC63u+S0ZSCcgUKW6gBkUqdRipARRndnum1RLGArFHxuR9e7GOBBFTy+3j1
         AFpgVytZhSHJ0nXyqO7mZSHNUPuAvkARxLaxUzAKQHKRrSCiJx4rPusa98guwJHQ8zoB
         pDqQ==
X-Gm-Message-State: AOJu0YzUuSqpER3mZWCEmJUyikrurlMXEKKEgSFr3NhXtAVV9reGRFf1
	X1rIyD/fKFnkhdbgPskTUB4xCQ0ubrQ=
X-Google-Smtp-Source: AGHT+IETxC5RKvvgkbEFi7U4uHPVNDglFNx0tlgodO8nHU35RdKHSdklWkAtWCTJGRw37KHM+xXjyA==
X-Received: by 2002:a9d:63c1:0:b0:6c6:3ea5:cdbe with SMTP id e1-20020a9d63c1000000b006c63ea5cdbemr1140783otl.18.1697681615094;
        Wed, 18 Oct 2023 19:13:35 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h6-20020a9d3e46000000b006ba864f5b37sm890258otg.12.2023.10.18.19.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 19:13:34 -0700 (PDT)
Message-ID: <2ad5ffbd-7ad1-41ea-b237-4184671a8c02@gmail.com>
Date: Wed, 18 Oct 2023 21:13:33 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] atmodem: added context deactivation event handling
Content-Language: en-US
To: MaxLyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-13-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231017104902.717947-13-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 10/17/23 05:49, MaxLyubimov wrote:
> ---
>   drivers/atmodem/gprs-context.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

