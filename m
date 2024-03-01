Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D0759176
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331548; cv=none; b=SckoOHqce3hae8em8GaxcsTDvG/f3TgEVRsFFZItihbKryXhc54os62Me1pyrBGgfbnz3sfvXrQwam2e5gLqFyNSGXcvLjFzS8j/ph+BuNynslr41PIguDqOeQjAKHF2nJGnbrN5IK13IAndaq2g0FCSh0GOUgR4u9QAydAkNhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331548; c=relaxed/simple;
	bh=KdyoEURJLvexlSecaodikI+afQxJ+Eka8oMRBUnQ/FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S03bpftXQE5j+dmMYYN1ctfoNg8rQNwU4O+LZ2hAb8PtnUUVn0kl3TiNbGVoHWwNPccVI8eimv8DjWCgnyXdyRGbGxZ5TXqoS/CiLsvozcRJsP/sjKKd6AJyLoiRqUGf4uKIrj4TSTPU7wX+1vHMgtLu27MoN8CjWX5RDkTpRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=YU1CCgOE; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=SwRMLaz4; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="YU1CCgOE";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="SwRMLaz4"
Received: from pps.filterd (m0286616.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421H8pMH003743
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 14:19:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=LfvOTbDRdyK6APQJzsz5j5
	UXNAaBgl7MAYAH3u946J4=; b=YU1CCgOEhRwEOiFobs0gSE2JZoai3QyxyB4bx4
	BLcvDKy9qONJl5j+knIRawWp2nj2hrm4V1yGsL24Wbqq6KHZ5cIBeow5ErCqpk5y
	0VmvYgtCqIVBPi3nS3BfelBZodJlHGcDnxPePU+fZvIIOdx0G2UqNv/9e6LYeU0J
	BS1rUW5GtdgNNDSY62naOOc5Fz3h9Lh3fOuaVVBOPf0TtHW+8bJ5pJovxo0HTgsa
	CVeMMnMOkVPm3Lg7XZXFaMrveCPYaguEya62LyYOtJYXKJTgI0e+BXZ9WXWPIofk
	n1TFJi2bdOGE4Lm6nuaPo4vBwTWbtG6zeDbkLwy9rgSD2J6A==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wkk5mrbax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 14:19:04 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3651a261194so27527925ab.1
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 14:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709331542; x=1709936342; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LfvOTbDRdyK6APQJzsz5j5UXNAaBgl7MAYAH3u946J4=;
        b=SwRMLaz478G5u8UmL0ug2InQeAnayrtJNBz+AfXJaSTaK7grVgLzN3W1+VcT+SlRI7
         hnj1Z0FOUOrRRp9vVsH+lm2Czy3hJirI2NR6skaKK1D1Hd1wtm456Z6e/e4+0uMVTi+U
         o2hUozBqqxwq+mauh2ovL+d1UW/FXVlAw+6FK4EBcu4F0DdwBwJjvQmXe331PPg0r9++
         BUZKiAumKiAyKr8X9KPtpWtXsHDA1Qt145n6q7ZqtH5CgOTFXanlzYRUVWF9Xd8leQ8B
         tSHJZ+q2Mv8TF3JqEHVY4afVXM0HANl0AXmTGn0xaJWfSKHC6uv6tKCe/UzELd10VTXR
         Qgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331542; x=1709936342;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfvOTbDRdyK6APQJzsz5j5UXNAaBgl7MAYAH3u946J4=;
        b=Fr92HxFwbxuqD4LPA7hI002mLfecKVp59ZHAFaGv4tNd+6wq6xujJPwa/Rd7Igp+HN
         W6IAxlDqbhL0ib5pXDObAIxjtzhsCFtun0M7GtOgnh5iSQy+5N/bAdhYNLrq66KepFRX
         TFi4gSkIgRHtbl+pfdvAnXZEdF70w1RBmQUKrQu4Pfd3Q8pEZ9iwkifrn1ckJHAuIZ1y
         ijZ8dvQaQzoBlH1+NcEz7PJw32GL4wMUAsS3CH4GYJDjXCHyRokTVPuBwt9qdjPMAGpW
         AhLjuuFK2vTXHnn5tgAHM5DVgZWxfnk+CzdeZD5W4TQSFmH5GcIGsRqwi4NxPepsqres
         CnDQ==
X-Gm-Message-State: AOJu0YzbkCO6PMgQZymIyJnZKAOJHl1FwV1DsX1vs9WyMwrsjTvyU46C
	VYGqYmQAkQ/AmLtHvmVMgERo+JLkGCDHdzLTH8bRDAh9anMT+SD1yv2yS/plNFPuDUZNiGF2780
	tOvbTJ62g2Vng64oIFYSdQSb4bneTwPED8MSVpKn7twUeF7kGgVElsCfuwbi2vVNUiphkb13D5e
	YVDP2aNk8t3G0AvlHTaIZxxGtE3asmiykYcA8nOWnNolLu8kY=
X-Received: by 2002:a05:6e02:1649:b0:365:c567:6ef6 with SMTP id v9-20020a056e02164900b00365c5676ef6mr4254657ilu.8.1709331542559;
        Fri, 01 Mar 2024 14:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESNdnGu+ZGOUn08VJiYKZQDUMJbtVI2jvwHKVqh7/tZYFvUA5lVS+DUNp9s2+O4xIUK5eH8Q==
X-Received: by 2002:a05:6e02:1649:b0:365:c567:6ef6 with SMTP id v9-20020a056e02164900b00365c5676ef6mr4254644ilu.8.1709331542209;
        Fri, 01 Mar 2024 14:19:02 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id g13-20020a92d7cd000000b003639d3e5afdsm1127808ilq.10.2024.03.01.14.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:19:01 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v3 2/4] qmi: Store the service info in the request
