Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81913281F
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305978; cv=none; b=SDqJbm7JMltd/oeIVVSqAFHeIYKLB5o5jUOwwbV28xHQ8SKrqFji9xipKG3IEhtcx7vnOCrjGRWyM514C3FfEQMT9/lSVi7+LZToiZbfVyoYAk5JmmZcjqyAZa7aZzis5EO0EgzkFJf2Fu1ERpR23DJJrhvLpxiFl8FB2DAw9+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305978; c=relaxed/simple;
	bh=1O/ZZGVQgH9DYMWv7KP3EjueuIgp9G0LH4qD4poBhlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4wU7ZQHuM4JjPU6c7no+ypboiIUzZ7mATivUc0V00lnqqazG4sJO00KqTrU7QSqYORMVItQbrTNdgNVmybXs9ThctnGv1ZuAt+smHVU3P9XZcU2ziR6zu7cRBlluhHjLxKucmondY323JSWvbFc3FZjWfAPDa65TM4rpO8hIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=WkcQNpeI; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=SjPlKzac; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="WkcQNpeI";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="SjPlKzac"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GDFDap015765
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:13:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=C8g3V7la4bNIj8265bV1b7
	7QXncTtN9+UOIL9Tw2T8k=; b=WkcQNpeI+dEYAr0A+vvvqCUbQ7Dj3OptgcG83t
	idwkufiq3oqwtkYd0R+GqGyQWSDKBue0IOmQDM1jN9BqzWHWVdnO2Em6kfk104dJ
	gZsoIfZVIl35CMNyBDb2qtBqqKhBX7TCgkaX5deojRisQcCmPdaE46crwmUdXZ9z
	dKbVDrPO+hyOzqulSwUf//FqelSfXzSqf2MbxiT3guuQHyTyZF+2awPn/+/9AzbB
	MRrPfD5QlTBm5uGDGxFfHweL3ZwhQc1GeWjp0sF7SD6Pl2hRBxxRO4oQHyk1V4rc
	F0+vqYjCb+T54MZrhPFC98HWgz4ZF7pcwbBvHuMRlRs8h44A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xfp8hjmxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:13:49 -0700 (PDT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-47b61811775so1347308137.3
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713305628; x=1713910428; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8g3V7la4bNIj8265bV1b77QXncTtN9+UOIL9Tw2T8k=;
        b=SjPlKzac0slIrPO18gQRWYBdgEvrv86K6T632qpM5E7dP+9/WlmFluNjKeiqghV1x0
         tfDLaye9ZeLeSzwBmG2IdjOV1UiiKvpQfluS945gM/uHPU+97ywBGwt0WCbc8lgxmpNU
         EGZPlCSblU71OhZMQVZcAsdxH9cY7JdlAucPaGwO/LyJpjnOXCYeQI2GxmALzi7EW+o1
         O5MT39BfDup7LE/gQU06cGQBJM7nzY4SjGMhP3iUXaUTeef4b8VE3yIzsI9LyIh/Gnh8
         vdPzrSH7gKT9aT7EGZ5eLQVWV4sw1r78TtNNV9kmRthe4Ln5CQaFEhtZ6Xhdkk6fcYYp
         KvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713305628; x=1713910428;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8g3V7la4bNIj8265bV1b77QXncTtN9+UOIL9Tw2T8k=;
        b=HFLtMilkH4NBepWqPuWXNutoCMvmPC0fEvA/CgV6xSMABEbe39e1JzQ5YbNzY8PT01
         vCG4m27m79nZwHwfS4qJ1CjcaQojttvWhqHV+zIuw40V62GrgEq1ztcisdynJz199rH7
         bN/zn5UmHKS8muOKOOWObuyegDx74l4/uUCEohV0+CR6iTAH8ByBQJEjpkBJ9GsPgNlY
         N0pYDOmdi2fmdsY4ITeSD/T2bqeJmFD7NJtFroYYS0821Q4iBkpQZkVFOcax3MzEVw9d
         MUqoW+cyiQItgmrVOv4jAz7S1ju2U8zEQwB0cPAE/kmjCWDKPW18PvBwGfOnqwaqpNCi
         OdAw==
X-Gm-Message-State: AOJu0YyU2d1zwYfsMm8ncIqcNV4hY+kXB7VdcFYdBV+LnSYUyVINPCtr
	yafEeYM3O9AEwq4f3AOe9I4UYcTEJ4Gn8JzRSxcrsZC4BisPH2rBTGVj0i6Qx+p053Aj/OI+ggY
	avDZd9MMFW7D1vRvYgOoCc8Pz1A2izz95M8FANXGBlOL5ZeDsbu11tR5NONKec3cBqcc5YUdJK6
	BnruXW9dPEdSleanEUX1yp9Hh0zfr7lMJ+rOvIeP3tPXHRo94=
X-Received: by 2002:a05:6102:148c:b0:47b:6b98:e9ae with SMTP id d12-20020a056102148c00b0047b6b98e9aemr12658389vsv.33.1713305627797;
        Tue, 16 Apr 2024 15:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEZBUBElKWS2IXG3aS/S8g3rx6ZQz8uDq7hgsLISr9+tsWaBK0y97ZpHo4GW3IbDdGH30vRQ==
X-Received: by 2002:a05:6102:148c:b0:47b:6b98:e9ae with SMTP id d12-20020a056102148c00b0047b6b98e9aemr12658366vsv.33.1713305627330;
        Tue, 16 Apr 2024 15:13:47 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id f6-20020a056214164600b0069b10d78445sm7654028qvw.142.2024.04.16.15.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:13:47 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 3/3] qmi unit: Add notification registration test
