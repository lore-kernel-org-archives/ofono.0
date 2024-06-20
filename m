Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5841AE84E
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895134; cv=none; b=ICFzgjLoKTdur27LfJN3dpfteJsoVtQh7IM8xDxvEBhmfpcKrm/+uZ84ZlKfsz3CuNSDjKrMCm1blKTgAPh+PxI6oMuXmbcwqXiEQ4DbZLqqdZPBguUdThuaszILsBWiQpFvyy6HXuCzw8XiXGFEc82I8vvThQhsEcu6eKVhJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895134; c=relaxed/simple;
	bh=WF/beh672nIScZHr5DfZokSw0hn7GjHI5/2Jybcvxfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6l4IQNLoEQV/hSOVtdIdZ2rrgE1qjiVUAtzXVWdaf3Lwaw1NH/fLeKhNc5mEm23p0nAXUa3JOGdM4/HFjY0lM+ixRBWl3e4X4yO/Jgjea5vZHWiWsEDBvcBf9AJInHuwJ7j3r/b7FYSsmrHxEc3EfukEoCv4s4s+Ht5U0VKRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABLdGdnD; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABLdGdnD"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9cc681ee7so404996b6e.1
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895132; x=1719499932; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxtzOOSjma+dwnvC+zehsPWABOmiS6mckSCt94NLhME=;
        b=ABLdGdnDz9ELwBN1tdr842nZZm7NLzP6e7RtELurR9wLGMT1amJkDqfXSyqTki2mDA
         0qZFDWNLfu48kqEHPh6gZnkGkNrthfJNVzFH3wwc6mR44Xjd4LxbBmuaDpwoJ+dUidYl
         ddIA7eNv+1eUmMwc8KKr5txLrP5CQpKT5LeVdJ4VZ2wfesx1xY+oKl4Yg9Yu3abiwYxJ
         f9Ody8/7uE8pyslBQPmZtwf3XHkqyZjoYfM/J3XojwOsAQfk1FNSOskM1L61Zw0cB305
         HWx33ZlAF782n9iKfJpyKp/Sv206OckakueczoiRXulib2LXJiwSRLxX1S5tvK7YWKgv
         ZT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895132; x=1719499932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxtzOOSjma+dwnvC+zehsPWABOmiS6mckSCt94NLhME=;
        b=WhiLp19i5xW1YupjcYDqDbndyDy8YwJm2BwyTDNONkvCippDGd0jBlX2V1vSouBjcS
         wdRK30qTkpmhzzmNh+nga16Dxigb2YnH4uwnMGkcNIAIVO76twpGI5uKuXh/xFOSxrV7
         UCgYpZGF6g8aI5V9SGowUuLZYTuqgV3EhX1msJxVMF6yo3Piysl4OCeAcjBL/UZdqV1Y
         hnFs8sEIubtjuNNrslSuOlJbREN3vPioCEOiI1eKC3XjtVZlLh1Hh772XOJHXKBxcSD5
         1E/vnHeFAS7A+3MN904J9GlA4/PcbgYLr8c1MTrzn8HJ/NF5qZ2JonZK2GCibrIEg6OR
         I3TA==
X-Gm-Message-State: AOJu0YydLcY/AmvLkguAkBlxLOW95Akfy6zeYfoR3FQEhyjGp29reRn2
	PaSjjxbE4tT78sIbTQWhZEodJLpe2Hj2wETv38CYDEg+9I4Am1rVXKfmNA==
X-Google-Smtp-Source: AGHT+IGS2r1JspiAJsROPwCcYq+79Dk0khcRmoksUznTUrQCmDFDcKOMHa4pYhsfA9h9SjOn6o//DQ==
X-Received: by 2002:a05:6808:2006:b0:3d2:1c7b:e64 with SMTP id 5614622812f47-3d51b6d344dmr2660824b6e.25.1718895131659;
        Thu, 20 Jun 2024 07:52:11 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:11 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 23/33] qmi: Make qmi_qrtr_node methods take struct qmi_qrtr_node
Date: Thu, 20 Jun 2024 09:51:10 -0500
Message-ID: <20240620145139.1135899-23-denkenz@gmail.com>
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
index 114c9bcb85cc..cf04d05f65cc 100644
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