Date: Fri,  1 Mar 2024 16:18:46 -0600
Message-ID: <20240301221851.1445586-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301221851.1445586-1-steve.schrock@getcruise.com>
References: <20240301221851.1445586-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: zrF73C8SzbJC198BcetbMquIxoQcFzg1
X-Proofpoint-ORIG-GUID: zrF73C8SzbJC198BcetbMquIxoQcFzg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010184

QRTR will need this to write to the appropriate node and port.
While here create helper functions to simplify request allocation.
---
 drivers/qmimodem/qmi.c | 59 ++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 44d1738d..a2a715e9 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -63,6 +63,7 @@ struct qmi_request {
 	uint16_t tid;
 	unsigned int group_id;		/* Always 0 for control */
 	uint8_t client;
+	struct qmi_service_info info;	/* Not used for control requests */
 	qmi_message_func_t callback;
 	void *user_data;
 	uint16_t len;
@@ -260,6 +261,30 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	return req;
 }
 
+static struct qmi_request *__control_request_alloc(uint16_t message,
+				const void *data, uint16_t length,
+				qmi_message_func_t func, void *user_data)
+{
+	return __request_alloc(QMI_SERVICE_CONTROL, 0x00, message,
+					data, length, func, user_data);
+
+}
+
+static struct qmi_request *__service_request_alloc(
+				struct qmi_service_info *info,
+				uint8_t client, uint16_t message,
+				const void *data, uint16_t length,
+				qmi_message_func_t func, void *user_data)
+{
+	struct qmi_request *req;
+
+	req = __request_alloc(info->service_type, client, message,
+						data, length, func, user_data);
+	memcpy(&req->info, info, sizeof(req->info));
+
+	return req;
+}
+
 static void __request_free(void *data)
 {
 	struct qmi_request *req = data;
@@ -1495,9 +1520,8 @@ static bool qmi_device_qmux_sync(struct qmi_device_qmux *qmux,
 
 	__debug_device(&qmux->super, "Sending sync to reset QMI");
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-				QMI_CTL_SYNC, NULL, 0,
-				qmux_sync_callback, data);
+	req = __control_request_alloc(QMI_CTL_SYNC, NULL, 0,
+					qmux_sync_callback, data);
 
 	__ctl_request_submit(qmux, req);
 
@@ -1623,9 +1647,8 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_GET_VERSION_INFO,
-			NULL, 0, qmux_discover_callback, data);
+	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0,
+						qmux_discover_callback, data);
 
 	data->tid = __ctl_request_submit(qmux, req);
 	data->timeout = l_timeout_create(5, qmux_discover_reply_timeout,
@@ -1769,10 +1792,9 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	qmi_device_get_service_version(device, data->type,
 						&data->major, &data->minor);
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_GET_CLIENT_ID,
-			client_req, sizeof(client_req),
-			qmux_client_create_callback, data);
+	req = __control_request_alloc(QMI_CTL_GET_CLIENT_ID,
+					client_req, sizeof(client_req),
+					qmux_client_create_callback, data);
 
 	data->tid = __ctl_request_submit(qmux, req);
 	data->timeout = l_timeout_create(8, qmux_client_create_reply,
@@ -1806,10 +1828,9 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 
 	qmux->release_users++;
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_RELEASE_CLIENT_ID,
-			release_req, sizeof(release_req),
-			qmux_client_release_callback, qmux);
+	req = __control_request_alloc(QMI_CTL_RELEASE_CLIENT_ID,
+					release_req, sizeof(release_req),
+					qmux_client_release_callback, qmux);
 
 	__ctl_request_submit(qmux, req);
 }
@@ -2691,11 +2712,11 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(service->info.service_type,
-				service->client_id, message,
-				param ? param->data : NULL,
-				param ? param->length : 0,
-				service_send_callback, data);
+	req = __service_request_alloc(&service->info,
+					service->client_id, message,
+					param ? param->data : NULL,
+					param ? param->length : 0,
+					service_send_callback, data);
 
 	qmi_param_free(param);
 
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
