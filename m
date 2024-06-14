Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5CF1A2C12
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391199; cv=none; b=V+xeXSFCPNYx1u6NwiWm2j8ZGj913qZXCixaS/3Izll0GH2yUU4BN9ROm+2YKCJjC9uRo38K419I3Lodh64oOUhBeG/ywpSiSbCeE9TeprPzG0Ibg9em1fVVF0K6DN+bSV/iRvrfrUuwL9Lwyz5ioNr9hz+vAtUjQRRXdieypu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391199; c=relaxed/simple;
	bh=pc7fpAsAsiuZxj7t5AR0cYq1vzfBL8gcVddY2nGjWy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmiIXvs0RaiF95T1xrmiCvmjFmz33Hkml364ykm4tgdkvsLbbFSibQcw9QxkWxlDB3rrsiwxKwlAXnTjureapcSwM7Bl00eUWPPvcE5Hr/EuoyRMKORk+dq7wPl2jSIzMeMojc5IDOJhrN+4SYH+/bJGBh0c/P1fHWMshEzc9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEXEfh1i; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEXEfh1i"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f971cb3c9cso1315378a34.1
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391196; x=1718995996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypAt5+8b2tJbJH16Wx1FjGcxMq4OFcsPPY9I+akKiwI=;
        b=FEXEfh1izyllIxjxMAJm5XLNIYQR9wlvynhgitNaGiqRE6npMzeh2z6x844avJ3OF2
         cXgJDDbfOGPSOi0HggDeJm47coPKzCOc+Sz++WtbwNG2btG6XnR6HkK1BFIaASFONK6a
         zX6FgxZMX+Y4ii5YFi1bONp1p1SAJHYzyxd5q1EuW04HUyzCNljGg0tI5qIHQI/1Ku9U
         1FNPMNfQGJQOiTX74uX6ta91WjRHI5QLvIPux1VqI+y1ZKO9l26tXj1bletAUyG06PCm
         Gn3iVuZFOsXSbujPYvRsChkuXdr8ciQDSD0B80pBNCBwO0L38Qqet6RonEfZQiMhpSXa
         OcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391196; x=1718995996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypAt5+8b2tJbJH16Wx1FjGcxMq4OFcsPPY9I+akKiwI=;
        b=kx8UEi8/t7wslhKhdu4AX4ZDeU89iKyDVbH4skjQ9TSbWEc/DO0a1FyFcot+R0FZ32
         Zio7892Q0aj/RyTQE5268NZ+yEt3I6DYRoyRC8q5bbUeIiqIRqkQeBZR6Ewh2ED94Q5U
         32GHvvIyP7v4tEgDwaqZQyrtmAbPikbVowrFSFL/vm/KbPwIp11DIIsaOl2HKQxLH00B
         rGVyADu/5RKHMlvQQSwveJTvAXTXcFcZfNfQPwZ7fmIT7DXjDCN22YpdddK9fFTq0td4
         eolSnqJspJjtSoY57qPZ0DYTtAGuqYagUdENWdQD+y3gE0OW2Qk75XDhdW6gzfCAmmAB
         zXMQ==
X-Gm-Message-State: AOJu0Yw7YoO8l7XMMUGq/nh3usXF2MNvhI7HNE5IRFSNcHwRzkhJsRPd
	mQfafqloEiJSFhHW6OWGLrXqliioMSN5hMmS9t8PDWGwhiZdjPHs9bg1QA==
X-Google-Smtp-Source: AGHT+IE5Kf6WIWw0mi01BfYYlhyxv1kqYKNB7Qm5Kydcu9AByiKsAFjZsSORFO88nIRCfI8j0jDYiw==
X-Received: by 2002:a05:6870:1494:b0:254:b1b1:7ea4 with SMTP id 586e51a60fabf-25842893a01mr3813727fac.12.1718391196565;
        Fri, 14 Jun 2024 11:53:16 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:16 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 18/27] qmi: Convert DBG statements to __debug_device
