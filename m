Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24915530F
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622131; cv=none; b=NDpc3TrOXdlX2lzXdNP/+uRNbwbFGXmpDDvng/uhFAEBZnjsCVlSR6sUZxZhn0FchbWPaNglyh5k86GTzFUJlx0kLiGv3/D0DEn6cPYm0waXvPoy9FQ+xWbNWItZRwX2bHQ+mOwRi3qw9xCGl8yzjgECWTdYnkTO3Y+gQCxVI6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622131; c=relaxed/simple;
	bh=fUcfvsRDblGXA4HEmBd2kkiiiBnqtKIt4CwdlBoeBE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3UoxrA2K9TCoC5+gyRqeloYdq9xXa9ASVEgPFo2xP2CDDWizXqI092oF37IiF8kVebIkZ5y7r+ldJuYhL9bUJMM0vd5mkGel9CehF6dAbx9EafVe2+ZYlMVromE7qGokyBEkGT/Z+EHDIeJZpKXo1y9NwKKP7evK1g7/njoAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fizf2XAO; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fizf2XAO"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb9d54575cso1337029b6e.2
        for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 09:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622128; x=1709226928; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cZTrmZvewyCz9UPHuMDihzz4/pRGJklgTR2XI0KwI4=;
        b=fizf2XAOM4tXAxTlxWElfZx7+emzlYyNPMywmQ/vYXsix2rgLtsOXZNvXPfqmP/Tgk
         f3TOlOsSkjLi4XvgMTvWMUDVVosVMjk5TLo4jtv4NAs+nEfz3kg9CFb9hvT1dbEjovhC
         LtnwTkvYhrR+UaiC4jvGjE+HBemIwrB7+iktBnybJZIjLkoRDloXs1skz6LyyeTWGwLh
         aa+VRmPBQCTwWEy+RIkpl2iv29S6OlU9BeYjdWRJ2gEEWL3gdI4DhHRhz2VcGp/K1ePK
         s1f+iQ/VXUKyVE7QSpYnbjwaEZ/PpMrDzQyaoI81An2dxVV/EoTVm66WNPVcFjN0PZyM
         CgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622128; x=1709226928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cZTrmZvewyCz9UPHuMDihzz4/pRGJklgTR2XI0KwI4=;
        b=NndAugKCoX+zWCOSm/Bs5/4PDu2JQd5RhoCX2S+LcQ3KLiRy99SV75zvLk6aWxXje4
         NfyiJW7rdWeIsqSDZoJmmOtE6ZJczDK2696rAGfO8794EZkkWn++4/NojfGmkA7riZ2K
         yFHjWyxAN1SAFe/XIjllQvuANSJldGYkkIlg53u3Dq4NPTQ8pXbrU+1Aey3wWmLnEGV7
         9nDiE8OksZigRkyxpwnp0Dsln/ObafXLHiAavCUG9WN16XHwNl3QFZ1cQ7Y1lbNqmn7C
         25M4zUk6izVLciJZwT58cnM1RPX0e6Iruo4QWaRmt7yo6GDUXxFs2P5sObmdllfIfk56
         FTYQ==
X-Gm-Message-State: AOJu0Yz+B0pFngINiPBqI5WHxzKiqFMYTkFjtpJ0J9sNXTokrWk4P451
	yWtH8FCm4Tb+FvJZs7rE41uCVz5uCfyHL7SNatsTQw4raz+y76dwlJinnw8J
X-Google-Smtp-Source: AGHT+IF6zl0Rzo1GX5HU8o0X0mVd3RqBQRC3yVzNObjC0XCL8KGgdDWr2f906PmzS2JSOrfWRZ1zUQ==
X-Received: by 2002:a05:6808:13cd:b0:3c1:7019:ae9b with SMTP id d13-20020a05680813cd00b003c17019ae9bmr6066780oiw.43.1708622127897;
        Thu, 22 Feb 2024 09:15:27 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cc7-20020a056808324700b003c178f6a504sm355898oib.14.2024.02.22.09.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:15:27 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/4] qmi: Introduce client_create driver method
Date: Thu, 22 Feb 2024 11:14:20 -0600
Message-ID: <20240222171438.1291553-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222171438.1291553-1-denkenz@gmail.com>
References: <20240222171438.1291553-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On QMUX, before using a particular QMI service, a client must first be
created.  Client creation is accomplished by sending a specific message
to the control service and waiting for the reply.

On QRTR, no such round trip is required.  A QRTR socket can immediately
access all services by virtue of creating a socket, with each QMI
service allocating an implicit client identifier.

