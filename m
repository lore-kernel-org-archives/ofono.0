Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54EF171085
	for <ofono@lists.linux.dev>; Fri,  5 Apr 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333340; cv=none; b=phewpInoz4i/4PGKVJBelpm5kB2nwg1ZyZRy6fBaDjmFTZePOK7LHY5u2BgiGkzuXLQFxHB1MAwurCTejqh80dRowyjIpof2OD6le+/fBwco5REXxj2U8NHC2z/q8lByg/dIERJ+P7tS5pvHusc74CmuCymfX1dPDnExmB3VLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333340; c=relaxed/simple;
	bh=33VoHisFOiNZ3p7accZwbbv3JfAjAhoiHOpdmDhKAWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=O0HxpZWyIAABDNYOHg8SzIwzX3dOV2KH2K63lia2JwhLR7wE+DYzNG1CCWhRbywGMB5A9dgEPuNhuxM8DNLMgso/NY5wT6ETT2QoWAQH7q8RthXKnfLUKYrzIgvpJNd98BUP44i5TxQp4yh9JNxPN8D/s7UzpHD8+qnqwgMzBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=KQIPAEpg; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=sTt0CQWB; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="KQIPAEpg";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="sTt0CQWB"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435Dffmj013162
	for <ofono@lists.linux.dev>; Fri, 5 Apr 2024 09:08:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=D2SvxvMOUpvlE8hXx4IheU/tB57v5LC+rwjOJBDTLA0=; b=K
	QIPAEpgn/PmIQjFcKLMoXHRYONmWqdqtVKEYXhGFAxq4uqOXIyZfQkyzoQddCvqB
	SYAigJr0xwDtQBkd42QkuoCY12R5lCDshagIGNWJIAql9a5UbPBXnqWvW/RfkoEw
	f2WZ6Sq966MTS9w7RCdyC5oRSs2HYnnBpykbtf1wCDG93eR05NFS3wvT/tBjnv1F
	bJ4Sw+eS/Fwn83CLeptmE7uh4RVPRTgbiI+kGhNmY9hiqkybOKDGUxfJfzK4BX7N
	YT76nfyKas/WT8nl27pxoa5jw8vOlagIlNEEenh/6IuD8BvEjPw3ikLmkbeqP0np
	0dbQLhVcSzcYdMYRlM/YQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3x9en31vw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 05 Apr 2024 09:08:50 -0700 (PDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-699317e4dd8so22527026d6.3
        for <ofono@lists.linux.dev>; Fri, 05 Apr 2024 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1712333330; x=1712938130; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2SvxvMOUpvlE8hXx4IheU/tB57v5LC+rwjOJBDTLA0=;
        b=sTt0CQWBfzdSmGFtIqR2CWH6J+wePwBE/0K9xtmJoMVQlrocsELiyKONWJxOjUyJwO
         ymJY/yr9BmApC8oIEqpUgFsNQu8y3f2cBErfP/8DJWGbbETrx5NAylGKqtdx6EEOZU8P
         0tjIBTaQ62Eo2sKJUFg22Sn08U+QySrL2gChO3jSSN4U3DryquYey5EP2K9L2NuOawBk
         TsYrZ27UbgBJ8n6F5GH7IANLsXzxHIPPzPvHU1q+R9xoAIvvrft/Njlqe5gBuTaEb2T+
         Y5RBKgRyMB8uLb/hjq1IOKV1I0zzeweKHKXZziNAuPcQ/BIMi/cNP1j1ylxX07HfIHVB
         PStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333330; x=1712938130;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2SvxvMOUpvlE8hXx4IheU/tB57v5LC+rwjOJBDTLA0=;
        b=ghbQofhkdBJuEemuZo6dGKrUKh93X81DjGf9v6pMPaFGGmtNrTu7WNBbCKHoYq6Ron
         zqgrlTin1+4qyZVaaozmUxKHQQJYT6/J0OiUFdRlLmUxz9PzxpofwIDiCMDRqybKI1Kf
         p1jRtWTG+Jv4hCgysjAukIGFoR4KcKQzP7GtlIoh9dJbVWHJ1AzUPhpSQPQTiT60qTRw
         D0qy4mnIx1kFZ1LU9wLEbywYQJOElhVA7fA4oJTTpCYTWiJIyMBzcVROw36oMKeCe1Qz
         l9LKMnFygg5IyZcMxYbY3K2ONKhQunv5rmwngmX5Zc514MtwODItvkeyQOv0oVGc6oQk
         7QAA==
X-Gm-Message-State: AOJu0YzT6vC7LMHmA5gu7IyhqhqR2lrpqensUvlbjS8vcZVOSAM/FWIg
	bY5cx9bn042J/W5g37238/136ept/uSgvNwQHTUvRHnwzHuWZVteAeut6CAxH7hvT5BiocsZuH7
	GnQRmUALXhO+RG2x5Agb1uUwyXmRURMh9To4g1emJA+zvDibiM7Prr8dfWn0SYp0mJQ344aDaUp
	Cs39QfpnEp/cmEWXjBekjr+uBnIqCInMPAxVO/QzAnY2TC6PI=
X-Received: by 2002:a05:6214:4001:b0:696:51ea:a2 with SMTP id kd1-20020a056214400100b0069651ea00a2mr1836725qvb.32.1712333329983;
        Fri, 05 Apr 2024 09:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNgxiFZf5WG6Af58pAew3No/wj+n2LeNcU6UdM8kZ4mNpmJjDGNfTKuCpy01IqjPWEhEJngA==
X-Received: by 2002:a05:6214:4001:b0:696:51ea:a2 with SMTP id kd1-20020a056214400100b0069651ea00a2mr1836667qvb.32.1712333329248;
        Fri, 05 Apr 2024 09:08:49 -0700 (PDT)
Received: from localhost.localdomain ([140.141.139.15])
        by smtp.gmail.com with ESMTPSA id t16-20020a0cde10000000b006991de7276asm728850qvk.94.2024.04.05.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:08:49 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/2] qmi: Create QRTR unit testing framework
