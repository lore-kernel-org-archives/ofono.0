Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DE38B
	for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373989; cv=none; b=uxyCxGdVBxOjXzp1XDwPwjJYGL/PYCo+BaTUKceJWWuB/UUIo2DPsf9RGZm2Bgp8fbQOxnFwL/Ye1hFrfF2cFKNOHCEnVgJqEkFqIS4aYpgu249tzRKN7EZy+/Ng1ZFZERVO7IC/+lhIIRrGr91GPuB6z7X8BbQHn4NeUR4gfY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373989; c=relaxed/simple;
	bh=j7KQdI0ShPwswLTbMyZOhNEpWGOQ1s2js9qSnk0zloY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYrR5t6oTqsZLpmLHJ5k9+G+JET4xPhXAee77BFjWC/quHoFXzdRkrXuxzQcrLPPocewzdGWTqIeCYK9xfmrfBCr+kM6BqIDxDo1H/YWbaCO3qltTrT1EpWFV+f+JozJk1X6MK3Wp4SwKnPSsB7S2uUmgYvz35g5vFEm8pVccCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPyqivPd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPyqivPd"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3684bea9728so2784296f8f.3
        for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 14:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722373986; x=1722978786; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGyW3vJ+n0QIKi3cR0x3zVL7ksnFxGeSu8UPWl8ZR0s=;
        b=OPyqivPdCbYyPYUmbDZFm0Q9PMerXrt1oM0hE1PU4dMkr3RI0dufSye0ExntxRNXRi
         53iMdvA1VvjyDru0E8USZIZiOftlNu8+d7hquItCy1d0c0jg9mjLVL6J7J7l5dAKoKMC
         YL8E1HEaOcg81jCAjPRZmZ9ip5txximjaMCFZHccgd1m/7+rtNQtCjvP3JIW75p8e8vs
         OXHSDxIWyUpf5VvWVIA/Iu63LCwjjoyVd00v/fyBX6OY0soI63Z0M4vhtbXK3Xt+Nl71
         r9vLFdNf/mGQ9J4aWdLLZnbrDF0jM8Vg9vdT9euOsOXwyEgmMP6YoLnRczPUlPyWCT1W
         61sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722373986; x=1722978786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGyW3vJ+n0QIKi3cR0x3zVL7ksnFxGeSu8UPWl8ZR0s=;
        b=j/foszXFpHkrNO4u2vV7wJKd9OITJtwY/m7zaETEJVg1yhzN5bqJ9at0YusWgv+vpo
         8VT88FmrOQ2Rr7NrTaS0pFEPk8T0pJd2T9rd5DIBXh9F8PXSoyAZf442hkp3aoMQWiTy
         POEy+1US6pfMuQmtdndjDVOikzsXnVrJRsEX0Yidt+l/CXU2gX4y/+MCTCf6kIyO4M1W
         MOMhrRoX5U7r93p/EVGzsuGgVeean6yW3lQe+7p9qsuuSgyugHiEnLpx/HxtmUNNzmyb
         LRoUjQqreftJYGM1M5KNEX/RyUFB9Tf1F1lRSG62bzUkN8wr9fz93CjJdubfxoKsnWBl
         u8jw==
X-Forwarded-Encrypted: i=1; AJvYcCUnI7EfVDdQ5O11YM9wXK0fn8eVWZErhVis0zaj6mfEaRpzoUM+IybfPJFfcZkWRkM+0afXDggGY1O2riQZO+eIrqrfo1o=
X-Gm-Message-State: AOJu0Yz1EZhKQ66XRpsFzr9th/yXfBp3qd8y09cGxTYdCA+KBDAbTKU5
	wzPIjTTe8k5MmqSMCsKZsE2EDPolmvpOOhhLvHzpcZaJ+x13SYm/
X-Google-Smtp-Source: AGHT+IFvsqhl+L1437rXBkjpnJy8prA7I7ErFHvTezV1wdoJrH3iCdrWu2gF85FrPm+JrxOd3cZpaQ==
X-Received: by 2002:adf:fa07:0:b0:368:6598:131e with SMTP id ffacd0b85a97d-36b5d0ae58fmr8178742f8f.38.1722373985499;
        Tue, 30 Jul 2024 14:13:05 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.246.116.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0344sm15597717f8f.2.2024.07.30.14.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:13:04 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Subject:
 Re: [PATCH] qmi: Allow qmi_qmux_device_discover be called from callback
Date: Tue, 30 Jul 2024 22:13:02 +0100
Message-ID: <3482701.LZWGnKmheA@adam-laptop-hp>
In-Reply-To: <0b03c25f-bf31-48eb-bc92-4a4eac783d04@gmail.com>
References:
 <20240730034738.222227-1-denkenz@gmail.com>
 <2517208.XAFRqVoOGU@adam-laptop-hp>
 <0b03c25f-bf31-48eb-bc92-4a4eac783d04@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday 30 July 2024 20:48:54 BST you wrote:
> Hi Adam,
> 
> > This certainly seems to improve the situation.  what happens now on boot
> > is
> > that the driver loads Ok, the UI shows the signal strength for a few
> > seconds, but then appears to go to an unregistered state, which is
> > supported by the logs below.  When I restart ofono, it seems to work
> > fine, this log is also below.
> 
>  From the first part of the log:
> Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:registration_status_cb()
> / quectelqmi_0 error 0 status 1
> Jul 30 10:44:40 PinePhone ofonod[2543]:
> src/gprs.c:ofono_gprs_status_notify() /quectelqmi_0 status registered (1)
> ...
> Jul 30 10:44:40 PinePhone ofonod[2543]: src/
> network.c:ofono_netreg_status_notify() /quectelqmi_0 status 1 tech 7 lac
> 11016 ci -1
> 
> Looks like we're registered at this point.  Then:
> Jul 30 10:44:41 PinePhone ofonod[2543]:
> src/gprs.c:ofono_gprs_status_notify() /quectelqmi_0 status unregistered (0)
> ...
> Jul 30 10:44:57 PinePhone ofonod[2543]:
> src/gprs.c:ofono_gprs_status_notify() /quectelqmi_0 status unregistered (0)
> Jul 30 10:44:57 PinePhone ofonod[2543]: src/gprs.c:netreg_status_changed() 0
> (unregistered)
> 
> Then you restart oFono.  I'm not really sure why the firmware says it isn't
> registered?  You haven't observed this before on boot?
> 

Maybe it was a hiccup .. I just shutdown and booted, and its working fine this 
time. i'll keep an eye on it!

Since the service restart this morning, it appears to have been working fine 
all day.

> Regards,
> -Denis




