Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000DC6FB8
	for <ofono@lists.linux.dev>; Fri,  3 May 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748572; cv=none; b=UUAO7QAl/u4mrH7e51wIwcZkfZyYP4fEC4F+d5MUmyUmglIjVyYovAHrpov8Ke+JtDEwx0ayRijucCzErsd04zoiV7rM6TDh7lpfvBPIC2HqenDrxZ3GtcyK5FmAumqFJoD0JAZSW4U5j/rD1Oq0xgPpFAkEvPaWzJ1lt0KDQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748572; c=relaxed/simple;
	bh=sceyytkrWhiPHwGOwTvXDxRXTNuEgas7Id5So2MS5pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qy5pZVuYfKHUf7GpvsiG+dDKVytouNvZQ9VHBaQzNwVEFhnIoxS9XuqXSIX9B5ChsnBnLH1BnkAiySkY8rdLZlxB91wP04KJBDL/YmQaLLtzTzG+3PLoKuyd3n7aT4WBLlKkZyC8WyXLPik0KwmZ5HIhqU+Y7w3uYToNA5oQw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=UUoppRo2; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=pDQb254J; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="UUoppRo2";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="pDQb254J"
Received: from pps.filterd (m0286621.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443ExRf9027780
	for <ofono@lists.linux.dev>; Fri, 3 May 2024 08:02:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=XpMMM6eOoL+FPZk9hDh8poH/qzTg0g8+4+uGZC9zGGM=; b=U
	UoppRo26g3vKrBTJcFTWxs/oSGTQPXShR5Fuf2u9pHLuwZ0hC1r4MqtwzuhxJuf+
	zxMVTbj1AXDbPEqwd/p7ZVdt18+UWmcRf8tVcaBz3uuwfMm+Qv/58aQWBfWQMEgi
	H4r8fCSzbDH44REbHusDXeKH12Wibp9hnda4rXVDrIlKog0GqpiwZnv8zXY113nN
	ZYMExmyX4YSIVk3Wn1npFo/9cAuZzWmJg2lB0RRGmfFjkFYq13drhNNlGpY3aX3o
	uxiO1aM/C6yC4jKKq/rDthU/lXqSP8LJK78sWHxMNtE0+clpphMeKEAcA6K2UqsY
	d6UOXr9Zn8bJgRPejaA5A==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xs0ecwaj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 03 May 2024 08:02:43 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c2ff79144so84657935ab.2
        for <ofono@lists.linux.dev>; Fri, 03 May 2024 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1714748562; x=1715353362; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XpMMM6eOoL+FPZk9hDh8poH/qzTg0g8+4+uGZC9zGGM=;
        b=pDQb254JYTkC6wjkOvSO5qAV+wZBtJbi48q9Z7tp6xeWbTLzakKRxRiTc0xIBVQGMt
         34ixFoE6khT0oaUdjWSmCc7/jMnBqUqyuG1Mhzyld84959r1AxtWctPZcTSQWYZ/7ZoU
         7eg57X/ayEmpp4n62qL2GZdFXxjb+OU5un8v5blLFy9nwTYvn/IfWYgipVzxXtZnif4W
         0ikSNmjq+7Y1TrprckVwE2rdY7jGAkaq/5jedWYZRFD5gb2c0xgVP0fNXpcBvZkxOqQL
         8+glsvxa/1oqdUh0np9+3dwGQp5b++LJdYysQ0Gs1JmXM3gCeb78iyXN4uF8fb4tc9ud
         Khcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714748562; x=1715353362;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpMMM6eOoL+FPZk9hDh8poH/qzTg0g8+4+uGZC9zGGM=;
        b=GX6BxfQ5X2P/fL+qqQM0LBptaByoJBj5BcEUfQytdPcW9+JRYLv0og1vHnKpTYBKXC
         Ib01f4eLEiIqpE8N7ZZLoLtVxtiplmr0qaMdVMEUMmrd+I+RwJR+XOE88DJ+Z3HVqZ0V
         ki8WWLD+8KEOBrZXnC6qr90yYGIBb7sK/O8wtV3R8ELt0RFnwjpbbjuium/glxf7ux5z
         Iw5AGUpm1bDlcqv8UnQg56sIS7pM6fargcACufqVq/iwOmhmbGWQPCERNoyClFosqKlP
         BTP1q3MZliw4IPyYcT5Y3TZFNsi56eEAN9DXOCE06Hjb8UxklEjRFcZt3ct2Gk/yDT2s
         gnRA==
X-Gm-Message-State: AOJu0Yz78I1A7/E+j81/hQYaQLCransI/EzbyInGBvvp5Kw/ht7c1DQK
	Zx3M/Zevvrku58KTl95dnsDPmOlC0sP0MKiOrWYNeTqBsY/T3lk6nhXdsTFegjmNmr9P0D0ur1Z
	n1i1RRSIJ2M7s0swKY8C/Ni8z5ZxwS03zQR76W2scNuNgcLH9mpNQweH6jfRfm1qC0ISOBExQ6Z
	G7ifxKmBlS4L35jn2H3hjI6zQced5iarvr1ksGvkNkwlUHKXM=
X-Received: by 2002:a05:6e02:1a27:b0:36c:d27:472f with SMTP id g7-20020a056e021a2700b0036c0d27472fmr3662541ile.29.1714748562305;
        Fri, 03 May 2024 08:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPJ/Mu3eJnzka9XgdaxYlBiho3MzDFXmsCWXtrROHOXELidrYxbk4QpZLMuwp5YBBY2dsr8w==
X-Received: by 2002:a05:6e02:1a27:b0:36c:d27:472f with SMTP id g7-20020a056e021a2700b0036c0d27472fmr3662464ile.29.1714748561304;
        Fri, 03 May 2024 08:02:41 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-743234.corp.robot.car (136.199.192.35.bc.googleusercontent.com. [35.192.199.136])
        by smtp.gmail.com with ESMTPSA id m6-20020a056638260600b00487c4826d55sm794996jat.31.2024.05.03.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:02:39 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 1/2] qmi: Separate the pending family creation queues
