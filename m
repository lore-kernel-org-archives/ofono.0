Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C644C89
	for <ofono@lists.linux.dev>; Thu, 15 Sep 2022 20:55:02 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id e18so28781243edj.3
        for <ofono@lists.linux.dev>; Thu, 15 Sep 2022 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=1P8zWgjxXRGWAnYqpkK8wa9ppeizUCgCCInUR0OhS/I=;
        b=la8Lh8AHmVc3gP1G7QrJh/vJpsF2chrcrF9mB8tcU6e7rHUrHi5YTFOosm8hrqr/Xu
         G7WpzJ5oAxF3srCF66KilQF7031t6Ho6W43IOD1W92TXYhSzpF6ulj7IrF8UdELsRx0i
         EMra1X/LQSnOZrlEKTTUYcmGUJnLVfS3eJwIKmGCU+F05OGebZwLgjpQUdyekL8DDnqq
         VbrNaie+0KKxt3wFcVYHa9EAbKHg5D/FY60Oh9q3drUm3SY6hA+vEfWwpTmw8qwPdnPp
         ZOWxzyCA+gID5utOyWoAh23JgPhZWoOPgbLWQtqci3C80986YoQBmaLPmon2cid8Bcb6
         SDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1P8zWgjxXRGWAnYqpkK8wa9ppeizUCgCCInUR0OhS/I=;
        b=fyZn64WXS2Tx99pDn5kQyCrXm4NRCBmsXtKhQ5SiUzy52Vvbgty/aiRWigj8220y2Y
         q2CRuaRQwcE/ac0arU1QffL5g5di7IUnbifn9CHSUcwu7usuhLPSx+whQ1wd6vDZeQfz
         FjFdw8mGDIQ866kFtpV7FvbXgBHTpoiSvzYuBnYy/up4dEJUTVg2omBmEvI+ARyt3rtr
         bCLFP+emf2GZ+zcA3VtEVBFFIyVRsaicLJgyRm3AB4rn1CvtXJq2kuRe9JGwuEtJAGm5
         ELZAcWOpx2b92jRIOCtHVEdym2stS5hi+3PLHDx6cZQJfwDz88p5g1kp5jXTsI66R0lh
         0sDQ==
X-Gm-Message-State: ACrzQf0Z7/OkwI7SFg7RUgAIMx5pZJvG012ZIRJt1szhuLshnHJojZX1
	FNK3n+HUrM/ZfgVYFrM9j9XgWcpuGvTlSQ==
X-Google-Smtp-Source: AMsMyM75mlCoexit5k3NIW3VWPpIK9B/o1dr9t08QjJkLQVrkrELwiPdcOK0FG27AVUzQhoDAVRLag==
X-Received: by 2002:aa7:d0c7:0:b0:44d:f0ed:75b8 with SMTP id u7-20020aa7d0c7000000b0044df0ed75b8mr1394798edo.50.1663275300593;
        Thu, 15 Sep 2022 13:55:00 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b0074182109623sm9519424ejh.39.2022.09.15.13.54.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Sep 2022 13:55:00 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: merlijn@wizzup.org,
	tony@atomide.com,
	pavel@ucw.cz,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/2] qmimodem: Remove service create request on timeout
Date: Thu, 15 Sep 2022 23:54:34 +0300
Message-Id: <1663275275-19800-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1663275275-19800-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1663275275-19800-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

Otherwise callback will be called on late response with dangling user_data.
---
 drivers/qmimodem/qmi.c | 66 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 4cd1530..fc4534a 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1147,7 +1147,7 @@ struct discover_data {
 	qmi_discover_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
-	uint8_t tid;
+	uint16_t tid;
 	guint timeout;
 };
 
@@ -1245,41 +1245,53 @@ done:
 	__qmi_device_discovery_complete(data->device, &data->super);
 }
 
-static gboolean discover_reply(gpointer user_data)
+static struct qmi_request *find_control_request(struct qmi_device *device,
+						uint16_t tid)
 {
-	struct discover_data *data = user_data;
-	struct qmi_device *device = data->device;
-	unsigned int tid = data->tid;
 	GList *list;
 	struct qmi_request *req = NULL;
+	unsigned int _tid = tid;
 
-	data->timeout = 0;
-
-	/* remove request from queues */
-	if (tid != 0) {
+	if (_tid != 0) {
 		list = g_queue_find_custom(device->req_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
+				GUINT_TO_POINTER(_tid), __request_compare);
 
 		if (list) {
 			req = list->data;
 			g_queue_delete_link(device->req_queue, list);
 		} else {
 			list = g_queue_find_custom(device->control_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
+				GUINT_TO_POINTER(_tid), __request_compare);
 
 			if (list) {
 				req = list->data;
 				g_queue_delete_link(device->control_queue,
-								list);
+							list);
 			}
 		}
 	}
 
+	return req;
+}
+
+static gboolean discover_reply(gpointer user_data)
+{
+	struct discover_data *data = user_data;
+	struct qmi_device *device = data->device;
+	struct qmi_request *req;
+
+	/* remove request from queues */
+	req = find_control_request(device, data->tid);
+
+	data->timeout = 0;
+
 	if (data->func)
 		data->func(data->user_data);
 
-	__qmi_device_discovery_complete(data->device, &data->super);
-	__request_free(req, NULL);
+	__qmi_device_discovery_complete(device, &data->super);
+
+	if (req)
+		__request_free(req, NULL);
 
 	return FALSE;
 }
@@ -1289,7 +1301,6 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 {
 	struct discover_data *data;
 	struct qmi_request *req;
-	uint8_t tid;
 
 	if (!device)
 		return false;
@@ -1316,11 +1327,9 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, discover_callback, data);
 
-	tid = __request_submit(device, req);
-
-	data->tid = tid;
-
+	data->tid = __request_submit(device, req);
 	data->timeout = g_timeout_add_seconds(5, discover_reply, data);
+
 	__qmi_device_discovery_started(device, &data->super);
 
 	return true;
@@ -1940,6 +1949,7 @@ struct service_create_data {
 	void *user_data;
 	qmi_destroy_func_t destroy;
 	guint timeout;
+	uint16_t tid;
 };
 
 static void service_create_data_free(gpointer user_data)
@@ -1960,11 +1970,21 @@ static void service_create_data_free(gpointer user_data)
 static gboolean service_create_reply(gpointer user_data)
 {
 	struct service_create_data *data = user_data;
+	struct qmi_device *device = data->device;
+	struct qmi_request *req;
+
+	/* remove request from queues */
+	req = find_control_request(device, data->tid);
 
 	data->timeout = 0;
-	data->func(NULL, data->user_data);
 
-	__qmi_device_discovery_complete(data->device, &data->super);
+	if (data->func)
+		data->func(NULL, data->user_data);
+
+	__qmi_device_discovery_complete(device, &data->super);
+
+	if (req)
+		__request_free(req, NULL);
 
 	return FALSE;
 }
@@ -2063,9 +2083,9 @@ static bool service_create(struct qmi_device *device,
 			client_req, sizeof(client_req),
 			service_create_callback, data);
 
-	__request_submit(device, req);
-
+	data->tid = __request_submit(device, req);
 	data->timeout = g_timeout_add_seconds(8, service_create_reply, data);
+
 	__qmi_device_discovery_started(device, &data->super);
 
 	return true;
-- 
1.9.1

