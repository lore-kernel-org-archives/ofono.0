Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5414174ECF
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333735; cv=none; b=RkYC1SHYHk/zHo4OyFb4JAQmwOPORYfUYQtxMbFWN+fz8rIqF5fXny3ymGVp3hLb1O8V3Xp6GSdt6MjDGwsW5KLN5/uX9ylQjo2+8YcTJxMPq0JhQ4YeugqGzMBjbmdJ1so58OZcVGynC16V6CBKrZMtsNpOKfBfxzoX0a6/+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333735; c=relaxed/simple;
	bh=/T5J0bBrC48jeSha7+fYGXWak7+mAdNB6W4S6FP0UYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQz8xdSskzKljX8U4aKyGy/LN6DiwaPY7Z+ZLdBzZtQhxvmeCeWhTDyV1EP4KTr3c77F4H5dm98mWKDbN3Rmw7A1iEl5+x4daPVs9a+H6039n63TCs+SrXVshDHO/E1VJXdXJ8rCMT/bfLPG/FdclieVIdZ74S3F8zAGaxaiGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLz2NZ/b; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLz2NZ/b"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f99555c922so3330843a34.3
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333733; x=1719938533; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bbtDJ3m87AQNzaszUaZlYQ5b5tKALGpvm/H+4yrLOU=;
        b=fLz2NZ/bQuBw4k+iKJYgcuIYnwtabjjfcljvZbB5UZSM0tIPiWpxjrS9JPKV+zLx9k
         d6cYSx9u3RwyC+7ZCAXwSnpS5QUZ7rnijtSV9PrxP3ztXvnl7dX6zM9QbdWDHED6O7Yv
         swJaAlCH11JHaeRl4eBDpeWJYub0N4vU5aIV25/l9yBGX+vzSoJ4U/BImi/hLx+ELYDO
         cV+6mzOtkTqiJEvkoKoFFakoZpN0NZHg3BwEaD0ZwkCdXnbmLM1p9trdu9fCtHDQXVKr
         y9xjkGp8QfDUIBhQ2MK9X5fq0kKvno3/sIk5x7RyBGfTuIjGNhcXcCmxljPB8Xpe8vMR
         PiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333733; x=1719938533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bbtDJ3m87AQNzaszUaZlYQ5b5tKALGpvm/H+4yrLOU=;
        b=n905ZA1vQ69t+bUtLbvcAcN6jc4FZPUUhUmWB9n34AYeqd41cS8Pau4f/Q8zlR7qpc
         VapO6HgKlJ+ctKj9LiNty2VqGIDsn/sYhjIM8C4XpfcKl9UJWf7A6q/gJmpry7N1mjcB
         6cibwJr3+Ziy+j5+4YhS87YAmJpn8aEvAgjogDey2oKZ9nAdIesuTj5FJYBMO7jfEq+H
         vDajgfdVtmK/sEsP8m5YSDMGQiOONnNRIkjdQ/z9ZXO4tbx7BXnz9+/XV6hGwsOoWv82
         1ZdfdFO3snDpcbjJeuV/R3MW966bV2Gyg0KMOaLIgd17KBWsG65Pix1NgF3ugVTBR6Ch
         29lA==
X-Gm-Message-State: AOJu0YzdAHbslTFNvDW5ZHSIx5M6KLXVrfz+73xgHZn4Lz1VheNvd67f
	mIuSe736QdKo2JLD2111OvTq9wIZeSVlgiN3rwq6a6YbFXOdyN0JxhJYJg==
X-Google-Smtp-Source: AGHT+IGwVy1DkyUYdcf7zZHXuAFj1jQODaEIgU+TO4cSFUg1ywKXZkvU3bTMG4KK1n8Nu/S3vj63qQ==
X-Received: by 2002:a05:6830:1bed:b0:6f9:7a21:b3ad with SMTP id 46e09a7af769-700af928336mr8722999a34.21.1719333732767;
        Tue, 25 Jun 2024 09:42:12 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:12 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 14/14] unit: Add unit test for QRTR dedicated services
Date: Tue, 25 Jun 2024 11:41:50 -0500
Message-ID: <20240625164158.1170937-14-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240625164158.1170937-1-denkenz@gmail.com>
References: <20240625164158.1170937-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While here, also add a couple of helper functions that perform
boiler-plate operations.  The service_common_setup helper
takes a 'dedicated' parameter which is used to select whether
qmi_qrtr_node_get_service or qmi_qrtr_node_get_service_dedicated
is used for service creation.
---
 unit/test-qmimodem-qmi.c | 73 +++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index e68f5a7bdd8f..bc021901ce74 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -413,26 +413,45 @@ static void send_response_to_client(struct test_info *info, struct l_io *io)
 		l_main_iterate(-1);
 }
 
