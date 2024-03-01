Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A359B4E
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331550; cv=none; b=ZiCi8IIqIVm3sYxhDPIg9n+VNF6rx0ZSpfQo2GrCbRF/+lxTVlHWHuvs/LmP7u3wyJkk7HKvm3Lu23dvQaJMKXQh+tviB8YZy2luIo870wTnjaaOO6ws7U+BPabk94Jy9ybQokDQ2+3XrEKIbbKiv8kav9npaXXY6cGTAEm0V4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331550; c=relaxed/simple;
	bh=/evW93q/I4eEioOXydPbCyDa/nNlwvam9yqsOfrVGRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qdp6Y5PzeDkztBaPeYHtDp/iAwB3oPs/g43PcTepCGrVaSqlJlvpMwJFsEZjTznsjuy2RjkSYM4QS5PPvGEYsaFUVshVjefBFMi4NWAfUcXv2fBfWnjOYgndA+IkZtYFtrDpf1QER6qRTTubznAxspsxmCWKKWLf7UgQDsHedGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=UsaDEYYM; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=lqXxF0hb; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="UsaDEYYM";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="lqXxF0hb"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421DpOeq031338
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 14:19:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=lx3PKlAeXHCwAUfyO/YzDk/6VoMZEcxAhny/2Rz9PGI=; b=U
	saDEYYMJI9RiDpV4Fk3eVTOVU76QSDykKIjeiR6t7+qjWgzCo0MzSr1ziCkC1N7A
	Hh2DlaJ9U1xFzL65H4sbA4jQhDg+MHAYox4WqQqI2ELds7TWdm+SZJMnN3+Z+m72
	74jgSUBGG8aywqnHnvBvY582IxbRbKsCLHhiBnmAA4e2Ok6KC/nu5WKvDRXYY/HJ
	++8MZoq0xLTaFb0LxktypjmNgrs5jQAjWL0wzDXQvRZoHYyvOCE5erxGprJq4hap
	sA6LY1i81FxnZd0/VAsx1kDSWG+prMGQQftuK91/tMMlezxi1/Rhps1h/bw/SXne
	j/wPwOq2vskT4emoUN3zA==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wjbv9a73s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 14:19:08 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365b4dc6c3eso27412375ab.2
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 14:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709331547; x=1709936347; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lx3PKlAeXHCwAUfyO/YzDk/6VoMZEcxAhny/2Rz9PGI=;
        b=lqXxF0hbJUwCALFH8q2nX5oPgyiL9ETRLjKKQgh3jtKlrwZSGP8wtN2CDlyuaU52Xs
         OwgfJsLpA9ioEY0qSdFBXTfVKGl6POz88zoJ9ydVDzIFOjw8RhOLlosSqGOslovH4Mw6
         lL/tp0uiFhLI2NRX7Scg65K1KL1bF/NHgk6f9ZFd2ZBStS31WwXoxuFWpVHy/9/lNrA0
         /bx8yxXlU8G5WTi+PV5qCnmNeEbaIpPpYvAGVNI7itjyILggPRFbH/IBvJ+heWqe0MnT
         DKGkRG7Fwq0e+Q2awt6euT86pZt3raVd8BBz+EQAGrK2rjn12sLNxCsc61oHm/MPdHSX
         QWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331547; x=1709936347;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx3PKlAeXHCwAUfyO/YzDk/6VoMZEcxAhny/2Rz9PGI=;
        b=oyraSYyH3+RUKbcDrHjc/lpu12Iztiq3kytmR02yJDmmW2K/88Xjzgh3b0Qnzj8cO/
         i2UgK0RsLDAMWHQFkuyxm7Q8xT/b8r+xfq9AOtbTlfq4T531jqT3cLcbCzwNLOyjcAni
         mCd9/uF0zum1TSaF5WXrqU4PFe8f3A99W0mQfIF2yJOlKBFO6D5KcFuZjq9FtyQno2FB
         9kT16ivtvY+Q4ULevLRfDvwtW83TSHTGuEGqrytH3n/8jI8LukvaNgilmtgG4e6hgzwy
         QOQZr3eEX9ZsX6lOpuiGCP5SMPpky4jWeJqGbRAQmVJmci2aiQeYC6bWQ0BErTlqA4fc
         wOxg==
X-Gm-Message-State: AOJu0Yw8ggyQISbkCqlGcbbGNI6Pe3GnamUMgiXCrRJjvyqVFI5a70CT
	oRUTE0T7eRhjM8gVFUFItLvHO4izaQnICoZ2DN2Y9ejMGwMUWr5eTN1d/xfBGaLBkdP1osEVu0a
	NypqrSXzmAm4OE+xu/N/RfnmtonczWf7eohDGiDolpjWCSkLjSswO2l/CSyALIKWU5lVmadgTB1
	Ee9m1+nEGGX8aEixUXZ3D5+dcw2F4extUPbYFq6rojKvB2Hc8=
X-Received: by 2002:a05:6e02:148f:b0:365:16c8:ca7c with SMTP id n15-20020a056e02148f00b0036516c8ca7cmr3673170ilk.23.1709331542270;
        Fri, 01 Mar 2024 14:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7GExbn3/Chk/0ISBd24Pcf5PBf6XFUKajplLUeoPnOXWIsXgKc1A8f3V96Cx7nT+SX2GvRQ==
X-Received: by 2002:a05:6e02:148f:b0:365:16c8:ca7c with SMTP id n15-20020a056e02148f00b0036516c8ca7cmr3673141ilk.23.1709331541740;
        Fri, 01 Mar 2024 14:19:01 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id g13-20020a92d7cd000000b003639d3e5afdsm1127808ilq.10.2024.03.01.14.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:19:01 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v3 1/4] qmi: Add an abstract group id to services and requests
Date: Fri,  1 Mar 2024 16:18:45 -0600
Message-ID: <20240301221851.1445586-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: MJ5tVSdVPI9J-mksHPmtHnbElU5lbNn8
X-Proofpoint-ORIG-GUID: MJ5tVSdVPI9J-mksHPmtHnbElU5lbNn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403010184

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