Date: Fri,  5 Apr 2024 16:07:01 +0000
Message-Id: <20240405160702.29261-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: QNFSfr5oghnEBzz8uE5kqsqbNcEqK3pS
X-Proofpoint-ORIG-GUID: QNFSfr5oghnEBzz8uE5kqsqbNcEqK3pS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_17,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050114

Use actual AF_QIPCRTR sockets to create test QRTR services that may be
utilized to validate the functionality of the QRTR implementation of
qmi_device.

These initial tests validate that the qmi code is performing service
lookup and instantiation properly.
---
 Makefile.am              |   7 ++
 unit/test-qmimodem-qmi.c | 265 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 272 insertions(+)
 create mode 100644 unit/test-qmimodem-qmi.c

diff --git a/Makefile.am b/Makefile.am
index 85bebae97830..3e545e8f11de 100644
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
@@ -953,6 +954,12 @@ unit_test_mbim_SOURCES = unit/test-mbim.c \
 unit_test_mbim_LDADD = $(ell_ldadd)
 unit_objects += $(unit_test_mbim_OBJECTS)
 
+unit_test_qmimodem_qmi_SOURCES = unit/test-qmimodem-qmi.c src/common.c \
+			src/util.c src/log.c \
+			drivers/qmimodem/qmi.c
+unit_test_qmimodem_qmi_LDADD = @GLIB_LIBS@ $(ell_ldadd)
+unit_objects += $(unit_test_qmimodem_qmi_OBJECTS)
+
 unit/test-provision.db: unit/test-provision.json
 	$(AM_V_GEN)$(srcdir)/tools/provisiontool generate \
 		--infile $< --outfile $@
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
new file mode 100644
index 000000000000..619e813f78d6
--- /dev/null
+++ b/unit/test-qmimodem-qmi.c
@@ -0,0 +1,265 @@
+/*
+ *  oFono - Open Source Telephony
+ *  Copyright (C) 2024  Cruise, LLC
+ *
+ *  SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include "drivers/qmimodem/qmi.h"
+#include <src/ofono.h>
+
+#include <string.h>
+#include <stdio.h>
+#include <assert.h>
+#include <ell/ell.h>
+
+#include <sys/socket.h>
+#include <linux/qrtr.h>
+
+#define TEST_SERVICE_COUNT	2
+#define TEST_TIMEOUT		5
+
+struct test_info {
+	int service_fds[TEST_SERVICE_COUNT];
+	struct qmi_device *device;
+	struct l_timeout *timeout;
+	struct l_queue *services;
+	bool discovery_callback_called : 1;
+};
+
+static uint32_t unique_service_type(uint32_t index)
+{
+	/* Try to use a value that will not conflict with any real services. */
+	return index + 10000;
+}
+
+static uint32_t unique_service_version(uint32_t index)
+{
+	return index + 10;
+}
+
+static uint32_t unique_service_instance(uint32_t index)
+{
+	return index + 20;
+}
+
+static int create_service(int i)
+{
+	int fd;
+	struct sockaddr_qrtr addr;
+	socklen_t addrlen;
+	struct qrtr_ctrl_pkt packet;
+	ssize_t bytes_sent;
+
+	fd = socket(AF_QIPCRTR, SOCK_DGRAM, 0);
+	if (fd == -1)
+		return -errno;
+
+	/*
+	 * The control node is configured by the system. Use getsockname to
+	 * get its node.
+	 */
+	addrlen = sizeof(addr);
+	if (getsockname(fd, (struct sockaddr *) &addr, &addrlen) == -1) {
+		DBG("getsockname failed: %s", strerror(errno));
+		goto error;
+	}
+
+	if (addr.sq_family != AF_QIPCRTR || addrlen != sizeof(addr)) {
+		DBG("Unexpected sockaddr from getsockname. family: %d size: %d",
+						addr.sq_family, addrlen);
+		goto error;
+	}
+
+	/* Node and port are assigned automatically so no need to set them */
+	memset(&packet, 0, sizeof(packet));
+	packet.cmd = L_CPU_TO_LE32(QRTR_TYPE_NEW_SERVER);
+	packet.server.service = L_CPU_TO_LE32(unique_service_type(i));
+	packet.server.instance = L_CPU_TO_LE32(
+					unique_service_instance(i) << 8 |
+					unique_service_version(i));
+
+	bytes_sent = sendto(fd, &packet, sizeof(packet), 0,
+				(struct sockaddr *) &addr, addrlen);
+	if (bytes_sent != sizeof(packet)) {
+		DBG("sendto to set up the qrtr service failed: %s",
+						strerror(errno));
+		goto error;
+	}
+
+	return fd;
+
+error:
+	close(fd);
+
+	return -errno;
+}
+
+static void setup_test_qrtr_services(struct test_info *info)
+{
+	int i;
+
+	for (i = 0; i < TEST_SERVICE_COUNT; ++i) {
+		info->service_fds[i] = create_service(i);
+		assert(info->service_fds[i] >= 0);
+	}
+}
+
+static void debug_log(const char *str, void *user_data)
+{
+	printf("%s\n", str);
+}
+
+static void test_timeout_cb(struct l_timeout *timeout, void *user_data)
+{
+	DBG("Test timed out!");
+	assert(false);
+}
+
+static struct test_info *test_setup(void)
+{
+	struct test_info *info;
+
+	l_main_init();
+
+	info = l_new(struct test_info, 1);
+	setup_test_qrtr_services(info);
+	info->device = qmi_device_new_qrtr();
+	assert(info->device);
+
+	/* Enable ofono logging */
+	qmi_device_set_debug(info->device, debug_log, NULL);
+
+	info->services = l_queue_new();
+	info->timeout = l_timeout_create(TEST_TIMEOUT, test_timeout_cb, info,
+								NULL);
+
+	return info;
+}
+
+static void test_cleanup(struct test_info *info)
+{
+	int i;
+
+	l_timeout_remove(info->timeout);
+	l_queue_destroy(info->services,
+				(l_queue_destroy_func_t) qmi_service_unref);
+	qmi_device_free(info->device);
+
+	/* The qrtr services will be destroyed automatically. */
+	for (i = 0; i < TEST_SERVICE_COUNT; ++i)
+		close(info->service_fds[i]);
+
+	l_free(info);
+
+	l_main_exit();
+}
+
+static void test_create_qrtr_device(const void *data)
+{
+	struct test_info *info = test_setup();
+
+	test_cleanup(info);
+}
+
+static void discovery_complete_cb(void *user_data)
+{
+	struct test_info *info = user_data;
+
+	info->discovery_callback_called = true;
+}
+
+static void perform_discovery(struct test_info *info)
+{
+	qmi_device_discover(info->device, discovery_complete_cb, info, NULL);
+
+	while (!info->discovery_callback_called)
+		l_main_iterate(-1);
+}
+
+static void test_discovery(const void *data)
+{
+	struct test_info *info = test_setup();
+
+	perform_discovery(info);
+
+	test_cleanup(info);
+}
+
+static void create_service_cb(struct qmi_service *service, void *user_data)
+{
+	struct test_info *info = user_data;
+
+	service = qmi_service_ref(service);
+	l_queue_push_tail(info->services, service);
+}
+
+/* Callbacks could queue other callbacks so continue until there are no more. */
+static void perform_all_pending_work(void)
+{
+	l_main_iterate(0);
+
+	while (l_main_prepare() != -1)
+		l_main_iterate(0);
+}
+
+static void test_create_services(const void *data)
+{
+	struct test_info *info = test_setup();
+	uint32_t service_type;
+	int i;
+
+	perform_discovery(info);
+
+	for (i = 0; i < TEST_SERVICE_COUNT; i++) {
+		struct qmi_service *service;
+		uint16_t major, minor;
+
+		service_type = unique_service_type(i);
+		assert(qmi_service_create(info->device, service_type,
+						create_service_cb, info, NULL));
+		perform_all_pending_work();
+
+		assert(l_queue_length(info->services) == 1);
+		service = l_queue_pop_head(info->services);
+		assert(service);
+
+		assert(qmi_service_get_version(service, &major, &minor));
+		assert(major == unique_service_version(i));
+		assert(minor == 0);
+
+		qmi_service_unref(service);
+	}
+
+	/*
+	 * Confirm that an unknown service cannot be created and does not
+	 * call the callback.
+	 */
+	service_type = unique_service_type(TEST_SERVICE_COUNT);
+	assert(!qmi_service_create(info->device, service_type,
+					create_service_cb, info, NULL));
+	perform_all_pending_work();
+	assert(l_queue_isempty(info->services));
+
+	test_cleanup(info);
+}
+
+int main(int argc, char **argv)
+{
+	int result;
+
+	/* Enable all DBG logging */
+	__ofono_log_init(argv[0], "*", FALSE);
+
+	l_test_init(&argc, &argv);
+	l_test_add("QRTR device creation", test_create_qrtr_device, NULL);
+	l_test_add("QRTR discovery", test_discovery, NULL);
+	l_test_add("QRTR services may be created", test_create_services, NULL);
+	result = l_test_run();
+
+	return result;
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