-/*
- * Initiates a send of the TLV data payload to the test service. The test
- * service will respond with the same data payload.
- */
-static void test_send_data(const void *data)
+static struct qmi_service *service_common_setup(struct test_info *info,
+								bool dedicated)
 {
-	_auto_(test_cleanup) struct test_info *info = test_setup();
-	struct l_io *io;
 	uint32_t service_type;
 	struct qmi_service *service;
 
 	perform_lookup(info);
 
 	service_type = unique_service_type(0); /* Use the first service */
-	service = qmi_qrtr_node_get_service(info->node, service_type);
+
+	if (dedicated)
+		service = qmi_qrtr_node_get_dedicated_service(info->node,
+								service_type);
+	else
+		service = qmi_qrtr_node_get_service(info->node, service_type);
+
 	assert(service);
 
-	io = l_io_new(info->service_fds[0]);
+	return service;
+}
+
+static struct l_io *setup_io(int fd, void *user_data)
+{
+	struct l_io *io = l_io_new(fd);
+
 	assert(io);
-	l_io_set_read_handler(io, received_data, info, NULL);
+	l_io_set_read_handler(io, received_data, user_data, NULL);
+	return io;
+}
+
+/*
+ * Initiates a send of the TLV data payload to the test service. The test
+ * service will respond with the same data payload.
+ */
+static void test_send_data(const void *data)
+{
+	_auto_(test_cleanup) struct test_info *info = test_setup();
+	struct l_io *io = setup_io(info->service_fds[0], info);
+	struct qmi_service *service = service_common_setup(info, false);
 
 	send_request_via_qmi(info, service);
 	send_response_to_client(info, io);
@@ -441,7 +460,6 @@ static void test_send_data(const void *data)
 	qmi_service_free(service);
 }
 
-
 static void notify_cb(struct qmi_result *result, void *user_data)
 {
 	struct test_info *info = user_data;
@@ -464,21 +482,10 @@ static void internal_timeout_cb(struct l_timeout *timeout, void *user_data)
 static void test_notifications(const void *data)
 {
 	_auto_(test_cleanup) struct test_info *info = test_setup();
-	struct l_io *io;
-	uint32_t service_type;
-	struct qmi_service *service;
+	struct qmi_service *service = service_common_setup(info, false);
+	struct l_io *io = setup_io(info->service_fds[0], info);
 	struct l_timeout *receive_timeout;
 
-	perform_lookup(info);
-
-	service_type = unique_service_type(0); /* Use the first service */
-	service = qmi_qrtr_node_get_service(info->node, service_type);
-	assert(service);
-
-	io = l_io_new(info->service_fds[0]);
-	assert(io);
-	l_io_set_read_handler(io, received_data, info, NULL);
-
 	send_request_via_qmi(info, service);
 	send_response_to_client(info, io);
 
@@ -525,9 +532,7 @@ static void test_service_notification_independence(const void *data)
 
 	service_type = unique_service_type(0); /* Use the first service */
 
-	io = l_io_new(info->service_fds[0]);
-	assert(io);
-	l_io_set_read_handler(io, received_data, info, NULL);
+	io = setup_io(info->service_fds[0], info);
 
 	for (i = 0; i < L_ARRAY_SIZE(services); i++) {
 		services[i] = qmi_qrtr_node_get_service(info->node,
@@ -558,6 +563,19 @@ static void test_service_notification_independence(const void *data)
 	l_io_destroy(io);
 }
 
+static void test_dedicated(const void *data)
+{
+	_auto_(test_cleanup) struct test_info *info = test_setup();
+	struct qmi_service *service = service_common_setup(info, true);
+	struct l_io *io = setup_io(info->service_fds[0], info);
+
+	send_request_via_qmi(info, service);
+	send_response_to_client(info, io);
+
+	l_io_destroy(io);
+	qmi_service_free(service);
+}
+
 static void exit_if_qrtr_not_supported(void)
 {
 	int fd;
@@ -590,6 +608,7 @@ int main(int argc, char **argv)
 	l_test_add("QRTR notifications", test_notifications, NULL);
 	l_test_add("QRTR service notifications are independent",
 				test_service_notification_independence, NULL);
+	l_test_add("QRTR dedicated service", test_dedicated, NULL);
 	result = l_test_run();
 
 	__ofono_log_cleanup();
-- 
2.45.0

