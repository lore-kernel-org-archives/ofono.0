Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BE1A2549
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391200; cv=none; b=bZS8JEjKLBSqPBTPdNezuE50pJFPJsyxsy4z1mJ7kpr43M8PeenJvjRKalNFt/uqKyQETmZTJY9u+kSSYEaz06WwpPE3Ik7Aq/PM8FgAQhfXb0jR0n9XgBb2q+wBBnFwB0OUuixV7nSoPIWCJA9JeFkVF9HnKkwldYC2JZ6ls0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391200; c=relaxed/simple;
	bh=IOSSPEsrM/OLITmDh2NTBxrbpPDfJKakZCCI0xeT88w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOrvfr20UpCdTtY0PxGoms1kzGTBjBid+qbOOHRMSxS96fxh0rMHinv0Ay8iwfICedl4ZbwG4lnP0d4GHlcRTcYHFofqsXJSE9GHOaQSr+jKjZo+3uoDvNigpYCbu2k/PHc8GN5ATz03ljoMryA8lwg1IAzi7uJn3yBsxip1dyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe6U+c+N; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe6U+c+N"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-254871388d3so1308070fac.1
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391197; x=1718995997; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVHycapvYITiiND0J/6/uj9vqdmYFePERDiu/TLhv1w=;
        b=Oe6U+c+N7lD5R5ueiTCyzo9WvQK2QmwE5+qg/UTvdbwyoeJhxIzHJOHPVXN7xwwgtT
         w/ynRc4Dj8J1IFp3i8lJOO0dkINLrYl4lJEh8VOV5smOD/Aom0BzI5DXTW0qLrA76EGV
         XBezTMr5wovhTZ5kXpkPvy5G9Rx9GPgcHeNWw/q4+puCqIWkx6j9Q91h2oTudR3UxIwH
         DzZ++A2WtpnUi76igi+IaCvkp1AYY1gi8qM6Qy2rqOUgeuIG55OfQrCz6eq1hBsUZVgu
         k7z+h+4NFZWbOpt69UEd1FpGpdGbzfMW24GO1hvhwhsZzvMhMOiTf6uMsZCVJmyiO3dg
         jVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391197; x=1718995997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVHycapvYITiiND0J/6/uj9vqdmYFePERDiu/TLhv1w=;
        b=QAOXWzEjhdKmRXfL48P5v0cc7IJoj3UGA+rUkdkjN7LRYnPql33Hy6MDBR2KFvokQF
         Zh734xtDUiEI9TuOIhaGRpMbwUq8XOty5ohCFSa3l6YiFy23A5UTLUKStG3+5KcJm9/s
         O/uiTu8hTUkLcqvu7y0Y4HrNQ9CyGQSSsKVLJK0kMPKjbGyqH0KuU82ThbYcHyh0Q1cG
         0qYrOtfnV3naH8Z0XS9m2zERhUPx4uMwdNacscB9JFOCSIue6H8O1+c5gUJOrykaWha9
         R/XGVo20QLTenMdLy+087MCfb3FwILQn0GoCmnAqLFY9CyV5GXYyJbesadjibGsvM1Bt
         FD+g==
X-Gm-Message-State: AOJu0Yzt70rJU/f9lize1HTOYfiXqgQOorypn8oG2bK4Hj1jI6WDbGrj
	Us+DCiqdUZAIjHrQ+yNkRdH1J4M5q79sHd0dn60qtB10K8gVpElUemIMVA==
X-Google-Smtp-Source: AGHT+IF809N7bxPsBHnFR80y9qmwAn/JSfYgbnyxRcNsQrMTInNLiKWGCBm1l4wMe6/jRi2iaZO6Fg==
X-Received: by 2002:a05:6870:14cf:b0:250:8141:9210 with SMTP id 586e51a60fabf-2584288feffmr3502033fac.9.1718391197208;
        Fri, 14 Jun 2024 11:53:17 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:16 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 19/27] qmi: introduce qmi_qrtr_node_lookup
Date: Fri, 14 Jun 2024 13:52:31 -0500
Message-ID: <20240614185300.1086701-19-denkenz@gmail.com>
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

Service discovery on QRTR is accomplished using a QRTR NEW_LOOKUP
control message.  Utilize this terminology and introduce a QRTR specific
qmi_qrtr_node_lookup method.  This method replaces
qmi_device_discover().  Update the qrtr unit tests to use the new API.

Refactor the lookup implementation to not use struct discover_data or
the discovery queue.  Use a dedicated 'lookup' structure instead.

