Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62ED1AE84C
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895130; cv=none; b=FJJX7rel5uHlM/DVj+OKvkX5vTMXp14UWp8vjoIxfvBsVVbBMU1udowHb8rQkuJ8367kD4u3qIBtO74qTduz7Z/tvGiQNrEMVLAHcE2+757yhoZNX0RfXrSpk8dI+931dsXbKzQK28UkF3ji4AAmTJM5LLDAiZAtfjj9JXHg7HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895130; c=relaxed/simple;
	bh=pc7fpAsAsiuZxj7t5AR0cYq1vzfBL8gcVddY2nGjWy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgqDjAM10p33MCDBDDS88c0DnZZ2azvXtX2EmwwTdSWnPmBmHOmfc/XyUtivleevQCRPey87ZU2dLU3b2FOmAy7l5/zRuErdfVD5U0P1QCAHQiLdNR466A7y2HRMhj7sdmixME2jK7+eEm4Gt/gTbqlbwx/fwUEutOcQ69fDKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrcmqDQ1; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrcmqDQ1"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d24724514eso540356b6e.0
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895128; x=1719499928; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypAt5+8b2tJbJH16Wx1FjGcxMq4OFcsPPY9I+akKiwI=;
        b=GrcmqDQ1g8XA8F+sVOMl1mQmQ4Dx4Db6wyYBZVfGK1L6D2M0nDzfrQXLXCyt6DagNS
         400Y5OLVt8GmJHEMbL0TGDRreBtX8pbEEtLsKo0oD59fQzYCcDtiOns4aO7f4peRyW2r
         Xp5ujWEaQw36iG5gsaiNj1C9bIWuCGGjhcCobjkW9bElI3WICIvYknQzo8RBKVpjcDfw
         qqxyxD1yA7YO/PQGjRImObGm0Hif3JxGeTbhIY963iJCD6Ax/uiDbAWvRzGnhPDYqjpy
         sqTERBBWTq5teIR1k5zjDvRNx9JmX84kxjrOjLXVaMstxGj4nwttUHZNsFhB5icQg/Kx
         42og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895128; x=1719499928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypAt5+8b2tJbJH16Wx1FjGcxMq4OFcsPPY9I+akKiwI=;
        b=LRluXdp6U70M0bAX9J9oRrc1GzSCAxKpcQXamHMQPHE5dKDAZGuu0HrZtDaALkiLsT
         harqKemT/M0Z4dBgoJkpOEsJw+VA0oDwp1orkwyZUQwB0tcH5yBhLLY5+4tesuyy5/qn
         u9QzCv162++JywmKMC5fvn4bsEYSlUj1DcF2OaxK7MIWEzYBeYstbRmG9q+oBQoDuEFk
         FaOcjMueakH7k9wbTmUeJLHbkulflg6PbW6QCiNxIpU0UEFQri6/RNNuVPWtHa42Gzj/
         GVpu2UVNYG6LUuQ0n0/4E6PpXq+NSMxzIEyYxeGM4awvsLyijio6rCiZuj2rwX5SU3r6
         /JgQ==
X-Gm-Message-State: AOJu0YxeqqbSInz1u4N6YnyYH9lylVBrXAFvsqwDpta4hlxLIMhr7msl
	LairsBTDFwImwnPMSUaeCbyVtJ1AgyZRRgq/QoXO0zBtmB/XzfoONObiQw==
X-Google-Smtp-Source: AGHT+IE6RdzQ1EOlr/1/dLF8ezJyQrqVlcYeP7f9JXvPO0lblkiDDGDx95Q+fYA7v9fY9WPRg7cLLg==
X-Received: by 2002:a05:6808:189b:b0:3d2:1759:7db1 with SMTP id 5614622812f47-3d51b96dca9mr6248685b6e.10.1718895127975;
        Thu, 20 Jun 2024 07:52:07 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:07 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 19/33] qmi: Convert DBG statements to __debug_device
Date: Thu, 20 Jun 2024 09:51:06 -0500
Message-ID: <20240620145139.1135899-19-denkenz@gmail.com>
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