Date: Fri,  3 May 2024 10:02:18 -0500
Message-ID: <20240503150221.13964-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: wnAG1jBZiZrdk0E1_Skijfdk5c7HpXJq
X-Proofpoint-ORIG-GUID: wnAG1jBZiZrdk0E1_Skijfdk5c7HpXJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_09,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030105

The family_list hashmap is keyed by the client ID and service type,
unless qmux is creating the first client for a service type. In that
case the high bytes are 0x8000 instead of the client ID, and the
value is a queue of clients waiting for that service instead of the
service_family.

This commit moves the pending clients into thir own hashmap to ensure
that each hashmap contains a consistent type and eliminates the need
for marking pending keys with 0x80000000.
---
 drivers/qmimodem/qmi.c | 73 ++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 69a0e535f689..c3af4a4cd98c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -101,6 +101,7 @@ struct qmi_device {
 	qmi_debug_func_t debug_func;
 	void *debug_data;
 	struct l_queue *service_infos;
+	struct l_hashmap *pending_family_creations;	/* holds l_queues */
 	struct l_hashmap *family_list;
 	const struct qmi_device_ops *ops;
 	bool writer_active : 1;
@@ -354,10 +355,6 @@ static void __family_find_by_type(const void *key, void *value,
 	struct service_family *family = value;
 	struct service_find_by_type_data *data = user_data;
 
-	/* ignore those that are in process of creation */
-	if (L_PTR_TO_UINT(key) & 0x80000000)
-		return;
-
 	if (family->info.service_type == data->type)
 		data->found_family = family;
 }
@@ -785,10 +782,6 @@ static void service_notify(const void *key, void *value, void *user_data)
 	struct service_family *family = value;
 	struct qmi_result *result = user_data;
 
-	/* ignore those that are in process of creation */
-	if (L_PTR_TO_UINT(key) & 0x80000000)
-		return;
-
 	l_queue_foreach(family->notify_list, service_notify_if_message_matches,
 				result);
 }
@@ -927,6 +920,7 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 	device->service_queue = l_queue_new();
 	device->discovery_queue = l_queue_new();
 	device->service_infos = l_queue_new();
+	device->pending_family_creations = l_hashmap_new();
 	device->family_list = l_hashmap_new();
 
 	device->next_service_tid = 256;
@@ -942,6 +936,15 @@ static void __qmi_device_shutdown_finished(struct qmi_device *device)
 		device->ops->destroy(device);
 }
 
