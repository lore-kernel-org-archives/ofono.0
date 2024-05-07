Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7316E877
	for <ofono@lists.linux.dev>; Tue,  7 May 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097853; cv=none; b=PRj78TGMmaMPBoeZ2pnNUNq4/rDbnZms2W07Fn1uUqkcPChA9r0xNP8h12Q1jsJHTMcoAn0HDocORsqZuospjZGo7ZTDNWprHAZ3QNofQNZDZydRdBK38K+SEoHK8vy6nF3HuWiWzR0g56T8WJtB4knWfMs+Ane7l/+KoWyG1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097853; c=relaxed/simple;
	bh=R7MI3il/PXPPpKm0XxlHNqDGqSIx8FQumH6IzTvztWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6dzjIc+g7tPhGSq3E4dtCWUZ/S4ilLBmoKadZqNGmx4bxkcSeFfjhyKmFIe/vlHnCdYdQgeCna5pRb69LwLsen8/iacuflBRm5FgSTbcHh7igZsmzRrstcFl7jm1nwL5q2UgTGnCm0x0kE5a/bQBtG2T6bcgXB4oo6vuKh3AWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=uconYgs5; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=IDfNc6zU; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="uconYgs5";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="IDfNc6zU"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447CFvK2010589
	for <ofono@lists.linux.dev>; Tue, 7 May 2024 09:04:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=qoT4SohktqJ/GEmbioYUIR
	YCPE+hFddaPIlyyj2Qg10=; b=uconYgs5ZTu8ogPDwFcTAYh0abDoKfrEI4uR96
	gx+0hY8hBlNErPr98VxvIUyKYhDkz+z55yxRjMHkNg1JG+z02+onnQscUUt/qz0p
	c9ZhmrdOS/qk+BKcw8Yc1A+rHcNWdgtc0ZovxEju4c82Il0IpdBw3Vn2kb6h3NC0
	mC2c/nDXNFvTG3dq9Wx5mRbl2uTYsCV4wbl0rD5Yx1RhdNSEKjDNJwCafFF2ofyA
	Fez+vofOFMynKDPmI73JF3VETXLctpkR/oDiIgpay538XAP7S0cS2H8kNd2633Jy
	21BQFbLbblbBRaY0BzvoQEg52YzAtl2G8I39ZQxiVr80CsOA==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xwjqt274n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 07 May 2024 09:04:09 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36c7ba4fe7aso35940565ab.3
        for <ofono@lists.linux.dev>; Tue, 07 May 2024 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1715097848; x=1715702648; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qoT4SohktqJ/GEmbioYUIRYCPE+hFddaPIlyyj2Qg10=;
        b=IDfNc6zUW/wVCP5yszwXEMvBxW+IACGW/fCEXNsXB/B2Ay56KVTlfg2rlsVG+Sm5JH
         FY2c8x4ifXogh5+inp7A9mZ3PPO0xjdP9EtFZefREqjDcL1eRj7yixjbWxmPiADmRMZd
         aX8eLfq22ZbWArK6sNUoRS/8b2+lsticaj24go0KdwLEB+1KNmCV1s6lJlViA9R7s4DB
         iH3wCnXxVCtHzhjittwx+6+UznEfaU0RXBJCbEYoo9tWlipzFYFEN2SIyuFoCJ0guwnA
         KpP6/YF69dqoweTibJ0Sq0NKL0JQIXU7eW+4Bu3vonJDfEvclps9CbPmKIIG6PBze5rg
         wRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097848; x=1715702648;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoT4SohktqJ/GEmbioYUIRYCPE+hFddaPIlyyj2Qg10=;
        b=ccAsVHxvIfgkUlFAnQUCgpxvpjUTICnfUUX0wiR6907ZIU0oj5gCx09at8vM2KUoR8
         MfdSsGF+0vCK6I012yxskJmj3y3Tdfbv8RFrEfWHhp7AnIjvVDENF2R9wmsafI7+VAwB
         +rXxnPLn5MI7UDvXaPp/bC7aSvUbbZJpreYuAlWHHyyRCK4KT+C3vf3xb1jKRV9kYcqg
         la5KWg7QK8ycnZdQWQTEkJBrVjSsGJJGWforQzX70gRsgR+Ut3KE+Rv/vOGJ2prIGgxE
         7vBMejm9fAVJgjfVVW4QYHu8O+FzkvETs/KsbL7ZtOSIgg7PdbsKmf6tZKkzzXjMFcmz
         gPOQ==
