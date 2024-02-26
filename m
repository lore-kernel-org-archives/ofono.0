Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3F156CF
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918658; cv=none; b=IDIuLXLUJaK9XkilhSfk0Ul27ZHSoeXvrhm3Sf2dQbsx3Ce/Ux35bFvs6CK6KYDOVdUzGRwyNUxK4an8zYO9SSmJBPulYxkTTFc74CHx3gcTG4ISaO8k+Qc8QZGlM9ddLRRxll67fS3BBHcFGmKR7IKIPdzcWkHXpYNqnkoRoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918658; c=relaxed/simple;
	bh=el/v/d/u2nff2/4kmJmXIENAdAGw7lh9zpCWD5BqNiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtTwrKdovx5FtxOg/6c6M9Hhg3AsU59f3rJdVB02WJOKIhhIBDB0MTFI1uffT9zRr6Ood6LOLtgQ7tsIImYWLoDm/1ZXPDKf94zPgBxCvnKW4wWt/cb2mbE9JbyamPvrfFQ6WuTUoGMtV6flWZXxWdVlb0DFiQrVpMO4jF6fSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3hscdVa; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3hscdVa"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb9d54575cso2237864b6e.2
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918656; x=1709523456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07TpU/iSC0/2gSbP2kh/PzMpYLssOlwLYG7TgqJSn1I=;
        b=U3hscdVa7ZbFGVQoVA+qFt2/dd5IUKAS+lEnoflvTdgjg0j/I/SP/3HjLQeqZ2DPUj
         EjoabXd1iOZx012StLPmydVoXlchAwdNY/F3c1qifrVkEqA5ChyGVBzL4ziGuA8v/mxi
         oX//CshRFql8fNvMXfi16RHB8o0m5D8IUO87WChOfpphly6yS2pk+iJt4MbtzWlHvMIR
         SnXb42wSZ1OzpxmXrmlb3HzMvohPCRDpYAsN62n8pzxpziAlLFzOAQLNttbSU/wF6oMM
         O8D8+dYdxQC8AHVb0mif6Lo4gbHWNhn3L6SK5SYLndpV835Wq3cg7TVpO7ltyPi1Z/rI
         AkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918656; x=1709523456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07TpU/iSC0/2gSbP2kh/PzMpYLssOlwLYG7TgqJSn1I=;
        b=sKVYtjXBvSix5fpQoqKtHcYPAL2384v5RZBTObDM2alfs7dz0MVg+wFfVlbEzLbu2Q
         vG3TjaFMho5BpcbzBa6Xet+omS6cNwE4q6hq9upwdHqSfd2bENfXgwKHLTrKjFQgqR41
         wPHabP8xxOKyI+FtGVWRJw1XR1I3qxFjz6LAPNc0piE+YXBF1+S/gh/SuGoZFOX1+JGn
         q6FW5uSk6Igll4iT9RKcO+q42N6NSoWElEV9MLsWr/oqEsTsGnKDu6HQqR3KqxAS3JyA
         ctDgdmn9t01TAkgrbCC4iA1A30x5HBwZ3V2NboOtvU2vC0PxC+Xvhnmn6vKkvwdgcPVw
         y+lQ==
X-Gm-Message-State: AOJu0YwgriarD0wofYjdAw5X1buBg0Q9ZBPAOxwQZtYB2B0qPQzO3QZK
	pqWz05RI2QZ2LWhPEA+MyT467Ylwg5K1MRujoPQVlYJuvIr4KF1eLl5/8KRB
X-Google-Smtp-Source: AGHT+IFJvfyZ8UgfjCOZA2UqPqEn+R68Fwe0YhrCmoMAVDDFhm9NqrqHJpI4DhKqZEs69OnGoCl5Bw==
X-Received: by 2002:a05:6808:38c5:b0:3c1:a58d:6f53 with SMTP id el5-20020a05680838c500b003c1a58d6f53mr385012oib.45.1708918656641;
        Sun, 25 Feb 2024 19:37:36 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:36 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 16/22] simutil: Remove use of g_strlcpy
Date: Sun, 25 Feb 2024 21:36:59 -0600
Message-ID: <20240226033724.1460079-16-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace with l_strlcpy
---
 src/simutil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 7345f38db571..a4a8f8c4b230 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -982,8 +982,8 @@ gboolean sim_spdi_lookup(struct sim_spdi *spdi,
 	if (spdi == NULL)
 		return FALSE;
 
-	g_strlcpy(spdi_op.mcc, mcc, sizeof(spdi_op.mcc));
-	g_strlcpy(spdi_op.mnc, mnc, sizeof(spdi_op.mnc));
+	l_strlcpy(spdi_op.mcc, mcc, sizeof(spdi_op.mcc));
+	l_strlcpy(spdi_op.mnc, mnc, sizeof(spdi_op.mnc));
 
 	return g_slist_find_custom(spdi->operators, &spdi_op,
 					spdi_operator_compare) != NULL;
-- 
2.43.0

