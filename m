Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD5186E41
	for <ofono@lists.linux.dev>; Thu, 30 May 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080190; cv=none; b=IbgFXM37/CppchrLOB7BRyeipSwC9R/zXyD2gfw/bZ4kyuApz9BXn1BL9GkvoPs+zFkqsg0nbkRfSkf4e9dIwJYlZu0aQaR39KwLRYQlJPcw2/feiG7c02tcbqRIF7PwML559ICHsn/8Dn/XiiH7fNdaGulU4MM52T4R6EPbuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080190; c=relaxed/simple;
	bh=kIE4ytsOPudEUEnkzISwtJwtuU06lvOvV7pBOGi2xzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5T7p1G4PQ6LSDC6Y5BW9s91zfewHrb9jj+w/9EatGB7wVJDjB0dr6VPhSWwuo7q0q11RPRbsTv+ayyBsgB6DPbOM1WAx2jaRdHRgczPHntZqUPxYDzUUaAEyzmzdSxxaeBMst9SoA1LYw+9vWMuIDKjxF20V1uspwgxeL2kSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRMtmugj; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRMtmugj"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-24fc5d260d4so567786fac.0
        for <ofono@lists.linux.dev>; Thu, 30 May 2024 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717080188; x=1717684988; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=noEgqseziX6vHpD2DxaOr6HXgU8zA+EZIsNFjw1bjLU=;
        b=MRMtmugjn2MsjHrHbUS5mRZ1cGWoHBPSoC2JB09R1vlbGRgbFEcmWe+GuZ3w0ITEVm
         cMPJOZ689gM6fZKGsUEAxWQ7wk0+TU8Pb+w2OeLHf1vUraXHYV1uf0lvtiFyeSwz3udp
         HKzXeISSQ0HGg7ZH1mU27r19GUEK7glWG3zKc3oDqYstOgCEWMQR2SHLA3+rCLAqLEPO
         hZMScgnGXWYPoiJ8UQrA8EhlYSHq33KQv56iflJ05uu30HuWNY3n7BYirOhmSAFP/VPE
         JbsA/6vuQKaXiGoqe6OtYzoCQPrpTtoNzcKeMfI9CQsdzYwIJ1xcui4OvSD5tUsSTc91
         aM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717080188; x=1717684988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noEgqseziX6vHpD2DxaOr6HXgU8zA+EZIsNFjw1bjLU=;
        b=L1kgzcM1sIL/44KBMu4sTvn0sCMcRVe5oLVytxdoPevst9Sg7LQ736YlY4+1ql+81c
         7AAsX3sGj326gvCtk7OfufW/j3kyzOzC30ntBiPdU9llug4MgZckw0WHlwec+p64l4x/
         lYH5sOewaw+nABeMQdndUJ0RxJQQ0Z/ICTGo35YAg+KHlfR1rLnif7yCfzdsxBVclxmY
         hamdv6nLlUcsfWkq1NxcEaRSOFwsckNaZZBl1IswMRM0Wbr7eKwqUDXzNRBviA/azrNf
         HpToaG5fwSX9gy3GOWMw+8vhaMvcV3p6XDdEfMShbY7kVM3GgxWyoQ0d2r7IpM7Tbacp
         /1Wg==
X-Gm-Message-State: AOJu0YxFUkiIgwpXl6OY0bPjY5zXiYDwTBIc/CD2zI1d/rpO6s0vlP5s
	vaS4gGBVZ0VE/214AVAJJWKeFbidwbO/BUzFUKvGskt5fwpSlzr+Z0kwYA==
X-Google-Smtp-Source: AGHT+IEuToGVTrhS37WbJBCyWOsrUXpJiiZzknSchxcOZ20GkkVSty2Es7lJ2yObV0LQ1SUZU9aGqA==
X-Received: by 2002:a05:6870:d289:b0:24f:f227:aa9e with SMTP id 586e51a60fabf-25065b27090mr878145fac.1.1717080187808;
        Thu, 30 May 2024 07:43:07 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25028ce5f1asm1321462fac.28.2024.05.30.07.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:43:07 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] qmimodem: Remove the create exclusive service API
Date: Thu, 30 May 2024 09:42:34 -0500
Message-ID: <20240530144305.266664-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steve Schrock <steve.schrock@getcruise.com>

qmi_service_create and qmi_service_create_shared were doing the same
thing--creating shared services. This change eliminates
qmi_service_create to avoid misleading the reader. Exclusive
services will be necessary, but they are going to be implemented
differently.
---
 drivers/qmimodem/location-reporting.c |  3 ++-
 drivers/qmimodem/qmi.c                |  8 --------
 drivers/qmimodem/qmi.h                |  3 ---
 drivers/qmimodem/sim.c                |  4 ++--
 drivers/qmimodem/sms.c                |  3 ++-
 drivers/qmimodem/voicecall.c          |  2 +-
 plugins/gobi.c                        |  2 +-
 unit/test-qmimodem-qmi.c              | 12 ++++++------
 8 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/location-reporting.c
index e83fd10eae5d..2bde369b46b8 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -244,7 +244,8 @@ static int qmi_location_reporting_probe(struct ofono_location_reporting *lr,
 
 	ofono_location_reporting_set_data(lr, data);
 
-	qmi_service_create(device, QMI_SERVICE_PDS, create_pds_cb, lr, NULL);
+	qmi_service_create_shared(device, QMI_SERVICE_PDS, create_pds_cb, lr,
+					NULL);
 
 	return 0;
 }
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5b016f2d1227..fc43500fae0b 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2712,14 +2712,6 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	return true;
 }
 
