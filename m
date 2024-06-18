Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1B15E5C2
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740962; cv=none; b=qvd7BCOqUgQMGLchNZBnQ0se5f+/cAMiIfAFD0BghNTSg5MNF3RmD6zAvBZ5LiO+nKYN4+xwQRSGbloOGI0w59A2uIrF1AZL9+EFQid3LKc3gor1Xjxv2ICqlv8jF14REdTEs4YeqqroJIbb3Ke3COEAWDvKUyB/4b939Ti9djM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740962; c=relaxed/simple;
	bh=rPM/i4e7JNbB0GoUVEilA/feGaIkpNm+nSVtOMNo4+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meS9/46lAC/RcdbjbfXrhbTTltz6dqdn2SmvhXugs9LeT/o4IKwY9mSTYhqf7HLCLNLCQqPkpQiI+GEPL2fsWF4ib7v3JPcgBr2yySm1+5MYAS1eydU19tc+QTXFyrgqcslvkEwgH9/6Ma+/tT78tLbS9Js1VWpsSKpwWrHH6no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2u0kEnt; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2u0kEnt"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5bad217c51aso3162022eaf.1
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740960; x=1719345760; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EDL8Ih8ViGlHl/Bpn1rDCvC2MR4b8VD2nremi7vdg4=;
        b=W2u0kEntNU8Z13L9Htp/GdOfA17P7QF/+VlFS/EDdyqdJUcn5jsXrXYjdAeG87681+
         t+DnVXegMKJp0jTEPWoEQ5YNMF3cXLk7RZTPMBhQYZsrZw/btNavNC93vWCfXRkxJ5AO
         /sM/A3S5fkZiV318KB8tkOMXKWtzFGsIwF5LEG4nVcdngoeztThiu6qcQbZj8LtCc3sb
         /RNig+CpLkqdGMde1dQ/hz00Y5mNZ6pQfitQ3dQ/AZOpKzDAWILrAJEq4RnmHxggEXDv
         NW+TdZcit+BV5cVIBkiM5s5AXml6Gxxy2y9Fnkczk8uikEE1AE1s7R/zkz5R2wPfO2Ep
         X7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740960; x=1719345760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EDL8Ih8ViGlHl/Bpn1rDCvC2MR4b8VD2nremi7vdg4=;
        b=k/+KGPug3uS/mV2RBX3RScOI5QZ/XEjFhvmcp/1MCQhc8/CtNkKSRG/BNJzx4PH++K
         Jo9cOnjf/iqAk/X4ojDx1ou4aI71si05RMtMWpBblZ9sKWejrmxaO2izTMDfZBcE7vmf
         bUFewNUZAJ1T/XHAc+jLAahy2SCa2oWO1D2VOeK8wMwOyDdj3fhGa0B14x3g7Ji6dCJL
         olYerKLKzaw+oE55QRYVTQcxJGqewzoyAWdlZlxrQ+PMoTj/XNPdYq3ScK0S7cHJmpsH
         RHIDiWNO7zIzB56M+1ktsbSAi3rFBEpKyoWkKHTtqUgIZTK+KZfKjayGCvDdGZitFI+x
         8/Zg==
X-Gm-Message-State: AOJu0YzfGrqBKShy9X7dqbI+oe+aPVa5xAXC9FPLducXlPYL8yY6qXxR
	KdRZXgGaf4V7BZzcp0hVRzdovk2ngHVII3LRQLAovvLKvBKQK/uktsEkWA==
X-Google-Smtp-Source: AGHT+IEhatvLTYBr6tOGhFd3GJ6NwKhO9zJAsMlalP2HxDz1dp3ORi8CJRQt9yX6akRXJNZ6yNTxmg==
X-Received: by 2002:a05:6871:554:b0:24f:e832:de19 with SMTP id 586e51a60fabf-25c94d02f56mr819918fac.47.1718740960121;
        Tue, 18 Jun 2024 13:02:40 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:39 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 10/33] unit: Rename device to node
Date: Tue, 18 Jun 2024 15:01:52 -0500
Message-ID: <20240618200231.1129282-10-denkenz@gmail.com>
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

