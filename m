Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F9173336
	for <ofono@lists.linux.dev>; Fri,  5 Apr 2024 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346256; cv=none; b=ISpxAcGyjvU//Uw+h0NiNX00MLdovf2Ro2LAVBflinfe7ZK28nf85RV6sF/eZ7ixSDFSyIDNT1q+TPtF9psN56gTq994whBxyH4+kEQCz+EYX6A+FLceyXGquDA59Hlzj+L+muwA66/Fp4LUoumPztFjjO/lY+VgARmCRnYnJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346256; c=relaxed/simple;
	bh=1/KchntF3WsLiOinvrHCHsH2Rbe2L2j0V1Zguingr/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErFPAL4y6ILpivnhrssFdpJKGJziTuOSrU4BpZ+61o7/LFGEWYxgsc4bKdUHT+RoMJYzY1DRcFpcI4tbJ6QFDf9Tw0Oo6x3sz07rybhdhK/PEWzjBmkfR9WbYvm5BOGOIiUWq7bBy0txwtZbECgZZcqdfozFDkaS4Kufa69E350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=U8IzqzZ4; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=jsdJi7WH; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="U8IzqzZ4";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="jsdJi7WH"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435DI3T1006490
	for <ofono@lists.linux.dev>; Fri, 5 Apr 2024 12:44:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=gDCvQywvS52sp74wTUoWVT
	q+b1g27nouMKP8de9VU6c=; b=U8IzqzZ4ZsSMHryXwcIWlRu4TPC1LUpMOhEzwy
	f3OHDhW9ztqkd2fwe3cEQUqXTu1jYefStwdECrgfaX9UKjy+8z554gxZEf0okq5H
	LfukJ1OShGK9MAfMVAwdi1Pp0N7u6j9JFC/ZHQpffILdz8BxCTKE9kjZOAj6YRja
	q3hEfLImTspPZoBVdVTem0Re5L61i3CHF5VuglQPpO9WN4rf0UKBuIGNDyXpWOIj
	/M3OzgGPgFOVwFedq34IgeL7p7bbXe6DuNflt9ixKQm5Vj0WC/52kuW3ZsvMhB8X
	Emczut+xitqbyjvXChoNQY7+iri1mfGT262VU4LIEA+ezUgA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3x9emyt5eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 05 Apr 2024 12:44:13 -0700 (PDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69654139bd5so22935376d6.1
        for <ofono@lists.linux.dev>; Fri, 05 Apr 2024 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1712346253; x=1712951053; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDCvQywvS52sp74wTUoWVTq+b1g27nouMKP8de9VU6c=;
        b=jsdJi7WHjstwyUFaZ3KApCi/5M5RpRDHs4pUa1XPPbe0AF+XUukNzDE4Z4lP6V0K3w
         eQ3BwuBkcaEF1qioQ7jdcD8/5jS5pgItSLCeSMwMe+JyMBkC5eNjs5XK+tTi7UV6YAZR
         +9rAsS9Nh5XIaxxyA6lI6QsMF5X6m6GQKyeMW3k2HGUmLCtIQ8VOsC5pdeC4k6e5Qtxl
         qYP6Pctthmzx6r+ri7+Ba5PETLBTXrxuhDTtp8D5MMFfjDnlvZHSQa9PQgt36qTDHCjF
         LtNvJhobwtdZbBrQZ7VlOVCoKihWc0reau3rgiNC0AyiJ0pofJND2NVmHRgTAmk0GYvq
         lQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712346253; x=1712951053;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDCvQywvS52sp74wTUoWVTq+b1g27nouMKP8de9VU6c=;
        b=aBxQy8HJlyDQw3y5iNhlXUdsY6YVcV59B5RTRU9f3RUMsz6KJ/59YSR7vsY4igRUxd
         rCgkAsc/nRuewzfVoqzMR/Fh4E5GF+zm3DFDu8NHeFr5T+CPt5R33RST0abJHcA9+H4L
         bY5mza/oDkigeGhkutIf61JaLE03b2mF9iBXq7MzKP2wgESlUb9neL9SBHIIQEo0L2st
         FsgKDa9pHFHOwq8Qz+j1tqK5O+wnQ10A9CZOX236TQCTgpvHgYGcQDm/L2NRCXV/2BU8
         qjLrvmqpG+InGnSG+0vdpEpxNMM6gIOxc9aVr5ZSrwgih1AzS3Hp9H/yeI1j0Ew395+v
         IEzg==
X-Gm-Message-State: AOJu0YxXQC9szRfPtdlaDaoWx7V3Q1E8Yv3vlPCOb/fQhNN4rsOxbiYO
	jhxmLPN3qMGu3k4xDWawo/oERCResNcG9eIJgr85Vqjyl6sEsorc+o6mm5B4xAH4bEr+F/LKair
	e6A5Mp1Gy4AyG5HGYcwQFey3Vkd4D21pxF+tj9dd6+kUfqUvOOGX9yhpdcFFeqxx3ipFsPg4Grf
	BB8m9An2mb7K6vUpHvUwmL5WaouzRnRS5UKFLTctB9BkyIg5o=
X-Received: by 2002:ad4:5f0f:0:b0:699:1f48:3fd2 with SMTP id fo15-20020ad45f0f000000b006991f483fd2mr2722169qvb.11.1712346252840;
        Fri, 05 Apr 2024 12:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+6nWx4PT92cYhIcb/LbFxp7SIXZZ1jcbcBoof4YKT+VO4lMP4Tzfia1sBktszLI+Dp1CpZA==
X-Received: by 2002:ad4:5f0f:0:b0:699:1f48:3fd2 with SMTP id fo15-20020ad45f0f000000b006991f483fd2mr2722143qvb.11.1712346252411;
        Fri, 05 Apr 2024 12:44:12 -0700 (PDT)
Received: from localhost.localdomain ([140.141.139.15])
        by smtp.gmail.com with ESMTPSA id eb18-20020ad44e52000000b006993284a977sm876141qvb.2.2024.04.05.12.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:44:12 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v3 2/2] qmi: Add unit test for QRTR qmi_service_send
