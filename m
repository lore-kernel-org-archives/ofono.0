Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09691174EC0
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333730; cv=none; b=gJYfRpmH435nMfyhaoRDFm2NxQusjliwSBj3/m58Y2chArzioA8t5cmyfJzZ0hkFtkYGSOPEgVUJb+TqbSntt9JR65cIQOspy2iSOjWb6uFFyVMOSzi++A+SRFd0MZo+LUuj1fsSOP8ShLOWsGfD8OaRJtoB/K6BaR6PLvuoK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333730; c=relaxed/simple;
	bh=HqrTWlPLfzO9qKEgcKbeoIloU98LR0/H19BpUtznX4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1wfGp9u2uJLLolH8a4O7hfTzZESNfhihBlNCKdmQzrGv/ux7kbnp13e/jAPa4YayguPiOVY746/ZDfJP5QT4Or/I84/P3/rN6PLAsAtQ2CXv9uzdOZTvp325QdBp3nN6Yeg4v3etb+1c3cJG5v4p51rsgBU5T8x6HIXRH9Cjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmFmyCSq; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmFmyCSq"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-700a6853664so2121893a34.1
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333728; x=1719938528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uc4UjTVkQoxnxpsdmRlaru0EVewRrLvUGFrVslChNw=;
        b=kmFmyCSqZDumdCC0AzALeNG/eP1QrCv0NFBfQIqZCkcQcZxABxqFipENTEaz12sUoN
         w5n73DcdA3/17L4fsQPJCkz82A5QFIxEG2DU+lxy/OkgU3VtVmGf2MPtL+Z4CbSYfAe2
         FCdgicL5ke6yA2EdLwEF9mVHZZ1jV4JZvL6PNXC0pceuXfCIUXaVH25Q/2jIKULZtGNR
         rBnZTgdWdYZncgpV6daOG0tRhw+8tY6zwAGrA9+8rZ6PgFH5KXY3QDpECkaHRHcL9j22
         FopH4kp81Vvjn0AQ/TPpUpE12nKwLXRG0NEOiBsP/x+HAzSzzcUX+nvVwB/pAp9DCBqq
         C85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333728; x=1719938528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uc4UjTVkQoxnxpsdmRlaru0EVewRrLvUGFrVslChNw=;
        b=smddyjf+3SNHJ6grmiz7ksa8cG62YVqhh+xuAHDPNbTstSxYsyJc87j6SVtO5H+nWZ
         alYdmpIqf65KU/E89Qh8OaBr7OXT8yXwAU5XF7DiEHR0RPdcMkkQps3UoLS16/Xb5iLu
         mytrqI5/lNx1REJwRlNoc2URTfiwfZI09rcWQhnFBZiTJC7XMss6AgOrP41kX0RFArOs
         3NtVZk1gLlOepDcoO1AZIB24WBCEc7mk+R8eAO4zrl4lJtWTdr6vUHxiWbF/hjHJSC/5
         TsPvoJ3ZmbpY/+xxPyumUrneOo7Ix8boixoPEnt8VNkikcX0fsszycXzubALf3uYRsYy
         31EQ==
X-Gm-Message-State: AOJu0YwMLt0jRqSnIYy3UTk2+VqP2cNtXx1en9ZSPdYM18uJCelDD+0A
	lltkd3ROEG7I2R7OuAKEm3yFtJb+eIbbFSnyIid+MC921Y7DMnwBlTH+vw==
X-Google-Smtp-Source: AGHT+IHin8i/7CVfESTTIc0ba8auWoTvWqGdoLQ8BrrnhflanBd/TPERL9SmYyr7uF92n0hZ9vXfWQ==
X-Received: by 2002:a05:6830:1002:b0:6f9:b69f:b64f with SMTP id 46e09a7af769-700afa4553dmr8138473a34.35.1719333727820;
        Tue, 25 Jun 2024 09:42:07 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:07 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 07/14] qmi: Separate transport from qmux/qrtr debugging
