Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8A54914
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633010; cv=none; b=UEn99wWvUhslYS1WqaPviyWliIioU9jnBTg9bghb9qiJPDTAIsmcvllRa2aGmyu6lNcfgOiG/n6Y9HNjfxROTejWvEYL+B3YCB8UONK3ymkAFl0otUMczzhXmKsZVe8C1lOsiaWg5VduD86V9PatYoostBVuBiRNigr+84JS/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633010; c=relaxed/simple;
	bh=72z+tT7DEB+5bcUz/kgwn+wcqAfQIkCkH77m0wCRMUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6Jh03svSigmDRXa4DqEYl985rWe6EjZpkftDYakC2QUsxM7ZUJ6x7QH37cu6AlB4x/QEJS5XBMx9/rVRs07VIPfd5+Gp9cK9H8LuyWH1zo4ncsRwNt6pAiVUx0r9pI46G3y5Ju+T0usvbyIauyWrKdVt0IAWpYcvGy6y9HblRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kavxCksC; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kavxCksC"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-599f5e71d85so137530eaf.3
        for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 12:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708633007; x=1709237807; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qlm5KhKwNC/pQaGIooXCUL1ClSIUaniMVo/Csisk3wQ=;
        b=kavxCksCT9nLX7KWjQW3fgGWBudSzS0F9N1ivzKqZCp/kNfheJ3Inl7yaOpSEjAm2c
         zwzMf79cfY/ls9HgP17AeWb8lc1N9W8fnWTfkJcbWU5Hom3dmBBM3lSB0d61k5OMvaA2
         qRaqNG8VOZJaMHJvnV8deKiP9C4GqSkWY6Ef28kTWiF6BKaKhQvyLgTW4UM+r23H1DcJ
         qIjQ7ci4KzWMQrZ51o70QNDEXmcBGPsox03lU1/uyuXW3Z4UAVl7tpFbHJMy1o48vKVv
         pUyo9l4xyCmeJHcMV3772hcfHnMZPRsCyTmfzZQbPSzRBpn6XCVdKGCuOL36lD8pnbLu
         NE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633007; x=1709237807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlm5KhKwNC/pQaGIooXCUL1ClSIUaniMVo/Csisk3wQ=;
        b=ILAIrJFaSoJ38cDoNkFMjyrUDT1fA8DfMDv/hGxOZQDQRWE7fCaKvF+kuVy7QBG0HA
         T4JgMsiVdyxrm/YxNU7mpSpl7V2SdkkXCQ3qHYRdDQuu0R8iEe2VYSAtlxqte7Dtw20g
         JZBkHVmzK5OpYvzYOk/Q8qEuoOygVRN9sztLpKETjFn4zO26NW+ywk2Td3txERYJHSzP
         wtgAOAFzzZ0rnjofBhqbTjKRUFFJQvJ/7V1m5rr3NUFEkoWc3RB/nRbrnvkRFtPttMo1
         /cJ4CnW5FZUWZi41mRDDPgnkt8+/dmnAFlA+UzdTRpnP1T4P2axr35s+r0RIRO7Arcrs
         kegQ==
X-Gm-Message-State: AOJu0YySz9OrziKnzB1mn98zMrLEGpNi7r9ipAHwo0LadUg1GUdF9pRu
	8auPyr9NJ7zHHOAOqRjIAn+rm7HZpbsBybcbWsfOJjbcQitsY+O6XLYeeBW6
X-Google-Smtp-Source: AGHT+IG9L2YIPsWkPFseLsQoGifTATRRccn3RpJYf0Xl//1curVsvqaQEOTUmpezIuaCglBaMOvBVQ==
X-Received: by 2002:a4a:3446:0:b0:5a0:109f:edff with SMTP id n6-20020a4a3446000000b005a0109fedffmr29699oof.4.1708633007139;
        Thu, 22 Feb 2024 12:16:47 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id k1-20020a4a9101000000b0059a14309a29sm2472353oog.16.2024.02.22.12.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:16:46 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/4] qmi: Introduce discover() driver method
