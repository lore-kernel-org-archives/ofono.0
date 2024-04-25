Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04B1514CC
	for <ofono@lists.linux.dev>; Thu, 25 Apr 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072040; cv=none; b=MGyzKH2Ehrc2Rm49WTI9nMeEcm5wjxoBLOiOXBQ0Ixsm+k53/PSn1TY3NqmK3/ZufoQQ5X7RXPpVBMLCWdf0hH+nnXMibBcKEcYQB6aSZqMU7PR79T267q8bTaOyNDLGA0TPAr3Pcr/y/TnAeSqJXBMbrPyhP3g3AYcw/RxJEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072040; c=relaxed/simple;
	bh=RFOF6gOD913C4VtEILuT7gsmlOenhQwfvSnBRI/JEp8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkDEZSXJ0KNEnMN3LcVcaBxAKcb/ZHpZFXOuNulAaPQPnirIg/cQykk2H+tgGDmBVyvsSmvWXLu+8cJHiQMX8D47rbhZIK/kejiffQv5SfpvZ4OC2/TptSvJx2eQskttl6a6/UG1InD4+mywNdZjx/edyb9T40g9ELyYlczSN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5PjnC+Y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5PjnC+Y"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b42ce6ce9so8035695e9.1
        for <ofono@lists.linux.dev>; Thu, 25 Apr 2024 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714072036; x=1714676836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7X/fhq6ZDRESLqil0aUjHE2KVe6Qr3tavgP52gScmA=;
        b=H5PjnC+YPAXBDEwgESM6gijm+0AKg8JLKLG1DiqoZRoDgcz8O4/Zs0LIqMaL0auT8p
         2EmZ11XDnXsCvWFqGYtKMyi8eUsNBDPUvMJhklmrgVuRtT/7S9p9Mk+OmrsyKr/L7R0w
         a7H3yJlNJ3QhusSgjb23b/CyZC1TdyxX1ohQs97q455CxTdYiLv9L1zo55oozG8x2l0y
         fGfSTRr6yzGewx+qioY3fb1zix1WEjl1HRpzaJ9Ejdw9tFTZ15MK/VRM4nAIxvaXiuE/
         n5J3zZyCbVNy7LlBgJkvebB7tc8ww1Xd/MfLjVLxKmwJmY067cmBn6bcq4efoGRavHNe
         U7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714072036; x=1714676836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d7X/fhq6ZDRESLqil0aUjHE2KVe6Qr3tavgP52gScmA=;
        b=VHtZEr9RY5OLjkP1V8AQk3ArE9jsxF4kDNtCYMLKYFGKw3NoMv32dRrRbURVA7mjvf
         OGxbG4tGPnc0zcvd9Sn8I265pdqe2GMnE0F/mJFPnNc/SyVr9o6UZfOUvdK+zOCBdeh/
         PvQu5hL7XUPzIGuXHxPrzQ00uRONpm2TyyrVC6Z/SVxD3YdIq7JpXxxHeW/JIh4vG0lQ
         g6kzGPpti+DJMv3Ls1aH/KH6+TyPgtaLObOO9XvFXmJxa15z4dlHl7LhgUs/1GcMMhcP
         zjIFpmi5UxQjsqinbLhi2jjbtw5SPhYSC3N54vkHJRxlo/S3nZFeIdP3mvO21it2v5PB
         fdWA==
X-Gm-Message-State: AOJu0Yzhm4slZJNU9vRXleraveeSOsOC6EGXFmyQh0bJnAZr86baB5rb
	cT2wbPYpGrHnyIfmnUW261ee1WblG4oNQ1MDuw5nsrMbqVK8six4ndcv2Q==
