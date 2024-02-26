Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05512B159
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961706; cv=none; b=CZPTGYjAjHm2GfXGLYCY4RdYPtlWeGLBP95jiqTMjX6MDNVIWFPOUy1REu+Ztz0M1oAToJ13Dfr8jXhmQCuGQA31L3+XcGfmqtTEtexFVlYPS2uUnA2ZBYk6x7BDzZDggvapoc9JUVXx/XVEHD9ju8wBF1thvaua4ug6ylqxokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961706; c=relaxed/simple;
	bh=Xeve0rSnXSK5w8DATuSfL23KzD4CI3qpNud37y1V9/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp9RQwGAqbPsoMSZPLqQth9XhJ6n5hILxpUyDJ09U7gc3eVGz9sSMfSJaNrFuipsR0ObMY2CDtOIeAt8SYSXWSvu9r6G38KlTnnh5uN0zSa9hJFumj61Z35Fs/cneEmZ0pBlFQ9u/P7YCAILAuoUO4mNhmxTqT0PccimjcmukKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miBQSGid; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miBQSGid"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e2ee49ebaaso1322590a34.0
        for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961704; x=1709566504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvceYn3Jwwu9U3VaWr3he0ATxff4u7FWrlVaiSexfPk=;
        b=miBQSGidkdKWb5sEbHkO1idsQW1u+GHB5IEhFgKbcE9jaBp0noqooYMV08ok3Gt496
         Gmiz8PVvH8J6Y7cTzhykVo0d1d9QZZOFl3/LXZBBRGWTcDRCE1VYw+CpsKW/sNwgx0Kf
         ur9IljzZTcWt+5X1FSCZ3DA+3hTsFvaM+YjPZsQcXZ7a/Nt452eF4Xc0AsvGLwBjAm/Z
         FnvoRgIKT6NibvhjqvFiKXiRSs2ald/zrs6GD2+1ymo8/q72C+1MnxpJC4muirh+IeDc
         sIvzBMa31OeK9/N+175dZmU2g2a2Z6TUgitjoeSOG5TM1zLdDUKTlJLIyFzmx2Xv6hkq
         nVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961704; x=1709566504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvceYn3Jwwu9U3VaWr3he0ATxff4u7FWrlVaiSexfPk=;
        b=ViZKU2j7DR+Su05z4Z2goiTiByARFS4GXnV578x6+RVL2FLVaZna6bvNle10oYnoW3
         XQ/1hS1cUx+e+CeCWnGOhrpfrkE3jGIiR6wQaEJsd1TLRZfbv3ELAi8fJlec0sJBOS4d
         pyFXCt/0Eqwk5Ifqv/z5kgoOID2bUVqFgMtgtYMFTwP9fvzsuXsqRNo+mNuDCyRxwscs
         7942qoDOpMAAWqY2OQ76iYuXeZSvQlrIXhb2PmJPkaSpKKoOEM1WD+pPwpUs2/xZvVhY
         FKtmdzIzVRfJiNGsump4BtAFVbP74Jrfb9B6y4xjnR1Qdw25yGRFpIEz/PTiUgH1E4bb
         MYdg==
X-Gm-Message-State: AOJu0YwC7JTpSM/OqyFLawNU6K80D7sVNaNZu74eoQXaBUPy7vHOXABy
	1Tjdd/04LyGJ/SJiDTccz1aMHnMl3nfXKySDaT7jgLIRro3KwqkQabMi4D0e
X-Google-Smtp-Source: AGHT+IEJ1cqDXE4LcAu+GgnNZgFhIiX/W0kRPuQ1OI7h5cKw+NeJrwN6e94zqVeDdj54pEtKGWGGVA==
X-Received: by 2002:a05:6871:7292:b0:220:1870:2a7e with SMTP id mm18-20020a056871729200b0022018702a7emr2581797oac.46.1708961704232;
        Mon, 26 Feb 2024 07:35:04 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eg14-20020a056870988e00b002201144306csm567048oab.53.2024.02.26.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:35:04 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/8] qmi: Introduce __ctl_request_submit
