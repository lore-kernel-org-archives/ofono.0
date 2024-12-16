Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F42010EF
	for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344452; cv=none; b=X/mSc4VrQ03ScAvMipzFpJyrLdno8XX/j55gr7fcFgMGuz7A/aGNoxILTFV51k+N6L/LDEmF0BeDK+2cnNylu1WCio+MkzUt8HhPRhfrjV9+kXjvhOx8VWX7gJwR79GQ0iLjZdaHfvdXag9Lu59sDpS6X15Z2wwQRsNqWd5+mfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344452; c=relaxed/simple;
	bh=sUjNE2HMyoX4vb1YpfYId71c4OT4L/kFHF/x3yQZY8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMOKpivDL2vywS1aPw18OIvPOOVGxiNxJEHCCJCAJCTJyaAx/svqaMuIC8uJdNOQTc546byKgGUUZviqyFsEHgTmuHUFOIuvZcfXZLimMUdEocY17SiCVY8kkymNVSCV94/ZSUFSiUr4kYZHrJ4Rm8uDkfFOhCK3zdcSg02DZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ6uBdA+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ6uBdA+"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6a618981eso642982366b.3
        for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 02:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344449; x=1734949249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NevN2wwzyAP5C+vyw3UFiYN66h6ehOD991ZX3ZcigO4=;
        b=ZJ6uBdA+/4ZvHiH6E98v+l7pAfH/X/07eMNxUn3pE7JS3E1Pw6cXOYB85m83xFPNG8
         iph1r+hH2D0Rhtjd5J9Md8k9DC1o5/ycAx4Z0vHQSLPuJ+a6aqtBZ7uMLK7pZTdYCWWH
         UxeS9uNV0jjf/PHLYHjDbu7UXNd/VgLzyy7OxQgqVCtBrCjlfK+4yMQQh21/DKbe5zFA
         E4eQlbxcUoQ1aatYEWA+C/RQZgBst5smbeXD+loP0ituZLNZwoyFBIIwfpsl5F5SHuad
         3T5P4Hz4xzW7EwR+ItCzVx17YRZO/YSYPXaNlXIXLowgDe0zT+lkJhTK/ATEiVFdccjG
         IaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344449; x=1734949249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NevN2wwzyAP5C+vyw3UFiYN66h6ehOD991ZX3ZcigO4=;
        b=SWEXJ1Zfm3tINGbhqXTukTfZOZie99vC8oNy2epFTxIr8YUZ4LqoKXhiQVwnqWM7xx
         ZymisCI+Ysxoj+VymkFO5CzC2aFzNKDcC/lMmCRChyufgT6DuaYDjNevXHNN4TcaZSpn
         CJHMw90NKryFPJuMTns4ldSpiCe7ZcK+NGezWqDDELdHujNHrVGo8JN52+MNsm4t8j+N
         3dap6X2qAJAs+lAfvg657uQ94iVJaxqqFa9rGMFWKYqav0XTrIS1jUbm8bCIeCm+AZzF
         GCgayLl0t04/1cDEgwMbe/HiZpIv94WIOP+q+CKEDyJ0mA+K4s0Ep0NVOAh6r0RDuZa8
         6iUQ==
X-Gm-Message-State: AOJu0Yxd6hgtz3yte/5/dg+iAI3gj84XczYK9lVNzPi7zD2W5Wxn7Zmd
	p5wnaq+vTLO+iqztjf6jktzGlbbATo0U5J8yYVtnrbXUuVZEa7upOYpu+AGn
X-Gm-Gg: ASbGncuaPZqSENcUrSdC4tbULN6U0TCGe2uvjawICS5xiPlD14m8nc2j7uhSMfQs9Lw
	iRfIFYvzkheoCZQRLu386TOJTcxiUA/9jWYwP+76NDVHJmJyvHBhjDErZGlPBZeRof9nEY+F9Ao
	FnM0qTuRz1MWRledvg+39GQruGPINJJRmHi+NuweehYKHX7M22lAKkxrF6yS8VwthH4kJP5JzmZ
	Hs6BcgdWcuB8Ymfhrx82q76hDNKXE43SqVQpoNJHfrq8ZqgmzYC/KXy
X-Google-Smtp-Source: AGHT+IERPaS8hNu4lQWrwrUCHLQ/mNpvpLFY83CAtc00iPFHwvk9VNwwRGUs7iHOdibnHANblDy7ww==
X-Received: by 2002:a17:907:9450:b0:aa6:7d82:5413 with SMTP id a640c23a62f3a-aab779b3f5emr1219086866b.34.1734344449017;
        Mon, 16 Dec 2024 02:20:49 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab604fsm3026099a12.2.2024.12.16.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:20:48 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 3/3] atmodem: sms: ensure buffer is initialized before use
Date: Mon, 16 Dec 2024 12:19:44 +0200
Message-ID: <20241216102021.345566-3-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241216102021.345566-1-absicsz@gmail.com>
References: <20241216102021.345566-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: CVE-2024-7540
Fixes: CVE-2024-7541
Fixes: CVE-2024-7542
---
 drivers/atmodem/sms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index d994856b..0668c631 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -399,7 +399,7 @@ static void at_cmt_notify(GAtResult *result, gpointer user_data)
 	struct sms_data *data = ofono_sms_get_data(sms);
 	GAtResultIter iter;
 	const char *hexpdu;
-	unsigned char pdu[176];
+	unsigned char pdu[176] = {0};
 	long pdu_len;
 	int tpdu_len;
 
@@ -466,7 +466,7 @@ static void at_cmgr_notify(GAtResult *result, gpointer user_data)
 	struct sms_data *data = ofono_sms_get_data(sms);
 	GAtResultIter iter;
 	const char *hexpdu;
-	unsigned char pdu[176];
+	unsigned char pdu[176] = {0};
 	long pdu_len;
 	int tpdu_len;
 
@@ -648,7 +648,7 @@ static void at_cmgl_notify(GAtResult *result, gpointer user_data)
 	struct sms_data *data = ofono_sms_get_data(sms);
 	GAtResultIter iter;
 	const char *hexpdu;
-	unsigned char pdu[176];
+	unsigned char pdu[176] = {0};
 	long pdu_len;
 	int tpdu_len;
 	int index;
-- 
2.45.2

