Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC024403
	for <ofono@lists.linux.dev>; Thu, 15 Sep 2022 20:55:03 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id 29so28755471edv.2
        for <ofono@lists.linux.dev>; Thu, 15 Sep 2022 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=SFkoe8JhNvMp72bpqOmgrTvSUjVveeUEk+nnuG04jRY=;
        b=O562nnjcFMu3nLd2crB+JE7y3h3bMn2aJ05p/CYLNKYzm5TfyQkaCn1WPIQGARXFbk
         ldxZdIhdFkeg2SNM3nidqgO4a3y5WZGlBoJNA98ldBmzOXx9maG1rohln7shUIjqu0sG
         du8cvzN4yZnuchmxf42e9I99B+LzZLanxOJv2Ml122LIhEZ9Y/o+ka+9k5zybYhLMXSi
         EQGMBqUCnb0MyWSEfMraMfelNF9Uy/HGIkOKb9pH8ZQff7MhQyGJmvKwS/FLvcQxpbmb
         6wXnp/AX6xD5GTz/r+kfJ7EPaCfp9RtNe7eFb24iQDlrBKH7mx9UEbhJYogb4RryvhdV
         Y9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SFkoe8JhNvMp72bpqOmgrTvSUjVveeUEk+nnuG04jRY=;
        b=aI8MfXrXm8xskdG6XyjJkb3SUeoMOnqyNQJqm+L1lH+fcBZmeW2+zqyQEGatGFdc+d
         22sCWUei9CO+cZUqoPuMtyU4hN7h5Ngh4YAzyPAoZnogLTEADaLTg8EpqiJXZU7UPYJw
         JamxEI/gH6FjOr2yYJ0GjK0rZl8yYGwdsf3XRJvatFwAZl00dDL4mKbrcli1KFkN4a1w
         0Z/Pxf7XQmMKDDu+ti82ppFIgopzrTlYxrTdZLV5iO3Ov1WeEoyk/x1zQhIi+CsRkNvK
         /dmvKZusMSTSfvTgdtCwyn5vWKhYqklHX5x2rezrZI6kb71OqlKxShiLfaPOvRTdQmZm
         0xNQ==
X-Gm-Message-State: ACrzQf0L7xmL815eYEK/e7iHBn63Ydfl2ZKSj7bTqaT8ftwvGSB0oXX2
	5lb55SyL30bsxbR2q9BDEVp7zti4DJiwyg==
X-Google-Smtp-Source: AMsMyM5XCWdnElTIhxDY9YAAf18+XIMXp7MZJU6ltWWSrxp5Qq2Toh/wZGoOYRsHXdD5wU6SELK/uQ==
X-Received: by 2002:a05:6402:50d4:b0:451:bf26:8c41 with SMTP id h20-20020a05640250d400b00451bf268c41mr1382671edb.219.1663275301555;
        Thu, 15 Sep 2022 13:55:01 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b0074182109623sm9519424ejh.39.2022.09.15.13.55.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Sep 2022 13:55:01 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: merlijn@wizzup.org,
	tony@atomide.com,
	pavel@ucw.cz,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/2] qmimodem: Fix shared service creation logic
Date: Thu, 15 Sep 2022 23:54:35 +0300
Message-Id: <1663275275-19800-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1663275275-19800-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1663275275-19800-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

qmi_service_create_shared() tries to find already created service of the
same type and if it fails to find one, start a creation of a new service.
This creation takes some time, so if while it is not complete, any new
calls to qmi_service_create_shared() will still fail to find a service of
that type and will start creation. This can easily lead to client ids
exhaustion and service creation failures.

