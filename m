Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE761A2C0A
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391194; cv=none; b=Ksh8gQekz8ZWmY/NXB/YS/ocSI4vNfQpk6nvLLp3mlCCeXkmYzFFrgh6jNuIDpe0LNMNfePumctccfl09tEyuPiRmqnkGP14Gye2cGn08uUyuAiyxRUWd+KfcLd1PrLZ4Tpu2RX3Iq2L3cZiTYmPVjFA3arKhOzPAUBbJfhOVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391194; c=relaxed/simple;
	bh=+zhDgJw/D82iGKx28eTwBX4xQruzeo5sOR/AkeOGjoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6tY5EH6xnYWDs1hQzz5bgcdw0o+DoenEWE5MJtC+9cXBfXdRYpiSDdLEKkaY0RsOL8/5RUvuR7FBvgOLqEa2qQ7drohThBfYaS0JKl1KtPFHJJ2X42kVlBVUC8Gk+rhfJ6q63a15TDM5Ygbx50v8lHLbhHWwE0RRkBL8SZ5Ytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGaYP2PR; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGaYP2PR"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-254c56efe06so1221031fac.2
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391192; x=1718995992; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9fNNbSfh2WeZGPLrsfMCew1Ljg+9Wq+JnyF3lhrH44=;
        b=XGaYP2PR86V5OisMxLGDd5qeOMI0FYx6okzvpsULt6feWLLTj29XyrMWgO6Caz1FaD
         Xs+sYPJZmWum6UHfXnNsQQQJsye/C2/SWR57nvRMzvQeXw+xS798yO2agvhbfk6bYAlg
         tQd+no+iuitX/YdBwELQC8C0zr+KIVXleq3/7ilquDkxQPKK4r9v4RqMx5Dj0oFBkvRc
         JSNYu/W6qEzDQgLt5OZZvkO2TK/Lu6ggwGeFtJAKGgh5EPMQhS7XutnZKYe58IXSeZuP
         /q/wWA+49867f+VY73+gQ6qfnLWKCSKmMVV8DdKlUA/jw99di/sZ9wSQp4+9rDUev2g8
         qD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391192; x=1718995992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9fNNbSfh2WeZGPLrsfMCew1Ljg+9Wq+JnyF3lhrH44=;
        b=pJ7vWJug6zxYEsuChC8u6BrD0y2xbUf/iuDYxB2mzKn9tk4Hse0VP154zf7ybxquXc
         sXV9wemMp00qCicNz52y0jgqAleYySs7y1fZaYgbqwlAMgBkFjH5cwShwS9LHJl+Xmx7
         l2WjfrqencSNUxlDXAJrS3nU87LHcBRx6ueKz5f76djmKVbiwArnufjnidR/lyQlyfQz
         Tnc9ZqyhoHD0uVJaJpwaxEsAWC/299ZdtYi4Awx1Z51WkImIGymVvn5nnOTs/rPBQajz
         9T3+NX/s1gBOM0GL2ubbFUjOsZBBqGCxqhiT3BLfVlXStUOFNunBEojZuo3raSuv5rjG
         s0/Q==
X-Gm-Message-State: AOJu0Yw4mDZfUoHqirXqBw1f+E7VVQvdoGMPTRP2JJUMiOBHSSXyl1Wg
	4pk7fJagNULUthjaglJ47Mbx4PO1RBsd5FuhoHNVTzY4dNfZrvGBCBd2wg==
X-Google-Smtp-Source: AGHT+IHZ0yPZ5l8sJdDD/qr4Qq6nShKewCFixIT4UXuoWDSTZwRA8nah6vsml5tVARaj5DL4iK5Vqg==
X-Received: by 2002:a05:6870:8185:b0:254:ad5e:da48 with SMTP id 586e51a60fabf-25842b2503emr3868460fac.42.1718391191839;
        Fri, 14 Jun 2024 11:53:11 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:11 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 12/27] unit: Drop use of qmi_service_create_shared
Date: Fri, 14 Jun 2024 13:52:24 -0500
Message-ID: <20240614185300.1086701-12-denkenz@gmail.com>
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

