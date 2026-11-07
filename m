Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068403;
	b=g54Z5WIRywi+7GJDuaFAoufjmJt2p8QkZpmDeeXkWdsMufpyCp+eYAXkz8CPy1kRoFeq
	 gOK/zTbI1rUz/1r91HhHGOHG75AyZGrIcQ/As44YvMg7tzuiEmySdkfYKknsFJkJW7NdH
	 0PcwxZnse3dHdNx3LPwFpTfRAde3mXPQzc7A9hf7giJtlSmBA7UpvpsTQ6sdoMgJRVJdQ
	 SCB8fGz7TspzY/egRtXdE312OU33hCujutnMwgax2C/kWb07j6QKjYj1YwK6DHxn8/C6l
	 3ptp5RmLI0yH+JrSPEnvnfqnaNvqwht7w7AyW2tEP8XVPxVl3aYSHork0e6CSFftGKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=X8fSlRozd32SWNYEdG7Fz40/mNYCjIxfKvbK3u0HDoM=;
	b=qDBctLvfuDyrrFV52F5tDWiuTeyHMUk9VHDwhTsKoJAKlysD9L+8U8C4LuGPPMbq5cRz
	 8Pfqf5UDi/e4SA7f0aKqCaEb8yIdJjJshLT49KgLAGC35XdY4DcF2CIfuLRuFVGjRvi1p
	 Hd3ia7IXwY3/8/nPCmw7emwldYf2Vwi+KT4Ok1nD/FfxUbaGOyCE/hrevi+IXTnSxaW+d
	 XrKE1qof+uNc62iNpVKj5xykhYrrjzBgDFLO1BRUNXaxZDFEIUedxVpzptCra7Wxa7Lm8
	 RRkHaeS5Us9ymykwlmAoT1sX8oxw+1aa1yoGvuySnqwhHX1XBxloJ3Tanf0z0clvIKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=byuCTieS;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CD606A326
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 394CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=byuCTieS
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so923286f8f.3
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068401; x=1794673201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X8fSlRozd32SWNYEdG7Fz40/mNYCjIxfKvbK3u0HDoM=;
        b=byuCTieSjeLcUvrbM+wdp9R+m8ezjNyEkxWgfy+5b1AVfVHSa1GKTHCeP+cRP9ajdp
         w2rw4MWE2hr1p/Zd9MBIiTlxXuA1SKZ9IZKEFOsGFGbUk5zAqXDVogBNR+rlJEpxt85j
         1OThZP8LlNIpNHecnUbaRhcHyJc2mDzsdB8nHer4H4CFUern0D8vAVlEXc6umGtBQu4x
         GHuA3SquRC6jESOD26taEnriHL851Y1wjM4jjKPSqOlvo4bf+2vuE1OA5jvD6vVzcQ4Y
         9lBErXUWltnFlj8GPfYIlRQRBuOzpe4nyaa2ajYGyB8EEabGNb1fiWhISpK9sIQx2BUM
         sE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068401; x=1794673201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X8fSlRozd32SWNYEdG7Fz40/mNYCjIxfKvbK3u0HDoM=;
        b=HUJlyWJ08V1U/NCAKyyB1wJ9+XhVTRgeNV3jKQ5vOjrs+GHHjxtA1c8gmTXgA1yNih
         /FlgBqtVTNcFRbJtL3KzjmlOjmlY9nPc6UoJSQWxETUHKplxEt0PAkoemOMkwh+RJJ+q
         iL2Gpc9DADmAwg+yCVcOyBuGXFuuQr5gARAVaCWaH6IDHdVkEEicxMNeUpvIGtBNO0ox
         wqdUl+HWFxQqdthAQIn6vOHsSvpMIO+3Q3na+kT01gT2f8QyKacnxcuNXpWsFVd/hXdI
         U7nz9kG4imVRlN8g51Y2ZjR/XwdY7TTlFvDRzUmDf6/wiknwIepF4dwsBmb13w29zY8G
         8LGg==
X-Gm-Message-State: APuU4Z9td/g41K2vme93/h7gqTTTN4kXG0HtAgzpOwNSSzVtgwE24xSA
	kwXAsHPdNAWYrlNClf5YcOjSS2oHaBUcFqjgKiV/xkIAPb3uVrE6JXYd5OFTIw==
X-Gm-Gg: AYBFou2aD3Pe3uQgUKJf8nAl/lWAC4xozy4kAHRYup6l1m3SviHFCL++HYGynSHeSxg
	gytuSc2aATqNeE5UNA8YOt/wmCGQtDo5wYjASyC8R14fGgNls0bJfni6qDI4rXMmM3ALcQvfdXV
	UVRf8mpsm3XkQM6i6hTTKv4j8UTwtFdB8kvJXWHPQZgWtLKWe9jzRZymKyWXm95lNmOwi1C4UBW
	tKUdgnraew6v1X3+x1N4lpb+tu26STDuh7BKDvL4TM8ct+V8Kk6M6BWMiPWEdpVTuiePwz8E2bH
	J7vRyfaxCViCj+LIIEaGFZdb6zkCmqFedTb8GSzk+iTdZku/ziOvSk4tcJj0PWcwbbk0o9f1gM2
	G7lO2VZpBVtOrlP8vzNgDfxaq8A7kZzQsadJdAyR//+GS5ftsX85NtChGvct2UC/sQKdIh5qFhN
	3224BPWKYy3dd/Jw2uHVj0l5zL4r+fRK+s/nnuFwCIruUwa5jvUvNLhUD8W2ryps4NXWWfObBR5
	arrQUfuHsak6sUX32LTmTy5PcbosYIk1YE+/qHZf72nJuoByv7LuGwJcG80hMocNtPOItBJUEAp
	VXgqMObXuTshvjsALu7UH0FN3/gcRNAQt9WoM8zk4tVleoUovA==
X-Received: by 2002:a5d:5e8e:0:b0:48a:f404:695e with SMTP id ffacd0b85a97d-49278733ab0mr9788745f8f.50.1794068401518;
        Sat, 07 Nov 2026 08:20:01 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4930a5a91dbsm8383911f8f.35.2026.11.07.08.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:20:00 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] smsutil: Fix CBS assembly double free
Date: Sat,  7 Nov 2026 18:19:47 +0200
Message-Id: <20261107161947.472111-1-ivo.g.dimitrov.75@gmail.com>
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

cbs_assembly_expire() freed the pages list and then passed the now
dangling list head to g_free() again instead of freeing the node
itself, causing a double free and leaking the node.  Free the node,
matching cbs_assembly_free().

Fixes: ZDI-CAN-30141
Reported-by: Trend Micro's Zero Day Initiative
---
 src/smsutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 84895c4f..7c8a82e0 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -4228,7 +4228,7 @@ static void cbs_assembly_expire(struct cbs_assembly *assembly,
 			assembly->assembly_list = l->next;
 
 		g_slist_free_full(node->pages, g_free);
-		g_free(node->pages);
+		g_free(node);
 		tmp = l;
 		l = l->next;
 		g_slist_free_1(tmp);
-- 
2.25.1

