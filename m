Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8151C4C
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067783; cv=none; b=a0x/nBqpM9p7tA9TrzqBvLfnJDEPCtiC4bHg+4C0R+hTf7muPELAhepfpPEn+T90P/vjYdiEEVGKXA+RmUlMlhwZLWMkpscEVm9VdVMH98R6y8G10CgimWC83LBZw33hNof74SWYJgFHWCpI3kaKrEh+/8OVpsNq/5eo2EZkawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067783; c=relaxed/simple;
	bh=2bozjL3ROAlIg+G/sLtbR4jaaGuWAXu10K++C6NBzLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iy8/EKdnaDULvNFgUd5sumq9ckQLjnrdEIVYNGBVNfXk166iZga3ojQVQ+/XA+h61I9rtzmz1D8DsYagNca/HgBMpaBoyrlzLfk1IH04o5o8CYXJe93MLLMcssdPDwfDwMYkWyeDM8wslbjHXc5c5XNZ7JhkSY7m+k68EUl+3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=nl57xPcZ; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=QHTnezAv; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="nl57xPcZ";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="QHTnezAv"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RDvt71019687
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 13:03:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=YJ0pICBdejroUNDl3kayOyReurowE4FX5J69x25Ge1s=; b=n
	l57xPcZJGgr1g8cCnT8RT36FtZTt4DiFzW9JBoNvQcJT11uOErvfyNlP4ymUFy+x
	HVr1U010HJhi4bkjmLSK1MpvMtf6QkllXl8EOwwuUn51axKddTy2mXw35dibFyp6
	jo8RsoA5J9pxgjLH67rVpA2bVaF6U5Utjypro4Sui6iQlHEIq9uaWaWU0Aa/iDAn
	9FG8cy0KlSU7vGwLUPOk6O/mLzwn4J3Tm71UoiGI7dZKWyLp11KJos+FjVz+LOGZ
	e73Py7hqEuRnZn6sM5pySFg4ntKqdMh8ftEM8bpx0pMM3O0YKyuQCoKB6sCK++MF
	hZopybmOj89ImNewYOr9A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wgygr1b25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 13:03:00 -0800 (PST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68f740ea9a8so2959676d6.0
        for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709067779; x=1709672579; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YJ0pICBdejroUNDl3kayOyReurowE4FX5J69x25Ge1s=;
        b=QHTnezAv0RRlEtPLHummdUp5N1AbW1uo6AtfLx31xVrUApGtjA0F7UxX3y7I8j5oRE
         D2ZOVSGchuSCG7h06xYPnNQX7nLfE6Yj+7SJJGkIBqbFJTdIFC+VjErL5z5a6wLjgD/0
         tGwhiUxSbUu0cj4R7vmuPDvAqTkQBo3gW9dXvhY9/Vax1+ASqW7xvs0pP3e378bfCxFd
         7r+4qYimZV8dkFUKtDI6pg1l7KJbzB3EWDAalzlK1h8PeALDsoDVOG9Ho1sIEn3N374z
         no3gJNyHZJYa28uNHkqYVuElsdEZ+ABJdvx6fB4iJ98UpPuuCOqtgejU522tzW53eUH3
         up9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709067779; x=1709672579;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YJ0pICBdejroUNDl3kayOyReurowE4FX5J69x25Ge1s=;
        b=OXxvC97z+GgaF+CbscDTu5chNlijb/zsS2farjUmRNpVRIc0ED+KxZqQsl8M6jUZqj
         jZHHYKxIaffLfJsQmHpiWmiJvpVZTbGq/asT8GG9NMqxK7hKhjgp94m8PnkZO0B9GpHu
         lHBsHuVM2E1uWfXunJoCVtW7gY5i8y3i/+qkb0GpnpGQSePegWi42rAJzY3G1bMg45I5
         kkSZmd1K9qXty0CrtKKQ4C15Zdvk4oxp+RXtKlOQhF/kKICCZhFd8ffAOGSOHkGLP2pt
         QXnjM9RctRRovPoS0NsnKmPR2JqAAziKfssGF7enJX752IjsSwfkC2rkC6e3u69wKpvx
         m+sg==
X-Gm-Message-State: AOJu0YxeH2nswh7VGuC4+3wQkQbQUIilf2uCdFnVYw8MjbXBsMTCnOnF
	SxoZKu0Hg3DEjoXa1w/5bFEBd9hynw+gH/5ft919n87e990HuX9etblCmIjFutSnyh7mUa9Y6PU
	JswD8RG573T45M0hAZvrSbHyXj3mzqUck3fBFjySVR/yPco6mO6PG1lPe9Rsj/K/0377wZieu0f
	WCu39t+wZteJus7sOdahdxoLsT6+g2ZHWUxLDk/AQttiUhy74=
X-Received: by 2002:a05:6214:3217:b0:690:2139:b50e with SMTP id qj23-20020a056214321700b006902139b50emr650153qvb.18.1709067778779;
        Tue, 27 Feb 2024 13:02:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfh+fy21AV9/AAjqnlFemh/u+mhEyKnIQQgAx8k6USYpNsLZRNb7Xli5ATX/4beyOnGYMItw==
X-Received: by 2002:a05:6214:3217:b0:690:2139:b50e with SMTP id qj23-20020a056214321700b006902139b50emr650134qvb.18.1709067778381;
        Tue, 27 Feb 2024 13:02:58 -0800 (PST)
Received: from localhost.localdomain ([140.177.178.112])
        by smtp.gmail.com with ESMTPSA id u17-20020a0cdd11000000b0068f7f26d74asm4506720qvk.138.2024.02.27.13.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:02:58 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] qmimodem: QRTR service discovery
