Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF81AE85F
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895139; cv=none; b=Xvu2dF6Ax/hgUlyihuXOCdXzrg3k+jUqaq2NLRZtWlKIQnsY+8th5mLBz3StLDv+RAZPd/7l8QlOgNSRjnx8RwOvM7I020bfpHT6dI9VZJ1Ti95ogV5CK2YXIYVmVbXb8g8towOwuvmNLpPcSR+ynSNA15UpMBBqDLP+DyzdNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895139; c=relaxed/simple;
	bh=U+peojbnu1k6q75LXI5k3vZfdNuC+ooo2jo7B+/NZ08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUDEiyO7pWBJU4oAvjYjCqDWz+KKvF5PRNjs2YTTrN4JDnno7LUJoSjj6bkhLdYIQNyxj6RnuHsue8dFw6Mp75jKEx+15uPqfg6ubCBuXofLldkErUqEOUY5CA7AhKsWcCUoqK7GPll5pM3+7mYRsA4tnHwpNSwX1ErzDNEaOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIDCQEGu; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIDCQEGu"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9cc681ee7so405049b6e.1
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895137; x=1719499937; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VNQjO4dvYVwxmdLCHVnJaHkQJpsvDJRxhitap70k/I=;
        b=VIDCQEGuDafpidBF1ZCVMK2J2jpUGX+WPlVo/wQHzWsKJzzwmSTnJmAG+AJ3udaHmZ
         ucqxpQJ96kG9/FIKlWghnZBf9SUFqXKLIegtmGqabPYgPy8dKrpmBnIgFn6duNvm7qJr
         QEL5SKGZfL80QBLybu/3+7JlUwNuzpWbnWbbiGl9mglXT5hZcbFtSH8j+Tu7CEVkuTEI
         0tI3bgbXkchOltjq15kckkrNL9q4QMLBf9ym0RGDsC5yoJnUvO9tCVBcL9vsve+/1zGf
         /ABbm1IUX+czpnvawtHj5Sw1um7EVJ8U4PL9xRW0OA4FIhbQO+YtXciFzzF9v1wh7Jma
         uClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895137; x=1719499937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VNQjO4dvYVwxmdLCHVnJaHkQJpsvDJRxhitap70k/I=;
        b=qyneYeoH/Z4blD2ld8V034bA/W3MbdeLbxidwd/KSbdE+BOy7wWNU9oz0XF4Y0R5vn
         08kb/k3mYvklvRtPrEBWQKDhe5SVZR+r5IfoOb8RgD1+O0cMFQ4IFxf0isqqZVGvNjId
         MKjuNX30LwHBnUZbKcyvYkDeA7JkGQV6pZMqaVGsvmLXwcxgTtqP7hFjoE9MLr1rztLE
         ElSWvrB1a63/sh1pH5v/fkFsY7oBiURbSPsHlHO8qP0vQ6l6Ucb95ryUdMTBFdOUXioT
         +fydkZUQsfEvHY2zHlXFcuKOLiZsfOTcX6uXxaH7jZc4dbWcqE6PgI01meEI9lSxMVdb
         Tmqg==
X-Gm-Message-State: AOJu0YyXxG3+aGBahl5+p3J1SyMCr5A4KJRvzGqfJxqQNMjOx/+zpjLd
	LYbr8d4JsV6wp5PnOe+BRmwlfNCeyYfIDixyn4AFDgrZVBxegeorxA6YQA==
X-Google-Smtp-Source: AGHT+IEpLdQSCb5tYdfRgijgSzapMEArbDXVkuseH+GIUEex9YlX3oUr89OXHKHc0t2ka6osLOUkgA==
X-Received: by 2002:a05:6808:23ca:b0:3d2:220c:6ebd with SMTP id 5614622812f47-3d51b5e70bfmr2646338b6e.11.1718895136671;
        Thu, 20 Jun 2024 07:52:16 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:16 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 29/33] qmi: combine service_send_data into qmi_request
Date: Thu, 20 Jun 2024 09:51:16 -0500
Message-ID: <20240620145139.1135899-29-denkenz@gmail.com>
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

Instead of allocating a separate service_send_data structure for each
request, simply extend the qmi_request structure with the needed
parameters.  This saves an extra memory allocation since
service_send_data lifetime was already tied to the qmi_request
lifetime.  While here, remove __service_request_alloc function.  This
helper was used in a single location and is unlikely to be used
elsewhere.
---
 drivers/qmimodem/qmi.c | 194 +++++++++++++++++++----------------------
 1 file changed, 92 insertions(+), 102 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 6e66060b1d3c..3742e8fc4b73 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -10,6 +10,7 @@
 #endif
 
 #define _GNU_SOURCE
