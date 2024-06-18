Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF916DC2E
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740967; cv=none; b=Tbk7m11LgTZVancXbt0ZvoQN8f37smXnyIheX2Pgd245KAmohf2z6WPDcsSHmgWz60Gq/Jm4LLfaNQDg5mMrfg1j0IGOw4iMzENvtcRtvm01sRjehDxLVnrsxiwCIKXNiXeRyP52+qDHY7mqc4rY0cWG1au0mEmCxvACsCTiHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740967; c=relaxed/simple;
	bh=guMbeyQHTt3Yhsyhs5yd106/04urQkLuDKC+L31Jasw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhNOxTlrZDlO6jjwI8qrmY9SAq99hyEezZXmvygHhnHq5blO60BssdB1WbJ1TXODNOR/hidsZXKb/a53TX14lWSvIJhPyFDmu+zoeDk1kxjtq2gQ+3b+lzM8rt+sqXn3t9wdSiKVQ1R0ls6TKFTJiUUEvGjWOBBe9UVc/+41guQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqC//q9B; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqC//q9B"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-250c0555a63so2892591fac.1
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740965; x=1719345765; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jLKnyWSbEnLm4HoUDKHbHoRajOmpNoERvnKnRZIt6Q=;
        b=lqC//q9BAf1+MvJp4E4AUwBTVVgNLDfKbua4qK3R/4LbZnGdFGijVO1ujQxGTWghIr
         FKXvPwPDIjLB8YanYuFGlx+PQ4ctKUQj5n9huGKoo04upEGsQ+Q97kNZWPSoZhHMzsME
         K+NwNp6LjeTvqXxDGIfJtjVvyTrcw4OGt1pY9YYH3ryikxP+zsj0M1YpADzvt16OhZ7R
         QGIF2mgMc+3fZoD0p0rJ8+J0c/QfJHZkpddC+3qFB5qSQeXbLuvI1EgD+AyDHg+ulL+N
         85Mr+pWP7BatqtHTd3fYG8ZMQGEoLTPStU/9gIgWrHDM1l6mWSvvYH42sTsU1gt3Paij
         y2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740965; x=1719345765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jLKnyWSbEnLm4HoUDKHbHoRajOmpNoERvnKnRZIt6Q=;
        b=QIjnyWlHjUrYZn9HJeu8VsqSBRTv34JCn2e5zadnvtDnatljGn1NTyUECteR89cUrf
         yV6fZu7g91SQXM1PyAYJmgNH7mv4Gr5Zv+nZf9BqbHTzZtvrhWU1mgJ9Xc/11nHyrqdH
         0z8tFV1RV8M8qcGF5zeB62Vt5Awsx9fxmPbAvqgJES9RDQ0kwYsN6/0kNYEzWi7Wf3ug
         St8TTAFpbvakJfqX16YEfYKgAg9J+4Ex29l0iKv8echno0PJj8vpKZ21KuhGXS8oTYxq
         od3QWiUHSUznZ/kdMCl/t9zB8HOsJjxBZeP5XfgurYLevB1hd3qkIKaQHHQOeKPzi1AQ
         NXNw==
X-Gm-Message-State: AOJu0YzEh2xzdsrzQLmOXBOwv8HmzEF5fckcSIJ7jOwEYcOpFetE3jkt
	k7oXCNU/aA2EnXqE41ULziO3A8IdGIEnM8TbGndpLf+jY1prdL6WB+WSdQ==
X-Google-Smtp-Source: AGHT+IF3GCKrOeXrEml124Fg4TeHK9knM5tFlTag5Knqh41H6DdoZMgOSVl3/fHTIsalEsqxLW3ZLA==
X-Received: by 2002:a05:6870:7192:b0:24c:bb91:df59 with SMTP id 586e51a60fabf-25c94a236a1mr857270fac.35.1718740964728;
        Tue, 18 Jun 2024 13:02:44 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:44 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 14/33] qmi: qmux: Make shared service creation generic
