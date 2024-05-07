Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4D16E880
	for <ofono@lists.linux.dev>; Tue,  7 May 2024 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097856; cv=none; b=Evyr6Ah3lK2kPw8jEIRLPpl97IqgpQC5nESF84bWkgmIqyB3lZvInaxhALKASLVgtQ6oedywhCGJqQmB2+eQXUbT/h9+6201aBeHPjlV96j9eQuxE9gkj4SJiTHDEgGi2kVNtdZ7S726C82pB6Wd9yJZxVvOwhrd3LkBTlVA1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097856; c=relaxed/simple;
	bh=sceyytkrWhiPHwGOwTvXDxRXTNuEgas7Id5So2MS5pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mh81ZBvYqCiPEIXy6NMiATdiZTwPLd85eZ6H9NJre53DikGfRb22fBtfuiKPl76gn20KB/e+QogTxplqC3T7IHH5iZRzIXN6X8IZoeFcTBy7yqNhk8t0TOgl9N8k1e4ojR5pAGFSAPslJ3ZZYtnYYcAYC4tCauGpKCm/PoOByWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=HHYHtL+I; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=qW4gdKuk; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="HHYHtL+I";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="qW4gdKuk"
Received: from pps.filterd (m0286616.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447EeWoZ029868
	for <ofono@lists.linux.dev>; Tue, 7 May 2024 09:04:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=XpMMM6eOoL+FPZk9hDh8poH/qzTg0g8+4+uGZC9zGGM=; b=H
	HYHtL+Ipoq/E4+dqGjgyF0Hdo8yOvXxmZqxGEDzAJPVz6RQl67iJGlTrbotgRA3U
	/YuHUQIj3ui5s9PoieoXESSK2+kpLS31PHIUdQtLYT8OELAfiJ9wFvuAuLIGrswL
	jpn9Io53AFRdTGMD0sREKenx1/qxBmfX8x0WCh+51mQF8DndPj6cEwXfCYqfLrub
	JbmadE5vMPeOZr5+MhE9z/FLvzFPxhs6MS0Y+tbPwzngKcOjqmOrOSuu5+6iUkxD
	GXNargQQ3RVqVa4dg/dWYmqeDA8a/7+kCU3OP1n2LP1BhpmkUy2s4bFXuWbC8fcO
	i68WWHtQmdwLHEBKX7+AQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xwjk5j7cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 07 May 2024 09:04:09 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6f050d1a15eso3078165a34.0
        for <ofono@lists.linux.dev>; Tue, 07 May 2024 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1715097848; x=1715702648; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XpMMM6eOoL+FPZk9hDh8poH/qzTg0g8+4+uGZC9zGGM=;
        b=qW4gdKuk3q9I3Q0fjkqS6zuykAsURRRm+altKj2he2lT9Y3qv82DYwfs3hcAaqpIgD
         myAWfFggVtFeKLz8A8DzxhNJzQ5sev9XHdtvtwTHSvY+BfMMc78KZnCQON4n7dC9k1c6
         go8SkzALJ/bMZGQPXuuoJwzI5MEJIahXK82k6FnYzQN2/jsd0blcyACy4wkUPXljBFl1
         rIZIwLeWcYmcVmNGI3j4N1hhRiRItXkLFJxJtrQTQgoUlNpj5Z4nUNh4psR9fBoKXqvc
         qFwW+ejWbV8v/XYz3mXIil21QDZlsLXucABCY4QUONqII2EvtW68yR3E+6Aa4xoqzsqs
         EtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097848; x=1715702648;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpMMM6eOoL+FPZk9hDh8poH/qzTg0g8+4+uGZC9zGGM=;
        b=EDVulpoZNfDcRCK6ti2mKO1DfhlFLDzYg4coo1MTwnQ1FAmFswVbMPnide0LY/iBjP
         SgGq41VJtrEjLK7NVkVx+fgDF+03XuhVQLsc2APzfe6VqT2n4mlc6Qzqrb56jE/CzIzG
         MaBeX/nGqEdhGcwJ1pQ5bEFhxAOsWeRkyQ/ddd0ltcb02vMZ7kXaEtbMeq4aABE7dwHb
         twCnJvY8IFpRIyUkUKIhyl1SrtoQiNOJJDWABhbVAOzpCEXUQn5m5u34ImUCrVEJ2b1S
         d3658rc0lx81T/VpkQ873nib5TJCWYhcyBUx0X1HdHIPM5hIyG01HEe9msGYQbvND87a
         kpGA==
X-Gm-Message-State: AOJu0YxPpKhySGzLRIMT6gJd36smdqq3hfGRd5V3/DuqjsA+YAtDdqVJ
	laNB28iJxYUvbF8ggydxi4uDV+Dwn4VCc4VXSlBhnTTOsLqJMy1ZZugasOKrZG23QOBv36s/lZR
	PzCTy0Ndxo+BmJXaUtpgZkxLki98YhOHXloFCKtM//WmvYKKHWOK5zFeALeQXtJ3cjS4X9TGDhh
	RBSGwxyHuRyH6DGlG/25IwDFtg4pzZ33tHzOUuOI/iCdTVcc0=
X-Received: by 2002:a05:6871:88b:b0:23b:caff:be33 with SMTP id r11-20020a056871088b00b0023bcaffbe33mr17654122oaq.49.1715097847766;
        Tue, 07 May 2024 09:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4fosYPp5WQX8oO+SFOSDgpvQw4MU9bcWuk96sRsN0RhxCHcMbugUpTYA8k8TS+k6/RQIDgw==
X-Received: by 2002:a05:6871:88b:b0:23b:caff:be33 with SMTP id r11-20020a056871088b00b0023bcaffbe33mr17654094oaq.49.1715097847346;
        Tue, 07 May 2024 09:04:07 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-2429.corp.robot.car (135.199.192.35.bc.googleusercontent.com. [35.192.199.135])
        by smtp.gmail.com with ESMTPSA id cl14-20020a0566383d0e00b0048879ef43b7sm1546487jab.64.2024.05.07.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:04:06 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v3 1/2] qmi: Separate the pending family creation queues
Date: Tue,  7 May 2024 11:03:47 -0500
Message-ID: <20240507160353.683868-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: zT_7An1CvcIMw1xVaEpl_E6qg_aYxsMV
X-Proofpoint-GUID: zT_7An1CvcIMw1xVaEpl_E6qg_aYxsMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_09,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405070111

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
