Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2AB39FC7
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622129; cv=none; b=L/YiCQPP2CAhnX4jKLznmfSNXgGv1xHI6md2xV5SmomkpdOJsivBvUMMYqaqctSL75vjXgXBXRWKXwMwn1pxmBLC/keBDNoGQ1m2c+mK797f3FMePMv60AtIDFYO4L10lM/fLq7/Fu31hu6VoOV6UEy3O9qEw+kbUIUTcqo+7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622129; c=relaxed/simple;
	bh=XimFDxnGu9aNf9IZidH/osLeXXM9BbEFCGuhoIrJ3NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6Y839ZGlQf8D1oCFKKSSGZQv7AzQX0nKBd9PS14yrJKIjlPFzJOc5MakJ19vvBpa5cNSbaSgMdeIUqzf1ZU6Y1uFkH/psoWbEZI75NuTKf3ZfxYzi3lYD0f5nOAqbIdV9UjaG5q5wLz573OHHsM2IuUXrRvD3EaKb6c+4qMwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3sZMES4; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3sZMES4"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c15b7b36bbso754092b6e.1
        for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 09:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622127; x=1709226927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZGOSGeE/jrsfV9okl7aggWgZdx42Y02vzP071GRclQ=;
        b=g3sZMES44Gy33vRjfPOMSHAhkHCrm0rgjsXURWLGEtje41YHox9Z8wcil+Y+uLoCS7
         MAqKbDKZw7Wa7FCpmltC6/lbO1Va5fmfz7nWcM/hrBlKMj8g9bSfoV4MyYcHH2cLvxaA
         7YNd/e/xROwN+L4LJDuqUP0eFRThbsB4VPUIBXT67MRGrDQSzUW4UCLGFnwlwTgvHmsp
         k9A6nfMxBaViRIR0I4URo+Z9lnaUcGnIzxXABp3NiPDk7dQ1e3hQJgvSQzPvNOwRmh8H
         dTKWuo8C0i1TIOBw958OgR8Soz0ULJlo5Pkh851DLqWieMSXvU78QqcD9U9MjRVRXUcj
         Vlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622127; x=1709226927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZGOSGeE/jrsfV9okl7aggWgZdx42Y02vzP071GRclQ=;
        b=NvL7WmgWjWjG9B5+d6aeOR11BxoUfYH35MqRDT7zG6LMzmzMb8Jm/yEJJ0uRvjL8vt
         I/QJx4zUZroXL7JfTqfT4MscQCZrR6fprZTezlObhLqJe6MtvR11LdtGX9SRH339xH9S
         vCgkv7sRaMUThA+FKwicZQ0Y4jyTnC1yp3wS4B+mmxh9KFRwTIE6JfjFmgbyo5PJ+qlV
         PX7c1Jo/3swoDKEkh8467sZjSs5FmABmTCTJJYTnHEicBrjPHdaAXjbScA4L4MK06ziA
         bfo/CYmXLpPF63XD8YXYsz1QGiloSwKaLhPDa+mI2GSCQmW3lPy9jacln9hzgXLaoGhC
         kZAg==
X-Gm-Message-State: AOJu0Yw+0MjwKJrnsbdqQ7wXlvJt1NKrB2/ZwHe88eG6ZkSp/S2PD8Ep
	uTCb3AlSk+pC/+V+3xpkK4vVPwH7nE4VsL9LQVg0YILyvIp2VqaHusYgJ0dz
X-Google-Smtp-Source: AGHT+IFb8qOYaLegEvhhukJ6ubu3Sks65XEtmZGly8FfYMe0xeAxOjvo0BWw51OuYHu3VYQ1FKBy1Q==
X-Received: by 2002:a05:6808:1688:b0:3c0:449c:b6a5 with SMTP id bb8-20020a056808168800b003c0449cb6a5mr27712956oib.0.1708622127021;
        Thu, 22 Feb 2024 09:15:27 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cc7-20020a056808324700b003c178f6a504sm355898oib.14.2024.02.22.09.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:15:26 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/4] qmi: Introduce client_release driver method
