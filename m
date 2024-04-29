Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887514039D
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421565; cv=none; b=mCtUCq+yCIZ2cZR56h85szhCDbOmfMZL4J6ee6EC7FGOwPX362WADiOAIOROuBoUkn6eDA8bRHscGg9aGezX0AuIjZ+zg9I4tRRFXzP23ULCFjZJq1vrz0sDjA7j4QZ7hrXzeLmbppihLtQbt/ud3M9q5YF8p6lXC8m38WOu7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421565; c=relaxed/simple;
	bh=EjA8ZLMt3TzKI/tK09BP+PQ8Y8RG0L0r++GlXKkHlFM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0kZNgt0B2DGaZhEnOkGbY3QEcOFvf8XudMXLl/G0UJzE1Ro7nenctm+GgGXD0xpgrWOajxGYVKSKsCk6wFNNAVAGspT3EoSuFEdc5wm5Y8W3histzYTj3ZTl0T2rjsGnFsDJV2IW26agnnULwIuQjh8NKAa9Lgg1ayaxlpT/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWsQO82u; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWsQO82u"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so63700331fa.1
        for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714421561; x=1715026361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfC3nUDdFWM6ELQe8mRsHQqYV/H7kXLD7zRSmgP3Qd0=;
        b=iWsQO82uYuFHb2PifskDr3lD355Bb2Hdp1KTRp3I0xSEPoRBpKInWJPIE9lIgu+x1g
         2x+1D4/47oeT440c+U5d1oBEs50k/XBq48h6BERCGGbeYBx9znTOtNU3wXDcAQnBGsZq
         tj2wKJ1tOsPnnCpqt2EUfSU9uc6sr3W7RZlcoFzaGVWltUW+/2Culm4pU6x5nhunFsR3
         gIxa3eMv8djUtRPvZqs5eP425Dz0/pHN3zKIqpSoTTtgnbgV8qBhQj1iwmo1OG7iu6FD
         GldzNMl9CTPl+T6CN+cbDvRf89nBFMWdgD4m2a0WriDso9RbkFLOikswqNgbCO7LDvj6
         9Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421561; x=1715026361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfC3nUDdFWM6ELQe8mRsHQqYV/H7kXLD7zRSmgP3Qd0=;
        b=L/5vNLulHiNNqKZoxzpBuiCu7Ks3MCe7ZbzxNX6YHpWa17IGb0mClgXd1t8jAja2Sq
         E66wvPhuVFtV611IGms3cw6RwJKHD/HCXFnRZQoe0dEsmZqkQxqrOW/Pchsq10DGgwN2
         eZcx1oMmJw6RYweT2QPZJYQp1KuOVLvOmRDxBr6S2pQdw0MlT4U+UNX4so3j+YF3tHUq
         E3IFRxyQE6+cv+Np0vdyHN7om+QlzFx7S3B+bQ1HzZEMbFYF9GBT9gNcmDrMwwQRZF+C
         ZF3aXBRrDjAlw6ZuKHHZjXwG9mGD6CFV8pE6T1HpIsRthMN0tP/ORxkF48wb3VRlWamk
         xWug==
X-Gm-Message-State: AOJu0YykYy3vNhoBmlWCScbq7SzQ1CX6iXZG3dgS8j9KnWp5tVeQP3qr
	rwyhvr11bvXuq4izNbqP1nI14NAk/GD3Gt8NjvMJIPrg9dRFBXG6SNIlsA==
X-Google-Smtp-Source: AGHT+IHWr5Q278hOQ2UASdjWX7ZA6tHs1qolwaxjUaiL6kFZ+oiMy5eAgq0moq0Ti3nuWUL6e7cIYA==
X-Received: by 2002:a05:651c:b25:b0:2df:bf2c:b376 with SMTP id b37-20020a05651c0b2500b002dfbf2cb376mr6309464ljr.20.1714421561267;
        Mon, 29 Apr 2024 13:12:41 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0041a1fee2854sm31727041wmq.17.2024.04.29.13.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:12:40 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v6] qmimodem: voicecall: Implement DTMF tones
Date: Mon, 29 Apr 2024 21:12:39 +0100
Message-ID: <2708035.vuYhMxLoTh@adam-laptop-hp>
In-Reply-To: <6df19933-f054-497e-9fff-4fd3d1625752@gmail.com>
References:
 <20240426212235.2627-1-adam@piggz.co.uk> <9691207.eNJFYEL58v@adam-laptop-hp>
 <6df19933-f054-497e-9fff-4fd3d1625752@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Dennis

