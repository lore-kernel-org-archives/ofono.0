Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123A401A3F
	for <ofono@lists.linux.dev>; Thu, 12 Mar 2026 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346426; cv=none; b=SFXJYJK6EMHbfDGTa4YqdoHu6rb561H+smfaglOCLjEnOdSvFRt4dKwaPWtjXHygmFW7taHmyb2jy5ShOSL5qEA5ei/gre8mS7pibz9SRSpfy0xmawCHXXDrzVKDg+wpohjsxv8M92ocoaMKAHBPn4vqCwNzDG2vm1hlw5IdXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346426; c=relaxed/simple;
	bh=y7VnCnEyJ/c5wnfVHWscSRmefw2mdGgBY1Yvc2Xu/co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bssck6ZfcqKhARIg+ePAFQBODew5K2Z3LGWjVDz2JBqM/93GcdSS8bOjhF7RQHTMmdRuEghK3YB4ir9usD61vftpeF6g74c1e4R5IuFDwML2KvBKyAU77l4Cd3g8dRt24/4/LyU9WeYT4C9EoEh1dKY8i/lF+/nWh9hKHsKT6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDYxLUwW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDYxLUwW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48539cbb7b1so8203745e9.3
        for <ofono@lists.linux.dev>; Thu, 12 Mar 2026 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773346423; x=1773951223; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGJ332WTfstdK28jpA+fiRu58kVPtDwdI94IyRfq1Pc=;
        b=lDYxLUwWIXQDyhth/gdfwNP3lGPQ9ORjaBiOClLJEEcCG6NKt9KRkaDS96rRj9jG1Y
         9oGUtA8OXZM6JsQ2vORdXd3eLNuToKq0z7yxsnJZKPxy/sef+xltJ3jCihNqTtIRPZfN
         Xzu7Po7Zy1QCNfyPJ0Is7kGCmjD5iQvO4z0ccC5rBmhUsdof91/QRysbhbxZAVb0oKyt
         CEC+YnJBUku+Obq02UmmAUOEkaI6xVT6UeB++pWmTKDsslllgZtofYebysBV1BndwDV6
         BrrQgK4RDQ1RFCYT1/jDjUMp0Wb8GUQVugLkNg/CoSVwMGZ7SgMpMU0dqMz24gM2idGr
         3k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346423; x=1773951223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGJ332WTfstdK28jpA+fiRu58kVPtDwdI94IyRfq1Pc=;
        b=vGozA4HUg6b0j4U6lESC+S9Pkl238cPFW+TKRnt57L43NeNjeIpEj+/tyLeD/dT107
         01GQxz6lr0WlbVO41lUnCilmqX5uRtBKze5jwmatBeVyuJN7pZXwQZdQxryxgHvtKH/v
         l6rLxKvKx82aSRtVKCMbu3jwKGLxykNGpYzUB5S5U9KIGRPGp0USG9aB4/ggZZUn0C4R
         fGkg/BDmA58GxO8ocIUfaWu0WSwpG7TYWUmJQPOxI4oSJGpMPzBvtdP70NHZRHvUzXk/
         LhwI0EfYCG3eIZgYaPVfXsFjVWxzlit72xcxvXxK69zp8/c2EPQYfH/pzvpBewxWUlxq
         Hv6w==
X-Forwarded-Encrypted: i=1; AJvYcCWUkl4d8B/BaR8JrX/4EKVJGCcdWUCtJLIhiSUrDnspXjzOR8jo3Ot/ysIhstIRoutNNCWC2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLb9V2ij/4LI5FxNxrPyOm+8zxvcGJkzDchq/6yx1YdfMbIaPM
	uvfcZtD2+Qzco+Sgr5X1SwH75XiDGxdTqbK8yfyAHgwLAvH05quzIAU8
X-Gm-Gg: ATEYQzy1PvyXN0j8793BFe6u5Iei3yUR5Pv0fobw9wmpHkEPxhKFmDzmT1YvouA32RC
	QKLdki8KGzUif3pvcUyDSTKzGeelTc1/Dkd1UsJuCuHQ33RdCBWqgkstm3gYFmG3TVDtgPol9wZ
	u54ODbFiN2NQTbhYx/HM2Bva2qNYWDOEH2QU7MLQZPszvL2VOzos5UQb1IZGkZlH0YRxEPGsdnm
	2qBiRpoVoa5Xo5oZU5WVPwYcIvPMGmBZuayqRDTR6IVML/ceQFLkEb9wSgb77N+EX/CpzIKQZ9O
	0MkyZjvwHJtTMNgTH6akrdnhLJ8RoE8kZ1p9DOFNuwzvfOOGd0Uz1Fy8W1EcxArwmFZHvGQFLpf
	0i5zxAAzL+E1rdK/H3lNR5mL8bghwsA9g/gHuivrHrRTGKLmMNolyet7uXburbGTaj8ZTjARXCL
	ZL3dqhn6dAQ+fZ93XJ8fqW1cPKob9Z