Fix that by adding logic that delays responses to any shared service
creation requests after the first one, until that request either fails or
succeeds.
---
 drivers/qmimodem/qmi.c | 132 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 35 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index fc4534a..d2d1bce 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -260,6 +260,10 @@ static gboolean __service_compare_shared(gpointer key, gpointer value,
 	struct qmi_service *service = value;
 	uint8_t type = GPOINTER_TO_UINT(user_data);
 
+	/* ignore those that are in process of creation */
+	if (GPOINTER_TO_UINT(key) & 0x80000000)
+		return FALSE;
+
 	if (service->type == type)
 		return TRUE;
 
@@ -736,6 +740,10 @@ static void service_notify(gpointer key, gpointer value, gpointer user_data)
 	struct qmi_result *result = user_data;
 	GList *list;
 
+	/* ignore those that are in process of creation */
+	if (GPOINTER_TO_UINT(key) & 0x80000000)
+		return;
+
 	for (list = g_list_first(service->notify_list); list;
 						list = g_list_next(list)) {
 		struct qmi_notify *notify = list->data;
@@ -1967,12 +1975,58 @@ static void service_create_data_free(gpointer user_data)
 	g_free(data);
 }
 
+struct service_create_shared_data {
+	struct discovery super;
+	struct qmi_service *service;
+	struct qmi_device *device;
+	qmi_create_func_t func;
+	void *user_data;
+	qmi_destroy_func_t destroy;
+	guint timeout;
+};
+
+static gboolean service_create_shared_reply(gpointer user_data)
+{
+	struct service_create_shared_data *data = user_data;
+
+	data->timeout = 0;
+	data->func(data->service, data->user_data);
+
+	__qmi_device_discovery_complete(data->device, &data->super);
+
+	return FALSE;
+}
+
+static void service_create_shared_pending_reply(struct qmi_device *device,
+						unsigned int type,
+						struct qmi_service *service)
+{
+	gpointer key = GUINT_TO_POINTER(type | 0x80000000);
+	GList **shared = g_hash_table_lookup(device->service_list, key);
+	GList *l;
+
+	g_hash_table_steal(device->service_list, key);
+
+	for (l = *shared; l; l = l->next) {
+		struct service_create_shared_data *shared_data = l->data;
+
+		shared_data->service = qmi_service_ref(service);
+		shared_data->timeout = g_timeout_add(
+				0, service_create_shared_reply, shared_data);
+	}
+
+	g_list_free(*shared);
+	g_free(shared);
+}
+
 static gboolean service_create_reply(gpointer user_data)
 {
 	struct service_create_data *data = user_data;
 	struct qmi_device *device = data->device;
 	struct qmi_request *req;
 
+	service_create_shared_pending_reply(device, data->type, NULL);
+
 	/* remove request from queues */
 	req = find_control_request(device, data->tid);
 
@@ -2039,6 +2093,8 @@ static void service_create_callback(uint16_t message, uint16_t length,
 				GUINT_TO_POINTER(hash_id), service);
 
 done:
+	service_create_shared_pending_reply(device, data->type, service);
+
 	data->func(service, data->user_data);
 	qmi_service_unref(service);
 
@@ -2052,14 +2108,22 @@ static bool service_create(struct qmi_device *device,
 	struct service_create_data *data;
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, type };
 	struct qmi_request *req;
+	GList **shared;
+	unsigned int type_val = type;
 	int i;
 
-	data = g_try_new0(struct service_create_data, 1);
-	if (!data)
+	if (!device->version_list)
 		return false;
 
-	if (!device->version_list)
+	shared = g_try_new0(GList *, 1);
+	if (!shared)
+		return NULL;
+
+	data = g_try_new0(struct service_create_data, 1);
+	if (!data) {
+		g_free(shared);
 		return false;
+	}
 
 	data->super.destroy = service_create_data_free;
 	data->device = device;
@@ -2088,19 +2152,13 @@ static bool service_create(struct qmi_device *device,
 
 	__qmi_device_discovery_started(device, &data->super);
 
+	/* Mark service creation as pending */
+	g_hash_table_insert(device->service_list,
+			GUINT_TO_POINTER(type_val | 0x80000000), shared);
+
 	return true;
 }
 
-struct service_create_shared_data {
-	struct discovery super;
-	struct qmi_service *service;
-	struct qmi_device *device;
-	qmi_create_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
-	guint timeout;
-};
-
 static void service_create_shared_data_free(gpointer user_data)
 {
 	struct service_create_shared_data *data = user_data;
@@ -2118,23 +2176,11 @@ static void service_create_shared_data_free(gpointer user_data)
 	g_free(data);
 }
 
-static gboolean service_create_shared_reply(gpointer user_data)
-{
-	struct service_create_shared_data *data = user_data;
-
-	data->timeout = 0;
-	data->func(data->service, data->user_data);
-
-	__qmi_device_discovery_complete(data->device, &data->super);
-
-	return FALSE;
-}
-
-bool qmi_service_create_shared(struct qmi_device *device,
-				uint8_t type, qmi_create_func_t func,
-				void *user_data, qmi_destroy_func_t destroy)
+bool qmi_service_create_shared(struct qmi_device *device, uint8_t type,
+			qmi_create_func_t func, void *user_data,
+			qmi_destroy_func_t destroy)
 {
-	struct qmi_service *service;
+	gpointer service;
 	unsigned int type_val = type;
 
 	if (!device || !func)
@@ -2143,27 +2189,43 @@ bool qmi_service_create_shared(struct qmi_device *device,
 	if (type == QMI_SERVICE_CONTROL)
 		return false;
 
-	service = g_hash_table_find(device->service_list,
+	service = g_hash_table_lookup(device->service_list,
+				GUINT_TO_POINTER(type_val | 0x80000000));
+	if (!service) {
+		service = g_hash_table_find(device->service_list,
 			__service_compare_shared, GUINT_TO_POINTER(type_val));
+	} else
+		type_val |= 0x80000000;
+
 	if (service) {
 		struct service_create_shared_data *data;
 
 		data = g_try_new0(struct service_create_shared_data, 1);
 		if (!data)
-			return false;
+			return NULL;
 
 		data->super.destroy = service_create_shared_data_free;
-		data->service = qmi_service_ref(service);
 		data->device = device;
 		data->func = func;
 		data->user_data = user_data;
 		data->destroy = destroy;
 
-		data->timeout = g_timeout_add(0,
-					service_create_shared_reply, data);
+		if (!data)
+			return false;
+
+		if (!(type_val & 0x80000000)) {
+			data->service = qmi_service_ref(service);
+			data->timeout = g_timeout_add(
+					0, service_create_shared_reply, data);
+		} else {
+			GList **l = service;
+
+			*l = g_list_prepend(*l, data);
+		}
+
 		__qmi_device_discovery_started(device, &data->super);
 
-		return 0;
+		return true;
 	}
 
 	return service_create(device, type, func, user_data, destroy);
-- 
1.9.1