Date: Mon, 26 Feb 2024 09:34:23 -0600
Message-ID: <20240226153459.1463304-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226153459.1463304-1-denkenz@gmail.com>
References: <20240226153459.1463304-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__request_submit was handling both CTL and non-CTL requests.  Split this
function into two, one for submitting CTL requests, and one that handles
normal service traffic.  This allows CTL requests to be isolated into
QMUX specific driver methods that use them.  While here, also move
next_control_tid member into the QMUX qmi_device subclass.
---
 drivers/qmimodem/qmi.c | 71 ++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index b08c1642c8c1..9843a9b33e5c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -77,7 +77,6 @@ struct qmi_device {
 	struct l_queue *control_queue;
 	struct l_queue *service_queue;
 	struct l_queue *discovery_queue;
-	uint8_t next_control_tid;
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
 	void *debug_data;
@@ -100,6 +99,7 @@ struct qmi_device_qmux {
 	qmi_destroy_func_t shutdown_destroy;
 	struct l_idle *shutdown_idle;
 	unsigned int release_users;
+	uint8_t next_control_tid;
 };
 
 struct qmi_service {
@@ -678,32 +678,18 @@ static void wakeup_writer(struct qmi_device *device)
 static uint16_t __request_submit(struct qmi_device *device,
 				struct qmi_request *req)
 {
-	struct qmi_mux_hdr *mux;
+	struct qmi_service_hdr *hdr =
+		(struct qmi_service_hdr *) &req->data[QMI_MUX_HDR_SIZE];
 
-	mux = (struct qmi_mux_hdr *) req->data;
+	hdr->type = 0x00;
+	hdr->transaction = device->next_service_tid++;
 
-	if (mux->service == QMI_SERVICE_CONTROL) {
-		struct qmi_control_hdr *hdr;
+	if (device->next_service_tid < 256)
+		device->next_service_tid = 256;
 
-		hdr = (struct qmi_control_hdr *) &req->data[QMI_MUX_HDR_SIZE];
-		hdr->type = 0x00;
-		hdr->transaction = device->next_control_tid++;
-		if (device->next_control_tid == 0)
-			device->next_control_tid = 1;
-		req->tid = hdr->transaction;
-	} else {
-		struct qmi_service_hdr *hdr;
-
-		hdr = (struct qmi_service_hdr *) &req->data[QMI_MUX_HDR_SIZE];
-		hdr->type = 0x00;
-		hdr->transaction = device->next_service_tid++;
-		if (device->next_service_tid < 256)
-			device->next_service_tid = 256;
-		req->tid = hdr->transaction;
-	}
+	req->tid = hdr->transaction;
 
 	l_queue_push_tail(device->req_queue, req);
-
 	wakeup_writer(device);
 
 	return req->tid;
@@ -934,7 +920,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 
 	device->service_list = l_hashmap_new();
 
-	device->next_control_tid = 1;
 	device->next_service_tid = 256;
 
 	device->ops = ops;
@@ -1310,6 +1295,26 @@ struct service_create_shared_data {
 	struct l_idle *idle;
 };
 
+static uint8_t __ctl_request_submit(struct qmi_device_qmux *qmux,
+					struct qmi_request *req)
+{
+	struct qmi_control_hdr *hdr =
+		(struct qmi_control_hdr *) &req->data[QMI_MUX_HDR_SIZE];
+
+	hdr->type = 0x00;
+	hdr->transaction = qmux->next_control_tid++;
+
+	if (qmux->next_control_tid == 0)
+		qmux->next_control_tid = 1;
+
+	req->tid = hdr->transaction;
+
+	l_queue_push_tail(qmux->super.req_queue, req);
+	wakeup_writer(&qmux->super);
+
+	return req->tid;
+}
+
 static void service_create_shared_reply(struct l_idle *idle, void *user_data)
 {
 	struct service_create_shared_data *data = user_data;
@@ -1386,18 +1391,18 @@ static void qmux_sync_callback(uint16_t message, uint16_t length,
 }
 
 /* sync will release all previous clients */
-static bool qmi_device_qmux_sync(struct qmi_device *device,
+static bool qmi_device_qmux_sync(struct qmi_device_qmux *qmux,
 					struct discover_data *data)
 {
 	struct qmi_request *req;
 
-	__debug_device(device, "Sending sync to reset QMI");
+	__debug_device(&qmux->super, "Sending sync to reset QMI");
 
 	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
 				QMI_CTL_SYNC, NULL, 0,
 				qmux_sync_callback, data);
 
-	__request_submit(device, req);
+	__ctl_request_submit(qmux, req);
 
 	return true;
 }
@@ -1479,7 +1484,7 @@ done:
 	/* if the device support the QMI call SYNC over the CTL interface */
 	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
 			qmux->control_major > 1) {
-		qmi_device_qmux_sync(data->device, data);
+		qmi_device_qmux_sync(qmux, data);
 		return;
 	}
 
@@ -1516,6 +1521,8 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 					void *user_data,
 					qmi_destroy_func_t destroy)
 {
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
 	struct discover_data *data;
 	struct qmi_request *req;
 
@@ -1536,7 +1543,7 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, qmux_discover_callback, data);
 
-	data->tid = __request_submit(device, req);
+	data->tid = __ctl_request_submit(qmux, req);
 	data->timeout = l_timeout_create(5, qmux_discover_reply_timeout,
 								data, NULL);
 
@@ -1662,6 +1669,8 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 					qmi_create_func_t func, void *user_data,
 					qmi_destroy_func_t destroy)
 {
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
 	struct qmi_request *req;
 	struct qmux_client_create_data *data;
@@ -1697,7 +1706,7 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 			client_req, sizeof(client_req),
 			qmux_client_create_callback, data);
 
-	data->tid = __request_submit(device, req);
+	data->tid = __ctl_request_submit(qmux, req);
 	data->timeout = l_timeout_create(8, qmux_client_create_reply,
 								data, NULL);
 
@@ -1734,7 +1743,7 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 			release_req, sizeof(release_req),
 			qmux_client_release_callback, qmux);
 
-	__request_submit(device, req);
+	__ctl_request_submit(qmux, req);
 }
 
 static void qmux_shutdown_destroy(void *user_data)
@@ -1829,6 +1838,8 @@ struct qmi_device *qmi_device_new_qmux(const char *device)
 		return NULL;
 	}
 
+	qmux->next_control_tid = 1;
+
 	return &qmux->super;
 }
 
-- 
2.43.0

