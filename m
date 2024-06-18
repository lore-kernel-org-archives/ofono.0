Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0916DC3C
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740979; cv=none; b=OAlpCUoNzof3LAO50BtNwmwz2wEaTtQR6DFDaecIR6n0awtudXF8cokMu+gYrWXCdQJAEXY1d9TqgSAu+vXf6avtNQ2oI+F+PBcd8n9KVqn/usZe3zP9wRwnfE51OcPiY8EP1osHVPbkwA4Zss+uCv/QYbpvRF4sb9SpQ3TNEi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740979; c=relaxed/simple;
	bh=ct6NBoejunpbdL+Y28R2VpykRFG30hZW+BMxLKieUbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/gH3iewnUElKw9iHRHEqY8fJGlv6KsQQDFsU3E9XpDXcxvYltVrL/koStTcTUaOnTFLtEPdFOqH68yu8vGeSrp4ssvIOcK+yGr0BOm2t4Pf86KOuSBmUYaKUDPbkvLLo1wMt/B3Z61lbit8BTTVndseFzXwDXw/dJ7q3SlYX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeQZeex4; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeQZeex4"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b9794dad09so2696168eaf.3
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740976; x=1719345776; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHhgRNI//pbHnUOtJhh2c15VzZvNnAL1vsZ9a8EnmmA=;
        b=VeQZeex4ZX8M0GhQBLvoDpVS0mXGAiGLZpIqIzXvHaaIfwCgHSXOGKVkupFCjZw0NY
         xFqSbXftmsPeZ4ep1RMp2w9WHWsCpOu9VxGxRcip0fVD9xbk9jnpxu9cCE1mBEh38by4
         wdeS/ZroeYoHghMtvPzSvanVS+jjJVJnRMhiKxI39cd+sAshHwpfQE5rSUra4Pa5L7KR
         9/9/X3XXaOb7LPEh8a1WmIKgu1AaXs3WvirvVJhp8KJUROn9bQvGmPHEmXmcf+yPUfUn
         khxiFQa5hSiSUeWgGE8Ywlshxzt9UNCO7iFd1Ug5fFer/0jlTj+JaxKPR/jRw4h70j4q
         wnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740976; x=1719345776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHhgRNI//pbHnUOtJhh2c15VzZvNnAL1vsZ9a8EnmmA=;
        b=tY8cC6U+Cu7B9G8egW/5dZoCb2327HVURWEq2RyJBFDoQgK5xiKGL0orA6BuAza48F
         DHwMJswjeGt4+cVixjLPI0FC5JqM6h1OK3HkXw4JL7vZVUQn8r8ikcpH20l5pqSbvsog
         pzM41EJvQWwU7frWwIvjV4x019kGkBS7QSgYVSF1rCT3SJARg8miXxPe/tEbTLTWW7uw
         QhWe5qyqfrwPCIgVekiRJg6B/8o5X1gGghgWfRUORjA4UOYtS+hLnz8+N2tPPToACE9s
         wNRl5EDuYRkwn28Lfaq8lVi+Saq3oDC789MHamZClm6BdpagEy/7WKUPbFhCLnCMohi/
         iyuQ==
X-Gm-Message-State: AOJu0Yx2gcFuwvLnjlWLtZUAp9x1E1LIeVDUWMzHKvcg2DpRNki/TH0+
	SjkMn2oGzdmeaXagODZgZj2ScZtAXR0pC4rFKdESZeJZbtGobhsr152YHA==
X-Google-Smtp-Source: AGHT+IFOLfbzQskesuDVQswnYWrSwJa3ZgXF0Y7QnkFzkruEjcjMeT4+LaJ5yoDEakq32mZrZpIETQ==
X-Received: by 2002:a05:6870:c10c:b0:254:7936:e1df with SMTP id 586e51a60fabf-25c949b0885mr1066414fac.22.1718740976493;
        Tue, 18 Jun 2024 13:02:56 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:56 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 30/33] qmi: combine qmux_client_create_data into qmi_request
Date: Tue, 18 Jun 2024 15:02:12 -0500
Message-ID: <20240618200231.1129282-30-denkenz@gmail.com>
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

Similarly to the previous commit, do not allocate a separate data
structure to hold client creation details, and instead allocate it as
a qmi_request specialization.  Since the lifetime of struct
qmux_client_create_data was already tied to the lifetime of the request
(and vice-versa), this change allows the extra allocation to be
optimized away.

While here, remove all vestiges of discovery and discovery_queue.  This
functionality is no longer needed since any data associated with the
request will be freed when struct qmi_request is freed.
---
 drivers/qmimodem/qmi.c | 153 ++++++++++++++---------------------------
 1 file changed, 51 insertions(+), 102 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3742e8fc4b73..e3a8b225140f 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -42,10 +42,6 @@ struct qmi_request;
 typedef void (*response_func_t)(struct qmi_request *, uint16_t message,
 				uint16_t length, const void *buffer);
 
