Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438C22097
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313111; cv=none; b=flNnXE32oYRxWOzSVrbNiB8yVX/dgxu5aYrnpMsYbLO0GnW5GxLGDiJ7g+vwbYzGH5wg+ehRrvjKH6m1R6jYJL4CImCJOtvqk09PgjT+JU0W/oNwJVC0uwlUkyfYfixbeoggQT+YfoLgctcHJ68M8b7nyhy+2tuaFvfjYJAeikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313111; c=relaxed/simple;
	bh=hEpgQGnlLRDntlL1aQXgLVnBFy1vcMRkTs/e6UUMsUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4Yr4gFlhiuUuyZRAA/La1KxM8sVJ+iCyP/FTY4dkufRkL7e6pWzm+P0D9arq7FmBmm+KOn2QihpqrhSccfrhYoI0f07M35jHblXtkUGZtKGESQnakrNwCdU7B+JvA1jVEVmj4UuTh3mGi/ywzJywXzseaMYGHZ1yXyve6W3QgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=sJJtRXXB; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=DGEhVjGo; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="sJJtRXXB";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="DGEhVjGo"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421EsJnj029012
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 09:11:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=GSDWDWekZHglxOCqo+DVe9
	jOyqxR17e1eNm5JQxvuNY=; b=sJJtRXXBOQIONk43BsYDaVqVIGRE5g1cJhBoca
	zw56C4MQOAEDk6lg5dSY5ax1ThXt6Ml95OmJQuMgx7L4diQfVyPABD4CMRKoH4GM
	DZIRRsLN4VWYeDmUjtSI9kIalZAJ4Ux5M9ZKOC0idekVRUTZnpvNPLUVmh7aEAmV
	68dhGS8P4NQQUdgBcYIN9yjMDg182raeRO0CT/92rqHmnEECDum7YRGfxIxhQwPL
	YJJm+wvPiD1X4zeT03hsLBuWNudFMJRpOL/aVaDE30UHwqtScu2xxz7UCRfXQuJv
	dtmVQeNdYJ60omnbRLz4SDK2OIk5/LNts4V/a950zgVHFcxw==
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wjenksmhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 09:11:43 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c78e7044b7so264114339f.2
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709313102; x=1709917902; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSDWDWekZHglxOCqo+DVe9jOyqxR17e1eNm5JQxvuNY=;
        b=DGEhVjGoY7KWR3jQHd/U1E0LLf9brMuubF7h5W/uZcqPirD87CohrjLkwCHLmUJHg5
         RYHIAuR8AyLnQvT79sDfuAPER1ktPNmJBQYi7SBVe1Q2L5Xu1Fhwxq4skEJjt+GqSSmC
         r6oW1qTTeQAPJMIiKVUr0oKOMyOuhlc28W75Z8nviYyaR5QYyGohH3wc59tDyd8ulprl
         F9njkUBCFEGHEBV3STN4imY6t7dLx0Iu6um+PqvgzKEpbqUvmUzYbGJMVcEAyOt3VvZS
         4g9UggmFhXWwd63hx7Tee1OzO06lsgtB7qbGcaF5Xi48Osbk4PY2ejDHiIuPZ8BII+jt
         fSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313102; x=1709917902;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSDWDWekZHglxOCqo+DVe9jOyqxR17e1eNm5JQxvuNY=;
        b=JtLSUvxtUzra/8DfAFYu9CYDrqtf18RVSr/oHv2fXRgPWqXtok3MwIqUFn9FNLOFze
         mEs5wxEhIiFzFAx6XUSyo6oRFfLN4thPCcHFbHeYs+OzUUJNucMgPGglQJNa+ohLRtqe
         daZi3SW/UmXSB+qPnMilFqShA7OFLoC6ITy5PSK//GZTQK2NtLmyqskPy7IWYWr4qM0O
         h6FqBW2ztUTJMlE34uCvOWAMUPJiiZxr4MlFpm977E6OftQd03JwN8YrXJHig1umEYrd
         OXJdnm6Qmgvl+nqXHXg4MyYSMPWsoZP18OSlCnzy6BjBh/VXXO5NJ3+e8YQFwtKHAeqO
         PEfg==
