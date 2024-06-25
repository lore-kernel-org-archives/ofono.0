Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D3171E75
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333730; cv=none; b=i2cDyMhKKlrNIdS2RcouCK0sNrtcf/JqGsBMwdNm23cQuuM03Hogkg9VzRKPBChaFTJqunMZoq3DHAP+BnUD0harHPicwZZBqH7cQzaLa/DZjsWq0IqtdsSyzwcGfRLo/3O/25KTAQrKVSdzoiFtVX/UP15VdOEj7KdMr3jjtQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333730; c=relaxed/simple;
	bh=qhIlzdE5YhnvLj6fu+OAX9qabULSZCjtB3FShraopMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvbXQJSERIoI8nRoBdmReeEf6WbRKOgAHE3CfqRZ7tI9YTTebTHd8mGhZJPhJ6ByICbtnGu9LUsT2tn1qQH+lJeWrxQNK0ecsWMCTcgETQAqa80y1a1rhfOoDLpzLsw+pISW94/+MWvcF3irVSadyPcVQnkYrWUczSia5mh6ReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7UPDR5o; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7UPDR5o"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5bfa5f9bbe6so2811359eaf.3
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333727; x=1719938527; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKyPV9p0M0ujvgaKTIG6sjKSVkVoJsb1MLlJ4Ul5+ow=;
        b=S7UPDR5oqcXOz+9Q8nwmR3LJo7kqydSnnqnVsoP0VCEFtflUg0QRmDsYZNUEuFBh97
         TvGpcqHLOXYu/+8YRETr2z7FshD3irdO3iHPW85dRW+mwQGG42XmoFMsZdsx7rRRGrIA
         dKSBmIMTqDwKSMmhbL6NFc2gDobiwKJvkN+A7C8rTk1SZOG9Ja8gLpcOrL/YKKWP8kUr
         /iiYqH9G/HfedPxZn5Q1tL9eAbMV41RKMvqPG5OkAXK33y1Xno6xnujaSj+b8NRejy3k
         NQiaQ8Y1VvLW4KxfmtNr9KFlKUe27B8+U8YFvsiAX1qJUXOIGaBsY36CfzdbHoNZNfjj
         zy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333727; x=1719938527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKyPV9p0M0ujvgaKTIG6sjKSVkVoJsb1MLlJ4Ul5+ow=;
        b=JcfGEs2juxWaDtWooxmjdI9DdwzHDbSWUuZFcFrS5R87ZoUIeFZorCHVvCggaA1Fnp
         i/Ey32nC1wJPE6C7kOcqbA4BkKB+IyaO5dEgimNijl9WrMKVK++FMNlJUJ1W6XOOzBBU
         rc5wAGGChum3iKG/OoggTYnIfqeeYN3LFOxraXLm5CNTXJluzeOLg1jUXdxKxhlbT9va
         woctbOU64t4phMrLHcU2sk2672PXxmtLXD8n2u5+19rq4leakt7871ztvoLG1Y48P6H+
         TmUo8fMUcBkN6XQ2YM+PvInt7gile3nAUp5cPafI2gOT5apJ7uYbDODrC6g/HY5mKahA
         WrfQ==
X-Gm-Message-State: AOJu0YyPoKNY0dI6prJWh6KzUIN9t9nvEvYAtPImXTBe9yV9foVNkRwv
	nRrPN3O/ET94eb2gEYishOiqobDyDsWhh8uHbPdpp9f3ldhtb0Voj/RdZA==
X-Google-Smtp-Source: AGHT+IHW58CIkN+MhQbbVvmBLqC0vS8Vko9zW/6B65KgIxJK0ZMpz9hholh5/kL2Hki0N1ghqZTAuA==
X-Received: by 2002:a4a:3114:0:b0:5c2:1f77:681e with SMTP id 006d021491bc7-5c21f77691bmr69912eaf.7.1719333727061;
        Tue, 25 Jun 2024 09:42:07 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:06 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 06/14] qmi: Rename qmi_device to qmi_transport
Date: Tue, 25 Jun 2024 11:41:42 -0500
Message-ID: <20240625164158.1170937-6-denkenz@gmail.com>
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

