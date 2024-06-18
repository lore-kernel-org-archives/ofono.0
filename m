Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BB16DED1
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740977; cv=none; b=tkp1ysPxpoATRJNm4DrOOuCMqA6VeBwARs5sjK0aVNcAJoiRHJYzbVjZt5llH2LgFCnaRZRyhoGR2tmLGroPFJQm8V7Siq9M3Ww1gClB+Kxl28YTNzGRh3autnDx/TNK6KFZ5FUW1Pi+eji5pHpXFL0nC/ZUGltgtbGq+cmBLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740977; c=relaxed/simple;
	bh=vALwEXGnKaUaWGin0BX40qNkKZqU1PtcNNQkIM7hnhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFjc9zdtzlZHI5iIBQuktdJn/o7Cl35k+XTFYcIjmym7XrEYI32b54BR1vDWZbJR/F/4khWGe7KVDEfIDW9ywAnES11vpB/f5kyXr28okOrTTt9slT4is6OST7GdA06z9fX+mkTOiujg6oCv65A6D2ltWswg8gL4lZIWKVwlX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNI3vvZn; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNI3vvZn"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-254a2d8485eso2825438fac.0
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740975; x=1719345775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDle5sLaDG156djjYdNfiUQ4KGhnaUyZOKGc/MznpDM=;
        b=ZNI3vvZnZMxjf78gbgkTJbefdpO3OC1h2sNlV/M/xXxo8nQQ9JuseS+DJPegR2sDw0
         U1iP9aMNMjjhfhP6YocF0C6Bj346xc+91WGhSpMYAfxXzbgeYk0sdFvZ7RAZ/Lh0mCMs
         pZSGLS/NqijLZ21wd4IQay4suVgSbDOwdlGhj6kXmdgV+aXY9zSzkqAtNRgXxZqUzMsA
         Xx9EekGe+S1qYvo0MKhB8yS/GzS07XLf9QnENclVbt5nh0JC5A0MDhTvSRpf+SSzGUq0
         gezadLy4CLPevWwlN45u3PlSPtcmEenGRhzS9j5J1gLwmAqYK20y+2/Fdc0DxA0ZFULv
         0mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740975; x=1719345775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDle5sLaDG156djjYdNfiUQ4KGhnaUyZOKGc/MznpDM=;
        b=A2o6IeAlz/0uxiQ15vppE2ZYYieN0U8C53kE1ExZ3lObNDqlHt8i/HO6Ic2E7covHG
         hzUSNMsVxriAnkOLbMMPfcx9KwbgkoPAJNt+2fRt7N+z5qiT8yNK+ZJ316usa3sagOVu
         VODXO9X0Ypi5M7Oaqt9tU3HtBNcBQoUApIDjH06rG2RstFcGny58AgS8GbT6gN8n30kf
         5qfXSHb4GGycdvQaG9tcmUTYTq+rMG0kH12qRqU/yU9mZ5C0LltRafrlUOQ5ma4yNuAF
         TKmnTRIs+yGtUvq8128spfa1b3CEC7rB1Z8+h+xTxGxgFuIYBCMQtTqoBc1QmZ6Q8T2c
         JlDA==
X-Gm-Message-State: AOJu0Yyu4pCOhU6dcRi9gGzGPztHMZh8nH92KOiMFS1fR56Cua/lEgYI
	gtiIGWmKP4jC2UyJqW2nQ/Gs/qEPXDZ2HdlTDV7VO4qGovNvk5gJYWJwiw==
X-Google-Smtp-Source: AGHT+IH6F8FpRKEzVEFVUp801iDsjCWTYc1TkufKYRFdjZzgOH7wj/o4wBpJpaKsyLloTKs//ym4Hw==
X-Received: by 2002:a05:6871:1ce:b0:24f:e09d:3c83 with SMTP id 586e51a60fabf-25c94cfcea0mr1034594fac.36.1718740975138;
        Tue, 18 Jun 2024 13:02:55 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:54 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 28/33] qmi: Make qmux methods operate on 'qmi_qmux_device'
Date: Tue, 18 Jun 2024 15:02:10 -0500
Message-ID: <20240618200231.1129282-28-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/qmi.c | 70 ++++++++++++++++++------------------------
 drivers/qmimodem/qmi.h | 19 ++++++------
 plugins/gobi.c         |  2 +-
 3 files changed, 40 insertions(+), 51 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 0d67b07fa729..6e66060b1d3c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -38,6 +38,8 @@
 typedef void (*qmi_message_func_t)(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data);
 
+struct qmi_device;
+
 struct discovery {
 	qmi_destroy_func_t destroy;
 };
