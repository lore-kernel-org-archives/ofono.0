Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0953803
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326191; cv=none; b=SeWEga2rNAucAn9XR9vqs43hweUV4jyjRuGOTJrbIsAwwlKLS9FLhH2nD++oHOkk7P7p4ZpqV8+u8ch2wpe/SHyvGHN1rHuBQtP6YsAW88yDtbSP1Dcerc+DmdfWHTq2Fh5KzzCVfVlhE+8d0N4yT027KjbiwTxEAzUEt4ZwAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326191; c=relaxed/simple;
	bh=kZV4/R2fCVtviG2K9guK/7AVrwCbbbMxm44EnDYyY2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YeM7osu5+FHj5ZLiSDNgwgNhOI3tzO+2Isi8qLXcSBSbawIORZRtwDaKnHnoOgZTvvl1V4/Acl9Cx4wBSjEUALExVEfa3TruICpewrq/+Xyn3MUv5lvT1EAOM1maFz1Oy9Ax7OTx9GCvoSfz8Iutxnl90nwfxu4zNCUo61RXH90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=bOLaI/dD; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=gzopyAoa; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="bOLaI/dD";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="gzopyAoa"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421EV3b4018488
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 12:49:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=t1TB1kyAEcYQwOLpXCvMRRBOH42bDsdwlRaI1NcO0GU=; b=b
	OLaI/dDVaGB/CJ7dgp7Gd37CMFkaEDW1hJ0Num1tThgLVnSEd8o3pf5gLsvmgx+q
	BzUuUiUy3PmHJBCO0zwnInyEenqTNPK+lyDKcavFx9FZtG3Eg1grqDj+tpNl9TQk
	+vkoCDIQwm45tsgWpqhNGjpYpqnftyKyTG2VFabwGIc6d4I50nCpOeEWJP47f1BD
	i4I3I7oWzd5xF0fkSoEqiEdEAirZH/bTJ/KjXfk7uiUsO7ZdUpBB56sarRFAUmHQ
	X6AaaALX4U/++Lc85oQrZ7ScwBbMm9N83EMnLcpr1GtMKWJuEO4uZkWq14FSahMY
	2K/7Wo6AHaA0RZJkcHgPw==
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wj1bqamha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 12:49:41 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36527824ab9so27562915ab.1
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709326180; x=1709930980; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t1TB1kyAEcYQwOLpXCvMRRBOH42bDsdwlRaI1NcO0GU=;
        b=gzopyAoafTjGHZles7kuJiqoHeGc2kWDczycaIxApXhfg/tgOVf6xWntQJO+iRMOx1
         pB6ajmRMtfGT79lmOPdnK+cwbhBSnBifjc9GQx5aTxMDvl5c00ocGIcU9m4rGrmZJcUz
         +KeAOhBe5u215psb1lX2jRn37Wy3QWeSKJbZWbi4+sdFYkjXV+tqtbUAQ+uBY4albGjn
         BHd3x/I5Q+x3N57/98k1n2qKubBK3UZOi/AIaSfPJKVjXXPhPtyGdRERKAwyya0wQFSA
         UNEye21LZu9E5Wn/0VStdmznD2zaEotqc2M5hOMZw7szB1qZyHMHhD/YMqvyJob0qLcd
         5xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709326180; x=1709930980;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1TB1kyAEcYQwOLpXCvMRRBOH42bDsdwlRaI1NcO0GU=;
        b=Td+3vXOdoICQo42l0tCICSLf5L/bmx5SZ2h/1qLytLuAsvJj+nyTroX0VXFlr8zBJx
         5z0ZE4Ekq7fGm06yOedhRgn25bJMiXnUQm9E0csWEUFNTxE3XP/6KWMpfwNdVeb4MNCD
         j8kWPoNIqstAGUI018GlAfRDiWVH4GLGtHs8gAtTTrzuhMRo7Tt+vSO9p2jwTu9h3mFD
         kW/fE1B4XASNRtpaJBY7/ln1SoTh/QU/3r0KtXdsAfRKAyd3MM9TU6Yita2lZJhFZiKr
         STpsngLjVijmOOAxiJ4mYZ1kVUjEWAhorqr83Y6QnRdUlmSQAn1zFmCrkh5yxSzpaodV
         ByUg==
X-Gm-Message-State: AOJu0YwLe+tzQx6EixTzLj0J8tX8eyysb1ZJjt+e9WUozZ/ZPTDv1x10
	gXKvWdBIGMQmhAhSRQ/sPump2i3sFVyEeWY6cNWmzUq/ftzY6HUa++GuS6qsM0mc8D6MKd6rqJn
	0FpvfIu9by9jgMjuzi3coISzRLjTHIwBaep6/oloV1BR2zMzrU+IEiya4QRFDDxR8oL0NPe1G2I
	FMg9+bHcPNdQQcGEedapDok7dz4myGOD7oNn4tNL+dWtlSkp6agA==
X-Received: by 2002:a05:6e02:1e03:b0:365:4aa1:8bd5 with SMTP id g3-20020a056e021e0300b003654aa18bd5mr3657571ila.5.1709326180407;
        Fri, 01 Mar 2024 12:49:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+2L3rvsLwu+7X5bZjin85VDEAIYCFVtlFHfQsgXu+CtYUPopwTdNJbdqDKZfArkVDyMgD+Q==
