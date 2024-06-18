Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940016DC3A
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740976; cv=none; b=eUGWnbEm5cprzAbjCqfd1VfgGOyY6uut0Xfh2W3Ik9/kcX05DQH24tEHS1QZ24RcodQxkIw/DU6Nx+UQx407WIINIJc+co/AOyb35jenr2navEWpdepCJmXWFecjLtdKO7t4VC4UrvpMPzss8KroEoShAghgQ8Bi7oowb2qDako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740976; c=relaxed/simple;
	bh=z68cc1ur7gn19+lZinUu8Xy5LUEFQexcoWZq1I3K8XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3wKgYjIk5egR0h4XHBv2EzC7BAe2SpVW/1fqvaie/p+0y0y8hcj/3lKRFi88eB/YAI5n2oEGViQMfpmpYjXDb8jh4ofIX4a9Zt8CXQGfCYMHpj5qyUDMvBqmxm+n0nf/UgUZ0Ti8xP2F7FwvLI9vkeHY3TRLlueYvO6LKjuq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVOprjAd; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVOprjAd"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-250ca14422aso3230244fac.0
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740974; x=1719345774; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM7YwLgeUpHVqmQLbUop8RywvbnihGeAaoAyFJzEgKE=;
        b=RVOprjAd2dn3RvoAcVLDPYIDEF+8eC1Y0xFHALmDrO+NuVRcmHZYw0LwiZAYOnbv5S
         Xgd5S6QvEKV7INWdEy73iTrzqrasaKlfIQ+GVesd5NChkwGobJquI4x3fKHvPBMkTCux
         uI2eJnS/kQl4BcOdJDHgpFoQ4DwG5/6/Ii/pimb/HwYoLVSjTY7FXSWPpEf8BrmNgBCf
         cARKf7vCv2ZAUzqMOxFb4GptMfvE3ImCiD0r3BymAFmTnPtf+nVxlbwkSSeFXQRQ2FS+
         +B3MFBYD2XKkju7QVU2jMV6pTFkOEycjgRSkQzI8HsDYFGFnrpEJLIsXSJ0MfkhsV6PW
         UBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740974; x=1719345774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BM7YwLgeUpHVqmQLbUop8RywvbnihGeAaoAyFJzEgKE=;
        b=kV/ir6ehPzYvI9EEdWS8Wy8FVpJYzgReBCX48wv2tRekzpAGmH5BbrcbCxsdcfJOiX
         VHg8Azc3ZzNA3owX1JnbLemtCRbk5EyHutdo9lv14W37WWV0GbljKe66Ge2btEMOw2zt
         xuyq7rwaaE2ssHr0Sb1gSOqayuyXqq+D7TYn/Qknt2HVHnZrh2rnantbaCUCoo6Whv1y
         U44KuPKj6Sf/P0EU5GmLRtOaAV2wk35lXCXB2mSSClT4yKPJ4CNAKWZLRYUAn2kI2gmD
         SatBN7hLudnOj605l2R5vfAuUlSeTVXsQGk0Cm5RmlbFZwj4qTszXFNXXkfJ7p+VSFbV
         cGxQ==
X-Gm-Message-State: AOJu0YzWMtRHp1ZeFqpCxZ5v+CIl6G4UbKUy/hF4JuNrJhV50cJwcCSq
	e3nrD++0ZZG4vO7CUnVxJqKIjfBanAouVAknkOeZca87One4yEgoZ6mhSQ==
X-Google-Smtp-Source: AGHT+IFAj1NjYiMvSzjIlbGU6sEFL0Sfv2NaH3yoS61tR2bCzhJi76cpm2H8yzsoiQJM7eqhoR6jzg==
X-Received: by 2002:a05:6871:58a8:b0:24f:dad3:97c with SMTP id 586e51a60fabf-25c94d05a4bmr935699fac.46.1718740973801;
        Tue, 18 Jun 2024 13:02:53 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:53 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 26/33] qmi: Rename qmi_device_shutdown
Date: Tue, 18 Jun 2024 15:02:08 -0500
Message-ID: <20240618200231.1129282-26-denkenz@gmail.com>
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
index 2aebb197fac0..2844ea9f06f6 100644
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
@@ -1529,7 +1516,7 @@ static void qmux_client_release_callback(uint16_t message, uint16_t length,
 {
 	struct qmi_device_qmux *qmux = user_data;
 
-	qmux->release_users--;
+	qmux->shutdown.release_users--;
 }
 
 static void qmi_device_qmux_client_release(struct qmi_device *device,
@@ -1541,7 +1528,7 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 	uint8_t release_req[] = { 0x01, 0x02, 0x00, service_type, client_id };
 	struct qmi_request *req;
 
-	qmux->release_users++;
+	qmux->shutdown.release_users++;
 
 	req = __control_request_alloc(QMI_CTL_RELEASE_CLIENT_ID,
 					release_req, sizeof(release_req),
@@ -1559,8 +1546,8 @@ static void __qmux_device_free(struct qmi_device_qmux *qmux)
 	if (qmux->discover.destroy)
 		qmux->discover.destroy(qmux->discover.user_data);
 
-	if (qmux->shutdown_idle)
-		l_idle_remove(qmux->shutdown_idle);
+	if (qmux->shutdown.idle)
+		l_idle_remove(qmux->shutdown.idle);
 
 	l_free(qmux->version_str);
 	l_free(qmux);
@@ -1570,10 +1557,10 @@ static void qmux_shutdown_destroy(void *user_data)
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
@@ -1583,41 +1570,45 @@ static void qmux_shutdown_callback(struct l_idle *idle, void *user_data)
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
@@ -1625,7 +1616,6 @@ static int qmi_device_qmux_shutdown(struct qmi_device *device,
 static const struct qmi_device_ops qmux_ops = {
 	.write = qmi_device_qmux_write,
 	.client_release = qmi_device_qmux_client_release,
-	.shutdown = qmi_device_qmux_shutdown,
 };
 
 struct qmi_device *qmi_qmux_device_new(const char *device)
@@ -1889,7 +1879,6 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 static const struct qmi_device_ops qrtr_ops = {
 	.write = qmi_qrtr_node_write,
 	.client_release = NULL,
-	.shutdown = NULL,
 };
 
 struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node)
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 152ebf1eb14b..64eebc27c17c 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -57,10 +57,10 @@ struct qmi_result;
 struct qmi_service;
 
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
-typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_qmux_device_discover_func_t)(void *user_data);
 typedef void (*qmi_qmux_device_create_client_func_t)(struct qmi_service *,
 							void *user_data);
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
index e39ea6c4ed0e..74df3c360c96 100644
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