X-Received: by 2002:a05:600c:c0d2:20b0:485:3d9f:5510 with SMTP id 5b1f17b1804b1-48556714f87mr8228805e9.19.1773346423278;
        Thu, 12 Mar 2026 13:13:43 -0700 (PDT)
Received: from tp440p.steeds.sam ([41.215.156.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe23afc5sm12222868f8f.39.2026.03.12.13.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:13:42 -0700 (PDT)
Date: Thu, 12 Mar 2026 22:13:37 +0200
From: Sicelo <absicsz@gmail.com>
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: Willy Tarreau <w@1wt.eu>,
	"ofono@lists.linux.dev" <ofono@lists.linux.dev>,
	"secalert@redhat.com" <secalert@redhat.com>,
	ivo.g.dimitrov.75@gmail.com, maemo-leste@lists.dyne.org
Subject: Re: ZDI-CAN-29089: New Vulnerability Report
Message-ID: <abMecbIIvAhibdPv@tp440p.steeds.sam>
References: <BYAPR01MB3830BD5C9755FDDBA5ADE0FC8062A@BYAPR01MB3830.prod.exchangelabs.com>
 <BYAPR01MB38303CF32A86888EBE5918DA8062A@BYAPR01MB3830.prod.exchangelabs.com>
 <BYAPR01MB3830E1E9E11FC8716A722A588062A@BYAPR01MB3830.prod.exchangelabs.com>
 <aYtkc7oTpBivYUZ1@1wt.eu>
 <BYAPR01MB38300A127FB5267EA5A6846E8044A@BYAPR01MB3830.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR01MB38300A127FB5267EA5A6846E8044A@BYAPR01MB3830.prod.exchangelabs.com>

Hi

Community members will work on these. As with any other open-source
projects, patches welcome.

Best Regards

On Thu, Mar 12, 2026 at 07:13:20PM +0000, zdi-disclosures@trendmicro.com wrote:
> Hello Willy,
> 
> Noted thank you!
> 
> Any updates on this issue?
> 
> Thanks,
> ZDI
> 
> -----Original Message-----
> From: Willy Tarreau <w@1wt.eu>
> Sent: Tuesday, February 10, 2026 9:02 AM
> To: ZDI Disclosures Mailbox <zdi-disclosures@trendmicro.com>
> Cc: ofono@lists.linux.dev; secalert@redhat.com; security@kernel.org
> Subject: Re: ZDI-CAN-29089: New Vulnerability Report
> 
> Hello,
> 
> On Tue, Feb 10, 2026 at 04:54:46PM +0000, zdi-disclosures@trendmicro.com wrote:
> > ZDI-CAN-29089: oFono MBIM SMS Handling Heap-based Buffer Overflow Arbitrary Code Execution Vulnerability
> >
> > -- CVSS -----------------------------------------
> >
> > 6.8: AV:P/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H
> >
> > -- ABSTRACT -------------------------------------
> >
> > Trend Micro's Zero Day Initiative has identified a vulnerability affecting the following products:
> > oFono - oFono
> >
> > -- VULNERABILITY DETAILS ------------------------
> > * Version tested:20.0.3
> > * Installer file:agl-demo-platform-crosssdk-raspberrypi4-64.wic.xz
> > * Platform tested:Raspberry Pi
> (...)
> 
> Please note that none of these 3 reports concern code in the Linux
> kernel, so security@kernel.org can be dropped from future exchanges.
> 
> Thanks,
> Willy
> TREND MICRO EMAIL NOTICE
> The information contained in this email and any attachments is confidential
> and may be subject to copyright or other intellectual property protection.
> If you are not the intended recipient, you are not authorized to use or
> disclose this information, and we request that you notify us by reply mail or
> telephone and delete the original message from your mail system.
> For details about what personal information we collect and why, please see our Privacy Notice on our website at: [ https://www.trendmicro.com/privacy]
> 
> 