+static void free_pending_family_creations_queue(struct l_queue *pending)
+{
+	/*
+	 * The service_create_shared_data objects are owned by the discovery
+	 * queue and do not need to be freed here.
+	 */
+	l_queue_destroy(pending, NULL);
+}
+
 void qmi_device_free(struct qmi_device *device)
 {
 	if (!device)
@@ -956,6 +959,8 @@ void qmi_device_free(struct qmi_device *device)
 	l_io_destroy(device->io);
 
 	l_hashmap_destroy(device->family_list, family_destroy);
+	l_hashmap_destroy(device->pending_family_creations,
+		(l_hashmap_destroy_func_t) free_pending_family_creations_queue);
 
 	l_queue_destroy(device->service_infos, l_free);
 
@@ -1535,11 +1540,12 @@ static void service_create_shared_pending_reply(struct qmi_device *device,
 						unsigned int type,
 						struct service_family *family)
 {
-	void *key = L_UINT_TO_PTR(type | 0x80000000);
-	struct l_queue *shared = l_hashmap_remove(device->family_list, key);
+	void *key = L_UINT_TO_PTR(type);
+	struct l_queue *pending = l_hashmap_remove(
+					device->pending_family_creations, key);
 	const struct l_queue_entry *entry;
 
-	for (entry = l_queue_get_entries(shared); entry; entry = entry->next) {
+	for (entry = l_queue_get_entries(pending); entry; entry = entry->next) {
 		struct service_create_shared_data *shared_data = entry->data;
 
 		shared_data->family = service_family_ref(family);
@@ -1547,7 +1553,7 @@ static void service_create_shared_pending_reply(struct qmi_device *device,
 							shared_data, NULL);
 	}
 
-	l_queue_destroy(shared, NULL);
+	l_queue_destroy(pending, NULL);
 }
 
 static void service_create_shared_data_free(void *user_data)
@@ -1853,13 +1859,11 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
 	struct qmi_request *req;
 	struct qmux_client_create_data *data;
-	struct l_queue *shared;
-	unsigned int type_val = service_type;
+	struct l_queue *pending;
 
 	if (!l_queue_length(device->service_infos))
 		return -ENOENT;
 
-	shared = l_queue_new();
 	data = l_new(struct qmux_client_create_data, 1);
 
 	data->super.destroy = qmux_client_create_data_free;
@@ -1884,9 +1888,13 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 
 	__qmi_device_discovery_started(device, &data->super);
 
-	/* Mark service creation as pending */
-	l_hashmap_insert(device->family_list,
-			L_UINT_TO_PTR(type_val | 0x80000000), shared);
+	/*
+	 * Only subsequent requests for this same service will be added to
+	 * the queue.
+	 */
+	pending = l_queue_new();
+	l_hashmap_insert(device->pending_family_creations,
+			L_UINT_TO_PTR(service_type), pending);
 
 	return 0;
 }
@@ -2615,9 +2623,8 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			qmi_create_func_t func, void *user_data,
 			qmi_destroy_func_t destroy)
 {
-	struct l_queue *shared;
+	struct l_queue *pending;
 	struct service_family *family = NULL;
-	unsigned int type_val = type;
 	int r;
 
 	if (!device || !func)
@@ -2631,10 +2638,10 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 
 		/*
 		 * The hash id is simply the service type in this case. There
-		 * is no "pending" state for discovery and no client id.
+		 * is no client id.
 		 */
 		family = l_hashmap_lookup(device->family_list,
-						L_UINT_TO_PTR(type_val));
+						L_UINT_TO_PTR(type));
 		if (!family) {
 			const struct qmi_service_info *info;
 
@@ -2644,7 +2651,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 
 			family = service_family_create(device, info, 0);
 			l_hashmap_insert(device->family_list,
-					L_UINT_TO_PTR(type_val), family);
+						L_UINT_TO_PTR(type), family);
 		}
 
 		data = l_new(struct service_create_shared_data, 1);
@@ -2665,27 +2672,25 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		return true;
 	}
 
-	shared = l_hashmap_lookup(device->family_list,
-					L_UINT_TO_PTR(type_val | 0x80000000));
+	pending = l_hashmap_lookup(device->pending_family_creations,
+						L_UINT_TO_PTR(type));
 
-	if (!shared) {
+	if (!pending) {
 		/*
 		 * There is no way to find in an l_hashmap using a custom
 		 * function. Instead we use a temporary struct to store the
-		 * found service. This is not very clean, but we expect this
-		 * code to be refactored soon.
+		 * found service family.
 		 */
 		struct service_find_by_type_data data;
 
-		data.type = type_val;
+		data.type = type;
 		data.found_family = NULL;
 		l_hashmap_foreach(device->family_list,	__family_find_by_type,
 					&data);
 		family = data.found_family;
-	} else
-		type_val |= 0x80000000;
+	}
 
-	if (shared || family) {
+	if (pending || family) {
 		struct service_create_shared_data *data;
 
 		data = l_new(struct service_create_shared_data, 1);
@@ -2696,12 +2701,12 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		data->user_data = user_data;
 		data->destroy = destroy;
 
-		if (!(type_val & 0x80000000)) {
+		if (family) {
 			data->family = service_family_ref(family);
 			data->idle = l_idle_create(service_create_shared_reply,
 							data, NULL);
 		} else
-			l_queue_push_head(shared, data);
+			l_queue_push_head(pending, data);
 
 		__qmi_device_discovery_started(device, &data->super);
 
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