X-Gm-Message-State: AOJu0YxKLMY4dyLhwKbENcCNmj2DmxFwsZBSWi7EMYGp7vEteW5+k1fk
	eXW58waE01ztz3V+Pk8brgtloxWmL8X+lHmnNsn8XEvRyxwZvlsw6ZOzjona60k5JuNrCszWng+
	4sICY7VSdZOBayh4TM0hMPLYJdxM6y0w/8coJnINXSRVAcZB5/zpWagMpryyD0woiPK1U/X54YZ
	VqhyDy1WQGMZzHpCGAesCdptjVZeEzGArdrPWnNdbWDfDvXoYUmQ==
X-Received: by 2002:a05:6602:1dcd:b0:7c8:249f:78f5 with SMTP id hk13-20020a0566021dcd00b007c8249f78f5mr1955941iob.0.1709313101913;
        Fri, 01 Mar 2024 09:11:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaJdujjEaZLr7cVONMCzj8/vaIR17R2aRPweE9bv/N0cSgr80Zu9KSFIHmN+hpiCNqlbwebA==
X-Received: by 2002:a05:6602:1dcd:b0:7c8:249f:78f5 with SMTP id hk13-20020a0566021dcd00b007c8249f78f5mr1955923iob.0.1709313101489;
        Fri, 01 Mar 2024 09:11:41 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id gs22-20020a0566382d9600b004745a061467sm881059jab.87.2024.03.01.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:11:41 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 3/3] qmi: Enable QRTR service writes and reads
Date: Fri,  1 Mar 2024 11:11:22 -0600
Message-ID: <20240301171124.38735-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301171124.38735-1-steve.schrock@getcruise.com>
References: <20240301171124.38735-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: NtDYo7QdG5N3qNbjQi2trlAziInmFWbW
X-Proofpoint-GUID: NtDYo7QdG5N3qNbjQi2trlAziInmFWbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_19,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010143

For simplicity the QRTR write method simply skips the QMUX
header. In the future it might make sense to add another ops
function that would allocate a larger buffer and populate
the QMUX header in the QMUX implementation.
---
 drivers/qmimodem/qmi.c | 204 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 180 insertions(+), 24 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 85ece8fc..b2881058 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -62,7 +62,7 @@ struct qmi_service_info {
 struct qmi_request {
 	uint16_t tid;
 	unsigned int service_id;	/* Always 0 for control */
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
 				unsigned int service_id,
 				uint8_t client, uint16_t message,
 				const void *data,
@@ -229,7 +229,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	uint16_t hdrlen = QMI_MUX_HDR_SIZE;
 	uint16_t msglen;
 
-	if (service == QMI_SERVICE_CONTROL)
+	if (service_type == QMI_SERVICE_CONTROL)
 		hdrlen += QMI_CONTROL_HDR_SIZE;
 	else
 		hdrlen += QMI_SERVICE_HDR_SIZE;
@@ -246,7 +246,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	hdr->frame = 0x01;
 	hdr->length = L_CPU_TO_LE16(req->len - 1);
 	hdr->flags = 0x00;
-	hdr->service = service;
+	hdr->service = service_type; /* qmux service types are 8 bits */
 	hdr->client = client;
 
 	msg = (struct qmi_message_hdr *) &req->data[hdrlen];
@@ -530,7 +530,7 @@ int qmi_error_to_ofono_cme(int qmi_error)
 	}
 }
 
