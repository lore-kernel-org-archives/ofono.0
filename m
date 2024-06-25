Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3BF174EDB
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333732; cv=none; b=oTkdYy8cHySEpY5OMMlntdNBxv7h316C3cWxrw8RMCJoe25tAWNOwlGbhTL3/OVYzNAR8Ks6filEDD6/A9Z4GjGQe6X1N3NoaBVOf+kORzxF9z8rB/wZkNWxhg/5UZTf7634LfYYZTByBYQImT3OtrXxLSCmWyYFiqQlCMIvpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333732; c=relaxed/simple;
	bh=+PU0Xu9x/C9ZAoFWH87Y3iEsdnsJqBZcrK13s8QAfzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f13JSWCHMQRZp8YZKZ7nPhs6DmRpNm3mjkqrG/ZabGSJ3Encodqkm6TnC17u6K6kZFMP6Uo+fNkA8sq3dqEO73vk8knsBT6t2fcGvH9kzSyNAiRmamSvAxc/k0EpJ2R2RQlXb0WmD+Ao1eszqRE/h+T+Xu52igG6GlczMQ3eKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRG0VM4e; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRG0VM4e"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-700cd43564eso246600a34.1
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333730; x=1719938530; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0PgN25RgsZ3iA8ftMEVOI7/8bdomop36UcJIG9G5KE=;
        b=GRG0VM4evKCr2rz46VdQMOmCi/FmigEr2ohYjxTAqFz6sbrM+mM/CfukFLLrw5iegA
         7yD3dmTPhHep95/7CUugKsRFYpNh1EdjG+iIDuHk64FhOHWtaRqXN9yDLKGaI0Kj6817
         9pf3UYXB8oi4CjN7Z/tCZUoHzNP9opskmeV8vw5ZmtFB/bbZKqiwxtyTCg3zyja8gSZe
         DA5HLsEB9RmL3texI0u128ZLS3rcP154dml4aMjz9dret3nNsOUmUGiBwO1u1SAc5iiF
         b+z8ixBcKbw7J/zzgy3O80HrISf2S/Ubk/Ch5d4ASD4SwiaaOqn/H6wjiU0j9jvfryyN
         G+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333730; x=1719938530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0PgN25RgsZ3iA8ftMEVOI7/8bdomop36UcJIG9G5KE=;
        b=FnlHbcptzbld8nrI2jn5CFFLJF7ZX3vY63eL3YwzNUaDiX8+hkM/28HbTQrzyeOC6a
         pL392sXTpSS0ylfyczpX2EHHsBd7cS33m0hHX9QkULZNy5lE/b+rpsfST8S5VEu212oI
         /5nsCNnD3NcbVNaD6UqFUMjYxattrojkd8laKFVxH6CSWfkTFhLaQFUzkstFHo6TtSw4
         0EVwNJZTK0y0DYKWbn5lMwR7Un8bJ4JGVsmwlqacfO6nQiLG5O9fo7bWjCtgsjWXuDQw
         3Wae8B8hCy0qU5gMfKMWTi2yWy/kzwYdekdhuxDYLFHT5MRhYyusixZcK7DDeXUNFjgC
         UTuw==
X-Gm-Message-State: AOJu0YybVMb1SgICtajLiFegQlmKOxo47E/BrsaiPeN4oTxCd6EDG01J
	TErIMmYQ3meon8xOR5n1nGOXARultMKgqhI6PxHm/+bx7HJoT8gNxHcvZg==
X-Google-Smtp-Source: AGHT+IEMQqBUY3vVTsUvNQDhJsjiJ8AvEGs+qeqzqj4yrDVV7Zq1yWQwDpbXOeOCIIEkrXhcOX2SEg==
X-Received: by 2002:a9d:63c3:0:b0:700:ae03:7645 with SMTP id 46e09a7af769-700ae037700mr8817482a34.31.1719333730015;
        Tue, 25 Jun 2024 09:42:10 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:09 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 10/14] qmi: Move release_client operation into service_family
