Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAE1A0AF5
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391203; cv=none; b=b+pcXQhaC5/5OPQDukDypPBT6V7s4Yyte3zbqZ03Hcw7FyKBSCfybIcqQ4Qe2mQOPHtNEWjTjX6LFHbyrNUkfqXC1apt95mFx0cPCUYvtW5NQ9ae2Qxvm5gbUqJdPVJzk+BB7+WtHZYHFe6eGghe7hUcJz+Lxej8dHvmlpgenpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391203; c=relaxed/simple;
	bh=ZJxt1JkN3G3NHq/Fc8wZAVKaIQoi2Pl08EGPBCj2768=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XykL2L0YMLV7wZ6wZHVk+MNJ7tiJCZ5YMBNipnLmkF7qy47F6PJ3ssL05Z4pzXVXYwjrtWjrqfbZetbI9OBLQz64/BJHMlvTm3IwPx0dXTSeAIxQBoCr1MwlfGM6ABXP4gCcabvpReto3zkUV4erc/0LVye/Tnsl3gjnetY4lRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdvP/v6S; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdvP/v6S"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f9398390fcso876075a34.3
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391201; x=1718996001; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5X0oV+jFH7Tq49MDbeHyB5hDlVv1wpG74hFAgCd7+E=;
        b=PdvP/v6SeoYEm5q5r9LtTaHRlS/L3bn/wZsj9Of91vW0RUnsHKtYlO/6i2xa9WF8Av
         eyc5892YUk1/7UMzrADB1BGfyw8vKoeEEcaNYzbmdIx3ZPzX4Gf12r0R2xaB574OXM+Y
         w//QI/kk+QW5hwDBIZFI2CX450ny7lB8JGmssiBDnZ0a2EQdg9b4BUtJ/m9O+sOyaGwQ
         0MtF9lh4gZaSlPBGEYoiz+NCZauEoHnzzxMEWTjJGK55mjwYRahQxNFKYFHRtgtgqURn
         CTvE7qQISWPzy7aOu+JNX1/JH9z0Qq9aiFe/bN7Y3aHmPfnJsrY597ECyJAs4O45g3mp
         f1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391201; x=1718996001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5X0oV+jFH7Tq49MDbeHyB5hDlVv1wpG74hFAgCd7+E=;
        b=Pmk1kXu2xGYiL+1u8WjINUYTAlKKr4YPo599IHGkXJ3YTepBig8VELwXvJCYc1Ip3w
         h0aMcD0lHkSeLdH0z5uO0Z4A9McWbmTRHx/lfzO749UctxQJcLkVTOcoVsiEESZbGDVX
         cS9CBPLfiydE2ufDSc9P5UenqsEXft3DE4YfS/4Qq5jLg69j7zRU4Pi/T2DIYsn+yI9X
         yuljJs6+j72z53ilAdUKGmoI8CzlPHyiJnbedY8ivmzftLHfNd7S20YSqcw4aIPiYCQb
         ZSGlLdW/jUthHYl6DIF6cUvnBKEnKhDxuZU0AO+/biW9pzSZ6ZAiywMnPHZCjl4rn8il
         0XNg==
X-Gm-Message-State: AOJu0YzNV/XsvaT2Y+/n23eMjiaA0zVy2v4twbIRCygVWM10heTWoe+v
	ppqRL83/j1xDzvh9e0VYLLOSVRf2yc1Lsbxdobtfy6eo6Hv/5rB++xALrQ==
X-Google-Smtp-Source: AGHT+IEdwRQkePNcjVE6WNoL/2/i6k1nX5pwF4ekCtMQJ+brQqFV2nN5JfeS1RZoXYKGP+eT4EiNIA==
X-Received: by 2002:a05:6870:c095:b0:254:7cd4:9092 with SMTP id 586e51a60fabf-258428eb176mr3626675fac.20.1718391200636;
        Fri, 14 Jun 2024 11:53:20 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:20 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 24/27] qmi: Rename and refactor qmi_device_discover
