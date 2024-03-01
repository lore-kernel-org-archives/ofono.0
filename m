Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA759B47
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331548; cv=none; b=DFVDdbiz5PGXL+CvYVX2Vfk3YLdUcYg9JIwSrp8HeOgwtfandN0/9Hb/+w7Vv2eO9xk+9gIe3UWfAlwxeGGDpaTEIswhDKHhvHQijOE/p2hPy9r0uF1/vYHBi7Jqn3Hk/GYEk2/UzhhLtle4CBLVO4Pep5PCD3JvK+LvG8LY12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331548; c=relaxed/simple;
	bh=DbYSjLuUCMFNPXs75vX0WyKVL1iXV00m4dt2BRNrRt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgZE1dnfptKpyhrShV88iwHHVpylhfeOq25EQLsA73NgBJGtLcVe52m0FFgGX71KI4mP0CDsLKngIALEwsRqXJ0IhOuua32LuJKnPFffJt+DRimh0peQxyrKJSy5Jqt+bzMflT/bRXpNZCO+eimi1YWCDZvWuWsL2vQdh6M+jSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=C2JJHHrn; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=nRmw1Pg8; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="C2JJHHrn";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="nRmw1Pg8"
Received: from pps.filterd (m0286616.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421H8dR0003242
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 14:19:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=gqht7k2Z4GlK4raYu0S+bk
	+KiAT1T13/Tx0jjfYu9mM=; b=C2JJHHrn9a9Ma3LwFaDJY6wov3Et03TdvR1lJ6
	Wz+BjtKIkfKZfdQteCFj1UkNe7rw0BScqFw4gzrjUYYFQpImP+BbsU6uvIWnbwRk
	h0QDMa0z4arRU51YVnPAf0DUAJH6zSLSqUG/pdJP/nhbs4zJWTZel4ueKUWma3I8
	CUZtDwPkSxvDqnvNMi8BWXCtR2grpR4VMOtomGooU4A1hhrF2PFUnmHdyhn4l32R
	hoXW/rWbd9aVbYirKjLoBDFpv32+kDchGFRKhFSLK0PAavNZwxuC6wFOapOeDaRI
	bK4fHlt/F69hN1S+FX5objLsWRpIdHZin4ZvsqzH6EpJbbew==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wkk5mrbb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 14:19:05 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3653092aee9so28998825ab.0
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 14:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709331544; x=1709936344; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqht7k2Z4GlK4raYu0S+bk+KiAT1T13/Tx0jjfYu9mM=;
        b=nRmw1Pg8HOl/k5Axd2DUPnJzDcKlB0D+h+4ygnB7gidYTrfBCRQW2QVr79kahv3XKL
         5r1vams/8+ScgSkVOJh9MTekQB5tU0QZCr7SgSQiS3UNVTC5p3MNNXiFRJ9I3b6MJdwQ
         Xkg3ScCnVTND82aiyLi+/Czc/JqQVesMcWMe9SKWkaXRMlSp997AA7kiUQIG4FeglkLT
         W1bgdSx0vUt57tHCP7lkO9UGjLJiZNgMw4uxW1yXtuL1z7hbHZqWE9YX3z2ZMF7RoRry
         jZ99eVOnKy4YdrZmop+YV/BgYktEKqNMYUX6mgpST/pdLjkwu1cKkY8ddooy/GS4RkCo
         MU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331544; x=1709936344;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqht7k2Z4GlK4raYu0S+bk+KiAT1T13/Tx0jjfYu9mM=;
        b=Bugf4vdLT1DtHMQZ19cMl/AMA5R87u1mfoKwDycn0JqehQ19ecN49uQVlqFUfpGAPG
         JpAfaKjX3xfrGvzJphaw3m74ZVTTX33ibBIyGw8JgKEpUaev8NYeyBLzD08ES1J8XDdC
         RA7UrDt5HMPVOOuSLLyHYb8nMdCs9THUvKsGpUurPQnjI0kV+EW/OxSwBy5uq5yeK4Yd
         NYAoMKmLgWlcIVOzm4ZfHlxblYIr3cveziy1c4tVfKD9byKwWRYABqmvBNMF+801wfFR
         Ku7K4LpmFPsO7PsTbHRug/K9aO5zPiTr2S3b1sBRbE84zh2GLSA46wGXGe9HRBDdUkAq
         SCSg==
X-Gm-Message-State: AOJu0YyyubQhzDvChgREpX2a0u9r1DE67zbo1nnZ2EnpDPkZekJjWsVz
	p8F3rhSgtqoJQi6DNRmXZPzY991BHSfh1K2cFxo2SPDEOAAgSwDdk3V6AKe+eM4XH0aXleG05Xr
	g+dnkPRLV3SwSTuRgeuISD2s8q871RBrl33UsSvlvLL7ySa25mnYgnEY9CsgC9M/0uz2uxBZNFb
	3StKm7vdQWvwqBfjoVYBjfS4RuBt9jV9pJhvz2o0jW5lb3eWg=
X-Received: by 2002:a05:6e02:1c43:b0:365:b93f:a33 with SMTP id d3-20020a056e021c4300b00365b93f0a33mr3717258ilg.20.1709331543909;
        Fri, 01 Mar 2024 14:19:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhe3FrYInW80Hi99ALd8gY9UHp4ULbqSr5T1cG7c9A5A5YtCx63SbnsTpU1uqYpXzGYHuUdQ==
X-Received: by 2002:a05:6e02:1c43:b0:365:b93f:a33 with SMTP id d3-20020a056e021c4300b00365b93f0a33mr3717236ilg.20.1709331543519;
        Fri, 01 Mar 2024 14:19:03 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id g13-20020a92d7cd000000b003639d3e5afdsm1127808ilq.10.2024.03.01.14.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:19:02 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v3 4/4] qmi: Enable QRTR service writes and reads
