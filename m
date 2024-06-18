Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0B1C2A8
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740956; cv=none; b=JInXobTn7cjAFEY1xF/IpeVQLAyDmxf8nHzug82web7W3a9EDBoe5fK9Enzc7xL/YJC7KR4r9mfYYvx5yo+hrtWKa5VNAYAqjW5zwl4F0z+htihi+8ONCPuwgvZHVA2GlKD/rqXLbqRv9SClvODbQm/5yyawcokL1cJdASW3xFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740956; c=relaxed/simple;
	bh=HUU3sUQwdUaQObDoIMlsAJAGfuur9LlGmMKFRvkjIlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riOjRLI/O1ZVwFwe0DF3sMcv4rhgBwz7mWa47m89qiO2tc8+uWa2V1SDGt1ZBtMPSd2I+aecost+8ZbKmUjEzX2NDnaozGUQ+TVVKw6k2btQ6DudSDWi4Xexnb2CcPZ1LCQlPt4SaZHphj3P8umhJdpT9qx1SBUS6hu7xWstTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2KjP+V3; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2KjP+V3"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f986b92acaso3374299a34.2
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740954; x=1719345754; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ku0cRHSkqfHg1v79ZIDpC0B8jaIvjzt5KGSfHCSRpGk=;
        b=H2KjP+V3G76Zg91X94IXXIlEicCsaxZMgM/ePpdBxANa3zFBh05R1t2r+XSd+8VBW5
         OGsgQpPgc/pRpHPrRrcm7lFZOeZwv98bLwQqQ7urINj8mGbJqiyIlgbdrAoIpUBwHnX6
         ewzQoNhAy8hWL8w287XCr+SxAVAgY7i2uYcFIapxCEiIC4WVx7097zjiTKG+GYt6HJBp
         uNXdppb/flQl3dnEfOtA9xQ3evAXdYCnY/uXwfL4Enz22rg6/i/huJ9HfVZB2GxRB+8X
         lK/KVY5JPjrYGOUzLJRb5KCPdT7OXv199Kxl27NvXHbDN6dYghTO98w1QEHnfdbzOvhm
         5djQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740954; x=1719345754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ku0cRHSkqfHg1v79ZIDpC0B8jaIvjzt5KGSfHCSRpGk=;
        b=KB7+k4Ntiox/MnikhqQUPXBU0/bl539jwEWjEXbh82Ilsi+YHTFfQ1YFik3GR234WA
         k0GvcU8ftO0kG1/bgnL7zDJO5EP0/WMe96zdhyesmFkcHbxsAqSMA2knxJermnvKKbGR
         5vf4ZbEOaRptdS98oeYR8lSORq7pRrKxZKi3HEW9PbQGGqJpbhAIs7bjqXNW934Ido8D
         fuoTC/4FB6oJOErPjpccC9DHAUYfBfLmN9wfUxdWbRCySR1yvkCk+U39qSbLSQN6PpF7
         ohf9n22fG7rsKan31QB8jcrmoF/mr48Nsm14rFhroRoXq5xNk5Q4qeNqftZ7jV6aESAC
         0OHw==
X-Gm-Message-State: AOJu0YzXusKcLoPgplyjr0RzMr6pZ3ac0J9Qkwd9Bh9nbZFBsWPI10wA
	M3HquHu/jVovLes4IYaku3TOAZNvtlgA5+mRS4aY4eMRc5YnePWeUH+4bw==
X-Google-Smtp-Source: AGHT+IGHplshEvyEV8QL+7RDqsxK+zM4tJ0mgPsKf8ComYBV5v2K1DMcG3ew5+xVVXE+sb+AWBjtoA==
X-Received: by 2002:a05:6870:330a:b0:254:a7ef:b714 with SMTP id 586e51a60fabf-25c94d743e9mr930434fac.58.1718740953832;
        Tue, 18 Jun 2024 13:02:33 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:33 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 01/33] qmi: Remove qmi_free()
Date: Tue, 18 Jun 2024 15:01:43 -0500
Message-ID: <20240618200231.1129282-1-denkenz@gmail.com>
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