Date: Tue, 18 Jun 2024 15:01:56 -0500
Message-ID: <20240618200231.1129282-14-denkenz@gmail.com>
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

The underlying QMUX protocol does not have a concept of a shared or
non-shared service.  Services are accessed via clients, with each client
having its own state tracked by the service implementation.  Some state
is shared amongst all clients.  The shared service concept was local to
the qmi_device implementation, enabling multiple atom drivers to request
a handle to a given service, and for that handle to share the client
service handle at the protocol level.

Services meant to be shared are now created and managed at the modem
driver level.  Services that require a dedicated service client handle
(such as in the case of gprs_context atom driver) will obtain such
handles from the modem driver in the future.

Remove qmi_service_create_shared() API and introduce a QMUX specific
qmux_device_create_client() API in its stead.  The new API will
generically handle creation of new service clients at the QMUX protocol
level.

While here, also remove the now unused client_create method from the
qmi_device_ops structure and rename qmux_client_create_reply() to
qmux_client_create_timeout()
---
 drivers/qmimodem/qmi.c | 233 ++++++++---------------------------------
 drivers/qmimodem/qmi.h |  12 ++-
 plugins/gobi.c         |   6 +-
 3 files changed, 51 insertions(+), 200 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 9fdc209edf7c..89645c1d6704 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -64,10 +64,6 @@ struct qmi_device_ops {
 	int (*discover)(struct qmi_device *device,
 			qmi_discover_func_t discover_func,
 			void *user, qmi_destroy_func_t destroy);
-	int (*client_create)(struct qmi_device *device,
-				uint16_t service_type,
-				qmi_create_func_t func,
-				void *user, qmi_destroy_func_t destroy);
 	void (*client_release)(struct qmi_device *device,
 				uint16_t service_type, uint16_t client_id);
 	int (*shutdown)(struct qmi_device *device,
@@ -106,7 +102,6 @@ struct qmi_device_qmux {
 	unsigned int release_users;
 	uint8_t next_control_tid;
 	struct l_queue *control_queue;
-	struct l_queue *pending_families;
 };
 
 struct service_family {
@@ -1410,17 +1405,6 @@ done:
 	l_free(family);
 }
 
-struct service_create_shared_data {
-	struct discovery super;
-	uint16_t service_type;
-	struct service_family *family;
-	struct qmi_device *device;
-	qmi_create_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
-	struct l_idle *idle;
-};
-
 static uint8_t __ctl_request_submit(struct qmi_device_qmux *qmux,
 					struct qmi_request *req)
 {
@@ -1484,79 +1468,6 @@ static struct qmi_service *service_create(struct service_family *family)
 	return service;
 }
 
-static void service_create_shared_idle_cb(struct l_idle *idle, void *user_data)
-{
-	struct service_create_shared_data *data = user_data;
-	struct qmi_service *service = service_create(data->family);
-
-	DISCOVERY_DONE(data, service, data->user_data);
-}
-
-static void service_create_shared_reply(struct service_create_shared_data *data,
-					struct service_family *family)
-{
-	struct qmi_service *service = NULL;
-
-	if (family)
-		service = service_create(family);
-
-	DISCOVERY_DONE(data, service, data->user_data);
-}
-
-static bool pending_family_match(const void *data, const void *user_data)
-{
-	const struct service_create_shared_data *shared_data = data;
-	uint16_t service_type = L_PTR_TO_UINT(user_data);
-
-	return shared_data->service_type == service_type;
-}
-
-struct pending_family_reply_if_match_info {
-	uint16_t service_type;
-	struct service_family *family;
-};
-
-static bool pending_family_reply_if_match(void *data, void *user_data)
-{
-	struct service_create_shared_data *shared_data = data;
-	const struct pending_family_reply_if_match_info *info = user_data;
-
-	if (pending_family_match(data, L_UINT_TO_PTR(info->service_type))) {
-		service_create_shared_reply(shared_data, info->family);
-		return true;
-	}
-
-	return false;
-}
-
-static void service_create_shared_pending_reply(struct qmi_device_qmux *qmux,
-						uint16_t service_type,
-						struct service_family *family)
-{	struct pending_family_reply_if_match_info info = {
-		.service_type = service_type,
-		.family = family,
-	};
-
-	l_queue_foreach_remove(qmux->pending_families,
-					pending_family_reply_if_match, &info);
-}
-
-static void service_create_shared_data_free(void *user_data)
-{
-	struct service_create_shared_data *data = user_data;
-
-	if (data->idle)
-		l_idle_remove(data->idle);
-
-	if (data->family)
-		service_family_unref(data->family);
-
-	if (data->destroy)
-		data->destroy(data->user_data);
-
-	l_free(data);
-}
-
 static struct qmi_request *find_control_request(struct qmi_device_qmux *qmux,
 						uint16_t tid)
 {
@@ -1737,7 +1648,9 @@ struct qmux_client_create_data {
 	uint8_t type;
 	uint16_t major;
 	uint16_t minor;
-	qmi_create_func_t func;
+	qmi_qmux_device_create_client_func_t func;
+	void *user_data;
+	qmi_destroy_func_t destroy;
 	struct l_timeout *timeout;
 	uint16_t tid;
 };
@@ -1749,10 +1662,14 @@ static void qmux_client_create_data_free(void *user_data)
 	if (data->timeout)
 		l_timeout_remove(data->timeout);
 
+	if (data->destroy)
+		data->destroy(data->user_data);
+
 	l_free(data);
 }
 
-static void qmux_client_create_reply(struct l_timeout *timeout, void *user_data)
+static void qmux_client_create_timeout(struct l_timeout *timeout,
+							void *user_data)
 {
 	struct qmux_client_create_data *data = user_data;
 	struct qmi_device *device = data->device;
@@ -1760,20 +1677,17 @@ static void qmux_client_create_reply(struct l_timeout *timeout, void *user_data)
 		l_container_of(device, struct qmi_device_qmux, super);
 	struct qmi_request *req;
 
-	DBG("");
-
-	service_create_shared_pending_reply(qmux, data->type, NULL);
-
-	/* remove request from queues */
-	req = find_control_request(qmux, data->tid);
+	__debug_device(device, "client creation timed out");
 
 	l_timeout_remove(data->timeout);
 	data->timeout = NULL;
 
-	DISCOVERY_DONE(data, NULL, NULL);
-
+	/* remove request from queues */
+	req = find_control_request(qmux, data->tid);
 	if (req)
 		__request_free(req);
+
+	DISCOVERY_DONE(data, NULL, data->user_data);
 }
 
 static void qmux_client_create_callback(uint16_t message, uint16_t length,
@@ -1781,9 +1695,8 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 {
 	struct qmux_client_create_data *data = user_data;
 	struct qmi_device *device = data->device;
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
 	struct service_family *family = NULL;
+	struct qmi_service *service = NULL;
 	struct qmi_service_info info;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
@@ -1817,72 +1730,63 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	hash_id = family_list_create_hash(family->info.service_type,
 							family->client_id);
 	l_hashmap_insert(device->family_list, L_UINT_TO_PTR(hash_id), family);
-	l_hashmap_insert(device->family_list,
-				L_UINT_TO_PTR(family->info.service_type),
-				family);
+
 done:
-	service_create_shared_pending_reply(qmux, data->type, family);
 	if (family)
-		service_family_unref(family);
+		service = service_create(family);
+
+	DISCOVERY_DONE(data, service, data->user_data);
 
-	DISCOVERY_DONE(data, NULL, NULL);
+	if (family)
+		service_family_unref(family);
 }
 
-static int qmi_device_qmux_client_create(struct qmi_device *device,
-					uint16_t service_type,
-					qmi_create_func_t func, void *user_data,
-					qmi_destroy_func_t destroy)
+bool qmi_qmux_device_create_client(struct qmi_device *device,
+				uint16_t service_type,
+				qmi_qmux_device_create_client_func_t func,
+				void *user_data, qmi_destroy_func_t destroy)
 {
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
+	const struct qmi_service_info *info;
+	struct qmi_device_qmux *qmux;
 	struct qmi_request *req;
-	struct service_create_shared_data *shared_data;
 	struct qmux_client_create_data *create_data;
-	bool create_in_progress;
 
-	if (!l_queue_length(device->service_infos))
-		return -ENOENT;
+	if (!device || !func)
+		return false;
 
-	create_in_progress = l_queue_find(qmux->pending_families,
-						pending_family_match,
-						L_UINT_TO_PTR(service_type));
+	if (service_type == QMI_SERVICE_CONTROL)
+		return false;
 
-	shared_data = l_new(struct service_create_shared_data, 1);
-	shared_data->super.destroy = service_create_shared_data_free;
-	shared_data->service_type = service_type;
-	shared_data->device = device;
-	shared_data->func = func;
-	shared_data->user_data = user_data;
-	shared_data->destroy = destroy;
-	l_queue_push_tail(qmux->pending_families, shared_data);
+	info = __find_service_info_by_type(device, service_type);
+	if (!info)
+		return false;
 
-	if (create_in_progress)
-		return 0;
+	qmux = l_container_of(device, struct qmi_device_qmux, super);
 
 	create_data = l_new(struct qmux_client_create_data, 1);
 	create_data->super.destroy = qmux_client_create_data_free;
 	create_data->device = device;
 	create_data->type = service_type;
+	create_data->major = info->major;
+	create_data->minor = info->minor;
+	create_data->func = func;
+	create_data->user_data = user_data;
+	create_data->destroy = destroy;
 
 	__debug_device(device, "service create [type=%d]", service_type);
 
-	qmi_device_get_service_version(device, create_data->type,
-						&create_data->major,
-						&create_data->minor);
-
 	req = __control_request_alloc(QMI_CTL_GET_CLIENT_ID,
 					client_req, sizeof(client_req),
 					qmux_client_create_callback,
 					create_data);
 
 	create_data->tid = __ctl_request_submit(qmux, req);
-	create_data->timeout = l_timeout_create(8, qmux_client_create_reply,
+	create_data->timeout = l_timeout_create(8, qmux_client_create_timeout,
 							create_data, NULL);
 
 	__qmi_device_discovery_started(device, &create_data->super);
-
-	return 0;
+	return true;
 }
 
 static void qmux_client_release_callback(uint16_t message, uint16_t length,
@@ -1971,8 +1875,6 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 
-	l_queue_destroy(qmux->pending_families,
-		(l_queue_destroy_func_t) service_create_shared_data_free);
 	l_queue_destroy(qmux->control_queue, __request_free);
 
 	if (qmux->shutdown_idle)
@@ -1985,7 +1887,6 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 static const struct qmi_device_ops qmux_ops = {
 	.write = qmi_device_qmux_write,
 	.discover = qmi_device_qmux_discover,
-	.client_create = qmi_device_qmux_client_create,
 	.client_release = qmi_device_qmux_client_release,
 	.shutdown = qmi_device_qmux_shutdown,
 	.destroy = qmi_device_qmux_destroy,
@@ -2010,7 +1911,6 @@ struct qmi_device *qmi_qmux_device_new(const char *device)
 
 	qmux->next_control_tid = 1;
 	qmux->control_queue = l_queue_new();
-	qmux->pending_families = l_queue_new();
 	l_io_set_read_handler(qmux->super.io, received_qmux_data, qmux, NULL);
 
 	return &qmux->super;
@@ -2304,7 +2204,6 @@ static void qmi_device_qrtr_destroy(struct qmi_device *device)
 static const struct qmi_device_ops qrtr_ops = {
 	.write = qmi_device_qrtr_write,
 	.discover = qmi_device_qrtr_discover,
-	.client_create = NULL,
 	.client_release = NULL,
 	.shutdown = NULL,
 	.destroy = qmi_device_qrtr_destroy,
@@ -2630,56 +2529,6 @@ bool qmi_result_get_uint64(struct qmi_result *result, uint8_t type,
 	return true;
 }
 
-bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
-			qmi_create_func_t func, void *user_data,
-			qmi_destroy_func_t destroy)
-{
-	struct service_create_shared_data *data;
-	struct service_family *family;
-
-	if (!device || !func)
-		return false;
-
-	if (type == QMI_SERVICE_CONTROL)
-		return false;
-
-	family = l_hashmap_lookup(device->family_list, L_UINT_TO_PTR(type));
-	if (!family) {
-		const struct qmi_service_info *info;
-
-		if (device->ops->client_create) {
-			int r;
-
-			r = device->ops->client_create(device, type, func,
-							user_data, destroy);
-			return r == 0;
-		}
-
-		info = __find_service_info_by_type(device, type);
-		if (!info)
-			return false;
-
-		family = service_family_create(device, info, 0);
-		l_hashmap_insert(device->family_list, L_UINT_TO_PTR(type),
-							family);
-	}
-
-	data = l_new(struct service_create_shared_data, 1);
-
-	data->super.destroy = service_create_shared_data_free;
-	data->device = device;
-	data->func = func;
-	data->user_data = user_data;
-	data->destroy = destroy;
-	data->family = service_family_ref(family);
-	data->idle = l_idle_create(service_create_shared_idle_cb, data, NULL);
-
-	/* Not really discovery... just tracking the idle callback. */
-	__qmi_device_discovery_started(device, &data->super);
-
-	return true;
-}
-
 const char *qmi_service_get_identifier(struct qmi_service *service)
 {
 	if (!service)
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 966d4f354d6e..90e83a4dbebd 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -65,12 +65,19 @@ struct qmi_service;
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(void *user_data);
+typedef void (*qmi_qmux_device_create_client_func_t)(struct qmi_service *,
+							void *user_data);
 
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
 struct qmi_device *qmi_qmux_device_new(const char *device);
 void qmi_device_free(struct qmi_device *device);
 
+bool qmi_qmux_device_create_client(struct qmi_device *device,
+				uint16_t service_type,
+				qmi_qmux_device_create_client_func_t func,
+				void *user_data, qmi_destroy_func_t destroy);
+
 void qmi_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data);
 
@@ -130,11 +137,6 @@ void qmi_result_print_tlvs(struct qmi_result *result);
 
 int qmi_error_to_ofono_cme(int qmi_error);
 
-typedef void (*qmi_create_func_t)(struct qmi_service *service, void *user_data);
-
-bool qmi_service_create_shared(struct qmi_device *device,
-				uint16_t type, qmi_create_func_t func,
-				void *user_data, qmi_destroy_func_t destroy);
 struct qmi_service *qmi_service_clone(struct qmi_service *service);
 void qmi_service_free(struct qmi_service *service);
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 5463a46edecb..23d16e251196 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -419,7 +419,7 @@ static void request_service_cb(struct qmi_service *service, void *user_data)
 	if (data->cur_service_request == data->num_service_requests) {
 		DBG("All services requested, proceeding to create WDA");
 
-		if (qmi_service_create_shared(data->device, QMI_SERVICE_WDA,
+		if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_WDA,
 						create_wda_cb, modem, NULL))
 			return;
 
@@ -429,7 +429,7 @@ static void request_service_cb(struct qmi_service *service, void *user_data)
 	req = &data->service_requests[data->cur_service_request];
 	DBG("Requesting: %u", req->service_type);
 
-	if (qmi_service_create_shared(data->device, req->service_type,
+	if (qmi_qmux_device_create_client(data->device, req->service_type,
 					request_service_cb, modem, NULL))
 		return;
 
@@ -482,7 +482,7 @@ static void discover_cb(void *user_data)
 	if (data->features & GOBI_UIM)
 		add_service_request(data, &data->uim, QMI_SERVICE_UIM);
 
-	if (qmi_service_create_shared(data->device, QMI_SERVICE_DMS,
+	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
 					request_service_cb, modem, NULL) > 0)
 		return;
 error:
-- 
2.45.0

