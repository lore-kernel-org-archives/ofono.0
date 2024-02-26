Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5612AAE1
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961704; cv=none; b=f50oM7Ob2xdlBFjbWqNCfjT7gGLzemKpZB7y4OuUz+VeKsn50WaMWftE1nScgD4pcPRqmCmEdqgsv2HiqXJeb/Seoii+3ySIhi0D7yy7UG363X8/2MndIcunHxnYX7uaL4dSOqxDktG9u53Yt5owuY0jZfaDUCDd7NsjDWU7XVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961704; c=relaxed/simple;
	bh=GlFvrwjbb6i5fHVEEfO5aiU7+RN7gClME9TcKMwfAqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbAFTxgdDSv21e1jeTsU8vQ6AY/n4De7Apc4QSU+g8W+rgfsZ4Lw4KKQMOp1OG0InsxsAfN1zw/NpmahoSfp+tEk3MF3gXZ9N4UydBoaxmQr/19YE95HQnFVwlKRpsnVBR/mE8mDBemEeCfBp1FRpQJKb7f3mHM93ptAVV8CrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFukQO+r; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFukQO+r"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e4a803c72aso182151a34.3
        for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961702; x=1709566502; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gaC3OFlbo8ouJ+UUjpgzjnVJ3/t7dzxE6gPU2Hm7x1M=;
        b=hFukQO+rgmK6l1qaPPYe+O+XQXJg/dCbJsyb2oqpEhyGk+/hOpJA9AVJHpLJO8VI1C
         X/e0aGvO++SU4hWO/39MGkxjhPrvB7OLoQmM6Njc8Kz3CWbNm+7UhYN2ansOmFVWl8Sc
         3bbOTAmvn6UNI8PbXjVP7Y6EyXY/nkw9Ahd9q3gY8lIL6TMgeYnj37xm0SdwbMJaaTz3
         G5ZXcuqVEX8uZgMudgztnZBUStiJ1ij6sVcmeaN6XvkYO4azw3N65ytBL7PmgNosTt5F
         YIbdj71Fle8HSe2VujOm7DRBw9yqgPeytrh3chpIxi/yRWVpQfE8NnXDqilA9rZ6NWvv
         IH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961702; x=1709566502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaC3OFlbo8ouJ+UUjpgzjnVJ3/t7dzxE6gPU2Hm7x1M=;
        b=Igim6WEg73UcYnzP7k3DAzT0U/SdL//AeFYPFVX28JYPRmtFwn1kn7ALmvQ7MHQ3SV
         4gd2Uv/quzdKQQyAhPn3N3PH1D3Bx/bQq9p68QBzno2X9iSEcKPXmt5wlMl7XiDqrQ3P
         N+31zjhOqraqkspY8HN1ILX55qjmozl8mG49Njw4uHNVrYNQOUPOmUoUrxpmQdC/zFyx
         X2EqNsBZNybldmeRnXoq5IgpBXWkYadk4kQ4e00HnK7+QIeDqG86DxjEPDdBle8oMsbZ
         YS55i4MmkRucHhg2/6vBzwONPjiFnwXORo4sAXQZWGye4/D7QZzJKFyl6YI6VZMxhROE
         sK3g==
X-Gm-Message-State: AOJu0YxEw4S7LQKr2veUAGGwoSEvQxQo29qN8oP/jxNiCK5E2zCFx+lQ
	r092o0aFWK1B/uTw5WRr2dl2IO/rZFa1E/eDxmmw7AQnBPgN5rnKUqHhjuXd
X-Google-Smtp-Source: AGHT+IGHgQYsqb/OPpUIWTBw/e/3atb0440xVLlaWRR/LGlyaleCFFeCOKaS501jE/S+RPODncL88w==
X-Received: by 2002:a05:6870:514f:b0:21f:828:7a7c with SMTP id z15-20020a056870514f00b0021f08287a7cmr9920314oak.6.1708961702056;
        Mon, 26 Feb 2024 07:35:02 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eg14-20020a056870988e00b002201144306csm567048oab.53.2024.02.26.07.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:35:01 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/8] qmi: Use FAM instead of allocating a member
