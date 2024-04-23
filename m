Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13320B3E
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713909302; cv=none; b=jhqoYyfvzi19rSw/e4L4utddfhEMItC4fxUWIY6CO+lAeL3O/APhRAbcGLQPJWIF/opjO5Xr6k5+He4AANhYKUfdWUVzbhuMq+qw236sCzqoirB7VIqDdGHeTPylpDGBRHwgwqDTobIhhjE4KXkJpwfflljjDcIHn9j0IKQ5KS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713909302; c=relaxed/simple;
	bh=6Kw+T6tPlvR3XwUk5l+D2LuwRQ9rtsVQJ3iBoMdpL5Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDSXRI6q8o468TvV3KVZn4laZcXyaoDOssdDKYi/IFV6mdncivFSH66zECj1Ll8voR+IDG6I/cp0er153vF65ePRVAiTwFexMrjag9VovGn2u3fjbj1ThPF00cGVLRVRLU2VKcX7lMwr1Flgps+SQJIOayKTq01Dd340HwXqh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fce+VFzz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fce+VFzz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41a4f291f80so23039775e9.1
        for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713909299; x=1714514099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oezIAdxxAeBbTfqL0dv6sG7ZNgY/1HqXH0Mo1QcN6Q8=;
        b=fce+VFzzK8YDDdku0QiTWKIvZQGZLcIW8MA7je91aecjC2eYIugB8ZOrSTs5JcFQ0j
         Pgf0LOhq6WK8uUtwdsdNhl/03Bu9GOvvlKsgAeLzRz+iBR+jKtHvWyYOSygwm4zQwvqr
         Ydgf7MeWXLVNXNPP02HwExPwlWPFyRBBPNsHMTC2WTJbxZV3G1rWivNxtFUNiD+ur+e5
         akln2GOvhzW82Olby3hYd/PEAKi7IVd9bS6JPAY3nRq1mPrkVyP5pcPQ4xEUOoMhWeIZ
         CBEMEVso+xHX9UrUY7JUP+n1/hkoEFkyqtD+YwEklmwXL8pAjCLiCfXWmtMk+9tCvIGb
         40dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713909299; x=1714514099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oezIAdxxAeBbTfqL0dv6sG7ZNgY/1HqXH0Mo1QcN6Q8=;
        b=ZD38KmpM28hF2J6o3GnkDfozr/Qy/m/Yzv3WFO9AOoVG+G/uERXd12fymcUU32I1rb
         Mb+Vl36LR5Shz0I7PoGH+N0ZYPT2O6pss7h8HmNofGrDNjvgBJWOi8C8wA0bFIA4AjER
         yEMw8s464o3bHR/J5YybjbYLCPM+aFjMeYEPj7ahkPQJMcD3PZxREFWL26+/mTHDkVRM
         xKigKpJaGlHKqSegxs0+bHwp3P4JIClwpyqIR7xhm6f+bGTarR8vzZ23kaVBWIZpzNU+
         UR15JdkOCXiitRdSdrcpcJnkUp+iR1hoEIkA4ny7qeOEt7hba3VZlBMyNmQj9AZb9pjT
         9U/Q==
X-Gm-Message-State: AOJu0YxL1A2bj6JFZ+gCDe4ZYNivUEhnU65BjIkcIg4pS7oMbn2NahXi
	E/x4M4M2/w3aX2Beow/684X8hkHlOIkehXWnNRTyWOrP40189RD8ZaZQGA==
X-Google-Smtp-Source: AGHT+IHa05m6H6a/mVVP2tHNOdF0mOAS/03X7+54TpJqAtzZdy/UtB5kWUTYXzWyFQ/CBkEuZgZiRQ==
X-Received: by 2002:a05:600c:4586:b0:416:3f85:d49 with SMTP id r6-20020a05600c458600b004163f850d49mr486361wmo.18.1713909298913;
        Tue, 23 Apr 2024 14:54:58 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id cs7-20020a056000088700b00346cdf48262sm15678707wrb.2.2024.04.23.14.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:54:58 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] qmimodem: voicecall: Implement DTMF tones
Date: Tue, 23 Apr 2024 22:54:57 +0100
Message-ID: <26374076.1r3eYUQgxm@adam-laptop-hp>
In-Reply-To: <81f70af9-4659-495b-9928-14d4286ea80e@gmail.com>
References:
 <20240421194926.13149-1-adam@piggz.co.uk> <1934099.7Z3S40VBb9@adam-laptop-hp>
 <81f70af9-4659-495b-9928-14d4286ea80e@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

So, I decided to have  a re-think and try the burst dtmf method, which accepts 
a string of chars, and should be simpler....

I created a packet struct for the parameter data:
struct qmi_dtmf_burst_info {
	uint8_t call_id;
	uint8_t length;
	char digits[0];
} __attribute__((__packed__));

and set it up as follows
	struct qmi_dtmf_burst_info *di;
	di = alloca(2 + strlen(dtmf));
	di->call_id = 0xff;
	di->length = strlen(dtmf);
	l_strlcpy(di->digits, dtmf, strlen(dtmf));
	param = qmi_param_new();
	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, di->length + 2,
			di))
		goto error;
	if (qmi_service_send(vd->voice, QMI_VOICE_BURST_DTMF, param,
			send_dtmf_cb, cbd, l_free) > 0)
		return;
But,  in the callback, in a call to qmi_result_set_error, i get back error 24, 
which is QMI_PROTOCOL_ERROR_NETWORK_UNSUPPORTED right?

Not sure where ivce gone wrong, the struct seems to match the format I found 
online for this function call, but is the likely culprit, or its not possible 
to do a burst dtmf, and its better to go back to the original style of 
individual characters?

Thanks


On Tuesday 23 April 2024 16:01:10 BST Denis Kenzior wrote:
> Hi Adam,
> 
> On 4/23/24 05:10, Adam Pigg wrote:
> > Hi Dennis
> > 
> > Thanks for the thorough review and merging the others....
> 
> And thanks for doing all the hard work :)
> 
> <snip>
> 
> >>> +
> >>> +	CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd->send_dtmf_data);
> >> 
> >> This calls back into oFono core unconditionally.  Doesn't this imply that
> >> you're handling only a single DTMF character?
> > 
> > Currently, ive only been able to test using single character invocations,
> > using the num-pad on the phone app.  Do you have any suggestions on how to
> > trigger multiple characters?
> 
> Take a look at doc/voicecallmanager-api.txt.  The SendTones() method takes a
> string of tones, so there can be multiple tones per request.  If your phone
> dialer UI does not support sending multiple tones, then the easiest way is
> to use a command line utility like 'dbus-send' (from dbus-1) or 'busctl'
> (from systemd), or a graphical one like d-feet or qdbus.
> 
> Something like:
> 
> dbus-send --print-reply --system --dest=org.ofono /phonesim
> org.ofono.VoicecallManager.SendTones string:"1234"
> 
> Replace /phonesim with the path of your modem device.
> 
> <snip>
> 
> >> This function doesn't seem to be invoked?
> > 
> > This function is passed into send_one_dtmf but yes, potentially goes
> > unused, unless it gets invoked in the macro call?  Ill double-check the
> > original implementation to see if i messed anything up, but open to
> > suggestions :)
>   I think your v4 implementation handled multiple characters correctly, just
> FYI.  Just the memory free paths were not completely correct.
> 
> Regards,
> -Denis




