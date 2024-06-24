Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5D1A01A9
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257607; cv=none; b=OrFiXLqHqeFevMapQ7Iohun4F0RjEZYTzXwZyeUVauVWDY2zUvi3vtsX8W/Hqw3SZYf8ziqZCN24yV+vmF0fKqpRri7lFFkWJHrwJH6NL7GDxieERmPPA3Tzt6Gtrf/EHwNOgKk97ewMYKQyWxEajhCuoRpDMNOhlaxP5FMVTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257607; c=relaxed/simple;
	bh=q2xnZlt/m5I5YG0NKJYp1eMi2APojbTBKYtZs/5/h2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2mFFLxVZlB6q5FDvLSGlDH0ZvnRmml69mO5s0up4268hiDXxssyoR0S6CJuVcZwI7UF3erXuazqYAbu6HWmIT2dsxbpub1gzdX6kToP+hT4xIOlTMHW1XyTYiHsoOBiENAfWMPZ416mpzYkO+8wAcbNlW1v6ahDbYOTk14Szds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXMF86X7; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXMF86X7"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c1ef5ac47eso892943eaf.2
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257605; x=1719862405; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIOf5a18nPN8XVNLEkurhAgeKtw6Y5gH32tbhaqR5jM=;
        b=MXMF86X7BkqKODIUsKKkcVA5bEZ8A5wXzqjUk7wH5TYtbXEvQ3HKdbfiPEgBjD2Wbe
         jw1QjVMAs0nz4TUOFhUwR2bdCaDq/IuXAKaWwvWzZqPND+o0Fz6gHOAsgo325trKKmBP
         K172gTTile04VX6XqlOmlZsdGf/sr8m57X0GqLxWLWUJkApTE+8DjOxxCSW7GBtdANqr
         wOg5BaLSQPKzVz/gZ0wMTdyfnf9yrCbtKsJWq2F2OBIoqplH66Qo4KWKFAFiykFVG+e0
         Hx1GipuVwSh00sQgZXEIS65dSup7frWf6I3nKzyjk/O3kudxKJvLm5CgPZH/C6Wo46az
         oaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257605; x=1719862405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIOf5a18nPN8XVNLEkurhAgeKtw6Y5gH32tbhaqR5jM=;
        b=GSODwC1afAKiwlQzJMffgJS9dTqR9dEIFGCal5S9T3yjktkJe9AYWtUqDBIplKfNQh
         5GRXsZKdtnaFVygsFBNPJ+YoKzLiWJY/8E8Ccy3j3xfv9U5b55YanaU2F1/ZQrP6bS/x
         UWRfJGskq/wAMjl/gUta5h9FVPBB+eAotYsGnSO4w9IwvLHtxZOxvm/6AVFGMX7XitEY
         54nj4p0b3I/gbN+GfxTb7/mhV46bEDtkXGpKTGpq7gXFF+6gBwO78cKmDtENFiPU//rN
         zTADDdtr6zOLiazh0ot13UXj4cvIIg4QzNPJfmYHHG5/7RE9UQeVvTUC4f8icONfiDn8
         Efpg==
X-Gm-Message-State: AOJu0Yx6Vn2H2vXYHyF16obIoThA6AIVif2LTHChg/2FjiUEL/CGUejf
	fAL8oPhMmfFkShRywlTaoJhLPuVD6P1o4u3cZHlrN9sGkda1fD7Q/hKtFQ==
X-Google-Smtp-Source: AGHT+IHuTWsX+tsVEMyOJaKFc/m7OdV/b4NjZX4R58tTvpti8JyKUFyxYG98dENzs/P7hhfMgAbvdw==
X-Received: by 2002:a4a:92c9:0:b0:5bd:a078:aba2 with SMTP id 006d021491bc7-5c1e95e1358mr6104256eaf.2.1719257605246;
        Mon, 24 Jun 2024 12:33:25 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:25 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/13] qmi: Move release_client operation into service_family
Date: Mon, 24 Jun 2024 14:32:53 -0500
Message-ID: <20240624193315.1164943-10-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624193315.1164943-1-denkenz@gmail.com>
References: <20240624193315.1164943-1-denkenz@gmail.com>
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
index de2d3410a702..7fba86eb1e29 100644
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
+	void (*free_family)(struct service_family *);
 };
 
 struct qmi_service {
@@ -1080,14 +1079,9 @@ static void service_family_unref(struct service_family *family)
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
@@ -1112,21 +1106,18 @@ static uint8_t __ctl_request_submit(struct qmi_qmux_device *qmux,
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
@@ -1310,6 +1301,50 @@ int qmi_qmux_device_discover(struct qmi_qmux_device *qmux,
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
@@ -1389,7 +1424,7 @@ static void qmux_create_client_callback(struct qmi_request *r,
 	info.major = req->major;
 	info.minor = req->minor;
 
-	family = service_family_create(&qmux->transport,
+	family = qmux_service_family_new(&qmux->transport,
 					next_id(&qmux->next_group_id),
 					&info, client_id->client);
 	DEBUG(&qmux->debug, "service family created [client=%d,type=%d]",
@@ -1453,33 +1488,6 @@ bool qmi_qmux_device_create_client(struct qmi_qmux_device *qmux,
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
@@ -1555,7 +1563,6 @@ int qmi_qmux_device_shutdown(struct qmi_qmux_device *qmux,
 
 static const struct qmi_transport_ops qmux_ops = {
 	.write = qmi_qmux_device_write,
-	.client_release = qmi_qmux_device_client_release,
 };
 
 struct qmi_qmux_device *qmi_qmux_device_new(const char *device)
@@ -1672,6 +1679,25 @@ static void __qrtr_lookup_finished(struct qmi_qrtr_node *node)
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
@@ -1999,8 +2025,9 @@ struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
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