X-Google-Smtp-Source: AGHT+IG7qT1J4XZEaK8cQTkDk6PTknVVqRp+1vzRsC+/kdUuKaBy9Z2g9CVthUdO1wRZd/ICPeJX5w==
X-Received: by 2002:a05:600c:4706:b0:41b:4c6a:fa24 with SMTP id v6-20020a05600c470600b0041b4c6afa24mr231528wmo.40.1714072036015;
        Thu, 25 Apr 2024 12:07:16 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm28475127wmo.36.2024.04.25.12.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:07:15 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: adam@piggz.co.uk
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] qmimodem: voicecall: Implement DTMF tones
Date: Thu, 25 Apr 2024 20:07:10 +0100
Message-ID: <2684478.lGaqSPkdTl@adam-laptop-hp>
In-Reply-To: <26374076.1r3eYUQgxm@adam-laptop-hp>
References:
 <20240421194926.13149-1-adam@piggz.co.uk>
 <81f70af9-4659-495b-9928-14d4286ea80e@gmail.com>
 <26374076.1r3eYUQgxm@adam-laptop-hp>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday 23 April 2024 22:54:57 BST Adam Pigg wrote:
> So, I decided to have  a re-think and try the burst dtmf method, which
> accepts a string of chars, and should be simpler....
> 
> I created a packet struct for the parameter data:
> struct qmi_dtmf_burst_info {
> 	uint8_t call_id;
> 	uint8_t length;
> 	char digits[0];
> } __attribute__((__packed__));
> 
> and set it up as follows
> 	struct qmi_dtmf_burst_info *di;
> 	di = alloca(2 + strlen(dtmf));
> 	di->call_id = 0xff;
> 	di->length = strlen(dtmf);
> 	l_strlcpy(di->digits, dtmf, strlen(dtmf));
> 	param = qmi_param_new();
> 	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, di->length + 2,
> 			di))
> 		goto error;
> 	if (qmi_service_send(vd->voice, QMI_VOICE_BURST_DTMF, param,
> 			send_dtmf_cb, cbd, l_free) > 0)
> 		return;
> But,  in the callback, in a call to qmi_result_set_error, i get back error
> 24, which is QMI_PROTOCOL_ERROR_NETWORK_UNSUPPORTED right?
> 
Some further research suggested burst dtmf is only supported on 3gpp2 
(cdma2000?) .. so maybe the original implementation is more suitable.


> Not sure where ivce gone wrong, the struct seems to match the format I found
> online for this function call, but is the likely culprit, or its not
> possible to do a burst dtmf, and its better to go back to the original
> style of individual characters?
> 
> Thanks
> 
> On Tuesday 23 April 2024 16:01:10 BST Denis Kenzior wrote:
> > Hi Adam,
> > 
> > On 4/23/24 05:10, Adam Pigg wrote:
> > > Hi Dennis
> > > 
> > > Thanks for the thorough review and merging the others....
> > 
> > And thanks for doing all the hard work :)
> > 
> > <snip>
> > 
> > >>> +
> > >>> +	CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd->send_dtmf_data);
> > >> 
> > >> This calls back into oFono core unconditionally.  Doesn't this imply
> > >> that
> > >> you're handling only a single DTMF character?
> > > 
> > > Currently, ive only been able to test using single character
> > > invocations,
> > > using the num-pad on the phone app.  Do you have any suggestions on how
> > > to
> > > trigger multiple characters?
> > 
> > Take a look at doc/voicecallmanager-api.txt.  The SendTones() method takes
> > a string of tones, so there can be multiple tones per request.  If your
> > phone dialer UI does not support sending multiple tones, then the easiest
> > way is to use a command line utility like 'dbus-send' (from dbus-1) or
> > 'busctl' (from systemd), or a graphical one like d-feet or qdbus.
> > 
> > Something like:
> > 
> > dbus-send --print-reply --system --dest=org.ofono /phonesim
> > org.ofono.VoicecallManager.SendTones string:"1234"
> > 
> > Replace /phonesim with the path of your modem device.
> > 
> > <snip>
> > 
> > >> This function doesn't seem to be invoked?
> > > 
> > > This function is passed into send_one_dtmf but yes, potentially goes
> > > unused, unless it gets invoked in the macro call?  Ill double-check the
> > > original implementation to see if i messed anything up, but open to
> > > suggestions :)
> > > 
> >   I think your v4 implementation handled multiple characters correctly,
> >   just
> > 
> > FYI.  Just the memory free paths were not completely correct.
> > 
> > Regards,
> > -Denis




