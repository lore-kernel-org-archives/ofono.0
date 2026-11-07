Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068534;
	b=SkVVyEuR03efFJmyB0CuDVxwXzYzM8kGjL+x+6fwYDtt02FT8za6qFmwv8+4B52JjMxF
	 GuT9W8HSG+bUl91SZRjotfyE1OW9CgT3/f51aG+LVNdJMr2kgjvvY55F/+l46N+o+bq+u
	 a1GJJqjYI1VEMqbZ9mMl7aO15BUITVH15pNlzuBYkxXAMUVimflO2e+Qs145eIWpM1Mph
	 mkw7YgCO36qU7o4wvcxdAXnWwtb5jU0QjSbM61VY9DzNwp09MSwLLTuWGryb9hZlCy6Fn
	 AQPDpe42xg2P5M/WNKjr4/txlKkIQlA5dhdXfmMtoOHPMZbuDB/559pDH2TslVMWj9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=foJ4rGVp7zAC5Lyno5RtgPx2pvteUl3GbuS4DSC2uXw=;
	b=CEQrK6IjO18X7YJyAlN7aNPHgTlkh3bWxb1Y8zB2qPr5e+y1wG08guwKDj1mkRi1Zwaa
	 k8OAjlq5UheX+tDDmCL2vjIPdII7tgQSi5sqWz3bC9OCkMJTMqASR4rBToLRf5ZhnCVhX
	 DzaAhQ49G+sOhXJCdtXwEeYUA339pd2LhtNvZF4ala/eDIGNhZf48uZgRMGLRn9484thc
	 cu5NoYuMc7GRWtoPjaCMvAlmVu/4x92FnTqVZI4j137P/sharYviZDWgtbc0lfwW+7Ohx
	 W05VLcbvBzQZ7Xyj71cgHhvbk+Ux9AqKnG+DOtN+adRcQyzjkMUNHk0nioc0RNcdRfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W+UrWowh;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F5B606A326
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F5B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W+UrWowh
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so14714025e9.2
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068532; x=1794673332; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=foJ4rGVp7zAC5Lyno5RtgPx2pvteUl3GbuS4DSC2uXw=;
        b=W+UrWowhr0mBzSN6RVucfF3NvDY5nf55wtRtQzZu/J5xijI7afZkBjdlP3EyEjlSRk
         glqt7G7AX9Vq38pX9eG5u0270cWe15INa86O3QMZ/ssVutaHyzKEU0dRiyC30wATz1pQ
         5lxMEnZkZb5nmmiOTk347A1plaHhyyhjQWRx+kGYubglDyPUAoqAhwrx7Ry9l1BhdZWN
         ow4ZpSv99D/OkHO/L5rNW7oPbDu+b0yAZBEP0KRKIhnGxOHs1RNeAqDyMNlpmbslZ3Cq
         QSZyuLAlAf0YTDMGZDBuIAbVlSEw5QiAVEv/+VjdXGTtXjGMc7Qk+RwHGWjOjIVwktA6
         Z29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068532; x=1794673332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=foJ4rGVp7zAC5Lyno5RtgPx2pvteUl3GbuS4DSC2uXw=;
        b=GvUdGt/u/oT1/f4C6LLqSmUXsd2PnmSvmW9v3edEFUQBFC7TatifaBDiHLM75K7yjD
         l1JOhIa0+g9DJCCsBNl8HT/OcaQTN3vLJvBwVfgFvZYg176D9s/LJL7yP3N8Z1KzExRE
         8YSJwFUAxWm2DtnaE4xlRCYokubU/zVybuT+/bQY4arT+G+bp5ORYKk23VQcKWT6sN1P
         0zHsqQsSFAFN80blvQmICp30YWLjw5S6b+ZdeFn94Ww4Mx3hep16bzMWTv1Twr3M5BKU
         UK5E8JpwkkUm+SVv1aOZOzTakEqV2mriIOlvLzjfvzQXe6q/22o402Pv5iJ3HAaA8WnZ
         2LSQ==
X-Gm-Message-State: APuU4Z/XaC0JxvvTJ2p2ETIONMM51TK3GdJRtohypgfizUTShdViCNJA
	sEzVqKfKt1ACirQfg3MnO6HD0gmIIu1uoeGfgr/vJ4UAzOdPicjV7kj9czykkw==
