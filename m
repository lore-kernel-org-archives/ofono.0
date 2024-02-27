Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CED4EB42
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056664; cv=none; b=gkrjtLJh261kl8SklhjZk8DXvG0oyXMRi6jPjOAxy0qU+M5hSr7n9kJR6zH+GXIS7TXHH5TwYSVNSt+JobwfETN8QQsLARcjSlPptxrIRyTAyTA2X67C/MWWmbgBBLPYO3Lxh8LmEC6saIPxyt9t7BmkcwTgrRaoCu9qWyYWdEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056664; c=relaxed/simple;
	bh=KRXNKvQPuJpxowqIJo3w7uNSS3VoP/B7s59GrUjDDNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgmmPtj1tAcS7R3o9PRNbubs4jOFdAnaml6P1IORZgi/RT7g+YsUMQee8nSSAaqTAzrmXqIjcaRyGUEmmgMIMQN/o8Qq5tP6GNRAmosbMToFCzl+6AeI/l8jkWgiZSBMYaYbWQKlJQ9WtEm4Bzc0YEMjadE4UxRXsnCWh5Tlv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNoHOCqL; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNoHOCqL"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c1a1e1e539so2643767b6e.1
        for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 09:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709056661; x=1709661461; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5iOBoZhbK8NkMAOp8Dcx9xJcsaDu/fiew3tC6Xi7gQA=;
        b=fNoHOCqLQXeKC303nm5bw+AHLZFtQjFBKKJU+rdQ+LTL3togJT8lHzOAomdCQc8wwK
         cAGNA8sH+9LgpHoEHxU9anBnZYuWZ+fynLXvwHS8gaHLFJ5cWpi5Z9LyknT6d0UmKcUU
         UV65Km9bdORbMkDfTzKKRZ2EYCpVLfI9+9NqytgiHUm8zM4BtM0vEPxK4MnSIQDYHxhl
         n+wvkZaAYZ9Jlb9Z1pPASwlYivSw/sOqu6obwnJ+ij8xoJgVBO1FRwikaE3Dsx2ozYW/
         pzit/KDtmC9BSckREwffj3o/GO0J3rYoFGRyHoU9iFreMYgxRZDC1OICupWIM6fVeijF
         KbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056661; x=1709661461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iOBoZhbK8NkMAOp8Dcx9xJcsaDu/fiew3tC6Xi7gQA=;
        b=Gjj6ztAhWrvdyX+sW4awu+f97pbmECCQg01l5EQKmjWNNP5IO8vVEc/oga2+bSz4Vc
         ufAbSE3Vnwf+jaRB1SthfcUQXe4uYgBhKkOSCaRIjLjhr9HQscI+3ed6JeiaRr12Mzhe
         TFpduZh7kvO8Ald7gTcESjt212k6Oos32mRwvt+9nruggChnGns6rPa48TLll2zDqMbn
         WcI3dlZAA8Chi5zwqCHharjXrMTb+ul6k2Jncgst+27Vp5GDvBWR2gfzHVAXeSCVDAIQ
         lR/IANUxMZnzIG8qR2qpoS3ywNtbojJ/lmcwX5IneDHr+WMI2KasjGEacseCIicUab9p
         CfYw==
X-Gm-Message-State: AOJu0YwL2jS4zcxzAIHPnkJlQd3X/wFQU+Shc0iqylgaJ0POOx3fizN/
	tVBqrt04DcrRquvK1H76S6WGirt3Pzliemh9c9h512v80MwmIcei6Smv/O2j
X-Google-Smtp-Source: AGHT+IEqvEFnwLdlBMSrnmUD2LFt6qAp5WHzq5+YHb/koVuhV3vB0nig5ubtR2EDqUn6SOPKNKfpNw==
X-Received: by 2002:a05:6808:1201:b0:3c1:5f09:b16f with SMTP id a1-20020a056808120100b003c15f09b16fmr3310963oil.26.1709056661604;
        Tue, 27 Feb 2024 09:57:41 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 1-20020aca1101000000b003c18ad40e35sm1259407oir.16.2024.02.27.09.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:57:41 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] qmi: Support dynamic service information
