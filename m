Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068292;
	b=3hza5HdJNObEccwHnWIjVk4Y/pxbgCAmEY3jgxBSDQu/BqMS5XzVtPn5+TuX9Sb+QRAL
	 cT7/P0Aq58JMKFKbO7J9JvJKFAzZPsftEU/xzpHGeyPhUY5tpiQvwFhn49pXIG+GUiGfm
	 Ej1Dmpquv/JjnbYs3dpkoe+rAiEhR/vUIdSTVzJvHzsYiX0d5hXT4OLljvm2lS8FMIhvx
	 vFIOqKu9c3voflXEPbYdSzoUOyG1wMwC5K6shjP+3g7bpCVSS/ysl69yXZw0ugJ9PTmkO
	 Gfemd0Xd4ujp+cd3UOMUZN2tGA5ckRskD4Uhey5X0Xffe4yvtXKZ1+Rrss97G9OWI8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yAjkDhXHphDC0iNcA3DVy9TbHQUJVYUFYl9wkDkGU/A=;
	b=s+b/86weuicxSk1abYidInQLB/6cyr7tgt8HiNS1WJtCN6FBhYM715MQsncG90o/HdaE
	 hgAl4GTyMVE7F77W2iSm+w7f9R7thNPEmtZivXTIEwY7qrOWewgYKGuEvbrD9pMTLof1+
	 NKg+rtc+2cX9rhyO1X+cAveEwuItZ8QJLaC4TYAca36kjd/Tnq6qqjtMFbxZXT1o1jKyk
	 lZ1rUhDRQSaAGDRWUnIvM5veTfenult7eMDH9xDgaopLqtq0OJtPkQ3yHhbIBYddra5Jv
	 aX6cNlxdzT2YJ95fWn9c0aLuF+NQT77io4esakJwPNvN6rdSofJzCNLdw7le1ui0e8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+e5G4NJ;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712E606A32D
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E712E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+e5G4NJ
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so13110185e9.0
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068287; x=1794673087; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yAjkDhXHphDC0iNcA3DVy9TbHQUJVYUFYl9wkDkGU/A=;
        b=u+e5G4NJwyjRANeQejknbkMTX26CD7AeYJ2hEWWn7sP57xpgDhvzxYWUSDlvfnUioZ
         D7fLz8Mm9iHcA9pUOQRd5RWHlDMaqz5CB11vmIBOJDSn+xUFMUpu6SwYQnWpeNg69G15
         jm93NRMx7BWuLGaoh4ELWpPydVWZg+FH5GYONCXmHAPsFUM6hsXBbwx338P3h5oip+dc
         45agxS1wCpJZ2ZQgtzjcxSzKusuioeERZnmd43lVnO21fF9nl2mIPJxr9S5cG4U+et3l
         PBb7hwtgsud8VMnsl4C7k+mECnHeZ80kNgQPDIkENGI9JL+/vH4VRHdZijo4pATrcfhx
         zn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068287; x=1794673087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yAjkDhXHphDC0iNcA3DVy9TbHQUJVYUFYl9wkDkGU/A=;
        b=VolPuAiH9l2zmBt+mLng1pFsngOuAQg1fHc+aneyXQLLn4c81qwScMNl6G4oFuNnjG
         4A92rEF7mkqdIcqCIFT+wZ1rdxXXQaYHgPYmSnUyaUeA6U3VBnmJM6Qix6zt5M/aP8Js
         RPb41XGzg4sgjvW72D3V+Qv+1te20Jvp3a1RXB5QJlhKvt+y/KKNtDIgKM9M6JM+lt9h
         6PzeAdJZlQMQ9vBueDHjt+JBn+32/Z2l8JLYw7QOCO/SSq6N0TSXJwOihMBebkD63FWG
         9KHyAJTUB9Ubv/ofQQKEPBaItXVXnVXASJJzwDXaH93yTkcZXvO8Fj/Eh7gycjqiffyi
         dW2A==
X-Gm-Message-State: APuU4Z+7vy6xs2jkoIjkzqTxc1T2W31ePC2EFIUnxp0N/9XCzUrqqrc/
	Rq9OL2T0VI2r7kxdS1GIyOeiNpbxPs/ABUBn5LRdiRiskLZERNr4bQnju1jOWA==
X-Gm-Gg: AYBFou18Q4ggzCaozYICLk0f3laW0X5z2S2xDkSOPyPi+NS2xyylxT0Mb/XPlU04dsI
	IncMo92GEhjr2F8GAwimBG9uhTmJ8Sda8aD8whbGq8iqIrTUiIpv7QnE50orl/uwOfa8r7mtNuv
	sfeeiHjXf6oYord8k8V0RFHRGYoPcaKw0ovebIyUTuGZfslGH7wfXvCKs5XyoX4QvVhFy973MWH
	IIolG5g6JC4GqThk90xrKHbbHhGL+sMUPm8uqMUisYxG88YghUBq94UYkefv1oAAeLionToI8hP
	StRVYG/FUaNg+2fB18FoibT2F+yHMAk5xYduh6XumlXzJQaZs613yli8bJ9mef0sR1rE8Zu49QA
	WIMNsEjPvrLJAMNf6t7oqAqpQlZWyy8XZgxCG+7wlg6ngrflEQhUwp0SLAQtmHR9zw4YVvhyZB1
	axTCLGTwFkyLGi/ebYjUOrdRevv0kfso1HgDcnunK6dNqAD7jzXIeVBONbNG321mwbus2mKTWHa
	90ZuLPm1qCOfdLQBVKlQeNma9dIB3CFMokcSN56uQYhbIE2aeAiAhPR4h/YYS4o0FsQhbokrZCy
	F9imN+09N10/9jOQ0I3amau9UXie6KtXiENh6Xxo9FguDewSdnhwPEdxjoDk59caN9BpvVE=
X-Received: by 2002:a05:600c:4f4a:b0:4a1:e6c8:ff74 with SMTP id 5b1f17b1804b1-4b6e0267f51mr107715765e9.29.1794068287251;
        Sat, 07 Nov 2026 08:18:07 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32b46a3sm83312035e9.6.2026.11.07.08.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:18:06 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] gatchat: Limit MRU to the HDLC buffer
Date: Sat,  7 Nov 2026 18:17:33 +0200
Message-Id: <20261107161733.471895-1-ivo.g.dimitrov.75@gmail.com>
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

The peer's LCP MRU option was accepted without any bound, allowing a
modem to negotiate frames larger than the HDLC decoder can receive.
Clamp the negotiated MRU to 2048, the maximum frame size the HDLC
layer is sized for, so such frames are never expected in the first
place.
---
 gatchat/gatppp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 307be641..e6ebd165 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -41,6 +41,7 @@
 #include "ppp.h"
 
 #define DEFAULT_MTU	1500
+#define MAX_MRU	2048
 
 #define PPP_ADDR_FIELD	0xff
 #define PPP_CTRL	0x03
@@ -505,6 +506,13 @@ void ppp_set_mtu(GAtPPP *ppp, const guint8 *data)
 {
 	guint16 mtu = get_host_short(data);
 
+	/*
+	 * Frames larger than the HDLC receive buffer cannot be
+	 * received, so never negotiate an MRU above it.
+	 */
+	if (mtu > MAX_MRU)
+		mtu = MAX_MRU;
+
 	ppp->mtu = mtu;
 }
 
-- 
2.25.1

