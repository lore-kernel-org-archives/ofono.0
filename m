Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63A1A0AFE
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391188; cv=none; b=r2aQdgY8CUmj3ij0FO79tFn3SJDXSKApq9OoOEUU1UiQPMnncf4xwJR1/4jMcjyxBSuzPkQaT6Jkn8qLiQ2PIITHN0Q/02e6TDZ1dNGTbD7JUYG+cTaBlY8+lhCUUAiVBXnWhgJ6vzhjCk9Z2tE1b0ILJIxvF5AuF7MV7uM7wCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391188; c=relaxed/simple;
	bh=AqmRSXpqsa74kzD6L/BnSNSpMChihtQQEBU2ZB4UNWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTOpIwNxmk/fSWreWeYRnb6cdVqOrsKdWwgh5dLy0p+6qMVY+7ThElHsQR5BMESOhvaP0qO+4Tkkxe4+dqwrFufl8PXTy1DBg/KWV9DHNz9MekEghTd3/EdNOJjdqPxnviJAjbyDFcQSKl6RTFAXmkygOxKaRVJOfTlGCdaVfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/W3SFVs; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/W3SFVs"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b96b249d56so1709342eaf.1
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391183; x=1718995983; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO1bu6fwYoOWz/p7z1OTd1k5bj+RKcc08WulqJPLBMU=;
        b=N/W3SFVseKo0JooPMt7lsEyH23xJ9VWCRgP1nCVQ0x79I69Gkwj4h6HhiaPhPF50Nf
         uc/DXW4+j9IQtNnvJuYCqtVIWXGBmolQTlezwCX+zieFitwDRifk3sU1dhDLBGS3sIw4
         FaEUivXChTwC177uYFxsSLLU/VwxamInJJQMbh1ApDfQSthu94jritXI2uBNuMOCintZ
         71M4U/94CZM5maGhEcfPurD00TveGfqbqTPrqDhTWe4i0oBGbhbBf8IQ6zkxo6a38R86
         Aqi9ecPN9KJxg3ny6SYdto4x/om3CJapSMdQbUMYX5Xfwkx1Pfz+oSquGCucXelQsMDC
         +aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391183; x=1718995983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO1bu6fwYoOWz/p7z1OTd1k5bj+RKcc08WulqJPLBMU=;
        b=LwftswFqwFQ7IugTldRjvRdLtlLBKUQKINJH+PqiqciLxRkm7vFxuyA0JBFya/lxQS
         Cohfexxi1nTVYF9P3yLo++DERp6XqewNA++EUbH3rMTru/zO33puUWVny8X90SN/Qz+Q
         sg+96yAXfqWDnotRZtocO5yQSMw8W40WUxgt0UG+xDCihDp+3tqtwo/ndH4YW2aMOlxO
         e+nGONqaC6OOfmlXuKgcbFhqVT9TEMsAQRvi2MTKff6RPanPjDScsvY2HParZVdrKMj5
         1w28PO67NquDzcpXla57t2y4ijH0jVCGZ5jACy3yoMbKmoU/deFQ1yvpLX1DQSJuVbG2
         CNMQ==
X-Gm-Message-State: AOJu0YwteRYNz2tyNgjXDUd6d3qgEqUV7e+QyGYfQAPJTg+VvaA7MwLj
	IsvFIYvdLhsWSuKmHLIZeCCzeqXtDtDrmaS/EPOOb/ZwtG/A48e8EVcqcA==
X-Google-Smtp-Source: AGHT+IGZ7twnZ4tG6EpX79UO5QyYxSMzEBd0B22d95vtFCS1EaUfKYyKuOyiM4rz+xiNBXtYi2ubsw==
X-Received: by 2002:a05:6870:a452:b0:258:3455:4b2f with SMTP id 586e51a60fabf-25840ffe483mr1540334fac.17.1718391183041;
        Fri, 14 Jun 2024 11:53:03 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/27] qmi: Rename qmi_result_func_t
Date: Fri, 14 Jun 2024 13:52:14 -0500
Message-ID: <20240614185300.1086701-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614185300.1086701-1-denkenz@gmail.com>
References: <20240614185300.1086701-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

