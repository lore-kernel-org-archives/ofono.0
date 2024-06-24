Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD651A00FC
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257605; cv=none; b=mfGZ7ySdy3dERbarBHgN6/8fnrIDmlEhRDQUh7qjb3aBcaeZT+87UUkeeZQEhSd7MOQdoNux1jkH8cNzfB+TYnI0AUCEjR5l3rRnjmlY2MBdpcDWS6Xg9rp+MjSx5edhAvgw5QHrNnEpbGUOyirP6CJ7TBY873vcSfHUJdk2EvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257605; c=relaxed/simple;
	bh=2V/oC7KQKCCzTbiTvFv9wFM9B/EZpCVfUopqWN10q6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWbbKfNXegx4ox3fzReg+vFxByAas3Fm5ZyY9L9ALJhE9138Zt8uVECFrb/CDiDxsNc4MNH7OTJWaZaKafiiH6YVLAC56UKKgGT0ZrZQdAZ/zgEFczxJrIqpEo5nee2CyybRyasisL+NMRR0iZQrEuA4Fqkj2DELCv7/znreQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7O2oR3z; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7O2oR3z"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5bad217c51aso2527164eaf.1
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257603; x=1719862403; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXNJNwOT7xDihfLcVGWEuBZkot5I4i+LRBpJ29ZOu74=;
        b=h7O2oR3zMbGC6k0PgJSfTfgjOGvUqcB3RJC7bqTksF/3jnNlpmEc2wZ1yHEKiGNhpb
         o3DscmVDTq3IFek/boWbGAXndxb3z9AsH67380cj/OtsJW0cPFSw6XWHzGoX1sn+2ZTY
         V30KHauT8ilNOyxMAh25/uZOIklEkvIdGZSe/R2r/+Bdsnx6M3rA/bHmxuu/gwwpRLee
         iv5j1XOSDNaCp7kDLcT3mDZT8NYrH9gLXVhekmDoEDkMwozvnYqAhCIOe/g8CrDFJmev
         cNlaBfOdGaB1r+6msUTvcQE4w1Z7C8+bFqzztTPRXvWjdFgNnw2chLgZBR/A+5iuZYIm
         RoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257603; x=1719862403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXNJNwOT7xDihfLcVGWEuBZkot5I4i+LRBpJ29ZOu74=;
        b=oG6Z75hEzal3azFozGAF7YVl3Ho2ePjgks9ZyPTGesWzIxBf+8KzX+SCZsyIztxEsi
         tKFYG0y88uUSPR+3tq4GdE712lNRD8c1KeqOMtaGQ05s8c3yCv+cLm0KElqCw7vA9vbh
         x+xG5iPHiHVGDjVYoi+j/LumLFhudU5RLgx4bX9QtCFkOSQJjfzC3nWJh40G85A2Jq6V
         TJOKDAGdsr+Sg38ba40nxxMwUYCKah2OZ+6igSZxCScsFOQLbqKKaWKs5Da0NZ7doCzZ
         t0cs7kbI4qFoUs91MF+mKaODEnUxJgI8lFa6vjmHDDdCrVaG/MgMf0rAVlEYfdmr4g1Z
         1xlg==
X-Gm-Message-State: AOJu0YzMLC5xTpOCX4a5WVyl1iYrs/tslwP121b1deswZ4p7168mLU6i
	LrZTL0ybUTTFjkC7Po82U2jZ9OGhgaU3/fxkT8dw6c5F7NSJudMGOPBIag==
X-Google-Smtp-Source: AGHT+IGbQrRWfK0GaJQ61Z9fC40RvlFn7EFde/eg67j1lxke83fQJCUv9XKOhrp1/7xLVBmYylRdtw==
X-Received: by 2002:a4a:3c53:0:b0:5ba:2d65:3fa0 with SMTP id 006d021491bc7-5c1eed86fe9mr5547122eaf.6.1719257602937;
        Mon, 24 Jun 2024 12:33:22 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:22 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/13] qmi: Separate transport from qmux/qrtr debugging
Date: Mon, 24 Jun 2024 14:32:50 -0500
Message-ID: <20240624193315.1164943-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624193315.1164943-1-denkenz@gmail.com>
References: <20240624193315.1164943-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Functions that send and receive bytes on the QMI transport are quite
verbose (using hexdump, etc).  It might be desirable to output debug
information from the internal state of qmi_qrtr_node / qmi_qmux_device
without also outputing everything coming and going over the wire.