-static void __debug_msg(const char dir, const void *buf, size_t len,
+static void __qmux_debug_msg(const char dir, const void *buf, size_t len,
 				qmi_debug_func_t function, void *user_data)
 {
 	const struct qmi_mux_hdr *hdr;
@@ -667,6 +667,101 @@ static void __debug_msg(const char dir, const void *buf, size_t len,
 		function(strbuf, user_data);
 }
 
+static void __qrtr_debug_msg(const char dir, const void *buf, size_t len,
+				uint16_t service_type,
+				qmi_debug_func_t function, void *user_data)
+{
+	const struct qmi_service_hdr *srv;
+	const struct qmi_message_hdr *msg;
+	const void *ptr;
+	uint16_t offset;
+	char strbuf[72 + 16], *str;
+	const char *type;
+	bool pending_print = false;
+
+	if (!function || !len)
+		return;
+
+	str = strbuf;
+	str += sprintf(str, "%c   %s", dir,
+				__service_type_to_string(service_type));
+
+	srv = buf;
+	msg = buf + QMI_SERVICE_HDR_SIZE;
+	ptr = buf + QMI_SERVICE_HDR_SIZE + QMI_MESSAGE_HDR_SIZE;
+
+	switch (srv->type) {
+	case 0x00:
+		type = "_req";
+		break;
+	case 0x02:
+		type = "_resp";
+		break;
+	case 0x04:
+		type = "_ind";
+		break;
+	default:
+		type = "";
+		break;
+	}
+
+	str += sprintf(str, "%s msg=%d len=%d", type,
+				L_LE16_TO_CPU(msg->message),
+				L_LE16_TO_CPU(msg->length));
+
+	str += sprintf(str, " [type=%d,tid=%d,len=%zd]",
+				srv->type,
+				L_LE16_TO_CPU(srv->transaction),
+				len);
+
+	function(strbuf, user_data);
+
+	if (!msg->length)
+		return;
+
+	str = strbuf;
+	str += sprintf(str, "      ");
+	offset = 0;
+
+	while (offset + QMI_TLV_HDR_SIZE < L_LE16_TO_CPU(msg->length)) {
+		const struct qmi_tlv_hdr *tlv = ptr + offset;
+		uint16_t tlv_length = L_LE16_TO_CPU(tlv->length);
+
+		if (tlv->type == 0x02 && tlv_length == QMI_RESULT_CODE_SIZE) {
+			const struct qmi_result_code *result = ptr + offset +
+							QMI_TLV_HDR_SIZE;
+			uint16_t error = L_LE16_TO_CPU(result->error);
+			const char *error_str;
+
+			error_str = __error_to_string(error);
+			if (error_str)
+				str += sprintf(str, " {type=%d,error=%s}",
+							tlv->type, error_str);
+			else
+				str += sprintf(str, " {type=%d,error=%d}",
+							tlv->type, error);
+		} else {
+			str += sprintf(str, " {type=%d,len=%d}", tlv->type,
+								tlv_length);
+		}
+
+		if (str - strbuf > 60) {
+			function(strbuf, user_data);
+
+			str = strbuf;
+			str += sprintf(str, "      ");
+
+			pending_print = false;
+		} else
+			pending_print = true;
+
+		offset += QMI_TLV_HDR_SIZE + tlv_length;
+	}
+
+	if (pending_print)
+		function(strbuf, user_data);
+}
+
 static void __debug_device(struct qmi_device *device,
 					const char *format, ...)
 {
@@ -772,7 +867,7 @@ static unsigned int service_list_create_hash(uint16_t service_type,
 }
 
 static void handle_indication(struct qmi_device *device,
-			uint8_t service_type, uint8_t client_id,
+			uint32_t service_type, uint8_t client_id,
 			uint16_t message, uint16_t length, const void *data)
 {
 	struct qmi_service *service;
@@ -805,7 +900,7 @@ static void handle_indication(struct qmi_device *device,
 }
 
 static void __rx_message(struct qmi_device *device,
-				uint8_t service_type, uint8_t client_id,
+				uint32_t service_type, uint8_t client_id,
 				const void *buf)
 {
 	const struct qmi_service_hdr *service = buf;
@@ -1284,7 +1379,7 @@ static int qmi_device_qmux_write(struct qmi_device *device,
 	l_util_hexdump(false, req->data, bytes_written,
 			device->debug_func, device->debug_data);
 
-	__debug_msg(' ', req->data, bytes_written,
+	__qmux_debug_msg(' ', req->data, bytes_written,
 				device->debug_func, device->debug_data);
 
 	hdr = (struct qmi_mux_hdr *) req->data;
@@ -1371,7 +1466,7 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 		if (bytes_read - offset < len)
 			break;
 
-		__debug_msg(' ', buf + offset, len,
+		__qmux_debug_msg(' ', buf + offset, len,
 				qmux->super.debug_func, qmux->super.debug_data);
 
 		msg = buf + offset + QMI_MUX_HDR_SIZE;
@@ -1945,6 +2040,48 @@ struct qmi_device_qrtr {
 	struct l_idle *shutdown_idle;
 };
 
+static int qmi_device_qrtr_write(struct qmi_device *device,
+					struct qmi_request *req)
+{
+	struct sockaddr_qrtr addr;
+	uint8_t *data;
+	uint16_t len;
+	socklen_t addr_len = sizeof(addr);
+	int rc;
+	ssize_t bytes_written;
+	int fd = l_io_get_fd(device->io);
+
+	/* Skip the QMUX header */
+	data = req->data + QMI_MUX_HDR_SIZE;
+	len = req->len - QMI_MUX_HDR_SIZE;
+
+	rc = getsockname(fd, (struct sockaddr *) &addr, &addr_len);
+	if (rc != 0) {
+		DBG("getsockname failed: %s", strerror(errno));
+		return -errno;
+	}
+
+	addr.sq_node = req->info.qrtr_node;
+	addr.sq_port = req->info.qrtr_port;
+	bytes_written = sendto(fd, data, len, 0, (struct sockaddr *) &addr,
+							addr_len);
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
@@ -1967,10 +2104,10 @@ static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
 	function(strbuf, user_data);
 }
 
-static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
-					const struct qrtr_ctrl_pkt *packet)
+static void qrtr_received_control_packet(struct qmi_device *device,
+						unsigned char *buf, ssize_t len)
 {
-	struct qmi_device *device = &qrtr->super;
+	struct qrtr_ctrl_pkt *packet = (struct qrtr_ctrl_pkt *) buf;
 	uint32_t cmd;
 	uint32_t type;
 	uint32_t instance;
@@ -1978,6 +2115,11 @@ static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
 	uint32_t node;
 	uint32_t port;
 
+	if ((unsigned long) len < sizeof(*packet)) {
+		DBG("qrtr packet is too small");
+		return;
+	}
+
 	qrtr_debug_ctrl_request(packet, device->debug_func,
 				device->debug_data);
 
@@ -2023,22 +2165,32 @@ static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
 	}
 }
 
-static void qrtr_handle_packet(struct qmi_device_qrtr *qrtr, uint32_t sending_port,
-				const void *buf, ssize_t len)
+static void qrtr_received_service_message(struct qmi_device *device,
+			uint32_t port, const unsigned char *buf, ssize_t len)
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
@@ -2052,7 +2204,7 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	addr_size = sizeof(addr);
 	bytes_read = recvfrom(l_io_get_fd(qrtr->super.io), buf, sizeof(buf), 0,
 				(struct sockaddr *) &addr, &addr_size);
-	DBG("Received %zd bytes from Node: %d Port: 0x%x", bytes_read,
+	DBG("Received %zd bytes from Node: %d Port: %d", bytes_read,
 		addr.sq_node, addr.sq_port);
 
 	if (bytes_read < 0)
@@ -2061,7 +2213,11 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
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
@@ -2162,7 +2318,7 @@ static void qmi_device_qrtr_destroy(struct qmi_device *device)
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
