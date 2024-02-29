Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469713EFF6
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220732; cv=none; b=M8w4GTU8EDv3TjVWRePB5qI/w+NZ9sHxUJ/hi2cY8sMOhsobrR/leCcZKhub27DTj7z5iKTtOhrDXuUamVoSzTfUNxW4+tp5foxxjpy3VVlmPni1cdzXrDB/RMWjLHqogqPc0ZT1gLTadBDoDTv26ixhEu1+GFxsS8qbFXefjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220732; c=relaxed/simple;
	bh=j2JnLs+JUEjFfAoJiNsqxoXyrI7291kP82ghK0ZVPvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIm031FsNN2i0y0EVSW38Eda1GxJV6dCkEJ5c9aUJllFBoM6OYYEB1aT4WeOHRiajIGuBLCWSQjbhnMN/oxtnxidAYO7lsPXoMik9t2DtQldzfwvWwN6VQ5atdHsV005I+Mm3/lTDZiDyOD7VgpeS6qWtnWHSpwemlLZF7SQgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=g6UrRfYJ; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=oZ8Op7OZ; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="g6UrRfYJ";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="oZ8Op7OZ"
Received: from pps.filterd (m0286619.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TEelrb029063
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=ttIhhjlyNyFxbGA/b8VD5w
	4/wyLT3VXxjEbA7Nda4HM=; b=g6UrRfYJvrw561CaEswBVE90mtbCBRwx9okM0X
	y/HIaBmu0aG2itx/6PDmQHRotmRT1nD/YW3epkJwwD/KTg0A9fYP8CwEwjVqSpwZ
	zHWcow2nV/DlgQGlFJVMEvf4FOj6xSclRxWJDP718G071Fgac6QUFJggIGPeUW+t
	qhO36KGGYMPQDKjr76h6FPfLaE55ZqVADlESMjYcCDVzSHRWzYSus0YTI/0dWXpf
	SddDUKT9IiY//vXv2xSkeB2j4PiiRpjWesGYYhcIg+HaoalBd2OQlGGpIoV1ZLgf
	wppUxzjj4pCWhBptiay0LnFjl4sW8GIkkLYJyHDvWmru+JsA==
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wj6jch3gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:08 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c7a2788749so97500139f.0
        for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709220727; x=1709825527; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttIhhjlyNyFxbGA/b8VD5w4/wyLT3VXxjEbA7Nda4HM=;
        b=oZ8Op7OZZnCvs1Z8+y+EK8Kv2L4i935e4aXp2yLilAKksKHTNWZk1dycoZhawU1Gl8
         x6SHaOwEvhbP+hu2QFKEzBgsSSvxw2nwu4iKg+Gs6iJyWTXLrMuZY/mh/I/vwFi0QeHU
         7juUyByTq8+xQh0Wm7of/hRtCUjFVuJzQDrhX0I7vAd1/f/EPTuXn2EjqRnJQLpTLzAK
         NBoQGr2t1eqCM43jGbX4fpxzSJ1ACYgNKo33PEIfkRXFJFTbVZpRuhivYNZRTlxfj3cX
         T0zSYV1GbHm+tySuN89PhnNMY/JsxzlXUt1VJMVTno2mqLT8clZDBfzmKFqCMWt9y8S6
         MFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709220727; x=1709825527;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttIhhjlyNyFxbGA/b8VD5w4/wyLT3VXxjEbA7Nda4HM=;
        b=t4A0mbBLj8TLYrMIplDTuExV7ILNymWxznsgkuBIB+fcClm17FQJJl3dWGw0dOogID
         JJXjIxRVIl63lOXoXZcqk765wQcFBTxWKObrawWLOLL0cgY0QDBrPwNfd1akjx2EPz0g
         Jydn9uzsjVdUhPJwVuO8XENzJB0MFQu3Nx1rgTjBG6LSfPUwxpJRuW1f3LIixSeJC+qg
         Fr8Xgh9N0StkHCWKGqOCFTVTa2buNReyv0Xs+pi4RPGNeJvz6w5aoOBR72EoMtF2ocrw
         lYFYd7C6pP/A9yzA6UGMrOqHl7ikp2Aoq4U1ZJ/Z126XlT18bs40zztZTv/Vrnp+PB7t
         EkTg==
X-Gm-Message-State: AOJu0YwG9nKfaJB+heUuwEtji1lwnwa+awEg1pN4u16N8lnsZvjFUPmB
	QlUUWevT6WoS7VFcdBXJu5DsZIz4SldOkdrekwOzQA5QVCOHbxbck150HVgVK9ePLTlrDL02NJ1
	RmIHf024IKEZcWLVJ9cILATPsiVgvHM783cTVTof5vICQemHdXuDBL1vpekJlmv6dCYGdS1jD/a
	oeHebDLNXXm9xUNXBBKzr+VWPqB/n28cO9mzdi4YiNCCw6rko=
X-Received: by 2002:a05:6602:1605:b0:7c7:b0de:d921 with SMTP id x5-20020a056602160500b007c7b0ded921mr3067764iow.18.1709220727223;
        Thu, 29 Feb 2024 07:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIs+4kXiZCn6iwwQK8CjYoelO0UwgcjAaVANPpg3J6vUhOBqgZAUndXDbeCTvHdsOlE3ZNOg==
X-Received: by 2002:a05:6602:1605:b0:7c7:b0de:d921 with SMTP id x5-20020a056602160500b007c7b0ded921mr3067735iow.18.1709220726845;
        Thu, 29 Feb 2024 07:32:06 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-217274.corp.robot.car (150.199.192.35.bc.googleusercontent.com. [35.192.199.150])
        by smtp.gmail.com with ESMTPSA id g2-20020a028502000000b00473e3c9d039sm381696jai.18.2024.02.29.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:32:06 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 2/4] qmi: Add more service info to qmi_service