Change the -EINPROGRESS error returned from qmi_qrtr_node_lookup to
-EALREADY to better reflect that the operation has already started.
-EINPROGRESS is frequently used in other drivers to notify the caller
that the operation will complete asynchronously, with the 0 result
meaning that the operation is already complete.
---
 drivers/qmimodem/qmi.c   | 193 +++++++++++++++++++--------------------
 drivers/qmimodem/qmi.h   |   4 +
 plugins/qrtrqmi.c        |   2 +-
 unit/test-qmimodem-qmi.c |  26 +++---
 4 files changed, 114 insertions(+), 111 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index d0f8a56f1461..f1b2247b4178 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1919,8 +1919,30 @@ void qmi_qmux_device_free(struct qmi_device *device)
 
 struct qmi_device_qrtr {
 	struct qmi_device super;
+	struct {
+		qmi_qrtr_node_lookup_done_func_t func;
+		void *user_data;
+		qmi_destroy_func_t destroy;
+		struct l_timeout *timeout;
+	} lookup;
 };
 
+static void __qrtr_lookup_finished(struct qmi_device_qrtr *node)
+{
+	if (!node->lookup.func) {
+		__debug_device(&node->super, "No lookup in progress");
+		return;
+	}
+
+	l_timeout_remove(node->lookup.timeout);
+	node->lookup.func(node->lookup.user_data);
+
+	if (node->lookup.destroy)
+		node->lookup.destroy(node->lookup.user_data);
+
+	memset(&node->lookup, 0, sizeof(node->lookup));
+}
+
 static int qmi_device_qrtr_write(struct qmi_device *device,
 					struct qmi_request *req)
 {
@@ -1980,11 +2002,11 @@ static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
 	function(strbuf, user_data);
 }
 