Add qmi_qmux_set_io_debug and qmi_qrtr_node_set_io_debug setters for
shuttling low-level transport debug information.  Update lower level rx
and tx path functions to use the transport debug handlers instead of the
ones on struct qmi_qrtr_node / struct qmi_qmux_device.
---
 drivers/qmimodem/qmi.c | 54 +++++++++++++++++++++++++++++-------------
 drivers/qmimodem/qmi.h |  4 ++++
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index d8fab9a34e5b..de2d3410a702 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -92,6 +92,7 @@ struct qmi_transport {
 	uint16_t next_service_tid;
 	struct l_hashmap *family_list;
 	const struct qmi_transport_ops *ops;
+	struct debug_data debug;
 	bool writer_active : 1;
 };
 
@@ -945,10 +946,10 @@ static int qmi_qmux_device_write(struct qmi_transport *transport,
 		return -errno;
 
 	l_util_hexdump(false, req->data, bytes_written,
-			qmux->debug.func, qmux->debug.user_data);
+			transport->debug.func, transport->debug.user_data);
 
 	__qmux_debug_msg(' ', req->data, bytes_written,
-				qmux->debug.func, qmux->debug.user_data);
+			transport->debug.func, transport->debug.user_data);
 
 	hdr = (struct qmi_mux_hdr *) req->data;
 
@@ -998,6 +999,7 @@ static void __rx_ctl_message(struct qmi_qmux_device *qmux,
 static bool received_qmux_data(struct l_io *io, void *user_data)
 {
 	struct qmi_qmux_device *qmux = user_data;
+	struct qmi_transport *transport = &qmux->transport;
 	struct qmi_mux_hdr *hdr;
 	unsigned char buf[2048];
 	ssize_t bytes_read;
@@ -1008,7 +1010,7 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 		return true;
 
 	l_util_hexdump(true, buf, bytes_read,
-			qmux->debug.func, qmux->debug.user_data);
+			transport->debug.func, transport->debug.user_data);
 
 	offset = 0;
 
@@ -1033,7 +1035,8 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 			break;
 
 		__qmux_debug_msg(' ', buf + offset, len,
-				qmux->debug.func, qmux->debug.user_data);
+				transport->debug.func,
+				transport->debug.user_data);
 
 		msg = buf + offset + QMI_MUX_HDR_SIZE;
 
@@ -1605,6 +1608,15 @@ void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 	__debug_data_init(&qmux->debug, func, user_data);
 }
 