Date: Tue, 16 Apr 2024 22:12:33 +0000
Message-Id: <20240416221233.404872-3-steve.schrock@getcruise.com>
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
X-Proofpoint-ORIG-GUID: C_3nhsX6HrBJJxNDKL7E6b2NYHGpO3u6
X-Proofpoint-GUID: C_3nhsX6HrBJJxNDKL7E6b2NYHGpO3u6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160143

---
 unit/test-qmimodem-qmi.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 7826ab671239..0e15f898f845 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -36,6 +36,7 @@ struct test_info {
 
 	bool discovery_callback_called		: 1;
 	bool service_send_callback_called	: 1;
+	bool notify_callback_called		: 1;
 };
 
 static uint32_t unique_service_type(uint32_t index)
@@ -286,6 +287,7 @@ static bool received_data(struct l_io *io, void *user_data)
 #define TEST_TLV_TYPE		0x21	/* Its data value is 1 byte */
 #define TEST_REQ_DATA_VALUE	0x89
 #define TEST_RESP_DATA_VALUE	0x8A
+#define TEST_IND_DATA_VALUE	0x8B
 
 static void send_test_data_cb(struct qmi_result *result, void *user_data)
 {
@@ -307,6 +309,7 @@ static void send_test_data_cb(struct qmi_result *result, void *user_data)
 
 #define TEST_REQ_MESSAGE_ID	42
 #define TEST_RESP_MESSAGE_ID	43
+#define TEST_IND_MESSAGE_ID	44
 #define QMI_HDR_SIZE		7
 
 enum qmi_message_type {
@@ -440,6 +443,57 @@ static void test_send_data(const void *data)
 	test_cleanup(info);
 }
 
+
+static void notify_cb(struct qmi_result *result, void *user_data)
+{
+	struct test_info *info = user_data;
+	uint8_t data;
+
+	assert(!qmi_result_set_error(result, NULL));
+	assert(qmi_result_get_uint8(result, TEST_TLV_TYPE, &data));
+	assert(data == TEST_IND_DATA_VALUE);
+
+	info->notify_callback_called = true;
+}
+
+static void test_notifications(const void *data)
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
+	send_response_to_client(info, io);
+
+	qmi_service_register(service, TEST_IND_MESSAGE_ID, notify_cb, info,
+						NULL);
+	send_message_to_client(&info->sender, io, QMI_MESSAGE_TYPE_IND, 0,
+						TEST_IND_MESSAGE_ID,
+						TEST_IND_DATA_VALUE);
+
+	while (!info->notify_callback_called)
+		l_main_iterate(-1);
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
@@ -469,6 +523,7 @@ int main(int argc, char **argv)
 	l_test_add("QRTR discovery", test_discovery, NULL);
 	l_test_add("QRTR services may be created", test_create_services, NULL);
 	l_test_add("QRTR service sends/responses", test_send_data, NULL);
+	l_test_add("QRTR notifications", test_notifications, NULL);
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
