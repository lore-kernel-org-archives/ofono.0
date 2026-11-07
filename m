Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068630;
	b=Y/9UOqQ7o9okEBbwCEIOgODb61qNIVUO9qhLmPrvEwvtdRgQn8d5M5jRrF+S5VcC+7Ha
	 GLvo8PYCXIq5a3IOea28733i+XIUn0VzN0/n06IW32HustXJLMdmsaOC4kUCnRf1WobCM
	 mv/7OmPU/RxopSOkIqJYnw2hdb6/jpebznBnp2+9eXd+2wq4j2cQZhMK1Pw0dlvrqfjUW
	 cZB4SYMtDx8BZspuIjQWoPhutJba+AiA1zKXU8TI5PmtvbqU4No60pzE7JGqT61gt2GmB
	 HILH6rQJPmnwIpPJ9LL/uOVjqbUVtfaGhKNYgemNo6HI9+HdOd0mMpa4t6zSJk/ikrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JzM0PFn4t+jOJ02XhuGNvYCb7UVOQNVu/xOSLrRagX0=;
	b=yszJGv2TgJmRPFvOXSEhz3RXyOqRkWKkYG0qU/TrLffknR0H8zhVA5etpdNdqzZcxPge
	 50okjWZE6b9Qx+vIOK/qxFpDX/GCvIhHcOP2oOv0RpcPWZMPdCcMO9iGsbv7+V9mTj9fV
	 ce/fp89x1v7UWxM0rr58THBJJxVkcdTkmAUP2E/zBHPEAcyRGvv17Go0nsvP8ZxVhx1AY
	 eHmnUA628RhjBARm4atyMk4aeg1wlwqWX6w2W9zF0ubS6bDy55wjwBijArq3w4qqomi8l
	 rS64vO73oZOtbUn4pbRNpzvLmzMgfSVFWxDPCHsSFyRJI60ETGsysT9YnM70MVs5/Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fs7g3AXg;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793A606A326
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6793A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fs7g3AXg
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b467581b98so12574915e9.0
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068629; x=1794673429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JzM0PFn4t+jOJ02XhuGNvYCb7UVOQNVu/xOSLrRagX0=;
        b=fs7g3AXgsJRk4zQ8KQfs59nc/AgaUjd+/NISgu4zzkeicb2RKU+IkXuJir5kDxfana
         bMmQBlSk+TXbZUTU+yUSUbA1KGT2CIvdBxd9yU8kO1doDlSgFTUYBdL0CZGSLLhUd2pi
         /nhdyAiDZLchPCDVZvuGq1sO8Hy3X/N+GFDJM0h5ynCpRAZOv4CSANXfAbsaLz9YCOhO
         jJMoUBs2pK+43Oh7P3x4iODrvNUdFqs0Dvy5Da27+Vob7TYldIwsY1Zby4ejyLGlf7OF
         mg5ASZpqN1Xbrqgdj2z0hoSvLjZdsXD4tAvJw5hyTlwH/MRwdRQSU0WStJ6J9w0RgYGt
         EOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068629; x=1794673429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JzM0PFn4t+jOJ02XhuGNvYCb7UVOQNVu/xOSLrRagX0=;
        b=txFFrmVRZczz//ZSyLrtXJe73lEqY6Olyr5iLS94a/FBlSthR4zHHBX3kYeyBmFa69
         ja64JrxYHEZUVj617ZLiUFepjA8jC3SLakbCQqpiDrLBx4sOB6g+g9jrZb2//bPSNKGT
         d0zz+zYYK2op6+QbGapeem4EU/WAwHMOxmEJIsjFlwzpJbapkauBgJrhtLTITYlzMjhJ
         2/k+Pd6SfNOMC/wPK3++sjkKgeyKYar40SX+p8HVKGrdmN/ehza45ympjLmpDPkYzEsr
         lWAXlxzfMoXMkEeNoCrGG6WH+JHiENz7024N4sJwR1QTQRTCns7xvgoJHaFETAfvEt5T
         HUwg==
X-Gm-Message-State: APuU4Z+DcXK/aKvxis84tH2wIR1Q9jaEozP6iXDbhcyoiXtrOOlr5LNQ
	NrvquWy1I9qNORl9WWyjU2GwiMrxOs8AL/Qx9zdOc2JAT1PHcA8c6O2t5RlLXg==
X-Gm-Gg: AYBFou29pw2JAKiUxu+NB7FrHENDLQoMUmUt3ewKuRuaxVYdk8x0vzhuNQX8sIUSGbp
	oM+RPLGRp9jNgtr/J4H1YtrvC2/OJjueDhVUJiBXMyl88UGtZkqcsL4kPBSPdDJjMb9brV0kVsp
	25MjMx1uGoKYb042v8gOgO+BLVfkUDguefc3JyAaV8ein/8ewNRfQzMTvpW3jzntORXQ3uEGKLq
	5x0JqKRO05V6ND6n1kaMtMvGFLaMBEReW+SfSc85YZYOUsILYn+VgjnXXBiF6x9DaBNtbZOdLB9
	WeDxCq9zm4C3q+v2i6N1ap7AK2r9FgJrlz4/NAd17Gt2yPvsrjTskxC81qie7R8XwLvQENbI6Cc
	CW16ZT2LFI3l6hQ6WoNi1P/8UwhbfwIJJRLhQOH3JE+cT0VLrS833x/1dXmUSDVh5yZsuupHxJP
	E1mL612zH/JZwyGy79znUMq0jq+WCJqJJoo3vsny1SYzivkIOGvLBm2S7C6LUxCHqqoARwTeMpf
	D6IMAKbSk1Fs9Fah/svQnsAYUIvyMfjIO2HyirOeZwMAJijJSO8XtdOGhKyTpvl9BKbaQLtd9eT
	R6FcyruDn35GbYm6w+gnljr0JXD0XzaXq34xEl3HbsmLTieSgA==
X-Received: by 2002:a05:600c:529a:b0:4a1:d675:b031 with SMTP id 5b1f17b1804b1-4b6ddee3235mr95085805e9.6.1794068628721;
        Sat, 07 Nov 2026 08:23:48 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b8af10dd35sm66768625e9.4.2026.11.07.08.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:23:48 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] gatchat: Fix possible heap-based buffer overflow
Date: Sat,  7 Nov 2026 18:23:15 +0200
Message-Id: <20261107162315.472471-1-ivo.g.dimitrov.75@gmail.com>
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

The PPP option iterator did not enforce the RFC 1661 requirement
that the option length field is at least 2, and could read the length
byte itself one byte past the option data.  A peer sending an option
with a length field of 0 or 1 caused a guint8 underflow in the
computed option length, which ipcp_server_rcr() then used as a memcpy
size, overflowing the rejection buffer.  Require at least two bytes
present and an option length of at least 2.

Fixes: ZDI-CAN-29663
Reported-by: Trend Micro's Zero Day Initiative
---
 gatchat/ppp_cp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index cc2f2089..b4d93e71 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -232,10 +232,11 @@ gboolean ppp_option_iter_next(struct ppp_option_iter *iter)
 	const guint8 *cur = iter->pdata + iter->pos;
 	const guint8 *end = iter->pdata + iter->max;
 
-	if (cur + 1 > end)
+	if (cur + 2 > end)
 		return FALSE;
 
-	if (cur + cur[1] > end)
+	/* RFC 1661: option length includes the type and length bytes */
+	if (cur[1] < 2 || cur + cur[1] > end)
 		return FALSE;
 
 	iter->type = cur[0];
-- 
2.25.1