Date: Fri, 14 Jun 2024 13:52:30 -0500
Message-ID: <20240614185300.1086701-18-denkenz@gmail.com>
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
 drivers/qmimodem/qmi.c | 53 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 509f3dda5945..d0f8a56f1461 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1942,7 +1942,7 @@ static int qmi_device_qrtr_write(struct qmi_device *device,
 	bytes_written = sendto(fd, data, len, 0, (struct sockaddr *) &addr,
 							sizeof(addr));
 	if (bytes_written < 0) {
-		DBG("Failure sending data: %s", strerror(errno));
+		__debug_device(device, "sendto: %s", strerror(errno));
 		return -errno;
 	}
 
@@ -1990,20 +1990,19 @@ static void qrtr_received_control_packet(struct qmi_device *device,
 	uint32_t type;
 	uint32_t instance;
 	uint32_t version;
-	uint32_t node;
-	uint32_t port;
+	uint32_t qrtr_node;
+	uint32_t qrtr_port;
 
 	if (len < sizeof(*packet)) {
-		DBG("qrtr packet is too small");
+		__debug_device(device, "qrtr packet is too small");
 		return;
 	}
 
-	qrtr_debug_ctrl_request(packet, device->debug_func,
-				device->debug_data);
+	qrtr_debug_ctrl_request(packet, device->debug_func, device->debug_data);
 
 	cmd = L_LE32_TO_CPU(packet->cmd);
 	if (cmd != QRTR_TYPE_NEW_SERVER) {
-		DBG("Unknown command: %d", cmd);
+		__debug_device(device, "Unknown command: %d", cmd);
 		return;
 	}
 
@@ -2011,7 +2010,8 @@ static void qrtr_received_control_packet(struct qmi_device *device,
 
 	if (!packet->server.service && !packet->server.instance &&
 			!packet->server.node && !packet->server.port) {
-		DBG("Initial service discovery has completed");
+		__debug_device(device,
+				"Initial service discovery has completed");
 
 		if (data)
 			DISCOVERY_DONE(data, data->user_data);
@@ -2025,16 +2025,17 @@ static void qrtr_received_control_packet(struct qmi_device *device,
 	version = L_LE32_TO_CPU(packet->server.instance) & 0xff;
 	instance = L_LE32_TO_CPU(packet->server.instance) >> 8;
 
-	node = L_LE32_TO_CPU(packet->server.node);
-	port = L_LE32_TO_CPU(packet->server.port);
+	qrtr_node = L_LE32_TO_CPU(packet->server.node);
+	qrtr_port = L_LE32_TO_CPU(packet->server.port);
 
-	DBG("New server: Type: %d Version: %d Instance: %d Node: %d Port: %d",
-		type, version, instance, node, port);
+	__debug_device(device,
+			"New server: %d Version: %d Node/Port: %d/%d",
+			type, version, qrtr_node, qrtr_port);
 
 	memset(&info, 0, sizeof(info));
 	info.service_type = type;
-	info.qrtr_port = port;
-	info.qrtr_node = node;
+	info.qrtr_port = qrtr_port;
+	info.qrtr_node = qrtr_node;
 	info.major = version;
 	info.instance = instance;
 
@@ -2049,7 +2050,8 @@ static void qrtr_received_control_packet(struct qmi_device *device,
 }
 
 static void qrtr_received_service_message(struct qmi_device *device,
-						uint32_t node, uint32_t port,
+						uint32_t qrtr_node,
+						uint32_t qrtr_port,
 						const void *buf, size_t len)
 {
 	const struct l_queue_entry *entry;
@@ -2059,15 +2061,16 @@ static void qrtr_received_service_message(struct qmi_device *device,
 				entry; entry = entry->next) {
 		struct qmi_service_info *info = entry->data;
 
-		if (info->qrtr_node == node && info->qrtr_port == port) {
+		if (info->qrtr_node == qrtr_node &&
+				info->qrtr_port == qrtr_port) {
 			service_type = info->service_type;
 			break;
 		}
 	}
 
 	if (!service_type) {
-		DBG("Received msg from unknown service on node: %d, port: %d",
-			node, port);
+		__debug_device(device, "Message from unknown at node/port %d/%d",
+				qrtr_node, qrtr_port);
 		return;
 	}
 
@@ -2088,8 +2091,8 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	addr_size = sizeof(addr);
 	bytes_read = recvfrom(l_io_get_fd(qrtr->super.io), buf, sizeof(buf), 0,
 				(struct sockaddr *) &addr, &addr_size);
-	DBG("Received %zd bytes from Node: %d Port: %d", bytes_read,
-		addr.sq_node, addr.sq_port);
+	__debug_device(&qrtr->super, "Received %zd bytes from Node: %d Port: %d",
+			bytes_read, addr.sq_node, addr.sq_port);
 
 	if (bytes_read < 0)
 		return true;
@@ -2152,14 +2155,15 @@ static int qmi_device_qrtr_discover(struct qmi_device *device,
 	addr_len = sizeof(addr);
 	rc = getsockname(fd, (struct sockaddr *) &addr, &addr_len);
 	if (rc) {
-		DBG("getsockname failed: %s", strerror(errno));
+		__debug_device(device, "getsockname failed: %s",
+				strerror(errno));
 		rc = -errno;
 		goto error;
 	}
 
 	if (addr.sq_family != AF_QIPCRTR || addr_len != sizeof(addr)) {
-		DBG("Unexpected sockaddr from getsockname. family: %d size: %d",
-			addr.sq_family, addr_len);
+		__debug_device(device, "Unexpected sockaddr family: %d size: %d",
+				addr.sq_family, addr_len);
 		rc = -EIO;
 		goto error;
 	}
@@ -2172,7 +2176,8 @@ static int qmi_device_qrtr_discover(struct qmi_device *device,
 				sizeof(packet), 0,
 				(struct sockaddr *) &addr, addr_len);
 	if (bytes_written < 0) {
-		DBG("Failure sending data: %s", strerror(errno));
+		__debug_device(device, "Failure sending data: %s",
+				strerror(errno));
 		rc = -errno;
 		goto error;
 	}
-- 
2.45.0

