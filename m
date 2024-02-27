Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C601BC4E
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005005; cv=none; b=qupbFyDW2tY/EX9GSRoG6wHEFnsOZIwEMurLQbeefr4tGteFIYYcF3qqXPcsooNg/+SB+QMDozzbuBUOVMKNviZNg/ipo5SAvhP3JPtYOCQHeUs2FMLFOjFbOREdlqxw3nh1tSqnV8pduJO2rS7BTb30rZyW+m6ewWYLYy1sl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005005; c=relaxed/simple;
	bh=dDQMssi9keBuls0gRym5x81nO8wnpUEWwouybr3sbjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z6XWlKCY9TvtZO9EUl8kXidsf4SniWY1xHPTu3EkFpd4wJJpqov+ebJmmEFfcfjy7svny3NitS+n7UgNCZBU9X1Ei8aYqu/tlhVfVF54ob0zJlel5wrAuzFr28OQn5CgZzH3fSsskOcIvYz3kUUzSzHAPWDeDuMcQkYhU3X725M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=tQsjMqwS; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=f9kciGJU; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="tQsjMqwS";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="f9kciGJU"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R3RCP2001068
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 19:36:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=Z6Sji+IKO0B32g+cSyXk4UU55GzL3761pO8R5dMlrYk=; b=t
	QsjMqwSTwHlxKvAWEq0F+TPvdFhjiaFAl+/2TXMOp14I72JqUYEIjHkAbNT3fHTK
	UL0H5wt1i6JEPbbA1DsG90TUBUIVJJN6pbFAI7GIvnBzIaIWHxdNlvu1v8KDBY+B
	BzShB7ggEGw2I5tnG/eFkTybXIVMtAc3qhabQCy8YqNl5TJkXOVkDnqxr4de07Bs
	JxO/Iwh3KS54wf7CeXC9UE/p1FlbTJXLjh4rpbwbB3bEkgxTMgAUIboJrqfqp8sv
	iDw2jicJ6jOCGWcgHB2zwW0UpmYWeIE73Bm07aBd069Pf38oWWphEJ/awCD4Pl1m
	g4QUCVMZjmbHGETswYo7w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wfdhp9xer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 19:36:41 -0800 (PST)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-42e8962fe39so20949581cf.3
        for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 19:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709005000; x=1709609800; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z6Sji+IKO0B32g+cSyXk4UU55GzL3761pO8R5dMlrYk=;
        b=f9kciGJUneyMryZPt4u+zLwz5nOh6jJogw+0Y8ufMhLaCcKE+jjJGa/BHV0x0HS2ML
         cNWVMVZr/CCfkYlEC0jTiXmwoA5hff58xSWJ2pg4RUpNMhLFiivM7mhyw3dyShWEqhm1
         Gc6L57R8xHpxYhErTMBXJFVLli/AJ8lFElInKqo4N32hHJ43S1b0FdS6l4IZLH3m8Hsx
         S2BEy9AnnH8QEGdOJwnjQKpKXAhGUlIqtNlmPbrcwcWrLXRE54Y3l3FW1Fozlke2XVml
         3i5apm/zB/Ll6Q+eRPuq2DtVG3faOvCwP9oz7TfOx0ZvSLhuui7mHAk0uzsOnO7ZSWon
         cBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005000; x=1709609800;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6Sji+IKO0B32g+cSyXk4UU55GzL3761pO8R5dMlrYk=;
        b=aa+36SUFM8o4K73wPOEhyAxGoddof8RmOx5w5XrmgldnPg5zh1+5LsViJGCfGv1vgh
         zil/L0jF/MKgnHXDgQjoxDB+09Z7wt6fGwLH06s5JotekgboXeGwUZe75FKDMrt2MVFS
         wKmY7XAgt2XiBS/+/9oEDelblbeAJKpsFoh+gtKtXnRZp8L/mL+bTJ1nLCLuT1Ugu5n8
         +pTOlNT091jsAULPrrbifBeyE7F0Jf0Hjs0t97eKxtHd1PzU7fF+xZ2IB6HtKtD1Vcgq
         SMfSj7RWJAYSLvcJl1fNr/0Z/WzNsWeKtQ5j05hrPXBrDpA5PCJLuluDdWg/LE0iQ6ue
         5sfg==
