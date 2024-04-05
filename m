Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C716D328
	for <ofono@lists.linux.dev>; Fri,  5 Apr 2024 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344094; cv=none; b=W4MNR7fgmI4eKRdqv+hHiW0ExdAhS/zUvAYQ7I1IKU+kujP6ncQCBV/zrRW32p/3au2H4Xmj+xxzhfyAGv2qlYWYvqhRVr59TV/Np6m9BFLqmxKlrBHqztk5mdvcg3nell9xG55VcawhkLHxQ+dE/tec09sDoWfC13IOgW4E/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344094; c=relaxed/simple;
	bh=cDEjxl6Fpew3NViSn81/J/zZudxaCjghYFYxCokvnLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYgbXrwSSFhfVoLhtgo7GwUiGUJPxXa7V5QM54G5cggwLTsnBB/93bN5hv1PVdQiDj1O4MN8D7AQIWdR2YPPQfor5v9tQxa6z9/Yp5rsVLrjM9qi6+bYFC4zZFnHaWbPepfLLEzlnpj8Ad/x9wOJZsrdWNzdNWR0qp9uE0tP0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Wcs6dGbN; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=fdc1MHTC; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Wcs6dGbN";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="fdc1MHTC"
Received: from pps.filterd (m0286621.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435Dw81b006033
	for <ofono@lists.linux.dev>; Fri, 5 Apr 2024 12:08:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=XV58LAVi8reNHvUrE/X5dp
	exUYFcJu0ioZL7iQigth4=; b=Wcs6dGbNPSHrZtHqkL382X91ZskBY4SaVpcLDJ
	wiV6lt4pVLyGlMZn5Q2mu1KqQw0izvYUpbQO5wzuPl0MSO4WBnvXNgeqrQqCHPH9
	xFhyRCS75irI5DVF5lz+3DEIyfkcQOAlc5cTM8NtgPa+VjX7mFUTOYoz1PsQQdjC
	rOhrugQ8KUIyT331rr9VqI0dZvYevX4DFfiyLLfjwhFeY5I9C9leY3jEXbzBOmZM
	T41K8N/qxNHNPCidSZQzmP7lBLfEHBkeeXl4FI7YEqjeDf/NVIAIkocBZHPHUbct
	Bz99aU1jZpYvxdw5GISyJJXMzRZpPNR3bKnHL9nLimjXwMCw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3x9emut4a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 05 Apr 2024 12:08:09 -0700 (PDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-42f3069a45dso62849071cf.1
        for <ofono@lists.linux.dev>; Fri, 05 Apr 2024 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1712344088; x=1712948888; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XV58LAVi8reNHvUrE/X5dpexUYFcJu0ioZL7iQigth4=;
        b=fdc1MHTCxGy+Y4cMxvvXKNJO1Dvji837c7upp4f7ITMazwzZ28tlfebwPID9Nl0Dpq
         xmItwJpeV9HM+aA/ushyRiYMFp0R2j7vL2rKCIiHxLmlAUqyBoIlbIdWBsfR3+pCOHR7
         Yxedft6513vwzpGVejv8slZTN1oLYZeE6AkSBv6mr6BZLJ2yxv/JZKeg6p8fcORfHxZw
         XOEZ4Jw08FGc5rqrGBHHlfYhjJh1RwyHgbRPjgrlcEovYJ3tD3p5s7Y34aKvJ75/iVzv
         ux/mjODn/mV28EgkrY7ot1823A5pfuH+Uj8ZNJJxAWqcA/oqc2A15lujMWYVxRDcFWB0
         Ox0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712344088; x=1712948888;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XV58LAVi8reNHvUrE/X5dpexUYFcJu0ioZL7iQigth4=;
        b=WPWpM9xM/hmtmKanzdFOjMwp6+3gT8520ktGSWd7XMgy1Cz1IjMSYc0e8PM6Lt1xol
         5RncQZCrynwqQfEMXAlErKYyw5pE1JvOFqCk7ow7fevzOEIlOri0+vICHgvEhs+CyRnu
         LBYmg2+ucCYMYlJJ6nLXz5m6V3KpwegY/JNJzKR24/7LRjztlWzTjM+ijt0C5cw5mSJe
         XJVaxyqeuL/qP6x5x2ua1zRTsgPweGlCjTfPVYl09eEYSkuy3BMpB2yAgtkDckG/4zZh
         /J4b+j8DgMuaNmCM4XPyj/qmN96Nri22bEq3AE0ewTOn+W/6bllnbGlYWEXQ+VbLW2Nt
         MVqw==
X-Gm-Message-State: AOJu0YzgmiX50sc8CNb7GRqpKvC+PaSv9oaMkAXgclqbs/Z8nHepYdVO
	uq+MWdksvWISvIK1evxz167UbxEWtg9EE3+4BAitsDGhqKlwIvrC/umjVowRv7H2UGzUXyBg2Ti
	ybCVsb+HuYGxuYN+HgzflFgHoN21xtv05oUXFfAHSFfEvvyGULRwBZOBg4CfclmSmOUo1w/UJpo
	nY8iqoFDQqIYbafVDjzKIdzQhd4KmLkorUj6hbaYXZxsFsxVc=
X-Received: by 2002:a05:622a:14c7:b0:434:5894:768f with SMTP id u7-20020a05622a14c700b004345894768fmr5880923qtx.31.1712344087737;
        Fri, 05 Apr 2024 12:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+mRrAFAICRP8T+RI0ghF2mfiReMlOSLft8PXx+nFbPDW3J3ANERw80ZDSYZ6VQESEJLyNdg==
X-Received: by 2002:a05:622a:14c7:b0:434:5894:768f with SMTP id u7-20020a05622a14c700b004345894768fmr5880897qtx.31.1712344087309;
        Fri, 05 Apr 2024 12:08:07 -0700 (PDT)
Received: from localhost.localdomain ([140.141.139.15])
        by smtp.gmail.com with ESMTPSA id hd20-20020a05622a299400b0043146d55f0csm1005414qtb.60.2024.04.05.12.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:08:07 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 2/2] qmi: Add unit test for QRTR qmi_service_send
Date: Fri,  5 Apr 2024 19:06:21 +0000
Message-Id: <20240405190621.38200-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240405190621.38200-1-steve.schrock@getcruise.com>
References: <20240405190621.38200-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: xUOIruU_PamL8RRfxffVyZFu6AMEX6Hh
X-Proofpoint-GUID: xUOIruU_PamL8RRfxffVyZFu6AMEX6Hh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050135

The unit test causes a qmi request to be sent to the test QRTR service
and echos the data back in its response.
---
 unit/test-qmimodem-qmi.c | 166 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 1 deletion(-)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 0bc2946a1a82..79a9a1437aba 100644
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
 static void exit_if_qrtr_not_supported()
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
