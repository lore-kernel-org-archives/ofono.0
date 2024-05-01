Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B781649DD
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596518; cv=none; b=levDj8B02B4G2flVN7rdggm3hu+XM4dYlrYJumUZDGavIGybrb7p+TQWXfafTppzxbFy1PA0vy6S0LSt+e5HEltyh76bdqqxI4NjY4oSI4nTuTpEXLPbA4Z2IFNMSJdwvOUaG8c1Hl2HE5XOD5qtLGYz+SeL+0gt5cB4y3hSdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596518; c=relaxed/simple;
	bh=FTQRmuV2nTCYCaMpezclmeDgiGmatjaiuHS2Ctq8F/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyektg83sIyB/xiEhM06vrpftDXP9JU8sEQDY5nV/oEK+qFSZmNq5SfU8x+HjjANiJlF/U1iEPKAcOXgfQPDhrF5WTrDhMgIZI07IJtEHrQIl5nyeJw6YCtFDnrAFOA35kpe7MuCp6PSHVvIrZgH4hzBrRBTFekasoHeyNS9E1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=CqrWdSlz; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=RwBuMJF3; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="CqrWdSlz";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="RwBuMJF3"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 441DkApr027781
	for <ofono@lists.linux.dev>; Wed, 1 May 2024 13:46:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=wCVBcUfxDX4yxNuntswCeA
	IeSpiBvvxr7Djl9WaUV/c=; b=CqrWdSlzOaT0G7sfr9dHVXWF23xdAMe4y5bGY3
	y7a5udT3MlbTVhh8syoo+lefelX0vlxq1bHpsrRPi48yay+hnsG7Gu2PcN6xVBNY
	JHOjoNVHxg0p6KEsvkMJEiG62F2G8gQYGzhTMHWzDl7IEZSB4cA7gSn6wWH6GZv1
	I89oyMcg70DZcKZYhM9xu6hTHiXmzt97oSR2ymy1lU/3B7iwqaVMetPGUeIysgT2
	od7/laMPPq3DdY1ymr+FEa6vY8F7WPNu/D+4n03tcOA6HMLtZEIzmvXLhTkTopX9
	X/EsQ4DjEvjTF3wklomaPCPD8XGwlJtN9B+B+bF88M+ALXbA==
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xrxcbuk7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 01 May 2024 13:46:14 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da42f683f7so630890739f.0
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1714596373; x=1715201173; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCVBcUfxDX4yxNuntswCeAIeSpiBvvxr7Djl9WaUV/c=;
        b=RwBuMJF3+XKUjvy/DD8a2HlkyobqpnP4vYppxVpgVXRyn9CmEp2Nefd0+HTCZgb2hH
         Zbgc9PNVqoT3kxB94144T6oCbby3BDgTnYha7zIffB7puWs6ZjnEfmIrF/GKM473iB9S
         3l/UsrSLC7NZaTVL/7l24PTHKUuxTKW/j/oyzRIG6DGIHg7ItiRGubIvtyJCtZYmJ7dZ
         pPJjWraR2Wem5DQy2Rgt1F/VgCS59SASbhfNv5sBW8LH2mqREzlnkmHZ9KcYvM9e95jc
         O8OLxiWe5AUgCJ1H/GHG+A0PDj8YAmPg1XxY37UvAcSHZC3ZCrdPK2odaw+SpINmH5vl
         EGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596373; x=1715201173;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCVBcUfxDX4yxNuntswCeAIeSpiBvvxr7Djl9WaUV/c=;
        b=QTS3u0ZQjSQLVEY583YWMuTd7OK3htGkchIGvGAS+7ICSGFSla3wfO0FXK7scqP66Q
         hVN7a6cJ0lLIoHPOcsKyUydeQCpU6dEDFtqAI5vGuSds0by/oabyrX8UFhtByRl2LQ1N
         ZvPt06eHyo3JzAG5FJ++VXkguOMDnHnBxtiVHbIKk/qam4XuCnh34vqJzUTTOnneGf1e
         FMyj3ZynAEGv6wdG+1TgFysdNjwIqhj8XTA9bCMwmwcnPVE6R9MQxv89DZTuuo5Y0GY4
         rzLafFNyAgQRRE9/CGdgP4uvHF0h/5DWDGaN7Yb5BGvzy+DeF5wM93KDXrwZwMBFn1Sf
         V07Q==
