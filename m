Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690861A00F1
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257604; cv=none; b=FHvMDAeEmnsqIiKEgMtrBQMcktlymt59SwSf/eO8+FGD4LTMApuTx1ktPVgv8NXJJkdjgs2/9mklrVsUsycilp/Qv1P5h5LCvBG5zMiV3+9vnxYQcPT5a0q6VJW8xIniVIKZqHS4tje+1qgVu8ZErlQSGc6rBJLFwFa8S1rur+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257604; c=relaxed/simple;
	bh=s+B6px07g1bh3lEsx1QEi3jgWWWeXOWOGN5/fs8wfHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPW0RCMdBxBoSDYE1ntyxEmNL942tVZWKxiJirfDDSVjlIDXUsmj+0nsVfvhVX6hlEJO9ry4TNwdVqPHhuKtu7MU8zUMu6ePegt1CKc2thN99tYzeJ6YQsa1i+TtNnvgcHIyrgee3OHderikoc8L10g+WHi4TyEUv8rd8cwa/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD0nY/fA; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD0nY/fA"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5bacd59e562so2372463eaf.2
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257601; x=1719862401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB/Riy1lXURl9N0ePmpdVZLbRroi1cvFTvSj7Tpk4FM=;
        b=XD0nY/fAXx2FHo97K41CJmbvH6yNafXKBtJMyELeBxVE+Ae1zf+wfvqq2eKtqe4xJ9
         9Jw/6yGbAxOu2htgVSwG2QDQ7LHcSGq+bLkD+3jALJX1t3BqYD8m3RwzgsdqXUV55Vtf
         ESTg+BddA9OoJU93NnwQccdnJwM5iHMGQptbZ+a92OIQcW04ctLZCbSK5E8uOV0Rg2pK
         73witWZbiG/9TJdo+YaZCEPJk5Uq40doO/zuOgHE0PcLQ5bbeXDj7Vzry8cf3H0z8/ql
         sOjVtt3LUED0y2OsZV031L1946RbvCRSKEVQIL5ueIwhu9dZCdhM+I7Qk8J3xB+Du9FH
         fVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257601; x=1719862401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iB/Riy1lXURl9N0ePmpdVZLbRroi1cvFTvSj7Tpk4FM=;
        b=idcqL1mdnDGPd4QtCVuH3uKAjrIJfK7BSS6nGybzFXErLxRlKIPkIrCwxvDPWZHrfE
         Q4ZvwOHrh5O7nldmpQPBMs+pOtTO6u7p/mmaa8VkkGOv5C4SAStRIl150JR8j6q6TEPA
         BvrOrW8dYXOUZQdWITPXCDjahN4z5PxZTZA/lWZuUlpB++Y0TeHQvGVMvJtfVHkkNnav
         r6+wrePDx4+bLbk2KD6Z3cv7gPJ39nRMlmCrEm8c9xNEfso/kfjKRHWxlZZpedh2ndJ0
         vG9kMZj3NjexeJGU9Cw5l99Yn3EcxlBhWKVY83m6Bjs7NRxlyzREXvkqo5Y82SVwXi4F
         U1QQ==
X-Gm-Message-State: AOJu0Yz0OIQf2iLGzzc00NNJls9isEq4u42cPJx/qxCxIz5bZylRvJpW
	JbB1SS64fjojnmzGzgxkUObVuHUeOh+a06JKUrn0DsXc023473/8RSkP8Q==
X-Google-Smtp-Source: AGHT+IFt33BXMpEHdkJC28yZPyUz7K1FU1y0tAj0r20gaZ0bQfXO3IPJxzCVfypzqrhg2Aj5QxZ/Uw==
X-Received: by 2002:a4a:650a:0:b0:5bd:b378:7921 with SMTP id 006d021491bc7-5c1ebb23d96mr6231608eaf.7.1719257601359;
        Mon, 24 Jun 2024 12:33:21 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:21 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/13] qmi: Move service_info management into qrtr/qmux
Date: Mon, 24 Jun 2024 14:32:48 -0500
Message-ID: <20240624193315.1164943-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624193315.1164943-1-denkenz@gmail.com>
References: <20240624193315.1164943-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Break out service_info management from struct qmi_device into qrtr and
qmux classes.  This allows to optimize how service info is managed
slightly:
 - On QMUX, the list is static and obtained during discovery.  An array
   can be used instead of a linked list.  Certain comparisons which are
   only relevant for QRTR can be skipped.
 - QRTR behavior remains the same.
