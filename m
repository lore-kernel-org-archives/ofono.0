Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB412AAF8
	for <ofono@lists.linux.dev>; Thu, 25 Apr 2024 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046271; cv=none; b=OL7DWgrclz0ybk5dwl1WVEe2s3/DT1zpKOk14I4h2nCI+p+CqhndOqWz5f5cmrQpf8WDqjvQFmDY0+OG8IW8FlqaEkzRv2jOnxOctjOToWIxMvvbQRujyxEPp6lnKA+O4lin1pLIj9WQJ0iHR3i/mcX0qg6L+OQyDLwfnKCyDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046271; c=relaxed/simple;
	bh=XVFByyb+MOc3AmD6PiHKw2/DdzESdt3vX/3if3HDWvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=noQt72eBysIeOD/xiAZyVqKVS2KaR+rqSy8GC0zEM4SE59IJrPp1l4wfBVB4QqzocvBCm4iF9s77NOC+BULivbgxWna8OZAf38wDuDDaD//aj/Gatmre1W/QSvyhi2R/M5YTRPNhKU76UGWH4+3oWDV277UeBQX/GJ6uy+oCN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=M8cWq7/7; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="M8cWq7/7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=pbOe+I1Ri7izsb8JhG1SRzC6Dl8eSar7InrroicFGrc=; b=M8cWq7/7dP1dGA90KLq9NFtDzj
	KNjFdUdipIbQLRrqTdBK7J3dm9bwzColPw95kTr5qfhamrSFPu+Zg9DhwHgPxcJ891PxkIf2YeWrs
	ibXaI7DuRnALM89K0BhcO5GjHvMH8PTyqLsMFd4Fs3qDuTlYqM64opH9nzpuTq0EVHWZWvmkwNH/6
	9cJRpXTpZQQIpmqc1M+DpHXm7N5nKkO06SeqeqY49osSDBThL2aVqptuR7Y28eJFoGFmgETcThQYd
	T7Am0BLUrwou1y3ggCMmBT5O1d7wmBK526qY0PfjyalnZxnJiuazWkSe7Ikr3W7HTMbGp5bZReqcU
	U0B3bWbg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1rzxjX-000NJA-A3; Thu, 25 Apr 2024 13:57:47 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1rzxjX-000AxO-0A;
	Thu, 25 Apr 2024 13:57:47 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH] atmodem: fix detection of ATD*99 for non-muxed serial ports
Date: Thu, 25 Apr 2024 13:57:43 +0200
Message-ID: <20240425115744.274891-1-martin@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27256/Thu Apr 25 10:27:19 2024)

The gprs context probe function has logic to detect whether CGDATA is
supported by the modem, or if ATD*99 should be used instead. However, it
seems like this logic was wrongly placed after registering for CGEV
notification, which did an early return in case the passed chat did not
have a slave.

Thus the ATD*99 detection was skipped for USB modems using separate
"virtual" serial ports for command and data channels (i.e. ttyUSB0 for
AT and ttyUSB1 for PPP).

Fix USB modem case by moving the check for a slave chat (and the
registraion for CGEV notifcations) to after the CGDATA check, which lets
the ATD*99 check run uncodionally.
---
 drivers/atmodem/gprs-context.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index d92b6392..bfe6ae56 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -458,10 +458,6 @@ static int at_gprs_context_probe(struct ofono_gprs_context *gc,
 
 	ofono_gprs_context_set_data(gc, gcd);
 
-	chat = g_at_chat_get_slave(gcd->chat);
-	if (chat == NULL)
-		return 0;
-
 	switch (vendor) {
 	case OFONO_VENDOR_SIMCOM_SIM900:
 		gcd->use_atd99 = FALSE;
@@ -471,7 +467,10 @@ static int at_gprs_context_probe(struct ofono_gprs_context *gc,
 						at_cgdata_test_cb, gc, NULL);
 	}
 
-	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
+	chat = g_at_chat_get_slave(gcd->chat);
+	if (chat)
+		g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc,
+									NULL);
 
 	return 0;
 }
-- 
2.44.0

