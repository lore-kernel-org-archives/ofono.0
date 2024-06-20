Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F6C1A00E8
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895110; cv=none; b=DcOERIYBtUaKwgX0njj5S66OdzMpupeoDROW3xcMAOGWEum8UCuiq7p0NDdNYKz1d5nBxCSTXhfojd1GVRBDkAp5x8jWTIjZBbGo2RAdQdRIgswiyYUEpru184FpCrLMxP+2xfQZ8rxwsp1JvgKRWwDENEJnA9eigiRGEJ9sdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895110; c=relaxed/simple;
	bh=AqmRSXpqsa74kzD6L/BnSNSpMChihtQQEBU2ZB4UNWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCEcIBt/S0tSNDZxR4uOaa2YGb8usgrKHt/aXbWKQFqxQThPlPIByqueVZ79JYRXYnDijxlc2I5KyXvBCW0T9PfwWkB64P/qUR9gCSA7nfC4tmBxu7wYN9wBGxH9fjeyRFeOp24mGS7SdVd1+fRdtT/ALIktDzu2M4okVH3vCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtG07q3V; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtG07q3V"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9d70d93dbso614267b6e.3
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895108; x=1719499908; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO1bu6fwYoOWz/p7z1OTd1k5bj+RKcc08WulqJPLBMU=;
        b=JtG07q3VZLs6qV1LuJzChSEfNxp5qR08jj08dXctlp5ia2mBCOiMJrIVFZy60n/1CT
         vuEFmzXVWgEaFV1tEy4oNuVKuBqvpPLhi70eVMrTsqzE0+w9seRz3GG5EhYrwgUazNcr
         0mOjqHO+34RWnnwNju2zbVzbTTl/6bPz96SEhl7tX+zzLv/nwHWJbUWWiIaBbpTPUnLU
         dzuN+kazT30QHt+YSH6+Ewl+77CP0PjTI+BRlR6ky1pYDb5tfz+pfNwCFzOIU0x/6LHg
         GnWtYXWOxzsLCdDN2eYbaCcBurhsd4nif3C5mhwGG+VZSZcbKBqJiVJSt4Sh3fbemqOZ
         Bh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895108; x=1719499908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO1bu6fwYoOWz/p7z1OTd1k5bj+RKcc08WulqJPLBMU=;
        b=eUDzuWNXYTK3H7SMyys8Z4m15CtGD/eXbLWxsR1TV62kOX2IcWD9J6N5vtcgaozSgb
         MlRJN1T7C6XgTB+pCpfW0BdLISLfSaGsxv3QjEWePsdG1Rkq3MBb/4GZ1EktV5KWKfQt
         uTH3yEyZbzV4r/HrGyeci21JGtYxMIBmB1+6tiqVEqdbrgAMXCcH/WkpWSrIO8QwJ+Vt
         1hTfcD7vOYhGJyeniMJujupMyw32nwvbAKl75/ppjXC8/jm6drNp7y1qWgFHBwSDv2cB
         UIVntEspdh6d4qLWVlYpc2/kpYAFiop3posi9YULVPUVzQ+Z//3ElNRejkAJZ1D0ta5T
         3RwQ==
X-Gm-Message-State: AOJu0Yws8Hh7/NJLxpB84kkeAn5B7XTupgC2T4GD9jhyXDva9CLpT1Ml
	7/NgdZu8e6TFfTroClLBu4y1kFp0gHFrvKpqCPx0bFv1Wz4wuInnM4HzcQ==
X-Google-Smtp-Source: AGHT+IF/FSIJwV98X/ihVpLtkRbz8RO9csXBwflNK2vh3uT/3JvHACZ0/BLliQb3Ppfv53d+HZzIZA==
X-Received: by 2002:a05:6808:16a2:b0:3d5:2bb7:867 with SMTP id 5614622812f47-3d52bb71282mr1765704b6e.17.1718895107944;
        Thu, 20 Jun 2024 07:51:47 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:47 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 02/33] qmi: Rename qmi_result_func_t
Date: Thu, 20 Jun 2024 09:50:49 -0500
Message-ID: <20240620145139.1135899-2-denkenz@gmail.com>
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

