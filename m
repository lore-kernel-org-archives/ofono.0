Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305281C07D5
	for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036720; cv=none; b=l1jtb4ZFX68RkJjHjVwlj1RuBFVBy/bB4bY/7EnN7tGx4w1rIp/ZJfuWny2NruX1cBJozXs7Zp4HiDR2RC9ywb9fIiSBRq8nHZ4PhCAiy9JkxsEfi62jAY6fRvDEngao3Mv0PxclDywn9xvxb6R3OTgFjgpn+nMQGLAiJmnBKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036720; c=relaxed/simple;
	bh=oMuE9RPDU2bT19YhOEMpTCghj8RXXKcG6iBi+ffV6R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vfk/7TwxxKfqbJAMIrEonRjtlObab6eNOISX/is0/Q7mJFCj7h/DzzEzW3JpV+43QONaCKGncN2gRVovZSb2xYxWxi64+M4MVv5NiS2+zju8F3TIlrXRPKySvwGl7bvktmw/qEJAagpZguL7prkn2vyGEwiW1MJaAXGn0NydJQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf6KHGhc; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf6KHGhc"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ee58c5c2e3so2015378eaf.2
        for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036717; x=1732641517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIRrEL/8rJLv9xIWnP8iJSawwIE6H+g1FdDCd1QdA98=;
        b=kf6KHGhchhdqpVD5xPbFbwKdobjpDzn1WgO29zhybrarbVTrcRSLLUoFfhJaAsVfGD
         qGMxdKvCnY0t0qPFvizFhRWZ69ZylX0TuwpNlQpeJAavx8lrI0V5yjr1v6JMz5CiT3Oh
         /gJVZRJ/viHnAqt85Fa1QkvMzhUiH2aBCQauitkLAbj09OTInM+IiwaoBo1eR9gj5ofI
         xohPg+1AgcDEq/fRNfJ7n/FjscnGrtcv7C3eq1jT0HhkqyKpX7LSIETqYhYXBQhQqxnk
         KJbRxs1IaCcvkNTERHhghGZ6RFZaiU7yfXOC9ouDYguXV3PBRRaml8YZoA3ZaWvW39a0
         uRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036717; x=1732641517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIRrEL/8rJLv9xIWnP8iJSawwIE6H+g1FdDCd1QdA98=;
        b=MsVIhFGrwjIsZ/kotfM/V96D+uq9oEjXYSUJYoz9pOIvnMYsIEXIXt6IiYJhtyLI+C
         Hxv4nrAcfeSG5qJZrrfd3fMMms4NCYgQFW/SK0UNHqf2PNPloXrCmEEn+qIIVgKg0yjW
         kBUEAMCwWb3csauOhfe0KrKWBmYSKn7Bi76JIFbu99lTH0dauPTJMcGT57DM8rs7gRP5
         jRJV9yxvZKaKn/2NwsMCSOQWqG7ly4bVbBWkoanv4wk/pafRK2rCB0YehqaUHqllec15
         xNQHH7Gx8PsXhLZlO2d02nkHw6yJZr4XLmQBERRuvc6anitTb2SHDoqa4gskkmlHjccs
         r3Qw==
X-Gm-Message-State: AOJu0YzfLAc1fGS4/SKQFfJq2CaFvAlFutu4wICuoFzTMG3e1bMGSdsR
	NKUK3KKXpzFh1+mvuoxygZaJx1CdQYMyODn3uEWY8r+PNv0itBtqqj1erA==
X-Google-Smtp-Source: AGHT+IFDo70De7g7WWsWTLhLX+mJb9/uMJcgcJWMgZXkLwwon+iUcyS7Z07DuHlSV3/lf0eZFMk0jA==
X-Received: by 2002:a05:6820:1a0b:b0:5e5:b652:9d14 with SMTP id 006d021491bc7-5eeab28ce0bmr14480254eaf.1.1732036717181;
        Tue, 19 Nov 2024 09:18:37 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eeabd7feaesm3664016eaf.39.2024.11.19.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:18:36 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 3/8] rmnet: Track link notifications
Date: Tue, 19 Nov 2024 11:18:14 -0600
Message-ID: <20241119171832.1119-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119171832.1119-1-denkenz@gmail.com>
References: <20241119171832.1119-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track link notifications that arrive via RTM_NEWLINK and RTM_DELLINK.
This will be used in the future to try to de-conflict use of RMNet
mux_ids that might have been (unlikely) created by other processes.
---
 src/rmnet.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/rmnet.c b/src/rmnet.c
index 325f1c503ca9..5f40fcabcfb7 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -27,6 +27,7 @@
 
 static struct l_netlink *rtnl;
 static uint32_t dump_id;
+static uint32_t link_notify_id;
 
 int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 				rmnet_new_interfaces_func_t cb,
@@ -193,6 +194,23 @@ static int rmnet_link_dump(void)
 	return -EIO;
 }
 
+static void rmnet_link_notification(uint16_t type, const void *data,
+					uint32_t len, void *user_data)
+{
+	char ifname[IF_NAMESIZE];
+	uint16_t mux_id;
+	uint32_t ifindex;
+
+	if (type != RTM_NEWLINK && type != RTM_DELLINK)
+		return;
+
+	if (rmnet_parse_link(data, len, ifname, &ifindex, &mux_id) < 0)
+		return;
+
+	DBG("link_notification: %s(%u) with mux_id: %u",
+			ifname, ifindex, mux_id);
+}
+
 static int rmnet_init(void)
 {
 	int r;
@@ -207,6 +225,9 @@ static int rmnet_init(void)
 	if (r < 0)
 		goto dump_failed;
 
+	link_notify_id = l_netlink_register(rtnl, RTNLGRP_LINK,
+					rmnet_link_notification, NULL, NULL);
+
 	return 0;
 dump_failed:
 	l_netlink_destroy(rtnl);
@@ -215,6 +236,7 @@ dump_failed:
 
 static void rmnet_exit(void)
 {
+	l_netlink_unregister(rtnl, link_notify_id);
 	l_netlink_destroy(rtnl);
 }
 
-- 
2.47.0