+#include <stddef.h>
 #include <stdio.h>
 #include <ctype.h>
 #include <dirent.h>
@@ -35,10 +36,11 @@
 	l_util_debug((debug)->func, (debug)->user_data, "%s:%i " fmt,	\
 			__func__, __LINE__, ## args)
 
-typedef void (*qmi_message_func_t)(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data);
-
 struct qmi_device;
+struct qmi_request;
+
+typedef void (*response_func_t)(struct qmi_request *, uint16_t message,
+				uint16_t length, const void *buffer);
 
 struct discovery {
 	qmi_destroy_func_t destroy;
@@ -59,12 +61,20 @@ struct qmi_request {
 	unsigned int service_handle;	/* Always 0 for control */
 	uint8_t client;			/* Always 0 for control and qrtr */
 	struct qmi_service_info info;	/* Not used for control requests */
-	qmi_message_func_t callback;
 	void *user_data;
+	response_func_t callback;
+	void (*free_request)(struct qmi_request *req);
 	uint16_t len;
 	uint8_t data[];
 };
 
+struct qmi_service_request {
+	qmi_service_result_func_t func;
+	void *user_data;
+	qmi_destroy_func_t destroy;
+	struct qmi_request super;
+};
+
 struct qmi_device_ops {
 	int (*write)(struct qmi_device *device, struct qmi_request *req);
 	void (*client_release)(struct qmi_device *device,
@@ -215,12 +225,12 @@ static void __qmi_service_appeared(struct qmi_device *device,
 				l_memdup(info, sizeof(struct qmi_service_info)));
 }
 
-static struct qmi_request *__request_alloc(uint32_t service_type,
-				uint8_t client, uint16_t message,
-				const void *data,
-				uint16_t length, qmi_message_func_t func,
-				void *user_data)
+static void *__request_alloc(uint32_t service_type,
+					uint8_t client, uint16_t message,
+					const void *data, uint16_t length,
+					size_t offset)
 {
+	void *mem;
 	struct qmi_request *req;
 	struct qmi_mux_hdr *hdr;
 	struct qmi_message_hdr *msg;
@@ -233,10 +243,9 @@ static struct qmi_request *__request_alloc(uint32_t service_type,
 		hdrlen += QMI_SERVICE_HDR_SIZE;
 
 	msglen = hdrlen + QMI_MESSAGE_HDR_SIZE + length;
-	req = l_malloc(sizeof(struct qmi_request) + msglen);
-	req->tid = 0;
-	req->group_id = 0;
-	req->service_handle = 0;
+	mem = l_malloc(offset + sizeof(struct qmi_request) + msglen);
+	req = mem + offset;
+	memset(req, 0, sizeof(struct qmi_request));
 	req->len = msglen;
 	req->client = client;
 
@@ -256,40 +265,24 @@ static struct qmi_request *__request_alloc(uint32_t service_type,
 	if (data && length > 0)
 		memcpy(req->data + hdrlen + QMI_MESSAGE_HDR_SIZE, data, length);
 
-	req->callback = func;
-	req->user_data = user_data;
-
-	return req;
+	return mem;
 }
 
 static struct qmi_request *__control_request_alloc(uint16_t message,
-				const void *data, uint16_t length,
-				qmi_message_func_t func, void *user_data)
+					const void *data, uint16_t length)
 {
 	return __request_alloc(QMI_SERVICE_CONTROL, 0x00, message,
-					data, length, func, user_data);
-}
-
-static struct qmi_request *__service_request_alloc(
-				struct qmi_service_info *info,
-				uint8_t client, uint16_t message,
-				const void *data, uint16_t length,
-				qmi_message_func_t func, void *user_data)
-{
-	struct qmi_request *req;
-
-	req = __request_alloc(info->service_type, client, message,
-						data, length, func, user_data);
-	memcpy(&req->info, info, sizeof(req->info));
-
-	return req;
+					data, length, 0);
 }
 
 static void __request_free(void *data)
 {
 	struct qmi_request *req = data;
 
-	l_free(req);
+	if (req->free_request)
+		req->free_request(req);
+	else
+		l_free(req);
 }
 
 static bool __request_compare(const void *a, const void *b)
@@ -817,7 +810,7 @@ static void __rx_message(struct qmi_device *device,
 		return;
 
 	if (req->callback)
-		req->callback(message, length, data, req->user_data);
+		req->callback(req, message, length, data);
 
 	__request_free(req);
 }
@@ -1047,7 +1040,7 @@ static void __rx_ctl_message(struct qmi_qmux_device *qmux,
 		return;
 
 	if (req->callback)
-		req->callback(message, length, data, req->user_data);
+		req->callback(req, message, length, data);
 
 	__request_free(req);
 }
@@ -1144,7 +1137,8 @@ done:
 }
 
 static uint8_t __ctl_request_submit(struct qmi_qmux_device *qmux,
-					struct qmi_request *req)
+					struct qmi_request *req,
+					response_func_t callback)
 {
 	struct qmi_control_hdr *hdr =
 		(struct qmi_control_hdr *) &req->data[QMI_MUX_HDR_SIZE];
@@ -1156,6 +1150,7 @@ static uint8_t __ctl_request_submit(struct qmi_qmux_device *qmux,
 		qmux->next_control_tid = 1;
 
 	req->tid = hdr->transaction;
+	req->callback = callback;
 
 	l_queue_push_tail(qmux->super.req_queue, req);
 	wakeup_writer(&qmux->super);
@@ -1227,18 +1222,18 @@ static void __qmux_discovery_finished(struct qmi_qmux_device *qmux)
 	memset(&qmux->discover, 0, sizeof(qmux->discover));
 }
 
-static void qmux_sync_callback(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data)
+static void qmux_sync_callback(struct qmi_request *req, uint16_t message,
+					uint16_t length, const void *buffer)
 {
-	struct qmi_qmux_device *qmux = user_data;
+	struct qmi_qmux_device *qmux = req->user_data;
 
 	__qmux_discovery_finished(qmux);
 }
 
-static void qmux_discover_callback(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data)
+static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
+					uint16_t length, const void *buffer)
 {
-	struct qmi_qmux_device *qmux = user_data;
+	struct qmi_qmux_device *qmux = req->user_data;
 	struct qmi_device *device = &qmux->super;
 	const struct qmi_result_code *result_code;
 	const struct qmi_service_list *service_list;
@@ -1306,11 +1301,14 @@ done:
 	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
 			qmux->control_major > 1) {
 		struct qmi_request *req =
-			__control_request_alloc(QMI_CTL_SYNC, NULL, 0,
-						qmux_sync_callback, qmux);
+			__control_request_alloc(QMI_CTL_SYNC, NULL, 0);
+
+		req->user_data = qmux;
 
 		DEBUG(&qmux->debug, "Sending sync to reset QMI");
-		qmux->discover.tid = __ctl_request_submit(qmux, req);
+		qmux->discover.tid = __ctl_request_submit(qmux, req,
+							qmux_sync_callback);
+
 		return;
 	}
 
@@ -1347,13 +1345,14 @@ int qmi_qmux_device_discover(struct qmi_qmux_device *qmux,
 	if (l_queue_length(qmux->super.service_infos) > 0 || qmux->discover.tid)
 		return -EALREADY;
 
-	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0,
-						qmux_discover_callback, qmux);
+	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0);
+	req->user_data = qmux;
 
 	qmux->discover.func = func;
 	qmux->discover.user_data = user_data;
 	qmux->discover.destroy = destroy;