+void qmi_qmux_device_set_io_debug(struct qmi_qmux_device *qmux,
+				qmi_debug_func_t func, void *user_data)
+{
+	if (!qmux)
+		return;
+
+	__debug_data_init(&qmux->transport.debug, func, user_data);
+}
+
 struct qmi_qrtr_node {
 	unsigned int next_group_id;	/* Matches requests with services */
 	struct l_queue *service_infos;
@@ -1663,8 +1675,6 @@ static void __qrtr_lookup_finished(struct qmi_qrtr_node *node)
 static int qmi_qrtr_node_write(struct qmi_transport *transport,
 					struct qmi_request *req)
 {
-	struct qmi_qrtr_node *node =
-		l_container_of(transport, struct qmi_qrtr_node, transport);
 	struct sockaddr_qrtr addr;
 	uint8_t *data;
 	uint16_t len;
@@ -1683,15 +1693,15 @@ static int qmi_qrtr_node_write(struct qmi_transport *transport,
 	bytes_written = sendto(fd, data, len, 0, (struct sockaddr *) &addr,
 							sizeof(addr));
 	if (bytes_written < 0) {
-		DEBUG(&node->debug, "sendto: %s", strerror(errno));
+		DEBUG(&transport->debug, "sendto: %s", strerror(errno));
 		return -errno;
 	}
 
 	l_util_hexdump(false, data, bytes_written,
-			node->debug.func, node->debug.user_data);
+			transport->debug.func, transport->debug.user_data);
 
 	__qrtr_debug_msg(' ', data, bytes_written,
-			req->info.service_type, &node->debug);
+			req->info.service_type, &transport->debug);
 
 	l_queue_push_tail(transport->service_queue, req);
 
@@ -1802,13 +1812,14 @@ static void qrtr_received_service_message(struct qmi_qrtr_node *node,
 		return;
 	}
 
-	__qrtr_debug_msg(' ', buf, len, service_type, &node->debug);
+	__qrtr_debug_msg(' ', buf, len, service_type, &transport->debug);
 	__rx_message(transport, service_type, 0, buf);
 }
 
 static bool qrtr_received_data(struct l_io *io, void *user_data)
 {
 	struct qmi_qrtr_node *qrtr = user_data;
+	struct debug_data *debug = &qrtr->transport.debug;
 	struct sockaddr_qrtr addr;
 	unsigned char buf[2048];
 	ssize_t bytes_read;
@@ -1818,14 +1829,13 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	bytes_read = recvfrom(l_io_get_fd(qrtr->transport.io),
 				buf, sizeof(buf), 0,
 				(struct sockaddr *) &addr, &addr_size);
-	DEBUG(&qrtr->debug, "Received %zd bytes from Node: %d Port: %d",
+	DEBUG(debug, "Received %zd bytes from Node: %d Port: %d",
 			bytes_read, addr.sq_node, addr.sq_port);
 
 	if (bytes_read < 0)
 		return true;
 
-	l_util_hexdump(true, buf, bytes_read,
-			qrtr->debug.func, qrtr->debug.user_data);
+	l_util_hexdump(true, buf, bytes_read, debug->func, debug->user_data);
 
 	if (addr.sq_port == QRTR_PORT_CTRL)
 		qrtr_received_control_packet(qrtr, buf, bytes_read);
@@ -1887,6 +1897,15 @@ void qmi_qrtr_node_set_debug(struct qmi_qrtr_node *node,
 	__debug_data_init(&node->debug, func, user_data);
 }
 
+void qmi_qrtr_node_set_io_debug(struct qmi_qrtr_node *node,
+				qmi_debug_func_t func, void *user_data)
+{
+	if (!node)
+		return;
+
+	__debug_data_init(&node->transport.debug, func, user_data);
+}
+
 static void qrtr_lookup_reply_timeout(struct l_timeout *timeout,
 							void *user_data)
 {
@@ -1904,6 +1923,7 @@ int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
 	socklen_t addr_len;
 	ssize_t bytes_written;
 	int fd;
+	struct debug_data *debug = &node->transport.debug;
 
 	if (!node || !func)
 		return -EINVAL;
@@ -1921,12 +1941,12 @@ int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
 	 */
 	addr_len = sizeof(addr);
 	if (getsockname(fd, (struct sockaddr *) &addr, &addr_len) < 0) {
-		DEBUG(&node->debug, "getsockname failed: %s", strerror(errno));
+		DEBUG(debug, "getsockname failed: %s", strerror(errno));
 		return -errno;
 	}
 
 	if (addr.sq_family != AF_QIPCRTR || addr_len != sizeof(addr)) {
-		DEBUG(&node->debug, "Unexpected sockaddr family: %d size: %d",
+		DEBUG(debug, "Unexpected sockaddr family: %d size: %d",
 				addr.sq_family, addr_len);
 		return -EIO;
 	}
@@ -1939,12 +1959,12 @@ int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
 				sizeof(packet), 0,
 				(struct sockaddr *) &addr, addr_len);
 	if (bytes_written < 0) {
-		DEBUG(&node->debug, "sendto failed: %s", strerror(errno));
+		DEBUG(debug, "sendto failed: %s", strerror(errno));
 		return -errno;
 	}
 
 	l_util_hexdump(false, &packet, bytes_written,
-			node->debug.func, node->debug.user_data);
+			debug->func, debug->user_data);
 
 	node->lookup.func = func;
 	node->lookup.user_data = user_data;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index db20280f9aa3..e61e9cc9e878 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -72,6 +72,8 @@ struct qmi_qmux_device *qmi_qmux_device_new(const char *device);
 void qmi_qmux_device_free(struct qmi_qmux_device *qmux);
 void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 				qmi_debug_func_t func, void *user_data);
+void qmi_qmux_device_set_io_debug(struct qmi_qmux_device *qmux,
+				qmi_debug_func_t func, void *user_data);
 int qmi_qmux_device_discover(struct qmi_qmux_device *qmux,
 				qmi_qmux_device_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
@@ -91,6 +93,8 @@ struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node);
 void qmi_qrtr_node_free(struct qmi_qrtr_node *node);
 void qmi_qrtr_node_set_debug(struct qmi_qrtr_node *node,
 				qmi_debug_func_t func, void *user_data);
+void qmi_qrtr_node_set_io_debug(struct qmi_qrtr_node *node,
+				qmi_debug_func_t func, void *user_data);
 int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
 			qmi_qrtr_node_lookup_done_func_t func,
 			void *user_data, qmi_destroy_func_t destroy);
-- 
2.45.0

