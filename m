Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A4A34
	for <ofono@lists.linux.dev>; Thu, 19 Oct 2023 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8WZHAKw"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6c64c2c0f97so4580509a34.3
        for <ofono@lists.linux.dev>; Wed, 18 Oct 2023 19:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697680813; x=1698285613; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUc7WAQ14/v6tAYSO1lA7KrqfDERmnOXfjVJHMp13ag=;
        b=R8WZHAKwTzDLSZHHEniO3UqB6UBu3vflVLivxmH7ZhAgZhHpHeJEeJoZ8jp10KtBMn
         Jl5wHiU+R7ianj5V+si7nnGI88OmMD+Gn3EeJoglcBbNn0lITqizqRcERB8Oh4Gytkmt
         72sHRGaQpMD07VZhF0+WHQnWJoTB5FjZZ6bJA8kPbeu/6je/Dwl3HEo8Qq54wCFPbuMz
         jkBU1ruGCdfGDw9k6OpTbt+65EVZEMfwzWbvkmxk/6vwjXMBq7jX1P+GudnoGCiFnkfw
         eSc01LiGPJwiBDSQppD3W11UDya/ARMOmDKcVPEhcwPNXMYnG8oNlJFCxtoTog5QU96p
         ++zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697680813; x=1698285613;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUc7WAQ14/v6tAYSO1lA7KrqfDERmnOXfjVJHMp13ag=;
        b=hBp2U+fDxwBgaVTRSO2Vn2IgN/OZWKhYowEOOI8CaSld6PzksA6ajT01lGL7+U2M5w
         qfJHxF2iYeKYAoEcoF1wc2oW+yl/gE2dkUBa00zAMo9HTHEz6AjiOsO+3Dc/wUi+sOeR
         h8AaONmJwMa0NGH42lpsvpnbDcC44hXqUicm+S9QcxQoluBHgwKrZpWH/JKqNCx65ZgU
         o/mHY3AG+qTtXtnAirFAWsFXuT6tZPKtBKq8f5/AOvUMRvI/L4QbFT2jh0hdXDpjrDeD
         HbjSFKDFPr+FWzNWGdFt+sybSI67p3ZP2sFFH9G5mOIwymQDcQ9sbLDwN6n6PraKb3YZ
         wNHA==
X-Gm-Message-State: AOJu0YxiRFRsmzTmGeG0YEzsYfOJ2lELuvZW9jYtfM10U9wiC1/ypTdu
	CdJu2PZHmL1A1Y3xdGDw5BSjTBA4hgI=
X-Google-Smtp-Source: AGHT+IHoDhC0Vtephrk/fVchLGHx0ozXUaFu/7flIu/MAlKO/pDwJ+G/NzeTTaHs3TwubYg658cqqA==
X-Received: by 2002:a9d:62c8:0:b0:6b7:56d9:533 with SMTP id z8-20020a9d62c8000000b006b756d90533mr945595otk.28.1697680813171;
        Wed, 18 Oct 2023 19:00:13 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w26-20020a9d5a9a000000b006c4be829aa8sm11258oth.44.2023.10.18.19.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 19:00:12 -0700 (PDT)
Message-ID: <2768fa9e-2833-4397-8242-75f40787a124@gmail.com>
Date: Wed, 18 Oct 2023 21:00:11 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] plugins: quectel: Add radio settings
Content-Language: en-US
To: MaxLyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-7-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231017104902.717947-7-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 10/17/23 05:48, MaxLyubimov wrote:
> ---
>   plugins/quectel.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Patches 07-11 applied with some style fixes.  Please double check that I didn't 
screw anything up.

Regards,
-Denis

