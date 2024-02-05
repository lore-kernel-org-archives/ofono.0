Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3258AC5
	for <ofono@lists.linux.dev>; Mon,  5 Feb 2024 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168764; cv=none; b=Ejd8TNYDecKfnUm5WKTv5edpiyuUVAaas1H0pbuVZUHnXblz3ep/L/ebMHxSoCi32zah4hPMN/4YsyF9brp5aJMJPe3OORo+/IG/mqHXk2epr+62d1jTi7bQA4a/keoUc2NKLfp8ZjnXM+YfvJ8rAIWAZ58B2xaB4NTXJch0BUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168764; c=relaxed/simple;
	bh=KSAM0+97ycvqtybAk65Fv1CVxlFr7E8pkc1K3f2xvDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZvDBLbm7QODLky/CTOjTGEIyDihu8/NZG+gm5036Pi3WI7O92t0U/arSjO4H99P3mzsAK9l7thEjUgGhcsSYZNX+4dyZ48OJSOzalYxIX2lahNlVRX/XBymKnS19ehEhMZeHzOo53N3fd38d7O71WB4JP84Yp+7KcBUcFz1rx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAaISnZP; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAaISnZP"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-204235d0913so2951724fac.1
        for <ofono@lists.linux.dev>; Mon, 05 Feb 2024 13:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707168762; x=1707773562; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoh83uIX80nRidT0qeUsw/bx7jwClpqh0KDOy/ValZs=;
        b=lAaISnZPpfPFwljHQZV1W+3oTqEO7Z23RNr9siqkBG43ZSincJmuJTDysCXg8JgyHm
         PXmLSjavs5DV0HPJV2lNzYxO0qhlGP2IowAipgyaqEpx4herffwTW8CfBJfNWJLSEcQr
         yVhTAAJnTcKY9fZSdNkGT20ev7HFVtEI4tYgdgFZhM2iP1lLz2DQqzxq63Hzb8C7bbCd
         AoqTQm6q6qCgFb5v3zWxTEZqrDJAWlIehKGZvkxxAysyZDVBSGr9W9Ix7CGyU7rD4H/z
         rfJZwLJuU4bdLdlnSjlHBDbm8vr8ck6mBfjRW4Jw/OO7ikg0GRYzLeIZ4mE5Qvlri3Xw
         uZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707168762; x=1707773562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoh83uIX80nRidT0qeUsw/bx7jwClpqh0KDOy/ValZs=;
        b=mEVjiG7tB3kkwpTTWcynSkwGyiHMT+H8cbWbkmHz2idOnCYyeimYSUGSZQ943ZopJo
         VVPcGFPB03nExtj6jT+10ihG9n5jlB/rjK97YtQwiZy3xMjUBZdPqWb3Xb298wewdlAo
         tdhzNLnE2Sg2vwU+Gt7ADJWNqoeMdpiEA493vHnpcE0e11+/25c+vAx4Wz7g9DBpCEY3
         QhIOeHgZ3NiBPPMDPod+gKAEiAPLEWjVi5IF0OH9o5ZG11Wh3b7GLfm948lZCJDCN9Lg
         I8xrHTtGwemA+hWbgcw6Ta09Dt0Y47JlIkA15qI77aEn8kkSP03N2ZUGQW0m2O26kJa8
         E//g==
X-Gm-Message-State: AOJu0Yx9b7oDBgfDtqb0HnE8I8BU91e8K3H+zlMFdSPbLWOjX+4GCHtz
	zBsQnwD7gd2R6husmj87ytatDypqLl+ZJTzOOvA5iT4PuD41+Xs3MZyUKZFP
X-Google-Smtp-Source: AGHT+IGI8mnXliAWRP4B/wk88WADLkliuyr49YD0X0vs1Eh4X1J/rFkMIpKcK2Jkr/fig9a9SL//bQ==
X-Received: by 2002:a05:6870:d889:b0:218:f6d4:d67d with SMTP id oe9-20020a056870d88900b00218f6d4d67dmr903215oac.43.1707168762306;
        Mon, 05 Feb 2024 13:32:42 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id mk10-20020a0568700d0a00b002190606a99esm153722oab.53.2024.02.05.13.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:32:42 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/6] unit: Update to the new API
Date: Mon,  5 Feb 2024 15:31:27 -0600
Message-ID: <20240205213150.1001245-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205213150.1001245-1-denkenz@gmail.com>
References: <20240205213150.1001245-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function now returns stdbool instead of gboolean, so update the use
accordingly and to the new coding style.
---
 unit/test-simutil.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 530f624e6b0b..8364f200c665 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -97,14 +97,14 @@ static void test_validate_tlv(void)
 	unsigned char impi_invalid1[] = { 0x80, 0x4, 'F', '\0', 'O', '\0' };
 	unsigned char impi_invalid2[] = { 0x80, 0x4, 0xff, 0xff, 0xff, 0xff };
 
-	g_assert(validate_utf8_tlv(impi_none) == FALSE);
-	g_assert(validate_utf8_tlv(impi_empty) == TRUE);
-	g_assert(validate_utf8_tlv(impi_term1) == TRUE);
-	g_assert(validate_utf8_tlv(impi_term2) == TRUE);
-	g_assert(validate_utf8_tlv(impi_term3) == TRUE);
-	g_assert(validate_utf8_tlv(impi_term4) == TRUE);
-	g_assert(validate_utf8_tlv(impi_invalid1) == FALSE);
-	g_assert(validate_utf8_tlv(impi_invalid2) == FALSE);
+	g_assert(!validate_utf8_tlv(impi_none));
+	g_assert(validate_utf8_tlv(impi_empty));
+	g_assert(validate_utf8_tlv(impi_term1));
+	g_assert(validate_utf8_tlv(impi_term2));
+	g_assert(validate_utf8_tlv(impi_term3));
+	g_assert(validate_utf8_tlv(impi_term4));
+	g_assert(!validate_utf8_tlv(impi_invalid1));
+	g_assert(!validate_utf8_tlv(impi_invalid2));
 }
 
 static void test_ber_tlv_builder_mms(void)
-- 
2.43.0

