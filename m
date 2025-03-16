Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7398F64
	for <ofono@lists.linux.dev>; Sun, 16 Mar 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742120828; cv=none; b=kuZsWez7HDvds1XkVaGcONY77U7QgyV5E/kTB7xZZGV88RIKIEAF0B3vYVwNVX0NtkHnrdMK26mRtbuPcwlHf/fnR0uVx4Jc0RGICI+o/t6VFY+KTKGxlV3lJinjnvstrTZ3D0R//YusuhrFE9zkOs/0+VTO9if0FQHllDQM8tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742120828; c=relaxed/simple;
	bh=JwAF1R6B/86a8xg/k5oc3sv9/9FGFstPMpglsRbMAVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhkXtzSDVxJmoIKJelTHsT9tkZGbWzEZWRPFEJwMsxM//E/AS1D4466u9Fsfk79aI4bGxnECWNnRYTQrz3T5sd+GcHjxOwh3EInmTqcfGdPyvF/C7jNmfKghKTlckFndT8GmFd1Bbx4rNMvxWANiwFAVTC5Hr6IkPHMBkasO0rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELe4D4a9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELe4D4a9"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39133f709f5so2079910f8f.0
        for <ofono@lists.linux.dev>; Sun, 16 Mar 2025 03:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742120825; x=1742725625; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wxadEEm1e+BPVfY1jHfNODtzywt8eyDcg48Luej8fg=;
        b=ELe4D4a9reFuajfDZGBaMKCSywGw+Dz+StnW7KPNNj9Qh+HF+M4mZWcttz4o29omPt
         WwMln1M/YnTaFmOz+yCkB7YleYk+s+7+03tDJlpLZfXjYj4xxbe4Cyj7wE4WqnqyJ81W
         KKcaxaG4SiR4ixorCfPaLEvNDHC3er2wxf1O2ttS+qdCkxd4hV7Gp4ya2sbalkMEo3wH
         PA3iXBUfRkEsTcXnFPV0Ehlk2tbEx7PtRxfv4zNt89m8/GSDRVYD2xZEVgWMVBuGFX7z
         PgMaFiTaqpKS40gF9p3dFWUbQIZ7du3mLfAxLL6x7ivXCJxisKKJBrCgzWOVYdW1fKvR
         b+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742120825; x=1742725625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wxadEEm1e+BPVfY1jHfNODtzywt8eyDcg48Luej8fg=;
        b=uxp7pgzHKf3eNlV86ZLZOXTwnp4eiXsicJ9vzXNHPcSLy0/gsMyVutDbq1nhyj0bZS
         BMshic+UrvgP9zGcGhFWYXv3E22FTmxbRnrnZnzwvCeb4qMyGbc4AaeldufsbHX7e2RG
         nfWZmagz6Kv6OlouHPUMbFLsKCgaH1p6hNnRJDQbRFT0VlMkocKWfHVCIEnkexP72bOx
         4W/jhGak2qbC7gdYw4ZKgWeeAUyAP/NkLRIZRo3QfoNA+Qp8JyGALOoY0crWPabPnFf0
         fAN10MfZjtds2xUAJVD7/d1cCOWTxqN7WrHXkSay7bYXwk5B+BZJ82revLkU1VqfTJma
         7aBQ==
X-Gm-Message-State: AOJu0Yxnw3AuSAf+CphVj2nDPk8Ih42psXulmRDxZfRUt7U2Rk6f7op6
	zwO3t5BjiKT5ZMMPr+sKOmYUqISJiUIWmBYaASitt+l92AzA1hNMX26/PA==
X-Gm-Gg: ASbGncu60ApeFMNkknvqW7TGh3kDgymUpcL/abJPCxhPkWiSaKPyOJkRR+ZwBgB/Sly
	z9gj0Jgpy37AuqSbYI5ROY5HkenVs6mGR5wo/aCwyHCkEZso85tjdyJw+P3aiHdNJJSHbt+eoag
	TW+sqI3prSFa4MsaeX1totBzXReQAGVooCJtu2M93OYhhwiCHzqhTLYRq1Of9N0mkV8ZzdVa9Md
	RzgG1T2nzV9erWzW58/cQ2O4dm8Wa8G6CBRNWCmtvncFoPsfxRnVr88G9LALUJE3hHuTC+XFY2I
	4Y5Kq9CPKgV1pLxCl1rsi3jzeQU+5QKpF7SB9jfRFeKVOXQiomPkU2107E8upxeVIMU=
X-Google-Smtp-Source: AGHT+IHSwMZvMNPNO88b9oEYjfugJQ7y4QYQzwRB4NydrCdlb1x2XAKnsIa2ztbnLD6ncMtkPBsjUg==
X-Received: by 2002:a5d:59a9:0:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-3971f9e497amr11687464f8f.40.1742120824742;
        Sun, 16 Mar 2025 03:27:04 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010de59sm73172245e9.33.2025.03.16.03.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 03:27:04 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	sunweaver@debian.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmi: sms: Fix possible out-of-bounds read
Date: Sun, 16 Mar 2025 12:26:42 +0200
Message-Id: <20250316102642.44301-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: CVE-2024-7537
---
 drivers/qmimodem/sms.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 3e2bef6e..75863480 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -442,6 +442,8 @@ static void get_msg_list_cb(struct qmi_result *result, void *user_data)
 	const struct qmi_wms_result_msg_list *list;
 	uint32_t cnt = 0;
 	uint16_t tmp;
+	uint16_t length;
+	size_t msg_size;
 
 	DBG("");
 
@@ -451,7 +453,7 @@ static void get_msg_list_cb(struct qmi_result *result, void *user_data)
 		goto done;
 	}
 
-	list = qmi_result_get(result, QMI_WMS_RESULT_MSG_LIST, NULL);
+	list = qmi_result_get(result, QMI_WMS_RESULT_MSG_LIST, &length);
 	if (list == NULL) {
 		DBG("Err: get msg list empty");
 		goto done;
@@ -460,6 +462,13 @@ static void get_msg_list_cb(struct qmi_result *result, void *user_data)
 	cnt = L_LE32_TO_CPU(list->cnt);
 	DBG("msgs found %d", cnt);
 
+	msg_size = cnt * sizeof(list->msg[0]);
+
+	if (length != sizeof(list->cnt) + msg_size) {
+		DBG("Err: invalid msg list count");
+		goto done;
+	}
+
 	for (tmp = 0; tmp < cnt; tmp++) {
 		DBG("unread type %d ndx %d", list->msg[tmp].type,
 			L_LE32_TO_CPU(list->msg[tmp].ndx));
@@ -473,8 +482,6 @@ static void get_msg_list_cb(struct qmi_result *result, void *user_data)
 
 	/* save list and get 1st msg */
 	if (cnt) {
-		int msg_size = cnt * sizeof(list->msg[0]);
-
 		data->msg_list = l_malloc(sizeof(list->cnt) + msg_size);
 		data->msg_list->cnt = cnt;
 		memcpy(data->msg_list->msg, list->msg, msg_size);
-- 
2.25.1