-	qmux->discover.tid = __ctl_request_submit(qmux, req);
+	qmux->discover.tid = __ctl_request_submit(qmux, req,
+							qmux_discover_callback);
 	qmux->discover.timeout =
 		l_timeout_create(DISCOVER_TIMEOUT, qmux_discover_reply_timeout,
 						qmux, NULL);
@@ -1409,10 +1408,11 @@ static void qmux_client_create_timeout(struct l_timeout *timeout,
 	DISCOVERY_DONE(data, NULL, data->user_data);
 }
 
-static void qmux_client_create_callback(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data)
+static void qmux_client_create_callback(struct qmi_request *req,
+					uint16_t message, uint16_t length,
+					const void *buffer)
 {
-	struct qmux_client_create_data *data = user_data;
+	struct qmux_client_create_data *data = req->user_data;
 	struct qmi_device *device = data->device;
 	struct qmi_qmux_device *qmux =
 		l_container_of(device, struct qmi_qmux_device, super);
@@ -1499,11 +1499,11 @@ bool qmi_qmux_device_create_client(struct qmi_qmux_device *qmux,
 	DEBUG(&qmux->debug, "creating client [type=%d]", service_type);
 
 	req = __control_request_alloc(QMI_CTL_GET_CLIENT_ID,
-					client_req, sizeof(client_req),
-					qmux_client_create_callback,
-					create_data);
+					client_req, sizeof(client_req));
+	req->user_data = create_data;
 
-	create_data->tid = __ctl_request_submit(qmux, req);
+	create_data->tid = __ctl_request_submit(qmux, req,
+						qmux_client_create_callback);
 	create_data->timeout = l_timeout_create(8, qmux_client_create_timeout,
 							create_data, NULL);
 
@@ -1511,10 +1511,11 @@ bool qmi_qmux_device_create_client(struct qmi_qmux_device *qmux,
 	return true;
 }
 
-static void qmux_client_release_callback(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data)
+static void qmux_client_release_callback(struct qmi_request *req,
+					uint16_t message, uint16_t length,
+					const void *buffer)
 {
-	struct qmi_qmux_device *qmux = user_data;
+	struct qmi_qmux_device *qmux = req->user_data;
 
 	qmux->shutdown.release_users--;
 }
@@ -1531,10 +1532,10 @@ static void qmi_qmux_device_client_release(struct qmi_device *device,
 	qmux->shutdown.release_users++;
 
 	req = __control_request_alloc(QMI_CTL_RELEASE_CLIENT_ID,
-					release_req, sizeof(release_req),
-					qmux_client_release_callback, qmux);
+					release_req, sizeof(release_req));
+	req->user_data = qmux;
 
-	__ctl_request_submit(qmux, req);
+	__ctl_request_submit(qmux, req, qmux_client_release_callback);
 }
 
 static void __qmux_device_free(struct qmi_qmux_device *qmux)
