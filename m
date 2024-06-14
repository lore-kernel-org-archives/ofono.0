Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8271A2FA8
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391204; cv=none; b=poxqeQKDEY6qo+jkinA6MLwiYRSBvAmCUq1vmet+cdX+pUitW0sYnqDG/bQpBxaZ7QTRi8LZNVJDJTqG/y7CemKmZSJAOFIX8GA1mwkgFpRyEY4K/R/thOn6kB6YZXy6AioI92rZVhkSGUOecBcfdcK3UpH7FLtm3A3BnxDRWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391204; c=relaxed/simple;
	bh=A3D5OFMMiBYDVA3hZ56PFrmbe/IGABLTe5qQ1xW9Nxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDCuM9BbV/DA+N3T6Jp1xqtAT7Gp5SJ7qRDLzVWJn/MlMIBnlHI47rc1XJftJHNXLN8l0qHGH0+JKZI/SUDXHE2vwCbN2yFwT1LXfuc3aMkjWRz2gXIp99G2IpqD55ZArU8bPOP/bg3GGGxXGktkTGCnEaLb5RNERs7Tfv1zwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpgdXeJl; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpgdXeJl"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d227b1f4f0so1292248b6e.3
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391202; x=1718996002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1FdxVo1nAkLjNNBMKJmVUFiBBHGx93b6MmsA6SserQ=;
        b=KpgdXeJldAwkxJ7EAtuq98tOrR5ZF3o+dClKVMb0J83alqcXlVcJgNwT7xlEjHntCE
         YDJ2Qzf0q6s+Uh82A7Gmz2Ymt4Drxus19Eyah6uQG6v35i44yoDCGlPp3jhb9AjtJXlc
         MwK+QgsQmRyaKKgYbs7YD0Qe5Ktp5Y6UkTfXMv6Yqr6U0FJoA+qtu0erJbQ/M/kA8+Qk
         6Zv4V5ufpmxUJORBmV2WBpQLUYN1vZvxXtsoUfK/1sCjTmxxJ5CFROaRSROcbUS7LKJs
         tLAkxVjQx/bSLxgN9pwR2f6W4FFvo61SuzsG+eycGt2ETXgxbD36SI+SpujoGSduOYyv
         iKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391202; x=1718996002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1FdxVo1nAkLjNNBMKJmVUFiBBHGx93b6MmsA6SserQ=;
        b=rtVXofDUMrz067fPbH+ozHtXcK8Qi9R6gBcEYYqL3v9/JI8lkx26u7/hAVlWv+GvH4
         rJVKvub7dkDS+Hlx8LBG+jv8g5mRFfOOQY4OSRU4b6ddqNuem8uAcL/ZVD6sw68eSnEA
         FsQr+1AX8XqtlMVI0JpNCTfYYIpm5DpiWKXT6lyw56LicdpX76h0Al/CmlkBZhGmT64p
         uLZBCb8oKLPE6aeccCRoyPBJL8oFk0syX6rodQVOj3pPW39Tif3miAFQVoqyXSm6EikV
         tkJX2eISULo9r4qa67od4sL/vCo7RH6udVSGDDLo55eZAls6ixcO5kIJdbp4EacMkpwR
         hLYg==
X-Gm-Message-State: AOJu0YytiBVwcURSAiyQZtO2paYgkyJGStuM1K7XNPnUwapP4jP9BNOo
	T2KbYiagXEVBxQ032/fQWsh2MzNU8UjbaZXrliVVDAmKQk89V/TNZ2Wl6g==
X-Google-Smtp-Source: AGHT+IHD9fgYrX9J4OWq/f0eIUAOzzpiL0VpTiL6oC9G3qHX2NZR0JMb2mJq2aFM3J3hgvFbjaC/rQ==
X-Received: by 2002:a05:6870:1696:b0:254:783d:aeb4 with SMTP id 586e51a60fabf-25842a20260mr3566593fac.35.1718391201973;
        Fri, 14 Jun 2024 11:53:21 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:21 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 26/27] qmi: Rename qmi_device_qmux to qmi_qmux_device
