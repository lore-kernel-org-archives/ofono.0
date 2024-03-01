Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E504420DC5
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313110; cv=none; b=C0gSe8Nj5eBDz1leaYQlbvjOB+Zq9k1vgGw9nYOWcNfnDvhd7pBUEO+lhaGYiE+pgvgINp+xOsKpFr7HaFO4uTqZ7XWMObvGElP9n0KuoNbKTg9nh1+8uxA5PASPgKSeySd3PeLxhxK2TaFTaROdFZ9nKpW3c+iP4ZSBC4S9r0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313110; c=relaxed/simple;
	bh=WakRB6ed7zqwaupLUc+g5/3PGP5nugxxbMqSYt6r+GY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R8Xy3tc8FJVGKNPZ0mzshGVaxOWzx5K3VPPJDNrnwx4KRqW2JJdxFw/OLyjDm4wR+u8wOsuJ6XHRWTJtId3qbHcWdRZg/dAdKb5hIdyH3LUBGJr4wdLktf7CWwQBlNAi5n44jN7PX5RB0aAzNcNV8wV0zFVe85+SGmo3d9o3M7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=GWEji9Y8; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=eYc93q+v; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="GWEji9Y8";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="eYc93q+v"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421EVjZI019599
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 09:11:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=GS+6fR5AhkBxv0dGFGYyBA/LayxewcRpe69e9rqoF3Q=; b=G
	WEji9Y8CL9DZLb6LzX8NUYEgxpl7CsmkCxXh/O/eBVdVC40nvNMYOrs0K9KH75iu
	6bZyGKfEqipd31LUxoindsvxeLSR3bZ4L2dCP8qdiZ1gmF38Yd8Ix9EExjUS4zhm
	mwtBQ0xCYcMDudzAHvwayYPHjM0xhYZFUAoJHKSSqp50HWWPIdbDklUp0k3HjYBd
	sd62o5MZEycWxqTZCh4ztGqKACyDED0wygsvc0E8CUXd39FzGSE52pslFv2g7B28
	//lsvfOMz8M97bsE0CED/QR/TLQ+ZjxkAfKZqF+X+DHk+rpDLXyQ99HGqpeyNK58
	YKZCigBPhIGbFcWxFgV7g==
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wjxass0n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 09:11:42 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c495649efdso305348039f.2
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709313101; x=1709917901; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GS+6fR5AhkBxv0dGFGYyBA/LayxewcRpe69e9rqoF3Q=;
        b=eYc93q+vW4+v+lLwNA8hh7arLH18fVmOJ/Ns5hCEMG8EoLaXQwjveslOgT1keEzpa3
         d7jVmf/bumaHiGvs4MlDwR8Lvur3rKsjI7K7dQ6DbTT/tyjwVRkr32Kvh+oNom1RQnxb
         6Wd6d+u9M/iXtH5xSA1EZ9rykzfPwZ9XN6tTrYNyjmL2jZZFd2XoT5cdn0vcbbMUs+zs
         uBSC8IVwNsiGUZEMskHdxCR6kYsoytp/mw9d67bPS8HNVcYgLlmZxcY+CuchYJt7nBWv
         ux+V+vwUvfU9NHKvad4yYb1/NVp/htW7v3in8bZ/SGhGwiim01iVTfBLTAINgJeWjKy2
         reBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313101; x=1709917901;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GS+6fR5AhkBxv0dGFGYyBA/LayxewcRpe69e9rqoF3Q=;
        b=iOEjqc9O2o3qrvs5HXAC9YePJU4nJI2/cCYl2YFBwpXa8AVKhzWgc7HqDvh8RUqUZq
         V6MXvrx80nKNnivEKLIGTpPT1h6ysAvjoH3jE4EYuY7d9HxL1LgRVMRYVS8A09WE72ZD
         vaMACcEdRBJmmXzjXeHrlBl9GwxkTsaNnkqtofckUpcvdF6Txf4Iyy7qtFgZ7k9Bf5xF
         1uiix/mJtuQtNWViUt8JBag6147/EqkDRcWfmlv/cWJde+YMEq99ct8M7jFOyisCnk7K
         EMRi4UYQiS8tsjpWNPzoVr2/46e95G+2jeitUaOwUWzDqEGu3G+WYL0dU2D+a49Vxn9h
         EwtA==
X-Gm-Message-State: AOJu0YwfUlRUx/ameAMupSDX/0hkMWMXT0egKs3svNYG7x8NoaHK2FAf
	rat1OdPd5+7GxGvSp0eWntmwi1IVC32WpR221+AirpfOaop4DycnTghCQJTMca1il5emsV5N/v8
	QJI18ssjUQQcY9nYZOvvO80CDe/FmKK0qh1fciFinG8NubFFGckfXIQ+jy1b9PXQjl8cprK11gA
	Cn+RTrGWErqFqfJtiYM7j5m2kA8hpPXxVYPQO3ZOivy0z2kRcu9Q==
