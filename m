Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068206;
	b=ocLhkcJ8ynj7ejHtR3ejqalOROPBkNxRqqwlWOvKbPXYGbYOc9O+fNSFElUTqFfXXGoa
	 Cu37p8d0cYKZITNbfwO6eS4U5LJ3rY0ugigDNKF044l3RGigrVmPjZcuNxe/JWCGiI27o
	 kOl7DYkHstJQVo6YUlx10lIwYf7X2klPUI+w9b42CvHWtFy/gE3i5lVY7jNJZNZggeAE8
	 A1F3gNcWPvEdZI1XyzPrC0DfdciTlEJU8RkHwbbmASyR/gMqncO3AkYhrVMB7g/WCqA7K
	 fbAmnyg8Uk2freUFZqJRtFi4IK8YWwmau5Gyji4+JHb9Xi73QYclQDQTWRfVNHIbL7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Nc2n6xAeheDjBc8rXQx8whDAf7rrfDwnyQr0n7y4OkQ=;
	b=n6K9AEGBqkojjJKBKMRpXzgeA2BZk/y3lSIHQQdFcbHYXQIwc+6JeBCQIW8f/DFk/239
	 QPWgkbcOhVZyq9wLyCcndzUiqsRc+CpFc4UcFix1UFZBcBTw+1Vb+MlTENx1nCi0eaQYm
	 hy3GrTdvHNBl/ocTL8vc/KasSe3YK81eOa7IzsUdSLct3PGGM1gtbosuQLqsSvK1ZKdiK
	 iLFN6Vumw75ioB9tPsdRhJVRKd0VY0/STyGbrd1jaGW93BUH3XDWQXTwnldMe/SDb/mRG
	 9OcTH79FBCqOXvqe1QIm0dcyWCA6kHdX5TK55Unm53V/TLTkE9uuMO/gJfu0Y3OMtkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQ4kuFwX;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642D4606D3C3
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 642D4606D3C3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQ4kuFwX
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so4553905e9.0
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068205; x=1794673005; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nc2n6xAeheDjBc8rXQx8whDAf7rrfDwnyQr0n7y4OkQ=;
        b=iQ4kuFwXeP2vv203VkDws8CnYZG6vuHzvy2hps+b+kn5iyz2OLwt1atd5HI8RdEnct
         IycpVsg2JsoQMLMw9XkKczHm3xN8dbAU/+hRj4jYuJLBFBQcqJrZP1DWa+hu6dZhToYL
         BUA9ZT3Kf9ujcH4+H1P7Y+geNQK1yQPxyWf8Oxu2/a3NS+sCRrwD54anxJvYlKNH0kkV
         ThGhFaZi80WCOoXrGmFf8d5qEY0QHJVE+GrRsRirsUaoqhflM6AyBsm1vVoMz0FstL6x
         q7Zy9V3LuE/Wt4TmSB0YSOlJpsfmljNdaAuKSivZaydgYjQeFMetwYcPOyMDBYJy5ReE
         t4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068205; x=1794673005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nc2n6xAeheDjBc8rXQx8whDAf7rrfDwnyQr0n7y4OkQ=;
        b=dwbtRxC76GKskIDWhVt9buJCupxf9GgVbfaERrYobCsxM2QaBVJ+qKFFvIOI5RFckM
         KhlSl2LzfnPlivVG7ZxpqA8gkt9rJQRogVIkb14S7Z9c7Qog2JPLXGHyPFWhRn/OLh6M
         qityV5ukKoV3OgM5rwhDHeusWPU/zbZW0GgmzyYZIANyJpZmx2Rg3DmvioZqvJugR6OW
         VjCMRGcrFK8BwXDgD4XhTtoLhNorBxDsCgNLdokQALiPVH+984GM4XcX5avRPKf7k2xR
         eqjGcx/+9KrQf7u6ON86Sef/Re6ov3MXWKKrEfpNe7oH+4GAs73H6QhjkSjR2CBwkJK3
         Lu/A==
X-Gm-Message-State: APuU4Z8Yxs2+c8/Qmem2ppxHHdpGTqvf9VfisFbeL76nHign6uME6y4B
	NKgdQUFiLpjtR4Rvk9b9iKLkhRAb4MrRmxAgGBE6cGUcz4I0qn6EBQfAkOQuWw==
X-Gm-Gg: AYBFou1tfacwTsQ996VYxkQftWxgmAyJOT/wS10JzaxxGOWlMRAE+mNBUCzgwhSKLa7
	ffZY0qfldK8LqoMk/s/8frDQ/XtMqBG1M23e9GBi85yajYqIP6OYh/nftny/fRrKCsu9vXW7XEp
	gidQtkjLXh5Ix5aoiEQSPs4QZQwyVAE0mFRXTzIIRmE2VTZ91vuviC9zrvOM4+MOl7MTcUYDR2Q
	ys8ZgRW/wMIsa61ez/5bkaLzuYtdgHWVYCJPUGACaWVHy0DoswcdioRTCQn0ZkwG5AU32myolnb
	CNJ3zEaZ6PVmwZiX8ExzSlCN8j2IpDtVkmJcUHAGwHJYK5Z34TjjZwohfC2vBPN5xX/V6/tik4Q
	XJD8N8gQ2WMK7kYlbnDLqbiYACLM4frC9jC7Mxwbc9OU2mFumu9vyO1n4pgKe7H/V+JFtCzIJm1
	KxfPkyTaN+B1BynEGU/llYDaN/blou/T9kgTC9PIRgkyyLma8y7hB9xzD6Yaivislwb3TwdLapE
	GEpSI/4OmDcEIIsDOtx3BYN2ZIhGs4mFyBEuoJXTHmCC7CSJLDLl1UXzr7Wn5pS8d3ZRP+QKKLu
	d3cwFhPzMHdhoXtX++jFBQl1amt+LlpJCMQMSJqirrEa7PhhPQ==
X-Received: by 2002:a05:600c:4e0e:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4b810df8c0fmr43616305e9.0.1794068204722;
        Sat, 07 Nov 2026 08:16:44 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1547fsm138696795e9.11.2026.11.07.08.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:44 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] atmodem: Fix possible stack-based buffer overflow
Date: Sat,  7 Nov 2026 18:16:23 +0200
Message-Id: <20261107161623.471746-1-ivo.g.dimitrov.75@gmail.com>
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

The ^NWTIME notification handler parses the timezone offset with an
unbounded %s conversion into a 4-byte stack buffer.  A malicious modem
can overflow it with an arbitrarily long string.  Limit the conversion
to %3s, which is enough for the largest valid offset (e.g. "+08").

Fixes: ZDI-CAN-30191
Reported-by: Trend Micro's Zero Day Initiative
---
 drivers/atmodem/network-registration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
index 73693d96..57c90973 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1277,7 +1277,7 @@ static void huawei_nwtime_notify(GAtResult *result, gpointer user_data)
 	if (sscanf(date, "%u/%u/%u", &year, &mon, &mday) != 3)
 		return;
 
-	if (sscanf(time, "%u:%u:%u%s", &hour, &min, &sec, tz) != 4)
+	if (sscanf(time, "%u:%u:%u%3s", &hour, &min, &sec, tz) != 4)
 		return;
 
 	nd->time.utcoff = atoi(tz) * 15 * 60;
-- 
2.25.1