Date: Fri, 14 Jun 2024 13:52:36 -0500
Message-ID: <20240614185300.1086701-24-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614185300.1086701-1-denkenz@gmail.com>
References: <20240614185300.1086701-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the discover implementation to not use struct discover_data
or the discovery queue.  Use a dedicated 'discover' structure instead.
Remove the now unused discover() method from qmi_device_ops.
---
 drivers/qmimodem/qmi.c | 152 ++++++++++++++++-------------------------
 drivers/qmimodem/qmi.h |   7 +-
 plugins/gobi.c         |   5 +-
 3 files changed, 65 insertions(+), 99 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 306ca6092e5c..5576c520bb08 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -65,9 +65,6 @@ struct qmi_request {
 
 struct qmi_device_ops {
 	int (*write)(struct qmi_device *device, struct qmi_request *req);
-	int (*discover)(struct qmi_device *device,
-			qmi_discover_func_t discover_func,
-			void *user, qmi_destroy_func_t destroy);
 	void (*client_release)(struct qmi_device *device,
 				uint16_t service_type, uint16_t client_id);
 	int (*shutdown)(struct qmi_device *device,
@@ -105,6 +102,13 @@ struct qmi_device_qmux {
 	qmi_destroy_func_t shutdown_destroy;
 	struct l_idle *shutdown_idle;
 	unsigned int release_users;
+	struct {
+		qmi_qmux_device_discover_func_t func;
+		void *user_data;
+		qmi_destroy_func_t destroy;
+		struct l_timeout *timeout;
+		uint16_t tid;
+	} discover;
 	uint8_t next_control_tid;
 	struct l_queue *control_queue;
 	bool shutting_down : 1;
@@ -981,41 +985,6 @@ bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type)
 	return __find_service_info_by_type(device, type);
 }
 
-struct discover_data {
-	struct discovery super;
-	struct qmi_device *device;
-	qmi_discover_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
-	uint16_t tid;
-	struct l_timeout *timeout;
-};
-
-static void discover_data_free(void *user_data)
-{
-	struct discover_data *data = user_data;
-
-	if (data->timeout)
-		l_timeout_remove(data->timeout);
-
-	if (data->destroy)
-		data->destroy(data->user_data);
-
-	l_free(data);
-}
-
-int qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
-				void *user_data, qmi_destroy_func_t destroy)
-{
-	if (!device)
-		return -EINVAL;
-
-	if (!device->ops->discover)
-		return -ENOTSUP;
-
-	return device->ops->discover(device, func, user_data, destroy);
-}
-
 int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
@@ -1255,37 +1224,31 @@ static struct qmi_request *find_control_request(struct qmi_device_qmux *qmux,
 	return req;
 }
 
-static void qmux_sync_callback(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data)
+static void __qmux_discovery_finished(struct qmi_device_qmux *qmux)
 {
-	struct discover_data *data = user_data;
+	l_timeout_remove(qmux->discover.timeout);
+	qmux->discover.func(qmux->discover.user_data);
 
-	DISCOVERY_DONE(data, data->user_data);
-}
+	if (qmux->discover.destroy)
+		qmux->discover.destroy(qmux->discover.user_data);
 
-/* sync will release all previous clients */
-static bool qmi_device_qmux_sync(struct qmi_device_qmux *qmux,
-					struct discover_data *data)
-{
-	struct qmi_request *req;
-
-	DEBUG(&qmux->debug, "Sending sync to reset QMI");
+	memset(&qmux->discover, 0, sizeof(qmux->discover));
+}
 
-	req = __control_request_alloc(QMI_CTL_SYNC, NULL, 0,
-					qmux_sync_callback, data);
 
-	__ctl_request_submit(qmux, req);
+static void qmux_sync_callback(uint16_t message, uint16_t length,
+					const void *buffer, void *user_data)
+{
+	struct qmi_device_qmux *qmux = user_data;
 
-	return true;
+	__qmux_discovery_finished(qmux);
 }
 
 static void qmux_discover_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
-	struct discover_data *data = user_data;
-	struct qmi_device *device = data->device;
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
+	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_device *device = &qmux->super;
 	const struct qmi_result_code *result_code;
 	const struct qmi_service_list *service_list;
 	const void *ptr;
@@ -1344,69 +1307,68 @@ static void qmux_discover_callback(uint16_t message, uint16_t length,
 	DEBUG(&qmux->debug, "version string: %s", qmux->version_str);
 
 done:
-	/* if the device support the QMI call SYNC over the CTL interface */
+	/*
+	 * If the device support the QMI call SYNC over the CTL interface,
+	 * invoke it to reset the state, including release all previously
+	 * allocated clients
+	 */
 	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
 			qmux->control_major > 1) {
-		qmi_device_qmux_sync(qmux, data);
+		struct qmi_request *req =
+			__control_request_alloc(QMI_CTL_SYNC, NULL, 0,
+						qmux_sync_callback, qmux);
+
+		DEBUG(&qmux->debug, "Sending sync to reset QMI");
+		qmux->discover.tid = __ctl_request_submit(qmux, req);
 		return;
 	}
 
-	DISCOVERY_DONE(data, data->user_data);
+	__qmux_discovery_finished(qmux);
 }
 
 static void qmux_discover_reply_timeout(struct l_timeout *timeout,
 							void *user_data)
 {
-	struct discover_data *data = user_data;
-	struct qmi_device *device = data->device;
+	struct qmi_device *device = user_data;
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 	struct qmi_request *req;
 
-	l_timeout_remove(data->timeout);
-	data->timeout = NULL;
-
 	/* remove request from queues */
-	req = find_control_request(qmux, data->tid);
-
-	DISCOVERY_DONE(data, data->user_data);
-
+	req = find_control_request(qmux, qmux->discover.tid);
 	if (req)
 		__request_free(req);
+
+	__qmux_discovery_finished(qmux);
 }
 