---
 drivers/qmimodem/qmi.c | 103 ++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 43 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2095a952fffd..cf4b6f156a5e 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -90,7 +90,6 @@ struct qmi_device {
 	struct l_queue *req_queue;
 	struct l_queue *service_queue;
 	uint16_t next_service_tid;
-	struct l_queue *service_infos;
 	struct l_hashmap *family_list;
 	const struct qmi_device_ops *ops;
 	bool writer_active : 1;
@@ -98,6 +97,8 @@ struct qmi_device {
 
 struct qmi_qmux_device {
 	struct qmi_device super;
+	struct qmi_service_info *service_list;
+	uint16_t n_services;
 	char *version_str;
 	struct debug_data debug;
 	struct {
@@ -219,16 +220,6 @@ static bool qmi_service_info_matches(const void *data, const void *user)
 	return true;
 }
 
-static void __qmi_service_appeared(struct qmi_device *device,
-					const struct qmi_service_info *info)
-{
-	if (l_queue_find(device->service_infos, qmi_service_info_matches, info))
-		return;
-
-	l_queue_push_tail(device->service_infos,
-				l_memdup(info, sizeof(struct qmi_service_info)));
-}
-
 static void *__request_alloc(uint32_t service_type,
 					uint8_t client, uint16_t message,
 					const void *data, uint16_t length,
@@ -843,7 +834,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 
 	device->req_queue = l_queue_new();
 	device->service_queue = l_queue_new();
-	device->service_infos = l_queue_new();
 	device->family_list = l_hashmap_new();
 
 	device->next_service_tid = 256;
@@ -861,8 +851,6 @@ static void __qmi_device_free(struct qmi_device *device)
 	l_io_destroy(device->io);
 
 	l_hashmap_destroy(device->family_list, family_destroy);
-
-	l_queue_destroy(device->service_infos, l_free);
 }
 
 void qmi_result_print_tlvs(struct qmi_result *result)
@@ -905,23 +893,19 @@ static const void *tlv_get(const void *data, uint16_t size,
 	return NULL;
 }
 
-static const struct qmi_service_info *__find_service_info_by_type(
-				struct qmi_device *device, uint16_t type)
+static const struct qmi_service_info *__qmux_service_info_find(
+				struct qmi_qmux_device *qmux, uint16_t type)
 {
-	const struct qmi_service_info *info = NULL;
-	const struct l_queue_entry *entry;
+	unsigned int i;
 
-	for (entry = l_queue_get_entries(device->service_infos);
-						entry; entry = entry->next) {
-		struct qmi_service_info *data = entry->data;
+	for (i = 0; i < qmux->n_services; i++) {
+		if (qmux->service_list[i].service_type != type)
+			continue;
 
-		if (data->service_type == type) {
-			info = data;
-			break;
-		}
+		return qmux->service_list + i;
 	}
 
-	return info;
+	return NULL;
 }
 
 bool qmi_qmux_device_get_service_version(struct qmi_qmux_device *qmux,
@@ -933,7 +917,7 @@ bool qmi_qmux_device_get_service_version(struct qmi_qmux_device *qmux,
 	if (!qmux)
 		return false;
 
-	info = __find_service_info_by_type(&qmux->super, type);
+	info = __qmux_service_info_find(qmux, type);
 	if (!info)
 		return false;
 
@@ -947,7 +931,7 @@ bool qmi_qmux_device_has_service(struct qmi_qmux_device *qmux, uint16_t type)
 	if (!qmux)
 		return false;
 
-	return __find_service_info_by_type(&qmux->super, type);
+	return __qmux_service_info_find(qmux, type);
 }
 
 static int qmi_qmux_device_write(struct qmi_device *device,
@@ -1197,7 +1181,6 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
 					uint16_t length, const void *buffer)
 {
 	struct qmi_qmux_device *qmux = req->user_data;
-	struct qmi_device *device = &qmux->super;
 	const struct qmi_result_code *result_code;
 	const struct qmi_service_list *service_list;
 	const void *ptr;
@@ -1219,6 +1202,13 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
 	if (len < QMI_SERVICE_LIST_SIZE)
 		goto done;
 
+	if (!service_list->count)
+		goto done;
+
+	l_free(qmux->service_list);
+	qmux->n_services = 0;
+	qmux->service_list = l_new(struct qmi_service_info, service_list->count);
+
 	for (i = 0; i < service_list->count; i++) {
 		uint16_t major =
 			L_LE16_TO_CPU(service_list->services[i].major);
@@ -1226,7 +1216,6 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
 			L_LE16_TO_CPU(service_list->services[i].minor);
 		uint8_t type = service_list->services[i].type;
 		const char *name = __service_type_to_string(type);
-		struct qmi_service_info info;
 
 		if (name)
 			DEBUG(&qmux->debug, "discovered service [%s %d.%d]",
@@ -1240,12 +1229,10 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
 			continue;
 		}
 
-		memset(&info, 0, sizeof(info));
-		info.service_type = type;
-		info.major = major;
-		info.minor = minor;
-
-		__qmi_service_appeared(device, &info);
+		qmux->service_list[qmux->n_services].service_type = type;
+		qmux->service_list[qmux->n_services].major = major;
+		qmux->service_list[qmux->n_services].minor = minor;
+		qmux->n_services += 1;
 	}
 
 	ptr = tlv_get(buffer, length, 0x10, &len);
@@ -1304,7 +1291,7 @@ int qmi_qmux_device_discover(struct qmi_qmux_device *qmux,
 
 	DEBUG(&qmux->debug, "device %p", qmux);
 
-	if (l_queue_length(qmux->super.service_infos) > 0 || qmux->discover.tid)
+	if (qmux->n_services || qmux->discover.tid)
 		return -EALREADY;
 
 	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0, 0);
@@ -1439,7 +1426,7 @@ bool qmi_qmux_device_create_client(struct qmi_qmux_device *qmux,
 	if (service_type == QMI_SERVICE_CONTROL)
 		return false;
 
-	info = __find_service_info_by_type(&qmux->super, service_type);
+	info = __qmux_service_info_find(qmux, service_type);
 	if (!info)
 		return false;
 
@@ -1504,6 +1491,7 @@ static void __qmux_device_free(struct qmi_qmux_device *qmux)
 	if (qmux->shutdown.idle)
 		l_idle_remove(qmux->shutdown.idle);
 
+	l_free(qmux->service_list);
 	l_free(qmux->version_str);
 	l_free(qmux);
 }
@@ -1621,6 +1609,7 @@ void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 struct qmi_qrtr_node {
 	struct qmi_device super;
 	unsigned int next_group_id;	/* Matches requests with services */
+	struct l_queue *service_infos;
 	struct debug_data debug;
 	struct {
 		qmi_qrtr_node_lookup_done_func_t func;
@@ -1630,6 +1619,32 @@ struct qmi_qrtr_node {
 	} lookup;
 };
 
+static const struct qmi_service_info *__qrtr_service_info_find(
+				struct qmi_qrtr_node *node, uint16_t type)
+{
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(node->service_infos);
+						entry; entry = entry->next) {
+		struct qmi_service_info *info = entry->data;
+
+		if (info->service_type == type)
+			return info;
+	}
+
+	return NULL;
+}
+
+static void __qrtr_service_appeared(struct qmi_qrtr_node *node,
+					const struct qmi_service_info *info)
+{
+	if (l_queue_find(node->service_infos, qmi_service_info_matches, info))
+		return;
+
+	l_queue_push_tail(node->service_infos,
+				l_memdup(info, sizeof(struct qmi_service_info)));
+}
+
 static void __qrtr_lookup_finished(struct qmi_qrtr_node *node)
 {
 	if (!node->lookup.func) {
@@ -1708,7 +1723,6 @@ static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
 static void qrtr_received_control_packet(struct qmi_qrtr_node *node,
 						const void *buf, size_t len)
 {
-	struct qmi_device *device = &node->super;
 	const struct qrtr_ctrl_pkt *packet = buf;
 	struct qmi_service_info info;
 	uint32_t cmd;
@@ -1755,7 +1769,7 @@ static void qrtr_received_control_packet(struct qmi_qrtr_node *node,
 	info.major = version;
 	info.instance = instance;
 
-	__qmi_service_appeared(device, &info);
+	__qrtr_service_appeared(node, &info);
 
 	if (!node->lookup.func)
 		return;
@@ -1772,7 +1786,7 @@ static void qrtr_received_service_message(struct qmi_qrtr_node *node,
 	const struct l_queue_entry *entry;
 	uint32_t service_type = 0;
 
-	for (entry = l_queue_get_entries(device->service_infos);
+	for (entry = l_queue_get_entries(node->service_infos);
 				entry; entry = entry->next) {
 		struct qmi_service_info *info = entry->data;
 
@@ -1844,6 +1858,8 @@ struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node)
 		return NULL;
 	}
 
+	qrtr->service_infos = l_queue_new();
+
 	l_io_set_read_handler(qrtr->super.io, qrtr_received_data, qrtr, NULL);
 
 	return qrtr;
@@ -1855,6 +1871,7 @@ void qmi_qrtr_node_free(struct qmi_qrtr_node *node)
 		return;
 
 	__qmi_device_free(&node->super);
+	l_queue_destroy(node->service_infos, l_free);
 
 	if (node->lookup.destroy)
 		node->lookup.destroy(node->lookup.user_data);
@@ -1957,7 +1974,7 @@ struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
 	if (family)
 		goto done;
 
-	info = __find_service_info_by_type(device, type);
+	info = __qrtr_service_info_find(node, type);
 	if (!info)
 		return NULL;
 
@@ -1973,7 +1990,7 @@ bool qmi_qrtr_node_has_service(struct qmi_qrtr_node *node, uint16_t type)
 	if (!node)
 		return false;
 
-	return __find_service_info_by_type(&node->super, type);
+	return __qrtr_service_info_find(node, type);
 }
 
 struct qmi_param *qmi_param_new(void)
-- 
2.45.0