Date: Mon, 26 Feb 2024 09:34:20 -0600
Message-ID: <20240226153459.1463304-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of allocating a separate buffer inside the request object, use a
flexible array member (FAM).  This allows the request metadata and data
to be allocated within the same memory region.  The only downside is
that the data buffer is not released once the request has been sent over
the socket.  Since most requests are quite small, this shouldn't affect
performance.
---
 drivers/qmimodem/qmi.c | 45 ++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 22702b41a77a..652f19fb6cd0 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -129,10 +129,10 @@ struct qmi_result {
 struct qmi_request {
 	uint16_t tid;
 	uint8_t client;
-	void *buf;
-	size_t len;
 	qmi_message_func_t callback;
 	void *user_data;
+	uint16_t len;
+	uint8_t data[];
 };
 
 struct qmi_notify {
@@ -192,22 +192,20 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	struct qmi_request *req;
 	struct qmi_mux_hdr *hdr;
 	struct qmi_message_hdr *msg;
-	uint16_t headroom;
-
-	req = l_new(struct qmi_request, 1);
+	uint16_t hdrlen = QMI_MUX_HDR_SIZE;
+	uint16_t msglen;
 
 	if (service == QMI_SERVICE_CONTROL)
-		headroom = QMI_CONTROL_HDR_SIZE;
+		hdrlen += QMI_CONTROL_HDR_SIZE;
 	else
-		headroom = QMI_SERVICE_HDR_SIZE;
-
-	req->len = QMI_MUX_HDR_SIZE + headroom + QMI_MESSAGE_HDR_SIZE + length;
-
-	req->buf = l_malloc(req->len);
+		hdrlen += QMI_SERVICE_HDR_SIZE;
 
+	msglen = hdrlen + QMI_MESSAGE_HDR_SIZE + length;
+	req = l_malloc(sizeof(struct qmi_request) + msglen);
+	req->len = msglen;
 	req->client = client;
 
-	hdr = req->buf;
+	hdr = (struct qmi_mux_hdr *) req->data;
 
 	hdr->frame = 0x01;
 	hdr->length = L_CPU_TO_LE16(req->len - 1);
@@ -215,14 +213,13 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	hdr->service = service;
 	hdr->client = client;
 
-	msg = req->buf + QMI_MUX_HDR_SIZE + headroom;
+	msg = (struct qmi_message_hdr *) &req->data[hdrlen];
 
 	msg->message = L_CPU_TO_LE16(message);
 	msg->length = L_CPU_TO_LE16(length);
 
 	if (data && length > 0)
-		memcpy(req->buf + QMI_MUX_HDR_SIZE + headroom +
-					QMI_MESSAGE_HDR_SIZE, data, length);
+		memcpy(req->data + hdrlen + QMI_MESSAGE_HDR_SIZE, data, length);
 
 	req->callback = func;
 	req->user_data = user_data;
@@ -234,7 +231,6 @@ static void __request_free(void *data)
 {
 	struct qmi_request *req = data;
 
-	l_free(req->buf);
 	l_free(req);
 }
 
@@ -637,26 +633,23 @@ static bool can_write_data(struct l_io *io, void *user_data)
 	if (!req)
 		return false;
 
-	bytes_written = write(l_io_get_fd(device->io), req->buf, req->len);
+	bytes_written = write(l_io_get_fd(device->io), req->data, req->len);
 	if (bytes_written < 0)
 		return false;
 
-	l_util_hexdump(false, req->buf, bytes_written,
+	l_util_hexdump(false, req->data, bytes_written,
 			device->debug_func, device->debug_data);
 
-	__debug_msg(' ', req->buf, bytes_written,
+	__debug_msg(' ', req->data, bytes_written,
 				device->debug_func, device->debug_data);
 
-	hdr = req->buf;
+	hdr = (struct qmi_mux_hdr *) req->data;
 
 	if (hdr->service == QMI_SERVICE_CONTROL)
 		l_queue_push_tail(device->control_queue, req);
 	else
 		l_queue_push_tail(device->service_queue, req);
 
-	l_free(req->buf);
-	req->buf = NULL;
-
 	if (l_queue_length(device->req_queue) > 0)
 		return true;
 
@@ -686,12 +679,12 @@ static uint16_t __request_submit(struct qmi_device *device,
 {
 	struct qmi_mux_hdr *mux;
 
-	mux = req->buf;
+	mux = (struct qmi_mux_hdr *) req->data;
 
 	if (mux->service == QMI_SERVICE_CONTROL) {
 		struct qmi_control_hdr *hdr;
 
-		hdr = req->buf + QMI_MUX_HDR_SIZE;
+		hdr = (struct qmi_control_hdr *) &req->data[QMI_MUX_HDR_SIZE];
 		hdr->type = 0x00;
 		hdr->transaction = device->next_control_tid++;
 		if (device->next_control_tid == 0)
@@ -700,7 +693,7 @@ static uint16_t __request_submit(struct qmi_device *device,
 	} else {
 		struct qmi_service_hdr *hdr;
 
-		hdr = req->buf + QMI_MUX_HDR_SIZE;
+		hdr = (struct qmi_service_hdr *) &req->data[QMI_MUX_HDR_SIZE];
 		hdr->type = 0x00;
 		hdr->transaction = device->next_service_tid++;
 		if (device->next_service_tid < 256)
-- 
2.43.0