X-Gm-Message-State: AOJu0YzGRIenQpN1E7hRvvKPQLRyi7f2dVeWvpK9pDKJ2FiGsU9rw/6S
	fr+vMUQh0jz1KJaLvR9VBUjnP+GuqwWFPfVwC8K1YG/0ZeikqHKqvmDeqO674rpWG6F2wYSj0pz
	4NAHVbZXehV2zlwlx+3XtD49Q7hk9cEohGl6CbuxymU107LnYPYlxb/e3oKaJMpLzn1+0YcHuSu
	nJQm0ukEWEy0jQ2QNim/0NWuIVGz5ao+QQyknV5zP+x6P1f7k=
X-Received: by 2002:ac8:5dc8:0:b0:42e:6905:fbbc with SMTP id e8-20020ac85dc8000000b0042e6905fbbcmr9150133qtx.0.1709005000176;
        Mon, 26 Feb 2024 19:36:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2JOtrxHqA+3v1ZkJovDmsmxdzj8omcasD8CQLOmpKxpjAhBVOFh499agTtGDO1zFbRTnCMA==
X-Received: by 2002:ac8:5dc8:0:b0:42e:6905:fbbc with SMTP id e8-20020ac85dc8000000b0042e6905fbbcmr9150115qtx.0.1709004999671;
        Mon, 26 Feb 2024 19:36:39 -0800 (PST)
Received: from localhost.localdomain ([140.177.178.112])
        by smtp.gmail.com with ESMTPSA id q18-20020ac84512000000b0042e5a18d850sm3124171qtn.68.2024.02.26.19.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:36:39 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] qmimodem: First QRTR commit: service discovery
Date: Tue, 27 Feb 2024 03:35:23 +0000
Message-Id: <20240227033523.123542-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: yn-arBpgTcsH0uZgp47Th3zFu6BLq0iD
X-Proofpoint-ORIG-GUID: yn-arBpgTcsH0uZgp47Th3zFu6BLq0iD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270028

This change allows the developer to force the /gobi_0 modem to be initialized
by passing --enable-qrtr to configure. Enabling QRTR will disable the existing
QMUX implementation. This is only temporary -- discovery of the QRTR
modem will be implemented later.

QRTR service discovery works by sending QRTR_TYPE_NEW_LOOKUP to
the special socket of type AF_QIPCRTR. Then the services are received
one-by-one. Soon they will be stored and made available for use by the
qmi client.

Since the QRTR implementation does not implement shutdown, I modified
gobi to handle the failure to avoid lengthy timeouts.
---
 Makefile.am            |   5 +
 configure.ac           |   9 ++
 drivers/qmimodem/qmi.c | 231 +++++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/qmi.h |   1 +
 plugins/gobi.c         |  40 ++++++-
 5 files changed, 285 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 85bebae9..afec6997 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -386,6 +386,11 @@ builtin_sources += $(qmi_sources) \
 			drivers/qmimodem/call-forwarding.c
 
 builtin_sources += plugins/gobi.c
+
+if QMIMODEM_QRTR
+builtin_modules += gobi
+endif
+
 endif
 
 if MBIMMODEM
diff --git a/configure.ac b/configure.ac
index 9fa6531a..14b37eef 100644
--- a/configure.ac
+++ b/configure.ac
@@ -227,6 +227,15 @@ AC_ARG_ENABLE(qmimodem, AS_HELP_STRING([--disable-qmimodem],
 					[enable_qmimodem=${enableval}])
 AM_CONDITIONAL(QMIMODEM, test "${enable_qmimodem}" != "no")
 
+AC_ARG_ENABLE(qrtr, AS_HELP_STRING([--enable_qrtr],
+				[enable Qualcomm QRTR modem support (WIP)]),
+					[enable_qrtr=${enableval}],
+					[enable_qrtr=no])
+AM_CONDITIONAL(QMIMODEM_QRTR, test "${enable_qrtr}" != "no")
+if (test "${enable_qrtr}" == "yes"); then
+	AC_DEFINE(QMIMODEM_QRTR, [], [forces Qualcomm QRTR instead of QMUX])
+fi
+
 AC_ARG_ENABLE(mbimmodem, AS_HELP_STRING([--disable-mbimmodem],
 				[disable MBIM modem support]),
 					[enable_mbimmodem=${enableval}])
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 35751d7c..48f9ce10 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -33,6 +33,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/limits.h>
+#include <linux/qrtr.h>
+#include <sys/socket.h>
 
 #include <ell/ell.h>
 
@@ -1874,6 +1876,235 @@ struct qmi_device *qmi_device_new_qmux(const char *device)
 	return &qmux->super;
 }
 
