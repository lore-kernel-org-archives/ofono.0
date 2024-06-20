Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557DF1AE84C
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895128; cv=none; b=UkGR8UqrH4R61a5vNNFHlXetmu35i35rWT8MWQRWNzn/fIYEX8vzuYU0b0lGophD17PScXm/CSvq+WbbkWJ/MEoYLKg6PJUFm8rDuw5813q9FfOd/BNvyjq0PNNP/wBfiKb3OQ3iDqgErQd2KcAu4A3gfJM+vr+wvnq0SCT+iuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895128; c=relaxed/simple;
	bh=IiJTpDFWVszkMs9yutzu4PpAAP2PVhhzrk0UUQ0VA/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaQZGHNUC+d2EeUezSaMabLImbzsy2kpTsIhWnhf1f5oOauD7cCvZS1TP0kKEi1QeosKznCuZ/kirICGMAJeOQfk+jAyBGQPurBuI3EZAt9EjH0TADlDN8vUEdAWt4pW5MiRybEA8t/r3Hbkl1sDvl4G/DEA8yAJ1IgBCFAOM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mi1JRV6E; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi1JRV6E"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d24724514eso540336b6e.0
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895126; x=1719499926; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyUF7wR+m1/dSK2kCnd4OkrUNVmnVUjk6Mt59JyOg58=;
        b=mi1JRV6E00H53zv0PTDeWDDOdnAHQIQMHflM9ekFY1RQ1YsBb/RNx6wKKEWzPxl50m
         iHYlhmBOef84brswhITDJi18LeHAawprJECHTn/mq6ycfXTGALmrlUI1R4Na3/NTNzod
         k8s8ijDLOmPRVej/ikis5IYH8vW0xYRhxKv0TKI6p1kx3zQT+BTwwj2LUEMWV8LHngME
         jU5Rse5lUffOs45eOx3rm8bbMq7P2WglYMv6bncMHYS5pbyT6G9XMBGZmZvy1JcZ/DmX
         le0XR5kf2XgMq59exSOgb+qHHIvIJewNOgn/4tQwndeBh2e6E9OXxEoJReqM7Je2EKn8
         IqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895126; x=1719499926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyUF7wR+m1/dSK2kCnd4OkrUNVmnVUjk6Mt59JyOg58=;
        b=FN7d9vvaqWMmRga6ePQ/MTMkRTgD07Fcv/SWZswjdJnoswGqpLc+zK/QkMEttJoabw
         +aR8b9QTazo9WrLhi5gRA3B1nBgRtdt1QNp5zG2m9J79nM73RvMjNi7p54jLmSiFnnu4
         N4tWcwf9cu0/X2vA0+nlbhJ1fOPxZ1+cSaKx4+QZM49C+MGhVG177JHFOKBdyEXNgihY
         5e33SzCHlf9Nn7F5hWGwgmV5hbEl+4hsuzV+7Am7NwbAz3nwleECGI8VGQI3XNKcAxtg
         98eI2mTn9SbTK+MKveP4pn70MVkYk6vxgNN4MrNRADaPsRtVUjZaNu1myHqGNEmQ4I5X
         /LCA==
X-Gm-Message-State: AOJu0Yz2oEOuJbY1F2wxX/2enFM2xJ3C1rruyvYtSRHGqleZIICBqaeJ
	O/VYYqnVyO5ePzzvRnmQgtSs2wmfKfJO2PL/QkYwlpUFIxLv1EUSG7mIow==
X-Google-Smtp-Source: AGHT+IHnv69rxdiBcjBVIkd2Jo8nozCO1mLqZGxzaPrTqsJVCTxdGqlJge9R6kf+cxmk7W1r9j2Vzg==
X-Received: by 2002:a05:6808:2dcd:b0:3d2:1f88:3e86 with SMTP id 5614622812f47-3d51bac6050mr6968349b6e.37.1718895126314;
        Thu, 20 Jun 2024 07:52:06 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:05 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 17/33] qmi: Rework qmi_service_get_version
Date: Thu, 20 Jun 2024 09:51:04 -0500
Message-ID: <20240620145139.1135899-17-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of QRTR support, qmi_service_get_version became
somewhat confusing.  It still returns the minor version, however QRTR
does not have such a concept.  Additionally, QRTR is limited to 8 bit
service versions.  Rework qmi_service_get_version API to make this
clearer.  While here, add some documentation and update the unit test to
the new API.
---
 drivers/qmimodem/qmi.c   | 22 +++++++++++++++-------
 drivers/qmimodem/qmi.h   |  3 +--
 unit/test-qmimodem-qmi.c |  7 +++----
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a56e5588c698..6d605d58ad65 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2538,17 +2538,25 @@ const char *qmi_service_get_identifier(struct qmi_service *service)
 	return __service_type_to_string(service->family->info.service_type);
 }
 
-bool qmi_service_get_version(struct qmi_service *service,
-					uint16_t *major, uint16_t *minor)
+/**
+ * qmi_service_get_version:
+ * @service: lightweight service handle
+ * @out_version: version output
+ *
+ * Returns the version of the service this handle is currently referring to.
+ * On QMUX this corresponds to the 'major' version of the service.  On QRTR,
+ * this corresponds to the lower 8 bits of the 'instance' attribute and is thus
+ * limited to uint8_t.
+ *
+ * Returns: #false if the service handle is NULL, #true on success.
+ */
+bool qmi_service_get_version(struct qmi_service *service, uint8_t *out_version)
 {
 	if (!service)
 		return false;
 
-	if (major)
-		*major = service->family->info.major;
-
-	if (minor)
-		*minor = service->family->info.minor;
+	if (out_version)
+		*out_version = service->family->info.major;
 
 	return true;
 }
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index da245e50ea50..4de9d7bd0037 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -142,8 +142,7 @@ struct qmi_service *qmi_service_clone(struct qmi_service *service);
 void qmi_service_free(struct qmi_service *service);
 
 const char *qmi_service_get_identifier(struct qmi_service *service);
-bool qmi_service_get_version(struct qmi_service *service,
-					uint16_t *major, uint16_t *minor);
+bool qmi_service_get_version(struct qmi_service *service, uint8_t *out_version);
 
 uint16_t qmi_service_send(struct qmi_service *service,
 				uint16_t message, struct qmi_param *param,
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index c40e9bb1d8af..4ea9c736c284 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -232,15 +232,14 @@ static void test_create_services(const void *data)
 
 	for (i = 0; i < TEST_SERVICE_COUNT; i++) {
 		struct qmi_service *service;
-		uint16_t major, minor;
+		uint8_t version;
 
 		service_type = unique_service_type(i);
 		service = qmi_qrtr_node_get_service(info->node, service_type);
 		assert(service);
 
-		assert(qmi_service_get_version(service, &major, &minor));
-		assert(major == unique_service_version(i));
-		assert(minor == 0);
+		assert(qmi_service_get_version(service, &version));
+		assert(version == unique_service_version(i));
 
 		qmi_service_free(service);
 	}
-- 
2.45.0