Date: Thu, 22 Feb 2024 11:14:19 -0600
Message-ID: <20240222171438.1291553-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222171438.1291553-1-denkenz@gmail.com>
References: <20240222171438.1291553-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When shutting down, any requested QMUX clients must be released
properly.  This is handled by sending a QMUX Control message with the
service type and client id.  QRTR doesn't have such a concept, a client
is closed by virtue of closing the socket.  Abstract away the
implementation details behind client_release() driver method.
---
 drivers/qmimodem/qmi.c | 76 +++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 8587766efe1f..b2f0f72190a1 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -56,6 +56,8 @@ struct qmi_version {
 };
 
 struct qmi_device_ops {
+	void (*client_release)(struct qmi_device *device,
+				uint16_t service_type, uint16_t client_id);
 	int (*shutdown)(struct qmi_device *device,
 			qmi_shutdown_func_t shutdown_func,
 			void *user, qmi_destroy_func_t destroy);
@@ -78,7 +80,6 @@ struct qmi_device {
 	struct qmi_version *version_list;
 	uint8_t version_count;
 	struct l_hashmap *service_list;
-	unsigned int release_users;
 	const struct qmi_device_ops *ops;
 	bool shutting_down : 1;
 	bool destroyed : 1;
@@ -93,6 +94,7 @@ struct qmi_device_qmux {
 	void *shutdown_user_data;
 	qmi_destroy_func_t shutdown_destroy;
 	struct l_idle *shutdown_idle;
+	unsigned int release_users;
 };
 
 struct qmi_service {
@@ -1312,21 +1314,6 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 	return true;
 }
 
-static void release_client(struct qmi_device *device,
-				uint8_t type, uint8_t client_id,
-				qmi_message_func_t func, void *user_data)
-{
-	unsigned char release_req[] = { 0x01, 0x02, 0x00, type, client_id };
-	struct qmi_request *req;
-
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_RELEASE_CLIENT_ID,
-			release_req, sizeof(release_req),
-			func, user_data);
-
-	__request_submit(device, req);
-}
-
 int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
@@ -1535,7 +1522,34 @@ done:
 	return res;
 }
 
-static void qmux_shutdown_destroy(void *user_data)
+static void qmux_client_release_callback(uint16_t message, uint16_t length,
+					const void *buffer, void *user_data)
+{
+	struct qmi_device_qmux *qmux = user_data;
+
+	qmux->release_users--;
+}
+
+static void qmi_device_qmux_client_release(struct qmi_device *device,
+						uint16_t service_type,
+						uint16_t client_id)
+{
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
+	uint8_t release_req[] = { 0x01, 0x02, 0x00, service_type, client_id };
+	struct qmi_request *req;
+
+	qmux->release_users++;
+
+	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+			QMI_CTL_RELEASE_CLIENT_ID,
+			release_req, sizeof(release_req),
+			qmux_client_release_callback, qmux);
+
+	__request_submit(device, req);
+}
+
+static void qmux_shutdown_destroy(gpointer user_data)
 {
 	struct qmi_device_qmux *qmux = user_data;
 
@@ -1551,7 +1565,7 @@ static void qmux_shutdown_callback(struct l_idle *idle, void *user_data)
 {
 	struct qmi_device_qmux *qmux = user_data;
 
-	if (qmux->super.release_users > 0)
+	if (qmux->release_users > 0)
 		return;
 
 	qmux->super.shutting_down = true;
@@ -1603,6 +1617,7 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 }
 
 static const struct qmi_device_ops qmux_ops = {
+	.client_release = qmi_device_qmux_client_release,
 	.shutdown = qmi_device_qmux_shutdown,
 	.destroy = qmi_device_qmux_destroy,
 };
@@ -2191,17 +2206,6 @@ bool qmi_service_create(struct qmi_device *device,
 						user_data, destroy);
 }
 
-static void service_release_callback(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data)
-{
-	struct qmi_service *service = user_data;
-
-	if (service->device)
-		service->device->release_users--;
-
-	l_free(service);
-}
-
 struct qmi_service *qmi_service_ref(struct qmi_service *service)
 {
 	if (!service)
@@ -2214,6 +2218,7 @@ struct qmi_service *qmi_service_ref(struct qmi_service *service)
 
 void qmi_service_unref(struct qmi_service *service)
 {
+	struct qmi_device *device;
 	unsigned int hash_id;
 
 	if (!service)
@@ -2222,7 +2227,8 @@ void qmi_service_unref(struct qmi_service *service)
 	if (__sync_sub_and_fetch(&service->ref_count, 1))
 		return;
 
-	if (!service->device) {
+	device = service->device;
+	if (!device) {
 		l_free(service);
 		return;
 	}
@@ -2232,13 +2238,13 @@ void qmi_service_unref(struct qmi_service *service)
 
 	hash_id = service->type | (service->client_id << 8);
 
-	l_hashmap_remove(service->device->service_list,
-				L_UINT_TO_PTR(hash_id));
+	l_hashmap_remove(device->service_list, L_UINT_TO_PTR(hash_id));
 
-	service->device->release_users++;
+	if (device->ops->client_release)
+		device->ops->client_release(device, service->type,
+							service->client_id);
 
-	release_client(service->device, service->type, service->client_id,
-					service_release_callback, service);
+	l_free(service);
 }
 
 const char *qmi_service_get_identifier(struct qmi_service *service)
-- 
2.43.0