Date: Fri,  1 Mar 2024 16:18:48 -0600
Message-ID: <20240301221851.1445586-4-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301221851.1445586-1-steve.schrock@getcruise.com>
References: <20240301221851.1445586-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: _wlVL4deaAHnu0JenUu1n3y-WINZ96-7
X-Proofpoint-ORIG-GUID: _wlVL4deaAHnu0JenUu1n3y-WINZ96-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=992
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010184

For simplicity the QRTR write method simply skips the QMUX
header. In the future it might make sense to add another ops
function that would allocate a larger buffer and populate
the QMUX header in the QMUX implementation.
---
 drivers/qmimodem/qmi.c | 118 +++++++++++++++++++++++++++++++++--------
 1 file changed, 97 insertions(+), 21 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c65860ce..8e849b75 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -62,7 +62,7 @@ struct qmi_service_info {
 struct qmi_request {
 	uint16_t tid;
 	unsigned int group_id;		/* Always 0 for control */
-	uint8_t client;
+	uint8_t client;			/* Always 0 for control and qrtr */
 	struct qmi_service_info info;	/* Not used for control requests */
 	qmi_message_func_t callback;
 	void *user_data;
@@ -216,7 +216,7 @@ static void __qmi_service_appeared(struct qmi_device *device,
 				l_memdup(info, sizeof(struct qmi_service_info)));
 }
 
-static struct qmi_request *__request_alloc(uint8_t service,
+static struct qmi_request *__request_alloc(uint32_t service_type,
 				uint8_t client, uint16_t message,
 				const void *data,
 				uint16_t length, qmi_message_func_t func,
@@ -228,7 +228,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	uint16_t hdrlen = QMI_MUX_HDR_SIZE;
 	uint16_t msglen;
 
-	if (service == QMI_SERVICE_CONTROL)
+	if (service_type == QMI_SERVICE_CONTROL)
 		hdrlen += QMI_CONTROL_HDR_SIZE;
 	else
 		hdrlen += QMI_SERVICE_HDR_SIZE;
@@ -244,7 +244,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	hdr->frame = 0x01;
 	hdr->length = L_CPU_TO_LE16(req->len - 1);
 	hdr->flags = 0x00;
-	hdr->service = service;
+	hdr->service = service_type; /* qmux service types are 8 bits */
 	hdr->client = client;
 
 	msg = (struct qmi_message_hdr *) &req->data[hdrlen];
@@ -654,6 +654,26 @@ static void __qmux_debug_msg(const char dir, const void *buf, size_t len,
 			L_LE16_TO_CPU(hdr->length), function, user_data);
 }
 
+static void __qrtr_debug_msg(const char dir, const void *buf, size_t len,
+				uint16_t service_type,
+				qmi_debug_func_t function, void *user_data)
+{
+	const struct qmi_service_hdr *srv;
+	const struct qmi_message_hdr *msg;
+	uint16_t tid;
+
+	if (!len)
+		return;
+
+	srv = buf;
+	msg = buf + QMI_SERVICE_HDR_SIZE;
+
+	tid = L_LE16_TO_CPU(srv->transaction);
+
+	__debug_msg(dir, msg, service_type, srv->type, tid, 0, len,
+						function, user_data);
+}
+
 static void __debug_device(struct qmi_device *device,
 					const char *format, ...)
 {
@@ -762,7 +782,7 @@ static unsigned int service_list_create_hash(uint16_t service_type,
 }
 
 static void handle_indication(struct qmi_device *device,
-			uint8_t service_type, uint8_t client_id,
+			uint32_t service_type, uint8_t client_id,
 			uint16_t message, uint16_t length, const void *data)
 {
 	struct qmi_service *service;
@@ -795,7 +815,7 @@ static void handle_indication(struct qmi_device *device,
 }
 
 static void __rx_message(struct qmi_device *device,
-				uint8_t service_type, uint8_t client_id,
+				uint32_t service_type, uint8_t client_id,
 				const void *buf)
 {
 	const struct qmi_service_hdr *service = buf;
@@ -1935,6 +1955,43 @@ struct qmi_device_qrtr {
 	struct l_idle *shutdown_idle;
 };
 
+static int qmi_device_qrtr_write(struct qmi_device *device,
+					struct qmi_request *req)
+{
+	struct sockaddr_qrtr addr;
+	uint8_t *data;
+	uint16_t len;
+	ssize_t bytes_written;
+	int fd = l_io_get_fd(device->io);
+
+	/* Skip the QMUX header */
+	data = req->data + QMI_MUX_HDR_SIZE;
+	len = req->len - QMI_MUX_HDR_SIZE;
+
+	memset(&addr, 0, sizeof(addr));	/* Ensures internal padding is 0 */
+	addr.sq_family = AF_QIPCRTR;
+	addr.sq_node = req->info.qrtr_node;
+	addr.sq_port = req->info.qrtr_port;
+
+	bytes_written = sendto(fd, data, len, 0, (struct sockaddr *) &addr,
+							sizeof(addr));
+	if (bytes_written < 0) {
+		DBG("Failure sending data: %s", strerror(errno));
+		return -errno;
+	}
+
+	l_util_hexdump(false, data, bytes_written,
+			device->debug_func, device->debug_data);
+
+	__qrtr_debug_msg(' ', data, bytes_written,
+			req->info.service_type, device->debug_func,
+			device->debug_data);
+
+	l_queue_push_tail(device->service_queue, req);
+
+	return 0;
+}
+
 static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
 					qmi_debug_func_t function,
 					void *user_data)
@@ -1957,10 +2014,10 @@ static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
 	function(strbuf, user_data);
 }
 
-static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
-					const struct qrtr_ctrl_pkt *packet)
+static void qrtr_received_control_packet(struct qmi_device *device,
+						unsigned char *buf, size_t len)
 {
-	struct qmi_device *device = &qrtr->super;
+	struct qrtr_ctrl_pkt *packet = (struct qrtr_ctrl_pkt *) buf;
 	uint32_t cmd;
 	uint32_t type;
 	uint32_t instance;
@@ -1968,6 +2025,11 @@ static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
 	uint32_t node;
 	uint32_t port;
 
+	if (len < sizeof(*packet)) {
+		DBG("qrtr packet is too small");
+		return;
+	}
+
 	qrtr_debug_ctrl_request(packet, device->debug_func,
 				device->debug_data);
 
@@ -2013,22 +2075,32 @@ static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
 	}
 }
 
-static void qrtr_handle_packet(struct qmi_device_qrtr *qrtr, uint32_t sending_port,
-				const void *buf, ssize_t len)
+static void qrtr_received_service_message(struct qmi_device *device,
+			uint32_t port, const unsigned char *buf, size_t len)
 {
-	const struct qrtr_ctrl_pkt *packet = buf;
+	const struct l_queue_entry *entry;
+	uint32_t service_type = 0;
 
-	if (sending_port != QRTR_PORT_CTRL) {
-		DBG("Receive of service data is not implemented");
-		return;
+	for (entry = l_queue_get_entries(device->service_infos);
+				entry; entry = entry->next) {
+		struct qmi_service_info *info = entry->data;
+
+		if (info->qrtr_port == port) {
+			service_type = info->service_type;
+			break;
+		}
 	}
 
-	if ((unsigned long) len < sizeof(*packet)) {
-		DBG("qrtr control packet is too small");
+	if (!service_type) {
+		DBG("Received packet from unknown service on port %d",
+			port);
 		return;
 	}
 
-	qrtr_handle_control_packet(qrtr, packet);
+	__qrtr_debug_msg(' ', buf, len, service_type,
+				device->debug_func, device->debug_data);
+
+	__rx_message(device, service_type, 0, buf);
 }
 
 static bool qrtr_received_data(struct l_io *io, void *user_data)
@@ -2042,7 +2114,7 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	addr_size = sizeof(addr);
 	bytes_read = recvfrom(l_io_get_fd(qrtr->super.io), buf, sizeof(buf), 0,
 				(struct sockaddr *) &addr, &addr_size);
-	DBG("Received %zd bytes from Node: %d Port: 0x%x", bytes_read,
+	DBG("Received %zd bytes from Node: %d Port: %d", bytes_read,
 		addr.sq_node, addr.sq_port);
 
 	if (bytes_read < 0)
@@ -2051,7 +2123,11 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	l_util_hexdump(true, buf, bytes_read, qrtr->super.debug_func,
 			qrtr->super.debug_data);
 
-	qrtr_handle_packet(qrtr, addr.sq_port, buf, bytes_read);
+	if (addr.sq_port == QRTR_PORT_CTRL)
+		qrtr_received_control_packet(&qrtr->super, buf, bytes_read);
+	else
+		qrtr_received_service_message(&qrtr->super, addr.sq_port,
+							buf, bytes_read);
 
 	return true;
 }
@@ -2152,7 +2228,7 @@ static void qmi_device_qrtr_destroy(struct qmi_device *device)
 }
 
 static const struct qmi_device_ops qrtr_ops = {
-	.write = NULL,
+	.write = qmi_device_qrtr_write,
 	.discover = qmi_device_qrtr_discover,
 	.client_create = NULL,
 	.client_release = NULL,
-- 
2.43.2


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
