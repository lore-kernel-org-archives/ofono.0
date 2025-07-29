Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441343AA4
	for <ofono@lists.linux.dev>; Tue, 29 Jul 2025 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827228; cv=none; b=eVTBjAdHuFArCHFJFCTWdMw9Q8EqwlSYknRbCgALCaq7QCuzROPpNKTtFF91d9dFdCn2lMtrcEJnk0o9L45dYT+Q0uFEBwmfJCnZ2tS+JznKns1aN0JRLiWHuwIRleRnLyZYPp1C8JSXz4i7pFNeFuZcTyBQtjt+b7GDTzJuSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827228; c=relaxed/simple;
	bh=zLPT/2h4LzJ4w5OZFHHXzkmRyEQJ4I6gYcPuaW8IeAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsqXjPOoLskhWiHTvro3wfAycqRgASdfu/1FiqzjbxYLVj5p84+8D6/HpwtsPjCWDWRHQtfzW6NMByHUNPGXaWkbir3sva4MkC71Bz2uq2ZWHZkvbmmPNgFX+JVqlJoHDFN/xhblTipo5omMwzLqku+NHoW11KT7FJAgEf23kGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXZHmjel; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXZHmjel"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-41b4bf6ead9so3523945b6e.3
        for <ofono@lists.linux.dev>; Tue, 29 Jul 2025 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753827226; x=1754432026; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJUE0qoXur5hW3UDtRNsi06Nfs8fmNI4WmxXPI4WZ9c=;
        b=OXZHmjel6qZTCLwJYCu6COijiunsBUTFjV3RQEZi5rPyVJNuV87wsjms695KPc0CYm
         5KdNW7QjKFogxdQH+vzcYQds55xkmAcjVGVsxJsFCx1RkeMnuZRxbI6ST9Y4esvdtvkA
         fvJgYh9Q+qdJ2lBKFOl7znVh1+GsicvR71jZrka1uh5g0u/977RC8pRfDIZAyknCns+2
         CdJLvJfA32ILrpLjJcJeZwB+ICFUhHh0HUtD8g21DBHgpbDO6/S7bvPKtArLCxKuar94
         na+9zwgcHzAaVY06vWNlh2TjlPlipdmNDqXZXRN92csrcqYn0axXWpn0vonO1Fvld7b0
         JHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753827226; x=1754432026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJUE0qoXur5hW3UDtRNsi06Nfs8fmNI4WmxXPI4WZ9c=;
        b=USdZxqhfXRknD4ll9YDGAwiYqtdBSjouisxN5+vuiQ35gVCDb36IkIEolyr0KY9iCL
         a51OnpJ9T1/Jfzx0qk1xJq8ugk8wSLjPbK40njxHeg4JvXr1RLtnjBwnucPk8+FlZHjq
         qNRKsIGvwMU0l97M452Z4ZRYl7KgweptTeqh3MqiVVU9MGZzssBfXXu6y9nf+nDt/lBN
         lSrflfqlh4hveD9q5aOEhx7mjwtlnpgZnutTHmIknDRYMuK9gDHLREJpmIEiWwfnlyBv
         BujbK3m1p0x9lOod3CLb1uHKXIr/95kPmoRUaY2wWeaGyAfuMw+Eda26ZsP08OAHw3uq
         KZhg==
X-Forwarded-Encrypted: i=1; AJvYcCWQCR4tou8GL6ArXeN/5VB6lwf1RaJE6ZnjSMX1xk3plNi6253YeTRxt/296FrAT4FsJ3CgMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx75S/d4x//1r7Pq0tAgyi0DII5Iq8u7ahswJEu7TbN48nBQ/Kg
	igM/rmBK4scmcoAB0jtb++Srh+D0yZ3n5FPX3BrP3DVh+htolOuSrERk
X-Gm-Gg: ASbGncvLWgAU0lfBmzGBqUpmK5yZvjNK7z6iZKoURD2tWYCnOBrRrnxQygYLasBKBMh
	cKzYmZeF9jVhEPAzQmp7LtK0q2L/UsLq7sHJi1+qoZhbEw7qWFC6w7LmvkixcZo2IDbACwLaYcK
	gLcKjfe6RovtAgmNKwiMxjxUlRhp64Qc6L2FzxWvRXHopIN2snkqdVTcxEilfAzHLWKfbUfhIL6
	5OnYmarUZPGldTkxpSLKWp66CVuJFwYa+AzJaGfRDH9kKGJ79EtILrHoMcAEoPxcf5geOiHU4Qm
	Hj2kOo5dSywiHXrrv12X7bLkz+2GTAb9Hj6RbFVtZKZWsgQ06X6j+leqS7owvA9VD/jADHLasCZ
	GrhLQwa3KmOyAK6w7sraOQoVBxbJKRuHa0wZ5OpuGUf3mTiRFcQwyvT1tJdGw+vvQOGyI+oQ85b
	z9WzjwUfztRw==
X-Google-Smtp-Source: AGHT+IHKEPC7905x0AUR9J1hpUIzGZbFYbM0U9c/+uMrnxl/b2C/g0lbvRHBEPGBo7pmPKKBPb5QYw==
X-Received: by 2002:a05:6808:4445:b0:406:7704:b2e9 with SMTP id 5614622812f47-43199d8fcd1mr818802b6e.9.1753827226531;
        Tue, 29 Jul 2025 15:13:46 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-42c7d8b60d5sm1634134b6e.28.2025.07.29.15.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 15:13:46 -0700 (PDT)
Message-ID: <3efff730-91c7-4607-9608-572e1af697a0@gmail.com>
Date: Tue, 29 Jul 2025 17:13:45 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] plugins: drop droid and use gobi for droid4 modem
 instead
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
 <20250729052132.779994-4-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250729052132.779994-4-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 7/29/25 12:21 AM, Ivaylo Dimitrov wrote:
> ---
>   Makefile.am      |   1 -
>   plugins/droid.c  | 172 -----------------------------------------------

Love it.  Thanks for doing this.

>   plugins/udevng.c |  32 ++++++---
>   3 files changed, 21 insertions(+), 184 deletions(-)
>   delete mode 100644 plugins/droid.c
> 

Regards,
-Denis
