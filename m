Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F61078B
	for <ofono@lists.linux.dev>; Tue, 21 May 2024 03:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261090; cv=none; b=NDTQrhPN229hqHTFW3ScpsPhelFRdTWUB5kS7RnU2SROz7p8wVtXoplEu8w5z0KEQM5LysJdrXmQ/M+vWKEnk9QaXBdEmqpwlqoY7FOZocHwJFV7KTizWvv0aprKmMazWflohJjV2EbWKADhPA+NFdOsnORxEuFqcSW4vWA/KMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261090; c=relaxed/simple;
	bh=e6xw/R8BCXIH94mjm4Bw/K2OZJAvH+tErUnnLQ139NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F60FZyt6GZGsPXaFyqlmTe3hT9HkZNDp7+7/DH/TryXUVPW9XGfGTGyg+95AN9hPAsGkok8jwRWwdCll0Qy4IF3cvybKHIBU9V+F4DTGd0CXAFBrHnd/SfLHNd4ph0wucrFow5V5dyq4xNQdCySXaU9wfMShBaFzAKY7SWDdrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=W29Xpjnm; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="W29Xpjnm"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 363C3603D2;
	Tue, 21 May 2024 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1716261080;
	bh=e6xw/R8BCXIH94mjm4Bw/K2OZJAvH+tErUnnLQ139NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W29XpjnmvOnwVXs73T1CcA2v9q3xhu5HYofc83HYisFwHxlQEXHcoF5LgH0YGCQ/D
	 4W+RozSb7CwdP28b1XQ1z+Bz2Vav36QifdWQr0xpb678VoAaY19rB3P2K1JN8GV9Zq
	 NC8owGe2VLbEDmUjDYNW+iCONl2gcCsxGIwWrVzqgcWD5IXoV/9vxxYORyG5VUbf8Z
	 p2ATQTmDhG/RGKeNyd/0y+4BMozLoO3Kqt1e+nUlsp39woH5WRVjbC2lzEavCf/c87
	 E4RQkoWS1IFlMnCB4Coh/X6LJ/QqNQy9eUBVluTB8Xy3R4EnUFT9tJ1sQ5LDj5H73T
	 NGjzeBYVkDiiA==
Date: Tue, 21 May 2024 06:11:05 +0300
From: Tony Lindgren <tony@atomide.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Merlijn Wajer <merlijn@wizzup.org>,
	Carl Philipp Klemm <philipp@uvos.xyz>
Subject: Re: RFC - Add AT interface to qmi device
Message-ID: <20240521031105.GC5153@atomide.com>
References: <2269874.vFx2qVVIhK@adam-laptop-hp>
 <42fea483-2770-45bc-9744-7063174b9ca7@gmail.com>
 <20240519182635.GF5156@atomide.com>
 <d4d09174-1f12-420d-8ba2-96e2f3f9aa7d@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d09174-1f12-420d-8ba2-96e2f3f9aa7d@gmail.com>

* Denis Kenzior <denkenz@gmail.com> [240520 18:58]:
> > > Have you considered simply using AT commands for calls and SMS?
> > 
> > At least on Droid4 the ttyUSB AT interface is bit buggy.. But there may be
> > a generic way to trigger lost QMI events based on the USB AT interface
> > notifications.
> 
> Hmm, okay.
> 
> > 
> > What we accidentally discovered with the Maemo Droid4 modem patches was
> > that triggering a dummy QMI call on serial (muxed TS 27.010) notifications
> 
> Can you clarify? QMI call on the QMI character device or on the AT port itself?

I think any QMI command on the USB QMI interface will trigger the pending
USB QMI notifications.

> > int mot_qmi_trigger_events(struct ofono_modem *modem)
> > {
> > 	struct motmdm_data *data = ofono_modem_get_data(modem);
> > 
> > 	if (data->wms == NULL)
> > 		return -ENODEV;
> > 
> > 	return qmi_service_send(data->wms, QMI_WMS_GET_SMSC_ADDR, NULL,
> > 						NULL, NULL, g_free);
> > };
> > 
> 
> I'm fine with this approach if the handling of this quirk is done by the
> modem driver.  The modem driver can manage both QMI and AT ports.  What I
> want to avoid is coupling between technologies in the atom drivers
> themselves.  In other words, QMI SMS driver should not depend on anything
> related to AT commands.

OK yes doing it as needed from the modem driver makes sense.

Note that there may not even be a need for proper AT commands in this case.
It may be possible to use just ell directly, and just kick the USB QMI
interface on any output from the ttyUSB AT interface basically. Not sure
if any thing needs to be acked on the ttyUSB AT interface.

Regards,

Tony

