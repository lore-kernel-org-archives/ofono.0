Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123711A2C0D
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391192; cv=none; b=LuOPE5MmoTindvu5EiBhnek9fHjins26QAwI9uq3dVHAdnc+d4brjTOjtrpGYNXYeq7rMvKbOFHHvxO3TocQ8hA2annzxT7kIQkm7z8khoUX3BzLe/q6SUoSoJwiHdP/uhJgFj+o3wecKe8HtfmOxg5lndq/LKHv6oC0fpm0S7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391192; c=relaxed/simple;
	bh=rPM/i4e7JNbB0GoUVEilA/feGaIkpNm+nSVtOMNo4+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akBh8/ZTtncALNXpdIzNHqKB5EcrGD0amwmIBKi/7Ny3YBDmyrA1wOZ9X5S0lxOFE48XBNNwvcsI4lePKf2SJCBCjchqbwa5WeEZS42E3j8aoM8QXeqfQzgG7uNLwRSPeWWKqTwnwUWjKMxp6+heLd26bQszclU3E/AiHNu6YdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwR6go8m; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwR6go8m"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-254c8e27c80so1312039fac.2
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391190; x=1718995990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EDL8Ih8ViGlHl/Bpn1rDCvC2MR4b8VD2nremi7vdg4=;
        b=OwR6go8mO38FcSsBg8B+9pjrHtoraQOf+oQ0vfaSiWmycThRXpzyxut59KKuLqwYkc
         ZV5urCyfv8CH/r3pOEUzsdqqW0P1/K0fUPd6GaOal9cVfIASpmAPx0Mpvc/IfUhcxz7q
         1j2WAuL4aBicCLQMyZz6fk/ShfKe6kzXOMXycfD27dYfkBKx2YQoUWoYpewxar9rGfAu
         UHsfivYIty37nZ8WR7lCPY4YfeNfyC6EaAZZ9wDQnHe/e2CJRNQh9NAXN5LLHEgGSTn8
         p+61Vyn8rutftVfss6FUbKjGl4sYAPdzTICJ/r1aknb7/z6G+URwQcCvXodXpEhzIwxL
         ulTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391190; x=1718995990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EDL8Ih8ViGlHl/Bpn1rDCvC2MR4b8VD2nremi7vdg4=;
        b=GkTF2dAdXs1LhwtJllTzSqpDi0JzwJEO9oeOUgusr5fPzNMIaBkg+fgrHcgshMPjwV
         DTdPwAlc9Vsk/lq2Qve+gLju4IBj5Bp8wPXsFG0z+ET89DFQvC52zZoJ1DjvjfYX0tkW
         F4h/DkTGV6IDACTa9dIN7Oii9cjCNjNLAqbGho0SGG/H9PUptNKAw0FFOzjmMVcJ1zNE
         BqB27AlOP/i60bwt28dEkxolxZg1MO2h1wDPPPoVCgkN3BDSPGOoTKN6XB9c58ZVizCR
         z/Ty8/E4dz1Qf9TUfkx+rO8l2eMPwypE0rJlUJFcEeoTTEcqYOpoLQWKIXCLR3BMHRQw
         gJ8g==
X-Gm-Message-State: AOJu0YyB+HhAbeCvJncC9HMJeq6k27aiu/shLyyLDTRT+cBnESOC3JjE
	5ztQfMu4Sncec+wkYO3+th6CrCuS4JSKWstPQyqifSEnKFlhpCNaYp8rjg==
X-Google-Smtp-Source: AGHT+IEkYaBEgx4nNXv7vT21qBL3v63Nt1rTqELFToR/svkmcjVQZoMJZYn3LsdCtBBAhKTbjW5evQ==
X-Received: by 2002:a05:6870:6391:b0:254:c8ad:7355 with SMTP id 586e51a60fabf-25842911546mr3688111fac.22.1718391189901;
        Fri, 14 Jun 2024 11:53:09 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:09 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/27] unit: Rename device to node
Date: Fri, 14 Jun 2024 13:52:21 -0500
Message-ID: <20240614185300.1086701-9-denkenz@gmail.com>
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