X-Gm-Message-State: AOJu0Yx/aYsC0yGvayUnrs/iX60Urgz9UMpngYwUiyWOtAFPCyGvJ02a
	bBBBShRk2TVl6pm5Ini6u9oFihIqy/6eMpOnAPPRjD6RWN1E6Pm+IGij726z99vW+hD52SCHG3o
	FjSwDO424lplCkY6TbYxXoKOGd76DB2UO02Cscg46MGwGVbGtjwSq+AlblCeidZdPS4U8r21OXn
	jNYA+3VFJNSDlOZDVsWooSgVfXIiPFlldiV+5QGFl+/q7BZE8=
X-Received: by 2002:a05:6e02:1d1a:b0:36c:4f81:cf21 with SMTP id i26-20020a056e021d1a00b0036c4f81cf21mr17172637ila.2.1715097848450;
        Tue, 07 May 2024 09:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVghy3YPfXvgVqYw0w84DaPYBcEm5TfHxizQ98fhk/qxmxVUiOvFEEzsDpuhFOiS3Pwh166Q==
X-Received: by 2002:a05:6e02:1d1a:b0:36c:4f81:cf21 with SMTP id i26-20020a056e021d1a00b0036c4f81cf21mr17172599ila.2.1715097848035;
        Tue, 07 May 2024 09:04:08 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-2429.corp.robot.car (135.199.192.35.bc.googleusercontent.com. [35.192.199.135])
        by smtp.gmail.com with ESMTPSA id cl14-20020a0566383d0e00b0048879ef43b7sm1546487jab.64.2024.05.07.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:04:07 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v3 2/2] qmi: Move the pending queues into qmi_device_qmux
Date: Tue,  7 May 2024 11:03:48 -0500
Message-ID: <20240507160353.683868-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507160353.683868-1-steve.schrock@getcruise.com>
References: <20240507160353.683868-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: 4MzdcgA9rh0P1deW0Ni-nDJBwSoJAs4g
X-Proofpoint-GUID: 4MzdcgA9rh0P1deW0Ni-nDJBwSoJAs4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_09,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405070111

Only qmux needs to asynchronously create service clients so the list
of pending clients should move there. At the same time flatten the
hashmap of queues of pending clients into a single queue that is
linearly searched--the number of pending clients will be small so
there is no need for any extra hashmap overhead or complexity.
---
 drivers/qmimodem/qmi.c | 269 ++++++++++++++++++++---------------------
 1 file changed, 132 insertions(+), 137 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c3af4a4cd98c..32cee1c45080 100644
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
 
@@ -1453,6 +1441,7 @@ done:
 
 struct service_create_shared_data {
 	struct discovery super;
+	uint16_t service_type;
 	struct service_family *family;
 	struct qmi_device *device;
 	qmi_create_func_t func;
@@ -1524,36 +1513,61 @@ static struct qmi_service *service_create(struct service_family *family)
 	return service;
 }
 
