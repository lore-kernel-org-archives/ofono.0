Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073A58AAF
	for <ofono@lists.linux.dev>; Mon,  5 Feb 2024 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168762; cv=none; b=UVyerN8vcwqjTTfGPO/tA6Qn0HjFNCYBY3yJdiSmNjvyNjl7UC/nYYJI2TAbLHMhM5Y9cD0d5x9CWD0sAt66IW860I7ty249UonDgxx9j8+TTNrzs80wM3zxyuzlxzHkQYsVZZ9WFLkaRp6WG6FDHbusWUJwe7tZe8QSIhmY6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168762; c=relaxed/simple;
	bh=vzLtM6MkMBJ1TSuPItalVoVVtf6aSoh7YgQkGCV4wnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMANZOlD3vmLjJmgecHnLJOAA79u/gdkrrZyCMcxNt5QbXsfeeClmPInV32Oet7NEIptxcJ0vHxw7UNBbef790m/hH1+x9P9Y7fxEsg6OGkzvY1oJ7cWrw2Rt955loWOvkAVwSBeHCZzfxLnAtcO76i0evXmS0zrufRMuKVPXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPIKRKa8; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPIKRKa8"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-214410e969cso2565034fac.0
        for <ofono@lists.linux.dev>; Mon, 05 Feb 2024 13:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707168760; x=1707773560; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JegzVh25QHy/lavJ0r4AuKJK1WDqy5LTxM4JiU9wnp4=;
        b=gPIKRKa8HBLaDQCQ5NDomNcQVjF/ZJIiDCz923w8kbGfb8ycEvul0VrclQYu+n9Qth
         3T4Ye6qynes+2FdeRip0JCnTorYVts0VZx6SbGVfc5wswooqntP5gDIpEfI/t2nq8j8m
         yn6MxkVnjPfRnpmCYauZPO2FattnQbFBLZZ+/aborsa+W1H3PnLMIqrU1IUAfXeT039A
         MyPqD8odva3N/eMbO6/1Lb6AP2Umc8oWJAA8j2LE5oBHPZ9xFrbx1m83JAtYWzCGJP8T
         +7PMryLXWGIQrcIde/kUo/NfdZ4Y6I9wOsXgc5OqpE7dRyHOvay5bkduq5rQ8o/32YDU
         QZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707168760; x=1707773560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JegzVh25QHy/lavJ0r4AuKJK1WDqy5LTxM4JiU9wnp4=;
        b=QDGlTfuDtgzlJC4tFAwy43kUIz9srTQwYHkChg3EA0H0QmiUddFX/uaVVVgTX1Eyhx
         wKMujpC/ZO/oGNPu/pl3MjLlHErnruDN2AU+RvosEpCoH/sObOe0DpjKYPFwav7xV6Vu
         EEJ55meh+wJuUHLZvcl4ZpHtJb2wCtgyQE6djLtgoAuKSpkJsiUuX7e8nqe+UNs2R513
         6esQHHyfKc8VdokbKquKKUTvdtL88fyEqsBEnVLg72T+Tt3KDerYvoOyb8F+/uoZiGnW
         h3KjX2hn9AFo820EB2YWenijtMMt7UZfmNSFYwKAhhEii51K3USraf/y2Iq7hOy1bDxL
         pvGw==
X-Gm-Message-State: AOJu0Yz4ULu+TGfwtCu6xtxsrLzesV8VdLwyj9PiHXjoc0jOBv7UdNLh
	HD8NoBze972x/wpGKUs9hjO5KflyrnhlNSvl7V5pwE3TTerDOAGQQUKufC5o
X-Google-Smtp-Source: AGHT+IECSLyMm+rgp0gnriXJZh6kPQhYuPDeCKBnubnCkM+MQtAazfFElfc17rF8WwvKz+hpM9L7Lw==
X-Received: by 2002:a05:6870:8186:b0:218:d8c7:3bcd with SMTP id k6-20020a056870818600b00218d8c73bcdmr407181oae.21.1707168759925;
        Mon, 05 Feb 2024 13:32:39 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id mk10-20020a0568700d0a00b002190606a99esm153722oab.53.2024.02.05.13.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:32:39 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/6] unit: Remove g_utf8_strlen use
Date: Mon,  5 Feb 2024 15:31:24 -0600
Message-ID: <20240205213150.1001245-3-denkenz@gmail.com>
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

Replace with l_utf8_strlen
---
 unit/test-sms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index 3bc099bcbdeb..154bb33ed244 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -1249,7 +1249,7 @@ static void test_prepare_concat(gconstpointer data)
 	sms_assembly_free(assembly);
 }
 
-static void test_limit(gunichar uni, int target_size, gboolean use_16bit)
+static void test_limit(gunichar uni, size_t target_size, gboolean use_16bit)
 {
 	char *utf8;
 	char *decoded;
@@ -1273,7 +1273,7 @@ static void test_limit(gunichar uni, int target_size, gboolean use_16bit)
 	g_assert(g_slist_length(l) == 255);
 
 	decoded = sms_decode_text(l);
-	g_assert(g_utf8_strlen(decoded, -1) == target_size);
+	g_assert(l_utf8_strlen(decoded) == target_size);
 
 	g_free(decoded);
 	g_slist_free_full(l, g_free);
-- 
2.43.0

