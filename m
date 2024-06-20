Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85EA1AE858
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895131; cv=none; b=H4l1zLaSwb3CW8Byxnh+AT1qj6ecDOC6866e3cDBZCbkiScUtBCxyK/zaMOM5Viw6tZ5AwZPihKOl4SokfTG25Csfe05e6sHAaW4zvnfCc0q9bYOqu7AXqF6oFa8kQ3KBM5zX3lN9KAE3EeOdlRrXSEcvKK2TyiYfGYmnyXSORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895131; c=relaxed/simple;
	bh=coxN1LgE84gfBTuq+/ipflyI44noVl25Cny2Yzv+2Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtA/d9flbi3WM5oNlgmoS1ujN2cs1AXEUSvZyAihzhKMnt970Ns1YZq2MzJuIvuoPYzzKJSyyfq5bbrnD9WkcDgAXuue9I5WTv+d2IhqrUA/u/YU55eFUk6HcIk4b6Mk9tQ/bijNVY3h5kVp4/elT35ZhMHIC7b3W3YQ46X/8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeIN3F0V; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeIN3F0V"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d5288e6513so509996b6e.0
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895129; x=1719499929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Q9ZBF3t/VddBaO74EVEslnyVmzfYoEF/ouJ68CH4v0=;
        b=eeIN3F0VbiEay8WLyrVdwhZAozMKdUt0FeP02T7zLGmdwe4xrqAeHj2WAVN/uotsd1
         pIloRaykYjGxor5wvkFrZSLdHYNGJKTn96lJDUqiOmgaRsVMV88WsW/B5oyokjBeEAy/
         u1xkMyUzge1R4imcSUv59iANOUYvGPLMLRrSoHn5u8mCIv/yIUfFja19BjV0ldQxdTr2
         3PJhcGLRNOKkgTLd0PwDgAsNNRQu2V+/A+APtt5gB/gQ+2zJ3vBWUv51eSCqeJZquXte
         4nWPPVy6wRr5awnhVdUC/Imuwrdpvqo8uIBbnFPVCZ1dAjM357XiX2vNcxgBl/Vqi+/o
         ix1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895129; x=1719499929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Q9ZBF3t/VddBaO74EVEslnyVmzfYoEF/ouJ68CH4v0=;
        b=KexqtuIO1FhB5fLW1ZxS4Noc8+TgPG57PplRGGLsCCIfFjy/1wjd2BoVRHx80rFmX8
         TO1GOIA1bN7WKXKHXTKJVBpl5wxBbg145+zDEMlevWmWuCLTnGi9q1OdQAlDTyjtq9/j
         fqWszsiaQU53KGYYBcjQviWA5y1wuK/rv9Ex7cgLLZks8R+y8/ft23Ibedy9vmlsnMyO
         rQRwF1Htl5mO2/SFXwZCE3VzvHPBr7EbUrHTjKkjDcCcwGVg4xk5vGmm4pTKBMRyGdva
         ZAQtDwtq1W0PvMeGMx2tLr8+lvIyuujsEnQljKDg6JEBLUNsoKuBcR3W39Bfq+Mp5+tN
         14oQ==
X-Gm-Message-State: AOJu0YyOiIbzXbtobmhf7Qu5LMacmC+Ak/G+BxKQheMTadwXkPmDQ2IS
	HMyX5WE7x20lnjkfyRU8r5+Q9cNaSRv9PqZT1+Cd9EnLTKdE6ImAJJL2mQ==
X-Google-Smtp-Source: AGHT+IFdSsBn0OCoPtrXhBmFqpGofYONsqiCvHdPzlyM9SQhK4y0cY8OIutjVHOK0SylpgzB92YkRQ==
X-Received: by 2002:a05:6808:300a:b0:3d5:11bd:1561 with SMTP id 5614622812f47-3d51b9e5b32mr5572796b6e.30.1718895128652;
        Thu, 20 Jun 2024 07:52:08 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:08 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 20/33] qmi: introduce qmi_qrtr_node_lookup
Date: Thu, 20 Jun 2024 09:51:07 -0500
Message-ID: <20240620145139.1135899-20-denkenz@gmail.com>
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
index 54661bf44d91..2b6a4edb8b85 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -67,6 +67,7 @@ typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(void *user_data);
 typedef void (*qmi_qmux_device_create_client_func_t)(struct qmi_service *,
 							void *user_data);
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
index 8ea9819f3297..0f9519d819bc 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -215,7 +215,7 @@ static int qrtrqmi_enable(struct ofono_modem *modem)
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