---
 unit/test-qmimodem-qmi.c | 47 +++++++---------------------------------
 1 file changed, 8 insertions(+), 39 deletions(-)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 0fedd9803bb5..c40e9bb1d8af 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -34,7 +34,6 @@ struct test_info {
 	int service_fds[TEST_SERVICE_COUNT];
 	struct qmi_device *node;
 	struct l_timeout *timeout;
-	struct l_queue *services;
 
 	/* Data sent to our test service */
 	struct sockaddr_qrtr sender;
@@ -159,7 +158,6 @@ static struct test_info *test_setup(void)
 	/* Enable ofono logging */
 	qmi_device_set_debug(info->node, debug_log, NULL);
 
-	info->services = l_queue_new();
 	info->timeout = l_timeout_create(TEST_TIMEOUT, test_timeout_cb, info,
 								NULL);
 
@@ -172,8 +170,6 @@ static void test_cleanup(struct test_info *info)
 
 	l_free(info->received);
 	l_timeout_remove(info->timeout);
-	l_queue_destroy(info->services,
-				(l_queue_destroy_func_t) qmi_service_free);
 	qmi_device_free(info->node);
 
 	/* The qrtr services will be destroyed automatically. */
@@ -216,13 +212,6 @@ static void test_discovery(const void *data)
 	test_cleanup(info);
 }
 
-static void create_service_cb(struct qmi_service *service, void *user_data)
-{
-	struct test_info *info = user_data;
-
-	l_queue_push_tail(info->services, service);
-}
-
 /* Callbacks could queue other callbacks so continue until there are no more. */
 static void perform_all_pending_work(void)
 {
@@ -246,12 +235,7 @@ static void test_create_services(const void *data)
 		uint16_t major, minor;
 
 		service_type = unique_service_type(i);
-		assert(qmi_service_create_shared(info->node, service_type,
-						create_service_cb, info, NULL));
-		perform_all_pending_work();
-
-		assert(l_queue_length(info->services) == 1);
-		service = l_queue_pop_head(info->services);
+		service = qmi_qrtr_node_get_service(info->node, service_type);
 		assert(service);
 
 		assert(qmi_service_get_version(service, &major, &minor));
@@ -266,21 +250,14 @@ static void test_create_services(const void *data)
 	 * call the callback.
 	 */
 	service_type = unique_service_type(TEST_SERVICE_COUNT);
-	assert(!qmi_service_create_shared(info->node, service_type,
-					create_service_cb, info, NULL));
-	perform_all_pending_work();
-	assert(l_queue_isempty(info->services));
+	assert(!qmi_qrtr_node_get_service(info->node, service_type));
 
 	/* Confirm that multiple services may be created for the same type */
 	service_type = unique_service_type(0);
 
 	for (i = 0; i < L_ARRAY_SIZE(services); i++) {
-		assert(qmi_service_create_shared(info->node, service_type,
-						create_service_cb, info, NULL));
-		perform_all_pending_work();
-
-		assert(l_queue_length(info->services) == 1);
-		services[i] = l_queue_pop_head(info->services);
+		services[i] = qmi_qrtr_node_get_service(info->node,
+								service_type);
 		assert(services[i]);
 	}
 
@@ -455,10 +432,7 @@ static void test_send_data(const void *data)
 	perform_discovery(info);
 
 	service_type = unique_service_type(0); /* Use the first service */
-	assert(qmi_service_create_shared(info->node, service_type,
-					create_service_cb, info, NULL));
-	perform_all_pending_work();
-	service = l_queue_pop_head(info->services);
+	service = qmi_qrtr_node_get_service(info->node, service_type);
 	assert(service);
 
 	io = l_io_new(info->service_fds[0]);
@@ -505,10 +479,7 @@ static void test_notifications(const void *data)
 	perform_discovery(info);
 
 	service_type = unique_service_type(0); /* Use the first service */
-	assert(qmi_service_create_shared(info->node, service_type,
-					create_service_cb, info, NULL));
-	perform_all_pending_work();
-	service = l_queue_pop_head(info->services);
+	service = qmi_qrtr_node_get_service(info->node, service_type);
 	assert(service);
 
 	io = l_io_new(info->service_fds[0]);
@@ -567,10 +538,8 @@ static void test_service_notification_independence(const void *data)
 	l_io_set_read_handler(io, received_data, info, NULL);
 
 	for (i = 0; i < L_ARRAY_SIZE(services); i++) {
-		assert(qmi_service_create_shared(info->node, service_type,
-						create_service_cb, info, NULL));
-		perform_all_pending_work();
-		services[i] = l_queue_pop_head(info->services);
+		services[i] = qmi_qrtr_node_get_service(info->node,
+								service_type);
 		assert(services[i]);
 
 		send_request_via_qmi(info, services[i]);
-- 
2.45.0

