Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD05EE76
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336756; cv=none; b=BiGWU+WAZzxNTyV+3T+fQn067yKyef4vU6rQRPsyLEQahKlMYT3mz1/XL6PEPJdUExg01pHnPG69uGysNNDcCndsmXrzzZHIsYNvCkAdqfpO5ulzbPG8+fcXjCCiosyTeLjTpWYP8Zi7ELkCPFDVeacKOo31LkZ7pcBFz3zt/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336756; c=relaxed/simple;
	bh=/evW93q/I4eEioOXydPbCyDa/nNlwvam9yqsOfrVGRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8A2jUQaSvztJOdozp9QSx5silrrs7sMnThcDli66024GKVYbsQiW7zDBm+EYHKUS5HStXBrPwOtEfmqXZI707FG2rQTwXUuzOwHB1ZtH1W7GV8uGAuT4yJFQ5PyUMAYfX5E08VwSiOqrzLH9hOySj6ra2U59Zbd9cW5VtbY9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Q6v/8bT9; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=rpy6j2TS; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Q6v/8bT9";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="rpy6j2TS"
Received: from pps.filterd (m0286619.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421EU2Av029480
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 15:45:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=lx3PKlAeXHCwAUfyO/YzDk/6VoMZEcxAhny/2Rz9PGI=; b=Q
	6v/8bT9J9/dAy6CpOy3TOIV3N5T6TIrCF7P5ieHHQrA0JJKGJCvCYZqE2gzJaw9a
	WEJpmqbB7dfqUTywJ0sCEG0bvCFDuwOuHMqO4JuZjByFfI82UT4Sn/lvsDg+AE/4
	E32h+cvqTOyeaJHZ6CJOgQSTSckpGyPnxk841H7Y8HzIUScWHeAZCG7yzW02x3Ze
	ivlWMRAD+mve+aM3B+2vjkIzDKS2FsKOPQJAGBO2FBeXxeQ5ZO+gEK5YhC+eWcXk
	9FmpZjA0vQq/xYHkwxtyX1KhMq+YxEBuInIuyp4O0nf60sXlUVQIFvjYl55bpydK
	L/HUWhpmV5zP/nFpcuAgA==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wj6jcjmpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 15:45:51 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36516d55c5fso33374865ab.2
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 15:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709336750; x=1709941550; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lx3PKlAeXHCwAUfyO/YzDk/6VoMZEcxAhny/2Rz9PGI=;
        b=rpy6j2TSOLEmnERq1Feo53lZZTvCkhq3c98QmoViGkmHO+H0CUe7ni9uHTAtFnGjk5
         JGye3z45/tOt339ISY/ZXW2yo6wPEDMlb/v6fMVM6faKj9cA1RUcSV1DiGoHmcC+edma
         fHf0SoJsS9x75SzCXn0EnFrzPJV97IAUWkexzkMNNGe6ruxJD03RSc7kfowRe8ibKuBS
         05iEWEOGpiIDv4VmfksLYId73paUgpXYTiisGuhCovacqI3gvVKz54i78GNgx60/Kamj
         /JnxJ+kmZlzj3WlFotPqctUkqimqU6NbKXdQ8cQZjyNPrwvi1/xYv2n1GbQtJtFluj7m
         aIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709336750; x=1709941550;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx3PKlAeXHCwAUfyO/YzDk/6VoMZEcxAhny/2Rz9PGI=;
        b=Y3zaZXoZqUbCWlG5cV+z6fUiurimNkSw++peuxGFinJr3fLEoQkWeDmvOF6vN7X6pF
         mBlQnxI5FavLaIGPCmkCO2viot5xiL5mic/Vav2t8HJcdPOi7H2DAG4Dl17RQnsJHfXR
         jx9vZLsdQR+v5eYO7TSv4Gzd0cwIz8R4PrYUsuUKgQ77ajK3mtqlCsztyceoYlQ81a7n
         jpohsHFQ6wduRiF1BrR+4L2KkOR+MNrCyM+kjFJ8JtTXWh/CHo+4JZN8g96Ja18A92+J
         g9w3ihg0tASBq9+KxHebjk9wu6rED6Cxt9zEzkbXhnkheyXkW0g0J27hWn6Pi/RsRTH/
         m0QQ==
X-Gm-Message-State: AOJu0YzIMnf1D9fnMaaVdcpTrg0BhaDvGoQ4YJksJkC4G4bxumBTAeja
	7ANO7I5QuCuilHabBO2mm3/OOiLxGlBM144oPWJ1aj+gxP3mnk6VWx0QpzjR189UT/lUq3N+bCX
	OdYyDve3vZdYhbO/BZfxniKFOJAJHshlK1ya5FOPiYWog+C1vwSMiKABdrxYDEq1j+N3Vev/DaK
	o7V3U9poiqD5hvbpstIhE3vo4+FjVCLq+oYIoPxYfkuQ01jY8=
X-Received: by 2002:a05:6e02:218c:b0:365:1749:cae5 with SMTP id j12-20020a056e02218c00b003651749cae5mr3232741ila.19.1709336750627;
        Fri, 01 Mar 2024 15:45:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4z1XCFtOxkD7Q3+Z+ZFU+vYJU+zAH3eDg12B48cxCbfm1U4kDLLf0ZhExkFY8gIgSMgA6ig==
X-Received: by 2002:a05:6e02:218c:b0:365:1749:cae5 with SMTP id j12-20020a056e02218c00b003651749cae5mr3232733ila.19.1709336750355;
        Fri, 01 Mar 2024 15:45:50 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id c6-20020a92cf06000000b00365bd7f608esm1137012ilo.40.2024.03.01.15.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 15:45:50 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v4 1/4] qmi: Add an abstract group id to services and requests
