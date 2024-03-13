Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC645A4E0
	for <ofono@lists.linux.dev>; Wed, 13 Mar 2024 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356593; cv=none; b=NQS8mBI/IPHkHTsczIXvZBxr5hiRqt20tgB3twnl8SuGFiCUr7C0nBw0c9zSnmBk87bBNjk2O41tTCbXSFLtLbDVFq2xXojkA7UPl5m2msJzzqHMb+MstiAjLf3o1W7BEnDLqbtD0N0toRGMBLxOyLhwyraPoLbYrpBeSnFXdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356593; c=relaxed/simple;
	bh=U5COmlmRSDj3WIy/yXZxMGpBb2LScYlOMJQiENsTgcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o1VnaEcy95esxTLIrWdP70G6NVioVxkq+zrMA8jYqkfNM5UZxHZsG69PdOGL1krcSLaDq9cZ6MrduQMZ/XvYoJcSQNEUA1KghQH2aHoDdi0ElFEJW2nOImklsZzZcwwqJHHw+3kXsGSIpKX0WQLwSob5mRy+nlkgfjPb9vm0ofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=F2PXbWn1; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=YgRALKbW; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="F2PXbWn1";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="YgRALKbW"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DESRXb017692
	for <ofono@lists.linux.dev>; Wed, 13 Mar 2024 12:03:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=TrGGZkzBL/BCJ9Gu3MjhDaYaghMExnoHcoFR9sBBHYc=; b=F
	2PXbWn1gXvEZovG7xUhA6g/sR9MNpu8f+dK7CT0au2VlMkuFOoTL2CWoK3fvSxR2
	bm8+ayJIzu/iAWJBOzAUYKE+P4qQlE1H+iwvQb8yX1iU6xcq/UVXrxPF2xO43tsE
	/scLDz2L4wALh6bI8G+RpznbrJjQq/LvvVP+ZtQyG3Tl42Ju1tEopC7UX2tQv3kd
	UwYvVy5SCIawSlWgPWYmkFN7tAqJAzS6HEo5diiiXG6S9NamTrQm5DaC/iDTYaik
	sP0lEbPuFPns1TjqmZS5OE6ZhNtRGqIatYGz2cAGbgbg0Dqr6fHoFQc8Mn/HGorF
	hS42WsqYqwcdHStkTnRKA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wrn27um52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 13 Mar 2024 12:03:04 -0700 (PDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42ea54868d2so930351cf.3
        for <ofono@lists.linux.dev>; Wed, 13 Mar 2024 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1710356583; x=1710961383; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TrGGZkzBL/BCJ9Gu3MjhDaYaghMExnoHcoFR9sBBHYc=;
        b=YgRALKbWtGPC7UVlnLSgasnxGlwULLhKCZa3KEeqsBw2yP2kotJEUQrZFxdtzI1KCY
         XB14Ol7DyeyqH6wB7QiGmdIuIHY/7pOLUPyCzoxBeQRHv+ZSwRkQdY3rY8RCr8d6TLaV
         9Usblfyj7YmBh9u6AfeqKe49rG4y4heJlABrwezt6JSSs9yrJSWmWUHOSmQu6Q2Rg4Fc
         iBCjVmRswxl9v1UFk4CNZ7s5cgO8CWFzicl2S8bpZYXs7tnsIskSeHLqasMJQ0hmnxQ2
         qyCWDxCaetnPy5+RKpdNFPJLIWbWwEtZr6UXaZk856SVPuqDc4FF+6bNXLqgBeZjhcBv
         1UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710356583; x=1710961383;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrGGZkzBL/BCJ9Gu3MjhDaYaghMExnoHcoFR9sBBHYc=;
        b=MeJUhdujZX0DLCyxXqfKLfBXV/ax6Hyj9c2trH5kil9jFA5hvjhw1RnVTt8dOVwJRV
         cDImYfxNaUPSCffz53iJBhBDDPUtLxakEGiYH26MAql1XmLS6JGwgVNrUeVjHq6N5DG8
         ERNvYeMPHr7ZssbyYVvQpfHTL2GvaM3m0WwtZdKS6Czai54JgzR/7nDhfmQ55kPP53Z5
         MAY4VkmDOXPLzJz9JonWZ+AHNV2dXJn6yyPLODi9hJkeKRNHt2UV0IIzYb4cCnSB9sAq
         YDQXSWXuG8UjJNNFU4FMfX3pecZgRyvIwFW7aKyAa7FLykN1pYdKcFt+bcFUQfrwieD/
         bdxA==
X-Gm-Message-State: AOJu0YyOI6pCoYBXS6k7S+5XKda+iMf/anTVq4fzkm9s4WG1AZA3chAd
	9rSZrcs7CRi0NYZvbefK8YHc4Rv6uU63y/m6R9PEJy6HrguXjH/hPZ4ckh0yZ96/XV2B48E14mj
	3NeGSqQAnICYD9FjHbgmJLldorWQ+JVfRsO+kcL9y648EjIpSLmIFLYGVH0UClZ2RQJ+Rt++4RX
	eEC2gADJ4WEXq3V0r1tdRgbyVYpTANG9lVSGpvtqmnpH837cg=
X-Received: by 2002:ac8:5d93:0:b0:42e:b90c:cffa with SMTP id d19-20020ac85d93000000b0042eb90ccffamr16074057qtx.0.1710356582818;
        Wed, 13 Mar 2024 12:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH68de5d77cXfuj07GxptYxY/gin6q4p048uCm0wsejr3iXUrIu/Xfoki9IrUDW/huG/Ecpbg==
X-Received: by 2002:ac8:5d93:0:b0:42e:b90c:cffa with SMTP id d19-20020ac85d93000000b0042eb90ccffamr16074012qtx.0.1710356582215;
        Wed, 13 Mar 2024 12:03:02 -0700 (PDT)
Received: from localhost.localdomain ([140.177.166.150])
        by smtp.gmail.com with ESMTPSA id t11-20020ac86a0b000000b0042ef4d442bcsm5120677qtr.82.2024.03.13.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:03:01 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [RFC PATCH] qmi: Initial unit test POC for QRTR
Date: Wed, 13 Mar 2024 19:01:33 +0000
Message-Id: <20240313190133.169510-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: FV-rzJaZdwyLqqHAYRxjuKF7Zxb052gk
X-Proofpoint-ORIG-GUID: FV-rzJaZdwyLqqHAYRxjuKF7Zxb052gk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130146

Looking for some feedback on my approach here. I need
to be able to fake the AF_QIPCRTR socket, but still
utilize the socket APIs so the tests can inspect and
send sockaddr_qrtr structs.

The approach that I am taking involves
1. Injecting certain dependencies to a private function
   used only internally in qmi.c and in the unit tests
2. Utilizing the linker's wrap directive to allow
   sendto and recvfrom to be overridden.

This allows me to inject a UNIX domain socket while
still validing the correct usage of sendto and
recvfrom.

I am open to trying alternative approaches if there
is a different strategy you would like to see.
---
 Makefile.am              |   8 +
 drivers/qmimodem/qmi.c   |  76 ++++++----
 unit/test-qmimodem-qmi.c | 310 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+), 27 deletions(-)
 create mode 100644 unit/test-qmimodem-qmi.c