X-Gm-Gg: AYBFou3bXJcKSXLXgcEAeYB8Iuns2UeUei8MXHtdziOzVErllQNHbytzV6lXsLGmBBp
	rvuDQphciiDrdp6WXLGUOsOGCilotqv86eSgohsplOpJ17qXs9F6M+O9yebiYuDC6UU8L3JUXqU
	/4Lb8GEMwoT5P/oSYy79DXG0BCN16bMYBQWw2Bqhtt80NqrvF8uHDCrAfm2RNLw+/ZHak+V2y4S
	7WfYyi1wIwfMQcBuO2blD/Ruv4MBhIlaHMyBvyaufwJ0vH+xRjtDzc8LkR2B3rgF4IsS9NfwZYm
	1SB9MLqwYA1k8oO1Q8fXDUyZqDDo9B9nRPDbiD62s0yPiSVQAlLgtCk6wu9n92LxwsXFqE6H+1P
	8mJ3545bX64ZxwNFAp1+W9/n1z9jBB3yVKzFh+NjtlsXi6KX6xO/CCsnAKGPUY/4813nqKPfqvl
	pLKT+F2D8ptbqIpct6efTex3E1snOWJPM24mfg5snugguVcJ2AYOseV8c861GCE++ETNKJ1hqzg
	r0oq9y2d9EKWH3URK78dDnQXfir9uT+GnlbGMBY1pTLp5bo/EBY9VpQMHLa3PDQRYNWyzSNttYJ
	MVhk3DoSP4+plf//EQYxDL7ogQ5XjLvDddTk86cPyDhyXWUVkw==
X-Received: by 2002:a05:600c:4f13:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4b6de1c645dmr113387805e9.20.1794068532114;
        Sat, 07 Nov 2026 08:22:12 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e329153esm90432725e9.14.2026.11.07.08.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:22:11 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] mbim: Fix memory leak when reassembling messages
Date: Sat,  7 Nov 2026 18:21:49 +0200
Message-Id: <20261107162149.472331-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Post: <mailto:ofono@lists.linux.dev>
List-Help: <mailto:ofono+help@lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ofono+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

message_assembly_add() did not take ownership of the segment on
several error paths (unknown message type, orphan or out-of-order
fragments, mismatching fragment count, or a failed single-fragment
message build) while its caller unconditionally re-allocated a fresh
segment right after, leaking the old one.  A malicious modem could
exhaust daemon memory by repeatedly sending such messages.  Free the
segment on all paths that do not store it.

Fixes: ZDI-CAN-29088
Reported-by: Trend Micro's Zero Day Initiative
---
 drivers/mbimmodem/mbim.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
index c405761d..f12f2e61 100644
--- a/drivers/mbimmodem/mbim.c
+++ b/drivers/mbimmodem/mbim.c
@@ -169,16 +169,20 @@ static struct mbim_message *message_assembly_add(
 	struct message_assembly_node *node;
 	struct mbim_message *message;
 
-	if (type != MBIM_COMMAND_DONE && type != MBIM_INDICATE_STATUS_MSG)
+	if (type != MBIM_COMMAND_DONE && type != MBIM_INDICATE_STATUS_MSG) {
+		l_free(frag);
 		return NULL;
+	}
 
 	node = l_queue_find(assembly->transactions,
 				message_assembly_node_match_tid,
 				L_UINT_TO_PTR(tid));
 
 	if (!node) {
-		if (cur_frag != 0)
+		if (cur_frag != 0) {
+			l_free(frag);
 			return NULL;
+		}
 
 		if (n_frags == 1) {
 			struct iovec *iov = l_new(struct iovec, 1);
@@ -186,7 +190,14 @@ static struct mbim_message *message_assembly_add(
 			iov[0].iov_base = frag;
 			iov[0].iov_len = frag_len;
 
-			return _mbim_message_build(header, iov, 1);
+			message = _mbim_message_build(header, iov, 1);
+
+			if (!message) {
+				l_free(frag);
+				l_free(iov);
+			}
+
+			return message;
 		}
 
 		node = l_new(struct message_assembly_node, 1);
@@ -203,11 +214,15 @@ static struct mbim_message *message_assembly_add(
 		return NULL;
 	}
 
-	if (node->n_iov != n_frags)
+	if (node->n_iov != n_frags) {
+		l_free(frag);
 		return NULL;
+	}
 
-	if (node->cur_iov + 1 != cur_frag)
+	if (node->cur_iov + 1 != cur_frag) {
+		l_free(frag);
 		return NULL;
+	}
 
 	node->cur_iov = cur_frag;
 	node->iov[node->cur_iov].iov_base = frag;
-- 
2.25.1