Date: Fri, 14 Jun 2024 13:52:38 -0500
Message-ID: <20240614185300.1086701-26-denkenz@gmail.com>
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
 drivers/qmimodem/qmi.c | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index d9b888380456..2c2be04c1593 100644
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
@@ -1226,7 +1226,7 @@ static void __qmux_discovery_finished(struct qmi_device_qmux *qmux)
 static void qmux_sync_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
-	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_qmux_device *qmux = user_data;
 
 	__qmux_discovery_finished(qmux);
 }
@@ -1234,7 +1234,7 @@ static void qmux_sync_callback(uint16_t message, uint16_t length,
 static void qmux_discover_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
-	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_qmux_device *qmux = user_data;
 	struct qmi_device *device = &qmux->super;
 	const struct qmi_result_code *result_code;
 	const struct qmi_service_list *service_list;
@@ -1317,8 +1317,8 @@ static void qmux_discover_reply_timeout(struct l_timeout *timeout,
 							void *user_data)
 {
 	struct qmi_device *device = user_data;
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
+	struct qmi_qmux_device *qmux =
+		l_container_of(device, struct qmi_qmux_device, super);
 	struct qmi_request *req;
 
 	/* remove request from queues */
@@ -1333,13 +1333,13 @@ int qmi_qmux_device_discover(struct qmi_device *device,
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
 
@@ -1391,8 +1391,8 @@ static void qmux_client_create_timeout(struct l_timeout *timeout,
 {
 	struct qmux_client_create_data *data = user_data;
 	struct qmi_device *device = data->device;
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
+	struct qmi_qmux_device *qmux =
+		l_container_of(device, struct qmi_qmux_device, super);
 	struct qmi_request *req;
 
 	DEBUG(&qmux->debug, "");
@@ -1413,8 +1413,8 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
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
@@ -1471,7 +1471,7 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 {
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
 	const struct qmi_service_info *info;
-	struct qmi_device_qmux *qmux;
+	struct qmi_qmux_device *qmux;
 	struct qmi_request *req;
 	struct qmux_client_create_data *create_data;
 
@@ -1485,7 +1485,7 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 	if (!info)
 		return false;
 
-	qmux = l_container_of(device, struct qmi_device_qmux, super);
+	qmux = l_container_of(device, struct qmi_qmux_device, super);
 
 	create_data = l_new(struct qmux_client_create_data, 1);
 	create_data->super.destroy = qmux_client_create_data_free;
@@ -1515,17 +1515,17 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
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
 
@@ -1538,7 +1538,7 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 	__ctl_request_submit(qmux, req);
 }
 
-static void __qmux_device_free(struct qmi_device_qmux *qmux)
+static void __qmux_device_free(struct qmi_qmux_device *qmux)
 {
 	l_queue_destroy(qmux->control_queue, __request_free);
 
@@ -1554,7 +1554,7 @@ static void __qmux_device_free(struct qmi_device_qmux *qmux)
 
 static void qmux_shutdown_destroy(void *user_data)
 {
-	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_qmux_device *qmux = user_data;
 
 	if (qmux->shutdown.destroy)
 		qmux->shutdown.destroy(qmux->shutdown.user_data);
@@ -1567,7 +1567,7 @@ static void qmux_shutdown_destroy(void *user_data)
 
 static void qmux_shutdown_callback(struct l_idle *idle, void *user_data)
 {
-	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_qmux_device *qmux = user_data;
 
 	if (qmux->shutdown.release_users > 0)
 		return;
@@ -1587,12 +1587,12 @@ int qmi_qmux_device_shutdown(struct qmi_device *device,
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
@@ -1613,20 +1613,20 @@ int qmi_qmux_device_shutdown(struct qmi_device *device,
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
@@ -1643,12 +1643,12 @@ struct qmi_device *qmi_qmux_device_new(const char *device)
 
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
 
@@ -1663,12 +1663,12 @@ void qmi_qmux_device_free(struct qmi_device *device)
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