Date: Thu, 22 Feb 2024 14:15:42 -0600
Message-ID: <20240222201559.1293947-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On QMUX the discover operation queries all available services by sending
a QMUX Control message and processing its reply.  The reply contains a
list of services and the corresponding major / minor version number.

QRTR has a similar, but much more dynamic mechanism utilizing the QRTR
nameserver.  Services on QRTR can appear and disappear freely compared
to services on QMUX.

Abstract the discovery operation behind a discover() method in the ops
structure, and move the QMUX specific implementation there.  While here,
change the return signature of qmi_device_discover() to return an int,
such that better error reporting can be supported.
---
 drivers/qmimodem/qmi.c | 358 +++++++++++++++++++++--------------------
 drivers/qmimodem/qmi.h |   2 +-
 2 files changed, 188 insertions(+), 172 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index ec7a74778079..2a6e79efeed2 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -56,6 +56,9 @@ struct qmi_version {
 };
 
 struct qmi_device_ops {
+	int (*discover)(struct qmi_device *device,
+			qmi_discover_func_t discover_func,
+			void *user, qmi_destroy_func_t destroy);
 	int (*client_create)(struct qmi_device *device,
 				uint16_t service_type,
 				qmi_create_func_t func,
@@ -1139,183 +1142,16 @@ static bool qmi_device_sync(struct qmi_device *device,
 	return true;
 }
 
-static void discover_callback(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data)
-{
-	struct discover_data *data = user_data;
-	struct qmi_device *device = data->device;
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
-	const struct qmi_result_code *result_code;
-	const struct qmi_service_list *service_list;
-	const void *ptr;
-	uint16_t len;
-	struct qmi_version *list;
-	uint8_t count;
-	unsigned int i;
-
-	count = 0;
-	list = NULL;
-
-	result_code = tlv_get(buffer, length, 0x02, &len);
-	if (!result_code)
-		goto done;
-
-	if (len != QMI_RESULT_CODE_SIZE)
-		goto done;
-
-	service_list = tlv_get(buffer, length, 0x01, &len);
-	if (!service_list)
-		goto done;
-
-	if (len < QMI_SERVICE_LIST_SIZE)
-		goto done;
-
-	list = l_malloc(sizeof(struct qmi_version) * service_list->count);
-
-	for (i = 0; i < service_list->count; i++) {
-		uint16_t major =
-			L_LE16_TO_CPU(service_list->services[i].major);
-		uint16_t minor =
-			L_LE16_TO_CPU(service_list->services[i].minor);
-		uint8_t type = service_list->services[i].type;
-		const char *name = __service_type_to_string(type);
-
-		if (name)
-			__debug_device(device, "found service [%s %d.%d]",
-					name, major, minor);
-		else
-			__debug_device(device, "found service [%d %d.%d]",
-					type, major, minor);
-
-		if (type == QMI_SERVICE_CONTROL) {
-			qmux->control_major = major;
-			qmux->control_minor = minor;
-			continue;
-		}
-
-		list[count].type = type;
-		list[count].major = major;
-		list[count].minor = minor;
-		list[count].name = name;
-
-		count++;
-	}
-
-	ptr = tlv_get(buffer, length, 0x10, &len);
-	if (!ptr)
-		goto done;
-
-	qmux->version_str = l_strndup(ptr + 1, *((uint8_t *) ptr));
-	__debug_device(device, "version string: %s", qmux->version_str);
-
-done:
-	device->version_list = list;
-	device->version_count = count;
-
-	/* if the device support the QMI call SYNC over the CTL interface */
-	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
-			qmux->control_major > 1) {
-		qmi_device_sync(data->device, data);
-		return;
-	}
-
-	if (data->func)
-		data->func(data->user_data);
-
-	__qmi_device_discovery_complete(data->device, &data->super);
-}
-
-static struct qmi_request *find_control_request(struct qmi_device *device,
-						uint16_t tid)
-{
-	struct qmi_request *req = NULL;
-	unsigned int _tid = tid;
-
-	if (_tid != 0) {
-		req = l_queue_remove_if(device->req_queue, __request_compare,
-						L_UINT_TO_PTR(_tid));
-
-		if (!req)
-			req = l_queue_remove_if(device->control_queue,
-							__request_compare,
-							L_UINT_TO_PTR(_tid));
-	}
-
-	return req;
-}
-
-
-static void discover_reply_idle(struct l_idle *idle, void *user_data)
-{
-	struct discover_data *data = user_data;
-	struct qmi_device *device = data->device;
-
-	l_idle_remove(data->idle);
-	data->idle = NULL;
-
-	if (data->func)
-		data->func(data->user_data);
-
-	__qmi_device_discovery_complete(device, &data->super);
-}
-
-static void discover_reply_timeout(struct l_timeout *timeout, void *user_data)
-{
-	struct discover_data *data = user_data;
-	struct qmi_device *device = data->device;
-	struct qmi_request *req;
-
-	l_timeout_remove(data->timeout);
-	data->timeout = NULL;
-
-	/* remove request from queues */
-	req = find_control_request(device, data->tid);
-
-	if (data->func)
-		data->func(data->user_data);
-
-	__qmi_device_discovery_complete(device, &data->super);
-
-	if (req)
-		__request_free(req);
-}
-
-bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
+int qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
-	struct discover_data *data;
-	struct qmi_request *req;
-
 	if (!device)
 		return false;
 
-	__debug_device(device, "device %p discover", device);
-
-	data = l_new(struct discover_data, 1);
-
-	data->super.destroy = discover_data_free;
-	data->device = device;
-	data->func = func;
-	data->user_data = user_data;
-	data->destroy = destroy;
-
-	if (device->version_list) {
-		data->idle = l_idle_create(discover_reply_idle, data, NULL);
-		__qmi_device_discovery_started(device, &data->super);
-		return true;
-	}
-
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_GET_VERSION_INFO,
-			NULL, 0, discover_callback, data);
-
-	data->tid = __request_submit(device, req);
-	data->timeout = l_timeout_create(5, discover_reply_timeout, data, NULL);
-
-	__qmi_device_discovery_started(device, &data->super);
+	if (!device->ops->discover)
+		return -ENOTSUP;
 
