Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64205A937
	for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346898; cv=none; b=QuS3dlVF7PmMfpqU5YNwcyHFr+/kR+7YMbW3pTNOhKO7rOsqDdWOWqSinV0MWmjU2TZ9U3hGVBAn3cn6jo/5FPvF0O6BjwtLaoKtKTO0OhiQQXJUmmlPWiykYhlCYYdldIWTXKFZWTla/EeY7M+uXZL8atfIkNia0fwuZc8riqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346898; c=relaxed/simple;
	bh=ZvTo4mSEZvWYC/6FSfhljKDJoALQVPrJXBOajtsSsJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxMbqLiL/1iQm1lp2BFvq2VhskdzQ4m8hyMULLJ+wEonggQXtFLaHcOTWEVLMTRrYpG/MPM93pakVaDB8p4KD+qlzbsohJhHnORbfKmAXPSAfkfM7Y4ZSDke9TTdwmtnf1+aarBzC48kJiEGw5R4n2/+UDFmFuR4hjOiXohlviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQDMWJVk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQDMWJVk"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa67f31a858so736494466b.2
        for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 03:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734346895; x=1734951695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B+O3dcA9s0ua/YpNVc+6ZFqISH4mKs9Hq4NLRDgvnM=;
        b=NQDMWJVkJQr/L0T/zLnno/xOJVfS7SYl+AgAQAnBFoTwMmmQatdekX/QxRo9TW8Wyv
         XBUNaX2Cade2VV5AAWZnQap+Pa2oMGqNiaW3xW3J9ZHFhS6lfrLCZrvfgxh9hdSs0gIQ
         2w0Gh/egkhxPi3FGLI+8qDePkhBcxJPKUha0LNNLsoN/ad2SZyNRaG+nmHljuh7Ehk2u
         zdh/A2sjx9SF/Hj7R2nHZ6MeSe8oXc3QdWez13yf+t5S/zXCPbZcIpqG0EJLQkrv0F7T
         qAdsAXB5XJ4XvHPA4Xn1FALi3r3xSqxJ1UzZn+yt5z11MCGGi1BWJ5ycCaMFzfEFTTLd
         6ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734346895; x=1734951695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0B+O3dcA9s0ua/YpNVc+6ZFqISH4mKs9Hq4NLRDgvnM=;
        b=RDT2TxVUDwvstMKE0U6bCswOAiQafGNPYpQPW1CKSjODNhpzOkImcDfFIkadLf56zO
         iKbRUEyfr7Aiiy+E6J4gIa1hAnbgPB7fn0TVRFJfp0k/KPM9Nr/F7JDSOyUXV4nnlC+f
         xWJF/zaY78IVZjcBh51senL4H3PrA8+9MZ1w41pNa9bz+O28MFhDCI5JikDEfcphIBqN
         ET1gfAkxfI/Yh7rOxbJbI5zU3uBt8koK/6YaCEHeDZqJEIhRJiwkcZxxLwEy30UEqfkZ
         ll5MublLXczbutDLYki68B1YG5A3gPvfOjK1VdYd3aicx44LaBVv52DEiC+K78+Za+br
         4W2g==
X-Gm-Message-State: AOJu0YyheI5h3/oJFwRGFPM2kdTJ0hJLHSg3Tjcm8VcyBi/lPIQ5Tden
	QrHia490Tfw25ZbnMK4v0tr3YN2s0wRYXSetutcbe21eYNmOcUHaejNBNmJl
X-Gm-Gg: ASbGnctHyZFW15pAgpPxWAT+du1vpx6oMlvai07aXQ3X3FojL3Qdi/FnXo5U8etfZnX
	xUXXA400tFCQREYJAv/LjRNTwbyhkFGOCkvgzdzyTtLSs1u9aPy/uTgFWeTa7Y34CH4mm8Grq3+
	zoQAsd5dt1EoFlJIfThExNKX+LxAELzGAwg8lSnsN5/eF+73RdxNgr1m1nuc67CT/T7hnN/+cNt
	ws4DILGDTwOGkFab5hHusUfdtD7MCdRm7LCK+hrxcjPdpXvGd3PRtkI
X-Google-Smtp-Source: AGHT+IEBRtID0lVYfOFlZwJGaogNhBQBhrbrS8KGcu+LszGiVphvmnZmNsy/bJRYBLAWF0ZKCbhKyg==
X-Received: by 2002:a17:907:7809:b0:aa6:6a52:974 with SMTP id a640c23a62f3a-aab779cead3mr962443366b.35.1734346894512;
        Mon, 16 Dec 2024 03:01:34 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ecacsm318006166b.145.2024.12.16.03.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 03:01:34 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 2/2] huaweimodem: ussd: ensure ussd content fits in buffer
Date: Mon, 16 Dec 2024 13:00:21 +0200
Message-ID: <20241216110106.567830-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241216110106.567830-1-absicsz@gmail.com>
References: <20241216110106.567830-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional fix for CVE-2024-7539
---
 drivers/huaweimodem/ussd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/huaweimodem/ussd.c b/drivers/huaweimodem/ussd.c
index 5e1c9078..1e246e5d 100644
--- a/drivers/huaweimodem/ussd.c
+++ b/drivers/huaweimodem/ussd.c
@@ -38,7 +38,7 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 	int status;
 	int dcs = 0;
 	const char *content;
-	unsigned char msg[160];
+	unsigned char msg[160] = {0};
 	const unsigned char *msg_ptr = NULL;
 	long msg_len;
 
@@ -55,6 +55,10 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 
 	g_at_result_iter_next_number(&iter, &dcs);
 
+	if (strlen(content) > sizeof(msg) * 2)
+		goto out;
+	}
+
 	msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
 
 out:
-- 
2.45.2

