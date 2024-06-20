Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AC1AE84E
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895125; cv=none; b=UChvBq3si3WAEn3ef+6nLAEIwWO6Wo+OLLzpIN3QzHFRg1/7bK8rdpiavDZQQ+Lj5upr3kaJwR21wQrOSYtiaawBzDUT2b68xg4jVjUpSL4YnebdpcY9Lqb4u8sR+ofBxwQfd0Cve2ZFpgHu4h4TwW/htCGwYNRey8I8d6sWCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895125; c=relaxed/simple;
	bh=+zhDgJw/D82iGKx28eTwBX4xQruzeo5sOR/AkeOGjoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2JcrA6vioT1Qi9CZ3Ft7kSUahOSwbpCJT/s5w+cFmRzqqAPMsIDhzp3gaiq4PGJerYn0rFnkjdFvbeWSee+lJzYBVB6CRrBAXqmdXqaZmIg/aPP2b+pFC1/U/iAEqRtF3yZ/wg4NQraAMD9gfoeoBXSR0NxMsGv5uVHUKNBbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RauWhkfQ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RauWhkfQ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d24724514eso540296b6e.0
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895123; x=1719499923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9fNNbSfh2WeZGPLrsfMCew1Ljg+9Wq+JnyF3lhrH44=;
        b=RauWhkfQ0Kb5vjhHpOxVWucTjX+eTZT8ywd+EqP9tEjar4qgwknPoLzkbvuanN4o/u
         tA9QWLOTth4VVweeJcbB1tqHkVlIrIS6oGNnxa89Tl+NCdHfw7ArZXVYV9X2Bqo4kSNg
         KFQrvDbzHyDznr2Pf8d4ySnx2bcul4cR7tk24usB9NvFaOn41Ioko3hP0kQ+MnZ+13xk
         Xjq3EJuXkPSDBK3VjQXHD5S9PjdT82BlBUjh+9YLVlTiIe7Hrjs+18fBF/Mb/6Q9P5uS
         9qMB4cjEaJFzuf69mG/NEtc1nRZrfQnvykqB3KmYUGWxoPAYxhfGqhsNkN8egvqRMFDx
         Mxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895123; x=1719499923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9fNNbSfh2WeZGPLrsfMCew1Ljg+9Wq+JnyF3lhrH44=;
        b=a4NlRYWF5f4zYYMZT8iMvnDkWzide7nUN2pC5fKTpxOGOLBPqyZyNPU2QSp4p4mJRd
         JC77jioNexNXLuRqQQ80bl7WGWAVgvnYj8An26Nn2CLNmdhMnJHEuzMhwms9PFVzXh3k
         2dcrK2hPo/yd36zMNiMbHV7dTPjy/eCnr2UgnBez5GXYNveS4rF+VysoUSM9nW5RCGnd
         uyouLHQb+JjMk5qT+fNzI8PCmucRugrfEjUNR8K3TF2p5+qWSqUN69+vd5zBtKpauEqc
         ZfX2L1qUZyPHgPOIDVwMaAy6/CNoRxiqjIc8bC72zjleEodket9qhlNA5lljVei8Lc9w
         E9rA==
X-Gm-Message-State: AOJu0YwlSp+xUpagAEE5i8B5hMezqyS69AxwJHjmlkRddsZjNiVwHq3N
	0VKUts0Jv54U3/1vJZ3cr/zmLnfD1j5TpHlx+VwipPk8qVtIBR4T0gMWSg==
X-Google-Smtp-Source: AGHT+IFTGvUlk6r5kfLozG3/eyK1zLBEJtgLwS7qOnivf3k2TK+jGm4kaHa5BSl6iW1p+3gHHVF2JA==
X-Received: by 2002:a05:6808:148e:b0:3d2:212e:71a0 with SMTP id 5614622812f47-3d51b96ddb8mr6145009b6e.6.1718895121948;
        Thu, 20 Jun 2024 07:52:01 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:01 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 13/33] unit: Drop use of qmi_service_create_shared
Date: Thu, 20 Jun 2024 09:51:00 -0500
Message-ID: <20240620145139.1135899-13-denkenz@gmail.com>
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

