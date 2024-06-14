Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC331A01CD
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391204; cv=none; b=c2pml7RCBvV39gq2d3Zsbg8O4hCI2tycg0ilCA4M8FpEdwXbKRGWP8O+55kshhtBr31ZsM/3LZD5iLUfUvu6QB4TEpt6GNdrXFBDlbk3JgAR7gZzRGmeJ6RUJG7yqKDQYEVRfpFEPgA4GU00I/c4D6PYva+ANYAfTxvRVDxy1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391204; c=relaxed/simple;
	bh=I/GnzEojX7m3CBDzhJSB4Lb6fCN+4ddKa+QODpVZWF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxZVqb8HJqUod+a2RJrkp76OZynl0vgfOpHEVHC9bhgxZODTu7obSbamZmrr2iTMmGtWKNJJphbwI+mFDjoPrFwBQDRlU2MImlWLxjj0PkM8WKbGtaWag4GfzPvE2AGZ1cmcEJ2CfOLl/Mz7s/eCgSrIRPAFSTO77dg5dMswa2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3DZoDwR; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3DZoDwR"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2508320e62dso1185386fac.3
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391201; x=1718996001; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbkw3gfBa7pDv5LtwL2F58xHAeTu0x1hEm/aJcvSENY=;
        b=U3DZoDwRzVtRkDBKAFich/HEGU/NxGA44Sm2VgmhM7hn3JbOS4osvlAGppmAa8O9HY
         xwO9RBFaIuXv5NlPYQc6SQkhkOLSmKKuWJ6jmov3ATouZVRNDKLAJns+c+Mo/NENBH8x
         ikHGYRyjEoZuf231MXbIZxAR3P1hPMicroiu3EXuU2VqM5DXigo21ICXc8LrFQr8jJRe
         +oJ3JKxF/XrXeJPdtL+ryAH2tN5/lAvVhKK84A1ep99MW2f+6c6LPzenX3IB5BICzC8Y
         h8Hcl2ra2mbroxnfeA9N+vVtVLzpQHF52Y+1WgWaTk2SULqg0ZFH5KZtq5LqDmlthwoi
         EBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391201; x=1718996001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbkw3gfBa7pDv5LtwL2F58xHAeTu0x1hEm/aJcvSENY=;
        b=jNdttNVkpfWgwr3NUSl5b00vnlY8EaK2dH/vWvP9mmID9ESqRYmznjshuPyJaHh4rC
         GyCgMNM1Q4brT6cpnMth6UIPndg/7CyDMPfRkSC0zVZYaEFQbeQYy9XVqPxoqvTJIIzv
         QgmmRbTrRX2R+PI0mI2yX3nGhNsgKjROfRogmL/5BZNv8Mnh4fnLHHurEOiTtiVzy1Sm
         kMhQPD56kNwxtXhxUymT3e6Rs67Z+Qt5+bEKAZE9HAfDn8+3iChM/meMAsCNLe3zsFcz
         fVbgmtQNAOUUsyxtfSjDb8E2XM1FO0TZDcFdIROyEipvKVhJOEmKiLGLaspV/r3ckQZs
         MpLw==
X-Gm-Message-State: AOJu0YzIBaG7cdjL+z70RG9Y4c5A6hc1pYGPrFd73FkbQgWEI/2tikow
	DYQsykxSAI488JEJwUJSpikvQmFKzoD+3todTXmqlf6LDBztkncECmqGMA==
X-Google-Smtp-Source: AGHT+IE60EvG/GAO1afRK1hYUy/0WBkrUDyIEUcEI2a2BuGgS9HmXsDkzh2reRJcKNo6oYp5N6WpWw==
X-Received: by 2002:a05:6870:1586:b0:254:a1a8:8501 with SMTP id 586e51a60fabf-25842b79405mr3916268fac.43.1718391201380;
        Fri, 14 Jun 2024 11:53:21 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:21 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 25/27] qmi: Rename qmi_device_shutdown
Date: Fri, 14 Jun 2024 13:52:37 -0500
Message-ID: <20240614185300.1086701-25-denkenz@gmail.com>
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