Date: Tue, 25 Jun 2024 11:41:43 -0500
Message-ID: <20240625164158.1170937-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240625164158.1170937-1-denkenz@gmail.com>
References: <20240625164158.1170937-1-denkenz@gmail.com>
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
without also outputting everything coming and going over the wire.

Add qmi_qmux_set_io_debug and qmi_qrtr_node_set_io_debug setters for
shuttling low-level transport debug information.  Update lower level rx
and tx path functions to use the transport debug handlers instead of the
ones on struct qmi_qrtr_node / struct qmi_qmux_device.
---
 drivers/qmimodem/qmi.c | 54 +++++++++++++++++++++++++++++-------------
 drivers/qmimodem/qmi.h |  4 ++++
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index f4af59a1b783..a2b5e652ef93 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -92,6 +92,7 @@ struct qmi_transport {
 	uint16_t next_service_tid;
 	struct l_hashmap *family_list;
 	const struct qmi_transport_ops *ops;
+	struct debug_data debug;
 	bool writer_active : 1;
 };
 
@@ -943,10 +944,10 @@ static int qmi_qmux_device_write(struct qmi_transport *transport,
 		return -errno;
 
 	l_util_hexdump(false, req->data, bytes_written,
-			qmux->debug.func, qmux->debug.user_data);
+			transport->debug.func, transport->debug.user_data);
 
 	__qmux_debug_msg(' ', req->data, bytes_written,
-				qmux->debug.func, qmux->debug.user_data);
+			transport->debug.func, transport->debug.user_data);
 
 	hdr = (struct qmi_mux_hdr *) req->data;
 
@@ -996,6 +997,7 @@ static void __rx_ctl_message(struct qmi_qmux_device *qmux,
 static bool received_qmux_data(struct l_io *io, void *user_data)
 {
 	struct qmi_qmux_device *qmux = user_data;
+	struct qmi_transport *transport = &qmux->transport;
 	struct qmi_mux_hdr *hdr;
 	unsigned char buf[2048];
 	ssize_t bytes_read;
@@ -1006,7 +1008,7 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 		return true;
 
 	l_util_hexdump(true, buf, bytes_read,
-			qmux->debug.func, qmux->debug.user_data);
+			transport->debug.func, transport->debug.user_data);
 
 	offset = 0;
 
@@ -1031,7 +1033,8 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 			break;
 
 		__qmux_debug_msg(' ', buf + offset, len,
-				qmux->debug.func, qmux->debug.user_data);
+				transport->debug.func,
+				transport->debug.user_data);
 
 		msg = buf + offset + QMI_MUX_HDR_SIZE;
 
@@ -1603,6 +1606,15 @@ void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
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
@@ -1661,8 +1673,6 @@ static void __qrtr_lookup_finished(struct qmi_qrtr_node *node)
 static int qmi_qrtr_node_write(struct qmi_transport *transport,
 					struct qmi_request *req)
 {
-	struct qmi_qrtr_node *node =
-		l_container_of(transport, struct qmi_qrtr_node, transport);
 	struct sockaddr_qrtr addr;
 	uint8_t *data;
 	uint16_t len;
@@ -1681,15 +1691,15 @@ static int qmi_qrtr_node_write(struct qmi_transport *transport,
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
 
@@ -1800,13 +1810,14 @@ static void qrtr_received_service_message(struct qmi_qrtr_node *node,
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
@@ -1816,14 +1827,13 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
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
@@ -1885,6 +1895,15 @@ void qmi_qrtr_node_set_debug(struct qmi_qrtr_node *node,
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
@@ -1902,6 +1921,7 @@ int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
 	socklen_t addr_len;
 	ssize_t bytes_written;
 	int fd;
+	struct debug_data *debug = &node->transport.debug;
 
 	if (!node || !func)
 		return -EINVAL;
@@ -1919,12 +1939,12 @@ int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
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
@@ -1937,12 +1957,12 @@ int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
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

