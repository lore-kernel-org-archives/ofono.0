Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69847F53
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868551; cv=none; b=mjEpriDCffCSeeRlzJ4lHdn5WPaKlj+hZNID4s8qNe+VO0YfyCievr6HGVeATVLMZkNAZ1FT+JZ5xMVVk61kM/J5//Zja/EKnOE2qkeR4oPXPQEAumd0JEdCzboARCCt6KLWGEEGOfSQjPbiqxjmPnZMrbk9lgFMkgkQA2gtQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868551; c=relaxed/simple;
	bh=ajg+ReZb7Gs7vzjvg7Mpd5yfXNn00L1DFuCPgvgTQPM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=ljiBz2UQxNXXPO3m319TCtCpd3Smtibq2m9XgGQyxsNuozfsZtKIz2NKOZR6+/99YXp75eIvZiAlUFbzhJjWBYVQauXLHy2RhACUApibzgnhC19sNRNuo9QwRaSLkiPM1UI9cAtOJMLztz04NdcdG91valFlD9sBGfD/zTntGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WkPExFeY; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WkPExFeY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=To:Cc:Date:Message-Id:Subject:Mime-Version:
	Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ajg+ReZb7Gs7vzjvg7Mpd5yfXNn00L1DFuCPgvgTQPM=; b=WkPExFeYE7hakKngsU6YgdhnZg
	byKM0AoeQJxePyjsIBN/KcRtzGe/gTMeUtmkFUeQ12z30J8hkwevWuS8MVHuc4lkyTUSghw3h+zty
	JvjHoxALku6qjywj7JJ1JOfOabb+bUjgxkbBcV3k7gqMJhxwEX12mFN3qcSZP6KfUTyKhyQb9a5/9
	klD0V29z7bEQS8nXiO32Yz80sSgIPIq7EzC8v1aUyEVucwEWa3KDgIf+ac/s+WKYvYYP2Kf8kPqhC
	OyTScV/14NJ2nq8iCOGkPygbzZ8ha1C6N0gjxA6/advjLNVZeWTildATDmxdDlaZhK1bsASI79lM4
	RqByZ23g==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sKCE8-000JiC-Bj; Thu, 20 Jun 2024 09:29:00 +0200
Received: from [185.17.218.86] (helo=smtpclient.apple)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sKCE7-0005zp-1A;
	Thu, 20 Jun 2024 09:29:00 +0200
From: Sean Nyekjaer <sean@geanix.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: qmi: differentiate between lte-cat-m1 and lte-cat-nb1
Message-Id: <13BA976A-5959-4708-97F2-77285400EFB1@geanix.com>
Date: Thu, 20 Jun 2024 09:28:48 +0200
Cc: ofono@lists.linux.dev,
 =?utf-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27311/Wed Jun 19 10:38:14 2024)

Hi Denis,

We are using the Quectel BG96, when online Technology comes up as =
=E2=80=9Clte=E2=80=9D.
We would like to see if it=E2=80=99s connected via =E2=80=9Clte-cat-m1=E2=80=
=9D or =E2=80=9Clte-cat-nb1=E2=80=9D.
It doesn=E2=80=99t look like the QMI standard is supporting this =
differentiation,
I have also looked in libqmi and uqmi. Is this the correct assumption?

Via AT commands, we can get the info:
AT+QCSQ
+QCSQ: "CAT-M1",-62,-88,168,-11
AT+QNWINFO
+QNWINFO: "CAT-M1","23801","LTE BAND 20",6350

Guess we are in the same boat as the folks from "RFC - Add AT interface =
to qmi device=E2=80=9D thread.
We need to add the AT interface in the modem driver and in some way =
prefer the technology from the AT interface.

Br,
Sean