-static void service_create_shared_reply(struct l_idle *idle, void *user_data)
+static void service_create_shared_idle_cb(struct l_idle *idle, void *user_data)
 {
 	struct service_create_shared_data *data = user_data;
-	struct qmi_service *service;
+	struct qmi_service *service = service_create(data->family);
+
+	DISCOVERY_DONE(data, service, data->user_data);
+}
+
+static void service_create_shared_reply(struct service_create_shared_data *data,
+					struct service_family *family)
+{
+	struct qmi_service *service = NULL;
 
-	l_idle_remove(data->idle);
-	data->idle = NULL;
+	if (family)
+		service = service_create(family);
 
-	service = service_create(data->family);
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
 
-	for (entry = l_queue_get_entries(pending); entry; entry = entry->next) {
-		struct service_create_shared_data *shared_data = entry->data;
+struct pending_family_reply_if_match_info {
+	uint16_t service_type;
+	struct service_family *family;
+};
+
+static bool pending_family_reply_if_match(void *data, void *user_data)
+{
+	struct service_create_shared_data *shared_data = data;
+	const struct pending_family_reply_if_match_info *info = user_data;
 
-		shared_data->family = service_family_ref(family);
-		shared_data->idle = l_idle_create(service_create_shared_reply,
-							shared_data, NULL);
+	if (pending_family_match(data, L_UINT_TO_PTR(info->service_type))) {
+		service_create_shared_reply(shared_data, info->family);
+		return true;
 	}
 
-	l_queue_destroy(pending, NULL);
+	return false;
+}
+
+static void service_create_shared_pending_reply(struct qmi_device_qmux *qmux,
+						uint16_t service_type,
+						struct service_family *family)
+{	struct pending_family_reply_if_match_info info = {
+		.service_type = service_type,
+		.family = family,
+	};
+
+	l_queue_foreach_remove(qmux->pending_families,
+					pending_family_reply_if_match, &info);
 }
 
 static void service_create_shared_data_free(void *user_data)
@@ -1563,7 +1577,8 @@ static void service_create_shared_data_free(void *user_data)
 	if (data->idle)
 		l_idle_remove(data->idle);
 
-	service_family_unref(data->family);
+	if (data->family)
+		service_family_unref(data->family);
 
 	if (data->destroy)
 		data->destroy(data->user_data);
@@ -1752,8 +1767,6 @@ struct qmux_client_create_data {
 	uint16_t major;
 	uint16_t minor;
 	qmi_create_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
 	struct l_timeout *timeout;
 	uint16_t tid;
 };
@@ -1765,9 +1778,6 @@ static void qmux_client_create_data_free(void *user_data)
 	if (data->timeout)
 		l_timeout_remove(data->timeout);
 
-	if (data->destroy)
-		data->destroy(data->user_data);
-
 	l_free(data);
 }
 
@@ -1781,7 +1791,7 @@ static void qmux_client_create_reply(struct l_timeout *timeout, void *user_data)
 
 	DBG("");
 
-	service_create_shared_pending_reply(device, data->type, NULL);
+	service_create_shared_pending_reply(qmux, data->type, NULL);
 
 	/* remove request from queues */
 	req = find_control_request(qmux, data->tid);
@@ -1789,7 +1799,7 @@ static void qmux_client_create_reply(struct l_timeout *timeout, void *user_data)
 	l_timeout_remove(data->timeout);
 	data->timeout = NULL;
 
-	DISCOVERY_DONE(data, NULL, data->user_data);
+	DISCOVERY_DONE(data, NULL, NULL);
 
 	if (req)
 		__request_free(req);
@@ -1800,9 +1810,10 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
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
@@ -1841,12 +1852,13 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	if (old_family)
 		family_destroy(old_family);
 
-	service = service_create(family);
-
+	family = service_family_ref(family);
 done:
-	service_create_shared_pending_reply(device, data->type, family);
+	service_create_shared_pending_reply(qmux, data->type, family);
+	if (family)
+		service_family_unref(family);
 
-	DISCOVERY_DONE(data, service, data->user_data);
+	DISCOVERY_DONE(data, NULL, NULL);
 }
 
 static int qmi_device_qmux_client_create(struct qmi_device *device,
@@ -1858,43 +1870,50 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
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
-
-	data->tid = __ctl_request_submit(qmux, req);
-	data->timeout = l_timeout_create(8, qmux_client_create_reply,
-								data, NULL);
+					qmux_client_create_callback,
+					create_data);
 
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
@@ -1985,6 +2004,8 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 
+	l_queue_destroy(qmux->pending_families,
+		(l_queue_destroy_func_t) service_create_shared_data_free);
 	l_queue_destroy(qmux->control_queue, __request_free);
 
 	if (qmux->shutdown_idle)
@@ -2022,6 +2043,7 @@ struct qmi_device *qmi_device_new_qmux(const char *device)
 
 	qmux->next_control_tid = 1;
 	qmux->control_queue = l_queue_new();
+	qmux->pending_families = l_queue_new();
 	l_io_set_read_handler(qmux->super.io, received_qmux_data, qmux, NULL);
 
 	return &qmux->super;
@@ -2623,9 +2645,8 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
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
@@ -2633,88 +2654,62 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
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
+	data->idle = l_idle_create(service_create_shared_idle_cb, data, NULL);
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
