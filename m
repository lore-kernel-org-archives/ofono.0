Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B417334B
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333728; cv=none; b=UiA+LhlszRmF0chmRACdcuUvWBpoY0PTGg71IFv+RX3SIvBUq0e0KG+dM0fq64mbDLGzJVysSCgT20s0o2YzD5C3uYLD9KllW3U6+ZjOjNrTW9xa5LettS3TBbgtyBntLPLHFTSbOdaciS8KM+x24CxyHMVx+c6kz9/65MnxvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333728; c=relaxed/simple;
	bh=Y6pk/Epc+DnYPENa/ALKt7JWYOnYzQLreTucHf93GOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQVmRdhm3kZK6vBYNE+czMtJnf5FVNKZzHrFT+64OLEh5xyRyyd0lUvr2c013tFsjxCtmxbfEBTtkwLMcmydMBNZyuIXOhWMd8T81sNt/cKKdRBg4sYfnBbcnSuUvSLBp4fFfAic1l2QBn0AqQzDXMtL+LSe5gbVTxWQjmjFHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuJtllTY; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuJtllTY"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70024655285so3405580a34.0
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333726; x=1719938526; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKlhb3KKjn5rkdS+78jiw2gNekNCU7VOTiVTG5mkm9U=;
        b=UuJtllTYxRQGbzUnkQK9UfCPHYIMUF1iltXf0kejsSp+SwFSzwh1tv04w+DGBprKc9
         lRViic9NFFNqGwmL/Q2FbXq9ZocQN/wFiK85ibnkJm/RMNyVYPwQL4ojXnrc8kJv6Zjl
         Ri466gV/TrMHEY4DPQJmEu+bWZPAe2Vz4oau8G9rplX/4lOdtuwreCDcV9SN7bKk6dc7
         3cJ7ZgoZy8ErfmBy4x5vFXxQjzCAKKRWz46nX+SH0xlZdxaBzw76eCzchEBeCsPOptsj
         m/wVqI4OGS6aInm9tZzPWlwFqvtkorSasInyk7k80vQcGwYkgWrJt4X92YhzwV/t2jo4
         gJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333726; x=1719938526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKlhb3KKjn5rkdS+78jiw2gNekNCU7VOTiVTG5mkm9U=;
        b=UkJBsKYl4wwlx/G3Bu5DMmVn5eCOp2SUcYP1ejOYjYIrntbMpFDjTGKm8YJRwwpIAT
         BD9un/s+n0HEGayDuFsZ/KbOG9Yms+zJSuaI4QcfcoCQuEvhsdLWAX+1vZ+fRhk6ZEwG
         uZ+7ZAB3ZyEOFaXna+NQXRK/IZCDGQJEmNMbXqPojPmKxudnsky9blxRQPhuewOWSODF
         VZwMN7h8XF91bIFO6o5cEDRlt9quVTbGjN7a8p20JutX2kXsAB4z0HByySBETbHXiQcM
         ijTS1F5iXdaOUS3L8WR/5xJd/VjiJusyyScT42/VDL51/TT01Jx5njwP9cnvc7zve6/X
         PoeA==
X-Gm-Message-State: AOJu0YwztCWcqM8RaOzVuhTOTQbkoYdiCqTaXwNi9G/VYg6xG2h8JfnI
	k9NoNfrB4ccrlcUQ9ZPQ0MeDVL8jMXM7iIhQvKwL9tQyrltceLRxZIreLA==
X-Google-Smtp-Source: AGHT+IF44mx8ThC9+nxOlbltV1ZWwGeqA2CzNv9NuiseVG250ho6Jj+DiVMGB5GgS5XpNx2dzep/kw==
X-Received: by 2002:a05:6830:120f:b0:700:cc10:6622 with SMTP id 46e09a7af769-700cc106639mr1263419a34.25.1719333724225;
        Tue, 25 Jun 2024 09:42:04 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:03 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 05/14] qmi: Move service_info management into qrtr/qmux
Date: Tue, 25 Jun 2024 11:41:41 -0500
Message-ID: <20240625164158.1170937-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240625164158.1170937-1-denkenz@gmail.com>
References: <20240625164158.1170937-1-denkenz@gmail.com>
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
 drivers/qmimodem/qmi.c | 103 +++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2095a952fffd..59a50eabeb2b 100644
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
@@ -905,23 +893,17 @@ static const void *tlv_get(const void *data, uint16_t size,
 	return NULL;
 }
 
