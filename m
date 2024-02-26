Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF312BE96
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961709; cv=none; b=njoa1UBTfw3kByLZm2r9Zm+fWNbJ9M2kpzjRecI6BsBk+i8cLNCt7ohrbGhx4OcZN8paryzAeilkafajaS8sAw9kAwNqMmoijFCMuFt1192Hr1c/gcqYTAS22nqkf59fQ3qSrFdqaAqfxe7s7JQR4e63Qi0oMrK6QwJhCwxISv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961709; c=relaxed/simple;
	bh=UbSADqgYldh/xATUh77EQyTdLcREq+26WctghklYPXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekEyH83QaECc+qmbg9C1MHaTDsrIoxtc7I7PhgWDIyYV3C6VpahjvObHHU5dcnuG28UzAVR9E4yyv057gDbtE/mRoYMshRxiuyBMBDkQGFUE4Gs3GHjPaQFV9IaGSBqyY/t7MzUaVtAZ6iRtAgkuOrbeTzEd1tCr4svIFPO5GTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM3pp4HU; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM3pp4HU"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21f2f813e3bso1206383fac.0
        for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961706; x=1709566506; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CapTx0RywUqOfvsfwbDHkXRxcsLss7bEilJRojg6BQc=;
        b=UM3pp4HUxeB0UkIFXUF0lJNcQtrP7EB7KH2tQXqLatrKwGERb8Cd/x1ancqgIVQiPK
         HJoXjwAuOsSb4ffpW1AWcf1SIs1hs6lFCKrcURMkWM3cL/DXxgIF8l4mmY0U8Awl8p2S
         IVFlY+MlFxT+lSvFjRs+phuBOGGSwqRtGeI17/kdE0JZfdCegdYi6nwnVGhUgw0CBzbC
         JayLIb7Gx0BSno1n/R+5yK6y9PJXwA/r0nccfFCERRjDhEjGpKQ0FfGewa58Tgk7wf6r
         wjuFp5YEdq0+sYwycYk109RzvASnLMlPFMV2+pgiZy/aAfrIW6+uYl/eKtZcIqlTstrr
         W23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961706; x=1709566506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CapTx0RywUqOfvsfwbDHkXRxcsLss7bEilJRojg6BQc=;
        b=r7EDmMLQz6JwHE/3tMhrcUsfAbcjTYr9WHRydPd/4T6Mmml06J757SGZcb4ne7fTi7
         IjMhMgt39Mle5Mk4Vsoe8FMdOQtA4vFZsCKi2Bo2791iiQZP2dvaSkeT37B9dz5+JjSv
         NYE9/A0jSGflvccqg6Xvy9eyXj+taTpuISrG9vLiScz/wg8MV1wHJrqa/rWTq4SeI3gD
         S+ELAmuX6c2Mq4gFLtR9LVrxnLPEtJxZPBsQqW/LW54cRM7kZCRZm25xdTmrOthsoft+
         4PhU3tgxEE0GDs93XWMjed3sTc3tiVIDfC1OXY5Mgs89/YquDSWem+t+l+adYktRH6wW
         Zr+Q==
X-Gm-Message-State: AOJu0Yw5bHeqJHkINZdADq/odETAq+SqJgIAjl+Figh2ayRgtA0aIBU+
	UWNqyRQkzET/CirbaCsDY6c/yL9d/KVi7cf7Iml9JLwTHYE8tDxjpU+SpQdW
X-Google-Smtp-Source: AGHT+IGJc0aYgGpxRZ4z4n3J10kIA78Im4kyxQmV8tN5forQeLRKWdqen4VASjuMGfOCSOG+0pXi3Q==
X-Received: by 2002:a05:6870:4153:b0:21e:6c0d:41c8 with SMTP id r19-20020a056870415300b0021e6c0d41c8mr3500844oad.16.1708961706653;
        Mon, 26 Feb 2024 07:35:06 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eg14-20020a056870988e00b002201144306csm567048oab.53.2024.02.26.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:35:06 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 7/8] qmi: Move control_queue member to qmux subclass
Date: Mon, 26 Feb 2024 09:34:26 -0600
Message-ID: <20240226153459.1463304-7-denkenz@gmail.com>
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

