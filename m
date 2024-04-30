Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593413C9C3
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477985; cv=none; b=WqKZR9zZcTb0RFFDI0bGVPrNIm6vduf+zR9jp6LbCBjYNIwgreMZpFWo1+qEx5/7Kalk+60EHlhlgXGySvF0/xll2Dxz7pHYVVWbLBqJPn8LYXSueIpu0dv/zydLsC9bnhyz4pm2SoJzhUjDHelICLIBE5SbgOnbvdj+c2sHCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477985; c=relaxed/simple;
	bh=L7B1SYDaJHNyobc/EAkEV5AvykQ4AuEyczxZ9njm5is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMRLaAq2QK6A5xMiqbv5GAWPCXTA8Z6R0JJJw3mTlO9YLVLzCfkD642+yPpZcLoi/owRDDuw20k4wpCJ43/brmrODa2DW0F9XezkTV862tvrvJio5VDDBNwcyJ6bzeGxKtG0el5L6aLGbkTAtIKhj433lTMvVJT0UoMum2IUVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=AfX/dH4E; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="AfX/dH4E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=jfoG/wi23tkAle5QqIXIEdUK8IKZ70XZ93bT60EKosc=; b=AfX/dH4EDW6epX0MzqWRGhZ/Iv
	KASakvxCe2pKoQhRr1LV9q6ULIzuT3cGF2lv7I54AWdDyNA5Ogb2ObVvnVxvZxdYAyCgLsaBcd5zt
	I8lHiqty6T7B5rFq5uCLwO14aYJITClJkGZgLzgI9jEZPPEB8jfxzfbkMxd4xUd3y1UGwFL7uyD6R
	Hh37y3ORKwaf1fecPzLd2+KM08Y9kTFNissc3pqUe68At60xc/OzflBs86EFUq9wT37iAHFT19bDj
	J4YkYnIgvpNtr6EqiIVaSskWIXruZDCRO2I9BbDFrFbya2WYKUNdTw+ZPkIy45ie0PsHYEnO2tAbs
	zzAJjmXQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s1m2X-000GTt-KK; Tue, 30 Apr 2024 13:52:53 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s1m2X-000LNp-0y;
	Tue, 30 Apr 2024 13:52:53 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 01/10] sim7100: simplify serial device opening
Date: Tue, 30 Apr 2024 13:52:24 +0200
Message-ID: <20240430115234.180185-1-martin@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27261/Tue Apr 30 10:23:42 2024)

Replace the g_at_{tty,syntax,chat} dance with a single call to
g_at_util_open_device().
---
 plugins/sim7100.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index c461cc32..4a1ac782 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -57,6 +57,7 @@
 #include <ofono/gprs-context.h>
 
 #include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/atutil.h>
 
 struct sim7100_data {
 	GAtChat *at;
@@ -67,7 +68,7 @@ static void sim7100_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	ofono_info("%s%s", prefix, str);
+	ofono_info("%s: %s", prefix, str);
 }
 
 /* Detect hardware, and initialize if found */
@@ -115,36 +116,14 @@ static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
 		ofono_modem_set_powered(modem, TRUE);
 }
 
-static int open_device(struct ofono_modem *modem, const char *devkey,
-			GAtChat **chatp)
+static int open_device(struct ofono_modem *modem, char *devkey, GAtChat **chat)
 {
-	GIOChannel *channel;
-	GAtSyntax *syntax;
-	GAtChat *chat;
-	const char *device;
-
 	DBG("devkey=%s", devkey);
 
-	device = ofono_modem_get_string(modem, devkey);
-	if (device == NULL)
-		return -EINVAL;
-
-	channel = g_at_tty_open(device, NULL);
-	if (channel == NULL)
+	*chat = at_util_open_device(modem, devkey, sim7100_debug, devkey, NULL);
+	if (*chat == NULL)
 		return -EIO;
 
-	syntax = g_at_syntax_new_gsm_permissive();
-	chat = g_at_chat_new(channel, syntax);
-	g_at_syntax_unref(syntax);
-	g_io_channel_unref(channel);
-
-	if (chat == NULL)
-		return -EIO;
-
-	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(chat, sim7100_debug, "");
-
-	*chatp = chat;
 	return 0;
 }
 
-- 
2.44.0

