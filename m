Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A61AE84E
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895138; cv=none; b=nRgSCAxaqLVVcLhQ2DKkhE7Cch3ExBvOnNc0XM+du8UTHeQvHMg2SBUTECP53Ua74ZE/oCA/oF96Jgui2N27PEOGW7bhd8HcBc6y5dIqRTvy1VJocS+KA25dc324QlRphOWz29pM7JIpwAuDLsAdZ2D1VH4NqZQvOgFfN9u/yiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895138; c=relaxed/simple;
	bh=ctS1BZKPNRDgevSky/pCEldnFDI35nGrtZ4u60dE0Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KciOZmZRAbHanEQ58Qq7FVHMWWivSCj3vZwTYG3kFv0YFxUiK43lipHx5f61RfbM9IJeUpEUK+iUnj1+wzpy65I7cSrU+Raj2HTGCqa8OGjS4YkkySI5PPwR+Az2WCA6oo8c9i6UCLve6+EypQKt2JFBBFGJXj20J/xMBv0PZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrT+eODn; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrT+eODn"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d516d3f0b2so563302b6e.1
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895136; x=1719499936; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bugyZioKe2x5rBXXZghaBG+FpRUXnMfDJnuLU3ec04=;
        b=nrT+eODnSmuuGq/NNVJ5YJudlz0fj99FlZIO7DDeGY5zqD52y6tR/XmiCV7KSkQxKj
         P5J/pKSQGuXVThbEkf/3sMTYEEi+WPoFL5JuWzy484m9YBP9pIE2zXvFcn4wZ5Vrz95v
         A36LtsPQB/HYvjOASz+aNhQ4be634ILSKmnNaHVragBoD3Z+xyAtxJi9Z/H3bxdV335O
         igP/VHaTCVwpOfYvsP80NQ9KurnjQ0WtBUmdfEqSv9qhi28fQRYiJqkK8Kl2MfDdvCI1
         DEI10/dJxFNtoqnxYwgCKUZZ9na1mJYAskI6dFMGv2OLlm+lbdyjXdYXYxyO/FpTLTn9
         BcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895136; x=1719499936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bugyZioKe2x5rBXXZghaBG+FpRUXnMfDJnuLU3ec04=;
        b=Im8s/XQ/uOGucEa/1eXFHV+2PrMOMlCgje34sEeO+B2uOLADJeGi/Xl6zPlMXx2hmn
         x1ZO2xtWOhjPPhr7pr9g0J+tXtTVPAy5BpqNsTewyN3rG+jdvszlyxTzxDWn/CG/JLb9
         I6Ar4SlLFDtazSwXIbMqBl+14ZY9K2miljT1VZVfquFqon8x4NRw3/vhT386ykj5F+QU
         lOKLb/lVOl8Qs5SzbrVFXU/bwbTxzyjSRDv5J/SpWo9TczAHaJ6N4WeTl/VtKRAH1RzO
         7UMeaCtpWfLXh+d2X1ijR4lrraBuUXjEeTCha1oflzRSR8+LDPuWaXfr+Y19X69HE/ke
         Ikmg==
X-Gm-Message-State: AOJu0Yx3UvWXIozlS9tZaNrei2rcqdseASdnCKRXcAYrgLK3jktY3npa
	lcC6zUvXRmxLsWH7oJmD3F1UvrNI7Ntm/sOdepunOpPKFUfq2uU/ZN0jTg==
X-Google-Smtp-Source: AGHT+IEeaB6IJtKiGOFHUyF07RqYRwc7feS6FDk3c2D8Rnkp0VbgBKF6J6nkUEWpA7CyA6o9eh8mxw==
X-Received: by 2002:a05:6808:bce:b0:3d2:4fe3:50ef with SMTP id 5614622812f47-3d51bae53f6mr6688267b6e.41.1718895135852;
        Thu, 20 Jun 2024 07:52:15 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:15 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 28/33] qmi: Make qmux methods operate on 'qmi_qmux_device'
Date: Thu, 20 Jun 2024 09:51:15 -0500
Message-ID: <20240620145139.1135899-28-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
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
index 3676c130f614..128874f12cfa 100644
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