Date: Tue, 27 Feb 2024 11:57:29 -0600
Message-ID: <20240227175739.1471333-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On QMUX, service information is static.  It is obtained via a CTL
request and remains static for the duration of the connection.  With
QRTR, services can appear and disappear dynamically.  Support this by
converting the existing version_list / version_count member into a
queue.  struct qmi_version is now replaced by struct qmi_service_info
with additional qrtr specific attributes.
---
 drivers/qmimodem/qmi.c | 118 +++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 52 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 35751d7ce267..e58e46b5a6df 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -48,6 +48,15 @@ struct discovery {
 	qmi_destroy_func_t destroy;
 };
 
+struct qmi_service_info {
+	uint32_t service_type;
+	uint32_t qrtr_port;		/* Always 0 on qmux */
+	uint32_t qrtr_node;		/* Always 0 on qmux */
+	uint16_t major;
+	uint16_t minor;			/* Always 0 on qrtr */
+	uint32_t instance;		/* Always 0 on qmux */
+};
+
 struct qmi_request {
 	uint16_t tid;
 	uint8_t client;
@@ -57,13 +66,6 @@ struct qmi_request {
 	uint8_t data[];
 };
 
-struct qmi_version {
-	uint8_t type;
-	uint16_t major;
-	uint16_t minor;
-	const char *name;
-};
-
 struct qmi_device_ops {
 	int (*write)(struct qmi_device *device, struct qmi_request *req);
 	int (*discover)(struct qmi_device *device,
@@ -89,8 +91,7 @@ struct qmi_device {
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
 	void *debug_data;
-	struct qmi_version *version_list;
-	uint8_t version_count;
+	struct l_queue *service_infos;
 	struct l_hashmap *service_list;
 	const struct qmi_device_ops *ops;
 	bool writer_active : 1;
@@ -184,6 +185,33 @@ void qmi_free(void *ptr)
 	l_free(ptr);
 }
 
+static bool qmi_service_info_matches(const void *data, const void *user)
+{
+	const struct qmi_service_info *info = data;
+	const struct qmi_service_info *match = user;
+
+	if (info->service_type != match->service_type)
+		return false;
+
+	if (info->qrtr_node != match->qrtr_node)
+		return false;
+
+	if (info->qrtr_port != match->qrtr_port)
+		return false;
+
+	return true;
+}
+
+static void __qmi_service_appeared(struct qmi_device *device,
+					const struct qmi_service_info *info)
+{
+	if (l_queue_find(device->service_infos, qmi_service_info_matches, info))
+		return;
+
+	l_queue_push_tail(device->service_infos,
+				l_memdup(info, sizeof(struct qmi_service_info)));
+}
+
 static struct qmi_request *__request_alloc(uint8_t service,
 				uint8_t client, uint16_t message,
 				const void *data,
@@ -822,7 +850,7 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 	device->req_queue = l_queue_new();
 	device->service_queue = l_queue_new();
 	device->discovery_queue = l_queue_new();
-
+	device->service_infos = l_queue_new();
 	device->service_list = l_hashmap_new();
 
 	device->next_service_tid = 256;
@@ -853,7 +881,7 @@ void qmi_device_free(struct qmi_device *device)
 
 	l_hashmap_destroy(device->service_list, service_destroy);
 
-	l_free(device->version_list);
+	l_queue_destroy(device->service_infos, (l_queue_destroy_func_t) l_free);
 
 	if (device->shutting_down)
 		device->destroyed = true;
@@ -914,17 +942,18 @@ static const void *tlv_get(const void *data, uint16_t size,
 bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
 					uint16_t *major, uint16_t *minor)
 {
-	struct qmi_version *info;
-	int i;
+	const struct l_queue_entry *entry;
 
-	for (i = 0, info = device->version_list;
-			i < device->version_count;
-			i++, info++) {
-		if (info->type == type) {
-			*major = info->major;
-			*minor = info->minor;
-			return true;
-		}
+	for (entry = l_queue_get_entries(device->service_infos);
+						entry; entry = entry->next) {
+		const struct qmi_service_info *info = entry->data;
+
+		if (info->service_type != type)
+			continue;
+
+		*major = info->major;
+		*minor = info->minor;
+		return true;
 	}
 
 	return false;
@@ -932,13 +961,13 @@ bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
 
 bool qmi_device_has_service(struct qmi_device *device, uint16_t type)
 {
-	struct qmi_version *info;
-	int i;
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(device->service_infos);
+						entry; entry = entry->next) {
+		const struct qmi_service_info *info = entry->data;
 
-	for (i = 0, info = device->version_list;
-			i < device->version_count;
-			i++, info++) {
-		if (info->type == type)
+		if (info->service_type == type)
 			return true;
 	}
 
@@ -1440,13 +1469,8 @@ static void qmux_discover_callback(uint16_t message, uint16_t length,
 	const struct qmi_service_list *service_list;
 	const void *ptr;
 	uint16_t len;
-	struct qmi_version *list;
-	uint8_t count;
 	unsigned int i;
 
-	count = 0;
-	list = NULL;
-
 	result_code = tlv_get(buffer, length, 0x02, &len);
 	if (!result_code)
 		goto done;
@@ -1461,8 +1485,6 @@ static void qmux_discover_callback(uint16_t message, uint16_t length,
 	if (len < QMI_SERVICE_LIST_SIZE)
 		goto done;
 
-	list = l_malloc(sizeof(struct qmi_version) * service_list->count);
-
 	for (i = 0; i < service_list->count; i++) {
 		uint16_t major =
 			L_LE16_TO_CPU(service_list->services[i].major);
@@ -1470,6 +1492,7 @@ static void qmux_discover_callback(uint16_t message, uint16_t length,
 			L_LE16_TO_CPU(service_list->services[i].minor);
 		uint8_t type = service_list->services[i].type;
 		const char *name = __service_type_to_string(type);
+		struct qmi_service_info info;
 
 		if (name)
 			__debug_device(device, "found service [%s %d.%d]",
@@ -1484,12 +1507,12 @@ static void qmux_discover_callback(uint16_t message, uint16_t length,
 			continue;
 		}
 
-		list[count].type = type;
-		list[count].major = major;
-		list[count].minor = minor;
-		list[count].name = name;
+		memset(&info, 0, sizeof(info));
+		info.service_type = type;
+		info.major = major;
+		info.minor = minor;
 
-		count++;
+		__qmi_service_appeared(device, &info);
 	}
 
 	ptr = tlv_get(buffer, length, 0x10, &len);
@@ -1500,9 +1523,6 @@ static void qmux_discover_callback(uint16_t message, uint16_t length,
 	__debug_device(device, "version string: %s", qmux->version_str);
 
 done:
-	device->version_list = list;
-	device->version_count = count;
-
 	/* if the device support the QMI call SYNC over the CTL interface */
 	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
 			qmux->control_major > 1) {
@@ -1552,7 +1572,7 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 
 	__debug_device(device, "device %p discover", device);
 
-	if (device->version_list)
+	if (l_queue_length(device->service_infos) > 0)
 		return -EALREADY;
 
 	data = l_new(struct discover_data, 1);
@@ -1702,9 +1722,8 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	struct qmux_client_create_data *data;
 	struct l_queue *shared;
 	unsigned int type_val = service_type;
-	int i;
 
-	if (!device->version_list)
+	if (!l_queue_length(device->service_infos))
 		return -ENOENT;
 
 	shared = l_queue_new();
@@ -1719,13 +1738,8 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 
 	__debug_device(device, "service create [type=%d]", service_type);
 
-	for (i = 0; i < device->version_count; i++) {
-		if (device->version_list[i].type == data->type) {
-			data->major = device->version_list[i].major;
-			data->minor = device->version_list[i].minor;
-			break;
-		}
-	}
+	qmi_device_get_service_version(device, data->type,
+						&data->major, &data->minor);
 
 	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_CLIENT_ID,
-- 
2.43.0

