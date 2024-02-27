Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3B93D541
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054073; cv=none; b=CHyBoPpy9CmpZ0Czd9UuPIXA0lfReEU7rCqebEgklAydKBM8mbfy8kIHVSYLhlrWJjm5ReIz8G4OgswzticZIMrgc9gQoSUOylRamm4De+BP9q9CIGHRqynWWA9hlnTwususmDO94pCPwTMU8aY+c2onItBqYCTv3QfDI7NMMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054073; c=relaxed/simple;
	bh=NhgsQen+0zVvCe0zdTbnJK0RuShASVMi6EIvgzSy5E4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=byvX7Af2mhplYy6asArw+cEpaBD39VnhH1XS2Q9/LkrfA9Ed6PZ4Tmfo1v3WnqDCUK9gLDxxvm1UeFNrSZxQsUocTqT+8NpOeoSU2bYFHCrdY7LF0uri4UHYjKzLzIktIYRq0ZZ7ZpGwzw2/p0Ytgy0BLobO0XsCzMJ/RyxAxFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=NyM6KhVC; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Wk7oe2oJ; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="NyM6KhVC";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Wk7oe2oJ"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RDLZoT013364
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 09:14:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=bvqz77OI6OhJyN0FQ+guVP0eR4FWxnnup+cFgmJKr1A=; b=N
	yM6KhVCa1ETx2afACL7jtNzyu3rbPf4HbAwRmVYEavJHHLeygOe1jCwuEH1WxbIV
	DqedAH/Wi1gSIRFiKlZ61EAC+RVxgdrheylBcsNWl9bNFa7Vor/7FFT2VOlt4kjF
	yboKBW0CYgPodtW0Gb9mmT2GxZkN6OK6Is+u4aD2jYzEYXD39bm3T5x7+LeFyzao
	/xKE/+o8QvO0zJpyF+0p/K17lFXpVXvRB0PXWXF3vUnRXZWj19kg4zTTqSDMhxNG
	gX30MpxVffDDrmpwKL5GiP+jc9Vun3wmrQshiE8OTLeWd6+t1ToEabhGb3E4UZcp
	cK4hWOR1C7uLKVKtX8xiQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wgygr11q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 09:14:25 -0800 (PST)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-608dc99b401so47816567b3.0
        for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 09:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709054064; x=1709658864; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bvqz77OI6OhJyN0FQ+guVP0eR4FWxnnup+cFgmJKr1A=;
        b=Wk7oe2oJHpAxTSyJYscMop7cYMl2CkCh08JzvxFvJjvKFB0YipNsB2HTSbV81LG2IE
         0mIaeNwy0lzuwVXsz5CVU4cldsLShcFqLkgDFz86kchwqAHydMqX5jJFzGf4SVXubdk7
         uTlqFUHQBO0Eum9hbzg38eWKOwRe9FGUGsHfdVCfh2nJw4cr1F8HdPvqiR/qR+hIA6aY
         Heu4TOwxHabQSpIgpvSzfWIAX64qnYia0E7HqaIXPIhY4FZO+qNN6DZHfZegizG6OjXA
         mBVgNSmlu8Ycqco3yGQY+8P+zeOd3LujOqvsh+jJNeQ1VKbCVV2LpqAs0UjiE1W1wsJ+
         UKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054064; x=1709658864;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvqz77OI6OhJyN0FQ+guVP0eR4FWxnnup+cFgmJKr1A=;
        b=VO5jaVm3p/tm+bpTYdl9ehpuuKVjvkDISA+s+c0d1qRFdB+yM//15vCVf8gVW7O9c1
         /Szpv6giek0PrA0XAmN7g6HVVHKCqyQrXoKFfSostuGAsi+MOEjOAF7LOJO4+U0afWvk
         b4TEgc+xD7aip/pRmGd1spdXXs/W3njkGCXmBQFNhSfHRdikcudtoNcgUpWje+LcZtTk
         aRoAkQdUzpJoWQnKR4InzD86n90JDDSc4DvOKKyieiHxhhthVqxhDqeEkD61Nfu6/M6W
         GhIcvbzTx775smlyWiAGj01wpALDmNb1UwxGIUH30w4NVmNMZx1lbU7IeY+nqLSFOCuU
         /S8w==
X-Gm-Message-State: AOJu0YxXzigZPd7gRqdU+PXK/opwR91s0Su87cQA00FoA5GcTrwYzOSC
	UA+ByTmM4g4uuKPeHu5cVFLYFM6DW3xn7WURVGPcviAaFQDL+REmcQsxp6SZA01Whau5UtAD5T2
	Q/+7epHu32Be0e97oP7KPud0dsWl6aPsN+pCbwatDK84JhPlwazGXeQuvegKFYE5PjNpfFJg8GS
	L4FxeH6O0Z7I5D3IVvpuz+XDnYIecIB9W+gEosYNZePl35E0U=
