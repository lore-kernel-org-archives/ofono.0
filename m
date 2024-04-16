Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48217736
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713306336; cv=none; b=FPk3zS8ZX5LO3iYtjDOsV7v1UVLcdskqHLUNwQrr6iJMBThnxB6O8Hq+SMkFcABbJBYWMKgEQCopBXK7dpUv4eJhD6nFSXRUlzoidhtSeR03YZ2q63HV8MDPoHhKp8B7D91oAyVh65EOYVpKqySQhZllnUzSLzhZawzenA8QfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713306336; c=relaxed/simple;
	bh=OZ48uyG14Egd8KpTKkHvMRjfBvUdg01y3Fv8puC32I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+UH/6vmnTAHINO092pmS7eREghSu+QMmVS20kCod2/lUyENVVFuYB7DO9/Ma9nEPa3jAtS9ryJYZ7TTKwuS4TL1sNOijshJdSYjmn59R92HZau8IxGUgTVGF7PcDHxzHfFy1PQUZcJlThyqsLxV5xxab4/v4Jml39whbTgsWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=plClSBG1; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=g2yPKAuQ; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="plClSBG1";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="g2yPKAuQ"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GEjE4C010846
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:13:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=Dn6I95OgI4jWekHVORLBsP
	32aGqlwtFqvaXzvxIJiMo=; b=plClSBG1Vk1dSbzDWHw8K3MIzPXgxnUOjv8iGJ
	pfW1xL7+fbIMgtYATirwqZxseefsI1/Cpm0ZF+UsvDZayEYaYle1XTnOkMAUrRqv
	Gy79VPuSoiWx4bHpPC3Khm7C55HAjO7QNckZ8aUYJL+9DsUHmuAi49+GM5/i0gKT
	EQSLqlm4u4dS2OMPXJzXEp4Kuye5jWSfhKtBD0av1PjTNNwhbW627U1oHILI+pFi
	zBb+ggM+EpLxkT6eP+Ondv/Ro8M+nSUqAibVfoNqKQbmRXf5CDu6gY99MTgLhKTN
	VWrqu4LREmnJQKuVgTqT6Kzzu8NyKoxBALtU6nO7kkkNTWgA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xhub9rgn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:13:48 -0700 (PDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69b0fdb7f0cso42691156d6.1
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713305627; x=1713910427; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn6I95OgI4jWekHVORLBsP32aGqlwtFqvaXzvxIJiMo=;
        b=g2yPKAuQT9mFa6j/dgzzwWH7UfM+YM7c72GDrCJd1mG5Ga9I6t3Od71NXbWPncHbcS
         PTAtuzZq10lDkL2uoaAdpFztY1Y+zQDMe/6w2GS3gQFN8yRkoeE/yMVcf6cPYVRuSH8p
         +aRHc5GiyQIZgqyZtzba5y3VxsvaDfdTT4F95zaq7QKltFEZfiBcbvT6QnU5ztIaz/nN
         kw7aYIKuWJfhXJV98YGhRj3hO09SzuTnFlsLEYVgrfi2ByFX/GPIrNCrjwmkvdma5/2t
         gw08cd0HYWISKFo2va1Mhz7mAk6xr2k3GmZze4/9DvCQM9L2NKHxcK7lTdpeq+3DR6bH
         5m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713305627; x=1713910427;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn6I95OgI4jWekHVORLBsP32aGqlwtFqvaXzvxIJiMo=;
        b=VXIAko8XttsdU4XEv+HWfK4H4b/39hs/u7qdxc8nkwIwVhIVAJn9vvoS7SUZ3UhSVL
         U8zp5QMyWcdI3z9gHC3aVD3oJC/eXEiE/IKkTlHyIjWCVFfK9CG/PACobWA5/7eh5R59
         95Yt/pG1POKEUnlfcLx1kJ4Kz9pIViI1EnHofjIchAr8gaKw1243ED+lCd0o0faXgvQm
         oanKLdRc1H6dNEaOVupz8P+MEjkq3tGpU+/bjfX+qOuwblIDxw/fEEy506WXkPZllKro
         u92pwTCM9ye84We1pVCAJ0Jbh7lRX0usTAi9pNI2gtv1rlYx+c61RMBSS2BY+vfRnZIi
         NDdw==
X-Gm-Message-State: AOJu0YyVhS+sr6IAPdmI6j7Ww8py3W9LRj6LsEp4OFiJV+ZCN0J48Oc2
	QOQGVkybDdZZfFM7NE6o14125Kn3qDqJm5zMEvCsXM5isjc8XtrKZpGsfDTP/ka/M18jIh00WX+
	K9a0F44dopMKPToZEgL8/usQUNpDYKZbgUJKf+gVD/T12Y7fTZrQy+9WHnElTdOC7Eh78mjx/b5
	wtAVdYW0oDcdLlqf/pdU9RMIJNgRV57x3KhgrwQMs1PHANuhA=
X-Received: by 2002:ad4:4ee7:0:b0:69b:79e5:fdae with SMTP id dv7-20020ad44ee7000000b0069b79e5fdaemr10452959qvb.60.1713305627155;
        Tue, 16 Apr 2024 15:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsq2WRKqCQvYLNO14rXnpljgetMC+wsJpjQr0rNRDe65gk68UwWyHOwTg6Qdu+oLkYjpQMVg==
X-Received: by 2002:ad4:4ee7:0:b0:69b:79e5:fdae with SMTP id dv7-20020ad44ee7000000b0069b79e5fdaemr10452938qvb.60.1713305626726;
        Tue, 16 Apr 2024 15:13:46 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id f6-20020a056214164600b0069b10d78445sm7654028qvw.142.2024.04.16.15.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:13:46 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/3] qmi unit: Make test service sends more generic
