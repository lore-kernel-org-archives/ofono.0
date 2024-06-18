Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BD28DCC
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740957; cv=none; b=AwXc+slNkZyfiNmC6OvDBwLMMqDPlOdNG92P7ycXy4b4zPQZyJjOT6AYzeBtN10EJvCa3Z4sbgmWfG1CEu1jEa6zFvZ+TB8Z26veNlP9C46jyIT5foLdI/jLjK4dq6MGVvVIrzctVrKfm6MAUqs+yqCGzzbE4M/sSRZ/VvtOWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740957; c=relaxed/simple;
	bh=AqmRSXpqsa74kzD6L/BnSNSpMChihtQQEBU2ZB4UNWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5+7DzdfqNiQLZ4Y8YM9wOmXS/wipyB4wQ84xr9r07oZnVHZJyf/9PHH3r9WE+K8PVewfEZQuk6Y/MIn3wpin8nshLcRtp5dSzUW55w80Nmg1eAY08LcmjBIbmUcUmY8bAEwmcJbdE7QssIjVwM2UOz7Sh4nhBfn9gaDKw6WHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij+SWUHf; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij+SWUHf"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2597922eb9eso592170fac.3
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740955; x=1719345755; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO1bu6fwYoOWz/p7z1OTd1k5bj+RKcc08WulqJPLBMU=;
        b=Ij+SWUHf+yXi1vq+18QYfcFNglKyTtGhR1iNxN8CvAKgUpWpbZWXUoikuzaI1pQIup
         58HvwCQCPHbmQ0ONAcyrG+kcIyJAXYkZR61f4RPlI0+OmiF5RzEzv8CH21XvzABRsohi
         pv2C41uscb/igOkf6rio7pzjhBCgaudaY4Tg4WvNKpF+RVsKXeUWYZfu/iNXafwSf+pZ
         AY9JlS2aoVXufDQhxH8d93eIpbBl8KOYX7/4mwidg6pNNwADLnwm/ju1qAoaf/AcptfU
         K54N/kADbg8rG9ARZ3nh3HtiMC6oYBNHUlwmDBKrrTVhc9D0CXdfzbtkWhQIC5cgFF/G
         OqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740955; x=1719345755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO1bu6fwYoOWz/p7z1OTd1k5bj+RKcc08WulqJPLBMU=;
        b=XS4CRi3U99ZRWLa3ZTFXTcA3Td1vICwc6nyXk9WOkB9c7wldCR7bgJVFim4RucWIfI
         HsUB7WLgtsKclbfpAHfvtRMtKI1KPK0iE8ypDo/O+PkgMccgdpP+WZ/QQcrcqsz295QD
         hvw69IVFE6HmPZy/Hg0pXsdM4xpIaHkgf7NYxhhntZhNdAEWJ4/8dKUD9UjJp65smlIe
         4gPRCNW6OtC1MUgH5rhcwJb4eFdBlYdgWLVHlvUx8/Pu9z1BzbN34FPXgbubHuGJ7sRy
         H+4m8OsHVk1lYWbgNeDi7W0B05GSx8388/bPCIc/6H79cu9JHUdho2i2ovTU9oJlkWJ/
         VPxQ==
X-Gm-Message-State: AOJu0YyWOQm0Gm6O2h1cehp61IZ3x39H28SMDxryLpip4mAMvJO2Sqaf
	SbNqNfXGCpaUjwQfw6Z4MJxHHShTojH9xd7fN/1ofW5+2XaAlqEXvMd34w==
X-Google-Smtp-Source: AGHT+IHrV2NpK9zCMyvpBjnVNT0KEV7tBgcGHhsy0FyA1xgDiTVabhkpl0hhgsYr+F14Jcr0JdKKXg==
X-Received: by 2002:a05:6870:a101:b0:254:ad5e:da49 with SMTP id 586e51a60fabf-25c94d05a5cmr839246fac.41.1718740954608;
        Tue, 18 Jun 2024 13:02:34 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:34 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 02/33] qmi: Rename qmi_result_func_t
Date: Tue, 18 Jun 2024 15:01:44 -0500
Message-ID: <20240618200231.1129282-2-denkenz@gmail.com>
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

