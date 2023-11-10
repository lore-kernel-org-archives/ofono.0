Received: from castle.weinholt.se (castle.weinholt.se [194.54.164.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAA134A0
	for <ofono@lists.linux.dev>; Fri, 10 Nov 2023 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=weinholt.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weinholt.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weinholt.se header.i=@weinholt.se header.b="5sf/MrQ+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=weinholt.se
	; s=castle2021; h=MIME-Version:Message-ID:Subject:To:From:Date:references:
	user-agent:in-reply-to:content-transfer-encoding:content-language;
	bh=cR9DhogpICZzoky9pz+9MYwDlkYPKK8rdD8bXJ7DLZo=; b=5sf/MrQ+gu4N5wv/cWTjx/7Mgp
	ytat6de1klT2PMgrcB0uxHmvoS9ObptxTz3HLuoSQfOO/xuFlvsvqSW2XyKj5NKZprExJVsuaOlur
	KSrYX1PvB8JYUDQL6wZexB78MZjUbm3q9T9PGTn3HXSo3nD+xByLk48r6AZel7dhpVI6jFfvLNbWu
	AoMohtpKuLrjTeCL6ivRPh3KAcZ1LGIriUp3H+EHNNme1m+i9yLiO5yDQdob9ZYr+Mfq+OaqyG0iK
	vQvJMy+/9C/nJQipoSfTjLV5soCL6l1+oJO+weP9Heg8XUeXS9Ivrk+Oi2LOwstLWnbgh9VqTi2G4
	citrjdEw==;
Received: from weinholt by castle.weinholt.se with local (Exim 4.96)
	(envelope-from <g@weinholt.se>)
	id 1r1NxJ-0021dk-2Q;
	Fri, 10 Nov 2023 09:37:37 +0000
Date: Fri, 10 Nov 2023 09:37:37 +0000
From: "G. Weinholt" <g@weinholt.net>
To: ofono@lists.linux.dev
Subject: SIM7600G-H: cid 1 activated before atom registered
Message-ID: <ZU354V7zyCseX1r2@castle.weinholt.se>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Weinholt Consulting AB - =?iso-8859-1?Q?G?=
 =?iso-8859-1?Q?=F6teborg=2C_V=E4stra_G=F6talan?= =?iso-8859-1?Q?d?= -
 559403-2707 - https://weinholt.net

Hello,

I have been troubleshooting a problem with a SIM7600G-H modem where the
LTE network does not come up after reboot. It can be worked around by
restarting ofono or connman.

A symptom of the problem is that the context can't be activated manually
because GPRS is marked as not attached. I've verified with both the modem
and Onomondo's signaling logs that GPRS is attached and oFono is wrong.

# dbus-send --print-reply --system --dest=org.ofono  \
 /sim7x00_0/context1 org.ofono.ConnectionContext.SetProperty  \
 string:"Active" variant:boolean:"true"
Error org.ofono.Error.NotAttached: GPRS is not attached
# mdmcmd /dev/serial/by-id/usb-SimTech_*-if02-port0 uart 'AT+CGATT?'
Starting with device
+/dev/serial/by-id/usb-SimTech__Incorporated_SimTech__Incorporated_0123456789ABCDEF-if02-port0, command
+AT+CGATT?
Received buffer: AT+CGATT?
+CGATT: 1

OK

There is an interesting log message: "cid 1 activated before atom
registered". This message was added in the commit "gprs: Ignore activated
contexts during init, list them later". That commit was followed by
another commit: "atmodem: Implement the list_activated_contexts callback".

I found that reverting the first commit makes the problem go away. But the
proper fix is probably to implement list_activated_contexts in the
qmimodem driver, as was done for the atmodem driver. Maybe other drivers
are also affected.

/weinholt
