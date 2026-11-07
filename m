Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068248;
	b=RwemuPcwLK+6H2Xc1SY3nuzdIObOF4RWe1OaYtTk9oid3KlGpt8dChM2+hIneloUdN7Y
	 DBQgPmATTD2TiSngSRLoAhsX0nzglLWzt+yRmT0uUgmeg3QWrzYackvkH+Uh/ubPTom0W
	 8lf/Sm37wdlA1R9SAGeZX5z2d6kdq3NO8/Zc8oLb8RCD9pwKbq8ycHDRaQJ0OF+a0g9cG
	 KI5zrfFR6HUgzvz7HOdj2hksRV54gbJIVw4hQ4bERr38bvW9t6mE4sBBef1bFRjKVkV53
	 kTbLCcFBUWwXLaG32AEQ10Rkc3UBYebee9nYOCHEgrd7RDZzQrDzKbFZZb4uEw5hmPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iccjEm7VM9g6M4B1OgZt0SpX/WNUmPhvqUb0+LHAzT8=;
	b=OsPvnp0fnekd18H1oNuxa1KFqHy5qPbho0p6coag0GfQeyVm21w8QS3H+IaGy4FsPDS0
	 qoq2QSipaAUzoV2inVRB0oWaL59OmBUduT9ro3cRSSQhL32An+j+icmWlii2s+eAHHY1X
	 Gnjz3YDFVzWO9FDxeADnSWfCNmmC6GRXrHXuAB1givHZBtbLUJE8xtkLoDlO9hmWoWZuO
	 8LbD408NvEpE7eqfUZ3lc1Fm48KMmooUD5Q1cXRcneOoI5JqxVy13d223tciH8WQAqntw
	 Wyf4ngXPyHBTCucTV87UvZUFUGr2QPIs6Ssc9PshFcdspmBdBYzdRo4DeP01K0ngkQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AyFs0V9k;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5E606AC09
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F5E606AC09
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AyFs0V9k
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a210470b49so10853755e9.2
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068246; x=1794673046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iccjEm7VM9g6M4B1OgZt0SpX/WNUmPhvqUb0+LHAzT8=;
        b=AyFs0V9k+A/P+8qji1PntcIQnZs0puL5VCWRlT47bL8KDu+grxbFOJ7MBv4UM3s1PB
         9sKRE7bEAwrB8JsRmB45oriZMisoFMOURvTH4GURHNwQ2Np9gG0dRgKuxmUscGvIc15H
         T1XHM2Jx5wcdaqS49nXcmhqDmWRG2d6LP7eQQFMnzyvpTxg8BZk2L2mIMDmQOLR73W7x
         1pMrnAyDmwsXMKJb9eMvFddnusI9T9/KQmdeCwsCJIz6tpAEQGZc5yDdFfJgmG6cufA2
         D+mCfslNDUK9fdZQII/0c7VtWLnLmIGMMEABENKD5hDweErhPgtetenuHgrdJdKiVVfO
         0axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068246; x=1794673046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iccjEm7VM9g6M4B1OgZt0SpX/WNUmPhvqUb0+LHAzT8=;
        b=oXu7o0wp0XrPOHmNYRq67Rrmf80LHdKdwua+2lXMXVpqQ5CHsECbaFiHBgK8ygHlF0
         cQr8NgzDVMGlN1zL4L6dPjFLRi1HKADTvQLa1uFTZyZzSju7a4hOcE5/YX2JvHsZ9L8/
         0J93i5bw7kBU+aCMqchWzr+LT93wDN6l5oqO+KG/E8GoEPOv+/8zIwri1z85dvQ3dKBO
         KThCB6M1c5XKrBNJsBfUWjPXERGZEDxeZPTJH5zQIGOMueK7fDcm+fVZJCvcPrdA6OtV
         k6NbJHVjVTFq9kcao9C/kulbCSkz5Xr2VDVgubV13+4MA7h8lP8mNyx5++lJY5olr2Qt
         jVPA==
X-Gm-Message-State: APuU4Z+HIlp3ryyVqp696jWxvWnj4nDA9e0ZD2QuqX3LE0G55u/X77o5
	KGOijq9C1S109CLUUsX27PIUjc1/Nw6q86fcsgWzA36BfVwFwSkJncign75iEA==