-static int qmi_device_qmux_discover(struct qmi_device *device,
-					qmi_discover_func_t func,
-					void *user_data,
-					qmi_destroy_func_t destroy)
+int qmi_qmux_device_discover(struct qmi_device *device,
+				qmi_qmux_device_discover_func_t func,
+				void *user_data, qmi_destroy_func_t destroy)
 {
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
-	struct discover_data *data;
+	struct qmi_device_qmux *qmux;
 	struct qmi_request *req;
 
-	DEBUG(&qmux->debug, "device %p", qmux);
+	if (!device)
+		return -EINVAL;
 
-	if (l_queue_length(device->service_infos) > 0)
-		return -EALREADY;
+	qmux = l_container_of(device, struct qmi_device_qmux, super);
 
-	data = l_new(struct discover_data, 1);
+	DEBUG(&qmux->debug, "device %p", qmux);
 
-	data->super.destroy = discover_data_free;
-	data->device = device;
-	data->func = func;
-	data->user_data = user_data;
-	data->destroy = destroy;
+	if (l_queue_length(device->service_infos) > 0 || qmux->discover.tid)
+		return -EALREADY;
 
 	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0,
-						qmux_discover_callback, data);
+						qmux_discover_callback, qmux);
 
-	data->tid = __ctl_request_submit(qmux, req);
-	data->timeout = l_timeout_create(DISCOVER_TIMEOUT,
-						qmux_discover_reply_timeout,
-						data, NULL);
-
-	__qmi_device_discovery_started(device, &data->super);
+	qmux->discover.func = func;
+	qmux->discover.user_data = user_data;
+	qmux->discover.destroy = destroy;
+	qmux->discover.tid = __ctl_request_submit(qmux, req);
+	qmux->discover.timeout =
+		l_timeout_create(DISCOVER_TIMEOUT, qmux_discover_reply_timeout,
+						qmux, NULL);
 
 	return 0;
 }
@@ -1593,6 +1555,9 @@ static void __qmux_device_free(struct qmi_device_qmux *qmux)
 {
 	l_queue_destroy(qmux->control_queue, __request_free);
 
+	if (qmux->discover.destroy)
+		qmux->discover.destroy(qmux->discover.user_data);
+
 	if (qmux->shutdown_idle)
 		l_idle_remove(qmux->shutdown_idle);
 
@@ -1658,7 +1623,6 @@ static int qmi_device_qmux_shutdown(struct qmi_device *device,
 
 static const struct qmi_device_ops qmux_ops = {
 	.write = qmi_device_qmux_write,
-	.discover = qmi_device_qmux_discover,
 	.client_release = qmi_device_qmux_client_release,
 	.shutdown = qmi_device_qmux_shutdown,
 };
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 702e8c5006b5..e5c99ab8b674 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -58,7 +58,7 @@ struct qmi_service;
 
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
-typedef void (*qmi_discover_func_t)(void *user_data);
+typedef void (*qmi_qmux_device_discover_func_t)(void *user_data);
 typedef void (*qmi_qmux_device_create_client_func_t)(struct qmi_service *,
 							void *);
 typedef void (*qmi_qrtr_node_lookup_done_func_t)(void *);
@@ -69,6 +69,9 @@ struct qmi_device *qmi_qmux_device_new(const char *device);
 void qmi_qmux_device_free(struct qmi_device *device);
 void qmi_qmux_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data);
+int qmi_qmux_device_discover(struct qmi_device *device,
+				qmi_qmux_device_discover_func_t func,
+				void *user_data, qmi_destroy_func_t destroy);
 bool qmi_qmux_device_create_client(struct qmi_device *device,
 				uint16_t service_type,
 				qmi_qmux_device_create_client_func_t func,
@@ -78,8 +81,6 @@ bool qmi_qmux_device_get_service_version(struct qmi_device *device,
 					uint16_t *major, uint16_t *minor);
 bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type);
 
-int qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
-				void *user_data, qmi_destroy_func_t destroy);
 int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 9c44c887b08d..483495972843 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -499,7 +499,8 @@ static void discover_cb(void *user_data)
 
 	if (!(data->features & GOBI_DMS)) {
 		if (++data->discover_attempts < 3 &&
-				!qmi_device_discover(data->device, discover_cb,
+				!qmi_qmux_device_discover(data->device,
+								discover_cb,
 								modem, NULL))
 			return;
 
@@ -544,7 +545,7 @@ static int gobi_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_QMI_DEBUG"))
 		qmi_qmux_device_set_debug(data->device, gobi_debug, "QMI: ");
 
-	r = qmi_device_discover(data->device, discover_cb, modem, NULL);
+	r = qmi_qmux_device_discover(data->device, discover_cb, modem, NULL);
 	if (!r)
 		return -EINPROGRESS;
 
-- 
2.45.0

