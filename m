Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D61AE863
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895137; cv=none; b=evQpbRhqaOjxq9y3k4VxnOhUvbpx28RHhLdlIM3BE8f3TyvZFBEo17jN5XMFXJOIVGt/jZcaklqMb/bbeYt+wvpyz8lGwiAS0qwIQCgswlvVM3o+HqXz+VAnr4MkvbwdSUMdSZkQQf3StpE4ov3oPhxuB/ZPuIoJT4MBJROaxuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895137; c=relaxed/simple;
	bh=1ByNebelWl9f4YdnvJ3Bax8lqU/4oSH9sh6q4mjNkHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNSmktwbXjV7HyO4J0Ez8QYjsG9WU2AuPQlBxXSraNrvvOoNRYjUo3wI9Sf31fd57vL4xnEoz0wtXS2w+FHjQ34q1Sj+j9Js3v9ExxUHf8r8G33/IxS/joA0gd129CDxUgeitTxQC6oCRRvI2aQThlkmOz4pHdCFGhANenA+PTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTIPMGJj; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTIPMGJj"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d518cdb252so453356b6e.1
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895135; x=1719499935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udO/L9DMI2zI7TIPMBxhylWJvX/iPlh3ntGUU1b17lg=;
        b=dTIPMGJjjTNuGZGw2ejLhxK8t8+T2qhqze0eKyQzwFvwaZznfjsG1ju2gmYwJmRLA/
         48MPdl9fo4HdxGfb9EXAQZWlf6PVJ8oeo24WfxLYPFQl8wHcI69KPe9hb/RSvx8jnfIb
         83qDZhIN9IyggTm6PkFLAfu7NmS7lHOIcXkSs/o6UgjTJ0C+L/LDNWvoFppmD4/gTOq7
         GOQRnjFC5P6JSJymq41I1ivnrqMWWq+tJAzbA6VhvF/nTNnqB30xXvrWZyyTW3i8JnKs
         iLICAtg6SIFIAvHOXWGWjbgkjVdaZcCxgzzm6LjN2Jqd1o7G8YBexh2XRes2g40BHUwe
         5o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895135; x=1719499935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udO/L9DMI2zI7TIPMBxhylWJvX/iPlh3ntGUU1b17lg=;
        b=GqnLESI6W5uhXYoo0lQBcfbhZhu2wKbvIi4+4n7RZqkQUpDVcKwKcO9c5q1furUvi3
         4eKxR0SG24/3GszzwBJ2fLDdLKxUYkHXoYL2u7uNDb93rwHT2q9BaZvY3LBhrh7rvQiS
         n8teVqR7mFb3tFfJ+ctRjlBDPDpsbzcdp2HT5RC5mbfyAGr/6txgMvYWCqtMRDVTNM5N
         YNrV1R7XLPoLUgAmW8nbHLrGA5G+9TyQWtlUYaKKV04LIyrxZ4wjaLF/anVX367h28ih
         eNUpWhWuHFkdjHIICbq/5fYz4atfZpj9q8hQIA5N5Mj6McMbykDVi8pZoedFC9hIDtHQ
         bggA==
X-Gm-Message-State: AOJu0YwZqVIgj3HxnTLiKgQ4Urw0jI3xMO2TuGbtLrumg/TvEavmbGVg
	uBuqMQw5EddtJ4XKqB36UkF4qyE2dUb3w8vXNc3MgBBdenw1ByFljBsbFw==
X-Google-Smtp-Source: AGHT+IGzBaA7wjSFWQKTwTUY35e8tD/5tPScZcot7l8us2TtuSeU55Rm09mmIK4vmlC9qiVfPOPdEA==
X-Received: by 2002:a05:6808:6542:b0:3d5:108a:5af3 with SMTP id 5614622812f47-3d51badd77dmr5516917b6e.56.1718895135133;
        Thu, 20 Jun 2024 07:52:15 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:14 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 27/33] qmi: Rename qmi_device_qmux to qmi_qmux_device
Date: Thu, 20 Jun 2024 09:51:14 -0500
Message-ID: <20240620145139.1135899-27-denkenz@gmail.com>
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