control_queue is only used by the QMUX transport.  Move it out from the
qmi_device structure into the QMUX specific qmi_device_qmux structure.
---
 drivers/qmimodem/qmi.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2af1d6463783..2371f178a4c4 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -84,7 +84,6 @@ struct qmi_device_ops {
 struct qmi_device {
 	struct l_io *io;
 	struct l_queue *req_queue;
-	struct l_queue *control_queue;
 	struct l_queue *service_queue;
 	struct l_queue *discovery_queue;
 	uint16_t next_service_tid;
@@ -110,6 +109,7 @@ struct qmi_device_qmux {
 	struct l_idle *shutdown_idle;
 	unsigned int release_users;
 	uint8_t next_control_tid;
+	struct l_queue *control_queue;
 };
 
 struct qmi_service {
@@ -820,7 +820,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 	l_io_set_close_on_destroy(device->io, true);
 
 	device->req_queue = l_queue_new();
-	device->control_queue = l_queue_new();
 	device->service_queue = l_queue_new();
 	device->discovery_queue = l_queue_new();
 
@@ -846,7 +845,6 @@ void qmi_device_free(struct qmi_device *device)
 
 	__debug_device(device, "device %p free", device);
 
-	l_queue_destroy(device->control_queue, __request_free);
 	l_queue_destroy(device->service_queue, __request_free);
 	l_queue_destroy(device->req_queue, __request_free);
 	l_queue_destroy(device->discovery_queue, __discovery_free);
@@ -1194,6 +1192,8 @@ done:
 static int qmi_device_qmux_write(struct qmi_device *device,
 					struct qmi_request *req)
 {
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
 	struct qmi_mux_hdr *hdr;
 	ssize_t bytes_written;
 
@@ -1210,7 +1210,7 @@ static int qmi_device_qmux_write(struct qmi_device *device,
 	hdr = (struct qmi_mux_hdr *) req->data;
 
 	if (hdr->service == QMI_SERVICE_CONTROL)
-		l_queue_push_tail(device->control_queue, req);
+		l_queue_push_tail(qmux->control_queue, req);
 	else
 		l_queue_push_tail(device->service_queue, req);
 
@@ -1243,7 +1243,7 @@ static void __rx_ctl_message(struct qmi_device_qmux *qmux,
 		return;
 	}
 
-	req = l_queue_remove_if(qmux->super.control_queue, __request_compare,
+	req = l_queue_remove_if(qmux->control_queue, __request_compare,
 						L_UINT_TO_PTR(tid));
 	if (!req)
 		return;
@@ -1383,22 +1383,21 @@ static void service_create_shared_data_free(void *user_data)
 	l_free(data);
 }
 
-static struct qmi_request *find_control_request(struct qmi_device *device,
+static struct qmi_request *find_control_request(struct qmi_device_qmux *qmux,
 						uint16_t tid)
 {
-	struct qmi_request *req = NULL;
-	unsigned int _tid = tid;
+	struct qmi_request *req;
 
-	if (_tid != 0) {
-		req = l_queue_remove_if(device->req_queue, __request_compare,
-						L_UINT_TO_PTR(_tid));
+	if (!tid)
+		return NULL;
 
-		if (!req)
-			req = l_queue_remove_if(device->control_queue,
-							__request_compare,
-							L_UINT_TO_PTR(_tid));
-	}
+	req = l_queue_remove_if(qmux->super.req_queue,
+					__request_compare, L_UINT_TO_PTR(tid));
+	if (req)
+		return req;
 
+	req = l_queue_remove_if(qmux->control_queue,
+					__request_compare, L_UINT_TO_PTR(tid));
 	return req;
 }
 
@@ -1522,13 +1521,15 @@ static void qmux_discover_reply_timeout(struct l_timeout *timeout,
 {
 	struct discover_data *data = user_data;
 	struct qmi_device *device = data->device;
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
 	struct qmi_request *req;
 
 	l_timeout_remove(data->timeout);
 	data->timeout = NULL;
 
 	/* remove request from queues */
-	req = find_control_request(device, data->tid);
+	req = find_control_request(qmux, data->tid);
 
 	if (data->func)
 		data->func(data->user_data);
@@ -1605,6 +1606,8 @@ static void qmux_client_create_reply(struct l_timeout *timeout, void *user_data)
 {
 	struct qmux_client_create_data *data = user_data;
 	struct qmi_device *device = data->device;
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
 	struct qmi_request *req;
 
 	DBG("");
@@ -1612,7 +1615,7 @@ static void qmux_client_create_reply(struct l_timeout *timeout, void *user_data)
 	service_create_shared_pending_reply(device, data->type, NULL);
 
 	/* remove request from queues */
-	req = find_control_request(device, data->tid);
+	req = find_control_request(qmux, data->tid);
 
 	l_timeout_remove(data->timeout);
 	data->timeout = NULL;
@@ -1829,6 +1832,8 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 
+	l_queue_destroy(qmux->control_queue, __request_free);
+
 	if (qmux->shutdown_idle)
 		l_idle_remove(qmux->shutdown_idle);
 
@@ -1863,6 +1868,7 @@ struct qmi_device *qmi_device_new_qmux(const char *device)
 	}
 
 	qmux->next_control_tid = 1;
+	qmux->control_queue = l_queue_new();
 	l_io_set_read_handler(qmux->super.io, received_qmux_data, qmux, NULL);
 
 	return &qmux->super;
-- 
2.43.0

