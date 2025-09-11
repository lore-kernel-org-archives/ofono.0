Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21CDDC3
	for <ofono@lists.linux.dev>; Thu, 11 Sep 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617742; cv=none; b=gTCMpXIwpmnwjxn4y9LGzaTWdY+1L8mrtCCuJII4xZIqshtLDtdogTs3yZCiFGBWOE0/Rh/EpfBL/9I8fd53Fmeqcq40THt96rOkNMACqj0R/RdKzENzEzUX1swJL0bEBtcrp8hVwFz9+CwuGFhdJOMFQbBKhno1y6RbmG/wxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617742; c=relaxed/simple;
	bh=TQ2hHIlCyvuhbfamhygGfm6axnUNh039FzG2NZk53TQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEvSACmLqOaKyO82o4bOeRt9JRaScpYSS8zV2wKYo2umX1OSiS+6Oy/9LnxwlbCDI4BCVEmJDu68qjyys6HZevobwxEpqteJ5henIrxUjcENRLJkRoTiKwYYS/aY4a1CGbgRGFVC/A0d7ncpUZZdo0W2qiZI2lMdiQMAHtz7oHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/aobXYO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/aobXYO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso13780605e9.0
        for <ofono@lists.linux.dev>; Thu, 11 Sep 2025 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617739; x=1758222539; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akDIlXZ7y+h9pA32D8iuSn2QKDcVJ1GRqzkBLlO4uQw=;
        b=a/aobXYOqq7OyHMebkjAV7OkZrWFtMlg0mCO4Shx4EHmAqcgMQRwelVzpvTcOJLGZs
         nUgCtO642Nf3xdgJQKNedEdq30cIJ2aRVkwe9174dkXZZvRZHPtsbfgdx/Zd9wHixX1R
         TaCbdgoN7DNz94980uyv40AyeRVtPnTLbjxUwdWIVeDA68Cd8e6o5C9o9yl3CQS4cXG2
         kRw+tDP30i1OHbmcZn2onUkjI6CqU6+q9UkmYkVHgOYSUMma8LbHYz8l4RW7T3slF/zJ
         0HQnnKQZPqJFjbBqipOizPJg8s/eLRcJP7yooiwkJ61WIOaeyxh2v10c98poGhhsH7/z
         YNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617739; x=1758222539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=akDIlXZ7y+h9pA32D8iuSn2QKDcVJ1GRqzkBLlO4uQw=;
        b=mYlGlzkO5bwzDwx7dzFh2R3FmSKFkEibjGPZ8SHjzYUEzRBw7s4x9Xh6Eu//vb4XFp
         +O90VoyYVfD9xvfOBNPZLDNVNGIXXKFO3DQZEcLdQFFd72Jgh/alzbYE3DqMiJjFf1wz
         Jqg3HLJvLi0eoEeLm+XqSjHbWPAVuqsY2UlPFOEmYPZFojnBuIezOtUB0mgM2bHT3B6z
         v9mUh1A8jbBli5DsOsopsWng2xiV6u/GkYCnQMMkJGjAcpT1GM282M/jStzeMR1h37cR
         crvipj88kI9+I/TkdQqyuKusnRghMA/S1abOznpmEqMHbN2uGHGkRlAot0J1CHHalW6j
         0SXg==
X-Forwarded-Encrypted: i=1; AJvYcCXeHxUAXdrviNT5gsC6TSm3COWLwJHOqm12wV/ad9ltiRnEbH7liEnPReKeG2CddbooKzw5oA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEuMnT8ILKz2EFKsenZ0hlc/nHMl7INW3pG7qD3bxyrcaMDrm/
	/roYZZXUz54/glpYfn3uw7A+TFEEcvC4Clvq4At8VYs6Lt2l5y7gORuz
X-Gm-Gg: ASbGnctnCerTeCkC4W/665Oub5FbSsxuKYfGvHxStlmTqe7CHxB6Ijc5qZbw0LmrcWO
	sohZ9UYrbxaxPcLcGoWjNGyoX+c8nLyETXqa5y6S9VVUgKReLujVTJXZytWaQ96EDbDf6jLa9f3
	aHIox5TpMhdb0jqPe86MVJd1+fEefF3UEsMsMCIRynZDNa7mJ1ZoSG5eNwYthX8zYMY4Nl7h12L
	CArJx6e2fJhxO7HGAnaaS6sugLb+HMXkK4F6dcI/HzBJPUOXvOw0Gss9CchNQLQPT7DVdduKnhs
	YfYONmlRrhWaf6YGvAm3uyiMWRxmrJPFaHyd+ai0K00qmz3LOMLDa6izWpHkbyYF1MZYYfA/j9N
	ycLHnZFFNumvUUXfPTMapiyQaI574JyeU
X-Google-Smtp-Source: AGHT+IFDFGduiuGexcl8OKVHS6W+6LgZCMbCzpvHU+dEgVgaO2NoxHSVzaWU2o0bnhoyXrNoPIw4lw==
X-Received: by 2002:a05:6000:2301:b0:3dc:280c:51e8 with SMTP id ffacd0b85a97d-3e7659f3b94mr451821f8f.15.1757617738946;
        Thu, 11 Sep 2025 12:08:58 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.242.93.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607ccf93sm3560969f8f.38.2025.09.11.12.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:08:58 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: adam@piggz.co.uk
To: Timo Ketola <timo.ketola@exertus.fi>, ofono@lists.linux.dev,
 Denis Kenzior <denkenz@gmail.com>
Subject: Re: Quectel modem ceases working
Date: Thu, 11 Sep 2025 20:08:55 +0100
Message-ID: <2784629.lGaqSPkdTl@adam-laptop-hp>
In-Reply-To: <fc280e2e-5707-44ab-956d-0bc7d9ff19d1@gmail.com>
References:
 <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
 <f5606785-6f7d-4363-93e0-39696bc30bed@exertus.fi>
 <fc280e2e-5707-44ab-956d-0bc7d9ff19d1@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 11 September 2025 15:43:55 British Summer Time Denis Kenzior 
wrote:
> Hi Timo,
> 
> On 9/11/25 7:45 AM, Timo Ketola wrote:
> > Hi Denis,
> > 
> > On 10.9.2025 18.31, Denis Kenzior wrote:
> >> You can try the following patch though and see if things work again.
> > 
> > Yes, it works! Thanks a lot!
> 
> Nice, thanks for testing.  I cleaned up the commit description and pushed it
> out.

Is this likely to fix the issue I have Dennis?  I will of course try testing it 
when I can.

> > Regarding longer term upgrade path, I'm completely on FM-broadcast-band
> > (finnish idiom). Is it Qualcomm/Quectel FW or qmiwwan Linux driver that
> > is the ultimate culprit here? Or is this modem completely deteriorating
> > out of support?
> 
> My comment is mostly about the kernel version.  It is impractical for me to
> test changes on old kernels or to support legacy driver behavior.
> 
> Regards,
> -Denis