Date: Fri,  1 Mar 2024 17:45:32 -0600
Message-ID: <20240301234539.1581017-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: IxSzpF_KF2-ZLN45ZihmdT2NZqVBo9c9
X-Proofpoint-ORIG-GUID: IxSzpF_KF2-ZLN45ZihmdT2NZqVBo9c9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010195

This will allow services and requests to be matched without using
the QMUX client id which does not exist in QRTR.
---
 drivers/qmimodem/qmi.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 23a5fee7..44d1738d 100644
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
@@ -692,8 +695,9 @@ static void wakeup_writer(struct qmi_device *device)
 	device->writer_active = true;
 }
 
-static uint16_t __request_submit(struct qmi_device *device,
-				struct qmi_request *req)
+static uint16_t __service_request_submit(struct qmi_device *device,
+						struct qmi_service *service,
+						struct qmi_request *req)
 {
 	struct qmi_service_hdr *hdr =
 		(struct qmi_service_hdr *) &req->data[QMI_MUX_HDR_SIZE];
@@ -703,6 +707,8 @@ static uint16_t __request_submit(struct qmi_device *device,
 	if (device->next_service_tid < 256)
 		device->next_service_tid = 256;
 
+	req->group_id = service->group_id;
+
 	hdr->type = 0x00;
 	hdr->transaction = L_CPU_TO_LE16(req->tid);
 
@@ -1397,6 +1403,11 @@ static struct qmi_service *service_create(struct qmi_device *device,
 	service->client_id = client_id;
 	service->notify_list = l_queue_new();
 
+	if (device->next_group_id == 0) /* 0 is reserved for control */
+		device->next_group_id = 1;
+
+	service->group_id = device->next_group_id++;
+
 	memcpy(&service->info, info, sizeof(service->info));
 
 	__debug_device(device, "service created [client=%d,type=%d]",
@@ -2667,7 +2678,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	if (!service)
 		return 0;
 
-	if (!service->client_id)
+	if (!service->group_id)
 		return 0;
 
 	device = service->device;
@@ -2680,15 +2691,15 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(service->info.service_type, service->client_id,
-				message,
+	req = __request_alloc(service->info.service_type,
+				service->client_id, message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
 				service_send_callback, data);
 
 	qmi_param_free(param);
 
-	tid = __request_submit(device, req);
+	tid = __service_request_submit(device, service, req);
 
 	return tid;
 }
@@ -2729,9 +2740,9 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 static bool remove_req_if_match(void *data, void *user_data)
 {
 	struct qmi_request *req = data;
-	uint8_t client = L_PTR_TO_UINT(user_data);
+	unsigned int group_id = L_PTR_TO_UINT(user_data);
 
-	if (!req->client || req->client != client)
+	if (req->group_id != group_id)
 		return false;
 
 	service_send_free(req->user_data);
@@ -2740,10 +2751,10 @@ static bool remove_req_if_match(void *data, void *user_data)
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
@@ -2753,15 +2764,15 @@ bool qmi_service_cancel_all(struct qmi_service *service)
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
