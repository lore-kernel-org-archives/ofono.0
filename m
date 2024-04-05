Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDAF16FF38
	for <ofono@lists.linux.dev>; Fri,  5 Apr 2024 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333341; cv=none; b=F692im7vtmf00NG06GIQHysPcewz8BZx6IlFPQ/Z8S5/l8V5S2fuBHAJoqwi0M/Bc1bbidjzudHMxxjLl1ra72m/s0USazoIMz/WlEKFM6BWtNC1MHcz0fEvJ1uzhR2IbB90ZyiJDHeHbCd9zPbbAWKuR74C7rLGngjOtcPBQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333341; c=relaxed/simple;
	bh=zvUb+v9JWfavJ0NdacHte84Tqx/KzD1OWJR2xSAWE/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSXf8IdrOovQYdHPaACb7Q0nWQjXyMbhmifqN5Rg9eiDwM4/tp9VMGuIZRzxSOR5Nnr1b1FfSmLhyf+0mB4GD98TN5ehWHNcPjKznghIJTKd+ifPAHY3YieguRRFW4LjahbHEYneodqJBfBppa6eUWJYzWKDXh3iu4msM9xnz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=YUYhUngP; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=mNDvKWC2; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="YUYhUngP";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="mNDvKWC2"
Received: from pps.filterd (m0286619.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435ETdXh027238
	for <ofono@lists.linux.dev>; Fri, 5 Apr 2024 09:08:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=SZMFx09LxUdSJSqtEJBXwP
	xkGLkyTqgQPR1qWITNHRs=; b=YUYhUngPLSNFWXc01xNL1lLpfO0f/UD8TtFFGm
	jvfQSvdE2b3ThE9OXaK1rQWC3w+IVdraXhGAEIHVkM4NHWyGYLiwhRgKpPoLT/uD
	q1rvIqv2hh0t/SRlQt5YGzvaJ/hmSDog8Ao0gAnm0mcqjuInJ4JPmEUhZEhMWjNQ
	sDoH+9LtJQBdHuaXwnH8o4GO6tu5iQoFwSSQhVc+5dzfDWWXM5d3xu8ktmxx1sK9
	/9UWq7zbve7ggCTGLF48ajD6upjaYQoVsN/wLuhXuUOfQtKbHdm0UMNNmBAd2reT
	9YJvPS/QgrYG1ESo9I4UucLtRUHOxgkLKhZpB33jr8SXEJyQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3x9tqg9ayv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 05 Apr 2024 09:08:52 -0700 (PDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-430baecb018so23311701cf.2
        for <ofono@lists.linux.dev>; Fri, 05 Apr 2024 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1712333331; x=1712938131; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZMFx09LxUdSJSqtEJBXwPxkGLkyTqgQPR1qWITNHRs=;
        b=mNDvKWC2RmnINgyhuH1LerT4VT+pV4G/eK0J2wfa8cFx9OTF27Hi+YUZuh0/O2Cgmv
         qZulRdIpe4rcF6TtHsaCNMk8+e+bMSvGNf8CbEQeXpzaLizO5xM307jibS87jPj8UjnF
         FUYWd+Jo1IXbjut0AiymUyIL+b7aRxEvIT++IUMind1ykn4hgU4mFW9o+RSyQUcmaD3I
         PCDB4EciPKJsIyFKh6XYlQenUZ6uBP9EAekhfQ3P5txl2hX0NnoqTqmKqFuvFbVzdi0w
         pPqqaW8ALWxg4KW4kGSl7tqraDmNx2S2H6H+nRAJ5AUdhj0mzy6G6HOXSEtWOeGkLAUb
         u6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333331; x=1712938131;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZMFx09LxUdSJSqtEJBXwPxkGLkyTqgQPR1qWITNHRs=;
        b=Kx3Ce8mJzCjrXMDHuV9tjecirHE69clu7Bd55tK1lNZoHYvK2ysljlWu9S74KzPrFy
         yVbfv+f76s5xG0Lmyp9H33+Ml80QTugkVpNbKJtWkLQccjUNxxSeY/mGgEMRt+HbPx62
         vqAcEpIXDSeuSKKKssrCJm8yPF0F2HhQAIt8WhoWVvPALPj9e06vqI8pSfLHiVpu7Pan
         fKpQrWPSSuov0u5+tBQWjkoy6ACSSncMvCJwuR5AHSQOj88+KWkNcRJj03MzJYwt0HUO
         5RbrxAPQjvm3e2vKo58xIcchNyXgWU7mKCm36y8LyLO5+ICV/GG5dU5xDRCIiYNzzwr7
         AkvQ==
X-Gm-Message-State: AOJu0Yxb+ej4ySsWKUq3SuBYI5gGk59VzDRnn8eSfnkMpFHYT+pSw8K/
	+ng6mTgKiyfiMExAjNtRkVwoc5QOF2I727BNOupXP4nwjIUH971RsLOSYIfaoqpi9+3vYZRlYzc
	TmLAcQ/p68JcQw0OajiI5UKXULNhTgPSVwmAio+l5iKwqhmTulXmlvbau/yJqRvcDEkcWNAowqT
	AtZYLU8+U/4/iirCiiR1a6ru/82Dy7F2uFOF8OqpkG58Bv3RE=
X-Received: by 2002:a05:6214:c43:b0:691:e21:736c with SMTP id r3-20020a0562140c4300b006910e21736cmr1626698qvj.30.1712333331005;
        Fri, 05 Apr 2024 09:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpizPcYzlNRpMk5s8EOy0+jQv+b017XsYDrxE47j+KOL4/ttCWRtnL8AXEe/eatTJVHrnqOQ==
X-Received: by 2002:a05:6214:c43:b0:691:e21:736c with SMTP id r3-20020a0562140c4300b006910e21736cmr1626639qvj.30.1712333329940;
        Fri, 05 Apr 2024 09:08:49 -0700 (PDT)
Received: from localhost.localdomain ([140.141.139.15])
        by smtp.gmail.com with ESMTPSA id t16-20020a0cde10000000b006991de7276asm728850qvk.94.2024.04.05.09.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:08:49 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/2] qmi: Add unit test for QRTR qmi_service_send
Date: Fri,  5 Apr 2024 16:07:02 +0000
Message-Id: <20240405160702.29261-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240405160702.29261-1-steve.schrock@getcruise.com>
References: <20240405160702.29261-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: B5F6GMKG7XlU8KX6cqjiKwlMF08N2UI4
X-Proofpoint-ORIG-GUID: B5F6GMKG7XlU8KX6cqjiKwlMF08N2UI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_17,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050114

The unit test causes a qmi request to be sent to the test QRTR service
and echos the data back in its response.
---
 unit/test-qmimodem-qmi.c | 165 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 619e813f78d6..2d15332637f6 100644
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
@@ -248,6 +255,161 @@ static void test_create_services(const void *data)
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
 int main(int argc, char **argv)
 {
 	int result;
@@ -259,6 +421,7 @@ int main(int argc, char **argv)
 	l_test_add("QRTR device creation", test_create_qrtr_device, NULL);
 	l_test_add("QRTR discovery", test_discovery, NULL);
 	l_test_add("QRTR services may be created", test_create_services, NULL);
+	l_test_add("QRTR service sends/responses", test_send_data, NULL);
 	result = l_test_run();
 
 	return result;
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