Date: Tue, 16 Apr 2024 22:12:32 +0000
Message-Id: <20240416221233.404872-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416221233.404872-1-steve.schrock@getcruise.com>
References: <20240416221233.404872-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: 0T9f0G8YloSSRS9wVnshl6zBRSkDnX2y
X-Proofpoint-GUID: 0T9f0G8YloSSRS9wVnshl6zBRSkDnX2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160143

Clean up the functions so that they can be used to send indications
in addition to responses in the future.
---
 unit/test-qmimodem-qmi.c | 68 ++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index d04f50041c51..7826ab671239 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -283,8 +283,9 @@ static bool received_data(struct l_io *io, void *user_data)
 	return true;
 }
 
-#define TEST_TLV_TYPE		21	/* Its data value is 1 byte */
-#define TEST_DATA_VALUE		0x89
+#define TEST_TLV_TYPE		0x21	/* Its data value is 1 byte */
+#define TEST_REQ_DATA_VALUE	0x89
+#define TEST_RESP_DATA_VALUE	0x8A
 
 static void send_test_data_cb(struct qmi_result *result, void *user_data)
 {
@@ -294,7 +295,7 @@ static void send_test_data_cb(struct qmi_result *result, void *user_data)
 
 	assert(!qmi_result_set_error(result, NULL));
 	assert(qmi_result_get_uint8(result, TEST_TLV_TYPE, &data));
-	assert(data == TEST_DATA_VALUE);
+	assert(data == TEST_RESP_DATA_VALUE);
 
 	info->service_send_callback_called = true;
 }
@@ -308,6 +309,12 @@ static void send_test_data_cb(struct qmi_result *result, void *user_data)
 #define TEST_RESP_MESSAGE_ID	43
 #define QMI_HDR_SIZE		7
 
