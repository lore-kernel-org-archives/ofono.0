Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236916DED1
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740975; cv=none; b=ZFlOxGM3TyXiTyXUDIjSmKgsL2uCurvg4lW2xnGFsoxh17I+nelEpyt9xA1FZUCcBjTDNHUYn4OTro0us0ZlX6uPgMWQOUxT07bn1TBxQaxGSk83c7Sv14fH9DPq02AV/vmu2KHYdpZ+4WVtvW8FZjOn7L2aq38tO9PDZOxvHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740975; c=relaxed/simple;
	bh=M3FSWRd4WUybbVJVhwwTq766oEYyHQOzwxsTlYnmMww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GznvqeiHfjpSoFctv9ILYNB7xpVsh92um0RfEUPzdYY5zhOdIsSS3IdCrJGsBLabUhL6mH0e2gY1Gt0UtQEaucpEWOTPjWLBZXuxYtcSoMha6HEs434OUHbdYc0AE8iAtnqf4uumW9wiOV2Oqh2oGWI0lFY+9ll6QAWhxcSPTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFuGCaZm; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFuGCaZm"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-254e42df409so3652611fac.0
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740973; x=1719345773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9vAusJEn0byCJUc2wyhItz7xUsaB/1WRDdM1+7MwVM=;
        b=FFuGCaZmIztP1lJbjXrmVWd9TIXdtxMZZ6s0KHguJmc+mo7LWtuE3FY6jtJeNGaSuS
         MI90VDoSa1Sw7Xui4/u+Ay4fiSzjhhuLcqaOIHu3q+D5SC9d/YiV3BprJJW1EKeRGmb5
         huX2mdT+g+ozjS9h4dGTLiZic38NqXGMqeN1ZZhkpKdRNJKFWn1lYDsSbUuBrS+q2nCo
         PS1SZFLmTLUF/F98Bw70WfDW0VFRt4pF2CT4tG85ZkhAq6cYVrrycItFE29ARE25E0uK
         X0HSXYCupUZyxCfOtBj0unSsUJYptxzVzc0XOiKSpkRzoocCt7az7ahcwRXAV0vT+zcI
         jpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740973; x=1719345773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9vAusJEn0byCJUc2wyhItz7xUsaB/1WRDdM1+7MwVM=;
        b=bkDY/DtBk2fImTR/MHoo4SHyweYp5L7f3H78Kd1p9Iob51nazJFEDVqBg+Wg4NMX/b
         lMwI+dpugB1/H4rbMgN92Mo26kZLv3Zc5Xs1VUWdHqFGdVSzV5sLP6cofnfwKfS4pF0S
         Gu7hO3osLRcf6Q6poRj8PEkAmshiGO9pay8NyfyRROzxieIbAfanOjqX/t4N3DlpTyek
         rkLzPNkwxlh0wKC8SV89CULeJ40yKKTNV6WpOM7g13XRMNYNRyjgy7eTVvD7u92tTS5E
         1XMD0wLIiayuPULPBD5yogxGCuXV2ANIMihqQ0Bd/9xPh+yW0aIlR5NU0ivnIb9/D8Rp
         Mz4g==
X-Gm-Message-State: AOJu0YzaA/ReiFNKz0vl1f1ezTNohhhEJpio46RcCa4X8SBwTZuSKydy
	y4u2ggg5+jYGp4e6sA7Xs79rd9XIvbBY3IT4BIEXSFTUzWDiZAhnkNGrRw==
X-Google-Smtp-Source: AGHT+IFfHC46GgxmoGElCTK0qXNmQB+q+I9YEas/kwq7brfebgZiJCSq5t1bpSwvHR4dHvZqIqxCSQ==
X-Received: by 2002:a05:6870:7681:b0:24c:5bd5:1934 with SMTP id 586e51a60fabf-25c94d5bfbcmr665444fac.39.1718740973129;
        Tue, 18 Jun 2024 13:02:53 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:52 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 25/33] qmi: Rename and refactor qmi_device_discover
Date: Tue, 18 Jun 2024 15:02:07 -0500
Message-ID: <20240618200231.1129282-25-denkenz@gmail.com>
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

Refactor the discover implementation to not use struct discover_data
or the discovery queue.  Use a dedicated 'discover' structure instead.
Remove the now unused discover() method from qmi_device_ops.
---
 drivers/qmimodem/qmi.c | 153 ++++++++++++++++-------------------------
 drivers/qmimodem/qmi.h |   7 +-
 plugins/gobi.c         |   5 +-
 3 files changed, 66 insertions(+), 99 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 306ca6092e5c..2aebb197fac0 100644
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
@@ -1255,37 +1224,30 @@ static struct qmi_request *find_control_request(struct qmi_device_qmux *qmux,
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
+	if (qmux->discover.destroy)
+		qmux->discover.destroy(qmux->discover.user_data);
+
+	memset(&qmux->discover, 0, sizeof(qmux->discover));
 }
 
-/* sync will release all previous clients */
-static bool qmi_device_qmux_sync(struct qmi_device_qmux *qmux,
-					struct discover_data *data)
+static void qmux_sync_callback(uint16_t message, uint16_t length,
+					const void *buffer, void *user_data)
 {
-	struct qmi_request *req;
-
-	DEBUG(&qmux->debug, "Sending sync to reset QMI");
-
-	req = __control_request_alloc(QMI_CTL_SYNC, NULL, 0,
-					qmux_sync_callback, data);
-
-	__ctl_request_submit(qmux, req);
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
@@ -1344,69 +1306,68 @@ static void qmux_discover_callback(uint16_t message, uint16_t length,
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
-
-	data->tid = __ctl_request_submit(qmux, req);
-	data->timeout = l_timeout_create(DISCOVER_TIMEOUT,
-						qmux_discover_reply_timeout,
-						data, NULL);
+						qmux_discover_callback, qmux);
 
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
@@ -1593,6 +1554,11 @@ static void __qmux_device_free(struct qmi_device_qmux *qmux)
 {
 	l_queue_destroy(qmux->control_queue, __request_free);
 
+	l_timeout_remove(qmux->discover.timeout);
+
+	if (qmux->discover.destroy)
+		qmux->discover.destroy(qmux->discover.user_data);
+
 	if (qmux->shutdown_idle)
 		l_idle_remove(qmux->shutdown_idle);
 
@@ -1658,7 +1624,6 @@ static int qmi_device_qmux_shutdown(struct qmi_device *device,
 
 static const struct qmi_device_ops qmux_ops = {
 	.write = qmi_device_qmux_write,
-	.discover = qmi_device_qmux_discover,
 	.client_release = qmi_device_qmux_client_release,
 	.shutdown = qmi_device_qmux_shutdown,
 };
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 1158600989c5..152ebf1eb14b 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -58,7 +58,7 @@ struct qmi_service;
 
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
-typedef void (*qmi_discover_func_t)(void *user_data);
+typedef void (*qmi_qmux_device_discover_func_t)(void *user_data);
 typedef void (*qmi_qmux_device_create_client_func_t)(struct qmi_service *,
 							void *user_data);
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
index 7570a7db3876..e39ea6c4ed0e 100644
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

