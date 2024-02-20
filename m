Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D84F40BFD
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472837; cv=none; b=iSkWLqMvSmmenrY4ZGg1EOXFmDA/Gh/i6ZgK2FwJZmtAw4JoII9z1wdmcOfmb5s3AidIXhBCvzMEFOf/pg4gFm+75XCeGrxX6nWzMk3HsM0TQxtBLChCTEHVofdI08qHdDZtuZLTjVMFAefn2bvA0g5hG5IXOpIopwbnwKqO7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472837; c=relaxed/simple;
	bh=WYYlEIW1yZxdbzawq8MJU0+gEMLPvQqiadXOnzb4KYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4iRUF0ZzsEopN9QNx/ceI1PpFuhjX3qZEXN/QV1XJATxRaORIG5VwmOHlDhWL48G7QWRcdLGayyTLfbsmHa3eQi/C3fYmkNbDCs4qt6r9gjeXOL0GDihG5XVo+/dX+hrfnRgLcFyT2Hx2DqmdNhDnpBanalKXOb8OSkYuz9Fwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=IS+HFdsh; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=FKc8QEMR; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="IS+HFdsh";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="FKc8QEMR"
Received: from pps.filterd (m0286621.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KMkoQg021656
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:26:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=3+MVDzdQGcTG8ZVcZlnHFI
	DI4xMMVPhSvdDkNAusK/M=; b=IS+HFdshpiUFjqz6oQOU68b8btS9DTfbRNqrDt
	FCi02O1Ve1xzZrGFhXU467eyixozIPvfJ3Whimxj7FIKU9sbzsU6vq+W7YapqM6l
	D8m/fFwAdgB9xANDJGk0zgQf2dWX80S5CMjkbJ61q6TaFzleSFRetySenvmEAQoa
	TPYJU/5id2g/c8lfXhvgJcniJ6Pn2FV0XtWid0OAeD6Snsz0GKXDvNzB8G6l/wD1
	/hj4P7I9X6gPULcIhu3RU2uKd+SwckuVipTcnWSmkUMfR6FQJMYcOcCoZZooro5h
	l48aVaU6AbpmieJu9PB1s+PV2ww55NgaK1Yl2of+LkXOUuuA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd563g1fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:26:55 -0800 (PST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68fa064556eso4482706d6.3
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708471614; x=1709076414; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+MVDzdQGcTG8ZVcZlnHFIDI4xMMVPhSvdDkNAusK/M=;
        b=FKc8QEMRG/5lh6q33DUdSer3ReWTXYq2XtzbMVjpvLoOzni4/8bCEQMxb24CA/IGJ1
         QYZ7VvW9QDLkEb0fK2Ip/mvfFRUBs9q3A8XnCiTU4ADXc6bi2sagrZmoZn+5Pvaj+Hot
         EtNnBYW9zi15nhL7Zkab6RU3KvfS7t3BEiFlQTtyPEbK4VZ8miD6jwS5huXXlPqaM7Zi
         eroV5XM3O02LYIZ0jAhmg7gsNVdalgpyeW/A9pXX4i+5GeOrW4lEbF39lE5HkITX/sjo
         HPm80x67FFxJmX6jnlE5ruOuwj69FsPYCeP0Fj7UoImZ7/9PLGEPYs0d9ODcnVSOng0L
         hEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471614; x=1709076414;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+MVDzdQGcTG8ZVcZlnHFIDI4xMMVPhSvdDkNAusK/M=;
        b=D0RJ07UerYQHmg9DRBQ4wjk3SDslAPpEBq6OxPT+1AnaGhapSPWS9s43g2OWvucU7+
         yHMJwiRa8q7isPOL9npneToOPRq4tWHjwOb4u1LDxBk2HmkveAZsWUQ6Losal/+lZJ7q
         ArXpr3SjzgFJ621RykQ1bXEWKxHe+cRl2/KChtVAT2p51AbHvyTxR/CeFSj3mGqmuqCV
         p0eR2WK1Szl1YQPH394gQ/xzSU5PmkX/vtv27UzAbTpdyw0yool8QUPuQzcfXXu5z3RQ
         yakMkLCRYY/sKo/ZgfKUBwL52FLPwJ0utf3jKKziVOZ3hW93aoGYPCQFNKluF9GkyWz0
         /qHQ==
X-Gm-Message-State: AOJu0Yx2TjCXNmLE2FzXqGSRB4RqHJcxhTo517ZH2eppCYUkZT5toEgc
	6Fg0C1LR5iymgpr14ECh+Y7dItiy2SbP+FrW4W0eFXMuVXlcpjEUcFKz+9C9oqQ8W4qlMt//Dzp
	rsKp6WhTTLRXuXrlHO0crebjoxR9vsYTPDq5Qz3I9hZrogbAweghCBiJLt/RxWQ6c3/8D44JLQm
	mN/opdiAeZ1P65J7FPwfftjhq8qG8Jw5+xEe5gA7faPfGmgqU=
X-Received: by 2002:a0c:9792:0:b0:68f:5091:872f with SMTP id l18-20020a0c9792000000b0068f5091872fmr10267174qvd.53.1708471613740;
        Tue, 20 Feb 2024 15:26:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgzVPGRyvRIduVzLqJu/r5rKlL4EUJ06hUHbJUdAYotAkQ1j4hdpAKzRk9UZm5NHSYfJEUwg==
X-Received: by 2002:a0c:9792:0:b0:68f:5091:872f with SMTP id l18-20020a0c9792000000b0068f5091872fmr10267158qvd.53.1708471613335;
        Tue, 20 Feb 2024 15:26:53 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id mb10-20020a056214550a00b0068f85706ecfsm1931983qvb.104.2024.02.20.15.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 15:26:53 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 3/4] qmimodem: Use l_queue instead of GQueue
Date: Tue, 20 Feb 2024 23:25:28 +0000
Message-Id: <20240220232529.128477-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240220232529.128477-1-steve.schrock@getcruise.com>
References: <20240220232529.128477-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: PdX7ZNEXHF_tBEEIul7OzGT42_txzuVl
X-Proofpoint-GUID: PdX7ZNEXHF_tBEEIul7OzGT42_txzuVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402200167

Now a find that is immediately followed by a removal will perform two
lookups instead of of one. The queues will be small so this should
not make a noticeable difference.
---
 drivers/qmimodem/qmi.c | 184 ++++++++++++++++-------------------------
 1 file changed, 73 insertions(+), 111 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index b8f019cc..95c9ef75 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -62,10 +62,10 @@ struct qmi_device {
 	bool close_on_unref;
 	guint read_watch;
 	guint write_watch;
-	GQueue *req_queue;
-	GQueue *control_queue;
-	GQueue *service_queue;
-	GQueue *discovery_queue;
+	struct l_queue *req_queue;
+	struct l_queue *control_queue;
+	struct l_queue *service_queue;
+	struct l_queue *discovery_queue;
 	uint8_t next_control_tid;
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
@@ -213,7 +213,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	return req;
 }
 
-static void __request_free(gpointer data, gpointer user_data)
+static void __request_free(void *data)
 {
 	struct qmi_request *req = data;
 
@@ -221,15 +221,15 @@ static void __request_free(gpointer data, gpointer user_data)
 	l_free(req);
 }
 
-static gint __request_compare(gconstpointer a, gconstpointer b)
+static bool __request_compare(const void *a, const void *b)
 {
 	const struct qmi_request *req = a;
 	uint16_t tid = GPOINTER_TO_UINT(b);
 
-	return req->tid - tid;
+	return req->tid == tid;
 }
 
-static void __discovery_free(gpointer data, gpointer user_data)
+static void __discovery_free(void *data)
 {
 	struct discovery *d = data;
 	qmi_destroy_func_t destroy = d->destroy;
@@ -614,7 +614,7 @@ static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
 	struct qmi_request *req;
 	ssize_t bytes_written;
 
-	req = g_queue_pop_head(device->req_queue);
+	req = l_queue_pop_head(device->req_queue);
 	if (!req)
 		return FALSE;
 
@@ -631,14 +631,14 @@ static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
 	hdr = req->buf;
 
 	if (hdr->service == QMI_SERVICE_CONTROL)
-		g_queue_push_tail(device->control_queue, req);
+		l_queue_push_tail(device->control_queue, req);
 	else
-		g_queue_push_tail(device->service_queue, req);
+		l_queue_push_tail(device->service_queue, req);
 
 	l_free(req->buf);
 	req->buf = NULL;
 
-	if (g_queue_get_length(device->req_queue) > 0)
+	if (l_queue_length(device->req_queue) > 0)
 		return TRUE;
 
 	return FALSE;
@@ -688,7 +688,7 @@ static uint16_t __request_submit(struct qmi_device *device,
 		req->tid = hdr->transaction;
 	}
 
-	g_queue_push_tail(device->req_queue, req);
+	l_queue_push_tail(device->req_queue, req);
 
 	wakeup_writer(device);
 
@@ -758,7 +758,6 @@ static void handle_packet(struct qmi_device *device,
 		const struct qmi_control_hdr *control = buf;
 		const struct qmi_message_hdr *msg;
 		unsigned int tid;
-		GList *list;
 
 		/* Ignore control messages with client identifier */
 		if (hdr->client != 0x00)
@@ -779,19 +778,16 @@ static void handle_packet(struct qmi_device *device,
 			return;
 		}
 
-		list = g_queue_find_custom(device->control_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
-		if (!list)
+		req = l_queue_find(device->control_queue, __request_compare,
+					GUINT_TO_POINTER(tid));
+		if (!req)
 			return;
 
-		req = list->data;
-
-		g_queue_delete_link(device->control_queue, list);
+		l_queue_remove(device->control_queue, req);
 	} else {
 		const struct qmi_service_hdr *service = buf;
 		const struct qmi_message_hdr *msg;
 		unsigned int tid;
-		GList *list;
 
 		msg = buf + QMI_SERVICE_HDR_SIZE;
 
@@ -808,20 +804,18 @@ static void handle_packet(struct qmi_device *device,
 			return;
 		}
 
-		list = g_queue_find_custom(device->service_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
-		if (!list)
+		req = l_queue_find(device->service_queue, __request_compare,
+					GUINT_TO_POINTER(tid));
+		if (!req)
 			return;
 
-		req = list->data;
-
-		g_queue_delete_link(device->service_queue, list);
+		l_queue_remove(device->service_queue, req);
 	}
 
 	if (req->callback)
 		req->callback(message, length, data, req->user_data);
 
-	__request_free(req, NULL);
+	__request_free(req);
 }
 
 static gboolean received_data(GIOChannel *channel, GIOCondition cond,
@@ -885,16 +879,16 @@ static void read_watch_destroy(gpointer user_data)
 static void __qmi_device_discovery_started(struct qmi_device *device,
 						struct discovery *d)
 {
-	g_queue_push_tail(device->discovery_queue, d);
+	l_queue_push_tail(device->discovery_queue, d);
 }
 
 static void __qmi_device_discovery_complete(struct qmi_device *device,
 						struct discovery *d)
 {
-	if (g_queue_remove(device->discovery_queue, d) != TRUE)
+	if (l_queue_remove(device->discovery_queue, d) != TRUE)
 		return;
 
-	__discovery_free(d, NULL);
+	__discovery_free(d);
 }
 
 static void service_destroy(gpointer data)
@@ -945,10 +939,10 @@ struct qmi_device *qmi_device_new(int fd)
 
 	g_io_channel_unref(device->io);
 
-	device->req_queue = g_queue_new();
-	device->control_queue = g_queue_new();
-	device->service_queue = g_queue_new();
-	device->discovery_queue = g_queue_new();
+	device->req_queue = l_queue_new();
+	device->control_queue = l_queue_new();
+	device->service_queue = l_queue_new();
+	device->discovery_queue = l_queue_new();
 
 	device->service_list = g_hash_table_new_full(g_direct_hash,
 					g_direct_equal, NULL, service_destroy);
@@ -979,17 +973,10 @@ void qmi_device_unref(struct qmi_device *device)
 
 	__debug_device(device, "device %p free", device);
 
-	g_queue_foreach(device->control_queue, __request_free, NULL);
-	g_queue_free(device->control_queue);
-
-	g_queue_foreach(device->service_queue, __request_free, NULL);
-	g_queue_free(device->service_queue);
-
-	g_queue_foreach(device->req_queue, __request_free, NULL);
-	g_queue_free(device->req_queue);
-
-	g_queue_foreach(device->discovery_queue, __discovery_free, NULL);
-	g_queue_free(device->discovery_queue);
+	l_queue_destroy(device->control_queue, __request_free);
+	l_queue_destroy(device->service_queue, __request_free);
+	l_queue_destroy(device->req_queue, __request_free);
+	l_queue_destroy(device->discovery_queue, __discovery_free);
 
 	if (device->write_watch > 0)
 		g_source_remove(device->write_watch);
@@ -1212,26 +1199,22 @@ done:
 static struct qmi_request *find_control_request(struct qmi_device *device,
 						uint16_t tid)
 {
-	GList *list;
 	struct qmi_request *req = NULL;
 	unsigned int _tid = tid;
 
 	if (_tid != 0) {
-		list = g_queue_find_custom(device->req_queue,
-				GUINT_TO_POINTER(_tid), __request_compare);
-
-		if (list) {
-			req = list->data;
-			g_queue_delete_link(device->req_queue, list);
-		} else {
-			list = g_queue_find_custom(device->control_queue,
-				GUINT_TO_POINTER(_tid), __request_compare);
-
-			if (list) {
-				req = list->data;
-				g_queue_delete_link(device->control_queue,
-							list);
-			}
+		req = l_queue_find(device->req_queue, __request_compare,
+					GUINT_TO_POINTER(_tid));
+
+		if (req)
+			l_queue_remove(device->req_queue, req);
+		else {
+			req = l_queue_find(device->control_queue,
+						__request_compare,
+						GUINT_TO_POINTER(_tid));
+
+			if (req)
+				l_queue_remove(device->control_queue, req);
 		}
 	}
 
@@ -1255,7 +1238,7 @@ static gboolean discover_reply(gpointer user_data)
 	__qmi_device_discovery_complete(device, &data->super);
 
 	if (req)
-		__request_free(req, NULL);
+		__request_free(req);
 
 	return FALSE;
 }
@@ -1983,7 +1966,7 @@ static gboolean service_create_reply(gpointer user_data)
 	__qmi_device_discovery_complete(device, &data->super);
 
 	if (req)
-		__request_free(req, NULL);
+		__request_free(req);
 
 	return FALSE;
 }
@@ -2309,9 +2292,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	if (!device)
 		return 0;
 
-	data = g_try_new0(struct service_send_data, 1);
-	if (!data)
-		return 0;
+	data = l_new(struct service_send_data, 1);
 
 	data->func = func;
 	data->user_data = user_data;
@@ -2335,7 +2316,6 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 	unsigned int tid = id;
 	struct qmi_device *device;
 	struct qmi_request *req;
-	GList *list;
 
 	if (!service || !tid)
 		return false;
@@ -2347,59 +2327,44 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 	if (!device)
 		return false;
 
-	list = g_queue_find_custom(device->req_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
-	if (list) {
-		req = list->data;
-
-		g_queue_delete_link(device->req_queue, list);
-	} else {
-		list = g_queue_find_custom(device->service_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
-		if (!list)
+	req = l_queue_find(device->req_queue, __request_compare,
+				GUINT_TO_POINTER(tid));
+	if (req)
+		l_queue_remove(device->req_queue, req);
+	else {
+		req = l_queue_find(device->service_queue, __request_compare,
+					GUINT_TO_POINTER(tid));
+		if (!req)
 			return false;
 
-		req = list->data;
-
-		g_queue_delete_link(device->service_queue, list);
+		l_queue_remove(device->service_queue, req);
 	}
 
 	service_send_free(req->user_data);
 
-	__request_free(req, NULL);
+	__request_free(req);
 
 	return true;
 }
 
-static GQueue *remove_client(GQueue *queue, uint8_t client)
+static bool remove_req_if_match(void* data, void* user_data)
 {
-	GQueue *new_queue;
-	GList *list;
-
-	new_queue = g_queue_new();
-
-	while (1) {
-		struct qmi_request *req;
-
-		list = g_queue_pop_head_link(queue);
-		if (!list)
-			break;
-
-		req = list->data;
-
-		if (!req->client || req->client != client) {
-			g_queue_push_tail_link(new_queue, list);
-			continue;
-		}
+	struct qmi_request *req = data;
+	uint8_t client = GPOINTER_TO_UINT(user_data);
 
-		service_send_free(req->user_data);
+	if (!req->client || req->client != client)
+		return false;
 
-		__request_free(req, NULL);
-	}
+	service_send_free(req->user_data);
+	__request_free(req);
 
-	g_queue_free(queue);
+	return true;
+}
 
-	return new_queue;
+static void remove_client(struct l_queue *queue, uint8_t client)
+{
+	l_queue_foreach_remove(queue, remove_req_if_match,
+				GUINT_TO_POINTER(client));
 }
 
 bool qmi_service_cancel_all(struct qmi_service *service)
@@ -2416,11 +2381,8 @@ bool qmi_service_cancel_all(struct qmi_service *service)
 	if (!device)
 		return false;
 
-	device->req_queue = remove_client(device->req_queue,
-						service->client_id);
-
-	device->service_queue = remove_client(device->service_queue,
-							service->client_id);
+	remove_client(device->req_queue, service->client_id);
+	remove_client(device->service_queue, service->client_id);
 
 	return true;
 }
-- 
2.40.1


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
