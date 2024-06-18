Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE8216DC1B
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740969; cv=none; b=NWvFrKXTRd6lDrDLnQK4NnaGvIscoJ09t80Xf0M18tC6gJwi56ksh3eey5oExeD31GcH12yHugDi0V49vuWP7S+sBD8RY192o1hevLGZl1z62Rw3KYd+cgaizEkQCwdYOwC+tbv+XEFG9TeYnTKF8jPPJY777eyhiVQl3nRrVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740969; c=relaxed/simple;
	bh=IiJTpDFWVszkMs9yutzu4PpAAP2PVhhzrk0UUQ0VA/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5PkaYYPZlJXJMPmvec3sA0DIp3nY0H1ICmyW67SR3jZNXw/d3wbfvlmQvyuqGTvr3/yhP1WcbOdxkTn9pam0n4idqj6xwagjPl5lFPMMfNwQOzjz6H+CkWozB3nP2x5xB2OcQSbkgxoi3OJuXlUVjYjZnc6691ZNsxTv+tbHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI6sWrV9; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI6sWrV9"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-24c9f73ccaaso3337385fac.1
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740967; x=1719345767; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyUF7wR+m1/dSK2kCnd4OkrUNVmnVUjk6Mt59JyOg58=;
        b=CI6sWrV9QTt2rkvCDMwzN5o4GfXfFaoP+I4z+TwGX660DCZYfp793ARPOZwfQTLhKH
         LgjSqOU5DJceFV5YZZoCDxopSFmcIiJa2LmgEBZsy+jY4w87F5VIUjNCP5ROdKB8n9J+
         Z6OwYrRbYf0GuLesD9GhtAIoV0Zu1GIX9Q5wECqZfPzTtEcJ40mohCg0/uITuxjkWw1s
         3VvZCnJuAQSYO9uPK3DvzYXBVomTDgmJOjKuBpuTEfqnP/kokkVANCJU/7YUgMbWTShI
         GPvJ/dpWj4CjNS4mbo9mgXKUNM1eV/2oCkRL1iBZ4Q2Saz5WryDkc+k0xBLqHyv4bz0F
         iVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740967; x=1719345767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyUF7wR+m1/dSK2kCnd4OkrUNVmnVUjk6Mt59JyOg58=;
        b=UyvfLs9jDZTg1tAGX6Qc5qlnRsHisiHei2tRcXen8oUe3Nr2IqLR0GAX1mN6XZqpZL
         TfEDXwTquHIu6bIFRwUPQUzMARVOyUBd302cnhinDcSV2w6FPDYWt4gokJVhMZkzXzyy
         hzsWrm563GV67gDFAqhqa84P4DGI4NOGUqd0amnXOsrofKxpG0c0JeYyF+58McHe7eiw
         iVfznXRxmFJHfM6PszxKXxB4bRtx1Zf3unZYXDWXmyCr1pbZe/E/bTp/JPbCwQAc/b42
         zAeocuA53M7tPRmX0qEx8OgJrspC5W+erO/zo4lmj7schjMDAiQKySjgg+gP/FBbrye/
         XMGQ==
X-Gm-Message-State: AOJu0YyLMDRxCXeN3KGFcrjM4klKdeX4PEaxiPexEiM8JFnGzx9CpMiu
	ZUY6GsfSVI0cdowj7xUx8uNHVoyeBG61dqpnBHiRPRQkz7mGPpHX6GHDKw==
X-Google-Smtp-Source: AGHT+IHu0JY8S85frnkzlvO+f+EZQ2j2bzVQhgM/hy7JSxW4zyjVzLF/qtGvVzU/FkfF83xgxrzAGA==
X-Received: by 2002:a05:6870:51c8:b0:251:2755:5a33 with SMTP id 586e51a60fabf-25c94d058d8mr907299fac.39.1718740967043;
        Tue, 18 Jun 2024 13:02:47 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:46 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 17/33] qmi: Rework qmi_service_get_version
Date: Tue, 18 Jun 2024 15:01:59 -0500
Message-ID: <20240618200231.1129282-17-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
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

