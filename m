Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91832F27
	for <ofono@lists.linux.dev>; Fri, 16 Sep 2022 09:31:55 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id kr11so2006430ejc.8
        for <ofono@lists.linux.dev>; Fri, 16 Sep 2022 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=zt6KSsxsmYIIeU0Vo54OP4ZAuepdlvlcKxQpkGsO7b4=;
        b=juny+lCjSs7Od9HR2nDSZc7jw6uSY2fn+UhEc3GUH8zndduTxZDeKP1pzlE0JF2Hp+
         54lUtQ8wZJGKS3h3I4BxUYTdzCmIMzqKB8/NRAmVc+a1GE+LWB4v8BjS0OHU61qmyR1O
         c5rPD1TBmyV9apDw6k19NWbCB7pWi+NoNZhaSGOc6SReEdrxpxWAPF5vCU63HItZwt5e
         1kk5gciDVE4MvYhFz3eNhADIRMvQviiIjTii24BrDLdu+OvV0zqS5ddfRnxrvjrCMxn6
         +EAvv3dm9gNP1Bz7irD2blvul7MiW4Q9DhPuyMSZCjyLCCGOvYUq6KfrDlEH4Nt0vudt
         IwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zt6KSsxsmYIIeU0Vo54OP4ZAuepdlvlcKxQpkGsO7b4=;
        b=M12xzF8C4XcIucsiCo8qTVXP2uCj2eGf5Rkc88vqKcVFbyDD8V49axi/z/yUuDW6kK
         cxn877Vtl4myxduM8Gds7UPH5yELVZo/FST4wKB8QEyv7XHHzk6HDwueP+6+hcfbBPii
         cRIFFmCin7zvQRHXnGfl1lWywsKuuSbxEiavbc4T8MpeabifmoWHS3wwyVMk6r4JoqZF
         IdaqjL2n970bK/qHFXe6k7oU5vKZ/u8XSRQGqsODU9ASXbkeMHvlKqXT45trsZfBtYKB
         lN5PaMbil0Q8S68QR1Dzj9mEns7jPwQVgencHOf2gPfmxaD0YVEn4aJtIXap1n4xZXJ2
         oleQ==
X-Gm-Message-State: ACrzQf01DomqmIn6/kjQ87QjkK4a90k0zmPDocc4bPeHdPu7BZt/11lM
	yyO/daAkvC43kNS7C55tMAvmuWpF/uP9mA==
X-Google-Smtp-Source: AMsMyM746+YH27dVh4eOW2KMBm2Hf2lH4+Y8X0h/J8jD/6grJ9MBiBYq8ywfP1v86i2Rwpv4uYUisQ==
X-Received: by 2002:a17:906:4fc4:b0:73d:d4e9:2d6e with SMTP id i4-20020a1709064fc400b0073dd4e92d6emr2944414ejw.165.1663320714149;
        Fri, 16 Sep 2022 02:31:54 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id w15-20020a50fa8f000000b00452bea2a0bfsm4611434edr.44.2022.09.16.02.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:31:53 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: merlijn@wizzup.org,
	tony@atomide.com,
	pavel@ucw.cz,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/2] qmimodem: Fix shared service creation logic
Date: Fri, 16 Sep 2022 12:31:03 +0300
Message-Id: <1663320663-26277-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1663320663-26277-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1663320663-26277-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
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
 drivers/qmimodem/qmi.c | 130 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 34 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index fc4534a..e66e8d8 100644
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
 
@@ -2052,15 +2108,23 @@ static bool service_create(struct qmi_device *device,
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
 		return false;
 
+	data = g_try_new0(struct service_create_data, 1);
+	if (!data) {
+		g_free(shared);
+		return false;
+	}
+
 	data->super.destroy = service_create_data_free;
 	data->device = device;
 	data->type = type;
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
+bool qmi_service_create_shared(struct qmi_device *device, uint8_t type,
+			qmi_create_func_t func, void *user_data,
+			qmi_destroy_func_t destroy)
 {
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
-{
-	struct qmi_service *service;
+	gpointer service;
 	unsigned int type_val = type;
 
 	if (!device || !func)
@@ -2143,8 +2189,14 @@ bool qmi_service_create_shared(struct qmi_device *device,
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
 
@@ -2153,17 +2205,27 @@ bool qmi_service_create_shared(struct qmi_device *device,
 			return false;
 
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