-	return true;
+	return device->ops->discover(device, func, user_data, destroy);
 }
 
 int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
@@ -1582,6 +1418,185 @@ static void service_create_shared_data_free(gpointer user_data)
 	l_free(data);
 }
 
+static struct qmi_request *find_control_request(struct qmi_device *device,
+						uint16_t tid)
+{
+	struct qmi_request *req = NULL;
+	unsigned int _tid = tid;
+
+	if (_tid != 0) {
+		req = l_queue_remove_if(device->req_queue, __request_compare,
+						L_UINT_TO_PTR(_tid));
+
+		if (!req)
+			req = l_queue_remove_if(device->control_queue,
+							__request_compare,
+							L_UINT_TO_PTR(_tid));
+	}
+
+	return req;
+}
+
+static void qmux_discover_callback(uint16_t message, uint16_t length,
+					const void *buffer, void *user_data)
+{
+	struct discover_data *data = user_data;
+	struct qmi_device *device = data->device;
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
+	const struct qmi_result_code *result_code;
+	const struct qmi_service_list *service_list;
+	const void *ptr;
+	uint16_t len;
+	struct qmi_version *list;
+	uint8_t count;
+	unsigned int i;
+
+	count = 0;
+	list = NULL;
+
+	result_code = tlv_get(buffer, length, 0x02, &len);
+	if (!result_code)
+		goto done;
+
+	if (len != QMI_RESULT_CODE_SIZE)
+		goto done;
+
+	service_list = tlv_get(buffer, length, 0x01, &len);
+	if (!service_list)
+		goto done;
+
+	if (len < QMI_SERVICE_LIST_SIZE)
+		goto done;
+
+	list = l_malloc(sizeof(struct qmi_version) * service_list->count);
+
+	for (i = 0; i < service_list->count; i++) {
+		uint16_t major =
+			L_LE16_TO_CPU(service_list->services[i].major);
+		uint16_t minor =
+			L_LE16_TO_CPU(service_list->services[i].minor);
+		uint8_t type = service_list->services[i].type;
+		const char *name = __service_type_to_string(type);
+
+		if (name)
+			__debug_device(device, "found service [%s %d.%d]",
+					name, major, minor);
+		else
+			__debug_device(device, "found service [%d %d.%d]",
+					type, major, minor);
+
+		if (type == QMI_SERVICE_CONTROL) {
+			qmux->control_major = major;
+			qmux->control_minor = minor;
+			continue;
+		}
+
+		list[count].type = type;
+		list[count].major = major;
+		list[count].minor = minor;
+		list[count].name = name;
+
+		count++;
+	}
+
+	ptr = tlv_get(buffer, length, 0x10, &len);
+	if (!ptr)
+		goto done;
+
+	qmux->version_str = l_strndup(ptr + 1, *((uint8_t *) ptr));
+	__debug_device(device, "version string: %s", qmux->version_str);
+
+done:
+	device->version_list = list;
+	device->version_count = count;
+
+	/* if the device support the QMI call SYNC over the CTL interface */
+	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
+			qmux->control_major > 1) {
+		qmi_device_sync(data->device, data);
+		return;
+	}
+
+	if (data->func)
+		data->func(data->user_data);
+
+	__qmi_device_discovery_complete(data->device, &data->super);
+}
+
+static void qmux_discover_reply_idle(struct l_idle *idle, void *user_data)
+{
+	struct discover_data *data = user_data;
+	struct qmi_device *device = data->device;
+
+	l_idle_remove(data->idle);
+	data->idle = NULL;
+
+	if (data->func)
+		data->func(data->user_data);
+
+	__qmi_device_discovery_complete(device, &data->super);
+}
+
+static void qmux_discover_reply_timeout(struct l_timeout *timeout,
+							void *user_data)
+{
+	struct discover_data *data = user_data;
+	struct qmi_device *device = data->device;
+	struct qmi_request *req;
+
+	l_timeout_remove(data->timeout);
+	data->timeout = NULL;
+
+	/* remove request from queues */
+	req = find_control_request(device, data->tid);
+
+	if (data->func)
+		data->func(data->user_data);
+
+	__qmi_device_discovery_complete(device, &data->super);
+
+	if (req)
+		__request_free(req);
+}
+
+static int qmi_device_qmux_discover(struct qmi_device *device,
+					qmi_discover_func_t func,
+					void *user_data,
+					qmi_destroy_func_t destroy)
+{
+	struct discover_data *data;
+	struct qmi_request *req;
+
+	__debug_device(device, "device %p discover", device);
+
+	data = l_new(struct discover_data, 1);
+
+	data->super.destroy = discover_data_free;
+	data->device = device;
+	data->func = func;
+	data->user_data = user_data;
+	data->destroy = destroy;
+
+	if (device->version_list) {
+		data->idle = l_idle_create(qmux_discover_reply_idle, data, NULL);
+		__qmi_device_discovery_started(device, &data->super);
+		return 0;
+	}
+
+	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+			QMI_CTL_GET_VERSION_INFO,
+			NULL, 0, qmux_discover_callback, data);
+
+	data->tid = __request_submit(device, req);
+	data->timeout = l_timeout_create(5, qmux_discover_reply_timeout,
+								data, NULL);
+
+	__qmi_device_discovery_started(device, &data->super);
+
+	return 0;
+}
+
 struct qmux_client_create_data {
 	struct discovery super;
 	struct qmi_device *device;
@@ -1841,6 +1856,7 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 }
 
 static const struct qmi_device_ops qmux_ops = {
+	.discover = qmi_device_qmux_discover,
 	.client_create = qmi_device_qmux_client_create,
 	.client_release = qmi_device_qmux_client_release,
 	.shutdown = qmi_device_qmux_shutdown,
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index ef2140faad9c..6a3d3415dd35 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -86,7 +86,7 @@ void qmi_device_free(struct qmi_device *device);
 void qmi_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data);
 
-bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
+int qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
-- 
2.43.0

