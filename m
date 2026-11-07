Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068446;
	b=iU1uX4zOL+h2ItcLiwLPluUOteq5XKHY6lDqdYb3NQ5WkGkLFGW+k7p9b+ugq2/Hl4n4
	 SqUPCl8zxJAehPAIhrnYzOwYspgXZEL+uriGwA6TtXqSmLkFDGETvbo0fD/8nVbDLim6g
	 iuSYNgmMrT6OHr0D8czdCq7r762vZtSaBwpW+kCr7v0yDvZ9Hl/D+H69v5ewuIFNnkicL
	 HpKPqmskrtXnpjKxgyl/vg5tItRzGgR0HiUNyEzgu0B4cgTLK5D66aKHLoA96MZiKjWHX
	 RbddbAJfCoszVRqp0D+Djc7Jvt8xttnR6PjSxmlsXkGeV/5aMBRsOJ1ropnfP+oF6GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IYoBvM0JMOyso4p6v9cK67Nzl+TRB4hGl//c/EVgF3U=;
	b=vTaFRDnzy4snclYQolc63hWiLO8KjIHMQTz6/gXr7HplqZG+0wnLbWRL0Zsd5WztzfQK
	 Y0F+Chj208Bz5X0iAoWqcvPJ/1R4A98CW04WvfVkp0ZUjje3FyeNsEURfRPEQ1G8omt2R
	 18HCK9G5LqwBUpSOUsKbUHaJ/QNRvqoO5dqcEmyUZZffpJ48/Karze1jGoKK3EqsWIYt3
	 XuUzPP37lkjKpls0DcD6Ydp5GNjaRIWCFmk/A+Z94HIBD554dQFymyLMXg+4SeeXufmPy
	 zhwZuA9n6LTGGNDHT4Brq3gJQ8NGpSiIkgERFKI+lQBv4raspUxzIg+Ztq7YjaWbkdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RyqQlgHK;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF45606A326
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF45606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RyqQlgHK
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so12603145e9.3
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068444; x=1794673244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYoBvM0JMOyso4p6v9cK67Nzl+TRB4hGl//c/EVgF3U=;
        b=RyqQlgHKKiT1M/dftUEj8okwGRZv3ILyyiJ3wMoJTUbxNubU/PxyH4U59gs8eSwXEa
         dot0cil7lLCuW5BP3Ezou4efIA5nxBsP8bv9NakL/NzEv3vl5ZXWtxw2jXhJmzVkycvs
         KT7IQrxxPkwYiKBRctXS0cnjmCt1X+vXySHaCCGX6TB9S0gl1gN5AyACaHp4Jy7UFptf
         t660QU0idHB53Bb0ZhE0wyrLpA/3ijB1yYTk2L5D30Tj5H3QcSNPApwmzEXhENa8p+UP
         PeJl0f/38bKgae0E5NSUEJcLPSj3l+FN/2eGVIAQpEQyv85mhsdve4A83Y3UhGaNcauG
         VzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068444; x=1794673244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYoBvM0JMOyso4p6v9cK67Nzl+TRB4hGl//c/EVgF3U=;
        b=hbq0WkNTIoyTToQi9ZyWm72Lo1vN2g+41Zqho/sbZ6qX5Dh2AA3bqey/DaHxsjNgjz
         PEnCfJ0yCxSqRwfkvvWxRgcd+/iW26yf/iMvot8PdkV8jpfi6xWhTJM1FLb7eHCQ0KaN
         6nmQW5hOMvmQ41If46IthCPr2lpMULpS9jQYa1Gn06ZNmtysCFfwWn4RpUWj/pynpJqY
         q/2FymtOhEPMd2VmK1cOVThhATC9ELtI5AhXLOzCbFfBT5MPjoKj+eO1mik9EMg6NY6B
         Bz/Yny3xebLKrMKECZLmWYkFv72j8u4UOV+huMBSIqvYngfJzigkz8s7xvuF/ZTIdmhO
         TBYQ==
X-Gm-Message-State: APuU4Z9oMTumob1DzRSafBw6qnCdw9J0eadBPG9oFOYDENuScUjlEx4H
	CVhUqLUqBOvSw3sJKi2gfkVlTv7Bja4pJbn2RDKkNb+j0wY6nWEEqLeq8pbqcQ==
X-Gm-Gg: AYBFou0PTGVy7yhCEvFHWZ2m8GGd/9Q/WJzE4fRKL7QJwRwry9/icu+ty6fMydWNmzF
	7snuA/lrJA8fkmnavMNlOVa/I4/FZZrY3wlLK90GGDu7pPTT8o5K4XP4w8FDqpZAHhJ5Y448b0K
	DnG7ghIK/ZZU9msxn/N7EwFEFzaybBIzLs3ug/HcDqDRyAYucC0i3NUMHEIWSqF9KCDOSZzGelk
	pGcjBD6ccAE9RE1+5FUvvOoCIKUZ7zfIajY/m/w8Ckr7vpVg20X1xDhCxBb4QjJXsr7nFGrGrnH
	WTY1/zJWRfkTCAOexjGSqld8Es4geFd46fmtpRh0kN9FEmX8zP+qQmZblGkTvt8KFg27vkv5zzr
	AD021SyuDbE/mqM93U6gdQAx8gCimJ8B89HIqI26mMTveDtDc6L2zFx3tq0gti36BejCPsDYk94
	Zn2Juh9ynFPKrWTNttZLtSRBwu3FhqUOJgmVNoV7L+FIZT2vnZkPrEdLjFG3KO0ydpbKGOEed97
	QkxfeFqi8IRDhO6p0Oolnsp30kePf0uPosopdxVHIcDLspzbUup4MPB9EVFlLS3AgbD7DOn5jNj
	8Ym3qcHgDFreBjhyv+3+a1CKXYkOyTBukDpQNC82mWiUMDCxXA==
X-Received: by 2002:a05:600c:c172:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4b6db2ba61dmr100757635e9.3.1794068444408;
        Sat, 07 Nov 2026 08:20:44 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7d2ad9b95sm87948945e9.0.2026.11.07.08.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:20:43 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] gatchat: Fix possible out-of-bounds read and write
Date: Sat,  7 Nov 2026 18:20:10 +0200
Message-Id: <20261107162010.472179-1-ivo.g.dimitrov.75@gmail.com>
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

The control protocol dispatcher never validated the packet length
field against the actual frame size.  A declared length smaller than
the header caused an integer underflow when computing option length,
leading to a heap overflow in pppcp_send_configure_nak(); a declared
length larger than the frame made option iterators and reply
generation read past the end of the receive buffer.  Reject packets
whose length field is inconsistent with the frame.

Fixes: ZDI-CAN-31027
Fixes: ZDI-CAN-31543
Reported-by: Trend Micro's Zero Day Initiative
---
 gatchat/ppp_cp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index f3f2cc4f..cc2f2089 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -956,6 +956,10 @@ void pppcp_process_packet(gpointer priv, const guint8 *new_packet, gsize len)
 	if (len < sizeof(struct pppcp_packet))
 		return;
 
+	if (ntohs(packet->length) < sizeof(struct pppcp_packet) ||
+				ntohs(packet->length) > len)
+		return;
+
 	/* check flags to see if we support this code */
 	if (!(data->driver->supported_codes & (1 << packet->code)))
 		event_type = RUC;
-- 
2.25.1