X-Gm-Message-State: AOJu0YzHtYkal7BknW9MnHLOUFIVWVRlZ5YXANI9DBMW8Tmf47U6mojw
	IAbkhu2b6VNsrJbJcIw8E4q51IAb3v5AEEn7ZmYcJf7EwqRtSmHKApBUQ0StthBbLXkiU+ZW7Aj
	pLnniTeWteCfUiRVISwDN7EQ/Fem4EYZ/pR+xcrv/KdFEICKB3ZQ9A1gs+m7Hq+QQ6LvaB45rBw
	dk6tiIARXPxWfrlCqzN47L/xLsbDVRJ7pRzVa+99PzqRBcmto=
X-Received: by 2002:a05:6e02:2167:b0:36a:1132:8c0d with SMTP id s7-20020a056e02216700b0036a11328c0dmr4517480ilv.17.1714596373296;
        Wed, 01 May 2024 13:46:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFddRD9Q243mS10CMmdUlMUl6pG0hiyScLe1PiUYS9auVqFei3Q591tOBTnxr14lpfWuT52Dw==
X-Received: by 2002:a05:6e02:2167:b0:36a:1132:8c0d with SMTP id s7-20020a056e02216700b0036a11328c0dmr4517443ilv.17.1714596372562;
        Wed, 01 May 2024 13:46:12 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-579583.corp.robot.car (109.32.128.34.bc.googleusercontent.com. [34.128.32.109])
        by smtp.gmail.com with ESMTPSA id bs16-20020a056e02241000b0036b246c1927sm263252ilb.53.2024.05.01.13.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:46:12 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/2] qmi: Move the pending queues into qmi_device_qmux
Date: Wed,  1 May 2024 15:45:33 -0500
Message-ID: <20240501204546.27312-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240501204546.27312-1-steve.schrock@getcruise.com>
References: <20240501204546.27312-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: jaNnR3oYeE31VMTSW8vG4IfgZ9oXNIJ5
X-Proofpoint-ORIG-GUID: jaNnR3oYeE31VMTSW8vG4IfgZ9oXNIJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405010147

