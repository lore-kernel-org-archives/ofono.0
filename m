Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3897F2F1FFE
	for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535844; cv=none; b=apL1bGqlNZBaUbx0Gy/5kz25EIHwPYhoqF/kFGk1yzw6MEJdefRZnJTKkRpmqbGE7+AhuS9FPaGeOY3XRL8NqJAe1xK2NaxvC36nQ1HNHJiUABS1o6Y7OhxJhini77nROVemMMcfgeZZrY2bS+oVXi110ARU8RaxuAB2cpBf0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535844; c=relaxed/simple;
	bh=axIVHt552oEVJInSY4xmM2m69uYRbxKzwMiyXGElUUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSHKSgMEJLWDcpMTKhZCzOL4AFSLDTRYySWtUEiTUDkIh/Xc+VXrXEGATaId6QUF2l5UERuxef6pZY3wuVVPTTny5dK1I7Yg/gQP0RW7Hgdwp1X6wdHFuQ26NVOzluaaSt2tN2cKRbsMcJ/+tTBO421biyvSUxG07p3Hh7vfxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6N82Wxt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6N82Wxt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso78925e9.3
        for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757535840; x=1758140640; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=32ej5TYeYCt/DCYMWt0gSzfcfTXOXiikcHm8xmTA7WQ=;
        b=A6N82WxtTyKeSKgRiTw9HKpYEViWMyUxpsyIckHaBxGW+v6RO6eIAkW373uiXAoVQ5
         bntejPBuOO8KtlPET7GM+/xM9IWb/Ew72Za0+GSm3qaS4sxLETnl8YAHKATlVadwMlTw
         3WOWHDmmh9p1oCUTEJdOf1wkgj+BQmqpecmkAFku7/YElkRT+Ja0hbNk/u6cPXCL/1Tk
         tl9B4siy5hOzVRGjGORjEbwITsjMnemkTiKTRRM/ASXcAehCnuS89w+lYNEq4Id5FJUF
         9GAqHj2v2PlcnCediGz+ON9+LxcEO2kG6AQSkeRJQHkZbB5URQj09W5S1Rb0uIgzoDDX
         uu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757535840; x=1758140640;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32ej5TYeYCt/DCYMWt0gSzfcfTXOXiikcHm8xmTA7WQ=;
        b=GuXSYM9WiFa2dU7KdNA+UFcqZL6ycWzqvYaTDXCMLXTLFmZh0ZJhfsTE4tZylpXKBB
         9o4C0pbDtOfxQs4Hv6rUKN2bejNh3k0BU8L4w96u18+7uLyKeSxjTzM1Uyi+1jPFlbIZ
         dbmqX9k+XDkeCs2jfvwLee7RRj1jK3srFqi9qwqKgGYQYqPKkZ41Gofi4GifharfxcFE
         jQWKiu5w1fvJjDJ4rWZ1NesMP3tl3K9oo7d7ruUoMk0+wshjgyDAQ+kDW2Kwsdb4ErTd
         BnKas1N29xvw9Aao5npwAXKVsKVS0ikMO573amacm8HofGDVJ9rsX9D3J+yLHgaz8QMv
         tezQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI/dboG6uYwdz7A6YkwrYTW0lFgOZOPkf3AMbldzeP28bfVprcbw6jMyVtqmdXNHSdLB8W+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYJSkUP/zCvLpHjdLraoQwBDU/sIhsCAf4exSeW6rZ85dMcufm
	eftZE+cmrt2MlPiMQQ1h5ztGH9BYt/TpR5/9eMGGK9xZbo/4kdNy3SjR