X-Received: by 2002:a05:6e02:1e03:b0:365:4aa1:8bd5 with SMTP id g3-20020a056e021e0300b003654aa18bd5mr3657550ila.5.1709326180025;
        Fri, 01 Mar 2024 12:49:40 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id o2-20020a92dac2000000b0036581060910sm1089407ilq.6.2024.03.01.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:49:39 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 1/3] qmi: Add an abstract group id to services and requests
Date: Fri,  1 Mar 2024 14:49:24 -0600
Message-ID: <20240301204929.87220-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: AZ1cg5tHMKO-HhozQuqR2Fjl6qN6Tkzd
X-Proofpoint-ORIG-GUID: AZ1cg5tHMKO-HhozQuqR2Fjl6qN6Tkzd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_21,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010173

This will allow services and requests to be matched without using
the QMUX client id which does not exist in QRTR.
---
 drivers/qmimodem/qmi.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 23a5fee7..be598007 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -61,6 +61,7 @@ struct qmi_service_info {
 
 struct qmi_request {
 	uint16_t tid;
+	unsigned int group_id;		/* Always 0 for control */
 	uint8_t client;
 	qmi_message_func_t callback;
 	void *user_data;
@@ -90,6 +91,7 @@ struct qmi_device {
 	struct l_queue *req_queue;
 	struct l_queue *service_queue;
 	struct l_queue *discovery_queue;
+	unsigned int next_group_id;	/* Matches requests with services */
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
 	void *debug_data;
@@ -119,6 +121,7 @@ struct qmi_service {
 	int ref_count;
 	struct qmi_device *device;
 	struct qmi_service_info info;
+	unsigned int group_id;
 	uint8_t client_id;
 	uint16_t next_notify_id;
 	struct l_queue *notify_list;
@@ -213,6 +216,7 @@ static void __qmi_service_appeared(struct qmi_device *device,
 }
 
 static struct qmi_request *__request_alloc(uint8_t service,
+				unsigned int group_id,
 				uint8_t client, uint16_t message,
 				const void *data,
 				uint16_t length, qmi_message_func_t func,
@@ -232,6 +236,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	msglen = hdrlen + QMI_MESSAGE_HDR_SIZE + length;
 	req = l_malloc(sizeof(struct qmi_request) + msglen);
 	req->tid = 0;
+	req->group_id = group_id;
 	req->len = msglen;
 	req->client = client;
 
@@ -1397,6 +1402,11 @@ static struct qmi_service *service_create(struct qmi_device *device,
 	service->client_id = client_id;
 	service->notify_list = l_queue_new();
 
+	if (device->next_group_id == 0) /* 0 is reserved for control */
+		device->next_group_id = 1;
+
+	service->group_id = device->next_group_id++;
+
 	memcpy(&service->info, info, sizeof(service->info));
 
 	__debug_device(device, "service created [client=%d,type=%d]",
@@ -1484,7 +1494,7 @@ static bool qmi_device_qmux_sync(struct qmi_device_qmux *qmux,
 
 	__debug_device(&qmux->super, "Sending sync to reset QMI");
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
 				QMI_CTL_SYNC, NULL, 0,
 				qmux_sync_callback, data);
 
@@ -1612,7 +1622,7 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, qmux_discover_callback, data);
 
@@ -1758,7 +1768,7 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	qmi_device_get_service_version(device, data->type,
 						&data->major, &data->minor);
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
 			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
 			qmux_client_create_callback, data);
@@ -1795,7 +1805,7 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 
 	qmux->release_users++;
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
 			QMI_CTL_RELEASE_CLIENT_ID,
 			release_req, sizeof(release_req),
 			qmux_client_release_callback, qmux);
@@ -2667,7 +2677,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	if (!service)
 		return 0;
 
-	if (!service->client_id)
+	if (!service->group_id)
 		return 0;
 
 	device = service->device;
@@ -2680,8 +2690,8 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(service->info.service_type, service->client_id,
-				message,
+	req = __request_alloc(service->info.service_type, service->group_id,
+				service->client_id, message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
 				service_send_callback, data);
@@ -2729,9 +2739,9 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 static bool remove_req_if_match(void *data, void *user_data)
 {
 	struct qmi_request *req = data;
-	uint8_t client = L_PTR_TO_UINT(user_data);
+	unsigned int group_id = L_PTR_TO_UINT(user_data);
 
-	if (!req->client || req->client != client)
+	if (req->group_id != group_id)
 		return false;
 
 	service_send_free(req->user_data);
@@ -2740,10 +2750,10 @@ static bool remove_req_if_match(void *data, void *user_data)
 	return true;
 }
 
-static void remove_client(struct l_queue *queue, uint8_t client)
+static void remove_client(struct l_queue *queue, unsigned int group_id)
 {
 	l_queue_foreach_remove(queue, remove_req_if_match,
-				L_UINT_TO_PTR(client));
+				L_UINT_TO_PTR(group_id));
 }
 
 bool qmi_service_cancel_all(struct qmi_service *service)
@@ -2753,15 +2763,15 @@ bool qmi_service_cancel_all(struct qmi_service *service)
 	if (!service)
 		return false;
 
-	if (!service->client_id)
+	if (!service->group_id)
 		return false;
 
 	device = service->device;
 	if (!device)
 		return false;
 
-	remove_client(device->req_queue, service->client_id);
-	remove_client(device->service_queue, service->client_id);
+	remove_client(device->req_queue, service->group_id);
+	remove_client(device->service_queue, service->group_id);
 
 	return true;
 }
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