+enum qmi_message_type {
+	QMI_MESSAGE_TYPE_REQ	= 0x00,
+	QMI_MESSAGE_TYPE_RESP	= 0x02,
+	QMI_MESSAGE_TYPE_IND	= 0x04,
+};
+
 struct qmi_test_service_request {
 	uint8_t  type;
 	uint16_t transaction;
@@ -338,7 +345,7 @@ static void send_request_via_qmi(struct test_info *info,
 	struct qmi_param *param;
 
 	param = qmi_param_new();
-	qmi_param_append_uint8(param, TEST_TLV_TYPE, TEST_DATA_VALUE);
+	qmi_param_append_uint8(param, TEST_TLV_TYPE, TEST_REQ_DATA_VALUE);
 	assert(qmi_service_send(service, TEST_REQ_MESSAGE_ID, param,
 					send_test_data_cb, info, NULL));
 
@@ -346,11 +353,36 @@ static void send_request_via_qmi(struct test_info *info,
 		l_main_iterate(-1);
 }
 
-static void send_response_via_socket(struct test_info *info, struct l_io *io)
+static void send_message_to_client(struct sockaddr_qrtr *dest, struct l_io *io,
+					uint8_t type, uint16_t transaction,
+					uint16_t message, uint8_t data_value)
 {
-	const struct qmi_test_service_request *request;
 	struct qmi_test_service_response response;
 
+	/*
+	 * Now echo it back to the qrtr client. The qmi_service send callback
+	 * will validate that the client processed this response correctly.
+	 */
+	memset(&response, 0, sizeof(response));
+	response.type = type;
+	response.transaction = transaction;
+	response.message = L_CPU_TO_LE16(message);
+	response.length = L_CPU_TO_LE16(sizeof(response) - QMI_HDR_SIZE);
+	response.error_type = 2;
+	response.error_length = L_CPU_TO_LE16(4);
+	response.data_type = TEST_TLV_TYPE;
+	response.data_length = 1;
+	response.data_value = data_value;
+
+	sendto(l_io_get_fd(io), &response, sizeof(response), 0,
+					(struct sockaddr *) dest,
+					sizeof(*dest));
+}
+
+static void send_response_to_client(struct test_info *info, struct l_io *io)
+{
+	const struct qmi_test_service_request *request;
+
 	/* First validate that the qrtr code sent the qmi request properly. */
 	assert(info->received_len == sizeof(*request));
 	request = info->received;
@@ -360,26 +392,16 @@ static void send_response_via_socket(struct test_info *info, struct l_io *io)
 					sizeof(*request) - QMI_HDR_SIZE));
 	assert(request->data_type == TEST_TLV_TYPE);
 	assert(request->data_length == L_CPU_TO_LE16(1));
-	assert(request->data_value == TEST_DATA_VALUE);
+	assert(request->data_value == TEST_REQ_DATA_VALUE);
 
 	/*
-	 * Now echo it back to the qrtr client. The qmi_service send callback
+	 * Now respond to the qrtr client. The qmi_service send callback
 	 * will validate that the client processed this response correctly.
 	 */
-	memset(&response, 0, sizeof(response));
-	response.type = 0x02;
-	response.transaction = request->transaction;
-	response.message = L_CPU_TO_LE16(TEST_RESP_MESSAGE_ID);
-	response.length = L_CPU_TO_LE16(sizeof(response) - QMI_HDR_SIZE);
-	response.error_type = 2;
-	response.error_length = L_CPU_TO_LE16(4);
-	response.data_type = request->data_type;
-	response.data_length = request->data_length;
-	response.data_value = request->data_value;
-
-	sendto(l_io_get_fd(io), &response, sizeof(response), 0,
-					(struct sockaddr *) &info->sender,
-					sizeof(info->sender));
+	send_message_to_client(&info->sender, io, QMI_MESSAGE_TYPE_RESP,
+					request->transaction,
+					TEST_RESP_MESSAGE_ID,
+					TEST_RESP_DATA_VALUE);
 
 	while (!info->service_send_callback_called)
 		l_main_iterate(-1);
@@ -410,7 +432,7 @@ static void test_send_data(const void *data)
 	l_io_set_read_handler(io, received_data, info, NULL);
 
 	send_request_via_qmi(info, service);
-	send_response_via_socket(info, io);
+	send_response_to_client(info, io);
 
 	l_io_destroy(io);
 	qmi_service_unref(service);
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