On Monday 29 April 2024 17:14:05 BST Denis Kenzior wrote:
> Hi Adam,
> 
> On 4/27/24 12:31 PM, adam@piggz.co.uk wrote:
> > I thought I would include the valgrind output while removing the modem
> > mid-
> > call after sending some dtmf digits.
> > 
> > The leak which is identified at the end is in a patch im not upstreaming,
> > which is part of the making the gobi driver work with the other patches
> > im using to support sailfish.  The other thing of note is some logs
> > relating to the SIM code.
> 
> Thanks for the report, this is exactly the kind of stuff I'd like to see
> when people report possible bugs.
> 
> <snip>
> 
> > ofonod[1888]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
> > tocopy: 10
> > ==1888== Invalid read of size 1
> > ==1888==    at 0x486EA2C: strlen (vg_replace_strmem.c:494)
> > ==1888==    by 0x48EA3FF: l_ascii_strdown (in /usr/lib64/libell.so.0.0.2)
> > ==1888==    by 0x4CD4DF: sim_parse_language_list (simutil.c:1853)
> > ==1888==    by 0x4C236F: sim_efpl_read_cb (sim.c:2456)
> > ==1888==    by 0x4E315B: sim_fs_op_read_block_cb (simfs.c:415)
> > ==1888==    by 0x422907: read_generic_cb (sim.c:221)
> > ==1888==    by 0x41A617: service_send_callback (qmi.c:2784)
> > ==1888==    by 0x41AF87: __rx_message (qmi.c:863)
> > ==1888==    by 0x41BFE3: received_qmux_data (qmi.c:1408)
> > ==1888==    by 0x48F021F: ??? (in /usr/lib64/libell.so.0.0.2)
> > ==1888==    by 0x48EF497: l_main_iterate (in /usr/lib64/libell.so.0.0.2)
> > ==1888==    by 0x49B0E7: event_check (main.c:196)
> > ==1888==  Address 0x5fd229a is 0 bytes after a block of size 10 alloc'd
> > ==1888==    at 0x486D6C4: calloc (vg_replace_malloc.c:1328)
> > ==1888==    by 0x4E24D7: sim_fs_op_read_block (simfs.c:443)
> > ==1888==    by 0x4A333C3: ??? (in /usr/lib64/libglib-2.0.so.0.7800.4)
> > ==1888==    by 0x4A36647: ??? (in /usr/lib64/libglib-2.0.so.0.7800.4)
> > ==1888==    by 0x4A370AF: g_main_loop_run (in /usr/lib64/libglib-2.0.so.
> > 0.7800.4)
> > ==1888==    by 0x41421F: main (main.c:314)
> > ==1888==
> > ==1888== Invalid read of size 1
> > ==1888==    at 0x486EA2C: strlen (vg_replace_strmem.c:494)
> > ==1888==    by 0x48EA3FF: l_ascii_strdown (in /usr/lib64/libell.so.0.0.2)
> > ==1888==    by 0x4CD4DF: sim_parse_language_list (simutil.c:1853)
> > ==1888==    by 0x4C23EF: sim_efpl_read_cb (sim.c:2463)
> > ==1888==    by 0x4E315B: sim_fs_op_read_block_cb (simfs.c:415)
> > ==1888==    by 0x422907: read_generic_cb (sim.c:221)
> > ==1888==    by 0x41A617: service_send_callback (qmi.c:2784)
> > ==1888==    by 0x41AF87: __rx_message (qmi.c:863)
> > ==1888==    by 0x41BFE3: received_qmux_data (qmi.c:1408)
> > ==1888==    by 0x48F021F: ??? (in /usr/lib64/libell.so.0.0.2)
> > ==1888==    by 0x48EF497: l_main_iterate (in /usr/lib64/libell.so.0.0.2)
> > ==1888==    by 0x49B0E7: event_check (main.c:196)
> > ==1888==  Address 0x5fcd46a is 0 bytes after a block of size 10 alloc'd
> > ==1888==    at 0x48687E8: malloc (vg_replace_malloc.c:381)
> > ==1888==    by 0x4A3D29F: g_malloc (in /usr/lib64/libglib-2.0.so.0.7800.4)
> > ==1888==    by 0x4A5781B: g_memdup2 (in
> > /usr/lib64/libglib-2.0.so.0.7800.4)
> > ==1888==    by 0x4C0C27: sim_efli_read_cb (sim.c:2381)
> > ==1888==    by 0x4C0C27: sim_efli_read_cb (sim.c:2372)
> > ==1888==    by 0x4E315B: sim_fs_op_read_block_cb (simfs.c:415)
> > ==1888==    by 0x422907: read_generic_cb (sim.c:221)
> > ==1888==    by 0x41A617: service_send_callback (qmi.c:2784)
> > ==1888==    by 0x41AF87: __rx_message (qmi.c:863)
> > ==1888==    by 0x41BFE3: received_qmux_data (qmi.c:1408)
> > ==1888==    by 0x48F021F: ??? (in /usr/lib64/libell.so.0.0.2)
> > ==1888==    by 0x48EF497: l_main_iterate (in /usr/lib64/libell.so.0.0.2)
> > ==1888==    by 0x49B0E7: event_check (main.c:196)
> > ==1888==
> 
> This should be fixed in ell in this commit (part of 0.64)
> 
> https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=57fcbf80bff6fdbf1
> 0b21bd4d3f3e282f14599b9
> 
> Could you upgrade ell and see if this is fixed?  Might have to rm -rf
> /var/lib/ofono/* first, to make sure the sim file cache is cleared.
> 
Yes, installing 0.65 (from 0.62) seems to have fixed this error.  I was 
compiling with 0.65, but hadnt upgraded the version on the phone. (i use it 
externally)

> Regards,
> -Denis