-static const struct qmi_service_info *__find_service_info_by_type(
-				struct qmi_device *device, uint16_t type)
+static const struct qmi_service_info *__qmux_service_info_find(
+				struct qmi_qmux_device *qmux, uint16_t type)
 {
-	const struct qmi_service_info *info = NULL;
-	const struct l_queue_entry *entry;
-
-	for (entry = l_queue_get_entries(device->service_infos);
-						entry; entry = entry->next) {
-		struct qmi_service_info *data = entry->data;
+	unsigned int i;
 
-		if (data->service_type == type) {
-			info = data;
-			break;
-		}
+	for (i = 0; i < qmux->n_services; i++) {
+		if (qmux->service_list[i].service_type == type)
+			return qmux->service_list + i;
 	}
 
-	return info;
+	return NULL;
 }
 
 bool qmi_qmux_device_get_service_version(struct qmi_qmux_device *qmux,
@@ -933,7 +915,7 @@ bool qmi_qmux_device_get_service_version(struct qmi_qmux_device *qmux,
 	if (!qmux)
 		return false;
 
-	info = __find_service_info_by_type(&qmux->super, type);
+	info = __qmux_service_info_find(qmux, type);
 	if (!info)
 		return false;
 
@@ -947,7 +929,7 @@ bool qmi_qmux_device_has_service(struct qmi_qmux_device *qmux, uint16_t type)
 	if (!qmux)
 		return false;
 
-	return __find_service_info_by_type(&qmux->super, type);
+	return __qmux_service_info_find(qmux, type);
 }
 
 static int qmi_qmux_device_write(struct qmi_device *device,
@@ -1197,7 +1179,6 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
 					uint16_t length, const void *buffer)
 {
 	struct qmi_qmux_device *qmux = req->user_data;
-	struct qmi_device *device = &qmux->super;
 	const struct qmi_result_code *result_code;
 	const struct qmi_service_list *service_list;
 	const void *ptr;
@@ -1219,6 +1200,13 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
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
@@ -1226,7 +1214,6 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
 			L_LE16_TO_CPU(service_list->services[i].minor);
 		uint8_t type = service_list->services[i].type;
 		const char *name = __service_type_to_string(type);
-		struct qmi_service_info info;
 
 		if (name)
 			DEBUG(&qmux->debug, "discovered service [%s %d.%d]",
@@ -1240,12 +1227,10 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
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
@@ -1304,7 +1289,7 @@ int qmi_qmux_device_discover(struct qmi_qmux_device *qmux,
 
 	DEBUG(&qmux->debug, "device %p", qmux);
 
-	if (l_queue_length(qmux->super.service_infos) > 0 || qmux->discover.tid)
+	if (qmux->n_services || qmux->discover.tid)
 		return -EALREADY;
 
 	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0, 0);
@@ -1439,7 +1424,7 @@ bool qmi_qmux_device_create_client(struct qmi_qmux_device *qmux,
 	if (service_type == QMI_SERVICE_CONTROL)
 		return false;
 
-	info = __find_service_info_by_type(&qmux->super, service_type);
+	info = __qmux_service_info_find(qmux, service_type);
 	if (!info)
 		return false;
 
@@ -1504,6 +1489,7 @@ static void __qmux_device_free(struct qmi_qmux_device *qmux)
 	if (qmux->shutdown.idle)
 		l_idle_remove(qmux->shutdown.idle);
 
+	l_free(qmux->service_list);
 	l_free(qmux->version_str);
 	l_free(qmux);
 }
@@ -1621,6 +1607,7 @@ void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 struct qmi_qrtr_node {
 	struct qmi_device super;
 	unsigned int next_group_id;	/* Matches requests with services */
+	struct l_queue *service_infos;
 	struct debug_data debug;
 	struct {
 		qmi_qrtr_node_lookup_done_func_t func;
@@ -1630,6 +1617,32 @@ struct qmi_qrtr_node {
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
@@ -1708,7 +1721,6 @@ static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
 static void qrtr_received_control_packet(struct qmi_qrtr_node *node,
 						const void *buf, size_t len)
 {
-	struct qmi_device *device = &node->super;
 	const struct qrtr_ctrl_pkt *packet = buf;
 	struct qmi_service_info info;
 	uint32_t cmd;
@@ -1755,7 +1767,7 @@ static void qrtr_received_control_packet(struct qmi_qrtr_node *node,
 	info.major = version;
 	info.instance = instance;
 
-	__qmi_service_appeared(device, &info);
+	__qrtr_service_appeared(node, &info);
 
 	if (!node->lookup.func)
 		return;
@@ -1772,7 +1784,7 @@ static void qrtr_received_service_message(struct qmi_qrtr_node *node,
 	const struct l_queue_entry *entry;
 	uint32_t service_type = 0;
 
-	for (entry = l_queue_get_entries(device->service_infos);
+	for (entry = l_queue_get_entries(node->service_infos);
 				entry; entry = entry->next) {
 		struct qmi_service_info *info = entry->data;
 
@@ -1844,6 +1856,8 @@ struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node)
 		return NULL;
 	}
 
+	qrtr->service_infos = l_queue_new();
+
 	l_io_set_read_handler(qrtr->super.io, qrtr_received_data, qrtr, NULL);
 
 	return qrtr;
@@ -1855,6 +1869,7 @@ void qmi_qrtr_node_free(struct qmi_qrtr_node *node)
 		return;
 
 	__qmi_device_free(&node->super);
+	l_queue_destroy(node->service_infos, l_free);
 
 	if (node->lookup.destroy)
 		node->lookup.destroy(node->lookup.user_data);
@@ -1957,7 +1972,7 @@ struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
 	if (family)
 		goto done;
 
-	info = __find_service_info_by_type(device, type);
+	info = __qrtr_service_info_find(node, type);
 	if (!info)
 		return NULL;
 
@@ -1973,7 +1988,7 @@ bool qmi_qrtr_node_has_service(struct qmi_qrtr_node *node, uint16_t type)
 	if (!node)
 		return false;
 
-	return __find_service_info_by_type(&node->super, type);
+	return __qrtr_service_info_find(node, type);
 }
 
 struct qmi_param *qmi_param_new(void)
-- 
2.45.0

