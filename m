Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1116DED1
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740971; cv=none; b=AaWvqwxq5nHmFz2nU2jyWjC/01GV253ow/A/IS98c6fM9kxK3Rp58LPM+6t9qL5/CtCy665gQ6FMBUtUrSyWQ4tGrWetMQSkCS2Pf00o2VdFMwghdMHpstYPQaFK9Tyk0vTvYHLeAtCJr6RbucA8ljKcwvI3KjxbuvwDnQ01+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740971; c=relaxed/simple;
	bh=pc7fpAsAsiuZxj7t5AR0cYq1vzfBL8gcVddY2nGjWy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfJnynKi4D+GKJfeOyENVgUcJBP/W8uH0nuhlietixFkWZ+J4pK1bZJZjBv019WYVu+wu12fCDI2nV9+0s5qgeoBdjtnnCKowGxfgQw/kKUY7ZcPLQpNuC6GfevHOx3XVT1jzavNicNFO07MxNEvC+Kpj8tm+0k4p5WfuQZwJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB+cpYeN; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB+cpYeN"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2506fc3a6cfso2841648fac.2
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740969; x=1719345769; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypAt5+8b2tJbJH16Wx1FjGcxMq4OFcsPPY9I+akKiwI=;
        b=PB+cpYeNzyQ6JhcrLS5e0D1IRje9eBVedjInvUpCg3NxofT52C+09bpkuxhN1V6pxK
         JcjTJWPc20PE7Dvw1A8kTfOw8fDSFIPzStd4Br+nRYqABeQ8ERl0D/YD5OIuHfOlHIEi
         +L/nrFGecWVb9gJCKQVOK1qpTt0M1C5bFfjutiOtmzOVj1/jfv0ow/0pMyHf1x2UZWTY
         HGH6DlSduO2IHVKqHfWSy1njTVYOKkJCaT4XScfQh6/dSX3505jxqNIC5lU4ic38QeXM
         +hoATtCwo45S+vXuAohDN8Ea9Js0joupLW+Z+qOvnhAnTT/LEN8F7tQ73pIqkNXWBv0o
         UjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740969; x=1719345769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypAt5+8b2tJbJH16Wx1FjGcxMq4OFcsPPY9I+akKiwI=;
        b=Fv0hL6cY2NH98uq5FsqI2Ubf5vCsC5HGrkHlevxAo+HYW90Os/199+y04EjlkOO0CA
         ZzEkRqmERHLGr2T3uy0n3e49nANaLs4MgQrX0WfjpsBeZIqyBA9KcWPOzn7aYeptGCg0
         am4E6RzAITnpVOSY5SfaEtAMevBq7e/Qc7SlU7KQMct4mKDNDbznG/wGJUxYBdeo58uw
         YvntGU/5pRL9aGVNwMpySa9QQmChaN2QFhgCfRiLkUUf6fa0baD7zmTv+hv5urLd+cqj
         g3I8V/FkLF8yQ+Aja4mbnYwmxeglW7DpY+hG2ijpnKnIagTCfcCCfsFbc3ily5LwKUye
         BiJA==
X-Gm-Message-State: AOJu0YzlVWPLSb1ORZLaJSaz3/Vx52L+sgdl1UaCJp4no0122AQcQZ6s
	SACM47u/qaOw81OH12HsrjYhuE2a0mjAfvS3neeMMkV0xv8GyGV4y0VY+Q==
X-Google-Smtp-Source: AGHT+IH3Y8qAVJlw4tcP8C8YNTeaIol9tLX3tIKHkWFWKxeBCvJsPebGOZUqsjAoNYRhf3gxtCV80w==
X-Received: by 2002:a05:6871:3a23:b0:259:8aef:db3a with SMTP id 586e51a60fabf-25c94a0e4d9mr931201fac.29.1718740968462;
        Tue, 18 Jun 2024 13:02:48 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 19/33] qmi: Convert DBG statements to __debug_device
Date: Tue, 18 Jun 2024 15:02:01 -0500
Message-ID: <20240618200231.1129282-19-denkenz@gmail.com>
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

