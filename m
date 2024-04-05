Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E197917276C
	for <ofono@lists.linux.dev>; Fri,  5 Apr 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344776; cv=none; b=fmPf7UDf2ZbYN2qA2rrDIC/axVWOABqPvMKhccQ8+n/zX2C//U0FWEqULuf4rl9mfFHHYfKfgl6kvVW6nPA+hkEy+NaPu4YWuQxfaPoOAauwgGmfho3C1htvmo5DugklkTteJgMst3HVSVREX+f0yhTOs2TQ8F0yQ/JTfs5dB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344776; c=relaxed/simple;
	bh=llRvzofzgNHzqcG72DxZoD9fht4s5/fikVluwfJlNMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EgdCeKAgEIR9UAf50IloYeK0vzFxyKHWMUjTVToQLqdnr/H5ykjm/jGi5jpJKeAN1hGan/DN/za8hcc4BAJ6mIrzYc7ZkloylsvBY0BcHzP1gdr+AqyPWgbng01hnJ7vUlOXpTeKWsTot1HgF2VwcJFMoT2IiQqv2XRXCp0/Ky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=PEDToIdJ; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Gd2X2Cz7; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="PEDToIdJ";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Gd2X2Cz7"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435DYCjK026984
	for <ofono@lists.linux.dev>; Fri, 5 Apr 2024 12:08:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=Ce448ze2bpO5qRUS7xzRG02QNoXJHWb8zIFDKBfh5zE=; b=P
	EDToIdJWNf9VAJubQXqpB+/rEy68ZpVXtq01HkdwlZtvUb3TxLHMsNuseaPdXxYF
	nCATtVCFgpZz5tQXs6iD8p7bQmBO8mhNnc3sb4N+9dhY9RTlla5CxW80kkPPWorU
	fZo4CepsfemWjHJS7hoPZa9wIZNITCWWFV2frn7xQeFQzdK8Q2XDKrkdm/gdI8Ke
	Se1Q3nHCeAXVsximrmOARC4PP4twDKIqMQCTIDtCUQ3QV2NqcqiTpH/hASURgQQz
	ImI0wZtSw/piX8oWWgaKadNF3dWaPDZuae/P3N8cEC4vnrToMgu8akp/gT+RzyBh
	0LwItrkb8lcsXTMegeKrA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xah3x0c8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 05 Apr 2024 12:08:08 -0700 (PDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-43168f0d394so30217941cf.3
        for <ofono@lists.linux.dev>; Fri, 05 Apr 2024 12:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1712344087; x=1712948887; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ce448ze2bpO5qRUS7xzRG02QNoXJHWb8zIFDKBfh5zE=;
        b=Gd2X2Cz766/nGOTxeK7+vXN2LgMJkZ7W012TIlGySu3TT/1PKfLyA4QkHSkc9R3lpK
         K10+EnqlTluuOV83tIJB3edhc4kIe5AULsSSRjZPzyX8wuY0x8cOEVtmhxiBCZ5++zDJ
         I6V8UECkoS1LJi0d/Z4oN+OLIwNpFny36D4vUMmeGAbWzpbmLoyHHb3ZRIsCdsggQhfj
         BZs0+0BLqJfXXr+DKNFAlI/V6H1ebHGVB23Y1bEGHvWziLJRKAkKdPpLPSEqvP5RUUJd
         pRDupUVodmNdOMoemvJfP4v41ttF6H0efnZA202OLnfb0HgTm+/Gv3LP5GNw5w6PPNC4
         IWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712344087; x=1712948887;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ce448ze2bpO5qRUS7xzRG02QNoXJHWb8zIFDKBfh5zE=;
        b=LgnQY/CyVoMOh41Pn/p4dKt+5IzfnABZLhrvesnS/u9IFWHhBbStuS3p6s/AwoAaHb
         8jmpcfAhU+AuRFwj1Tysd8WEvNOD9O/d/+QRbwG6WiNJqbHLH65LTDCea7Hky1Y5oXEi
         fTvNoQ3NHl4Le+ahMcE7TEQY0C2khXDHHF+KAaAktCaYl2ns+B+4YUjQKAXekHzpKa1g
         Ql5d7E/VXr/LoSnHbdv+/lzUkWkFkEvLytYHEjxoH9v1k/DT7L9tUbBDxnp6v8MU1Xvj
         zaXNldM9wBeMgbZOE78SuH0TPyH358MTZrpneHZiSvmabkltRnQ+3rC7OV0lBuHknFHr
         zU1g==
X-Gm-Message-State: AOJu0YyYKrGxZ222ox7auHXyK7rtPGDfhBHsuzrjBrqqoSjp6tFVZlXV
	zoCvN9gWDPOxxaewXlrw6YOKTW7E4zJajYTxdBT/vDTqy0e5yor/aO04OrXNg+71e9+rI7V3lrR
	3nGtPkIpbDCZJBaZFoPoqgb+k30uf2zU2j/700DqOcSbTd2njWAXCsAiFn1fkiP84cF/SJkjDMW
	lIf5T4IWxoV/nXBPzM6r6q8buqWNY/FLiCPWutHC5X+tAIb4Q=
X-Received: by 2002:ac8:59c9:0:b0:431:5aaa:649b with SMTP id f9-20020ac859c9000000b004315aaa649bmr3010782qtf.3.1712344087226;
        Fri, 05 Apr 2024 12:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgCn5GrbFQqhh2lffUKxXR4Bh70QImNHRB0S2QqrvSNTv9fN7t/rHO9PxmJxMDcmO1l+whPQ==
X-Received: by 2002:ac8:59c9:0:b0:431:5aaa:649b with SMTP id f9-20020ac859c9000000b004315aaa649bmr3010752qtf.3.1712344086679;
        Fri, 05 Apr 2024 12:08:06 -0700 (PDT)
Received: from localhost.localdomain ([140.141.139.15])
        by smtp.gmail.com with ESMTPSA id hd20-20020a05622a299400b0043146d55f0csm1005414qtb.60.2024.04.05.12.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:08:06 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 1/2] qmi: Create QRTR unit testing framework
Date: Fri,  5 Apr 2024 19:06:20 +0000
Message-Id: <20240405190621.38200-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: j2XYTtlbOruTMqZHFyNfR8feJ9tyPo56
X-Proofpoint-ORIG-GUID: j2XYTtlbOruTMqZHFyNfR8feJ9tyPo56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404050135

Use actual AF_QIPCRTR sockets to create test QRTR services that may be
utilized to validate the functionality of the QRTR implementation of
qmi_device.

These initial tests validate that the qmi code is performing service
lookup and instantiation properly.
---
 Makefile.am              |   7 +
 unit/test-qmimodem-qmi.c | 286 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 293 insertions(+)
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
index 000000000000..0bc2946a1a82
--- /dev/null
+++ b/unit/test-qmimodem-qmi.c
@@ -0,0 +1,286 @@
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
+	if (fd == -1) {
+		DBG("Could not create AF_QIPCRTR socket: %s", strerror(errno));
+		return -errno;
+	}
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
+static void exit_if_qrtr_not_supported()
+{
+	int fd;
+
+	fd = socket(AF_QIPCRTR, SOCK_DGRAM, 0);
+	if (fd == -1) {
+		printf("Could not create AF_QIPCRTR socket: %s\n",
+					strerror(errno));
+		printf("Skipping tests...\n");
+		exit(0);
+	}
+
+	close(fd);
+}
+
+int main(int argc, char **argv)
+{
+	int result;
+
+	exit_if_qrtr_not_supported();
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
+	__ofono_log_cleanup();
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
