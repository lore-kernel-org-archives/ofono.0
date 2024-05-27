Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7A13C835
	for <ofono@lists.linux.dev>; Mon, 27 May 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807578; cv=none; b=EJZCaKkbr0SOliWAFlxdIfYYUdvlymHw8Iuyh1lYyqZiM7qvFxauf3dTPTd3h1pIV/eJOL8dNYp2/WHm8hmtI9gHegbnC/tPMH82tly15DnA9odQv8JXWqn5H/FAjtMGWzc3AoTuyv2bsZXEJnM9IglxGLq11Tajcohpvj3uxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807578; c=relaxed/simple;
	bh=80HrD0Y4LDczL5PvrSNdvRsamUpyoCtTCS/nLJRgkkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXqTkOTyYyLgT3ys9Ic79fMiRvQUJtBRJZ1qZzqky+pG/ly8tdtJz5zewSEIPdVHcDDcCvya/5Tv0Gp3Z4iePOxD65UoK0d7HWN4gcdgRvWVMyziOUtLBGu9Hzbog4hsYLTClV8W26na855mrsWcwoWIKYakQQNoumD8NVmYohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=iRf7q3XF; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="iRf7q3XF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=8pfgSbmTNAUei0SAGQrYJpEcQk26VKiOB1DwgAbYNBQ=; b=iRf7q3XFH2b71fS+Rceer04X39
	EfWc1o09BPpAGiuGYx6p6vqCdfEhcySZdJoSJiEieARM0g8QSzpLTPuPfzqqAeixNLZ3z3I6dLcFf
	HGoufwhLGcSN/y3o+WCrYe3Tn0evlhVDEJLDF7uh39paQ6NOrzcvvXh0KkDRqpS9GYR/B+A0FCTH8
	OAndluRTDOivPx8ixPcTsnO6XK7+hrOKEKEZTXnzSHSMiJl0ci5yeQJsa4B9touGsMxVn6+RTQeXR
	nrjrW1ZYo52H304uADktCOPxsW7XOc/3d92aNFqBVK78x8kUUtV18JLppz/vh29NxuBnWnhG4H1Oe
	TwYlLGYQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1sBY4i-000IUc-15; Mon, 27 May 2024 12:59:32 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1sBY4i-000Ecz-0e;
	Mon, 27 May 2024 12:59:31 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Sergei Golubtsov <s.e.golubtsov@gmail.com>
Subject: [PATCH] atmodem: gprs-context: use default PPP ACCM for Quectel serial modems
Date: Mon, 27 May 2024 12:59:07 +0200
Message-ID: <20240527105915.637532-1-martin@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27288/Mon May 27 10:29:01 2024)

Since commit c8ed7162 ("ppp: using RX ACCM = 0 by default"), the Quectel
M95 modem has failed to establish a PPP context. Instead, it
continuously logs this:
    PPP: event: 9 (RCN), action: 1028, new_state: 8 (ACKSENT)
    PPP: lcp: pppcp_initialize_restart_count: current state 8:ACKSENT
    PPP: lcp: pppcp_send_configure_request: current state 8:ACKSENT
    PPP: lcp: pppcp_process_configure_nak: current state 8:ACKSENT
    PPP: lcp: pppcp_generate_event: current state 8:ACKSENT

Restore PPP functionality by configuring the (protocol) default ACCM
value of 0x000a0000.
---
 drivers/atmodem/gprs-context.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index bfe6ae56..0baea4a1 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -163,6 +163,11 @@ static gboolean setup_ppp(struct ofono_gprs_context *gc)
 		g_at_ppp_set_credentials(gcd->ppp, gcd->username,
 								gcd->password);
 
+	/* Quectel M95 fails to configure RCN when using ACCM = 0, so set it to
+	 * the protocol default of 0x000a0000. */
+	if (gcd->vendor == OFONO_VENDOR_QUECTEL_SERIAL)
+		g_at_ppp_set_accm(gcd->ppp, 0x000a0000);
+
 	/* set connect and disconnect callbacks */
 	g_at_ppp_set_connect_function(gcd->ppp, ppp_connect, gc);
 	g_at_ppp_set_disconnect_function(gcd->ppp, ppp_disconnect, gc);
-- 
2.44.0

