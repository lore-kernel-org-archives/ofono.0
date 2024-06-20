Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40071AE849
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895120; cv=none; b=iL40YL/PakjfCc6BfLy/D4eLL33WZpYhvMd1BvDGyEfH7aqeC1GwbyfqrC/0klTUylP7Rd+L7SlBsu6W2l0q9cSPmyEwVX6tVBD49xd0Hn0EWdeqPDwpbzrxRylliOemw8STTQldLEopwXirDg4ajs1MdPeebXhxTfHqZ3IBQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895120; c=relaxed/simple;
	bh=rPM/i4e7JNbB0GoUVEilA/feGaIkpNm+nSVtOMNo4+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBWlGTfh+BxNgsYoM/El8lrKEaj7CIs2gYHNiMdQeGIsnI0tmGOrT6s4+gptZPU9yiW6i6npK3mOJuk39zV+v8fV1N9b+nmntcKdn/M7IVebyRkHum0N1Wxm8wvtEm8B7c+TTFgl0yBfgMs94zFsvoWf4I0Uop6Lbgcv+rQ1zQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caXmF5Vl; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caXmF5Vl"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d516d3f0b2so563017b6e.1
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895118; x=1719499918; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EDL8Ih8ViGlHl/Bpn1rDCvC2MR4b8VD2nremi7vdg4=;
        b=caXmF5VllYO/akKusiDuYSGvZ0gtTe35LhlfVP4m3w4EkSJekqAso5MMPdIa4YNUf3
         8z9Cuc50UGK4z/KB/Xgd6f2BPOjEcxgqL3nLr7LyKErS7Bi+y4xE5huuOCad2i6SPSKh
         eAVoOWOn4GcYsA5VyCjARA071LMGs+EyMsFyzn/IAM9pPOmjdaTIU7mfkkkTewr+e8Gv
         3XlwO3QHskiIqqx9KZmaNWRYyqC6d1DDUm1wlVbedkVOAJitKV2EXW8TyLx3pNMiSGE/
         k0Y/x5pcU2mYBuc/S293yhn1E6w/iZhuHSwATEdKXQp2QXZ35AAeHp6/Ka8bqAdFdmw5
         js7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895118; x=1719499918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EDL8Ih8ViGlHl/Bpn1rDCvC2MR4b8VD2nremi7vdg4=;
        b=BY9xaiJ/fpGfPa2G9WSfnAuCSv+6RAO6sVSMgD29uoO7v96iDcMYpCJ9+Obb8JE2pq
         cRUpqF8dsstV4rF+T19EeWBn1bqQ6RXQaLzir1HZN7k0c1sE2xgCfNtTFNrTdstccwak
         /qqanPOAbT0AsfGPX3QoVX/i/gZHG6cVDRNHqjyfxye8lT6SOPFCgznLZ2SEzEgconGC
         T3aFRQlt16yFc9gNpk0xw9i9z8gw4/wR7svqkz8/qS5Kn+eaAxOKLIR5cQ/l/Stjewli
         k2RwK978lG8OieIUxDnkT9e4nX0Ahy+llH81sWFTb50nIC8Hz79xA723XqZmuTiAgFwL
         XCfw==
X-Gm-Message-State: AOJu0Yw4jrMm/0f+RTkcMtgprr68RZgSspY2+hB8I40y8e7S5uoH4/0y
	d65ENDc4O0czo8/FGcAuTs7qwuN1PEk4s6mpFMKta6eUYOihUBgVI8jsTw==
X-Google-Smtp-Source: AGHT+IH5os+1+d1in1DBCSqE02srsQQ5EDdbGx2qsM98dCrhYhO2ZzWknG0wgctrTcxsJp5JWfd6QQ==
X-Received: by 2002:a05:6808:1315:b0:3d2:1c25:1078 with SMTP id 5614622812f47-3d51bae596bmr6418742b6e.38.1718895117897;
        Thu, 20 Jun 2024 07:51:57 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:57 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 10/33] unit: Rename device to node
Date: Thu, 20 Jun 2024 09:50:57 -0500
Message-ID: <20240620145139.1135899-10-denkenz@gmail.com>
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

