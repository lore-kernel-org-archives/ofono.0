Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16E1A01B6
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391205; cv=none; b=nzXttmsNl2HeMCzqg/E0HtHC/52vd5xr9Yel8rDQ2Wg7NXTOY5xGigWf8UBEhu2wP7Sg9Q/AJ99yCJ8ukvEL69fLyqCoUfN4SfettyrEin7SFGbzCEAHCj5RdjsTdjiac7XG7h7WnTdH+WvTgC+1jU1pFV6XLYCHGH1uQsryGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391205; c=relaxed/simple;
	bh=S++E0RX5PVoXJY5HaJLV1pqA47zbOxH++i4VWRT/mr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0bFM8WYzJYblbMLqKlQHMxUpMxP554dgmKuNPITnKD/yWXQium4meFRqN6yt/4MXAjxUF90W95j2f0hHXdkzhkS+gzNY2T0ZyNAnHMjlApyY36ysksDgRf2eP541u3Zb1rUuNU6NyxwlEi2AnIpHw6PMgWE/sluWLxFWQWYp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VseVA/Yt; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VseVA/Yt"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-254efc9ca45so1626160fac.3
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391202; x=1718996002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugbpFhjKwDNfXPVXhfs+40yagMN/CSbumoTOvLcEct4=;
        b=VseVA/YtsgzqfD2qTO95rAacmEKycfCB6DoNIb4PwTI9JHszEZWc/eQaMgxrdw2Q8C
         aFZ44pOsiJIBu+3ffvQ0WV1unRzMSe+okTg3cEnczetJaENXXtWaeKb5KAWvswZhfgPh
         5nDx4A6DIlmaqP1avu7Wi+ngBJVB2Q644+LylBKSg9DGHbXhRuITnZc0EiDZh8uQNORE
         +QQIodMenR0sf2xT6pauq1raTBo3wKKik5svunIQnOOMQRZ6c2c9lRFFQ5qpaaB3el5j
         SQoDEJIHdmyyBaJuRxVaV4TZUyI5lbIvvFjDSF8z+QqOro0/dz8jYHv35ei69NuLgwRa
         PItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391202; x=1718996002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugbpFhjKwDNfXPVXhfs+40yagMN/CSbumoTOvLcEct4=;
        b=PVsm4o0nLQJmUAavhlHk7fzQyngqjF2R24rOb8wB1+7oqtF1JF0lAHGqNCoQk8Z9ag
         uU7P38PmbH+kimWUFuODcsCsjCfDXICRjrwQxTei8nMz4+05hzNdZTwoAJza3kAwdh1+
         xrRaUmaW35dzg1fBYzt4mY/GW4HM3LFRpCJSCX4B8gqzWtKnwy83ngTN7h9WhJ34ao2b
         SG1/Oc6vUwfhB8jrmcBnZHdf7ybPDTWRsAtPSVPLHRIUPVgQfTzSGcrd/+tSzB+OO6dz
         BMxyNbL27MyhE5LRZDDtCUEYqTy75cWehU7ie8BjXsvp55VeHdfn81EoX5C/F1z3pmhI
         +gzw==
X-Gm-Message-State: AOJu0Yz3j3q01fH9UCV20U+Fx8SMCsseFR786NE8wAM/VWRQojFcQGbT
	3DoJyrF+XQDm1JRYycQhULk7npRx1mGret1GPyQHUvkFj6X6MsrtWhtYpQ==
X-Google-Smtp-Source: AGHT+IEZBJpMZe+MxHxrvDCJxaFkMu9Ex8gyG8p1XScBDwuLEyTyPwcJEQr/oPKrtgJBeZWrK04R6w==
X-Received: by 2002:a05:6870:618d:b0:254:a233:3d11 with SMTP id 586e51a60fabf-258429a4ce3mr3139017fac.30.1718391202513;
        Fri, 14 Jun 2024 11:53:22 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:22 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 27/27] qmi: Make qmux methods operate on 'qmi_qmux_device'
Date: Fri, 14 Jun 2024 13:52:39 -0500
Message-ID: <20240614185300.1086701-27-denkenz@gmail.com>
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

---
 drivers/qmimodem/qmi.c | 70 ++++++++++++++++++------------------------
 drivers/qmimodem/qmi.h | 19 ++++++------
 plugins/gobi.c         |  2 +-
 3 files changed, 40 insertions(+), 51 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2c2be04c1593..e8fcb97b2ca2 100644
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
@@ -1329,21 +1334,18 @@ static void qmux_discover_reply_timeout(struct l_timeout *timeout,
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
@@ -1445,14 +1447,15 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
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
@@ -1464,32 +1467,29 @@ done:
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
@@ -1508,7 +1508,7 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 	create_data->timeout = l_timeout_create(8, qmux_client_create_timeout,
 							create_data, NULL);
 
-	__qmi_device_discovery_started(device, &create_data->super);
+	__qmi_device_discovery_started(&qmux->super, &create_data->super);
 	return true;
 }
 
@@ -1582,18 +1582,14 @@ static void qmux_shutdown_callback(struct l_idle *idle, void *user_data)
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
 
@@ -1617,7 +1613,7 @@ static const struct qmi_device_ops qmux_ops = {
 	.client_release = qmi_qmux_device_client_release,
 };
 
-struct qmi_device *qmi_qmux_device_new(const char *device)
+struct qmi_qmux_device *qmi_qmux_device_new(const char *device)
 {
 	struct qmi_qmux_device *qmux;
 	int fd;
@@ -1638,19 +1634,16 @@ struct qmi_device *qmi_qmux_device_new(const char *device)
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
@@ -1660,15 +1653,12 @@ void qmi_qmux_device_free(struct qmi_device *device)
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
index 26ef8c72f9df..441f7b72f3bf 100644
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
index 091e5f08ea5d..e5ebec44ebc7 100644
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

