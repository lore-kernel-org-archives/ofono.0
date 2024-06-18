Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1816DC3A
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740974; cv=none; b=oipf1MX4zdnRp0cRmns2ULshNpkJeJJo3W4CAn99rYsXxiZD8c7KtJDaPqN2ol98lOgJcFF8LNzavrfMgMAzhZIvhLpKDeC0uNMdRgXNl4BAwgeI2xpNkUgrEnRUk80jZGB2pcFsSZp93SHI0471GXvHc4zHghltshlIEYXWS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740974; c=relaxed/simple;
	bh=c+ISnDayuuXGeIoFjdCD46rwDEvlyAWEQLDJu69jD8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdGVbz4dPMsupuzK44RPBb8uHRClOpnj/Nj7qQKXkP67fhhNfmUNvJ6KVTmll3ZApwG/U0QfMhwnmJvJ/6b9r7oAftkFUK7frSJfMk6ScpcyT4BxDimf1O6RoGM8axB/sabZXHBjBXlw0pvgRHdMyMaU/EJBIZ/gKTrp500w0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRTVQmYd; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRTVQmYd"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2598a57b2c1so314304fac.0
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740972; x=1719345772; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGUpZHRIRvxK0pNl0wDhivLPtVbaekEl0KqbXtilTKA=;
        b=XRTVQmYdowsNDYLAG9/UVwgo6vKzH6sdEgznXE7cnv36rWazAIDj0shV+LBNLgM2pm
         j5X7iVVRqWQxj7gBalp8/o7jMP7KM0iBHXpQMwCpQlsTQaVw+2SR6uhqoj4Jh9cAGcml
         davU9kzXV9wpEWYxK3DsyHGdawwxV821lipWEcT33OXaidMA0nva8I5EobLB0EdzCede
         QOivAVikO1s5sxKX8941Gih2Y5heeRr2nWG7brygzTYQkRRMrQkN5yTTtl8A7XxMtDnn
         bt5lhTo6/IqH8gj/t7Szrwung9cnvRkXGEKFuyBh1i4NbdumgSQgeOrOcHY4aRhKIKKz
         DhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740972; x=1719345772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGUpZHRIRvxK0pNl0wDhivLPtVbaekEl0KqbXtilTKA=;
        b=cLmJmQp7Rm6qQ8a2f8Vo+n7NmTKW+8vuWZzh/p78zdICYW0EQxDA2I/sWKkxF7DuGh
         Znfrrw6HiXmuK+0SiHQMlXARRymBnZx2206Nk6P6z1eSRRkpl9jDQTssFRzhxFRx1t3E
         N9RauoA3o1yKOAg5Ft/rKYPZH+ZgQ9PXK59RTyeyIqwoj7N5ZicJYbtkKMAl5bIZuJgG
         eJabJxgtuPj42GCLdFqW9gEsukn4BXZCGHfEUTlkR3NUv1OClmUwT7y0SaqSF3EGpCqM
         3PiN/SEKuPn0KMouGNwbjB7hWllfdqTnByyYXEKkWetCGKPnPcluguOhoKMmIMmAqKe0
         a1Xw==
X-Gm-Message-State: AOJu0YyKihCh/P2+FOV4NciqfwT8g9R/nrr+u1aqYzEydgIA/FtaluNO
	4R6XMoUmEd5iP9DpAzOPiX7lzoJ1sd1I+/pAbfVLre9qImiuVawcAvxHhw==
X-Google-Smtp-Source: AGHT+IF5zLlR0+F2iOwoQxWkhk+X0Y6/A6w3CvCl86q38WnxYfh2KCBUophjCR+QJhqAsJHrydyYvQ==
X-Received: by 2002:a05:6870:1018:b0:257:ea15:b72b with SMTP id 586e51a60fabf-25c948f40fbmr693037fac.9.1718740971678;
        Tue, 18 Jun 2024 13:02:51 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 23/33] qmi: Make qmi_qrtr_node methods take struct qmi_qrtr_node
Date: Tue, 18 Jun 2024 15:02:05 -0500
Message-ID: <20240618200231.1129282-23-denkenz@gmail.com>
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
 drivers/qmimodem/qmi.c   | 64 ++++++++++++++++++----------------------
 drivers/qmimodem/qmi.h   | 12 ++++----
 plugins/qrtrqmi.c        | 10 +++----
 unit/test-qmimodem-qmi.c |  2 +-
 4 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index b5fb27c51a31..4dba8186c09d 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1915,7 +1915,7 @@ void qmi_qmux_device_set_debug(struct qmi_device *device,
 	__debug_data_init(&qmux->debug, func, user_data);
 }
 