diff --git a/Makefile.am b/Makefile.am
index 85bebae9..0510236b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -858,6 +858,7 @@ unit_tests = unit/test-common unit/test-util \
 				unit/test-simutil unit/test-stkutil \
 				unit/test-sms \
 				unit/test-mbim \
+				unit/test-qmimodem-qmi \
 				unit/test-rilmodem-cs \
 				unit/test-rilmodem-sms \
 				unit/test-rilmodem-cb \
@@ -953,6 +954,13 @@ unit_test_mbim_SOURCES = unit/test-mbim.c \
 unit_test_mbim_LDADD = $(ell_ldadd)
 unit_objects += $(unit_test_mbim_OBJECTS)
 
+unit_test_qmimodem_qmi_SOURCES = unit/test-qmimodem-qmi.c src/common.c \
+			src/util.c src/log.c \
+			drivers/qmimodem/qmi.c
+unit_test_qmimodem_qmi_LDADD = @GLIB_LIBS@ $(ell_ldadd)
+unit_test_qmimodem_qmi_LDFLAGS = -Wl,--wrap=sendto -Wl,--wrap=recvfrom
+unit_objects += $(unit_test_qmimodem_qmi_OBJECTS)
+
 unit/test-provision.db: unit/test-provision.json
 	$(AM_V_GEN)$(srcdir)/tools/provisiontool generate \
 		--infile $< --outfile $@
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3408c32a..c4f17880 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1948,6 +1948,7 @@ struct qmi_device *qmi_device_new_qmux(const char *device)
 
 struct qmi_device_qrtr {
 	struct qmi_device super;
+	uint32_t control_node;
 	qmi_shutdown_func_t shutdown_func;
 	void *shutdown_user_data;
 	qmi_destroy_func_t shutdown_destroy;
@@ -2148,10 +2149,11 @@ static int qmi_device_qrtr_discover(struct qmi_device *device,
 					void *user_data,
 					qmi_destroy_func_t destroy)
 {
+	struct qmi_device_qrtr *qrtr =
+		l_container_of(device, struct qmi_device_qrtr, super);
 	struct discover_data *data;
 	struct qrtr_ctrl_pkt packet;
 	struct sockaddr_qrtr addr;
-	socklen_t addr_len;
 	int rc;
 	ssize_t bytes_written;
 	int fd;
@@ -2171,32 +2173,16 @@ static int qmi_device_qrtr_discover(struct qmi_device *device,
 
 	fd = l_io_get_fd(device->io);
 
-	/*
-	 * The control node is configured by the system. Use getsockname to
-	 * get its value.
-	 */
-	addr_len = sizeof(addr);
-	rc = getsockname(fd, (struct sockaddr *) &addr, &addr_len);
-	if (rc) {
-		DBG("getsockname failed: %s", strerror(errno));
-		rc = -errno;
-		goto error;
-	}
-
-	if (addr.sq_family != AF_QIPCRTR || addr_len != sizeof(addr)) {
-		DBG("Unexpected sockaddr from getsockname. family: %d size: %d",
-			addr.sq_family, addr_len);
-		rc = -EIO;
-		goto error;
-	}
-
+	memset(&addr, 0, sizeof(addr));
+	addr.sq_family = AF_QIPCRTR;
+	addr.sq_node = qrtr->control_node;
 	addr.sq_port = QRTR_PORT_CTRL;
 	memset(&packet, 0, sizeof(packet));
 	packet.cmd = L_CPU_TO_LE32(QRTR_TYPE_NEW_LOOKUP);
 
 	bytes_written = sendto(fd, &packet,
 				sizeof(packet), 0,
-				(struct sockaddr *) &addr, addr_len);
+				(struct sockaddr *) &addr, sizeof(addr));
 	if (bytes_written < 0) {
 		DBG("Failure sending data: %s", strerror(errno));
 		rc = -errno;
@@ -2236,17 +2222,15 @@ static const struct qmi_device_ops qrtr_ops = {
 	.destroy = qmi_device_qrtr_destroy,
 };
 
-struct qmi_device *qmi_device_new_qrtr(void)
+/* This method is separated so unit tests can inject dependencies. */
+struct qmi_device *qmi_device_new_qrtr_private(int fd, uint32_t control_node)
 {
 	struct qmi_device_qrtr *qrtr;
-	int fd;
-
-	fd = socket(AF_QIPCRTR, SOCK_DGRAM, 0);
-	if (fd < 0)
-		return NULL;
 
 	qrtr = l_new(struct qmi_device_qrtr, 1);
 
+	qrtr->control_node = control_node;
+
 	if (qmi_device_init(&qrtr->super, fd, &qrtr_ops) < 0) {
 		close(fd);
 		l_free(qrtr);
@@ -2258,6 +2242,44 @@ struct qmi_device *qmi_device_new_qrtr(void)
 	return &qrtr->super;
 }
 
+struct qmi_device *qmi_device_new_qrtr(void)
+{
+	int fd;
+	struct sockaddr_qrtr addr;
+	socklen_t addrlen;
+	struct qmi_device *device;
+
+	fd = socket(AF_QIPCRTR, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return NULL;
+
+	/*
+	 * The control node is configured by the system. Use getsockname to
+	 * get its value.
+	 */
+	addrlen = sizeof(addr);
+	if (getsockname(fd, (struct sockaddr *) &addr, &addrlen) == -1) {
+		DBG("getsockname failed: %s", strerror(errno));
+		goto error;
+	}
+
+	if (addr.sq_family != AF_QIPCRTR || addrlen != sizeof(addr)) {
+		DBG("Unexpected sockaddr from getsockname. family: %d size: %d",
+			addr.sq_family, addrlen);
+		goto error;
+	}
+
+	device = qmi_device_new_qrtr_private(fd, addr.sq_node);
+	if (!device)
+		goto error;
+
+	return device;
+
+error:
+	close(fd);
+	return NULL;
+}
+
 struct qmi_param *qmi_param_new(void)
 {
 	struct qmi_param *param;
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
new file mode 100644
index 00000000..e2f18680
--- /dev/null
+++ b/unit/test-qmimodem-qmi.c
@@ -0,0 +1,310 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2024  Cruise LLC
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include "drivers/qmimodem/qmi.h"
+
+#include <string.h>
+#include <stdio.h>
+#include <assert.h>
+#include <linux/qrtr.h>
+#include <ell/ell.h>
+
+#include <ofono/types.h>
+#include <src/ofono.h>
+
+#include <sys/socket.h>
+#include <sys/param.h>
+
+#define CONTROL_NODE 42
+#define SERVICE_NODE 43
+
+struct sendto_record {
+	int sockfd;
+	int flags;
+	struct sockaddr_qrtr sockaddr;
+	size_t len;
+	uint8_t data[];
+};
+
+struct recvfrom_entry {
+	struct sockaddr_qrtr sockaddr;
+	size_t len;
+	uint8_t data[];
+};
+
+static const struct sockaddr_qrtr control_addr = {
+	.sq_family = AF_QIPCRTR,
+	.sq_node = CONTROL_NODE,
+	.sq_port = QRTR_PORT_CTRL,
+};
+
+struct test_info {
+	struct qmi_device *device;
+	int test_socket;
+	int client_socket; /* Used by qmi_device to send/receive */
+	struct l_queue *sendto;
+	struct l_queue *recvfrom;
+	bool discovery_callback_called : 1;
+};
+
+static struct test_info *info;
+
+ssize_t __wrap_sendto(int sockfd, const void *buf, size_t len, int flags,
+			const struct sockaddr *dest_addr, socklen_t addrlen)
+{
+	struct sendto_record *record;
+
+	if (addrlen != sizeof(struct sockaddr_qrtr)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	record = l_malloc(sizeof(struct sendto_record) + len);
+	record->sockfd = sockfd;
+	record->flags = flags;
+	memcpy(&record->sockaddr, dest_addr, addrlen);
+	record->len = len;
+	memcpy(record->data, buf, len);
+
+	l_queue_push_tail(info->sendto, record);
+
+	return len;
+}
+
+static void wakeup_client_read_handler(void)
+{
+	char c = ' ';
+
+	write(info->test_socket, &c, sizeof(char));
+}
+
+static void stop_client_read_handler(void)
+{
+	char c;
+
+	if (l_queue_isempty(info->recvfrom))
+		read(info->client_socket, &c, sizeof(c));
+}
+
+static void allow_client_to_read_all(void)
+{
+	int max_loops = l_queue_length(info->recvfrom) + 10;
+
+	wakeup_client_read_handler();
+	while (!l_queue_isempty(info->recvfrom)) {
+		l_main_iterate(0);
+
+		max_loops--;
+		assert(max_loops > 0);
+	}
+}
+
+ssize_t __wrap_recvfrom(int sockfd, void *buf, size_t len, int flags,
+			struct sockaddr *src_addr, socklen_t *addrlen)
+{
+	struct recvfrom_entry *entry;
+	size_t data_bytes_to_copy;
+	socklen_t addr_bytes_to_copy;
+
+	if (l_queue_isempty(info->recvfrom)) {
+		errno = EAGAIN;
+		return -1;
+	}
+
+	entry = l_queue_pop_head(info->recvfrom);
+
+	/*
+	 * This does not handle the case where the client passes in a buffer
+	 * that is too small.
+	 */
+	data_bytes_to_copy = MIN(len, entry->len);
+	memcpy(buf, entry->data, data_bytes_to_copy);
+
+	addr_bytes_to_copy = MIN(*addrlen, sizeof(struct sockaddr_qrtr));
+	memcpy(src_addr, &entry->sockaddr, addr_bytes_to_copy);
+	*addrlen = addr_bytes_to_copy;
+
+	l_free(entry);
+
+	stop_client_read_handler();
+
+	return data_bytes_to_copy;
+}
+
+struct qmi_device *qmi_device_new_qrtr_private(int fd, uint32_t control_node);
+
+static void debug_log(const char *str, void *user_data)
+{
+	printf("%s\n", str);
+}
+
+static void test_setup(void)
+{
+	int sockets[2];
+
+	l_main_init();
+
+	info = l_new(struct test_info, 1);
+	info->sendto = l_queue_new();
+	info->recvfrom = l_queue_new();
+
+	socketpair(AF_UNIX, SOCK_DGRAM, 0, sockets);
+	info->test_socket = sockets[0];
+	info->client_socket = sockets[1];
+
+	info->device = qmi_device_new_qrtr_private(info->client_socket,
+							CONTROL_NODE);
+	assert(info->device);
+
+	/* Enable ofono logging */
+	qmi_device_set_debug(info->device, debug_log, NULL);
+}
+
+static void test_cleanup(void)
+{
+	l_queue_destroy(info->recvfrom, l_free);
+	l_queue_destroy(info->sendto, l_free);
+
+	close(info->test_socket);
+	qmi_device_free(info->device);
+
+	l_free(info);
+	info = NULL;
+
+	l_main_exit();
+}
+
+static void create_qrtr_device(const void *data)
+{
+	test_setup();
+	test_cleanup();
+}
+
+static void discovery_complete_cb(void *user_data)
+{
+	assert(user_data == info);
+	info->discovery_callback_called = true;
+}
+
+static void enqueue_new_server_packet(uint32_t service, uint8_t version,
+					uint32_t instance, uint32_t node,
+					uint32_t port)
+{
+	struct recvfrom_entry *entry = l_malloc(
+				sizeof(struct recvfrom_entry) +
+				sizeof(struct qrtr_ctrl_pkt));
+	struct qrtr_ctrl_pkt *new_server =
+				(struct qrtr_ctrl_pkt *) entry->data;
+
+	memcpy(&entry->sockaddr, &control_addr, sizeof(struct sockaddr_qrtr));
+
+	entry->len = sizeof(struct qrtr_ctrl_pkt);
+	new_server->cmd = L_CPU_TO_LE32(QRTR_TYPE_NEW_SERVER);
+	new_server->server.service = L_CPU_TO_LE32(service);
+	new_server->server.instance = L_CPU_TO_LE32(instance << 8 | version);
+	new_server->server.node = L_CPU_TO_LE32(node);
+	new_server->server.port = L_CPU_TO_LE32(port);
+
+	l_queue_push_tail(info->recvfrom, entry);
+}
+
+static void initiate_discovery(const void *data)
+{
+	int rc;
+	struct sendto_record *record;
+	const struct qrtr_ctrl_pkt *packet;
+
+	test_setup();
+
+	rc = qmi_device_discover(info->device, discovery_complete_cb, info,
+								NULL);
+	assert(rc == 0);
+
+	assert(l_queue_length(info->sendto) == 1);
+	record = l_queue_pop_head(info->sendto);
+
+	assert(record->sockfd == info->client_socket);
+	assert(record->flags == 0);
+	assert(record->sockaddr.sq_family == AF_QIPCRTR);
+	assert(record->sockaddr.sq_node == CONTROL_NODE);
+	assert(record->sockaddr.sq_port == QRTR_PORT_CTRL);
+
+	assert(record->len == sizeof(struct qrtr_ctrl_pkt));
+	packet = (const struct qrtr_ctrl_pkt *) record->data;
+	assert(packet->cmd == QRTR_TYPE_NEW_LOOKUP);
+
+	l_free(record);
+
+	test_cleanup();
+}
+
+static void send_servers(const void *data)
+{
+	int i;
+	int rc;
+
+	test_setup();
+
+	rc = qmi_device_discover(info->device, discovery_complete_cb, info,
+								NULL);
+	assert(rc == 0);
+
+	for (i = 1; i <= 2; i++)
+		enqueue_new_server_packet(i, i + 10, 1, SERVICE_NODE, i + 20);
+
+	enqueue_new_server_packet(0, 0, 0, 0, 0);
+
+	allow_client_to_read_all();
+	assert(info->discovery_callback_called);
+
+	for (i = 1; i <= 2; i++) {
+		uint16_t major, minor;
+
+		assert(qmi_device_has_service(info->device, i));
+
+		assert(qmi_device_get_service_version(info->device, i,
+							&major, &minor));
+		assert(major == i + 10);
+		assert(minor == 0);
+	}
+
+	assert(!qmi_device_has_service(info->device, i));
+
+	test_cleanup();
+}
+
+int main(int argc, char **argv)
+{
+	/* Enable all DBG logging */
+	__ofono_log_init(argv[0], "*", FALSE);
+
+	l_test_init(&argc, &argv);
+
+	l_test_add("QRTR device creation", create_qrtr_device, NULL);
+	l_test_add("QRTR discovery sends NEW_LOOKUP", initiate_discovery, NULL);
+	l_test_add("QRTR discovery reads NEW_SERVERs", send_servers, NULL);
+
+	return l_test_run();
+}
-- 
2.40.1


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
