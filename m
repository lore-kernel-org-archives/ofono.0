Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2E16DC3C
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740977; cv=none; b=frExu9Vjx+TYYGvNFr/noXyDYZ4L/rOdLlnT107+15jjphnp0C6R18txrXUG5EBSJHUUTuOkyLySUrCU/I2T1FV+bx+4ck9NAREhKgF7YDB1vXD6h010bH11DJBJK0EjNvKsHAR0uVaaFHgsYZdsrJGzD3poLY3wSMb2xlIasCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740977; c=relaxed/simple;
	bh=1ByNebelWl9f4YdnvJ3Bax8lqU/4oSH9sh6q4mjNkHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3lva6XObDwtE3XD6MHWHYyg3aepIrpOJOkhMQ8PsxgHg533UIcTeerAJNT0ICA6k6eVKrvQRLE9aK3QLV07drCgLadOxHKuz1hD6PXdBNaZBBF71MHrn9czgHJ5cHjgX3g5VvFk1D1eY4xNfb8Q6HsSH2lUtQ5YZlxYP8zrpbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F78wceID; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F78wceID"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-254871388d3so3048294fac.1
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740975; x=1719345775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udO/L9DMI2zI7TIPMBxhylWJvX/iPlh3ntGUU1b17lg=;
        b=F78wceIDs2aXJ218EVo58Di8XgM3uE7VkT/6qcL1RVhGIUwXHnERaFbC7RopZq+VxD
         gWSfWIwXRlXSaB+QZnm+tQtj7YoDdzkdj7MOoGS4SrrgTgEIPqIioka3KNZasX78Lv7s
         VIec5iGJ971zb9QjSmvAQDjB6A2stMAouGPz2B+HX57/P0rO74h6U90Tjjcw1124JB0o
         X93D+wl4GACBZhrCBc5Fgv9QnIsjf+wQaw5WZYxavLqGrglOdkUAQvx6ISynUENOoJ0v
         WPuPYfVUspvKp9/W7ExUh1CYzG+2rCMwFICMijn5IwEpgyy6tHKgQbPY3h+owRehG4Ll
         9AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740975; x=1719345775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udO/L9DMI2zI7TIPMBxhylWJvX/iPlh3ntGUU1b17lg=;
        b=FCSyUop3DxeBCpekrpD8ocbYfNfvVYbIzZTuLpOy1yUdCKXRaKmhb1gwwNtElBs+yo
         k2QSzbBm+k1OjOATRtPUK9jGPYQjQG8S6ASIE0lsfhYmwYVGNutQ0njEFlPoLhOCg0D+
         9vS8+CDQGEDt2VrvLVYJtIsw2r1YzfxIML4hPEb7JJML6cB5eN9uCCOauvotGatPRyPr
         Q6z3hPpZWkXhIcVuv+SuNcUnkEzcvwbQNlVapY7Mzb8h6/B/mugwi03fz0qoNXVljBv4
         NGqSd2muo1A3LcWnEc+yZZ6cHZmehLrASHZRzXluYgJTPunqofqw1lQV767oHVGiVDVl
         5NDw==
X-Gm-Message-State: AOJu0YwNkSLnukndW8c/G8oueaQgfuH63NRHRp+zb0GFTfoRc8J8BI7K
	End8ws2weZFHTfuACefJjNYLQeNriPoeTTnyD17ucDK4vg8gAKxK82kgTA==
X-Google-Smtp-Source: AGHT+IGtPlSJU/LK/nm8fX4nvY810gTbphDDwDdKf9xS6jsiLJwRpFpiozvppg99d+2ZjZ8hm/87EA==
X-Received: by 2002:a05:6870:d60a:b0:258:38d5:6518 with SMTP id 586e51a60fabf-25c948e3e2amr926036fac.4.1718740974509;
        Tue, 18 Jun 2024 13:02:54 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:54 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 27/33] qmi: Rename qmi_device_qmux to qmi_qmux_device
Date: Tue, 18 Jun 2024 15:02:09 -0500
Message-ID: <20240618200231.1129282-27-denkenz@gmail.com>
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
 drivers/qmimodem/qmi.c | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2844ea9f06f6..0d67b07fa729 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -88,7 +88,7 @@ struct qmi_device {
 	bool writer_active : 1;
 };
 
-struct qmi_device_qmux {
+struct qmi_qmux_device {
 	struct qmi_device super;
 	uint16_t control_major;
 	uint16_t control_minor;
@@ -984,11 +984,11 @@ bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type)
 	return __find_service_info_by_type(device, type);
 }
 