Date: Tue, 27 Feb 2024 21:01:43 +0000
Message-Id: <20240227210143.142603-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: Mv9M0drtch0iJyzThkCasbwUvIKYsz0g
X-Proofpoint-GUID: Mv9M0drtch0iJyzThkCasbwUvIKYsz0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270162

QRTR service discovery works by sending QRTR_TYPE_NEW_LOOKUP to
the special socket of type AF_QIPCRTR. Then the services are received
one-by-one. Soon they will be stored and made available for use by the
qmi client.

There was a re-entrancy problem where the qmi_device could be
destroyed in a callback, but then the code running would still try
to access that device. This was solved by creating a common macro
that would do things in the right order so that the qmi_device was
not accessed again after calling back into the client.

QRTR modem discovery and instantiation will be implemented later.
---
 drivers/qmimodem/qmi.c | 289 +++++++++++++++++++++++++++++++++++++----
 drivers/qmimodem/qmi.h |   1 +
 2 files changed, 267 insertions(+), 23 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 35751d7c..36b99f8d 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -33,6 +33,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/limits.h>
+#include <linux/qrtr.h>
+#include <sys/socket.h>
 
 #include <ell/ell.h>
 
@@ -784,10 +786,22 @@ static void __qmi_device_discovery_complete(struct qmi_device *device,
 {
 	if (!l_queue_remove(device->discovery_queue, d))
 		return;
-
-	__discovery_free(d);
 }
 
+/*
+ * Prevents re-entrancy problems by removing the entry from the discovery_queue
+ * before calling the callback.
+ */
+#define DISCOVERY_DONE(data, ...)\
+do {\
+	__qmi_device_discovery_complete(data->device, &data->super);\
+\
+	if (data->func)\
+		data->func(__VA_ARGS__);\
+\
+	__discovery_free(&data->super);\
+} while (0)
+
 static void service_destroy(void *data)
 {
 	struct qmi_service *service = data;
@@ -1344,9 +1358,8 @@ static void service_create_shared_reply(struct l_idle *idle, void *user_data)
 
 	l_idle_remove(data->idle);
 	data->idle = NULL;
-	data->func(data->service, data->user_data);
 
-	__qmi_device_discovery_complete(data->device, &data->super);
+	DISCOVERY_DONE(data, data->service, data->user_data);
 }
 
 static void service_create_shared_pending_reply(struct qmi_device *device,
@@ -1406,10 +1419,7 @@ static void qmux_sync_callback(uint16_t message, uint16_t length,
 {
 	struct discover_data *data = user_data;
 
-	if (data->func)
-		data->func(data->user_data);
-
-	__qmi_device_discovery_complete(data->device, &data->super);
+	DISCOVERY_DONE(data, data->user_data);
 }
 
 /* sync will release all previous clients */
@@ -1510,10 +1520,7 @@ done:
 		return;
 	}
 
-	if (data->func)
-		data->func(data->user_data);
-
-	__qmi_device_discovery_complete(data->device, &data->super);
+	DISCOVERY_DONE(data, data->user_data);
 }
 
 static void qmux_discover_reply_timeout(struct l_timeout *timeout,
@@ -1531,10 +1538,7 @@ static void qmux_discover_reply_timeout(struct l_timeout *timeout,
 	/* remove request from queues */
 	req = find_control_request(qmux, data->tid);
 
-	if (data->func)
-		data->func(data->user_data);
-
-	__qmi_device_discovery_complete(device, &data->super);
+	DISCOVERY_DONE(data, data->user_data);
 
 	if (req)
 		__request_free(req);
@@ -1620,10 +1624,7 @@ static void qmux_client_create_reply(struct l_timeout *timeout, void *user_data)
 	l_timeout_remove(data->timeout);
 	data->timeout = NULL;
 
-	if (data->func)
-		data->func(NULL, data->user_data);
-
-	__qmi_device_discovery_complete(device, &data->super);
+	DISCOVERY_DONE(data, NULL, data->user_data);
 
 	if (req)
 		__request_free(req);
@@ -1684,10 +1685,8 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 done:
 	service_create_shared_pending_reply(device, data->type, service);
 
-	data->func(service, data->user_data);
+	DISCOVERY_DONE(data, service, data->user_data);
 	qmi_service_unref(service);
-
-	__qmi_device_discovery_complete(data->device, &data->super);
 }
 
 static int qmi_device_qmux_client_create(struct qmi_device *device,
@@ -1874,6 +1873,250 @@ struct qmi_device *qmi_device_new_qmux(const char *device)
 	return &qmux->super;
 }
 
+struct qmi_device_qrtr {
+	struct qmi_device super;
+	qmi_shutdown_func_t shutdown_func;
+	void *shutdown_user_data;
+	qmi_destroy_func_t shutdown_destroy;
+	struct l_idle *shutdown_idle;
+};
+
+static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
+					qmi_debug_func_t function,
+					void *user_data)
+{
+	char strbuf[72 + 16], *str;
+	const char *type;
+
+	if (!function)
+		return;
+
+	str = strbuf;
+	str += sprintf(str, "    %s",
+			__service_type_to_string(QMI_SERVICE_CONTROL));
+
+	type = "_pkt";
+
+	str += sprintf(str, "%s cmd=%d", type,
+				L_LE32_TO_CPU(packet->cmd));
+
+	function(strbuf, user_data);
+}
+
+static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
+					const struct qrtr_ctrl_pkt *packet)
+{
+	struct qmi_device *device = &qrtr->super;
+	uint32_t cmd;
+	uint32_t type;
+	uint32_t instance;
+	uint32_t version;
+	uint32_t node;
+	uint32_t port;
+
+	qrtr_debug_ctrl_request(packet, device->debug_func,
+				device->debug_data);
+
+	cmd = L_LE32_TO_CPU(packet->cmd);
+	if (cmd != QRTR_TYPE_NEW_SERVER) {
+		DBG("Unknown command: %d", cmd);
+		return;
+	}
+
+	if (!packet->server.service && !packet->server.instance &&
+			!packet->server.node && !packet->server.port) {
+		struct discover_data *data;
+
+		DBG("Initial service discovery has completed");
+
+		data = l_queue_peek_head(device->discovery_queue);
+		DISCOVERY_DONE(data, data->user_data);
+
+		return;
+	}
+
+	type = L_LE32_TO_CPU(packet->server.service);
+	version = L_LE32_TO_CPU(packet->server.instance) & 0xff;
+	instance = L_LE32_TO_CPU(packet->server.instance) >> 8;
+
+	node = L_LE32_TO_CPU(packet->server.node);
+	port = L_LE32_TO_CPU(packet->server.port);
+
+	if (cmd == QRTR_TYPE_NEW_SERVER) {
+		DBG("New server: Type: %d Version: %d Instance: %d Node: %d Port: %d",
+			type, version, instance, node, port);
+	}
+}
+
+static void qrtr_handle_packet(struct qmi_device_qrtr *qrtr, uint32_t sending_port,
+				const void *buf, ssize_t len)
+{
+	const struct qrtr_ctrl_pkt *packet = buf;
+
+	if (sending_port != QRTR_PORT_CTRL) {
+		DBG("Receive of service data is not implemented");
+		return;
+	}
+
+	if ((unsigned long) len < sizeof(*packet)) {
+		DBG("qrtr control packet is too small");
+		return;
+	}
+
+	qrtr_handle_control_packet(qrtr, packet);
+}
+
+static bool qrtr_received_data(struct l_io *io, void *user_data)
+{
+	struct qmi_device_qrtr *qrtr = user_data;
+	struct sockaddr_qrtr addr;
+	unsigned char buf[2048];
+	ssize_t bytes_read;
+	socklen_t addr_size;
+
+	addr_size = sizeof(addr);
+	bytes_read = recvfrom(l_io_get_fd(qrtr->super.io), buf, sizeof(buf), 0,
+				(struct sockaddr *) &addr, &addr_size);
+	DBG("Received %zd bytes from Node: %d Port: 0x%x", bytes_read,
+		addr.sq_node, addr.sq_port);
+
+	if (bytes_read < 0)
+		return true;
+
+	l_util_hexdump(true, buf, bytes_read, qrtr->super.debug_func,
+			qrtr->super.debug_data);
+
+	qrtr_handle_packet(qrtr, addr.sq_port, buf, bytes_read);
+
+	return true;
+}
+
+static void qrtr_discover_reply_timeout(struct l_timeout *timeout,
+							void *user_data)
+{
+	struct discover_data *data = user_data;
+
+	l_timeout_remove(data->timeout);
+	data->timeout = NULL;
+
+	DISCOVERY_DONE(data, data->user_data);
+}
+
+static int qmi_device_qrtr_discover(struct qmi_device *device,
+					qmi_discover_func_t func,
+					void *user_data,
+					qmi_destroy_func_t destroy)
+{
+	struct discover_data *data;
+	struct qrtr_ctrl_pkt packet;
+	struct sockaddr_qrtr addr;
+	socklen_t addr_len;
+	int rc;
+	ssize_t bytes_written;
+	int fd;
+
+	__debug_device(device, "device %p discover", device);
+
+	if (l_queue_length(device->discovery_queue) > 0)
+		return -EINPROGRESS;
+
+	data = l_new(struct discover_data, 1);
+
+	data->super.destroy = discover_data_free;
+	data->device = device;
+	data->func = func;
+	data->user_data = user_data;
+	data->destroy = destroy;
+
+	fd = l_io_get_fd(device->io);
+
+	/*
+	 * The control node is configured by the system. Use getsockname to
+	 * get its value.
+	 */
+	addr_len = sizeof(addr);
+	rc = getsockname(fd, (struct sockaddr *) &addr, &addr_len);
+	if (rc) {
+		DBG("getsockname failed: %s", strerror(errno));
+		rc = -errno;
+		goto error;
+	}
+
+	if (addr.sq_family != AF_QIPCRTR || addr_len != sizeof(addr)) {
+		DBG("Unexpected sockaddr from getsockname. family: %d size: %d",
+			addr.sq_family, addr_len);
+		rc = -EIO;
+		goto error;
+	}
+
+	addr.sq_port = QRTR_PORT_CTRL;
+	memset(&packet, 0, sizeof(packet));
+	packet.cmd = L_CPU_TO_LE32(QRTR_TYPE_NEW_LOOKUP);
+
+	bytes_written = sendto(fd, &packet,
+				sizeof(packet), 0,
+				(struct sockaddr *) &addr, addr_len);
+	if (bytes_written < 0) {
+		DBG("Failure sending data: %s", strerror(errno));
+		rc = -errno;
+		goto error;
+	}
+
+	l_util_hexdump(false, &packet, bytes_written,
+			device->debug_func, device->debug_data);
+
+	data->timeout = l_timeout_create(5, qrtr_discover_reply_timeout,
+								data, NULL);
+
+	__qmi_device_discovery_started(device, &data->super);
+
+	return 0;
+
+error:
+	__discovery_free(&data->super);
+
+	return rc;
+}
+
+static void qmi_device_qrtr_destroy(struct qmi_device *device)
+{
+	struct qmi_device_qrtr *qrtr =
+		l_container_of(device, struct qmi_device_qrtr, super);
+
+	l_free(qrtr);
+}
+
+static const struct qmi_device_ops qrtr_ops = {
+	.write = NULL,
+	.discover = qmi_device_qrtr_discover,
+	.client_create = NULL,
+	.client_release = NULL,
+	.shutdown = NULL,
+	.destroy = qmi_device_qrtr_destroy,
+};
+
+struct qmi_device *qmi_device_new_qrtr(void)
+{
+	struct qmi_device_qrtr *qrtr;
+	int fd;
+
+	fd = socket(AF_QIPCRTR, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return NULL;
+
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
+}
+
 struct qmi_param *qmi_param_new(void)
 {
 	struct qmi_param *param;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 6a3d3415..506fed6b 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -101,6 +101,7 @@ bool qmi_device_set_expected_data_format(struct qmi_device *device,
 			enum qmi_device_expected_data_format format);
 
 struct qmi_device *qmi_device_new_qmux(const char *device);
+struct qmi_device *qmi_device_new_qrtr(void);
 
 struct qmi_param;
 
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