X-Gm-Gg: ASbGncsK7us1B8/u8xBMZUAGdh4YIrrvG0tT7WUHoIMZj26P7X2X8bBUaBgYMJE7EVB
	aJwkKjTRMjYS3NZeYzcKiyueU010HlFvPF/rtQHxJ9aA4Jb8eRuRpmcb/55j7us1Gn6sY9q3R2F
	f8L3Z0ZpqAsmegLki+HYRUHU1AUw8eiFekQvXdtaSuUzzA1X/CV04TCrE6k+bYZLS/zL84hKq4o
	kbew54SKLFiZ2he78xSdYGeVZnoTiM43tMoqE0dqYN50ncTAwd5PX52sAAHDU/HHNjNur/xeIa9
	Mn5kW200YoDJ9R1sx9fP3zZ3nmJ5bkcADE3IKlbhaMeSRttgvZ4sSobxi/e9KPPUPq/lhf00V/a
	MvIbmds9nH3nv8IfsDp6df3L3MMquz9Pl
X-Google-Smtp-Source: AGHT+IEeUogrb/+/te8OxRHZ3I/4ZMsJGB3MjJA72AeaD7cuk0i36OuUDBJdZPkOQGm08vCttpfVeA==
X-Received: by 2002:a05:600c:5247:b0:45d:cf5f:cff8 with SMTP id 5b1f17b1804b1-45de2028e47mr147987005e9.11.1757535840150;
        Wed, 10 Sep 2025 13:24:00 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.242.93.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521d88e8sm8114757f8f.27.2025.09.10.13.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:23:59 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: Timo Ketola <timo.ketola@exertus.fi>, ofono@lists.linux.dev,
 Denis Kenzior <denkenz@gmail.com>
Subject: Re: Quectel modem ceases working
Date: Wed, 10 Sep 2025 21:23:55 +0100
Message-ID: <5017207.OV4Wx5bFTl@adam-laptop-hp>
In-Reply-To: <5c6569bb-5242-43b5-a3ba-cec28ae0d51d@gmail.com>
References:
 <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
 <2221614.9o76ZdvQCi@adam-laptop-hp>
 <5c6569bb-5242-43b5-a3ba-cec28ae0d51d@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart27077364.1r3eYUQgxm";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart27077364.1r3eYUQgxm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Adam Pigg <adam@piggz.co.uk>
Subject: Re: Quectel modem ceases working
Date: Wed, 10 Sep 2025 21:23:55 +0100
Message-ID: <5017207.OV4Wx5bFTl@adam-laptop-hp>
In-Reply-To: <5c6569bb-5242-43b5-a3ba-cec28ae0d51d@gmail.com>
MIME-Version: 1.0

On Wednesday, 10 September 2025 20:34:08 British Summer Time Denis Kenzior 
wrote:
> Hi Adam,
> 
> > Is this the same/similar issue I reported in Dec 24, where the pinephone
> > modem stopped working between 2.12 and 2.13?
> 
> Not the same but likely related.  There's quite a bit of variance in how
> Qualcomm derived firmware behaves in this area.
> 
In any case, it would be great to get both issues fixed on the EG25 :)
> Regards,
> -Denis


--nextPart27077364.1r3eYUQgxm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQFPBAABCAA5FiEEr1aGel3+a3VM67n3d+rfHu07OYAFAmjB3lsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEHfq3x7tOzmA5QgIAKcJtngVhic8HiuYceMr
vb49bt9Rs2igkZJ0bA3xowGiz/qmTXSIpLkary9mEup82grMi2hQUw+c62niMK7B
20C6SOrDkAJVGTQWw1xAFL/slNT+wVvmv54BTQkm9WxkrK6nJUJjMAISv6jggB4C
qtqj/3huJkxh6Wv5pBTJSws1O2VqnjSYWJTeO5NJbYEcMCjyHFQr6tY11wUFYWgt
/g6D30g0NKXh/g3lHaHWafDwicFnFTC4jm9hYgGNAVZVRZdgEzfHONH9awrrYhDs
1XEEgX4zt5Jt73jue+wd0G+bxaLZBOrzGpRYPstOPSFNAh88N+WwBEIXQpbTaYiS
w+g=
=49jD
-----END PGP SIGNATURE-----

--nextPart27077364.1r3eYUQgxm--