-struct qmi_device_qrtr {
+struct qmi_qrtr_node {
 	struct qmi_device super;
 	struct debug_data debug;
 	struct {
@@ -1926,7 +1926,7 @@ struct qmi_device_qrtr {
 	} lookup;
 };
 
-static void __qrtr_lookup_finished(struct qmi_device_qrtr *node)
+static void __qrtr_lookup_finished(struct qmi_qrtr_node *node)
 {
 	if (!node->lookup.func) {
 		DEBUG(&node->debug, "No lookup in progress");
@@ -1942,11 +1942,11 @@ static void __qrtr_lookup_finished(struct qmi_device_qrtr *node)
 	memset(&node->lookup, 0, sizeof(node->lookup));
 }
 
-static int qmi_device_qrtr_write(struct qmi_device *device,
+static int qmi_qrtr_node_write(struct qmi_device *device,
 					struct qmi_request *req)
 {
-	struct qmi_device_qrtr *node =
-		l_container_of(device, struct qmi_device_qrtr, super);
+	struct qmi_qrtr_node *node =
+		l_container_of(device, struct qmi_qrtr_node, super);
 	struct sockaddr_qrtr addr;
 	uint8_t *data;
 	uint16_t len;
@@ -2001,7 +2001,7 @@ static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
 	debug->func(strbuf, debug->user_data);
 }
 
-static void qrtr_received_control_packet(struct qmi_device_qrtr *node,
+static void qrtr_received_control_packet(struct qmi_qrtr_node *node,
 						const void *buf, size_t len)
 {
 	struct qmi_device *device = &node->super;
@@ -2059,7 +2059,7 @@ static void qrtr_received_control_packet(struct qmi_device_qrtr *node,
 	l_timeout_modify(node->lookup.timeout, DISCOVER_TIMEOUT);
 }
 
-static void qrtr_received_service_message(struct qmi_device_qrtr *node,
+static void qrtr_received_service_message(struct qmi_qrtr_node *node,
 						uint32_t qrtr_node,
 						uint32_t qrtr_port,
 						const void *buf, size_t len)
@@ -2091,7 +2091,7 @@ static void qrtr_received_service_message(struct qmi_device_qrtr *node,
 
 static bool qrtr_received_data(struct l_io *io, void *user_data)
 {
-	struct qmi_device_qrtr *qrtr = user_data;
+	struct qmi_qrtr_node *qrtr = user_data;
 	struct sockaddr_qrtr addr;
 	unsigned char buf[2048];
 	ssize_t bytes_read;
@@ -2119,21 +2119,21 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 }
 
 static const struct qmi_device_ops qrtr_ops = {
-	.write = qmi_device_qrtr_write,
+	.write = qmi_qrtr_node_write,
 	.client_release = NULL,
 	.shutdown = NULL,
 };
 
-struct qmi_device *qmi_qrtr_node_new(uint32_t node)
+struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node)
 {
-	struct qmi_device_qrtr *qrtr;
+	struct qmi_qrtr_node *qrtr;
 	int fd;
 
 	fd = socket(AF_QIPCRTR, SOCK_DGRAM, 0);
 	if (fd < 0)
 		return NULL;
 
-	qrtr = l_new(struct qmi_device_qrtr, 1);
+	qrtr = l_new(struct qmi_qrtr_node, 1);
 
 	if (qmi_device_init(&qrtr->super, fd, &qrtr_ops) < 0) {
 		close(fd);
@@ -2143,19 +2143,15 @@ struct qmi_device *qmi_qrtr_node_new(uint32_t node)
 
 	l_io_set_read_handler(qrtr->super.io, qrtr_received_data, qrtr, NULL);
 
-	return &qrtr->super;
+	return qrtr;
 }
 
-void qmi_qrtr_node_free(struct qmi_device *device)
+void qmi_qrtr_node_free(struct qmi_qrtr_node *node)
 {
-	struct qmi_device_qrtr *node;
-
-	if (!device)
+	if (!node)
 		return;
 
-	__qmi_device_free(device);
-
-	node = l_container_of(device, struct qmi_device_qrtr, super);
+	__qmi_device_free(&node->super);
 
 	if (node->lookup.destroy)
 		node->lookup.destroy(node->lookup.user_data);
@@ -2163,47 +2159,42 @@ void qmi_qrtr_node_free(struct qmi_device *device)
 	l_free(node);
 }
 
-void qmi_qrtr_node_set_debug(struct qmi_device *device,
+void qmi_qrtr_node_set_debug(struct qmi_qrtr_node *node,
 				qmi_debug_func_t func, void *user_data)
 {
-	struct qmi_device_qrtr *node;
-
-	if (device == NULL)
+	if (!node)
 		return;
 
-	node = l_container_of(device, struct qmi_device_qrtr, super);
 	__debug_data_init(&node->debug, func, user_data);
 }
 
 static void qrtr_lookup_reply_timeout(struct l_timeout *timeout,
 							void *user_data)
 {
-	struct qmi_device_qrtr *node = user_data;
+	struct qmi_qrtr_node *node = user_data;
 
 	__qrtr_lookup_finished(node);
 }
 
-int qmi_qrtr_node_lookup(struct qmi_device *device,
+int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
 			qmi_qrtr_node_lookup_done_func_t func,
 			void *user_data, qmi_destroy_func_t destroy)
 {
-	struct qmi_device_qrtr *node;
 	struct qrtr_ctrl_pkt packet;
 	struct sockaddr_qrtr addr;
 	socklen_t addr_len;
 	ssize_t bytes_written;
 	int fd;
 
-	if (!device || !func)
+	if (!node || !func)
 		return -EINVAL;
 
-	node = l_container_of(device, struct qmi_device_qrtr, super);
 	if (node->lookup.func)
 		return -EALREADY;
 
 	DEBUG(&node->debug, "node %p", node);
 
-	fd = l_io_get_fd(device->io);
+	fd = l_io_get_fd(node->super.io);
 
 	/*
 	 * The control node is configured by the system. Use getsockname to
@@ -2246,13 +2237,14 @@ int qmi_qrtr_node_lookup(struct qmi_device *device,
 	return 0;
 }
 
-struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
+struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
 						uint32_t type)
 {
+	struct qmi_device *device = &node->super;
 	struct service_family *family;
 	const struct qmi_service_info *info;
 
-	if (!device)
+	if (!node)
 		return NULL;
 
 	if (type == QMI_SERVICE_CONTROL)
@@ -2272,12 +2264,12 @@ done:
 	return service_create(family);
 }
 
-bool qmi_qrtr_node_has_service(struct qmi_device *device, uint16_t type)
+bool qmi_qrtr_node_has_service(struct qmi_qrtr_node *node, uint16_t type)
 {
-	if (!device)
+	if (!node)
 		return false;
 
-	return __find_service_info_by_type(device, type);
+	return __find_service_info_by_type(&node->super, type);
 }
 
 struct qmi_param *qmi_param_new(void)
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index c85699d0e76f..6e6fc6912622 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -94,16 +94,16 @@ enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 bool qmi_device_set_expected_data_format(struct qmi_device *device,
 			enum qmi_device_expected_data_format format);
 
-struct qmi_device *qmi_qrtr_node_new(uint32_t node);
-void qmi_qrtr_node_free(struct qmi_device *device);
-void qmi_qrtr_node_set_debug(struct qmi_device *device,
+struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node);
+void qmi_qrtr_node_free(struct qmi_qrtr_node *node);
+void qmi_qrtr_node_set_debug(struct qmi_qrtr_node *node,
 				qmi_debug_func_t func, void *user_data);
-int qmi_qrtr_node_lookup(struct qmi_device *device,
+int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
 			qmi_qrtr_node_lookup_done_func_t func,
 			void *user_data, qmi_destroy_func_t destroy);
-struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
+struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
 						uint32_t type);
-bool qmi_qrtr_node_has_service(struct qmi_device *device, uint16_t type);
+bool qmi_qrtr_node_has_service(struct qmi_qrtr_node *node, uint16_t type);
 
 struct qmi_param;
 
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index f112043a1596..51e682f7e87c 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -45,7 +45,7 @@
 #include <drivers/qmimodem/util.h>
 
 struct qrtrqmi_data {
-	struct qmi_device *node;
+	struct qmi_qrtr_node *node;
 	struct qmi_service *dms;
 	int main_net_ifindex;
 	char main_net_name[IFNAMSIZ];
@@ -182,7 +182,7 @@ static void lookup_done(void *user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
-	struct qmi_device *node = data->node;
+	struct qmi_qrtr_node *node = data->node;
 
 	DBG("");
 
@@ -288,7 +288,7 @@ static void qrtrqmi_set_online(struct ofono_modem *modem, ofono_bool_t online,
 static void qrtrqmi_pre_sim(struct ofono_modem *modem)
 {
 	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
-	struct qmi_device *node = data->node;
+	struct qmi_qrtr_node *node = data->node;
 	struct qmi_service *voice;
 
 	DBG("%p", modem);
@@ -363,7 +363,7 @@ static void setup_gprs(struct ofono_modem *modem)
 static void qrtrqmi_post_sim(struct ofono_modem *modem)
 {
 	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
-	struct qmi_device *node = data->node;
+	struct qmi_qrtr_node *node = data->node;
 	struct qmi_service *wms;
 
 	DBG("%p", modem);
@@ -394,7 +394,7 @@ static void qrtrqmi_post_sim(struct ofono_modem *modem)
 static void qrtrqmi_post_online(struct ofono_modem *modem)
 {
 	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
-	struct qmi_device *node = data->node;
+	struct qmi_qrtr_node *node = data->node;
 
 	DBG("%p", modem);
 
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 12fab71ba271..2ff981391849 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -32,7 +32,7 @@
 
 struct test_info {
 	int service_fds[TEST_SERVICE_COUNT];
-	struct qmi_device *node;
+	struct qmi_qrtr_node *node;
 	struct l_timeout *timeout;
 
 	/* Data sent to our test service */
-- 
2.45.0

