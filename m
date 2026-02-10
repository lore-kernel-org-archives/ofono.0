Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC332860E
	for <ofono@lists.linux.dev>; Tue, 10 Feb 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743449; cv=none; b=SqPYNIHp3qNELXoGlTq+uDPGahbhFhne4CZQdgBWUPOv4nIwj56K/+Jh4h69AYO0BGWbRIL2E6h+l2+Y26MnQSDsrRB6sbGd4EkXXaQ4BGQheixtTaBJr6q+3gsTkSiFKlt9FADVpcDptBwt1pnQhGvJ92pVOdDMSa8EMqu/uQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743449; c=relaxed/simple;
	bh=mW3ybAB+lRtIHTG4KgGkT62mzidPiqWQCG4MUjkxhfM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XedCQrkm4Tntg4VnUUPmH/54VzWpG+xP6siw7w5wMALsYsAXao2cxmwbsKuFnybkbrUyjR6LgefiZofY1XscdFkMYZKk3KaxpnAwJXzUwAt/ag6YjahE7RQuUlbhM7Tm0Nk6kW0ItLQgkCRseUJf0dyDQk1T/wY5A8uHFLLz0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=KThwPrY6; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="KThwPrY6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1770742900; bh=+FT7RPqlIfel2lgbH1Dw9tO/cfDeJulypcInTFcGGOU=;
	h=From:Message-ID:From;
	b=KThwPrY68Mar774zKQFWcuoKYSmGZ9Req39b3ACIcD9tO+etGyi1g+OlEvY98xVoT
	 4DOKKi61inOm5tICNZMVxZbj5GMJsNNOSYoyxYQg1TBz5PF8/9dMlbWYFHecrNeY57
	 YuUnB4XQ2DsCE9c+C0233jnWJxn/BbecxWW2181M=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 0DAD9C09DB;
	Tue, 10 Feb 2026 18:01:40 +0100 (CET)
Date: Tue, 10 Feb 2026 18:01:39 +0100
From: Willy Tarreau <w@1wt.eu>
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: "ofono@lists.linux.dev" <ofono@lists.linux.dev>,
        "secalert@redhat.com" <secalert@redhat.com>,
        "security@kernel.org" <security@kernel.org>
Subject: Re: ZDI-CAN-29089: New Vulnerability Report
Message-ID: <aYtkc7oTpBivYUZ1@1wt.eu>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR01MB3830BD5C9755FDDBA5ADE0FC8062A@BYAPR01MB3830.prod.exchangelabs.com>
 <BYAPR01MB38303CF32A86888EBE5918DA8062A@BYAPR01MB3830.prod.exchangelabs.com>
 <BYAPR01MB3830E1E9E11FC8716A722A588062A@BYAPR01MB3830.prod.exchangelabs.com>

Hello,

On Tue, Feb 10, 2026 at 04:54:46PM +0000, zdi-disclosures@trendmicro.com wrote:
> ZDI-CAN-29089: oFono MBIM SMS Handling Heap-based Buffer Overflow Arbitrary Code Execution Vulnerability
> 
> -- CVSS -----------------------------------------
> 
> 6.8: AV:P/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H
> 
> -- ABSTRACT -------------------------------------
> 
> Trend Micro's Zero Day Initiative has identified a vulnerability affecting the following products:
> oFono - oFono
> 
> -- VULNERABILITY DETAILS ------------------------
> * Version tested:20.0.3
> * Installer file:agl-demo-platform-crosssdk-raspberrypi4-64.wic.xz
> * Platform tested:Raspberry Pi
(...)

Please note that none of these 3 reports concern code in the Linux
kernel, so security@kernel.org can be dropped from future exchanges.

Thanks,
Willy
