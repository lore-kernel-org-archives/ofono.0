Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787911A01C1
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391184; cv=none; b=cd7OTzbahGO95pp4NQTbfy8jE7kGco7Q9+ZTBTPxOctIxSkwM6bfimfhZzRQJ+9qftCMKQJZEn6ZkwgnD672tpkGWV+KxL15BePUnKwrbD7B4b1bgF/JxWiXptZePxIhhUQNC3RpUorlqI38/QP64OjePptizw9kQxwLjCaiFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391184; c=relaxed/simple;
	bh=HUU3sUQwdUaQObDoIMlsAJAGfuur9LlGmMKFRvkjIlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfPNPp7b3HulRufq7f3k3EV8Pdnp4PfMCX1YVz8/XRYS9vENnbSvWhoeXnnViMQECmD3K/PYtiUOPpJr8njRLoRCuH2sbodg4Opy4oO/pDkaNPtNWUGiYf2C0liw9ova0y04xuTBBvQZ+oNGUCdSe4HqxwaIc46ngn9RzkeN8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3YHHqTs; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3YHHqTs"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f980c89db8so1347360a34.1
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391182; x=1718995982; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ku0cRHSkqfHg1v79ZIDpC0B8jaIvjzt5KGSfHCSRpGk=;
        b=l3YHHqTsh2FuMC7N8I2zLSCOWgDX/Gr37zzAYIv4E0fBzSgj99trTwOUzVbErvJh6P
         CNFzgDiZUFiDx4612Jr32+JwrVpptqb3wxcsoKsS82Ya7mwiPl2gK3bDCe4qVLQyVjNz
         m0Sch6qo8LyXuEbouAx1TYINxFCBreA0WwzuaCAFv/MblhQFdumWSGo1eCkIld72vYNV
         o06AaYVhfnDKRVLi98/BlwgyUpCGG+qk96fwc6cJvJDyKAlDm9++RzFtBScF8Pnldt4y
         K8aCZKGdY6Q4lSctz7gnKARX0QslABdKx0sM1FoowQBeZhKFTNSNizBbwu2j9LDQfpdG
         iybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391182; x=1718995982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ku0cRHSkqfHg1v79ZIDpC0B8jaIvjzt5KGSfHCSRpGk=;
        b=HtGhaq5lpk1r96k/FxlspznybU6wFhf+eVUY3DYq0E5uiTrCx8ehf+av62sZSK6Ckw
         2RfCdQsBwYirp9eGiCrop5ajhRVUHpZX8vObyFBktZPm+CnhVW7E4XiBi0M0GX3bRJrn
         +YqFeVshctH3kNrXIQE7rTG3kpLbtQStHY5z3nUH29ufpb1KosziHME3EisaapsNhz9T
         Ti+zvAU/EMrVOJqq2pvSbS8exViH9OU/Aoga2ozW3Wgaoq2Ln7Tg5cgsc68lQSvNPcsL
         clLEWRr9QNPPzfpSgTYl5hf+KVwzGMQ7pmA1wLXOuviEa0vzmPHD71wKdtGfcobcsAtc
         b2dA==
X-Gm-Message-State: AOJu0YwBtQ8zH+BXlahYz2dWmUkGxDVnzkJecd5qU8pyoklX+pAOrbSy
	8l/zs5WjB7AB5q09KuEg329WGX1WhMdZh9JOElkD9615tRgHvIsQHuSO7Q==
X-Google-Smtp-Source: AGHT+IHJBc53o6CHUPAc9eSi+LTsWzuHu/brI243sKxcC8t7blsFXb4Et3acU/8+huDB9EYTbamc0g==
X-Received: by 2002:a05:6870:e9a2:b0:24f:c892:d02b with SMTP id 586e51a60fabf-2584256ea77mr3941713fac.0.1718391182394;
        Fri, 14 Jun 2024 11:53:02 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/27] qmi: Remove qmi_free()
Date: Fri, 14 Jun 2024 13:52:13 -0500
Message-ID: <20240614185300.1086701-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was just a simple wrapper around l_free, get rid of it.
---
 drivers/qmimodem/devinfo.c    | 8 ++++----
 drivers/qmimodem/qmi.c        | 5 -----
 drivers/qmimodem/qmi.h        | 2 --
 drivers/qmimodem/sim-legacy.c | 6 +++---
 drivers/qmimodem/sim.c        | 2 +-
 5 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index 2e514cfa3265..fd1ca3ceb2dd 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -45,7 +45,7 @@ static void string_cb(struct qmi_result *result, void *user_data)
 
 	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
 
-	qmi_free(str);
+	l_free(str);
 }
 
 static void qmi_query_manufacturer(struct ofono_devinfo *devinfo,
@@ -136,9 +136,9 @@ static void get_ids_cb(struct qmi_result *result, void *user_data)
 	else
 		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 
-	qmi_free(esn);
-	qmi_free(imei);
-	qmi_free(meid);
+	l_free(esn);
+	l_free(imei);
+	l_free(meid);
 }
 
 static void qmi_query_serial(struct ofono_devinfo *devinfo,
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 91469dc2e00c..632f647e5ea7 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -181,11 +181,6 @@ struct qmi_tlv_hdr {
 } __attribute__ ((packed));
 #define QMI_TLV_HDR_SIZE 3
 
-void qmi_free(void *ptr)
-{
-	l_free(ptr);
-}
-
 static bool qmi_service_info_matches(const void *data, const void *user)
 {
 	const struct qmi_service_info *info = data;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 821e54443658..de6238f25e62 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -56,8 +56,6 @@ enum qmi_data_endpoint_type {
 	QMI_DATA_ENDPOINT_TYPE_BAM_DMUX  = 0x05,
 };
 
-void qmi_free(void *ptr);
-
 typedef void (*qmi_destroy_func_t)(void *user_data);
 
 
diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index 1feaf86976c6..4c909f7f4ae4 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -71,14 +71,14 @@ static void get_iccid_cb(struct qmi_result *result, void *user_data)
 
 	len = strlen(str);
 	if (len > 20) {
-		qmi_free(str);
+		l_free(str);
 		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
 		return;
 	}
 
 	sim_encode_bcd_number(str, iccid);
 	iccid_len = len / 2;
-	qmi_free(str);
+	l_free(str);
 
 	CALLBACK_WITH_SUCCESS(cb, iccid, iccid_len, cbd->data);
 }
@@ -128,7 +128,7 @@ static void get_imsi_cb(struct qmi_result *result, void *user_data)
 
 	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
 
-	qmi_free(str);
+	l_free(str);
 }
 
 static void qmi_read_imsi(struct ofono_sim *sim,
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 876274fa87b4..1fffae27f63e 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -427,7 +427,7 @@ static void get_imsi_cb(struct qmi_result *result, void *user_data)
 
 	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
 
-	qmi_free(str);
+	l_free(str);
 }
 
 static void qmi_read_imsi(struct ofono_sim *sim,
-- 
2.45.0