Abstract away the client creation details behind the client_create()
driver method.  Rename the service_create_data structure to
qmux_client_create_data in order to make it clear that this operation is
QMUX specific.
---
 drivers/qmimodem/qmi.c | 450 +++++++++++++++++++++--------------------
 1 file changed, 231 insertions(+), 219 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index b2f0f72190a1..ec7a74778079 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -56,6 +56,10 @@ struct qmi_version {
 };
 
 struct qmi_device_ops {
+	int (*client_create)(struct qmi_device *device,
+				uint16_t service_type,
+				qmi_create_func_t func,
+				void *user, qmi_destroy_func_t destroy);
 	void (*client_release)(struct qmi_device *device,
 				uint16_t service_type, uint16_t client_id);
 	int (*shutdown)(struct qmi_device *device,
@@ -1522,6 +1526,226 @@ done:
 	return res;
 }
 
+struct service_create_shared_data {
+	struct discovery super;
+	struct qmi_service *service;
+	struct qmi_device *device;
+	qmi_create_func_t func;
+	void *user_data;
+	qmi_destroy_func_t destroy;
+	struct l_idle *idle;
+};
+
+static void service_create_shared_reply(struct l_idle *idle, void *user_data)
+{
+	struct service_create_shared_data *data = user_data;
+
+	l_idle_remove(data->idle);
+	data->idle = NULL;
+	data->func(data->service, data->user_data);
+
+	__qmi_device_discovery_complete(data->device, &data->super);
+}
+
+static void service_create_shared_pending_reply(struct qmi_device *device,
+						unsigned int type,
+						struct qmi_service *service)
+{
+	gpointer key = L_UINT_TO_PTR(type | 0x80000000);
+	GList **shared = l_hashmap_remove(device->service_list, key);
+	GList *l;
+
+	for (l = *shared; l; l = l->next) {
+		struct service_create_shared_data *shared_data = l->data;
+
+		shared_data->service = qmi_service_ref(service);
+		shared_data->idle = l_idle_create(service_create_shared_reply,
+							shared_data, NULL);
+	}
+
+	g_list_free(*shared);
+	l_free(shared);
+}
+
+static void service_create_shared_data_free(gpointer user_data)
+{
+	struct service_create_shared_data *data = user_data;
+
+	if (data->idle)
+		l_idle_remove(data->idle);
+
+	qmi_service_unref(data->service);
+
+	if (data->destroy)
+		data->destroy(data->user_data);
+
+	l_free(data);
+}
+
+struct qmux_client_create_data {
+	struct discovery super;
+	struct qmi_device *device;
+	uint8_t type;
+	uint16_t major;
+	uint16_t minor;
+	qmi_create_func_t func;
+	void *user_data;
+	qmi_destroy_func_t destroy;
+	struct l_timeout *timeout;
+	uint16_t tid;
+};
+
+static void qmux_client_create_data_free(gpointer user_data)
+{
+	struct qmux_client_create_data *data = user_data;
+
+	if (data->timeout)
+		l_timeout_remove(data->timeout);
+
+	if (data->destroy)
+		data->destroy(data->user_data);
+
+	l_free(data);
+}
+
+static void qmux_client_create_reply(struct l_timeout *timeout, void *user_data)
+{
+	struct qmux_client_create_data *data = user_data;
+	struct qmi_device *device = data->device;
+	struct qmi_request *req;
+
+	DBG("");
+
+	service_create_shared_pending_reply(device, data->type, NULL);
+
+	/* remove request from queues */
+	req = find_control_request(device, data->tid);
+
+	l_timeout_remove(data->timeout);
+	data->timeout = NULL;
+
+	if (data->func)
+		data->func(NULL, data->user_data);
+
+	__qmi_device_discovery_complete(device, &data->super);
+
+	if (req)
+		__request_free(req);
+}
+
+static void qmux_client_create_callback(uint16_t message, uint16_t length,
+					const void *buffer, void *user_data)
+{
+	struct qmux_client_create_data *data = user_data;
+	struct qmi_device *device = data->device;
+	struct qmi_service *service = NULL;
+	struct qmi_service *old_service = NULL;
+	const struct qmi_result_code *result_code;
+	const struct qmi_client_id *client_id;
+	uint16_t len;
+	unsigned int hash_id;
+
+	result_code = tlv_get(buffer, length, 0x02, &len);
+	if (!result_code)
+		goto done;
+
+	if (len != QMI_RESULT_CODE_SIZE)
+		goto done;
+
+	client_id = tlv_get(buffer, length, 0x01, &len);
+	if (!client_id)
+		goto done;
+
+	if (len != QMI_CLIENT_ID_SIZE)
+		goto done;
+
+	if (client_id->service != data->type)
+		goto done;
+
+	service = l_new(struct qmi_service, 1);
+
+	service->ref_count = 1;
+	service->device = data->device;
+
+	service->type = data->type;
+	service->major = data->major;
+	service->minor = data->minor;
+
+	service->client_id = client_id->client;
+
+	__debug_device(device, "service created [client=%d,type=%d]",
+					service->client_id, service->type);
+
+	hash_id = service->type | (service->client_id << 8);
+
+	l_hashmap_replace(device->service_list, L_UINT_TO_PTR(hash_id),
+				service, (void **) &old_service);
+
+	if (old_service)
+		service_destroy(old_service);
+
+done:
+	service_create_shared_pending_reply(device, data->type, service);
+
+	data->func(service, data->user_data);
+	qmi_service_unref(service);
+
+	__qmi_device_discovery_complete(data->device, &data->super);
+}
+
+static int qmi_device_qmux_client_create(struct qmi_device *device,
+					uint16_t service_type,
+					qmi_create_func_t func, void *user_data,
+					qmi_destroy_func_t destroy)
+{
+	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
+	struct qmi_request *req;
+	struct qmux_client_create_data *data;
+	GList **shared;
+	unsigned int type_val = service_type;
+	int i;
+
+	if (!device->version_list)
+		return -ENOENT;
+
+	shared = l_new(GList *, 1);
+	data = l_new(struct qmux_client_create_data, 1);
+
+	data->super.destroy = qmux_client_create_data_free;
+	data->device = device;
+	data->type = service_type;
+	data->func = func;
+	data->user_data = user_data;
+	data->destroy = destroy;
+
+	__debug_device(device, "service create [type=%d]", service_type);
+
+	for (i = 0; i < device->version_count; i++) {
+		if (device->version_list[i].type == data->type) {
+			data->major = device->version_list[i].major;
+			data->minor = device->version_list[i].minor;
+			break;
+		}
+	}
+
+	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+			QMI_CTL_GET_CLIENT_ID,
+			client_req, sizeof(client_req),
+			qmux_client_create_callback, data);
+
+	data->tid = __request_submit(device, req);
+	data->timeout = l_timeout_create(8, qmux_client_create_reply,
+								data, NULL);
+
+	__qmi_device_discovery_started(device, &data->super);
+
+	/* Mark service creation as pending */
+	l_hashmap_insert(device->service_list,
+			L_UINT_TO_PTR(type_val | 0x80000000), shared);
+
+	return 0;
+}
+
 static void qmux_client_release_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