---
 drivers/qmimodem/qmi.c | 233 +++++++++++++++++++++--------------------
 1 file changed, 117 insertions(+), 116 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 59a50eabeb2b..f4af59a1b783 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -39,7 +39,7 @@
 #define SERVICE_VERSION(major, minor)				\
 	(((major) << 16) | (minor))
 
-struct qmi_device;
+struct qmi_transport;
 struct qmi_request;
 
 typedef void (*response_func_t)(struct qmi_request *, uint16_t message,
@@ -74,31 +74,31 @@ struct qmi_service_request {
 	struct qmi_request super;
 };
 
-struct qmi_device_ops {
-	int (*write)(struct qmi_device *device, struct qmi_request *req);
-	void (*client_release)(struct qmi_device *device,
-				uint16_t service_type, uint16_t client_id);
-};
-
 struct debug_data {
 	qmi_debug_func_t func;
 	void *user_data;
 };
 
-struct qmi_device {
+struct qmi_transport_ops {
+	int (*write)(struct qmi_transport *transport, struct qmi_request *req);
+	void (*client_release)(struct qmi_transport *transport,
+				uint16_t service_type, uint16_t client_id);
+};
+
+struct qmi_transport {
 	struct l_io *io;
 	struct l_queue *req_queue;
 	struct l_queue *service_queue;
 	uint16_t next_service_tid;
 	struct l_hashmap *family_list;
-	const struct qmi_device_ops *ops;
+	const struct qmi_transport_ops *ops;
 	bool writer_active : 1;
 };
 
 struct qmi_qmux_device {
-	struct qmi_device super;
 	struct qmi_service_info *service_list;
 	uint16_t n_services;
+	struct qmi_transport transport;
 	char *version_str;
 	struct debug_data debug;
 	struct {
@@ -124,7 +124,7 @@ struct qmi_qmux_device {
 
 struct service_family {
 	int ref_count;
-	struct qmi_device *device;
+	struct qmi_transport *transport;
 	struct qmi_service_info info;
 	unsigned int group_id;
 	uint8_t client_id;
@@ -651,21 +651,21 @@ static void __qrtr_debug_msg(const char dir, const void *buf, size_t len,
 
 static bool can_write_data(struct l_io *io, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_transport *transport = user_data;
 	struct qmi_request *req;
 	int r;
 
-	req = l_queue_pop_head(device->req_queue);
+	req = l_queue_pop_head(transport->req_queue);
 	if (!req)
 		return false;
 
-	r = device->ops->write(device, req);
+	r = transport->ops->write(transport, req);
 	if (r < 0) {
 		__request_free(req);
 		return false;
 	}
 
-	if (l_queue_length(device->req_queue) > 0)
+	if (l_queue_length(transport->req_queue) > 0)
 		return true;
 
 	return false;
@@ -673,33 +673,33 @@ static bool can_write_data(struct l_io *io, void *user_data)
 
 static void write_watch_destroy(void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_transport *transport = user_data;
 
-	device->writer_active = false;
+	transport->writer_active = false;
 }
 
-static void wakeup_writer(struct qmi_device *device)
+static void wakeup_writer(struct qmi_transport *transport)
 {
-	if (device->writer_active)
+	if (transport->writer_active)
 		return;
 
-	l_io_set_write_handler(device->io, can_write_data, device,
+	l_io_set_write_handler(transport->io, can_write_data, transport,
 				write_watch_destroy);
 
-	device->writer_active = true;
+	transport->writer_active = true;
 }
 
-static uint16_t __service_request_submit(struct qmi_device *device,
+static uint16_t __service_request_submit(struct qmi_transport *transport,
 						struct qmi_service *service,
 						struct qmi_request *req)
 {
 	struct qmi_service_hdr *hdr =
 		(struct qmi_service_hdr *) &req->data[QMI_MUX_HDR_SIZE];
 
-	req->tid = device->next_service_tid++;
+	req->tid = transport->next_service_tid++;
 
-	if (device->next_service_tid < 256)
-		device->next_service_tid = 256;
+	if (transport->next_service_tid < 256)
+		transport->next_service_tid = 256;
 
 	req->group_id = service->family->group_id;
 	req->service_handle = service->handle;
@@ -707,8 +707,8 @@ static uint16_t __service_request_submit(struct qmi_device *device,
 	hdr->type = 0x00;
 	hdr->transaction = L_CPU_TO_LE16(req->tid);
 
-	l_queue_push_tail(device->req_queue, req);
-	wakeup_writer(device);
+	l_queue_push_tail(transport->req_queue, req);
+	wakeup_writer(transport);
 
 	return req->tid;
 }
@@ -737,7 +737,7 @@ static unsigned int family_list_create_hash(uint16_t service_type,
 	return (service_type | (client_id << 16));
 }
 
-static void handle_indication(struct qmi_device *device,
+static void handle_indication(struct qmi_transport *transport,
 			uint32_t service_type, uint8_t client_id,
 			uint16_t message, uint16_t length, const void *data)
 {
@@ -755,13 +755,13 @@ static void handle_indication(struct qmi_device *device,
 	result.length = length;
 
 	if (client_id == 0xff) {
-		l_hashmap_foreach(device->family_list, service_notify,
+		l_hashmap_foreach(transport->family_list, service_notify,
 					&result);
 		return;
 	}
 
 	hash_id = family_list_create_hash(service_type, client_id);
-	family = l_hashmap_lookup(device->family_list,
+	family = l_hashmap_lookup(transport->family_list,
 					L_UINT_TO_PTR(hash_id));
 
 	if (!family)
@@ -770,7 +770,7 @@ static void handle_indication(struct qmi_device *device,
 	service_notify(NULL, family, &result);
 }
 
-static void __rx_message(struct qmi_device *device,
+static void __rx_message(struct qmi_transport *transport,
 				uint32_t service_type, uint8_t client_id,
 				const void *buf)
 {
@@ -787,12 +787,12 @@ static void __rx_message(struct qmi_device *device,
 	tid = L_LE16_TO_CPU(service->transaction);
 
 	if (service->type == 0x04) {
-		handle_indication(device, service_type, client_id,
+		handle_indication(transport, service_type, client_id,
 					message, length, data);
 		return;
 	}
 
-	req = l_queue_remove_if(device->service_queue, __request_compare,
+	req = l_queue_remove_if(transport->service_queue, __request_compare,
 						L_UINT_TO_PTR(tid));
 	if (!req)
 		return;
@@ -807,14 +807,14 @@ static void family_destroy(void *data)
 {
 	struct service_family *family = data;
 
-	if (!family->device)
+	if (!family->transport)
 		return;
 
-	family->device = NULL;
+	family->transport = NULL;
 }
 
-static int qmi_device_init(struct qmi_device *device, int fd,
-					const struct qmi_device_ops *ops)
+static int qmi_transport_open(struct qmi_transport *transport, int fd,
+				const struct qmi_transport_ops *ops)
 {
 	long flags;
 
@@ -829,28 +829,26 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 			return -errno;
 	}
 
-	device->io = l_io_new(fd);
-	l_io_set_close_on_destroy(device->io, true);
-
-	device->req_queue = l_queue_new();
-	device->service_queue = l_queue_new();
-	device->family_list = l_hashmap_new();
+	transport->io = l_io_new(fd);
+	l_io_set_close_on_destroy(transport->io, true);
 
-	device->next_service_tid = 256;
-
-	device->ops = ops;
+	transport->req_queue = l_queue_new();
+	transport->service_queue = l_queue_new();
+	transport->next_service_tid = 256;
+	transport->ops = ops;
+	transport->family_list = l_hashmap_new();
 
 	return 0;
 }
 
-static void __qmi_device_free(struct qmi_device *device)
+static void qmi_transport_close(struct qmi_transport *transport)
 {
-	l_queue_destroy(device->service_queue, __request_free);
-	l_queue_destroy(device->req_queue, __request_free);
+	l_queue_destroy(transport->service_queue, __request_free);
+	l_queue_destroy(transport->req_queue, __request_free);
 
-	l_io_destroy(device->io);
+	l_io_destroy(transport->io);
 
-	l_hashmap_destroy(device->family_list, family_destroy);
+	l_hashmap_destroy(transport->family_list, family_destroy);
 }
 
 void qmi_result_print_tlvs(struct qmi_result *result)
@@ -932,15 +930,15 @@ bool qmi_qmux_device_has_service(struct qmi_qmux_device *qmux, uint16_t type)
 	return __qmux_service_info_find(qmux, type);
 }
 
-static int qmi_qmux_device_write(struct qmi_device *device,
+static int qmi_qmux_device_write(struct qmi_transport *transport,
 					struct qmi_request *req)
 {
 	struct qmi_qmux_device *qmux =
-		l_container_of(device, struct qmi_qmux_device, super);
+		l_container_of(transport, struct qmi_qmux_device, transport);
 	struct qmi_mux_hdr *hdr;
 	ssize_t bytes_written;
 
-	bytes_written = write(l_io_get_fd(device->io), req->data, req->len);
+	bytes_written = write(l_io_get_fd(transport->io), req->data, req->len);
 	if (bytes_written < 0)
 		return -errno;
 
@@ -955,7 +953,7 @@ static int qmi_qmux_device_write(struct qmi_device *device,
 	if (hdr->service == QMI_SERVICE_CONTROL)
 		l_queue_push_tail(qmux->control_queue, req);
 	else
-		l_queue_push_tail(device->service_queue, req);
+		l_queue_push_tail(transport->service_queue, req);
 
 	return 0;
 }
@@ -979,7 +977,7 @@ static void __rx_ctl_message(struct qmi_qmux_device *qmux,
 	length = L_LE16_TO_CPU(msg->length);
 
 	if (control->type == 0x02 && control->transaction == 0x00) {
-		handle_indication(&qmux->super, service_type, client_id,
+		handle_indication(&qmux->transport, service_type, client_id,
 					message, length, data);
 		return;
 	}
@@ -1003,7 +1001,7 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 	ssize_t bytes_read;
 	uint16_t offset;
 
-	bytes_read = read(l_io_get_fd(qmux->super.io), buf, sizeof(buf));
+	bytes_read = read(l_io_get_fd(qmux->transport.io), buf, sizeof(buf));
 	if (bytes_read < 0)
 		return true;
 
@@ -1040,7 +1038,7 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 		if (hdr->service == QMI_SERVICE_CONTROL)
 			__rx_ctl_message(qmux, hdr->service, hdr->client, msg);
 		else
-			__rx_message(&qmux->super,
+			__rx_message(&qmux->transport,
 					hdr->service, hdr->client, msg);
 
 		offset += len;
@@ -1058,28 +1056,29 @@ static struct service_family *service_family_ref(struct service_family *family)
 
 static void service_family_unref(struct service_family *family)
 {
-	struct qmi_device *device;
+	struct qmi_transport *transport;
 
 	if (--family->ref_count)
 		return;
 
-	device = family->device;
-	if (!device)
+	transport = family->transport;
+	if (!transport)
 		goto done;
 
 	if (family->client_id) {
 		unsigned int hash_id =
 			family_list_create_hash(family->info.service_type,
 							family->client_id);
-		l_hashmap_remove(device->family_list, L_UINT_TO_PTR(hash_id));
+		l_hashmap_remove(transport->family_list, L_UINT_TO_PTR(hash_id));
 	}
 
-	l_hashmap_remove(device->family_list,
+	l_hashmap_remove(transport->family_list,
 				L_UINT_TO_PTR(family->info.service_type));
 
-	if (device->ops->client_release)
-		device->ops->client_release(device, family->info.service_type,
-							family->client_id);
+	if (transport->ops->client_release)
+		transport->ops->client_release(transport,
+						family->info.service_type,
+						family->client_id);
 
 done:
 	l_queue_destroy(family->notify_list, NULL);
@@ -1102,20 +1101,21 @@ static uint8_t __ctl_request_submit(struct qmi_qmux_device *qmux,
 	req->tid = hdr->transaction;
 	req->callback = callback;
 
-	l_queue_push_tail(qmux->super.req_queue, req);
-	wakeup_writer(&qmux->super);
+	l_queue_push_tail(qmux->transport.req_queue, req);
+	wakeup_writer(&qmux->transport);
 
 	return req->tid;
 }
 
-static struct service_family *service_family_create(struct qmi_device *device,
+static struct service_family *service_family_create(
+			struct qmi_transport *transport,
 			unsigned int group_id,
 			const struct qmi_service_info *info, uint8_t client_id)
 {
 	struct service_family *family = l_new(struct service_family, 1);
 
 	family->ref_count = 0;
-	family->device = device;
+	family->transport = transport;
 	family->client_id = client_id;
 	family->notify_list = l_queue_new();
 	family->group_id = group_id;
@@ -1146,7 +1146,7 @@ static struct qmi_request *find_control_request(struct qmi_qmux_device *qmux,
 	if (!tid)
 		return NULL;
 
-	req = l_queue_remove_if(qmux->super.req_queue,
+	req = l_queue_remove_if(qmux->transport.req_queue,
 					__request_compare, L_UINT_TO_PTR(tid));
 	if (req)
 		return req;
@@ -1265,9 +1265,7 @@ done:
 static void qmux_discover_reply_timeout(struct l_timeout *timeout,
 							void *user_data)
 {
-	struct qmi_device *device = user_data;
-	struct qmi_qmux_device *qmux =
-		l_container_of(device, struct qmi_qmux_device, super);
+	struct qmi_qmux_device *qmux = user_data;
 	struct qmi_request *req;
 
 	/* remove request from queues */
@@ -1386,7 +1384,7 @@ static void qmux_create_client_callback(struct qmi_request *r,
 	info.major = req->major;
 	info.minor = req->minor;
 
-	family = service_family_create(&qmux->super,
+	family = service_family_create(&qmux->transport,
 					next_id(&qmux->next_group_id),
 					&info, client_id->client);
 	DEBUG(&qmux->debug, "service family created [client=%d,type=%d]",
@@ -1395,7 +1393,7 @@ static void qmux_create_client_callback(struct qmi_request *r,
 	family = service_family_ref(family);
 	hash_id = family_list_create_hash(family->info.service_type,
 							family->client_id);
-	l_hashmap_insert(qmux->super.family_list,
+	l_hashmap_insert(qmux->transport.family_list,
 					L_UINT_TO_PTR(hash_id), family);
 
 done:
@@ -1459,12 +1457,12 @@ static void qmux_client_release_callback(struct qmi_request *req,
 	qmux->shutdown.release_users--;
 }
 
-static void qmi_qmux_device_client_release(struct qmi_device *device,
+static void qmi_qmux_device_client_release(struct qmi_transport *transport,
 						uint16_t service_type,
 						uint16_t client_id)
 {
 	struct qmi_qmux_device *qmux =
-		l_container_of(device, struct qmi_qmux_device, super);
+		l_container_of(transport, struct qmi_qmux_device, transport);
 	uint8_t release_req[] = { 0x01, 0x02, 0x00, service_type, client_id };
 	struct qmi_request *req;
 
@@ -1550,7 +1548,7 @@ int qmi_qmux_device_shutdown(struct qmi_qmux_device *qmux,
 	return 0;
 }
 
-static const struct qmi_device_ops qmux_ops = {
+static const struct qmi_transport_ops qmux_ops = {
 	.write = qmi_qmux_device_write,
 	.client_release = qmi_qmux_device_client_release,
 };
@@ -1566,7 +1564,7 @@ struct qmi_qmux_device *qmi_qmux_device_new(const char *device)
 
 	qmux = l_new(struct qmi_qmux_device, 1);
 
-	if (qmi_device_init(&qmux->super, fd, &qmux_ops) < 0) {
+	if (qmi_transport_open(&qmux->transport, fd, &qmux_ops) < 0) {
 		close(fd);
 		l_free(qmux);
 		return NULL;
@@ -1574,7 +1572,8 @@ struct qmi_qmux_device *qmi_qmux_device_new(const char *device)
 
 	qmux->next_control_tid = 1;
 	qmux->control_queue = l_queue_new();
-	l_io_set_read_handler(qmux->super.io, received_qmux_data, qmux, NULL);
+	l_io_set_read_handler(qmux->transport.io,
+				received_qmux_data, qmux, NULL);
 
 	return qmux;
 }
@@ -1585,7 +1584,7 @@ void qmi_qmux_device_free(struct qmi_qmux_device *qmux)
 		return;
 
 	DEBUG(&qmux->debug, "device %p", qmux);
-	__qmi_device_free(&qmux->super);
+	qmi_transport_close(&qmux->transport);
 
 	if (qmux->shutting_down) {
 		qmux->destroyed = true;
@@ -1605,7 +1604,6 @@ void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 }
 
 struct qmi_qrtr_node {
-	struct qmi_device super;
 	unsigned int next_group_id;	/* Matches requests with services */
 	struct l_queue *service_infos;
 	struct debug_data debug;
@@ -1615,6 +1613,7 @@ struct qmi_qrtr_node {
 		qmi_destroy_func_t destroy;
 		struct l_timeout *timeout;
 	} lookup;
+	struct qmi_transport transport;
 };
 
 static const struct qmi_service_info *__qrtr_service_info_find(
@@ -1659,16 +1658,16 @@ static void __qrtr_lookup_finished(struct qmi_qrtr_node *node)
 	memset(&node->lookup, 0, sizeof(node->lookup));
 }
 
-static int qmi_qrtr_node_write(struct qmi_device *device,
+static int qmi_qrtr_node_write(struct qmi_transport *transport,
 					struct qmi_request *req)
 {
 	struct qmi_qrtr_node *node =
-		l_container_of(device, struct qmi_qrtr_node, super);
+		l_container_of(transport, struct qmi_qrtr_node, transport);
 	struct sockaddr_qrtr addr;
 	uint8_t *data;
 	uint16_t len;
 	ssize_t bytes_written;
-	int fd = l_io_get_fd(device->io);
+	int fd = l_io_get_fd(transport->io);
 
 	/* Skip the QMUX header */
 	data = req->data + QMI_MUX_HDR_SIZE;
@@ -1692,7 +1691,7 @@ static int qmi_qrtr_node_write(struct qmi_device *device,
 	__qrtr_debug_msg(' ', data, bytes_written,
 			req->info.service_type, &node->debug);
 
-	l_queue_push_tail(device->service_queue, req);
+	l_queue_push_tail(transport->service_queue, req);
 
 	return 0;
 }
@@ -1780,7 +1779,7 @@ static void qrtr_received_service_message(struct qmi_qrtr_node *node,
 						uint32_t qrtr_port,
 						const void *buf, size_t len)
 {
-	struct qmi_device *device = &node->super;
+	struct qmi_transport *transport = &node->transport;
 	const struct l_queue_entry *entry;
 	uint32_t service_type = 0;
 
@@ -1802,7 +1801,7 @@ static void qrtr_received_service_message(struct qmi_qrtr_node *node,
 	}
 
 	__qrtr_debug_msg(' ', buf, len, service_type, &node->debug);
-	__rx_message(device, service_type, 0, buf);
+	__rx_message(transport, service_type, 0, buf);
 }
 
 static bool qrtr_received_data(struct l_io *io, void *user_data)
@@ -1814,7 +1813,8 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	socklen_t addr_size;
 
 	addr_size = sizeof(addr);
-	bytes_read = recvfrom(l_io_get_fd(qrtr->super.io), buf, sizeof(buf), 0,
+	bytes_read = recvfrom(l_io_get_fd(qrtr->transport.io),
+				buf, sizeof(buf), 0,
 				(struct sockaddr *) &addr, &addr_size);
 	DEBUG(&qrtr->debug, "Received %zd bytes from Node: %d Port: %d",
 			bytes_read, addr.sq_node, addr.sq_port);
@@ -1834,9 +1834,8 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	return true;
 }
 
-static const struct qmi_device_ops qrtr_ops = {
+static const struct qmi_transport_ops qrtr_ops = {
 	.write = qmi_qrtr_node_write,
-	.client_release = NULL,
 };
 
 struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node)
@@ -1850,15 +1849,15 @@ struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node)
 
 	qrtr = l_new(struct qmi_qrtr_node, 1);
 
-	if (qmi_device_init(&qrtr->super, fd, &qrtr_ops) < 0) {
+	if (qmi_transport_open(&qrtr->transport, fd, &qrtr_ops) < 0) {
 		close(fd);
 		l_free(qrtr);
 		return NULL;
 	}
 
 	qrtr->service_infos = l_queue_new();
-
-	l_io_set_read_handler(qrtr->super.io, qrtr_received_data, qrtr, NULL);
+	l_io_set_read_handler(qrtr->transport.io,
+					qrtr_received_data, qrtr, NULL);
 
 	return qrtr;
 }
@@ -1868,7 +1867,7 @@ void qmi_qrtr_node_free(struct qmi_qrtr_node *node)
 	if (!node)
 		return;
 
-	__qmi_device_free(&node->super);
+	qmi_transport_close(&node->transport);
 	l_queue_destroy(node->service_infos, l_free);
 
 	if (node->lookup.destroy)
@@ -1912,7 +1911,7 @@ int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
 
 	DEBUG(&node->debug, "node %p", node);
 
-	fd = l_io_get_fd(node->super.io);
+	fd = l_io_get_fd(node->transport.io);
 
 	/*
 	 * The control node is configured by the system. Use getsockname to
@@ -1958,7 +1957,7 @@ int qmi_qrtr_node_lookup(struct qmi_qrtr_node *node,
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
 						uint32_t type)
 {
-	struct qmi_device *device = &node->super;
+	struct qmi_transport *transport;
 	struct service_family *family;
 	const struct qmi_service_info *info;
 
@@ -1968,7 +1967,9 @@ struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
 	if (type == QMI_SERVICE_CONTROL)
 		return NULL;
 
-	family = l_hashmap_lookup(device->family_list, L_UINT_TO_PTR(type));
+	transport = &node->transport;
+
+	family = l_hashmap_lookup(transport->family_list, L_UINT_TO_PTR(type));
 	if (family)
 		goto done;
 
@@ -1976,9 +1977,9 @@ struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
 	if (!info)
 		return NULL;
 
-	family = service_family_create(device, next_id(&node->next_group_id),
+	family = service_family_create(transport, next_id(&node->next_group_id),
 					info, 0);
-	l_hashmap_insert(device->family_list, L_UINT_TO_PTR(type), family);
+	l_hashmap_insert(transport->family_list, L_UINT_TO_PTR(type), family);
 done:
 	return service_create(family);
 }
@@ -2338,8 +2339,8 @@ uint16_t qmi_service_send(struct qmi_service *service,
 				qmi_service_result_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
-	struct qmi_device *device;
 	struct service_family *family;
+	struct qmi_transport *transport;
 	struct qmi_service_request *sreq;
 	struct qmi_service_info *info;
 
@@ -2350,8 +2351,8 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	if (!family->group_id)
 		return 0;
 
-	device = family->device;
-	if (!device)
+	transport = family->transport;
+	if (!transport)
 		return 0;
 
 	info = &family->info;
@@ -2368,7 +2369,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	sreq->user_data = user_data;
 	sreq->destroy = destroy;
 
-	return __service_request_submit(device, service, &sreq->super);
+	return __service_request_submit(transport, service, &sreq->super);
 }
 
 struct request_lookup {
@@ -2393,7 +2394,7 @@ static bool __request_compare_for_cancel(const void *a, const void *b)
 
 bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 {
-	struct qmi_device *device;
+	struct qmi_transport *transport;
 	struct qmi_request *req;
 	struct service_family *family;
 	struct request_lookup lookup = { .tid = id };
@@ -2406,17 +2407,17 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 	if (!family->client_id)
 		return false;
 
-	device = family->device;
-	if (!device)
+	transport = family->transport;
+	if (!transport)
 		return false;
 
 	lookup.group_id = family->group_id;
 	lookup.service_handle = service->handle;
 
-	req = l_queue_remove_if(device->req_queue, __request_compare_for_cancel,
-					&lookup);
+	req = l_queue_remove_if(transport->req_queue,
+				__request_compare_for_cancel, &lookup);
 	if (!req) {
-		req = l_queue_remove_if(device->service_queue,
+		req = l_queue_remove_if(transport->service_queue,
 						__request_compare_for_cancel,
 						&lookup);
 		if (!req)
@@ -2457,7 +2458,7 @@ static void remove_client(struct l_queue *queue, unsigned int group_id,
 
 static bool qmi_service_cancel_all(struct qmi_service *service)
 {
-	struct qmi_device *device;
+	struct qmi_transport *transport;
 
 	if (!service)
 		return false;
@@ -2465,13 +2466,13 @@ static bool qmi_service_cancel_all(struct qmi_service *service)
 	if (!service->family->group_id)
 		return false;
 
-	device = service->family->device;
-	if (!device)
+	transport = service->family->transport;
+	if (!transport)
 		return false;
 
-	remove_client(device->req_queue,
+	remove_client(transport->req_queue,
 				service->family->group_id, service->handle);
-	remove_client(device->service_queue,
+	remove_client(transport->service_queue,
 				service->family->group_id, service->handle);
 
 	return true;
-- 
2.45.0

