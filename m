Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A492010EF
	for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344444; cv=none; b=Tsxv4vlw98A2lheT26fHsDebjEOOk0TlVmWEW6680g0c4xnLeW1Fgnr4bILirzvhKe05apjpI75WXF6lD2H41mB26rh24YXz9RNZ1iJM2shE/K+eNpBHuRZswK7IWDJ8H7zzic/4qq1z7O2y+PMAzRDB7TnrLf79+vxC8ucPJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344444; c=relaxed/simple;
	bh=ILZAYwUk/DSCT7EuUJZ2MMDiq7SKf25AU6N/814bC+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RymrCSZcM4p2v9TOzqL3Ats1x5m/shz12IYJarW0+8cwkZ9wesjbnGsHQay+CZ4p2wj1Q9kzstg/zfDN9hYrxURnGDCJgDrIV0dyR19k0gsusfplKDFGxA6P2m2HlSBdOUI5lB/oFzUd/CWsT4+e233yYazALZIOdWqmghmMxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km6MY0Lj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km6MY0Lj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so7404794a12.2
        for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 02:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344440; x=1734949240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJsc4o1c6jnSv9LOCDTRbPOWWQRnItGG2p5/yupt4Hw=;
        b=km6MY0LjFEVsFcITArt+KcFS7RHzy0BDkBS91kMgIthR5uEa9x6lrsG0lOHO1n7+FI
         uR9oJZ8ws6+vuQvnbk0SxgJ4+QHnj/69SD8TdZHEBkyyJDFQb/cgIH366m3JmK7PnuyQ
         qn670om8YZ5+0zQ0M/sgfj/+/fnJ2lxQszcy7l7tAbG3o36pGqzm4gBP8H+UUv40c75t
         sUBjYFMGq6MrEUg/Lfkq6rnwgXxlbGLuprB6GBUk6OCenvv3Ohrh6oDezHhjjk7L0IFb
         nIZ5c3sP5o5EOziboPsqSWd9+7NodyXAhwwyaU1ctiuaChsGRQpaakdSJxROI04ZdYMe
         Wh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344440; x=1734949240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJsc4o1c6jnSv9LOCDTRbPOWWQRnItGG2p5/yupt4Hw=;
        b=b/sddAhPQtqL+eUQHb95FpIiBwBlehiTHSKWvh6Xs8bQz/ZHcbDXzJFEsJxhqzRyGZ
         yLN2qfCr2E18m2NPveG0oLvCrscafiGsVS8cZdlRd7Vdp/ykvAYfpdBA02EWdppd32iP
         SwXJLgQO+RwG2ijayyQbUdL3zuXI5MpyDkGkCVBP6sIsghIbsZiFzS7gbyBrd8pFVddH
         +87d4a1NxistLTMjT5rX6IPZQnoZW7FxEoui1bJpjD9Ze5e3f0RZtfLVknzR4fAK0Mm3
         bs4aE0XbUvq442TBmoROYRiaAIVWpfe27ZQ6Cr0XHW4io0x62tk8PbQ679LVQLz+QrYf
         mgfQ==
X-Gm-Message-State: AOJu0YztUm6nGHwVopkGKLJfdIYZuCHtCTeyLqTFmPTBrX9GoYRT1MOE
	DGkkw0CbQDwpn+TuQAvNDawxS5Uf9sPqzdtwvUdlqACAQFQA/aGY8ODutw5K
X-Gm-Gg: ASbGncsAqRFGMWjb/lYxYW2aU06jGNPiyXG1TUTXUSW25EVJdX6qNz0b2TIhMbaSsgl
	sGPKvi3U8YbeWeREI2vHsUQQEfaIFMcEK3CjJntOBscZcv3Bpo/Mwni1Baqbm6hv6/am4sXKMbk
	5a9CVkeP9/m/hVIy0UVtWYk5rlMrzJGvyjPWHZy0HeVS2jqL8ibGBoWhWCtJ9UyajkIn+qY+Yha
	ITdXmxr6OAEx3y7C/szcnFdWnw/GqS0c57qFmUDP18r29tLEuM+g4r4
X-Google-Smtp-Source: AGHT+IGcyK0pxLycJG6lmbRUV5Ec/9sx23ZXY2ijDp3BUltQk3KQ9o11Cuvip6wJ3evdlsE/1GR2gw==
X-Received: by 2002:a05:6402:1f8e:b0:5d3:cd5b:64a9 with SMTP id 4fb4d7f45d1cf-5d63c3c08d7mr10886777a12.34.1734344439816;
        Mon, 16 Dec 2024 02:20:39 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab604fsm3026099a12.2.2024.12.16.02.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:20:39 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 1/3] util: ensure decode_hex_own_buf is passed a valid buffer
Date: Mon, 16 Dec 2024 12:19:42 +0200
Message-ID: <20241216102021.345566-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/util.c b/src/util.c
index 53d55d7e..bfe46ef2 100644
--- a/src/util.c
+++ b/src/util.c
@@ -3181,6 +3181,9 @@ unsigned char *decode_hex_own_buf(const char *in, long len, long *items_written,
 	char c;
 	unsigned char b;
 
+	if (!buf)
+		return NULL;
+
 	if (len < 0)
 		len = strlen(in);
 
-- 
2.45.2