Date: Fri,  5 Apr 2024 19:42:50 +0000
Message-Id: <20240405194250.39561-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240405194250.39561-1-steve.schrock@getcruise.com>
References: <20240405194250.39561-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: VHN8WlZrSYAZJ3zpwab9AypK6OTq5fAi
X-Proofpoint-ORIG-GUID: VHN8WlZrSYAZJ3zpwab9AypK6OTq5fAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_23,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050139

The unit test causes a qmi request to be sent to the test QRTR service
and echos the data back in its response.
---
 unit/test-qmimodem-qmi.c | 166 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 1 deletion(-)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index ab19704e67cb..3c5418be2e60 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -28,7 +28,14 @@ struct test_info {
 	struct qmi_device *device;
 	struct l_timeout *timeout;
 	struct l_queue *services;
-	bool discovery_callback_called : 1;
+
+	/* Data sent to our test service */
+	struct sockaddr_qrtr sender;
+	size_t received_len;
+	void *received;
+
+	bool discovery_callback_called		: 1;
+	bool service_send_callback_called	: 1;
 };
 
 static uint32_t unique_service_type(uint32_t index)
@@ -147,6 +154,7 @@ static void test_cleanup(struct test_info *info)
 {
 	int i;
 
+	l_free(info->received);
 	l_timeout_remove(info->timeout);
 	l_queue_destroy(info->services,
 				(l_queue_destroy_func_t) qmi_service_unref);
@@ -250,6 +258,161 @@ static void test_create_services(const void *data)
 	test_cleanup(info);
 }
 