X-Received: by 2002:a81:488b:0:b0:608:9f0f:5a48 with SMTP id v133-20020a81488b000000b006089f0f5a48mr3029694ywa.11.1709054063968;
        Tue, 27 Feb 2024 09:14:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYYGyNggljouq0K+xVqKz0CxB6Vp+UQh8/Mbw3qS0CYAgON1gT6MVU5fUl1SoilBMFQ+W1UQ==
X-Received: by 2002:a81:488b:0:b0:608:9f0f:5a48 with SMTP id v133-20020a81488b000000b006089f0f5a48mr3029663ywa.11.1709054063558;
        Tue, 27 Feb 2024 09:14:23 -0800 (PST)
Received: from localhost.localdomain ([140.177.178.112])
        by smtp.gmail.com with ESMTPSA id a11-20020a81bb4b000000b006049167ccffsm1803075ywl.65.2024.02.27.09.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:14:23 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] qmimodem: QRTR service discovery
Date: Tue, 27 Feb 2024 17:12:35 +0000
Message-Id: <20240227171235.128397-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: N9Lt1YAo68xKhoV1ZEJ71XDD8YpwfIPs
X-Proofpoint-GUID: N9Lt1YAo68xKhoV1ZEJ71XDD8YpwfIPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270133

QRTR service discovery works by sending QRTR_TYPE_NEW_LOOKUP to
the special socket of type AF_QIPCRTR. Then the services are received
one-by-one. Soon they will be stored and made available for use by the
qmi client.

QRTR modem discovery and instantiation will be implemented later.
---
 drivers/qmimodem/qmi.c | 312 +++++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/qmi.h |   1 +
 2 files changed, 313 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 35751d7c..5f730a74 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -33,6 +33,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/limits.h>
+#include <linux/qrtr.h>
+#include <sys/socket.h>
 
 #include <ell/ell.h>
 
@@ -1874,6 +1876,316 @@ struct qmi_device *qmi_device_new_qmux(const char *device)
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
+
+		if (data->func)
+			data->func(data->user_data);
+
+		__qmi_device_discovery_complete(device, &data->super);
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
+	struct qmi_device *device = data->device;
+
+	l_timeout_remove(data->timeout);
+	data->timeout = NULL;
+
+	if (data->func)
+		data->func(data->user_data);
+
+	__qmi_device_discovery_complete(device, &data->super);
+}
+
+static int qmi_device_qrtr_discover(struct qmi_device *device,
+					qmi_discover_func_t func,
+					void *user_data,
+					qmi_destroy_func_t destroy)
+{
+	struct qmi_device_qrtr *qrtr =
+		l_container_of(device, struct qmi_device_qrtr, super);
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
+static void qrtr_shutdown_destroy(void *user_data)
+{
+	struct qmi_device_qrtr *qrtr = user_data;
+
+	if (qrtr->shutdown_destroy)
+		qrtr->shutdown_destroy(qrtr->shutdown_user_data);
+
+	qrtr->shutdown_idle = NULL;
+
+	__qmi_device_shutdown_finished(&qrtr->super);
+}
+
+static void qrtr_shutdown_callback(struct l_idle *idle, void *user_data)
+{
+	struct qmi_device_qrtr *qrtr = user_data;
+
+	qrtr->super.shutting_down = true;
+
+	if (qrtr->shutdown_func)
+		qrtr->shutdown_func(qrtr->shutdown_user_data);
+
+	qrtr->super.shutting_down = false;
+
+	l_idle_remove(qrtr->shutdown_idle);
+}
+
+/*
+ * Prevents problems caused by device destruction through re-entrancy by
+ * performing destruction in an idle callback.
+ */
+static int qmi_device_qrtr_shutdown(struct qmi_device *device,
+					qmi_shutdown_func_t func,
+					void *user_data,
+					qmi_destroy_func_t destroy)
+{
+	struct qmi_device_qrtr *qrtr =
+		l_container_of(device, struct qmi_device_qrtr, super);
+
+	if (qrtr->shutdown_idle)
+		return -EALREADY;
+
+	__debug_device(&qrtr->super, "device %p shutdown", &qrtr->super);
+
+	qrtr->shutdown_idle = l_idle_create(qrtr_shutdown_callback, qrtr,
+						qrtr_shutdown_destroy);
+
+	if (!qrtr->shutdown_idle)
+		return -EIO;
+
+	qrtr->shutdown_func = func;
+	qrtr->shutdown_user_data = user_data;
+	qrtr->shutdown_destroy = destroy;
+
+	return 0;
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
+	.shutdown = qmi_device_qrtr_shutdown,
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