Date: Tue, 25 Jun 2024 11:41:46 -0500
Message-ID: <20240625164158.1170937-10-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240625164158.1170937-1-denkenz@gmail.com>
References: <20240625164158.1170937-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qmi_device has been renamed into qmi_transport which now encapsulated
the details of maintaining a list of outstanding requests, active
service families and low-level tx/rx details.  The client_remove
operation is now out of place and logically fits much better on the
service_family object.

Remove the release_client operation from qmi_transport_ops.  Introduce
two specializations of service_family for qrtr and qmux respectively.
Release of QMUX clients will now be triggered when the QMUX service
family object is destroyed.
---
 drivers/qmimodem/qmi.c | 121 +++++++++++++++++++++++++----------------
 1 file changed, 74 insertions(+), 47 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a2b5e652ef93..5720218072bc 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -81,8 +81,6 @@ struct debug_data {
 
 struct qmi_transport_ops {
 	int (*write)(struct qmi_transport *transport, struct qmi_request *req);
-	void (*client_release)(struct qmi_transport *transport,
-				uint16_t service_type, uint16_t client_id);
 };
 
 struct qmi_transport {
@@ -132,6 +130,7 @@ struct service_family {
 	uint16_t next_notify_id;
 	unsigned int next_service_handle;
 	struct l_queue *notify_list;
+	void (*free_family)(struct service_family *family);
 };
 
 struct qmi_service {
@@ -1078,14 +1077,9 @@ static void service_family_unref(struct service_family *family)
 	l_hashmap_remove(transport->family_list,
 				L_UINT_TO_PTR(family->info.service_type));
 
-	if (transport->ops->client_release)
-		transport->ops->client_release(transport,
-						family->info.service_type,
-						family->client_id);
-
 done:
 	l_queue_destroy(family->notify_list, NULL);
-	l_free(family);
+	family->free_family(family);
 }
 
 static uint8_t __ctl_request_submit(struct qmi_qmux_device *qmux,
@@ -1110,21 +1104,18 @@ static uint8_t __ctl_request_submit(struct qmi_qmux_device *qmux,
 	return req->tid;
 }
 
-static struct service_family *service_family_create(
-			struct qmi_transport *transport,
-			unsigned int group_id,
-			const struct qmi_service_info *info, uint8_t client_id)
+static void __service_family_init(struct service_family *family,
+					struct qmi_transport *transport,
+					unsigned int group_id,
+					const struct qmi_service_info *info,
+					uint8_t client_id)
 {
-	struct service_family *family = l_new(struct service_family, 1);
-
 	family->ref_count = 0;
 	family->transport = transport;
 	family->client_id = client_id;
 	family->notify_list = l_queue_new();
 	family->group_id = group_id;
 	memcpy(&family->info, info, sizeof(family->info));
-
-	return family;
 }
 
 static struct qmi_service *service_create(struct service_family *family)
@@ -1308,6 +1299,50 @@ int qmi_qmux_device_discover(struct qmi_qmux_device *qmux,
 	return 0;
 }
 
+static void qmux_client_release_callback(struct qmi_request *req,
+					uint16_t message, uint16_t length,
+					const void *buffer)
+{
+	struct qmi_qmux_device *qmux = req->user_data;
+
+	qmux->shutdown.release_users--;
+}
+
+static void qmux_service_family_free(struct service_family *family)
+{
+	struct qmi_qmux_device *qmux = l_container_of(family->transport,
+							struct qmi_qmux_device,
+							transport);
+	uint8_t release_req[] = { 0x01, 0x02, 0x00,
+				family->info.service_type, family->client_id };
+	struct qmi_request *req;
+
+	if (family->transport) {
+		qmux->shutdown.release_users++;
+		req = __control_request_alloc(QMI_CTL_RELEASE_CLIENT_ID,
+					release_req, sizeof(release_req), 0);
+		req->user_data = qmux;
+
+		__ctl_request_submit(qmux, req, qmux_client_release_callback);
+	}
+
+	l_free(family);
+}
+
+static struct service_family *qmux_service_family_new(
+					struct qmi_transport *transport,
+					unsigned int group_id,
+					const struct qmi_service_info *info,
+					uint8_t client_id)
+{
+	struct service_family *family = l_new(struct service_family, 1);
+
+	__service_family_init(family, transport, group_id, info, client_id);
+	family->free_family = qmux_service_family_free;
+
+	return family;
+}
+
 struct qmux_create_client_request {
 	struct qmi_qmux_device *qmux;
 	uint8_t type;
@@ -1387,7 +1422,7 @@ static void qmux_create_client_callback(struct qmi_request *r,
 	info.major = req->major;
 	info.minor = req->minor;
 
-	family = service_family_create(&qmux->transport,
+	family = qmux_service_family_new(&qmux->transport,
 					next_id(&qmux->next_group_id),
 					&info, client_id->client);
 	DEBUG(&qmux->debug, "service family created [client=%d,type=%d]",
@@ -1451,33 +1486,6 @@ bool qmi_qmux_device_create_client(struct qmi_qmux_device *qmux,
 	return true;
 }
 
-static void qmux_client_release_callback(struct qmi_request *req,
-					uint16_t message, uint16_t length,
-					const void *buffer)
-{
-	struct qmi_qmux_device *qmux = req->user_data;
-
-	qmux->shutdown.release_users--;
-}
-
-static void qmi_qmux_device_client_release(struct qmi_transport *transport,
-						uint16_t service_type,
-						uint16_t client_id)
-{
-	struct qmi_qmux_device *qmux =
-		l_container_of(transport, struct qmi_qmux_device, transport);
-	uint8_t release_req[] = { 0x01, 0x02, 0x00, service_type, client_id };
-	struct qmi_request *req;
-
-	qmux->shutdown.release_users++;
-
-	req = __control_request_alloc(QMI_CTL_RELEASE_CLIENT_ID,
-					release_req, sizeof(release_req), 0);
-	req->user_data = qmux;
-
-	__ctl_request_submit(qmux, req, qmux_client_release_callback);
-}
-
 static void __qmux_device_free(struct qmi_qmux_device *qmux)
 {
 	l_queue_destroy(qmux->control_queue, __request_free);
@@ -1553,7 +1561,6 @@ int qmi_qmux_device_shutdown(struct qmi_qmux_device *qmux,
 
 static const struct qmi_transport_ops qmux_ops = {
 	.write = qmi_qmux_device_write,
-	.client_release = qmi_qmux_device_client_release,
 };
 
 struct qmi_qmux_device *qmi_qmux_device_new(const char *device)
@@ -1670,6 +1677,25 @@ static void __qrtr_lookup_finished(struct qmi_qrtr_node *node)
 	memset(&node->lookup, 0, sizeof(node->lookup));
 }
 
+static void qrtr_service_family_free(struct service_family *family)
+{
+	l_free(family);
+}
+
+static struct service_family *qrtr_service_family_new(
+					struct qmi_transport *transport,
+					unsigned int group_id,
+					const struct qmi_service_info *info,
+					uint8_t client_id)
+{
+	struct service_family *family = l_new(struct service_family, 1);
+
+	__service_family_init(family, transport, group_id, info, client_id);
+	family->free_family = qrtr_service_family_free;
+
+	return family;
+}
+
 static int qmi_qrtr_node_write(struct qmi_transport *transport,
 					struct qmi_request *req)
 {
@@ -1997,8 +2023,9 @@ struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
 	if (!info)
 		return NULL;
 
-	family = service_family_create(transport, next_id(&node->next_group_id),
-					info, 0);
+	family = qrtr_service_family_new(transport,
+						next_id(&node->next_group_id),
+						info, 0);
 	l_hashmap_insert(transport->family_list, L_UINT_TO_PTR(type), family);
 done:
 	return service_create(family);
-- 
2.45.0