@@ -2322,24 +2323,22 @@ bool qmi_service_get_version(struct qmi_service *service, uint8_t *out_version)
 	return true;
 }
 
-struct service_send_data {
-	qmi_service_result_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
-};
-
-static void service_send_free(struct service_send_data *data)
+static void qmi_service_request_free(struct qmi_request *req)
 {
-	if (data->destroy)
-		data->destroy(data->user_data);
+	struct qmi_service_request *sreq = l_container_of(req,
+					struct qmi_service_request, super);
 
-	l_free(data);
+	if (sreq->destroy)
+		sreq->destroy(sreq->user_data);
+
+	l_free(sreq);
 }
 
-static void service_send_callback(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data)
+static void service_send_callback(struct qmi_request *req, uint16_t message,
+					uint16_t length, const void *buffer)
 {
-	struct service_send_data *data = user_data;
+	struct qmi_service_request *sreq = l_container_of(req,
+					struct qmi_service_request, super);
 	const struct qmi_result_code *result_code;
 	uint16_t len;
 	struct qmi_result result;
@@ -2359,10 +2358,8 @@ static void service_send_callback(uint16_t message, uint16_t length,
 	result.error = L_LE16_TO_CPU(result_code->error);
 
 done:
-	if (data->func)
-		data->func(&result, data->user_data);
-
-	service_send_free(data);
+	if (sreq->func)
+		sreq->func(&result, sreq->user_data);
 }
 
 uint16_t qmi_service_send(struct qmi_service *service,
@@ -2372,15 +2369,13 @@ uint16_t qmi_service_send(struct qmi_service *service,
 {
 	struct qmi_device *device;
 	struct service_family *family;
-	struct service_send_data *data;
-	struct qmi_request *req;
-	uint16_t tid;
+	struct qmi_service_request *sreq;
+	struct qmi_service_info *info;
 
 	if (!service)
 		return 0;
 
 	family = service->family;
-
 	if (!family->group_id)
 		return 0;
 
@@ -2388,23 +2383,21 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	if (!device)
 		return 0;
 
-	data = l_new(struct service_send_data, 1);
-
-	data->func = func;
-	data->user_data = user_data;
-	data->destroy = destroy;
-
-	req = __service_request_alloc(&family->info,
-					family->client_id, message,
-					param ? param->data : NULL,
-					param ? param->length : 0,
-					service_send_callback, data);
-
+	info = &family->info;
+	sreq = __request_alloc(info->service_type, family->client_id, message,
+				param ? param->data : NULL,
+				param ? param->length : 0,
+				offsetof(struct qmi_service_request, super));
 	qmi_param_free(param);
 
-	tid = __service_request_submit(device, service, req);
+	memcpy(&sreq->super.info, info, sizeof(*info));
+	sreq->super.callback = service_send_callback;
+	sreq->super.free_request = qmi_service_request_free;
+	sreq->func = func;
+	sreq->user_data = user_data;
+	sreq->destroy = destroy;
 
-	return tid;
+	return __service_request_submit(device, service, &sreq->super);
 }
 
 bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
@@ -2435,8 +2428,6 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 			return false;
 	}
 
-	service_send_free(req->user_data);
-
 	__request_free(req);
 
 	return true;
@@ -2450,7 +2441,6 @@ static bool remove_req_if_match(void *data, void *user_data)
 	if (req->service_handle != service_handle)
 		return false;
 
-	service_send_free(req->user_data);
 	__request_free(req);
 
 	return true;
-- 
2.45.0