@@ -1617,6 +1841,7 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 }
 
 static const struct qmi_device_ops qmux_ops = {
+	.client_create = qmi_device_qmux_client_create,
 	.client_release = qmi_device_qmux_client_release,
 	.shutdown = qmi_device_qmux_shutdown,
 	.destroy = qmi_device_qmux_destroy,
@@ -1920,224 +2145,6 @@ bool qmi_result_get_uint64(struct qmi_result *result, uint8_t type,
 	return true;
 }
 
-struct service_create_data {
-	struct discovery super;
-	struct qmi_device *device;
-	uint8_t type;
-	uint16_t major;
-	uint16_t minor;
-	qmi_create_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
-	struct l_timeout *timeout;
-	uint16_t tid;
-};
-
-static void service_create_data_free(gpointer user_data)
-{
-	struct service_create_data *data = user_data;
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
-struct service_create_shared_data {
-	struct discovery super;
-	struct qmi_service *service;
-	struct qmi_device *device;
-	qmi_create_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
-	struct l_idle *idle;
-};
-
-static void service_create_shared_reply(struct l_idle *idle, void *user_data)
-{
-	struct service_create_shared_data *data = user_data;
-
-	l_idle_remove(data->idle);
-	data->idle = NULL;
-	data->func(data->service, data->user_data);
-
-	__qmi_device_discovery_complete(data->device, &data->super);
-}
-
-static void service_create_shared_pending_reply(struct qmi_device *device,
-						unsigned int type,
-						struct qmi_service *service)
-{
-	gpointer key = L_UINT_TO_PTR(type | 0x80000000);
-	GList **shared = l_hashmap_remove(device->service_list, key);
-	GList *l;
-
-	for (l = *shared; l; l = l->next) {
-		struct service_create_shared_data *shared_data = l->data;
-
-		shared_data->service = qmi_service_ref(service);
-		shared_data->idle = l_idle_create(service_create_shared_reply,
-							shared_data, NULL);
-	}
-
-	g_list_free(*shared);
-	l_free(shared);
-}
-
-static void service_create_reply(struct l_timeout *timeout, void *user_data)
-{
-	struct service_create_data *data = user_data;
-	struct qmi_device *device = data->device;
-	struct qmi_request *req;
-
-	DBG("");
-
-	service_create_shared_pending_reply(device, data->type, NULL);
-
-	/* remove request from queues */
-	req = find_control_request(device, data->tid);
-
-	l_timeout_remove(data->timeout);
-	data->timeout = NULL;
-
-	if (data->func)
-		data->func(NULL, data->user_data);
-
-	__qmi_device_discovery_complete(device, &data->super);
-
-	if (req)
-		__request_free(req);
-}
-
-static void service_create_callback(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data)
-{
-	struct service_create_data *data = user_data;
-	struct qmi_device *device = data->device;
-	struct qmi_service *service = NULL;
-	struct qmi_service *old_service = NULL;
-	const struct qmi_result_code *result_code;
-	const struct qmi_client_id *client_id;
-	uint16_t len;
-	unsigned int hash_id;
-
-	result_code = tlv_get(buffer, length, 0x02, &len);
-	if (!result_code)
-		goto done;
-
-	if (len != QMI_RESULT_CODE_SIZE)
-		goto done;
-
-	client_id = tlv_get(buffer, length, 0x01, &len);
-	if (!client_id)
-		goto done;
-
-	if (len != QMI_CLIENT_ID_SIZE)
-		goto done;
-
-	if (client_id->service != data->type)
-		goto done;
-
-	service = l_new(struct qmi_service, 1);
-
-	service->ref_count = 1;
-	service->device = data->device;
-
-	service->type = data->type;
-	service->major = data->major;
-	service->minor = data->minor;
-
-	service->client_id = client_id->client;
-
-	__debug_device(device, "service created [client=%d,type=%d]",
-					service->client_id, service->type);
-
-	hash_id = service->type | (service->client_id << 8);
-
-	l_hashmap_replace(device->service_list, L_UINT_TO_PTR(hash_id),
-				service, (void **) &old_service);
-
-	if (old_service)
-		service_destroy(old_service);
-
-done:
-	service_create_shared_pending_reply(device, data->type, service);
-
-	data->func(service, data->user_data);
-	qmi_service_unref(service);
-
-	__qmi_device_discovery_complete(data->device, &data->super);
-}
-
-static bool service_create(struct qmi_device *device,
-				uint8_t type, qmi_create_func_t func,
-				void *user_data, qmi_destroy_func_t destroy)
-{
-	struct service_create_data *data;
-	unsigned char client_req[] = { 0x01, 0x01, 0x00, type };
-	struct qmi_request *req;
-	GList **shared;
-	unsigned int type_val = type;
-	int i;
-
-	if (!device->version_list)
-		return false;
-
-	shared = l_new(GList *, 1);
-	data = l_new(struct service_create_data, 1);
-
-	data->super.destroy = service_create_data_free;
-	data->device = device;
-	data->type = type;
-	data->func = func;
-	data->user_data = user_data;
-	data->destroy = destroy;
-
-	__debug_device(device, "service create [type=%d]", type);
-
-	for (i = 0; i < device->version_count; i++) {
-		if (device->version_list[i].type == data->type) {
-			data->major = device->version_list[i].major;
-			data->minor = device->version_list[i].minor;
-			break;
-		}
-	}
-
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_GET_CLIENT_ID,
-			client_req, sizeof(client_req),
-			service_create_callback, data);
-
-	data->tid = __request_submit(device, req);
-	data->timeout = l_timeout_create(8, service_create_reply, data, NULL);
-
-	__qmi_device_discovery_started(device, &data->super);
-
-	/* Mark service creation as pending */
-	l_hashmap_insert(device->service_list,
-			L_UINT_TO_PTR(type_val | 0x80000000), shared);
-
-	return true;
-}
-
-static void service_create_shared_data_free(gpointer user_data)
-{
-	struct service_create_shared_data *data = user_data;
-
-	if (data->idle)
-		l_idle_remove(data->idle);
-
-	qmi_service_unref(data->service);
-
-	if (data->destroy)
-		data->destroy(data->user_data);
-
-	l_free(data);
-}
-
 bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			qmi_create_func_t func, void *user_data,
 			qmi_destroy_func_t destroy)
@@ -2145,6 +2152,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	GList **l = NULL;
 	struct qmi_service *service = NULL;
 	unsigned int type_val = type;
+	int r;
 
 	if (!device || !func)
 		return false;
@@ -2195,7 +2203,11 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		return true;
 	}
 
-	return service_create(device, type, func, user_data, destroy);
+	if (!device->ops->client_create)
+		return -ENOTSUP;
+
+	r = device->ops->client_create(device, type, func, user_data, destroy);
+	return r == 0;
 }
 
 bool qmi_service_create(struct qmi_device *device,
-- 
2.43.0

