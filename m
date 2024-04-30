Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058731311B0
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477985; cv=none; b=mHS2mOE3OU7bKUr50OhXUGF4Hs24z8zvNL93ojqiSyuq529S1IXksONlC8Wae+IaWlSc2YK3OzxojbaBJSY9zOikjULtf6f2E8tZVFcme39bP9EVwYwL8EPM+DFOHAcGKntbSrUN+XHf+3Q5LddxkpdemkVrGrY7mYmFzwvIPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477985; c=relaxed/simple;
	bh=i9GvYp8n3wAxoIfQma4rXOJYMJ9lP8azfkUWLidc1LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVfKBwy4N+eVHHkSPGsTpFqUNktFtBnyGkoGZASeLAlby2GyaQRFAGnb6VD3aA8mrN+FNi+fosKLpbx7lD9FWtbFWYsTmGos7kubmFOG87NJKj+/tTjBJQOggeF/D4REiytH9ozfAseZUY45hmio5kxkj4fo14dOrHyL5el9l6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=HUpENskd; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="HUpENskd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=y+E1T6gO6ibNQDkw75ASOsnvzubSo3Sc12aMHICNrcI=; b=HUpENskdFEyXJdYHXefaikiEDM
	nKCv1bWmz5UfKSAPHR82b25MMUflYMyrC1J28rLor3j03nLIisr3k1FslVt5G7iMkf86K32RJm2ur
	XErs5RiIxfp10tfOlicZRhdp0IbnTolS9F1f3RnTqdHD4nmGNVLEAGPA8ZqOz9qktJ6sdhIXbBqn/
	tfb4CJADGznBCHtJ+Dd3K8dxhopiqrc+F6iLeBe0s99dCSngeWsd4HqVsUPcFW8SUXWTfGdEc+VXJ
	Tol7KDsIdm4Km2X6fA9G7uKcVMO8swdlWfOb0FRchTMCNiRUiELctlwAvPGwVLirYK6Oz2POGrboT
	iR16jCeg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s1m2X-000GTu-NG; Tue, 30 Apr 2024 13:52:53 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s1m2X-000LNp-1R;
	Tue, 30 Apr 2024 13:52:53 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 02/10] sim7100: wait for modem to start while enabling
Date: Tue, 30 Apr 2024 13:52:25 +0200
Message-ID: <20240430115234.180185-2-martin@geanix.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430115234.180185-1-martin@geanix.com>
References: <20240430115234.180185-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27261/Tue Apr 30 10:23:42 2024)

The sim7100_enable() returns 0 just after queuing the AT+CFUN=1 command,
which ofono core interprets as the modem being powered up and in pre-sim
state. In fact, the pre-sim state isn't reached until the modem returns
OK, which is caught in cfun_set_on_cb() in sim7100.c.

Delay the transition from off to pre-sim until the respone is received
by return EINPROGRESS instead, and let the (existing)
ofono_modem_set_powered() call signal pre-sim to ofono core.
---
 plugins/sim7100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 4a1ac782..b5e65891 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -149,7 +149,7 @@ static int sim7100_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->at, "AT+CFUN=1", NULL, cfun_set_on_cb,
 								modem, NULL);
 
-	return 0;
+	return -EINPROGRESS;
 }
 
 static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_data)
-- 
2.44.0