-bool qmi_service_create(struct qmi_device *device,
-				uint16_t type, qmi_create_func_t func,
-				void *user_data, qmi_destroy_func_t destroy)
-{
-	return qmi_service_create_shared(device, type, func,
-						user_data, destroy);
-}
-
 const char *qmi_service_get_identifier(struct qmi_service *service)
 {
 	if (!service)
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 0075f73803cc..802cb065b5fb 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -150,9 +150,6 @@ typedef void (*qmi_result_func_t)(struct qmi_result *result, void *user_data);
 
 typedef void (*qmi_create_func_t)(struct qmi_service *service, void *user_data);
 
-bool qmi_service_create(struct qmi_device *device,
-				uint16_t type, qmi_create_func_t func,
-				void *user_data, qmi_destroy_func_t destroy);
 bool qmi_service_create_shared(struct qmi_device *device,
 				uint16_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 4137a432d3d2..03be5c8f2ef8 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -896,8 +896,8 @@ static void create_dms_cb(struct qmi_service *service, void *user_data)
 
 	data->dms = service;
 
-	qmi_service_create(data->qmi_dev, QMI_SERVICE_UIM, create_uim_cb, sim,
-					NULL);
+	qmi_service_create_shared(data->qmi_dev, QMI_SERVICE_UIM, create_uim_cb,
+					sim, NULL);
 }
 
 static int qmi_sim_probe(struct ofono_sim *sim,
diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index c6252d9d12cb..97e0862d6f23 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -788,7 +788,8 @@ static int qmi_sms_probe(struct ofono_sms *sms,
 
 	ofono_sms_set_data(sms, data);
 
-	qmi_service_create(device, QMI_SERVICE_WMS, create_wms_cb, sms, NULL);
+	qmi_service_create_shared(device, QMI_SERVICE_WMS, create_wms_cb, sms,
+					NULL);
 
 	return 0;
 }
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index c6383a563b6e..f4ca2e96f59a 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -763,7 +763,7 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 
 	ofono_voicecall_set_data(vc, data);
 
-	qmi_service_create(device, QMI_SERVICE_VOICE,
+	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
 					create_voice_cb, vc, NULL);
 
 	return 0;
diff --git a/plugins/gobi.c b/plugins/gobi.c
index bb4560c43a06..c9db6704dce0 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -405,7 +405,7 @@ static void create_dms_cb(struct qmi_service *service, void *user_data)
 
 	data->dms = service;
 
-	if (qmi_service_create(data->device, QMI_SERVICE_WDA,
+	if (qmi_service_create_shared(data->device, QMI_SERVICE_WDA,
 					create_wda_cb, modem, NULL))
 		return;
 
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 00bd135683cd..c7db6a053ef5 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -246,7 +246,7 @@ static void test_create_services(const void *data)
 		uint16_t major, minor;
 
 		service_type = unique_service_type(i);
-		assert(qmi_service_create(info->device, service_type,
+		assert(qmi_service_create_shared(info->device, service_type,
 						create_service_cb, info, NULL));
 		perform_all_pending_work();
 
@@ -266,7 +266,7 @@ static void test_create_services(const void *data)
 	 * call the callback.
 	 */
 	service_type = unique_service_type(TEST_SERVICE_COUNT);
-	assert(!qmi_service_create(info->device, service_type,
+	assert(!qmi_service_create_shared(info->device, service_type,
 					create_service_cb, info, NULL));
 	perform_all_pending_work();
 	assert(l_queue_isempty(info->services));
@@ -275,7 +275,7 @@ static void test_create_services(const void *data)
 	service_type = unique_service_type(0);
 
 	for (i = 0; i < L_ARRAY_SIZE(services); i++) {
-		assert(qmi_service_create(info->device, service_type,
+		assert(qmi_service_create_shared(info->device, service_type,
 						create_service_cb, info, NULL));
 		perform_all_pending_work();
 
@@ -455,7 +455,7 @@ static void test_send_data(const void *data)
 	perform_discovery(info);
 
 	service_type = unique_service_type(0); /* Use the first service */
-	assert(qmi_service_create(info->device, service_type,
+	assert(qmi_service_create_shared(info->device, service_type,
 					create_service_cb, info, NULL));
 	perform_all_pending_work();
 	service = l_queue_pop_head(info->services);
@@ -505,7 +505,7 @@ static void test_notifications(const void *data)
 	perform_discovery(info);
 
 	service_type = unique_service_type(0); /* Use the first service */
-	assert(qmi_service_create(info->device, service_type,
+	assert(qmi_service_create_shared(info->device, service_type,
 					create_service_cb, info, NULL));
 	perform_all_pending_work();
 	service = l_queue_pop_head(info->services);
@@ -567,7 +567,7 @@ static void test_service_notification_independence(const void *data)
 	l_io_set_read_handler(io, received_data, info, NULL);
 
 	for (i = 0; i < L_ARRAY_SIZE(services); i++) {
-		assert(qmi_service_create(info->device, service_type,
+		assert(qmi_service_create_shared(info->device, service_type,
 						create_service_cb, info, NULL));
 		perform_all_pending_work();
 		services[i] = l_queue_pop_head(info->services);
-- 
2.45.0