Only qmux needs to asynchronously create service clients so the list
of pending clients should move there. At the same time flatten the
hashmap of queues of pending clients into a single queue that is
linearly searched--the number of pending clients will be small so
there is no need for any extra hashmap overhead or complexity.
---
 drivers/qmimodem/qmi.c | 262 +++++++++++++++++++++--------------------
 1 file changed, 133 insertions(+), 129 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c3af4a4cd98c..824749e9be77 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -101,7 +101,6 @@ struct qmi_device {
 	qmi_debug_func_t debug_func;
 	void *debug_data;
 	struct l_queue *service_infos;
-	struct l_hashmap *pending_family_creations;	/* holds l_queues */
 	struct l_hashmap *family_list;
 	const struct qmi_device_ops *ops;
 	bool writer_active : 1;
@@ -121,6 +120,7 @@ struct qmi_device_qmux {
 	unsigned int release_users;
 	uint8_t next_control_tid;
 	struct l_queue *control_queue;
+	struct l_queue *pending_families;
 };
 
 struct service_family {
@@ -920,7 +920,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 	device->service_queue = l_queue_new();
 	device->discovery_queue = l_queue_new();
 	device->service_infos = l_queue_new();
-	device->pending_family_creations = l_hashmap_new();
 	device->family_list = l_hashmap_new();
 
 	device->next_service_tid = 256;
@@ -936,15 +935,6 @@ static void __qmi_device_shutdown_finished(struct qmi_device *device)
 		device->ops->destroy(device);
 }
 
-static void free_pending_family_creations_queue(struct l_queue *pending)
-{
-	/*
-	 * The service_create_shared_data objects are owned by the discovery
-	 * queue and do not need to be freed here.
-	 */
-	l_queue_destroy(pending, NULL);
-}
-
 void qmi_device_free(struct qmi_device *device)
 {
 	if (!device)
@@ -959,8 +949,6 @@ void qmi_device_free(struct qmi_device *device)
 	l_io_destroy(device->io);
 
 	l_hashmap_destroy(device->family_list, family_destroy);
-	l_hashmap_destroy(device->pending_family_creations,
-		(l_hashmap_destroy_func_t) free_pending_family_creations_queue);
 
 	l_queue_destroy(device->service_infos, l_free);
 
@@ -1421,6 +1409,9 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 
 static struct service_family *service_family_ref(struct service_family *family)
 {
+	if (!family)
+		return NULL;
+
 	family->ref_count++;
 
 	return family;
@@ -1431,6 +1422,9 @@ static void service_family_unref(struct service_family *family)
 	struct qmi_device *device;
 	unsigned int hash_id;
 
+	if (!family)
+		return;
+
 	if (--family->ref_count)
 		return;
 
@@ -1453,6 +1447,7 @@ done:
 
 struct service_create_shared_data {
 	struct discovery super;
+	uint16_t service_type;
 	struct service_family *family;
 	struct qmi_device *device;
 	qmi_create_func_t func;
@@ -1536,24 +1531,56 @@ static void service_create_shared_reply(struct l_idle *idle, void *user_data)
 	DISCOVERY_DONE(data, service, data->user_data);
 }
 
-static void service_create_shared_pending_reply(struct qmi_device *device,
-						unsigned int type,
-						struct service_family *family)
+static bool pending_family_match(const void *data, const void *user_data)
 {
-	void *key = L_UINT_TO_PTR(type);
-	struct l_queue *pending = l_hashmap_remove(
-					device->pending_family_creations, key);
-	const struct l_queue_entry *entry;
+	const struct service_create_shared_data *shared_data = data;
+	uint16_t service_type = L_PTR_TO_UINT(user_data);
+
+	return shared_data->service_type == service_type;
+}
+
+struct pending_family_reply_if_match_info {
+	uint16_t service_type;
+	struct service_family *family;
+};
 
-	for (entry = l_queue_get_entries(pending); entry; entry = entry->next) {
-		struct service_create_shared_data *shared_data = entry->data;
+static bool pending_family_reply_if_match(void *data, void *user_data)
+{
+	struct service_create_shared_data *shared_data = data;
+	struct pending_family_reply_if_match_info *info = user_data;
 
-		shared_data->family = service_family_ref(family);
+	if (pending_family_match(data, L_UINT_TO_PTR(info->service_type))) {
+		shared_data->family = info->family;
+
+		/*
+		 * Perform the callback later after we have incremented the ref
+		 * count.
+		 */
 		shared_data->idle = l_idle_create(service_create_shared_reply,
 							shared_data, NULL);
+
+		return true;
 	}
 
-	l_queue_destroy(pending, NULL);
+	return false;
+}
+
+static void service_create_shared_pending_reply(struct qmi_device_qmux *qmux,
+						uint16_t service_type,
+						struct service_family *family)
+{
+	struct pending_family_reply_if_match_info info = {
+		.service_type = service_type,
+		.family = family,
+	};
+	unsigned int removed;
+
+	removed = l_queue_foreach_remove(qmux->pending_families,
+						pending_family_reply_if_match,
+						&info);
+
+	if (family)
+		family->ref_count += removed;
 }
 
 static void service_create_shared_data_free(void *user_data)
@@ -1752,8 +1779,6 @@ struct qmux_client_create_data {
 	uint16_t major;
 	uint16_t minor;
 	qmi_create_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
 	struct l_timeout *timeout;
 	uint16_t tid;
 };
@@ -1765,9 +1790,6 @@ static void qmux_client_create_data_free(void *user_data)
 	if (data->timeout)
 		l_timeout_remove(data->timeout);
 
-	if (data->destroy)
-		data->destroy(data->user_data);
-
 	l_free(data);
 }
 
@@ -1781,7 +1803,7 @@ static void qmux_client_create_reply(struct l_timeout *timeout, void *user_data)
 
 	DBG("");
 
-	service_create_shared_pending_reply(device, data->type, NULL);
+	service_create_shared_pending_reply(qmux, data->type, NULL);
 
 	/* remove request from queues */
 	req = find_control_request(qmux, data->tid);
@@ -1789,7 +1811,7 @@ static void qmux_client_create_reply(struct l_timeout *timeout, void *user_data)
 	l_timeout_remove(data->timeout);
 	data->timeout = NULL;
 
-	DISCOVERY_DONE(data, NULL, data->user_data);
+	DISCOVERY_DONE(data, NULL, NULL);
 
 	if (req)
 		__request_free(req);
@@ -1800,9 +1822,10 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 {
 	struct qmux_client_create_data *data = user_data;
 	struct qmi_device *device = data->device;
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
 	struct service_family *family = NULL;
 	struct service_family *old_family = NULL;
-	struct qmi_service *service = NULL;
 	struct qmi_service_info info;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
@@ -1841,12 +1864,10 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	if (old_family)
 		family_destroy(old_family);
 
-	service = service_create(family);
-
 done:
-	service_create_shared_pending_reply(device, data->type, family);
+	service_create_shared_pending_reply(qmux, data->type, family);
 
-	DISCOVERY_DONE(data, service, data->user_data);
+	DISCOVERY_DONE(data, NULL, NULL);
 }
 
 static int qmi_device_qmux_client_create(struct qmi_device *device,
@@ -1858,43 +1879,50 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 		l_container_of(device, struct qmi_device_qmux, super);
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
 	struct qmi_request *req;
-	struct qmux_client_create_data *data;
-	struct l_queue *pending;
+	struct service_create_shared_data *shared_data;
+	struct qmux_client_create_data *create_data;
+	bool create_in_progress;
 
 	if (!l_queue_length(device->service_infos))
 		return -ENOENT;
 
-	data = l_new(struct qmux_client_create_data, 1);
+	create_in_progress = l_queue_find(qmux->pending_families,
+						pending_family_match,
+						L_UINT_TO_PTR(service_type));
 
-	data->super.destroy = qmux_client_create_data_free;
-	data->device = device;
-	data->type = service_type;
-	data->func = func;
-	data->user_data = user_data;
-	data->destroy = destroy;
+	shared_data = l_new(struct service_create_shared_data, 1);
+	shared_data->super.destroy = service_create_shared_data_free;
+	shared_data->service_type = service_type;
+	shared_data->device = device;
+	shared_data->func = func;
+	shared_data->user_data = user_data;
+	shared_data->destroy = destroy;
+	l_queue_push_tail(qmux->pending_families, shared_data);
+
+	if (create_in_progress)
+		return 0;
+
+	create_data = l_new(struct qmux_client_create_data, 1);
+	create_data->super.destroy = qmux_client_create_data_free;
+	create_data->device = device;
+	create_data->type = service_type;
 
 	__debug_device(device, "service create [type=%d]", service_type);
 
-	qmi_device_get_service_version(device, data->type,
-						&data->major, &data->minor);
+	qmi_device_get_service_version(device, create_data->type,
+						&create_data->major,
+						&create_data->minor);
 
 	req = __control_request_alloc(QMI_CTL_GET_CLIENT_ID,
 					client_req, sizeof(client_req),
-					qmux_client_create_callback, data);
+					qmux_client_create_callback,
+					create_data);
 
-	data->tid = __ctl_request_submit(qmux, req);
-	data->timeout = l_timeout_create(8, qmux_client_create_reply,
-								data, NULL);
-
-	__qmi_device_discovery_started(device, &data->super);
+	create_data->tid = __ctl_request_submit(qmux, req);
+	create_data->timeout = l_timeout_create(8, qmux_client_create_reply,
+							create_data, NULL);
 
-	/*
-	 * Only subsequent requests for this same service will be added to
-	 * the queue.
-	 */
-	pending = l_queue_new();
-	l_hashmap_insert(device->pending_family_creations,
-			L_UINT_TO_PTR(service_type), pending);
+	__qmi_device_discovery_started(device, &create_data->super);
 
 	return 0;
 }
@@ -1985,6 +2013,8 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 
+	l_queue_destroy(qmux->pending_families,
+		(l_queue_destroy_func_t) service_create_shared_data_free);
 	l_queue_destroy(qmux->control_queue, __request_free);
 
 	if (qmux->shutdown_idle)
@@ -2022,6 +2052,7 @@ struct qmi_device *qmi_device_new_qmux(const char *device)
 
 	qmux->next_control_tid = 1;
 	qmux->control_queue = l_queue_new();
+	qmux->pending_families = l_queue_new();
 	l_io_set_read_handler(qmux->super.io, received_qmux_data, qmux, NULL);
 
 	return &qmux->super;
@@ -2623,9 +2654,8 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			qmi_create_func_t func, void *user_data,
 			qmi_destroy_func_t destroy)
 {
-	struct l_queue *pending;
-	struct service_family *family = NULL;
-	int r;
+	struct service_create_shared_data *data;
+	struct service_family *family;
 
 	if (!device || !func)
 		return false;
@@ -2633,88 +2663,62 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	if (type == QMI_SERVICE_CONTROL)
 		return false;
 
-	if (!device->ops->client_create) {
-		struct service_create_shared_data *data;
-
-		/*
-		 * The hash id is simply the service type in this case. There
-		 * is no client id.
-		 */
-		family = l_hashmap_lookup(device->family_list,
-						L_UINT_TO_PTR(type));
-		if (!family) {
-			const struct qmi_service_info *info;
-
-			info = __find_service_info_by_type(device, type);
-			if (!info)
-				return false;
-
-			family = service_family_create(device, info, 0);
-			l_hashmap_insert(device->family_list,
-						L_UINT_TO_PTR(type), family);
-		}
-
-		data = l_new(struct service_create_shared_data, 1);
-
-		data->super.destroy = service_create_shared_data_free;
-		data->device = device;
-		data->func = func;
-		data->user_data = user_data;
-		data->destroy = destroy;
-		data->family = service_family_ref(family);
-
-		data->idle = l_idle_create(service_create_shared_reply,
-							data, NULL);
-
-		/* Not really discovery... just tracking the idle callback. */
-		__qmi_device_discovery_started(device, &data->super);
-
-		return true;
-	}
+	/*
+	 * First check to see if the bare type is in the hashmap. If it is not
+	 * the family might exist already, but have the client id included in
+	 * the hash id.
+	 */
+	family = l_hashmap_lookup(device->family_list, L_UINT_TO_PTR(type));
 
-	pending = l_hashmap_lookup(device->pending_family_creations,
-						L_UINT_TO_PTR(type));
+	if (!family) {
+		struct service_find_by_type_data find_data;
 
-	if (!pending) {
 		/*
 		 * There is no way to find in an l_hashmap using a custom
 		 * function. Instead we use a temporary struct to store the
 		 * found service family.
 		 */
-		struct service_find_by_type_data data;
-
-		data.type = type;
-		data.found_family = NULL;
+		find_data.type = type;
+		find_data.found_family = NULL;
 		l_hashmap_foreach(device->family_list,	__family_find_by_type,
-					&data);
-		family = data.found_family;
+						&find_data);
+		family = find_data.found_family;
 	}
 
-	if (pending || family) {
-		struct service_create_shared_data *data;
-
-		data = l_new(struct service_create_shared_data, 1);
+	if (!family) {
+		const struct qmi_service_info *info;
 
-		data->super.destroy = service_create_shared_data_free;
-		data->device = device;
-		data->func = func;
-		data->user_data = user_data;
-		data->destroy = destroy;
+		if (device->ops->client_create) {
+			int r;
 
-		if (family) {
-			data->family = service_family_ref(family);
-			data->idle = l_idle_create(service_create_shared_reply,
-							data, NULL);
-		} else
-			l_queue_push_head(pending, data);
+			r = device->ops->client_create(device, type, func,
+							user_data, destroy);
+			return r == 0;
+		}
 
-		__qmi_device_discovery_started(device, &data->super);
+		info = __find_service_info_by_type(device, type);
+		if (!info)
+			return false;
 
-		return true;
+		family = service_family_create(device, info, 0);
+		l_hashmap_insert(device->family_list, L_UINT_TO_PTR(type),
+							family);
 	}
 
-	r = device->ops->client_create(device, type, func, user_data, destroy);
-	return r == 0;
+	data = l_new(struct service_create_shared_data, 1);
+
+	data->super.destroy = service_create_shared_data_free;
+	data->device = device;
+	data->func = func;
+	data->user_data = user_data;
+	data->destroy = destroy;
+	data->family = service_family_ref(family);
+	data->idle = l_idle_create(service_create_shared_reply, data, NULL);
+
+	/* Not really discovery... just tracking the idle callback. */
+	__qmi_device_discovery_started(device, &data->super);
+
+	return true;
 }
 
 bool qmi_service_create(struct qmi_device *device,
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