X-Received: by 2002:a5e:951a:0:b0:7c7:d38e:4f70 with SMTP id r26-20020a5e951a000000b007c7d38e4f70mr2040017ioj.19.1709313101075;
        Fri, 01 Mar 2024 09:11:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3C+7fPaqCo8mu8s0rBb++I9MQ46cHMLt5mxilP9e53dQkT5ArfzdyMcYSvHpXcHnrdlGr3g==
X-Received: by 2002:a5e:951a:0:b0:7c7:d38e:4f70 with SMTP id r26-20020a5e951a000000b007c7d38e4f70mr2039987ioj.19.1709313100670;
        Fri, 01 Mar 2024 09:11:40 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id gs22-20020a0566382d9600b004745a061467sm881059jab.87.2024.03.01.09.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:11:40 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/3] qmi: Add an abstract service id to requests
Date: Fri,  1 Mar 2024 11:11:20 -0600
Message-ID: <20240301171124.38735-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: orbFEvm8UWJcMP6T1lz1FMO4Fe6YSqQ3
X-Proofpoint-GUID: orbFEvm8UWJcMP6T1lz1FMO4Fe6YSqQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_19,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010143

This will allow services and requests to be matched without using
the QMUX client id which does not exist in QRTR.
---
 drivers/qmimodem/qmi.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 23a5fee7..ce40d6a1 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -61,6 +61,7 @@ struct qmi_service_info {
 
 struct qmi_request {
 	uint16_t tid;
+	unsigned int service_id;	/* Always 0 for control */
 	uint8_t client;
 	qmi_message_func_t callback;
 	void *user_data;
@@ -90,6 +91,7 @@ struct qmi_device {
 	struct l_queue *req_queue;
 	struct l_queue *service_queue;
 	struct l_queue *discovery_queue;
+	unsigned int next_service_id;	/* Matches requests with services */
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
 	void *debug_data;
@@ -119,6 +121,7 @@ struct qmi_service {
 	int ref_count;
 	struct qmi_device *device;
 	struct qmi_service_info info;
+	unsigned int service_id;
 	uint8_t client_id;
 	uint16_t next_notify_id;
 	struct l_queue *notify_list;
@@ -213,6 +216,7 @@ static void __qmi_service_appeared(struct qmi_device *device,
 }
 
 static struct qmi_request *__request_alloc(uint8_t service,
+				unsigned int service_id,
 				uint8_t client, uint16_t message,
 				const void *data,
 				uint16_t length, qmi_message_func_t func,
@@ -232,6 +236,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	msglen = hdrlen + QMI_MESSAGE_HDR_SIZE + length;
 	req = l_malloc(sizeof(struct qmi_request) + msglen);
 	req->tid = 0;
+	req->service_id = service_id;
 	req->len = msglen;
 	req->client = client;
 
@@ -1397,6 +1402,11 @@ static struct qmi_service *service_create(struct qmi_device *device,
 	service->client_id = client_id;
 	service->notify_list = l_queue_new();
 
+	if (device->next_service_id == 0) /* 0 is reserved for control */
+		device->next_service_id = 1;
+
+	service->service_id = device->next_service_id++;
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
+	if (!service->service_id)
 		return 0;
 
 	device = service->device;
@@ -2680,8 +2690,8 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(service->info.service_type, service->client_id,
-				message,
+	req = __request_alloc(service->info.service_type, service->service_id,
+				service->client_id, message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
 				service_send_callback, data);
@@ -2729,9 +2739,9 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 static bool remove_req_if_match(void *data, void *user_data)
 {
 	struct qmi_request *req = data;
-	uint8_t client = L_PTR_TO_UINT(user_data);
+	unsigned int service_id = L_PTR_TO_UINT(user_data);
 
-	if (!req->client || req->client != client)
+	if (req->service_id != service_id)
 		return false;
 
 	service_send_free(req->user_data);
@@ -2740,10 +2750,10 @@ static bool remove_req_if_match(void *data, void *user_data)
 	return true;
 }
 
-static void remove_client(struct l_queue *queue, uint8_t client)
+static void remove_client(struct l_queue *queue, unsigned int service_id)
 {
 	l_queue_foreach_remove(queue, remove_req_if_match,
-				L_UINT_TO_PTR(client));
+				L_UINT_TO_PTR(service_id));
 }
 
 bool qmi_service_cancel_all(struct qmi_service *service)
@@ -2753,15 +2763,15 @@ bool qmi_service_cancel_all(struct qmi_service *service)
 	if (!service)
 		return false;
 
-	if (!service->client_id)
+	if (!service->service_id)
 		return false;
 
 	device = service->device;
 	if (!device)
 		return false;
 
-	remove_client(device->req_queue, service->client_id);
-	remove_client(device->service_queue, service->client_id);
+	remove_client(device->req_queue, service->service_id);
+	remove_client(device->service_queue, service->service_id);
 
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