-struct discovery {
-	qmi_destroy_func_t destroy;
-};
-
 struct qmi_service_info {
 	uint32_t service_type;
 	uint32_t qrtr_port;		/* Always 0 on qmux */
@@ -90,7 +86,6 @@ struct qmi_device {
 	struct l_io *io;
 	struct l_queue *req_queue;
 	struct l_queue *service_queue;
-	struct l_queue *discovery_queue;
 	unsigned int next_group_id;	/* Matches requests with services */
 	unsigned int next_service_handle;
 	uint16_t next_service_tid;
@@ -268,11 +263,12 @@ static void *__request_alloc(uint32_t service_type,
 	return mem;
 }
 
-static struct qmi_request *__control_request_alloc(uint16_t message,
-					const void *data, uint16_t length)
+static void *__control_request_alloc(uint16_t message,
+					const void *data, uint16_t length,
+					size_t offset)
 {
 	return __request_alloc(QMI_SERVICE_CONTROL, 0x00, message,
-					data, length, 0);
+					data, length, offset);
 }
 
 static void __request_free(void *data)
@@ -293,14 +289,6 @@ static bool __request_compare(const void *a, const void *b)
 	return req->tid == tid;
 }
 
-static void __discovery_free(void *data)
-{
-	struct discovery *d = data;
-	qmi_destroy_func_t destroy = d->destroy;
-
-	destroy(d);
-}
-
 static void __notify_free(void *data)
 {
 	struct qmi_notify *notify = data;
@@ -815,33 +803,6 @@ static void __rx_message(struct qmi_device *device,
 	__request_free(req);
 }
 
-static void __qmi_device_discovery_started(struct qmi_device *device,
-						struct discovery *d)
-{
-	l_queue_push_tail(device->discovery_queue, d);
-}
-
-static void __qmi_device_discovery_complete(struct qmi_device *device,
-						struct discovery *d)
-{
-	if (!l_queue_remove(device->discovery_queue, d))
-		return;
-}
-
-/*
- * Prevents re-entrancy problems by removing the entry from the discovery_queue
- * before calling the callback.
- */
-#define DISCOVERY_DONE(data, ...)\
-do {\
-	__qmi_device_discovery_complete(data->device, &data->super);\
-\
-	if (data->func)\
-		data->func(__VA_ARGS__);\
-\
-	__discovery_free(&data->super);\
-} while (0)
-
 static void family_destroy(void *data)
 {
 	struct service_family *family = data;
@@ -873,7 +834,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 
 	device->req_queue = l_queue_new();
 	device->service_queue = l_queue_new();
-	device->discovery_queue = l_queue_new();
 	device->service_infos = l_queue_new();
 	device->family_list = l_hashmap_new();
 
@@ -888,7 +848,6 @@ static void __qmi_device_free(struct qmi_device *device)
 {
 	l_queue_destroy(device->service_queue, __request_free);
 	l_queue_destroy(device->req_queue, __request_free);
-	l_queue_destroy(device->discovery_queue, __discovery_free);
 
 	l_io_destroy(device->io);
 
@@ -1301,7 +1260,7 @@ done:
 	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
 			qmux->control_major > 1) {
 		struct qmi_request *req =
-			__control_request_alloc(QMI_CTL_SYNC, NULL, 0);
+			__control_request_alloc(QMI_CTL_SYNC, NULL, 0, 0);
 
 		req->user_data = qmux;
 
@@ -1345,7 +1304,7 @@ int qmi_qmux_device_discover(struct qmi_qmux_device *qmux,
 	if (l_queue_length(qmux->super.service_infos) > 0 || qmux->discover.tid)
 		return -EALREADY;
 
-	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0);
+	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0, 0);
 	req->user_data = qmux;
 
 	qmux->discover.func = func;
@@ -1360,9 +1319,8 @@ int qmi_qmux_device_discover(struct qmi_qmux_device *qmux,
 	return 0;
 }
 
-struct qmux_client_create_data {
-	struct discovery super;
-	struct qmi_device *device;
+struct qmux_create_client_request {
+	struct qmi_qmux_device *qmux;
 	uint8_t type;
 	uint16_t major;
 	uint16_t minor;
@@ -1370,52 +1328,46 @@ struct qmux_client_create_data {
 	void *user_data;
 	qmi_destroy_func_t destroy;
 	struct l_timeout *timeout;
-	uint16_t tid;
+	struct qmi_request super;
 };
 
-static void qmux_client_create_data_free(void *user_data)
+static void qmux_create_client_request_free(struct qmi_request *r)
 {
-	struct qmux_client_create_data *data = user_data;
+	struct qmux_create_client_request *req =
+		l_container_of(r, struct qmux_create_client_request, super);
 
-	if (data->timeout)
-		l_timeout_remove(data->timeout);
+	if (req->timeout)
+		l_timeout_remove(req->timeout);
 
-	if (data->destroy)
-		data->destroy(data->user_data);
+	if (req->destroy)
+		req->destroy(req->user_data);
 
-	l_free(data);
+	l_free(req);
 }
 
-static void qmux_client_create_timeout(struct l_timeout *timeout,
+static void qmux_create_client_timeout(struct l_timeout *timeout,
 							void *user_data)
 {
-	struct qmux_client_create_data *data = user_data;
-	struct qmi_device *device = data->device;
-	struct qmi_qmux_device *qmux =
-		l_container_of(device, struct qmi_qmux_device, super);
-	struct qmi_request *req;
+	struct qmux_create_client_request *req = user_data;
+	struct qmi_qmux_device *qmux = req->qmux;
 
 	DEBUG(&qmux->debug, "");
 
-	l_timeout_remove(data->timeout);
-	data->timeout = NULL;
+	l_timeout_remove(req->timeout);
+	req->timeout = NULL;
 
 	/* remove request from queues */
-	req = find_control_request(qmux, data->tid);
-	if (req)
-		__request_free(req);
-
-	DISCOVERY_DONE(data, NULL, data->user_data);
+	find_control_request(qmux, req->super.tid);
+	__request_free(&req->super);
 }
 
-static void qmux_client_create_callback(struct qmi_request *req,
+static void qmux_create_client_callback(struct qmi_request *r,
 					uint16_t message, uint16_t length,
 					const void *buffer)
 {
-	struct qmux_client_create_data *data = req->user_data;
-	struct qmi_device *device = data->device;
-	struct qmi_qmux_device *qmux =
-		l_container_of(device, struct qmi_qmux_device, super);
+	struct qmux_create_client_request *req =
+		l_container_of(r, struct qmux_create_client_request, super);
+	struct qmi_qmux_device *qmux = req->qmux;
 	struct service_family *family = NULL;
 	struct qmi_service *service = NULL;
 	struct qmi_service_info info;
@@ -1438,13 +1390,13 @@ static void qmux_client_create_callback(struct qmi_request *req,
 	if (len != QMI_CLIENT_ID_SIZE)
 		goto done;
 
-	if (client_id->service != data->type)
+	if (client_id->service != req->type)
 		goto done;
 
 	memset(&info, 0, sizeof(family->info));
-	info.service_type = data->type;
-	info.major = data->major;
-	info.minor = data->minor;
+	info.service_type = req->type;
+	info.major = req->major;
+	info.minor = req->minor;
 
 	family = service_family_create(&qmux->super, &info, client_id->client);
 	DEBUG(&qmux->debug, "service family created [client=%d,type=%d]",
@@ -1460,7 +1412,8 @@ done:
 	if (family)
 		service = service_create(family);
 
-	DISCOVERY_DONE(data, service, data->user_data);
+	if (req->func)
+		req->func(service, req->user_data);
 
 	if (family)
 		service_family_unref(family);
@@ -1473,8 +1426,7 @@ bool qmi_qmux_device_create_client(struct qmi_qmux_device *qmux,
 {
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
 	const struct qmi_service_info *info;
-	struct qmi_request *req;
-	struct qmux_client_create_data *create_data;
+	struct qmux_create_client_request *req;
 
 	if (!qmux || !func)
 		return false;
@@ -1486,28 +1438,25 @@ bool qmi_qmux_device_create_client(struct qmi_qmux_device *qmux,
 	if (!info)
 		return false;
 
-	create_data = l_new(struct qmux_client_create_data, 1);
-	create_data->super.destroy = qmux_client_create_data_free;
-	create_data->device = &qmux->super;
-	create_data->type = service_type;
-	create_data->major = info->major;
-	create_data->minor = info->minor;
-	create_data->func = func;
-	create_data->user_data = user_data;
-	create_data->destroy = destroy;
-
 	DEBUG(&qmux->debug, "creating client [type=%d]", service_type);
 
 	req = __control_request_alloc(QMI_CTL_GET_CLIENT_ID,
-					client_req, sizeof(client_req));
-	req->user_data = create_data;
-
-	create_data->tid = __ctl_request_submit(qmux, req,
-						qmux_client_create_callback);
-	create_data->timeout = l_timeout_create(8, qmux_client_create_timeout,
-							create_data, NULL);
+				client_req, sizeof(client_req),
+				offsetof(struct qmux_create_client_request,
+						super));
+	req->super.free_request = qmux_create_client_request_free;
+	req->qmux = qmux;
+	req->type = service_type;
+	req->major = info->major;
+	req->minor = info->minor;
+	req->func = func;
+	req->user_data = user_data;
+	req->destroy = destroy;
+	req->timeout = l_timeout_create(8, qmux_create_client_timeout,
+					req, NULL);
+
+	__ctl_request_submit(qmux, &req->super, qmux_create_client_callback);
 
-	__qmi_device_discovery_started(&qmux->super, &create_data->super);
 	return true;
 }
 
@@ -1532,7 +1481,7 @@ static void qmi_qmux_device_client_release(struct qmi_device *device,
 	qmux->shutdown.release_users++;
 
 	req = __control_request_alloc(QMI_CTL_RELEASE_CLIENT_ID,
-					release_req, sizeof(release_req));
+					release_req, sizeof(release_req), 0);
 	req->user_data = qmux;
 
 	__ctl_request_submit(qmux, req, qmux_client_release_callback);
-- 
2.45.0