+static bool received_data(struct l_io *io, void *user_data)
+{
+	struct test_info *info = user_data;
+	struct sockaddr_qrtr addr;
+	unsigned char buf[2048];
+	ssize_t bytes_read;
+	socklen_t addr_size;
+
+	addr_size = sizeof(addr);
+	bytes_read = recvfrom(l_io_get_fd(io), buf, sizeof(buf), 0,
+				(struct sockaddr *) &addr, &addr_size);
+	memcpy(&info->sender, &addr, sizeof(addr));
+
+	assert(!info->received); /* Only expect one message */
+	info->received_len = bytes_read;
+	info->received = l_memdup(buf, bytes_read);
+
+	return true;
+}
+
+#define TEST_TLV_TYPE		21	/* Its data value is 1 byte */
+#define TEST_DATA_VALUE		0x89
+
+static void send_test_data_cb(struct qmi_result *result, void *user_data)
+{
+	struct test_info *info = user_data;
+
+	uint8_t data;
+
+	assert(!qmi_result_set_error(result, NULL));
+	assert(qmi_result_get_uint8(result, TEST_TLV_TYPE, &data));
+	assert(data == TEST_DATA_VALUE);
+
+	info->service_send_callback_called = true;
+}
+
+/*
+ * We know exactly how the qmi data should be packed so we can hard code the
+ * structure layout to simplify the tests.
+ */
+
+#define TEST_REQ_MESSAGE_ID	42
+#define TEST_RESP_MESSAGE_ID	43
+#define QMI_HDR_SIZE		7
+
+struct qmi_test_service_request {
+	uint8_t  type;
+	uint16_t transaction;
+	uint16_t message;
+	uint16_t length;	/* Message size without header */
+	uint8_t  data_type;
+	uint16_t data_length;
+	uint8_t  data_value;
+} __attribute__ ((packed));
+
+struct qmi_test_service_response {
+	uint8_t  type;
+	uint16_t transaction;
+	uint16_t message;
+	uint16_t length;	/* Message size without header */
+	uint8_t  error_type;
+	uint16_t error_length;
+	uint16_t error_result;
+	uint16_t error_error;
+	uint8_t  data_type;
+	uint16_t data_length;
+	uint8_t  data_value;
+} __attribute__ ((packed));
+
+static void send_request_via_qmi(struct test_info *info,
+						struct qmi_service *service)
+{
+	struct qmi_param *param;
+
+	param = qmi_param_new();
+	qmi_param_append_uint8(param, TEST_TLV_TYPE, TEST_DATA_VALUE);
+	assert(qmi_service_send(service, TEST_REQ_MESSAGE_ID, param,
+					send_test_data_cb, info, NULL));
+
+	while (!info->received)
+		l_main_iterate(-1);
+}
+
+static void send_response_via_socket(struct test_info *info, struct l_io *io)
+{
+	const struct qmi_test_service_request *request;
+	struct qmi_test_service_response response;
+
+	/* First validate that the qrtr code sent the qmi request properly. */
+	assert(info->received_len == sizeof(*request));
+	request = info->received;
+	assert(request->type == 0x00);
+	assert(request->message == L_CPU_TO_LE16(TEST_REQ_MESSAGE_ID));
+	assert(request->length == L_CPU_TO_LE16(
+					sizeof(*request) - QMI_HDR_SIZE));
+	assert(request->data_type == TEST_TLV_TYPE);
+	assert(request->data_length == L_CPU_TO_LE16(1));
+	assert(request->data_value == TEST_DATA_VALUE);
+
+	/*
+	 * Now echo it back to the qrtr client. The qmi_service send callback
+	 * will validate that the client processed this response correctly.
+	 */
+	memset(&response, 0, sizeof(response));
+	response.type = 0x02;
+	response.transaction = request->transaction;
+	response.message = L_CPU_TO_LE16(TEST_RESP_MESSAGE_ID);
+	response.length = L_CPU_TO_LE16(sizeof(response) - QMI_HDR_SIZE);
+	response.error_type = 2;
+	response.error_length = L_CPU_TO_LE16(4);
+	response.data_type = request->data_type;
+	response.data_length = request->data_length;
+	response.data_value = request->data_value;
+
+	sendto(l_io_get_fd(io), &response, sizeof(response), 0,
+					(struct sockaddr *) &info->sender,
+					sizeof(info->sender));
+
+	while (!info->service_send_callback_called)
+		l_main_iterate(-1);
+}
+
+/*
+ * Initiates a send of the TLV data payload to the test service. The test
+ * service will respond with the same data payload.
+ */
+static void test_send_data(const void *data)
+{
+	struct test_info *info = test_setup();
+	struct l_io *io;
+	uint32_t service_type;
+	struct qmi_service *service;
+
+	perform_discovery(info);
+
+	service_type = unique_service_type(0); /* Use the first service */
+	assert(qmi_service_create(info->device, service_type,
+					create_service_cb, info, NULL));
+	perform_all_pending_work();
+	service = l_queue_pop_head(info->services);
+	assert(service);
+
+	io = l_io_new(info->service_fds[0]);
+	assert(io);
+	l_io_set_read_handler(io, received_data, info, NULL);
+
+	send_request_via_qmi(info, service);
+	send_response_via_socket(info, io);
+
+	l_io_destroy(io);
+	qmi_service_unref(service);
+
+	test_cleanup(info);
+}
+
 static void exit_if_qrtr_not_supported(void)
 {
 	int fd;
@@ -278,6 +441,7 @@ int main(int argc, char **argv)
 	l_test_add("QRTR device creation", test_create_qrtr_device, NULL);
 	l_test_add("QRTR discovery", test_discovery, NULL);
 	l_test_add("QRTR services may be created", test_create_services, NULL);
+	l_test_add("QRTR service sends/responses", test_send_data, NULL);
 	result = l_test_run();
 
 	__ofono_log_cleanup();
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
