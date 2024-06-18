Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D916DC21
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740966; cv=none; b=XK2cqfegXCsvt3q0fyEgpr0IIVUGQzldIbVmkheM6xX882dew3ISB+bR1E2h/KgxrTQuVhZAmKaN0qeW/jfM368a+RtnSt8xZZ4MuqkOJWq24QmKV/dpONySk+ZrrDg3/QjgmLzuccf+Fyml73Y7Uksn5w4VOfcWVJPmrg+ljXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740966; c=relaxed/simple;
	bh=+zhDgJw/D82iGKx28eTwBX4xQruzeo5sOR/AkeOGjoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFJyaHcX6xl2UOOWon7E86vPWtrG+NW2WkV3rjUl4eNLYJ3fQPA2R3NzJgEmqoocYkxXodD09hpB9g7pcHVv58anosR1uw92aK4kdZL33RNxCTfX6AzcIUBr+aMfzYzVV9y/PardYmS4O0Lc73WX9tp3lI1c4ycA6TxHEJAbaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYlLURId; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYlLURId"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-254c8e27c80so3184584fac.2
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740964; x=1719345764; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9fNNbSfh2WeZGPLrsfMCew1Ljg+9Wq+JnyF3lhrH44=;
        b=dYlLURId8fglPyqKAzQ7fazrD+rUe17ZyFTQ4AVJ4EztMGV4dv8+LxhxQBEewcO7uP
         l4nQYdwD+oF/inChF/eIPsJPf1Y+3qXEA3c0auj5Veg9cchA8moeTmU6bsCAvY4H7SpT
         sLDcdgSe7qIwIl3CAIsQurDJhnHR6/Fip9uaVRrZS0iD9+cuZOgMtORbhkiEXMf+t9f+
         buQbAkISv25oNT5UQ6/13guOqg7sAslptvEzkXGbRR1yfvzKU3Gcv3JRFxyZvMTPwCAm
         SfHKRVvEV0kjdbF9FK4Q+dIOAxTtfQAA/DeKG6oaE1tS7fo9MG1NmKkcyO0jDVtjlyW1
         dhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740964; x=1719345764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9fNNbSfh2WeZGPLrsfMCew1Ljg+9Wq+JnyF3lhrH44=;
        b=mi683IgKcEAYRtOiQSamLh40mcBZGtOOM8I+S5UdER0gcpAia/rcJ9XH9PF5rhbMSe
         mfKyKVZrFs6yBRvjCpQRvTpwnQ/4CZolqGDiZXu3ZpA3yS5sTsSD/a9KoFWgDYaMd7J4
         N76YOW0kN63qufQUbpnA+FA36i3/oUplC5fwNsezOgBVWkgwGBvtkRZgl91GdYQedHM5
         G3TWhQRWqj+Voulumng+dCs9EAVRm+WUg6C4q0lTY+weAk1Bz+4GOiwRjHQsHX0s3DC1
         f/NBsOXEnJV1/+x5Uw6UWrSSjsQlLUTuqVYXF8OJGZbMKeJYWxdNGRXacrDa26hkF/Vw
         +McQ==
X-Gm-Message-State: AOJu0YyGBDx44w8BT+eYokNCeQzF6divdWMT20D5u67X1EkeCFrFCHJu
	cq90bnBZKFmns6OOx+9VyWKKLvzJb5/BXKS0kXSDWRvPT2Dp3cbI1z9+jA==
X-Google-Smtp-Source: AGHT+IGiYvXz+Bh4dySsEV1yDWH0NOIMqerhcTEZ0u0F/FpYpdZ7okpicbWz41n9aCOoP0aJwOpMDw==
X-Received: by 2002:a05:6870:d889:b0:254:c617:a9a0 with SMTP id 586e51a60fabf-25c94d713eemr919841fac.50.1718740964010;
        Tue, 18 Jun 2024 13:02:44 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 13/33] unit: Drop use of qmi_service_create_shared
Date: Tue, 18 Jun 2024 15:01:55 -0500
Message-ID: <20240618200231.1129282-13-denkenz@gmail.com>
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