-static void qrtr_received_control_packet(struct qmi_device *device,
+static void qrtr_received_control_packet(struct qmi_device_qrtr *node,
 						const void *buf, size_t len)
 {
+	struct qmi_device *device = &node->super;
 	const struct qrtr_ctrl_pkt *packet = buf;
-	struct discover_data *data;
 	struct qmi_service_info info;
 	uint32_t cmd;
 	uint32_t type;
@@ -2006,18 +2028,11 @@ static void qrtr_received_control_packet(struct qmi_device *device,
 		return;
 	}
 
-	data = l_queue_peek_head(device->discovery_queue);
-
 	if (!packet->server.service && !packet->server.instance &&
 			!packet->server.node && !packet->server.port) {
 		__debug_device(device,
 				"Initial service discovery has completed");
-
-		if (data)
-			DISCOVERY_DONE(data, data->user_data);
-		else
-			DBG("discovery_queue is empty"); /* likely a timeout */
-
+		__qrtr_lookup_finished(node);
 		return;
 	}
 
@@ -2041,12 +2056,10 @@ static void qrtr_received_control_packet(struct qmi_device *device,
 
 	__qmi_service_appeared(device, &info);
 
-	if (!data) {
-		DBG("discovery_queue is empty"); /* likely a timeout */
+	if (!node->lookup.func)
 		return;
-	}
 
-	l_timeout_modify(data->timeout, DISCOVER_TIMEOUT);
+	l_timeout_modify(node->lookup.timeout, DISCOVER_TIMEOUT);
 }
 
 static void qrtr_received_service_message(struct qmi_device *device,
@@ -2101,7 +2114,7 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 			qrtr->super.debug_data);
 
 	if (addr.sq_port == QRTR_PORT_CTRL)
-		qrtr_received_control_packet(&qrtr->super, buf, bytes_read);
+		qrtr_received_control_packet(qrtr, buf, bytes_read);
 	else
 		qrtr_received_service_message(&qrtr->super, addr.sq_node,
 						addr.sq_port, buf, bytes_read);
@@ -2109,42 +2122,78 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	return true;
 }
 
-static void qrtr_discover_reply_timeout(struct l_timeout *timeout,
-							void *user_data)
+static const struct qmi_device_ops qrtr_ops = {
+	.write = qmi_device_qrtr_write,
+	.client_release = NULL,
+	.shutdown = NULL,
+};
+
+struct qmi_device *qmi_qrtr_node_new(uint32_t node)
 {
-	struct discover_data *data = user_data;
+	struct qmi_device_qrtr *qrtr;
+	int fd;
 
-	l_timeout_remove(data->timeout);
-	data->timeout = NULL;
+	fd = socket(AF_QIPCRTR, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return NULL;
 
-	DISCOVERY_DONE(data, data->user_data);
+	qrtr = l_new(struct qmi_device_qrtr, 1);
+
+	if (qmi_device_init(&qrtr->super, fd, &qrtr_ops) < 0) {
+		close(fd);
+		l_free(qrtr);
+		return NULL;
+	}
+
+	l_io_set_read_handler(qrtr->super.io, qrtr_received_data, qrtr, NULL);
+
+	return &qrtr->super;
 }
 
-static int qmi_device_qrtr_discover(struct qmi_device *device,
-					qmi_discover_func_t func,
-					void *user_data,
-					qmi_destroy_func_t destroy)
+void qmi_qrtr_node_free(struct qmi_device *device)
 {
-	struct discover_data *data;
+	struct qmi_device_qrtr *node;
+
+	if (!device)
+		return;
+
+	__qmi_device_free(device);
+
+	node = l_container_of(device, struct qmi_device_qrtr, super);
+
+	if (node->lookup.destroy)
+		node->lookup.destroy(node->lookup.user_data);
+
+	l_free(node);
+}
+
+static void qrtr_lookup_reply_timeout(struct l_timeout *timeout,
+							void *user_data)
+{
+	struct qmi_device_qrtr *node = user_data;
+
+	__qrtr_lookup_finished(node);
+}
+
+int qmi_qrtr_node_lookup(struct qmi_device *device,
+			qmi_qrtr_node_lookup_done_func_t func,
+			void *user_data, qmi_destroy_func_t destroy)
+{
+	struct qmi_device_qrtr *node;
 	struct qrtr_ctrl_pkt packet;
 	struct sockaddr_qrtr addr;
 	socklen_t addr_len;
-	int rc;
 	ssize_t bytes_written;
 	int fd;
 
-	__debug_device(device, "device %p discover", device);
-
-	if (l_queue_length(device->discovery_queue) > 0)
-		return -EINPROGRESS;
+	if (!device || !func)
+		return -EINVAL;
 
-	data = l_new(struct discover_data, 1);
+	node = l_container_of(device, struct qmi_device_qrtr, super);
+	if (node->lookup.func)
+		return -EALREADY;
 
-	data->super.destroy = discover_data_free;
-	data->device = device;
-	data->func = func;
-	data->user_data = user_data;
-	data->destroy = destroy;
+	__debug_device(device, "node %p discover", node);
 
 	fd = l_io_get_fd(device->io);
 
@@ -2153,19 +2202,16 @@ static int qmi_device_qrtr_discover(struct qmi_device *device,
 	 * get its value.
 	 */
 	addr_len = sizeof(addr);
-	rc = getsockname(fd, (struct sockaddr *) &addr, &addr_len);
-	if (rc) {
+	if (getsockname(fd, (struct sockaddr *) &addr, &addr_len) < 0) {
 		__debug_device(device, "getsockname failed: %s",
 				strerror(errno));
-		rc = -errno;
-		goto error;
+		return -errno;
 	}
 
 	if (addr.sq_family != AF_QIPCRTR || addr_len != sizeof(addr)) {
 		__debug_device(device, "Unexpected sockaddr family: %d size: %d",
 				addr.sq_family, addr_len);
-		rc = -EIO;
-		goto error;
+		return -EIO;
 	}
 
 	addr.sq_port = QRTR_PORT_CTRL;
@@ -2178,67 +2224,20 @@ static int qmi_device_qrtr_discover(struct qmi_device *device,
 	if (bytes_written < 0) {
 		__debug_device(device, "Failure sending data: %s",
 				strerror(errno));
-		rc = -errno;
-		goto error;
+		return -errno;
 	}
 
 	l_util_hexdump(false, &packet, bytes_written,
 			device->debug_func, device->debug_data);
 
-	data->timeout = l_timeout_create(DISCOVER_TIMEOUT,
-						qrtr_discover_reply_timeout,
-						data, NULL);
-
-	__qmi_device_discovery_started(device, &data->super);
+	node->lookup.func = func;
+	node->lookup.user_data = user_data;
+	node->lookup.destroy = destroy;
+	node->lookup.timeout = l_timeout_create(DISCOVER_TIMEOUT,
+						qrtr_lookup_reply_timeout,
+						node, NULL);
 
 	return 0;
-
-error:
-	__discovery_free(&data->super);
-
-	return rc;
-}
-
-static const struct qmi_device_ops qrtr_ops = {
-	.write = qmi_device_qrtr_write,
-	.discover = qmi_device_qrtr_discover,
-	.client_release = NULL,
-	.shutdown = NULL,
-};
-
-struct qmi_device *qmi_qrtr_node_new(uint32_t node)
-{
-	struct qmi_device_qrtr *qrtr;
-	int fd;
-
-	fd = socket(AF_QIPCRTR, SOCK_DGRAM, 0);
-	if (fd < 0)
-		return NULL;
-
-	qrtr = l_new(struct qmi_device_qrtr, 1);
-
-	if (qmi_device_init(&qrtr->super, fd, &qrtr_ops) < 0) {
-		close(fd);
-		l_free(qrtr);
-		return NULL;
-	}
-
-	l_io_set_read_handler(qrtr->super.io, qrtr_received_data, qrtr, NULL);
-
-	return &qrtr->super;
-}
-
-void qmi_qrtr_node_free(struct qmi_device *device)
-{
-	struct qmi_device_qrtr *node;
-
-	if (!device)
-		return;
-
-	__qmi_device_free(device);
-
-	node = l_container_of(device, struct qmi_device_qrtr, super);
-	l_free(node);
 }
 
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 35ff62ff5a31..68d5cca6d9d2 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -67,6 +67,7 @@ typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(void *user_data);
 typedef void (*qmi_qmux_device_create_client_func_t)(struct qmi_service *,
 							void *);
+typedef void (*qmi_qrtr_node_lookup_done_func_t)(void *);
 
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
@@ -98,6 +99,9 @@ bool qmi_device_set_expected_data_format(struct qmi_device *device,
 
 struct qmi_device *qmi_qrtr_node_new(uint32_t node);
 void qmi_qrtr_node_free(struct qmi_device *device);
+int qmi_qrtr_node_lookup(struct qmi_device *device,
+			qmi_qrtr_node_lookup_done_func_t func,
+			void *user_data, qmi_destroy_func_t destroy);
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
 						uint32_t type);
 
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 23fd6e165bf4..6765f0644e98 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -213,7 +213,7 @@ static int qrtrqmi_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_QMI_DEBUG"))
 		qmi_device_set_debug(data->node, qrtrqmi_debug, "QRTR: ");
 
-	r = qmi_device_discover(data->node, lookup_done, modem, NULL);
+	r = qmi_qrtr_node_lookup(data->node, lookup_done, modem, NULL);
 	if (!r)
 		return -EINPROGRESS;
 
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 4c035db3c9c9..b6537629f86d 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -40,7 +40,7 @@ struct test_info {
 	size_t received_len;
 	void *received;
 
-	bool discovery_callback_called		: 1;
+	bool lookup_callback_called		: 1;
 	bool service_send_callback_called	: 1;
 	bool internal_timeout_callback_called	: 1;
 	bool notify_callback_called		: 1;
@@ -188,26 +188,26 @@ static void test_create_qrtr_node(const void *data)
 	test_cleanup(info);
 }
 
-static void discovery_complete_cb(void *user_data)
+static void lookup_complete_cb(void *user_data)
 {
 	struct test_info *info = user_data;
 
-	info->discovery_callback_called = true;
+	info->lookup_callback_called = true;
 }
 
-static void perform_discovery(struct test_info *info)
+static void perform_lookup(struct test_info *info)
 {
-	qmi_device_discover(info->node, discovery_complete_cb, info, NULL);
+	qmi_qrtr_node_lookup(info->node, lookup_complete_cb, info, NULL);
 
-	while (!info->discovery_callback_called)
+	while (!info->lookup_callback_called)
 		l_main_iterate(-1);
 }
 
-static void test_discovery(const void *data)
+static void test_lookup(const void *data)
 {
 	struct test_info *info = test_setup();
 
-	perform_discovery(info);
+	perform_lookup(info);
 
 	test_cleanup(info);
 }
@@ -228,7 +228,7 @@ static void test_create_services(const void *data)
 	uint32_t service_type;
 	size_t i;
 
-	perform_discovery(info);
+	perform_lookup(info);
 
 	for (i = 0; i < TEST_SERVICE_COUNT; i++) {
 		struct qmi_service *service;
@@ -428,7 +428,7 @@ static void test_send_data(const void *data)
 	uint32_t service_type;
 	struct qmi_service *service;
 
-	perform_discovery(info);
+	perform_lookup(info);
 
 	service_type = unique_service_type(0); /* Use the first service */
 	service = qmi_qrtr_node_get_service(info->node, service_type);
@@ -475,7 +475,7 @@ static void test_notifications(const void *data)
 	struct qmi_service *service;
 	struct l_timeout *receive_timeout;
 
-	perform_discovery(info);
+	perform_lookup(info);
 
 	service_type = unique_service_type(0); /* Use the first service */
 	service = qmi_qrtr_node_get_service(info->node, service_type);
@@ -528,7 +528,7 @@ static void test_service_notification_independence(const void *data)
 	struct qmi_service *services[2];
 	size_t i;
 
-	perform_discovery(info);
+	perform_lookup(info);
 
 	service_type = unique_service_type(0); /* Use the first service */
 
@@ -592,7 +592,7 @@ int main(int argc, char **argv)
 
 	l_test_init(&argc, &argv);
 	l_test_add("QRTR node creation", test_create_qrtr_node, NULL);
-	l_test_add("QRTR discovery", test_discovery, NULL);
+	l_test_add("QRTR lookup", test_lookup, NULL);
 	l_test_add("QRTR services may be created", test_create_services, NULL);
 	l_test_add("QRTR service sends/responses", test_send_data, NULL);
 	l_test_add("QRTR notifications", test_notifications, NULL);
-- 
2.45.0