+struct qmi_device_qrtr {
+	struct qmi_device super;
+	struct discover_data *discover_data;
+};
+
+static void __debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
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
+static void handle_control_packet(struct qmi_device_qrtr *qrtr,
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
+	__debug_ctrl_request(packet, device->debug_func,
+				device->debug_data);
+
+	cmd = L_LE32_TO_CPU(packet->cmd);
+	if (cmd != QRTR_TYPE_NEW_SERVER) {
+		DBG("Unknown command: %d", cmd);
+		return;
+	}
+
+	if (!packet->server.service && !packet->server.instance &&
+		!packet->server.node && !packet->server.port) {
+		DBG("Initial service discovery has completed");
+
+		if (qrtr->discover_data->func)
+			qrtr->discover_data->func(qrtr->discover_data->user_data);
+
+		discover_data_free(qrtr->discover_data);
+		qrtr->discover_data = NULL;
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
+static void handle_packet(struct qmi_device_qrtr *qrtr, uint32_t sending_port,
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
+	handle_control_packet(qrtr, packet);
+}
+
+static bool received_qrtr_data(struct l_io *io, void *user_data)
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
+	DBG("Received %ld bytes from Node: %d Port: 0x%x", bytes_read,
+		addr.sq_node, addr.sq_port);
+
+	if (bytes_read < 0)
+		return true;
+
+	l_util_hexdump(true, buf, bytes_read, qrtr->super.debug_func,
+			qrtr->super.debug_data);
+
+	handle_packet(qrtr, addr.sq_port, buf, bytes_read);
+
+	return true;
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
+	if (qrtr->discover_data)
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
+	qrtr->discover_data = data;
+
+	return 0;
+
+error:
+	l_free(data);
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
+	l_io_set_read_handler(qrtr->super.io, received_qrtr_data, qrtr, NULL);
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
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 99a7d556..cf78ad58 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -105,6 +105,7 @@ static int gobi_probe(struct ofono_modem *modem)
 	if (!data)
 		return -ENOMEM;
 
+#ifndef QMIMODEM_QRTR
 	kernel_driver = ofono_modem_get_string(modem, "KernelDriver");
 	DBG("kernel_driver: %s", kernel_driver);
 
@@ -117,6 +118,9 @@ static int gobi_probe(struct ofono_modem *modem)
 			ofono_modem_get_string(modem, "NetworkInterface"),
 			sizeof(data->main_net_name));
 	DBG("net: %s (%d)", data->main_net_name, data->main_net_ifindex);
+#else
+	(void) kernel_driver;
+#endif
 
 	ofono_modem_set_data(modem, data);
 
@@ -175,7 +179,10 @@ static void shutdown_device(struct ofono_modem *modem)
 
 	cleanup_services(data);
 
-	qmi_device_shutdown(data->device, shutdown_cb, modem, NULL);
+	if (qmi_device_shutdown(data->device, shutdown_cb, modem, NULL)) {
+		DBG("qmi_device_shutdown failed, calling shutdown_cb directly");
+		shutdown_cb(modem);
+	}
 }
 
 static void power_reset_cb(struct qmi_result *result, void *user_data)
@@ -426,11 +433,17 @@ static int gobi_enable(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
+#ifdef QMIMODEM_QRTR
+	(void) device;
+	data->device = qmi_device_new_qrtr();
+#else
 	device = ofono_modem_get_string(modem, "Device");
 	if (!device)
 		return -EINVAL;
 
 	data->device = qmi_device_new_qmux(device);
+#endif
+
 	if (!data->device)
 		return -EIO;
 
@@ -766,3 +779,28 @@ static struct ofono_modem_driver gobi_driver = {
 };
 
 OFONO_MODEM_DRIVER_BUILTIN(gobi, &gobi_driver)
+
+#ifdef QMIMODEM_QRTR
+static struct ofono_modem *qrtr_modem;
+
+static int gobi_init(void)
+{
+	DBG("");
+
+	qrtr_modem = ofono_modem_create(NULL, "gobi");
+	ofono_modem_register(qrtr_modem);
+
+	return 0;
+}
+
+static void gobi_exit(void)
+{
+	DBG("");
+
+	ofono_modem_remove(qrtr_modem);
+	qrtr_modem = NULL;
+}
+
+OFONO_PLUGIN_DEFINE(gobi, "Qualcomm Gobi modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, gobi_init, gobi_exit)
+#endif
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
