Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2204111A2
	for <ofono@lists.linux.dev>; Sat, 16 Mar 2024 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710585695; cv=none; b=krL1wJ74AvI0A14PNwfo+Uja6OZzVM4iJbIrke6qCyxL+iR1ZYBbBgvXhBthSCHugUo6nWS1XvaL+uPeATJS4tZnG4XAWz3jWgm2eDFmINGdTonNY9ehU/ihvo0vZm3YndAVEXtmHkjwdk2/Is9i5zTre0eQMcVMwBvo9RrM0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710585695; c=relaxed/simple;
	bh=2ZWP8TrCWF6SS+cpWXIWWiQeRChw23RtaP3wTr79qY8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2eBQnx8/1pJo+I3VIa5FqBa6zaPQBEnrcFQmTLEDd4pgoelwhjeHrFOCgPBKCTwWxiTAy7E4YboHwOpow0kaJZa7iCuYAftFqrFReCOXU6WJwZAstGnl7s9oG5A6mv1JQx0L9Rjzzg3RDVGm3oNnRbJIBy9pvhfri7l8KtC3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLULhIMI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLULhIMI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41400332525so12631295e9.0
        for <ofono@lists.linux.dev>; Sat, 16 Mar 2024 03:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710585691; x=1711190491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8+OAnDRveDUpFs+BOiXOjcLr8ovpUs4c6ckNgWlezQ=;
        b=jLULhIMI5IL6j1ZdSDjwywN8P690zuXjZ4024DXBzBKuIY/aLlrHjWcfVVZ/88NumE
         H7khkSImgbx2LE+mkih39mwCmW9rlmrg1xpUch3/70gpsXyj9j/P3nvXHFTZQBegLBKp
         VrDvQ1EOBBUxhpV0M/SS+LnpGzNXHWzjQf0ndnU4wwk3vcbmzn55hY2BlGQMK4g4b5k0
         0qkC+AMKnsNhpZ2xNF/w62MZU75rmFCHxFnlb/LHBec01Hzut9O5N56LuoisRhB+jUVQ
         Zm5K2GTRl1apHPuxbiWmWb6ziJCQG3qtnDp6M40hwBtr8zE1kUNOeFGNN+7W0/+qpyi7
         u2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710585691; x=1711190491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8+OAnDRveDUpFs+BOiXOjcLr8ovpUs4c6ckNgWlezQ=;
        b=RLOj2FnXzQPTmtAxtJRruAmMjY0Dbz2M16jookJHUpyiZOopBzFzdpoptUv2xNMzji
         j3GQgWG8hx3LoNclb4tfJVw5OR9TonEAk3OacjqfOvDXMkEwXtwTGRp6O9CMK5+lsb9K
         2cKoAU405ystWW/WNp8XPYcUnZ73oEGJmXgkd1594aTVH6pEuVRzLnWMlHO1fGNAtktv
         stIM34myzFBLRFJCWi4UHZDms1m3BxUfEyrkeFi0vEx3Vru8cu30vhPOLPUJJRdEskl1
         qobvhfjV0b9L5jeXVubmR90Ckpy39BftjR0fMvFdJSsMyhFX4m8M4Rn41rkwCOGw+06T
         59RQ==
X-Gm-Message-State: AOJu0YxvNzzDqgHCaNwKdWAk2tvEvhiJ5OBrOXex7MImFgasmvMTm8Fu
	xSI/1/fZnbFc7Su2LARJbU9u8e3G77TIw9vgNky3gbuGjZOLVKUoLiwDSNPDHy8=
X-Google-Smtp-Source: AGHT+IH7gRj4DquHNOhbbVaSBeqvebk9YcaDI6R27Z0Ea5ZhlXDCJ2ZpufZeeW04m8xale02uehGtg==
X-Received: by 2002:a05:600c:5247:b0:414:21f:ef7e with SMTP id fc7-20020a05600c524700b00414021fef7emr3046265wmb.2.1710585690944;
        Sat, 16 Mar 2024 03:41:30 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b00414038162e1sm3909755wmq.23.2024.03.16.03.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 03:41:30 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: Possible ofono patches
Date: Sat, 16 Mar 2024 10:41:28 +0000
Message-ID: <7481802.MGcBpxfIA8@adam-laptop-hp>
In-Reply-To: <472c1fd1-45c4-4721-a0df-76a60ccc3944@gmail.com>
References:
 <scd9r5.saa0vh.2sch1i-qmf@smtp.gmail.com>
 <472c1fd1-45c4-4721-a0df-76a60ccc3944@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Denis

On Friday, 15 March 2024 13:56:00 GMT Denis Kenzior wrote:
> Hi Adam,
> 
> On 3/13/24 02:59, piggz1@gmail.com wrote:
> > Hi all
> > 
> > A few weeks ago, i started a personal project to try to rebase the jolla
> > ofonalo dbus api's and changes ontop of current ofono.  I am writing
> > about it here https://www.piggz.co.uk/sites/pgz/blog
> Nice!
> 
> > My current work is against 2.5 with patches that are somewhat working with
> > my pinephone. My tree of individual patches is available at
> > https://github.com/piggz/ofono-upstream/tree/main/rpm
> > 
> > I wondered if anyone would care to scan over them and provide feedback as
> > to whether any are suitable to upatream into ofono.  I appreciate not all
> > will be, but with some rework, others may be of interest.
> Hard to say since the commits lack any context information for _why_ the
> given code exists and what problem it is trying to solve.  Perhaps Jolla
> can help with that?
> 
> Also, I'd like to eradicate the use of glib in favor of ell in oFono,
> starting with qmi modem driver (which is now 99.9% glib free).  To this
> end, my preference is not to accept any new code that is glib based unless
> there's a strong reason to do so.
> 
> > There is a working voicecall implementation for qmimodem, which includes a
> > refactored call-list implementation.  Many of the others add dbus
> > interfaces for sailfish so may not be interesting.
> The voicecall driver is definitely something I'd take upstream and can help
> shepherd along.
>
I thought this would be most likely.  I do some re-work on it and make sure 
there is no glib before I submit it to the ML.

Currently it seems to be working for me, at least when in 2g or 3g mode.  
Calls fail in 4g, i think because the connection needs to be downgraded at 
this point. 
> Regards,
> -Denis