This better reflects the terminology on the QRTR bus
---
 unit/test-qmimodem-qmi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index c7db6a053ef5..07560aadcc49 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -32,7 +32,7 @@
 
 struct test_info {
 	int service_fds[TEST_SERVICE_COUNT];
-	struct qmi_device *device;
+	struct qmi_device *node;
 	struct l_timeout *timeout;
 	struct l_queue *services;
 
@@ -153,11 +153,11 @@ static struct test_info *test_setup(void)
 
 	info = l_new(struct test_info, 1);
 	setup_test_qrtr_services(info);
-	info->device = qmi_device_new_qrtr();
-	assert(info->device);
+	info->node = qmi_device_new_qrtr();
+	assert(info->node);
 
 	/* Enable ofono logging */
-	qmi_device_set_debug(info->device, debug_log, NULL);
+	qmi_device_set_debug(info->node, debug_log, NULL);
 
 	info->services = l_queue_new();
 	info->timeout = l_timeout_create(TEST_TIMEOUT, test_timeout_cb, info,
@@ -174,7 +174,7 @@ static void test_cleanup(struct test_info *info)
 	l_timeout_remove(info->timeout);
 	l_queue_destroy(info->services,
 				(l_queue_destroy_func_t) qmi_service_free);
-	qmi_device_free(info->device);
+	qmi_device_free(info->node);
 
 	/* The qrtr services will be destroyed automatically. */
 	for (i = 0; i < TEST_SERVICE_COUNT; ++i)
@@ -185,7 +185,7 @@ static void test_cleanup(struct test_info *info)
 	l_main_exit();
 }
 
-static void test_create_qrtr_device(const void *data)
+static void test_create_qrtr_node(const void *data)
 {
 	struct test_info *info = test_setup();
 
@@ -201,7 +201,7 @@ static void discovery_complete_cb(void *user_data)
 
 static void perform_discovery(struct test_info *info)
 {
-	qmi_device_discover(info->device, discovery_complete_cb, info, NULL);
+	qmi_device_discover(info->node, discovery_complete_cb, info, NULL);
 
 	while (!info->discovery_callback_called)
 		l_main_iterate(-1);
@@ -246,7 +246,7 @@ static void test_create_services(const void *data)
 		uint16_t major, minor;
 
 		service_type = unique_service_type(i);
-		assert(qmi_service_create_shared(info->device, service_type,
+		assert(qmi_service_create_shared(info->node, service_type,
 						create_service_cb, info, NULL));
 		perform_all_pending_work();
 
@@ -266,7 +266,7 @@ static void test_create_services(const void *data)
 	 * call the callback.
 	 */
 	service_type = unique_service_type(TEST_SERVICE_COUNT);
-	assert(!qmi_service_create_shared(info->device, service_type,
+	assert(!qmi_service_create_shared(info->node, service_type,
 					create_service_cb, info, NULL));
 	perform_all_pending_work();
 	assert(l_queue_isempty(info->services));
@@ -275,7 +275,7 @@ static void test_create_services(const void *data)
 	service_type = unique_service_type(0);
 
 	for (i = 0; i < L_ARRAY_SIZE(services); i++) {
-		assert(qmi_service_create_shared(info->device, service_type,
+		assert(qmi_service_create_shared(info->node, service_type,
 						create_service_cb, info, NULL));
 		perform_all_pending_work();
 
@@ -455,7 +455,7 @@ static void test_send_data(const void *data)
 	perform_discovery(info);
 
 	service_type = unique_service_type(0); /* Use the first service */
-	assert(qmi_service_create_shared(info->device, service_type,
+	assert(qmi_service_create_shared(info->node, service_type,
 					create_service_cb, info, NULL));
 	perform_all_pending_work();
 	service = l_queue_pop_head(info->services);
@@ -505,7 +505,7 @@ static void test_notifications(const void *data)
 	perform_discovery(info);
 
 	service_type = unique_service_type(0); /* Use the first service */
-	assert(qmi_service_create_shared(info->device, service_type,
+	assert(qmi_service_create_shared(info->node, service_type,
 					create_service_cb, info, NULL));
 	perform_all_pending_work();
 	service = l_queue_pop_head(info->services);
@@ -567,7 +567,7 @@ static void test_service_notification_independence(const void *data)
 	l_io_set_read_handler(io, received_data, info, NULL);
 
 	for (i = 0; i < L_ARRAY_SIZE(services); i++) {
-		assert(qmi_service_create_shared(info->device, service_type,
+		assert(qmi_service_create_shared(info->node, service_type,
 						create_service_cb, info, NULL));
 		perform_all_pending_work();
 		services[i] = l_queue_pop_head(info->services);
@@ -623,7 +623,7 @@ int main(int argc, char **argv)
 	__ofono_log_init(argv[0], "*", FALSE);
 
 	l_test_init(&argc, &argv);
-	l_test_add("QRTR device creation", test_create_qrtr_device, NULL);
+	l_test_add("QRTR node creation", test_create_qrtr_node, NULL);
 	l_test_add("QRTR discovery", test_discovery, NULL);
 	l_test_add("QRTR services may be created", test_create_services, NULL);
 	l_test_add("QRTR service sends/responses", test_send_data, NULL);
-- 
2.45.0

