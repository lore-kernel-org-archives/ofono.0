Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06710E3
	for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532852; cv=none; b=CX40QO/C7UFGLnDXjK9b4MT8DQFQqEUjfpGwS6mrBjI5jotei0vPxp4j1B3+lFKGWkBg2MPk9XxAIEC3DE05Xtu64Rr6/CQu5Dv5oYJGCTpW1dHr5VxQA+FlI7PrB6HRbczERX0ieObV4MMcOze59MgcgOexGPB6Qrr+o+tTU/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532852; c=relaxed/simple;
	bh=DdIxo0s8sQClDnH6VMaNw4vU6epgz/5Foq8frJy3VWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qTDRmgWQrYRIWXHf+FZ6o/vzoeizoErsYGfWygXs5omh4XcZFWzPGXfIVWWA18unNIva+mAPGv2pfGHohNoAuHEOvzVJgTtJ5J/I3b0RyoFHk57SoujRFYdcGB8lec5QWgdZ3zO8ubWSdjzIpgXCVA9Nu5Hots/yVmpvpKe1RRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewIhytgY; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewIhytgY"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61e73b1544fso3348371eaf.0
        for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757532850; x=1758137650; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhrLDzmM4HaTLcv2W6DtqHlFMXyIiJ2/NeFSx7aiGTE=;
        b=ewIhytgY3jNPG1UkxCRrCAGvte5djL6v/ikk9nz0qEdbN/6/pqZE45kRLb09te6Fb9
         g7mSZkcwQDpIntno+E69qDMkCTA2qKsNPjDwzBeZsLoFelvrZBs40Wq2nO39pWNxfspx
         rZhLsyV8mnnkBVkamobCbk2QV7MMS7yagsaWRasveFd5kRWxKOMQM4lguNmn0+1zksJl
         CmV0G/fdF152PyFm01I/YKNUGiQIm9srTtfl4XiphoQkBZM5meuOVa4sAUJ9nLPRXjzm
         /ZOL+Lgbq9VJnF5c/UmoB2s4XoBlLKR2p9QoeRCxsOyXL8FaeVvENOHy3nmLMmwhi3ml
         Yd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532850; x=1758137650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhrLDzmM4HaTLcv2W6DtqHlFMXyIiJ2/NeFSx7aiGTE=;
        b=Q5tq7OnCRF4FxRcxCOx4qqS3HgwS7/nJJFaI3Manlyle1ywGRWQg4zal9HsRrmf3cA
         NDtERXs1rRoz60zE6CYoOyd0iUHJPs/5JcVQF8SgHk9C58YPhm8ZaCQf3p9CQ151Z1F8
         Zle+VLUGZbti36eZVakqwnHDjfbpoNK4+iUc+O9n2HQxd1OLdNcjqlrabKI9WMXEcKUW
         7fQL5HQmd0iFDv7dDCfMnLbualcVa5wMq/vlieQxzl/ruYZuJ/2jvj8uFCMyfQgXRU/V
         CMKpnKjyRSmqdZ29JMBGnn92wsyrFODVmPxy8PqSTlepfHA4oKAqN0+NeuJ9icOUbiq+
         I6dw==
X-Forwarded-Encrypted: i=1; AJvYcCUkl/thPXnHJOcMwvGX8+3/FJsg4B00lZpG5Ng5AgKMWUcm1PDNh4RCQ+1gfnR4pz5X1lgtsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXmrnBMhfgudxPrEh/qbxh1o9pAbVgO9Tb/T4QJ4NO5hsdBq4u
	IJQG6LGoJ93tdeWYAS8jTgVBbdgj8VlQ9cGha9OxDTjXAvkApkildw99
X-Gm-Gg: ASbGncv73MVBQpqm0vi+MM608AwDzSjfDT1KkWgFYqVRs38o3bFXJJ4XssCX1HxBYYP
	Y3WmnnH9Tj2Z5SS6rVq9dZV60BdYGonmw9OJfS62MPHF0GWQZQtpkH9S7dkTZNtQj1xZtL0Qpyf
	efkliX/XANGAO7T1h/kx3qih0RY1K2d+FGJXJvmNRb6ZYX69SfDy4IHBhkiEgWGz2Eg0m9Ycg4l
	n5EBYbRFhQhQ7AusWhlfhCMR8f7r2YRduTmtLsFkxJC43JtBVSanaqQ58rJkgi4af1O61XY2kae
	cBkSlKhdWys4iuv96EWqWddkThzph4c2iooECxmTJeMLazoH0YO6jGq2l3tL1KHh6dXBKx/GBSZ
	beYHOt3ciIC1YC0anl+pjtqFk6TS1WvdsdoImboP/vvLghjhytquCNfO0OVHwZVFb2nHdjLLk/G
	2fnKeJuzVneg==
X-Google-Smtp-Source: AGHT+IGkbEb2sscPZ2awyZrCrFmmBlIpskVf6ZM+vE7xNZIXyzN+TTaPPB+9IRfkHsexJZYJHuJXTA==
X-Received: by 2002:a05:6870:d893:b0:319:c5ac:c375 with SMTP id 586e51a60fabf-3226285773dmr8607865fac.10.1757532849705;
        Wed, 10 Sep 2025 12:34:09 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-75200e69c4dsm62743a34.12.2025.09.10.12.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 12:34:09 -0700 (PDT)
Message-ID: <5c6569bb-5242-43b5-a3ba-cec28ae0d51d@gmail.com>
Date: Wed, 10 Sep 2025 14:34:08 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Quectel modem ceases working
To: adam@piggz.co.uk, Timo Ketola <timo.ketola@exertus.fi>,
 ofono@lists.linux.dev
References: <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
 <e400c04f-1550-4263-9f21-ce1476e12c80@exertus.fi>
 <379c6d32-28be-40ac-a055-0ebcf13613ea@gmail.com>
 <2221614.9o76ZdvQCi@adam-laptop-hp>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2221614.9o76ZdvQCi@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

 >
> Is this the same/similar issue I reported in Dec 24, where the pinephone modem
> stopped working between 2.12 and 2.13?

Not the same but likely related.  There's quite a bit of variance in how 
Qualcomm derived firmware behaves in this area.

Regards,
-Denis