to qmi_service_result_func_t to be more consistent.
---
 drivers/qmimodem/call-settings.c |  2 +-
 drivers/qmimodem/qmi.c           |  8 ++++----
 drivers/qmimodem/qmi.h           | 12 +++++-------
 drivers/qmimodem/sms.c           |  2 +-
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/call-settings.c b/drivers/qmimodem/call-settings.c
index 3611c98894a0..8a65217aceb0 100644
--- a/drivers/qmimodem/call-settings.c
+++ b/drivers/qmimodem/call-settings.c
@@ -24,7 +24,7 @@ struct call_settings_data {
 };
 
 static void query_status(struct ofono_call_settings *cs, uint16_t message,
-				qmi_result_func_t fn,
+				qmi_service_result_func_t fn,
 				ofono_call_settings_status_cb_t cb, void *data)
 {
 	struct call_settings_data *csd = ofono_call_settings_get_data(cs);
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 632f647e5ea7..c5a4a37b917d 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -141,7 +141,7 @@ struct qmi_notify {
 	uint16_t id;
 	uint16_t message;
 	unsigned int service_handle;
-	qmi_result_func_t callback;
+	qmi_service_result_func_t callback;
 	void *user_data;
 	qmi_destroy_func_t destroy;
 };
@@ -2678,7 +2678,7 @@ bool qmi_service_get_version(struct qmi_service *service,
 }
 
 struct service_send_data {
-	qmi_result_func_t func;
+	qmi_service_result_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
 };
@@ -2722,7 +2722,7 @@ done:
 
 uint16_t qmi_service_send(struct qmi_service *service,
 				uint16_t message, struct qmi_param *param,
-				qmi_result_func_t func,
+				qmi_service_result_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	struct qmi_device *device;
@@ -2838,7 +2838,7 @@ static bool qmi_service_cancel_all(struct qmi_service *service)
 }
 
 uint16_t qmi_service_register(struct qmi_service *service,
-				uint16_t message, qmi_result_func_t func,
+				uint16_t message, qmi_service_result_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	struct qmi_notify *notify;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index de6238f25e62..3e532ec25abd 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -60,11 +60,14 @@ typedef void (*qmi_destroy_func_t)(void *user_data);
 
 
 struct qmi_device;
+struct qmi_result;
 
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(void *user_data);
 
+typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
+
 void qmi_device_free(struct qmi_device *device);
 
 void qmi_device_set_debug(struct qmi_device *device,
@@ -105,9 +108,6 @@ struct qmi_param *qmi_param_new_uint8(uint8_t type, uint8_t value);
 struct qmi_param *qmi_param_new_uint16(uint8_t type, uint16_t value);
 struct qmi_param *qmi_param_new_uint32(uint8_t type, uint32_t value);
 
-
-struct qmi_result;
-
 bool qmi_result_set_error(struct qmi_result *result, uint16_t *error);
 const char *qmi_result_get_error(struct qmi_result *result);
 
@@ -130,8 +130,6 @@ int qmi_error_to_ofono_cme(int qmi_error);
 
 struct qmi_service;
 
-typedef void (*qmi_result_func_t)(struct qmi_result *result, void *user_data);
-
 typedef void (*qmi_create_func_t)(struct qmi_service *service, void *user_data);
 
 bool qmi_service_create_shared(struct qmi_device *device,
@@ -146,11 +144,11 @@ bool qmi_service_get_version(struct qmi_service *service,
 
 uint16_t qmi_service_send(struct qmi_service *service,
 				uint16_t message, struct qmi_param *param,
-				qmi_result_func_t func,
+				qmi_service_result_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 bool qmi_service_cancel(struct qmi_service *service, uint16_t id);
 
 uint16_t qmi_service_register(struct qmi_service *service,
-				uint16_t message, qmi_result_func_t func,
+				uint16_t message, qmi_service_result_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 bool qmi_service_unregister(struct qmi_service *service, uint16_t id);
diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 4238665a5e8d..2ac06a40bdd6 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -353,7 +353,7 @@ static void delete_msg(struct ofono_sms *sms, uint8_t tag)
 {
 	struct sms_data *data = ofono_sms_get_data(sms);
 	struct qmi_param *param;
-	qmi_result_func_t func = NULL;
+	qmi_service_result_func_t func = NULL;
 
 	DBG("");
 
-- 
2.45.0

