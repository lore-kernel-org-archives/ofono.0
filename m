Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E844C7B
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924755; cv=none; b=E/iOOLNwcWhD7m9y0snQxDSyGLoABSyuRglNBjrX7QSZEr/5+hi5mU0oZOVO/Hxg3ZJQPAMbqQFdDMJ+eSwQUQOKa2DnNdFzaBRYkuOnGvYOtXXVvSMhbD2BIstthEpEgYALOzUM4+XJsUHfi54+qhRdfw+8xntojuYYmAqBi8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924755; c=relaxed/simple;
	bh=uFUNaE/7jKQ0MEhKGWB3w3xNjYX8m4m8QbzvQu4tuQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ta7ucmkgikPIha2JZm5Z7KfdoNaMppvNchU5qJy6XAjrrlh89/pBrqPIt6bv1p5qMZf1enA7FZToOJI24NVJxFddLslizbTQDm9Un6jq95tFHpV2wXw2PdWFiAnIOrs7tLvhVfKUyEYcMUy/UZ9+bEtZTrVfDNF5Xy7H0eOGTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7ZfSxRX; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7ZfSxRX"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b998092bdaso746213eaf.2
        for <ofono@lists.linux.dev>; Tue, 28 May 2024 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716924752; x=1717529552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPaldu6RYcFbFSFsAGtZhs7LqeMETBGiP3boYTS5b3Q=;
        b=h7ZfSxRXaYfnjq8MbkM3+0BkvKARqEb6B1YIDCAGBbX1jHtlCt9zjVmiRjzOyKW0Pm
         vRtjoToW07QTi6h/xHAbU8HlhsehCRr7fdcdfSSs+Aj3Z4UD2Fw8qLXkPbAYwXQBoqQt
         27I9ZW9s+mUe8zMP7PbwtRM4QcB/JbcutyDI4EuJWuItt3LOQgwBT0T55eh5BCECq2oX
         3+7W9WvihfEPa6Du1lMXAiToyh5z1Syj8TQ+LY1W+sWJRBn+6OrE9LWKun02vvj4OwYH
         teJndjqZyQ6aadjiMkWXWTDhF/iYkkGcLCdSWexM9azU7p1zKR2YEFqOw/6MTAwj9S0h
         nnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716924752; x=1717529552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPaldu6RYcFbFSFsAGtZhs7LqeMETBGiP3boYTS5b3Q=;
        b=o5OfyNPVtEq/c77HqkZUM7ARoq/QRJWK1TTesES/lXcRn2eGULrAQqv1Xx5hlgj7z1
         BRrrkDlVaChv9Cage7waTGu6JmoiaXn4WCDA4G8l1Bx/LFqkX5eYkQWt6o3MOxxvEOpu
         9Chgx3VzBwG6VQflz3EngWo/HLrhVY0NckrxzUHwgezHWzYqaWN0xHJNSMx5wRuDeBBT
         FnyifojnMj/y6B/823oM0iI3b6sA3ARw6JROGtvoc3jVODvvFLDHrLJlCffJKDkYZN37
         wxAl3BLWfcgmd2yPqg2o9BMWFodZ0ZacZzweVuxY7lxK401m7DzGCDjb4AO5ih+1w6K/
         NbnA==
X-Gm-Message-State: AOJu0YygvPRMsRv4vNQM4iqBTs0HWSQEjZE/VauaCH4v1nM6wcq9Cq9d
	2GD7NO/WujHOufDaXpLFu1XtepTnKABrqR0EEs8w2elVWBKwLexbkutM9Q==
X-Google-Smtp-Source: AGHT+IEXPLYn3ktavLhZJxlKIF4Pp9R1sOp5aIR/Z2735+u3SWYv3Ju66adzVYWEghd0WwkNjo6k/g==
X-Received: by 2002:a05:6820:2291:b0:5b2:7677:4f27 with SMTP id 006d021491bc7-5b961a66ba0mr14800982eaf.4.1716924752628;
        Tue, 28 May 2024 12:32:32 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c699953sm2278337eaf.31.2024.05.28.12.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:32:32 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 1/3] build: link dundee with ell
Date: Tue, 28 May 2024 14:32:19 -0500
Message-ID: <20240528193229.225499-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 44fb7b1baef0..e60f4f2d2bee 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -991,7 +991,7 @@ dundee_common_sources = $(gatchat_sources) \
 			dundee/dbus.c dundee/manager.c dundee/device.c
 
 dundee_dundee_LDADD = $(builtin_libadd) gdbus/libgdbus-internal.la \
-			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
+			$(ell_ldadd) @GLIB_LIBS@ @DBUS_LIBS@ -ldl
 
 if DATAFILES
 dist_dbusconf_DATA += dundee/dundee.conf
-- 
2.45.0

