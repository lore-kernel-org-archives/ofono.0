Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A32F27
	for <ofono@lists.linux.dev>; Fri, 16 Sep 2022 09:31:51 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 29so30632999edv.2
        for <ofono@lists.linux.dev>; Fri, 16 Sep 2022 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=1P8zWgjxXRGWAnYqpkK8wa9ppeizUCgCCInUR0OhS/I=;
        b=UOpfiuhxAGl+74BWWrLMCjAFaXAx8/Gf8cRXNf4I+YJDU6rVVfZPM03t/nmOUjzZBx
         DcYplB1O5tniltzXskpEtAD03f0XElNj2NhLj5P21vN4tG9LhQ2aybbWNWKOlPadgKeN
         6GZN+SAIsy1XD9BPRKsS7dTQ/9J6pYQHWQvgBnuK/c3myFy8W+3jVkzt18qCOdAoIB4z
         gA1CZwAkT/+K+xU47UeYpKzaDKPNyg9MTKaCNYfH3YYhAWuypMBNOGePEYGj4r/Km0hY
         n5vfrdM2JzrGKjaUKEMy44ze2DBiBrP9uJsQ6sFoFf00O+Yf6PhX1WcCBZXMt5R4jWjf
         kCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1P8zWgjxXRGWAnYqpkK8wa9ppeizUCgCCInUR0OhS/I=;
        b=LxRV2ttql4bXlzaEFAR3Me5VLlY4eSvZSxW+Gmn+tg6lc5CJov20d0jGNRaHUIvx/W
         ez8XFWcsh5CKYhF+dAeFXJQ0mJutV50PowJlbXJSoHeegeXwIXCY/zgyMt7AUSP04Trq
         Eyw4X5+5Gtsr5GA29V3Lq/p74g7obtI6dseE/RkvMN3xr9fsidxToPvEbC6XTboenF/D
         dSll25okI544xjFxmLn9dg12ApY/FT8hyjZMYDSHKN8EkTG8LcaC/ZQqdoRlk9/iLlYl
         DJf5HtVIBI6efAU5e715QaE2y5OYujjteRdRgvO1nojjrJrusgVGOeG7R/A7DqRlMaos
         F4uQ==
X-Gm-Message-State: ACrzQf3YKiYJdWqqCbcuIDaQ3h/B3pD2kxn/dNZCHGstwtMH5qpV+/lX
	t7+ZEDmnJTsCFNkA113pauPZCV8YnEva8A==
X-Google-Smtp-Source: AMsMyM41s/+cUWJTtR9MHpSoyHpLQeG0o5OIkQ1t7AsVl8P7bZkl/2+iUnh9wzmAhNXSM8+ftqrJyA==
X-Received: by 2002:a05:6402:298e:b0:451:129e:1b35 with SMTP id eq14-20020a056402298e00b00451129e1b35mr3196455edb.79.1663320710306;
        Fri, 16 Sep 2022 02:31:50 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id w15-20020a50fa8f000000b00452bea2a0bfsm4611434edr.44.2022.09.16.02.31.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:31:49 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: merlijn@wizzup.org,
	tony@atomide.com,
	pavel@ucw.cz,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/2] qmimodem: Remove service create request on timeout
Date: Fri, 16 Sep 2022 12:31:02 +0300
Message-Id: <1663320663-26277-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1663320663-26277-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1663320663-26277-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
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