X-Gm-Gg: AYBFou14OAeuJtEFNZzb8tzPhmweaukFaPbrNxj3Ttj6cNe+WszrsopxLCmQGCeq5d2
	xvRwA2TJ+AjY3Z+YuJnC+XsStV6ldK378uUEJ+WO5WxNs4dJ2dRq34ijMF4pUJKkv//2zN2vbSb
	qDWp1lb9qZyES1/rDFlOLXqdIvT0v1agYBbr4N0IxRbINT5bQ6auUZ1PfUJBrFruqulMe71gZNM
	2uW05APBRqV19B7t5kvxlU9X0Taejzi5Qyg7l11pbkHxxUvg7EZPUMvZwGBMU8O03mZmXyTauL3
	1Rypp3wi1A7J+yE8431yYiAlTbVwyzrfUd1mN79woUeGj/fWBxZ8XfsG2Es2sppIUaJMqXcfaKF
	8V7kO8qJ7BvPK3Kb9cX0sdXm8JsBJpyC2ACjdKO7Pw7q7KnLmJzq80zs8QABmTm88QPTHIEj879
	BDVoFLO9D2PDYavigK3j6STShwiOzWt8QChYACnNYswhuRh6z6s/y204QYSE0AR/sGBt84aubQ6
	E/7FuvuJj4I7VO8i1M1YiUNpWAgvXcn3b5bicVI+QivdOXjSyb0GgP8LKbCK2yOR4aAHpiIltOT
	Rz1r0DDNgHL5hDRgkInoOFD0DUEbZNYAHtVfBGF0uf2Ks3Kx9g==
X-Received: by 2002:a05:600c:8705:b0:4a1:cd83:b23e with SMTP id 5b1f17b1804b1-4b6d83a8593mr95799935e9.0.1794068245778;
        Sat, 07 Nov 2026 08:17:25 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cb75913sm68229035e9.0.2026.11.07.08.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:17:25 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] gatchat: Fix possible heap-based buffer overflow
Date: Sat,  7 Nov 2026 18:17:01 +0200
Message-Id: <20261107161701.471819-1-ivo.g.dimitrov.75@gmail.com>
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

The HDLC decoder writes every incoming byte that is not a flag or
escape into a fixed 4096-byte decode buffer, but only resets the
write offset when a closing flag is received.  A modem sending more
than 4096 bytes without a flag overflows the heap buffer.  Drop bytes
once the buffer is full; since the FCS is no longer updated, the
oversized frame fails its checksum and is discarded when the next
flag resynchronizes the decoder.

Fixes: ZDI-CAN-30192
Reported-by: Trend Micro's Zero Day Initiative
---
 gatchat/gathdlc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 8a7c5b1d..fa5f9f22 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -242,6 +242,15 @@ static gboolean check_escape(GAtHDLC *hdlc, struct ring_buffer *rbuf)
 	return TRUE;
 }
 
+static void hdlc_write_byte(GAtHDLC *hdlc, unsigned char val)
+{
+	if (hdlc->decode_offset >= BUFFER_SIZE)
+		return;
+
+	hdlc->decode_buffer[hdlc->decode_offset++] = val;
+	hdlc->decode_fcs = HDLC_FCS(hdlc->decode_fcs, val);
+}
+
 static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 {
 	GAtHDLC *hdlc = user_data;
@@ -285,8 +294,7 @@ static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 		if (hdlc->decode_escape == TRUE) {
 			unsigned char val = *buf ^ HDLC_TRANS;
 
-			hdlc->decode_buffer[hdlc->decode_offset++] = val;
-			hdlc->decode_fcs = HDLC_FCS(hdlc->decode_fcs, val);
+			hdlc_write_byte(hdlc, val);
 
 			hdlc->decode_escape = FALSE;
 		} else if (*buf == HDLC_ESCAPE) {
@@ -306,8 +314,7 @@ static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 			hdlc->decode_offset = 0;
 		} else if (*buf >= 0x20 ||
 					(hdlc->recv_accm & (1 << *buf)) == 0) {
-			hdlc->decode_buffer[hdlc->decode_offset++] = *buf;
-			hdlc->decode_fcs = HDLC_FCS(hdlc->decode_fcs, *buf);
+			hdlc_write_byte(hdlc, *buf);
 		}
 
 		buf++;
-- 
2.25.1