Date: Thu, 29 Feb 2024 09:31:39 -0600
Message-ID: <20240229153151.36410-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229153151.36410-1-steve.schrock@getcruise.com>
References: <20240229153151.36410-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: 8F7WnIbtbxsh3DfrMRnmc_SDFIglg3DG
X-Proofpoint-ORIG-GUID: 8F7WnIbtbxsh3DfrMRnmc_SDFIglg3DG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290119

QRTR will need to know the node and port for writes.
---
 drivers/qmimodem/qmi.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index d65a1c15..d2f28bec 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -118,9 +118,7 @@ struct qmi_device_qmux {
 struct qmi_service {
 	int ref_count;
 	struct qmi_device *device;
-	uint8_t type;
-	uint16_t major;
-	uint16_t minor;
+	struct qmi_service_info info;
 	uint8_t client_id;
 	uint16_t next_notify_id;
 	struct l_queue *notify_list;
@@ -315,7 +313,7 @@ static void __service_find_by_type(const void *key, void *value,
 	if (L_PTR_TO_UINT(key) & 0x80000000)
 		return;
 
-	if (service->type == data->type)
+	if (service->info.service_type == data->type)
 		data->found_service = service;
 }
 
@@ -1687,17 +1685,18 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	service->ref_count = 1;
 	service->device = data->device;
 
-	service->type = data->type;
-	service->major = data->major;
-	service->minor = data->minor;
+	service->info.service_type = data->type;
+	service->info.major = data->major;
+	service->info.minor = data->minor;
 
 	service->client_id = client_id->client;
 	service->notify_list = l_queue_new();
 
 	__debug_device(device, "service created [client=%d,type=%d]",
-					service->client_id, service->type);
+					service->client_id,
+					service->info.service_type);
 
-	hash_id = service->type | (service->client_id << 8);
+	hash_id = service->info.service_type | (service->client_id << 8);
 
 	l_hashmap_replace(device->service_list, L_UINT_TO_PTR(hash_id),
 				service, (void **) &old_service);
@@ -2526,12 +2525,12 @@ void qmi_service_unref(struct qmi_service *service)
 	qmi_service_cancel_all(service);
 	qmi_service_unregister_all(service);
 
-	hash_id = service->type | (service->client_id << 8);
+	hash_id = service->info.service_type | (service->client_id << 8);
 
 	l_hashmap_remove(device->service_list, L_UINT_TO_PTR(hash_id));
 
 	if (device->ops->client_release)
-		device->ops->client_release(device, service->type,
+		device->ops->client_release(device, service->info.service_type,
 							service->client_id);
 
 	l_free(service);
@@ -2542,7 +2541,7 @@ const char *qmi_service_get_identifier(struct qmi_service *service)
 	if (!service)
 		return NULL;
 
-	return __service_type_to_string(service->type);
+	return __service_type_to_string(service->info.service_type);
 }
 
 bool qmi_service_get_version(struct qmi_service *service,
@@ -2552,10 +2551,10 @@ bool qmi_service_get_version(struct qmi_service *service,
 		return false;
 
 	if (major)
-		*major = service->major;
+		*major = service->info.major;
 
 	if (minor)
-		*minor = service->minor;
+		*minor = service->info.minor;
 
 	return true;
 }
@@ -2629,7 +2628,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(service->type, service->client_id,
+	req = __request_alloc(service->info.service_type, service->client_id,
 				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
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