-static int qmi_device_qmux_write(struct qmi_device *device,
+static int qmi_qmux_device_write(struct qmi_device *device,
 					struct qmi_request *req)
 {
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
+	struct qmi_qmux_device *qmux =
+		l_container_of(device, struct qmi_qmux_device, super);
 	struct qmi_mux_hdr *hdr;
 	ssize_t bytes_written;
 
@@ -1012,7 +1012,7 @@ static int qmi_device_qmux_write(struct qmi_device *device,
 	return 0;
 }
 
-static void __rx_ctl_message(struct qmi_device_qmux *qmux,
+static void __rx_ctl_message(struct qmi_qmux_device *qmux,
 				uint8_t service_type, uint8_t client_id,
 				const void *buf)
 {
@@ -1049,7 +1049,7 @@ static void __rx_ctl_message(struct qmi_device_qmux *qmux,
 
 static bool received_qmux_data(struct l_io *io, void *user_data)
 {
-	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_qmux_device *qmux = user_data;
 	struct qmi_mux_hdr *hdr;
 	unsigned char buf[2048];
 	ssize_t bytes_read;
@@ -1138,7 +1138,7 @@ done:
 	l_free(family);
 }
 
-static uint8_t __ctl_request_submit(struct qmi_device_qmux *qmux,
+static uint8_t __ctl_request_submit(struct qmi_qmux_device *qmux,
 					struct qmi_request *req)
 {
 	struct qmi_control_hdr *hdr =
@@ -1193,7 +1193,7 @@ static struct qmi_service *service_create(struct service_family *family)
 	return service;
 }
 
-static struct qmi_request *find_control_request(struct qmi_device_qmux *qmux,
+static struct qmi_request *find_control_request(struct qmi_qmux_device *qmux,
 						uint16_t tid)
 {
 	struct qmi_request *req;
@@ -1211,7 +1211,7 @@ static struct qmi_request *find_control_request(struct qmi_device_qmux *qmux,
 	return req;
 }
 
-static void __qmux_discovery_finished(struct qmi_device_qmux *qmux)
+static void __qmux_discovery_finished(struct qmi_qmux_device *qmux)
 {
 	l_timeout_remove(qmux->discover.timeout);
 	qmux->discover.func(qmux->discover.user_data);
@@ -1225,7 +1225,7 @@ static void __qmux_discovery_finished(struct qmi_device_qmux *qmux)
 static void qmux_sync_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
-	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_qmux_device *qmux = user_data;
 
 	__qmux_discovery_finished(qmux);
 }
@@ -1233,7 +1233,7 @@ static void qmux_sync_callback(uint16_t message, uint16_t length,
 static void qmux_discover_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
-	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_qmux_device *qmux = user_data;
 	struct qmi_device *device = &qmux->super;
 	const struct qmi_result_code *result_code;
 	const struct qmi_service_list *service_list;
@@ -1316,8 +1316,8 @@ static void qmux_discover_reply_timeout(struct l_timeout *timeout,
 							void *user_data)
 {
 	struct qmi_device *device = user_data;
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
+	struct qmi_qmux_device *qmux =
+		l_container_of(device, struct qmi_qmux_device, super);
 	struct qmi_request *req;
 
 	/* remove request from queues */
@@ -1332,13 +1332,13 @@ int qmi_qmux_device_discover(struct qmi_device *device,
 				qmi_qmux_device_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
-	struct qmi_device_qmux *qmux;
+	struct qmi_qmux_device *qmux;
 	struct qmi_request *req;
 
 	if (!device)
 		return -EINVAL;
 
-	qmux = l_container_of(device, struct qmi_device_qmux, super);
+	qmux = l_container_of(device, struct qmi_qmux_device, super);
 
 	DEBUG(&qmux->debug, "device %p", qmux);
 
@@ -1390,8 +1390,8 @@ static void qmux_client_create_timeout(struct l_timeout *timeout,
 {
 	struct qmux_client_create_data *data = user_data;
 	struct qmi_device *device = data->device;
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
+	struct qmi_qmux_device *qmux =
+		l_container_of(device, struct qmi_qmux_device, super);
 	struct qmi_request *req;
 
 	DEBUG(&qmux->debug, "");
@@ -1412,8 +1412,8 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 {
 	struct qmux_client_create_data *data = user_data;
 	struct qmi_device *device = data->device;
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
+	struct qmi_qmux_device *qmux =
+		l_container_of(device, struct qmi_qmux_device, super);
 	struct service_family *family = NULL;
 	struct qmi_service *service = NULL;
 	struct qmi_service_info info;
@@ -1470,7 +1470,7 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 {
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
 	const struct qmi_service_info *info;
-	struct qmi_device_qmux *qmux;
+	struct qmi_qmux_device *qmux;
 	struct qmi_request *req;
 	struct qmux_client_create_data *create_data;
 
@@ -1484,7 +1484,7 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 	if (!info)
 		return false;
 
-	qmux = l_container_of(device, struct qmi_device_qmux, super);
+	qmux = l_container_of(device, struct qmi_qmux_device, super);
 
 	create_data = l_new(struct qmux_client_create_data, 1);
 	create_data->super.destroy = qmux_client_create_data_free;
@@ -1514,17 +1514,17 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 static void qmux_client_release_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
-	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_qmux_device *qmux = user_data;
 
 	qmux->shutdown.release_users--;
 }
 
-static void qmi_device_qmux_client_release(struct qmi_device *device,
+static void qmi_qmux_device_client_release(struct qmi_device *device,
 						uint16_t service_type,
 						uint16_t client_id)
 {
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
+	struct qmi_qmux_device *qmux =
+		l_container_of(device, struct qmi_qmux_device, super);
 	uint8_t release_req[] = { 0x01, 0x02, 0x00, service_type, client_id };
 	struct qmi_request *req;
 
@@ -1537,7 +1537,7 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 	__ctl_request_submit(qmux, req);
 }
 
-static void __qmux_device_free(struct qmi_device_qmux *qmux)
+static void __qmux_device_free(struct qmi_qmux_device *qmux)
 {
 	l_queue_destroy(qmux->control_queue, __request_free);
 
@@ -1555,7 +1555,7 @@ static void __qmux_device_free(struct qmi_device_qmux *qmux)
 
 static void qmux_shutdown_destroy(void *user_data)
 {
-	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_qmux_device *qmux = user_data;
 
 	if (qmux->shutdown.destroy)
 		qmux->shutdown.destroy(qmux->shutdown.user_data);
@@ -1568,7 +1568,7 @@ static void qmux_shutdown_destroy(void *user_data)
 
 static void qmux_shutdown_callback(struct l_idle *idle, void *user_data)
 {
-	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_qmux_device *qmux = user_data;
 
 	if (qmux->shutdown.release_users > 0)
 		return;
@@ -1588,12 +1588,12 @@ int qmi_qmux_device_shutdown(struct qmi_device *device,
 					void *user_data,
 					qmi_destroy_func_t destroy)
 {
-	struct qmi_device_qmux *qmux;
+	struct qmi_qmux_device *qmux;
 
 	if (!device)
 		return -EINVAL;
 
-	qmux = l_container_of(device, struct qmi_device_qmux, super);
+	qmux = l_container_of(device, struct qmi_qmux_device, super);
 
 	if (qmux->shutdown.idle)
 		return -EALREADY;
@@ -1614,20 +1614,20 @@ int qmi_qmux_device_shutdown(struct qmi_device *device,
 }
 
 static const struct qmi_device_ops qmux_ops = {
-	.write = qmi_device_qmux_write,
-	.client_release = qmi_device_qmux_client_release,
+	.write = qmi_qmux_device_write,
+	.client_release = qmi_qmux_device_client_release,
 };
 
 struct qmi_device *qmi_qmux_device_new(const char *device)
 {
-	struct qmi_device_qmux *qmux;
+	struct qmi_qmux_device *qmux;
 	int fd;
 
 	fd = open(device, O_RDWR | O_NONBLOCK | O_CLOEXEC);
 	if (fd < 0)
 		return NULL;
 
-	qmux = l_new(struct qmi_device_qmux, 1);
+	qmux = l_new(struct qmi_qmux_device, 1);
 
 	if (qmi_device_init(&qmux->super, fd, &qmux_ops) < 0) {
 		close(fd);
@@ -1644,12 +1644,12 @@ struct qmi_device *qmi_qmux_device_new(const char *device)
 
 void qmi_qmux_device_free(struct qmi_device *device)
 {
-	struct qmi_device_qmux *qmux;
+	struct qmi_qmux_device *qmux;
 
 	if (!device)
 		return;
 
-	qmux = l_container_of(device, struct qmi_device_qmux, super);
+	qmux = l_container_of(device, struct qmi_qmux_device, super);
 	DEBUG(&qmux->debug, "device %p", qmux);
 	__qmi_device_free(device);
 
@@ -1664,12 +1664,12 @@ void qmi_qmux_device_free(struct qmi_device *device)
 void qmi_qmux_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data)
 {
-	struct qmi_device_qmux *qmux;
+	struct qmi_qmux_device *qmux;
 
 	if (device == NULL)
 		return;
 
-	qmux = l_container_of(device, struct qmi_device_qmux, super);
+	qmux = l_container_of(device, struct qmi_qmux_device, super);
 	__debug_data_init(&qmux->debug, func, user_data);
 }
 
-- 
2.45.0