Rename qmi_device_shutdown to qmi_qmux_device_shutdown to make it clear
that only the QMUX implementation requires this operation.  Remove the
shutdown() method from qmi_device_ops since it is no longer needed.

While here, move shutdown operation related members to a dedicated
'shutdown' structure inside qmi_device_qmux.  This makes it more
consistent with how discovery related members are setup.
---
 drivers/qmimodem/qmi.c | 75 ++++++++++++++++++------------------------
 drivers/qmimodem/qmi.h |  6 ++--
 plugins/gobi.c         |  2 +-
 3 files changed, 36 insertions(+), 47 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5576c520bb08..d9b888380456 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -67,9 +67,6 @@ struct qmi_device_ops {
 	int (*write)(struct qmi_device *device, struct qmi_request *req);
 	void (*client_release)(struct qmi_device *device,
 				uint16_t service_type, uint16_t client_id);
-	int (*shutdown)(struct qmi_device *device,
-			qmi_shutdown_func_t shutdown_func,
-			void *user, qmi_destroy_func_t destroy);
 };
 
 struct debug_data {
@@ -97,11 +94,6 @@ struct qmi_device_qmux {
 	uint16_t control_minor;
 	char *version_str;
 	struct debug_data debug;
-	qmi_shutdown_func_t shutdown_func;
-	void *shutdown_user_data;
-	qmi_destroy_func_t shutdown_destroy;
-	struct l_idle *shutdown_idle;
-	unsigned int release_users;
 	struct {
 		qmi_qmux_device_discover_func_t func;
 		void *user_data;
@@ -109,6 +101,13 @@ struct qmi_device_qmux {
 		struct l_timeout *timeout;
 		uint16_t tid;
 	} discover;
+	struct {
+		qmi_qmux_device_shutdown_func_t func;
+		void *user_data;
+		qmi_destroy_func_t destroy;
+		struct l_idle *idle;
+		unsigned int release_users;
+	} shutdown;
 	uint8_t next_control_tid;
 	struct l_queue *control_queue;
 	bool shutting_down : 1;
@@ -985,18 +984,6 @@ bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type)
 	return __find_service_info_by_type(device, type);
 }
 
-int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
-				void *user_data, qmi_destroy_func_t destroy)
-{
-	if (!device)
-		return -EINVAL;
-
-	if (!device->ops->shutdown)
-		return -ENOTSUP;
-
-	return device->ops->shutdown(device, func, user_data, destroy);
-}
-
 static int qmi_device_qmux_write(struct qmi_device *device,
 					struct qmi_request *req)
 {
@@ -1530,7 +1517,7 @@ static void qmux_client_release_callback(uint16_t message, uint16_t length,
 {
 	struct qmi_device_qmux *qmux = user_data;
 
-	qmux->release_users--;
+	qmux->shutdown.release_users--;
 }
 
 static void qmi_device_qmux_client_release(struct qmi_device *device,
@@ -1542,7 +1529,7 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 	uint8_t release_req[] = { 0x01, 0x02, 0x00, service_type, client_id };
 	struct qmi_request *req;
 
-	qmux->release_users++;
+	qmux->shutdown.release_users++;
 
 	req = __control_request_alloc(QMI_CTL_RELEASE_CLIENT_ID,
 					release_req, sizeof(release_req),
@@ -1558,8 +1545,8 @@ static void __qmux_device_free(struct qmi_device_qmux *qmux)
 	if (qmux->discover.destroy)
 		qmux->discover.destroy(qmux->discover.user_data);
 
-	if (qmux->shutdown_idle)
-		l_idle_remove(qmux->shutdown_idle);
+	if (qmux->shutdown.idle)
+		l_idle_remove(qmux->shutdown.idle);
 
 	l_free(qmux->version_str);
 	l_free(qmux);
@@ -1569,10 +1556,10 @@ static void qmux_shutdown_destroy(void *user_data)
 {
 	struct qmi_device_qmux *qmux = user_data;
 
-	if (qmux->shutdown_destroy)
-		qmux->shutdown_destroy(qmux->shutdown_user_data);
+	if (qmux->shutdown.destroy)
+		qmux->shutdown.destroy(qmux->shutdown.user_data);
 
-	qmux->shutdown_idle = NULL;
+	qmux->shutdown.idle = NULL;
 
 	if (qmux->destroyed)
 		__qmux_device_free(qmux);
@@ -1582,41 +1569,45 @@ static void qmux_shutdown_callback(struct l_idle *idle, void *user_data)
 {
 	struct qmi_device_qmux *qmux = user_data;
 
-	if (qmux->release_users > 0)
+	if (qmux->shutdown.release_users > 0)
 		return;
 
 	qmux->shutting_down = true;
 
-	if (qmux->shutdown_func)
-		qmux->shutdown_func(qmux->shutdown_user_data);
+	if (qmux->shutdown.func)
+		qmux->shutdown.func(qmux->shutdown.user_data);
 
 	qmux->shutting_down = false;
 
-	l_idle_remove(qmux->shutdown_idle);
+	l_idle_remove(qmux->shutdown.idle);
 }
 
-static int qmi_device_qmux_shutdown(struct qmi_device *device,
-					qmi_shutdown_func_t func,
+int qmi_qmux_device_shutdown(struct qmi_device *device,
+					qmi_qmux_device_shutdown_func_t func,
 					void *user_data,
 					qmi_destroy_func_t destroy)
 {
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
+	struct qmi_device_qmux *qmux;
+
+	if (!device)
+		return -EINVAL;
+
+	qmux = l_container_of(device, struct qmi_device_qmux, super);
 
-	if (qmux->shutdown_idle)
+	if (qmux->shutdown.idle)
 		return -EALREADY;
 
 	DEBUG(&qmux->debug, "device %p", &qmux);
 
-	qmux->shutdown_idle = l_idle_create(qmux_shutdown_callback, qmux,
+	qmux->shutdown.idle = l_idle_create(qmux_shutdown_callback, qmux,
 						qmux_shutdown_destroy);
 
-	if (!qmux->shutdown_idle)
+	if (!qmux->shutdown.idle)
 		return -EIO;
 
-	qmux->shutdown_func = func;
-	qmux->shutdown_user_data = user_data;
-	qmux->shutdown_destroy = destroy;
+	qmux->shutdown.func = func;
+	qmux->shutdown.user_data = user_data;
+	qmux->shutdown.destroy = destroy;
 
 	return 0;
 }
@@ -1624,7 +1615,6 @@ static int qmi_device_qmux_shutdown(struct qmi_device *device,
 static const struct qmi_device_ops qmux_ops = {
 	.write = qmi_device_qmux_write,
 	.client_release = qmi_device_qmux_client_release,
-	.shutdown = qmi_device_qmux_shutdown,
 };
 
 struct qmi_device *qmi_qmux_device_new(const char *device)
@@ -1888,7 +1878,6 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 static const struct qmi_device_ops qrtr_ops = {
 	.write = qmi_qrtr_node_write,
 	.client_release = NULL,
-	.shutdown = NULL,
 };
 
 struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node)
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index e5c99ab8b674..26ef8c72f9df 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -57,10 +57,10 @@ struct qmi_result;
 struct qmi_service;
 
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
-typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_qmux_device_discover_func_t)(void *user_data);
 typedef void (*qmi_qmux_device_create_client_func_t)(struct qmi_service *,
 							void *);
+typedef void (*qmi_qmux_device_shutdown_func_t)(void *user_data);
 typedef void (*qmi_qrtr_node_lookup_done_func_t)(void *);
 
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
@@ -80,8 +80,8 @@ bool qmi_qmux_device_get_service_version(struct qmi_device *device,
 					uint16_t type,
 					uint16_t *major, uint16_t *minor);
 bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type);
-
-int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
+int qmi_qmux_device_shutdown(struct qmi_device *device,
+				qmi_qmux_device_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
 struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 483495972843..091e5f08ea5d 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -234,7 +234,7 @@ static void shutdown_device(struct ofono_modem *modem)
 
 	cleanup_services(data);
 
-	if (qmi_device_shutdown(data->device, shutdown_cb, modem, NULL) < 0)
+	if (qmi_qmux_device_shutdown(data->device, shutdown_cb, modem, NULL) < 0)
 		shutdown_cb(modem);
 }
 
-- 
2.45.0