@@ -961,13 +963,16 @@ static const struct qmi_service_info *__find_service_info_by_type(
 	return info;
 }
 
-bool qmi_qmux_device_get_service_version(struct qmi_device *device,
+bool qmi_qmux_device_get_service_version(struct qmi_qmux_device *qmux,
 					uint16_t type,
 					uint16_t *major, uint16_t *minor)
 {
 	const struct qmi_service_info *info;
 
-	info = __find_service_info_by_type(device, type);
+	if (!qmux)
+		return false;
+
+	info = __find_service_info_by_type(&qmux->super, type);
 	if (!info)
 		return false;
 
@@ -976,12 +981,12 @@ bool qmi_qmux_device_get_service_version(struct qmi_device *device,
 	return true;
 }
 
-bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type)
+bool qmi_qmux_device_has_service(struct qmi_qmux_device *qmux, uint16_t type)
 {
-	if (!device)
+	if (!qmux)
 		return false;
 
-	return __find_service_info_by_type(device, type);
+	return __find_service_info_by_type(&qmux->super, type);
 }
 
 static int qmi_qmux_device_write(struct qmi_device *device,
@@ -1328,21 +1333,18 @@ static void qmux_discover_reply_timeout(struct l_timeout *timeout,
 	__qmux_discovery_finished(qmux);
 }
 
-int qmi_qmux_device_discover(struct qmi_device *device,
+int qmi_qmux_device_discover(struct qmi_qmux_device *qmux,
 				qmi_qmux_device_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
-	struct qmi_qmux_device *qmux;
 	struct qmi_request *req;
 
-	if (!device)
+	if (!qmux)
 		return -EINVAL;
 
-	qmux = l_container_of(device, struct qmi_qmux_device, super);
-
 	DEBUG(&qmux->debug, "device %p", qmux);
 
-	if (l_queue_length(device->service_infos) > 0 || qmux->discover.tid)
+	if (l_queue_length(qmux->super.service_infos) > 0 || qmux->discover.tid)
 		return -EALREADY;
 
 	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0,
@@ -1444,14 +1446,15 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	info.major = data->major;
 	info.minor = data->minor;
 
-	family = service_family_create(device, &info, client_id->client);
+	family = service_family_create(&qmux->super, &info, client_id->client);
 	DEBUG(&qmux->debug, "service family created [client=%d,type=%d]",
 			family->client_id, family->info.service_type);
 
 	family = service_family_ref(family);
 	hash_id = family_list_create_hash(family->info.service_type,
 							family->client_id);
-	l_hashmap_insert(device->family_list, L_UINT_TO_PTR(hash_id), family);
+	l_hashmap_insert(qmux->super.family_list,
+					L_UINT_TO_PTR(hash_id), family);
 
 done:
 	if (family)
@@ -1463,32 +1466,29 @@ done:
 		service_family_unref(family);
 }
 
-bool qmi_qmux_device_create_client(struct qmi_device *device,
+bool qmi_qmux_device_create_client(struct qmi_qmux_device *qmux,
 				uint16_t service_type,
 				qmi_qmux_device_create_client_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
 	const struct qmi_service_info *info;
-	struct qmi_qmux_device *qmux;
 	struct qmi_request *req;
 	struct qmux_client_create_data *create_data;
 
-	if (!device || !func)
+	if (!qmux || !func)
 		return false;
 
 	if (service_type == QMI_SERVICE_CONTROL)
 		return false;
 
-	info = __find_service_info_by_type(device, service_type);
+	info = __find_service_info_by_type(&qmux->super, service_type);
 	if (!info)
 		return false;
 
-	qmux = l_container_of(device, struct qmi_qmux_device, super);
-
 	create_data = l_new(struct qmux_client_create_data, 1);
 	create_data->super.destroy = qmux_client_create_data_free;
-	create_data->device = device;
+	create_data->device = &qmux->super;
 	create_data->type = service_type;
 	create_data->major = info->major;
 	create_data->minor = info->minor;
@@ -1507,7 +1507,7 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 	create_data->timeout = l_timeout_create(8, qmux_client_create_timeout,
 							create_data, NULL);
 
-	__qmi_device_discovery_started(device, &create_data->super);
+	__qmi_device_discovery_started(&qmux->super, &create_data->super);
 	return true;
 }
 
@@ -1583,18 +1583,14 @@ static void qmux_shutdown_callback(struct l_idle *idle, void *user_data)
 	l_idle_remove(qmux->shutdown.idle);
 }
 
-int qmi_qmux_device_shutdown(struct qmi_device *device,
+int qmi_qmux_device_shutdown(struct qmi_qmux_device *qmux,
 					qmi_qmux_device_shutdown_func_t func,
 					void *user_data,
 					qmi_destroy_func_t destroy)
 {
-	struct qmi_qmux_device *qmux;
-
-	if (!device)
+	if (!qmux)
 		return -EINVAL;
 
-	qmux = l_container_of(device, struct qmi_qmux_device, super);
-
 	if (qmux->shutdown.idle)
 		return -EALREADY;
 
@@ -1618,7 +1614,7 @@ static const struct qmi_device_ops qmux_ops = {
 	.client_release = qmi_qmux_device_client_release,
 };
 
-struct qmi_device *qmi_qmux_device_new(const char *device)
+struct qmi_qmux_device *qmi_qmux_device_new(const char *device)
 {
 	struct qmi_qmux_device *qmux;
 	int fd;
@@ -1639,19 +1635,16 @@ struct qmi_device *qmi_qmux_device_new(const char *device)
 	qmux->control_queue = l_queue_new();
 	l_io_set_read_handler(qmux->super.io, received_qmux_data, qmux, NULL);
 
-	return &qmux->super;
+	return qmux;
 }
 
-void qmi_qmux_device_free(struct qmi_device *device)
+void qmi_qmux_device_free(struct qmi_qmux_device *qmux)
 {
-	struct qmi_qmux_device *qmux;
-
-	if (!device)
+	if (!qmux)
 		return;
 
-	qmux = l_container_of(device, struct qmi_qmux_device, super);
 	DEBUG(&qmux->debug, "device %p", qmux);
-	__qmi_device_free(device);
+	__qmi_device_free(&qmux->super);
 
 	if (qmux->shutting_down) {
 		qmux->destroyed = true;
@@ -1661,15 +1654,12 @@ void qmi_qmux_device_free(struct qmi_device *device)
 	__qmux_device_free(qmux);
 }
 
-void qmi_qmux_device_set_debug(struct qmi_device *device,
+void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 				qmi_debug_func_t func, void *user_data)
 {
-	struct qmi_qmux_device *qmux;
-
-	if (device == NULL)
+	if (!qmux)
 		return;
 
-	qmux = l_container_of(device, struct qmi_qmux_device, super);
 	__debug_data_init(&qmux->debug, func, user_data);
 }
 
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 64eebc27c17c..966f99f114fe 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -52,9 +52,8 @@ enum qmi_data_endpoint_type {
 
 typedef void (*qmi_destroy_func_t)(void *user_data);
 
-struct qmi_device;
-struct qmi_result;
 struct qmi_service;
+struct qmi_result;
 
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_qmux_device_discover_func_t)(void *user_data);
@@ -65,22 +64,22 @@ typedef void (*qmi_qrtr_node_lookup_done_func_t)(void *);
 
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
-struct qmi_device *qmi_qmux_device_new(const char *device);
-void qmi_qmux_device_free(struct qmi_device *device);
-void qmi_qmux_device_set_debug(struct qmi_device *device,
+struct qmi_qmux_device *qmi_qmux_device_new(const char *device);
+void qmi_qmux_device_free(struct qmi_qmux_device *qmux);
+void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 				qmi_debug_func_t func, void *user_data);
-int qmi_qmux_device_discover(struct qmi_device *device,
+int qmi_qmux_device_discover(struct qmi_qmux_device *qmux,
 				qmi_qmux_device_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
-bool qmi_qmux_device_create_client(struct qmi_device *device,
+bool qmi_qmux_device_create_client(struct qmi_qmux_device *qmux,
 				uint16_t service_type,
 				qmi_qmux_device_create_client_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
-bool qmi_qmux_device_get_service_version(struct qmi_device *device,
+bool qmi_qmux_device_get_service_version(struct qmi_qmux_device *qmux,
 					uint16_t type,
 					uint16_t *major, uint16_t *minor);
-bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type);
-int qmi_qmux_device_shutdown(struct qmi_device *device,
+bool qmi_qmux_device_has_service(struct qmi_qmux_device *qmux, uint16_t type);
+int qmi_qmux_device_shutdown(struct qmi_qmux_device *qmux,
 				qmi_qmux_device_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 74df3c360c96..d24b95fffc91 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -61,7 +61,7 @@ struct service_request {
 };
 
 struct gobi_data {
-	struct qmi_device *device;
+	struct qmi_qmux_device *device;
 	struct qmi_service *dms;
 	struct qmi_service *wda;
 	struct qmi_service *nas;
-- 
2.45.0

