Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB17524C4
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122164; cv=none; b=kYQALGXlIQRI2ZxqUdkgnmuw7Z8yFjKE79CEFLJPkTpEJWThaPPAM1RjhKOlk8U8/rWiTv+L+qwom/kFTpPlY5JgbiN9zbxIfsd1DVLoTOVq/4WSY3u65AvOUY0LIsPHF0A6KpprvEvZCBbR5IZw0/FqD7SQ2n5s4Db8zJRBvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122164; c=relaxed/simple;
	bh=W6uvZisSYNEQjcVezRx7ALmV51KyF8XmVqESwNLMd34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAoT0KIW+H6QHk0Ezx2dbd+75x1jDzCNmd3DS9EoPnqXOA93UN6FFV+wksFmOg1IZevCDh+Q/lUtmrIwIbg6fDcLLZI5kurAiPcMRQUdbvEH3TqjNmOYTY9sgtyuK0Jq2j3aRdTMJNzzkgexkiFf+CWooGB/2lvGs0H5BcM/lug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzlCYTNQ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzlCYTNQ"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e2c45b81d8so980015a34.0
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122162; x=1711726962; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOhvItY3Y0qLd518mZq72HRT5QF9xoAQYfLZ9ScWJTE=;
        b=PzlCYTNQV5VcmWm95Pd8nJ+JJG4ZosvqOxeJOkEchHBs6qWuAevrQHxRsaHtGrbpmM
         ud8xjuYlPSF7uCS19Lyzi+/cbDmioJMWM3DQxYlHspQhkDrzt4NM3cU9bxLEClZNPz9/
         28+315vZAmADwXc5mptWJkxGJjdXoq1Lsr06BBKiMZ1AFw52qhAPurKBZDkSqudARfyR
         BBedtbg/Gnm6pVNLu4LAXziRHAtTY6oZAwNletTH023Y7J+yyHRAiXkCwRuOenhcVJm8
         +zKr3hzqg1RDl2bsDv7clL6s8u8okiCl3XK458vqbUxNFhulvkJfowY3U8/ompK8yVuN
         mY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122162; x=1711726962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOhvItY3Y0qLd518mZq72HRT5QF9xoAQYfLZ9ScWJTE=;
        b=lH3pESklQAfZh6xURBYXpp6CxD/S6m8litNJBYe4FX1NFjt5PkxBGTuDwTbrGNLUSq
         3NK1C934k6vochoigy0xy+GRIZEGuwsXRTDV9Fhjn9SMMcuXVvAkqK3cGp3JEtKR+mWC
         Ktg/UmrHaL0PVSujrxbLZpi2vYvjjCB11C1tCMB+PzWviwaLfb0DEY8tbB5bEvlmda8J
         NoMy3QopqNz7lmTKLWXs4Ex6l1kU05Mon4k11axCR/hAOCYrGBnyoh3FDU4jyHBdpLuU
         U0xirajD3i2NkyTiulk5lGre6z5Mrz9dI2Y5Gp31ZOENhMiLboqjOIwmwn6k35AYgh02
         /QfQ==
X-Gm-Message-State: AOJu0YykVGY+gZqdXEJyRzlER2VPgxCzEvjLN8ZXDSih1xH0mZuWLRYQ
	l78/gkMcm3qZMl13eNbMZmk4X68PArevltKFiMJNN5E8paHOJi3V4SN1FEvv
X-Google-Smtp-Source: AGHT+IHu7KO4AEREejUKn2RkjHJ6bxBnLjwEuN+2hooaG9HSVQofATP/8lgri6sixa1huAJY+4qx0Q==
X-Received: by 2002:a05:6830:4bc:b0:6e6:8d4d:3735 with SMTP id l28-20020a05683004bc00b006e68d4d3735mr895494otd.6.1711122162194;
        Fri, 22 Mar 2024 08:42:42 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:41 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 08/11] xmm7xxx: Set modem as lte capable
Date: Fri, 22 Mar 2024 10:42:21 -0500
Message-ID: <20240322154234.2720542-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322154234.2720542-1-denkenz@gmail.com>
References: <20240322154234.2720542-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/xmm7xxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 871c964c03b8..a02f1f5aa027 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -1682,6 +1682,7 @@ static int xmm7xxx_probe(struct ofono_modem *modem)
 		return -ENOMEM;
 
 	ofono_modem_set_data(modem, data);
+	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
 	return 0;
 }
-- 
2.43.0

