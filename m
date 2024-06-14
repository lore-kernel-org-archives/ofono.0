Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375A1A2C0D
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391198; cv=none; b=bvxDjNzHtxybzjV1qmggBrRRQ6v47ofvoJCfRUrPEUbGCsDnOH8utKzhHy/WGrx/oULi4KjvHy11Wn4IPaCvPWGNwAE07yintm68wDcW88Ca2asEJNjUXhb2TN9auJmAncJncK5pOVQ8220zz1jNfUGsKYjvDGhdH5CWR1NL6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391198; c=relaxed/simple;
	bh=dTKmPOhj1w1qTStuL9Eg35eghgMqPlj+0vy+Ev6cEpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0sNkbyQ2vRX+J4TudJRh9EzZriSvcxiSTphFI1EKe3iY07SLRxQvWQxb5eZAUFWfJ1kFYYurIgLnb7qyh8qGSgKyozKn3KvcJhUHwFmLj0lAEa9qWFKOnZ/k0MILm7dqwo7ddGmOQLB47cwJ/j/ePT70aBuKHLW3Y6uSCaX4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoETcK5q; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoETcK5q"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d1d08c7c8aso1398367b6e.2
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391196; x=1718995996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhygGDyOl6XKQmM7dvIsidsD2U4HXrcOkyr1vR4I8+0=;
        b=QoETcK5qR/E4X9qfJb4naF22oz/yA2MIDxf2udE4Ls2ZpBd+8wFj6r7fy89E7/lTTq
         GBmQHfTo0s9OsqRkW0IPP5BoMlNT+BSvQGUZ77RukZ+zpt7CRT23wcxOs4CA+rqqLXR1
         dWB0lCsZlNr9kPJnmC1o1lgPEqPJ7LHwvxoH8Qdc0uQkYBQJv6NLj4OfjeFOFEPQs9xd
         nOiW4FwLXHGnGmaE1QeQDgkaRgoqB9Gb6fFZ4xDmaH5+tHzdLYQ+vNQ4WgVxfITtOQJ2
         LTiicYNIGf/NMVOHJNkAT47ZPC2sxIix26T/bCa/UQqwCfpCZ+rIvuoDo3/wxlVtRPjA
         rICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391196; x=1718995996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhygGDyOl6XKQmM7dvIsidsD2U4HXrcOkyr1vR4I8+0=;
        b=q9CtgW4KX/pHv0V7SZbteISGCc761wPyVPu3eCAhsspiEfW2kf7bIap2MNKEfCYmH0
         ONmdBFIjk+QdDmNJHaDjv0r08hKGIcUVDUkJhOO9JQP6MEuNjXiBo+3BdtzfhwW15lIx
         klLk9FZ6bK8wl7ALJrFQLpyYNlEhsMqCPvDM30SBZ3W4Coz+cZj4i5K2eW8nStsTvrSp
         hAf+4Oqzagh6tpZmHFV7YAQ4qPMuyk4XoPbmp9sxXLg92cf5aOfl8W9lypfUMGjpiPur
         cOxu6rtdGlnhrT00ddsCgK/xe20vKCGNk4dHFIyw882G3phfA/cpd0p5xUh2XdJzPBs0
         WvWw==
X-Gm-Message-State: AOJu0YwG3Q0MSNzpyPLCxcxTBuOAJ15qkkxpSq+23jyAhzchSxdQNsaG
	C80hEhBSnhaeJ8bSIUBNyrZW+NRLFnpYcS1cofI7gi0KdQMpCE2Kymqakg==
X-Google-Smtp-Source: AGHT+IFXKbnhT0rANyakY0IIIS/N/xF9JaGSLAi4+oFZE8The647T895LWTodQD38UussA0dfAJWSQ==
X-Received: by 2002:a05:6870:fba9:b0:254:9625:79b with SMTP id 586e51a60fabf-258428de103mr3619169fac.20.1718391195678;
        Fri, 14 Jun 2024 11:53:15 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:15 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 17/27] qmi: break up qmi_device_free into qrtr & qmux variants
Date: Fri, 14 Jun 2024 13:52:29 -0500
Message-ID: <20240614185300.1086701-17-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614185300.1086701-1-denkenz@gmail.com>
References: <20240614185300.1086701-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce qmi_qrtr_node_free() that will deallocate a qrtr node object
and qmi_qmux_device_free() that will deallocate a qmux device object.
This removes the need for the .destroy method inside qmi_device_ops, so
get rid of that as well.

Since qrtr has no concept of shutting down (this is accomplished
immediately using close() on the qrtr socket), move the relevant
variables into the qmux specific structure.

The destroy operation inside qmi_device_ops is no longer used, remove
it.
---
 drivers/qmimodem/qmi.c   | 94 +++++++++++++++++++++-------------------
 drivers/qmimodem/qmi.h   |  3 +-
 plugins/gobi.c           |  4 +-
 plugins/qrtrqmi.c        |  2 +-
 unit/test-qmimodem-qmi.c |  2 +-
 5 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 6d605d58ad65..509f3dda5945 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -69,7 +69,6 @@ struct qmi_device_ops {
 	int (*shutdown)(struct qmi_device *device,
 			qmi_shutdown_func_t shutdown_func,
 			void *user, qmi_destroy_func_t destroy);
-	void (*destroy)(struct qmi_device *device);
 };
 
 struct qmi_device {
@@ -86,8 +85,6 @@ struct qmi_device {
 	struct l_hashmap *family_list;
 	const struct qmi_device_ops *ops;
 	bool writer_active : 1;
-	bool shutting_down : 1;
-	bool destroyed : 1;
 };
 
 struct qmi_device_qmux {
@@ -102,6 +99,8 @@ struct qmi_device_qmux {
 	unsigned int release_users;
 	uint8_t next_control_tid;
 	struct l_queue *control_queue;
+	bool shutting_down : 1;
+	bool destroyed : 1;
 };
 
 struct service_family {
@@ -890,17 +889,8 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 	return 0;
 }
 
-static void __qmi_device_shutdown_finished(struct qmi_device *device)
+static void __qmi_device_free(struct qmi_device *device)
 {
-	if (device->destroyed)
-		device->ops->destroy(device);
-}
-
-void qmi_device_free(struct qmi_device *device)
-{
-	if (!device)
-		return;
-
 	__debug_device(device, "device %p free", device);
 
 	l_queue_destroy(device->service_queue, __request_free);
@@ -912,11 +902,6 @@ void qmi_device_free(struct qmi_device *device)
 	l_hashmap_destroy(device->family_list, family_destroy);
 
 	l_queue_destroy(device->service_infos, l_free);
-
-	if (device->shutting_down)
-		device->destroyed = true;
-	else
-		device->ops->destroy(device);
 }
 
 void qmi_device_set_debug(struct qmi_device *device,
@@ -1816,6 +1801,17 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 	__ctl_request_submit(qmux, req);
 }
 
+static void __qmux_device_free(struct qmi_device_qmux *qmux)
+{
+	l_queue_destroy(qmux->control_queue, __request_free);
+
+	if (qmux->shutdown_idle)
+		l_idle_remove(qmux->shutdown_idle);
+
+	l_free(qmux->version_str);
+	l_free(qmux);
+}
+
 static void qmux_shutdown_destroy(void *user_data)
 {
 	struct qmi_device_qmux *qmux = user_data;
@@ -1825,7 +1821,8 @@ static void qmux_shutdown_destroy(void *user_data)
 
 	qmux->shutdown_idle = NULL;
 
-	__qmi_device_shutdown_finished(&qmux->super);
+	if (qmux->destroyed)
+		__qmux_device_free(qmux);
 }
 
 static void qmux_shutdown_callback(struct l_idle *idle, void *user_data)
@@ -1835,12 +1832,12 @@ static void qmux_shutdown_callback(struct l_idle *idle, void *user_data)
 	if (qmux->release_users > 0)
 		return;
 
-	qmux->super.shutting_down = true;
+	qmux->shutting_down = true;
 
 	if (qmux->shutdown_func)
 		qmux->shutdown_func(qmux->shutdown_user_data);
 
-	qmux->super.shutting_down = false;
+	qmux->shutting_down = false;
 
 	l_idle_remove(qmux->shutdown_idle);
 }
@@ -1871,26 +1868,11 @@ static int qmi_device_qmux_shutdown(struct qmi_device *device,
 	return 0;
 }
 
-static void qmi_device_qmux_destroy(struct qmi_device *device)
-{
-	struct qmi_device_qmux *qmux =
-		l_container_of(device, struct qmi_device_qmux, super);
-
-	l_queue_destroy(qmux->control_queue, __request_free);
-
-	if (qmux->shutdown_idle)
-		l_idle_remove(qmux->shutdown_idle);
-
-	l_free(qmux->version_str);
-	l_free(qmux);
-}
-
 static const struct qmi_device_ops qmux_ops = {
 	.write = qmi_device_qmux_write,
 	.discover = qmi_device_qmux_discover,
 	.client_release = qmi_device_qmux_client_release,
 	.shutdown = qmi_device_qmux_shutdown,
-	.destroy = qmi_device_qmux_destroy,
 };
 
 struct qmi_device *qmi_qmux_device_new(const char *device)
@@ -1917,6 +1899,24 @@ struct qmi_device *qmi_qmux_device_new(const char *device)
 	return &qmux->super;
 }
 
+void qmi_qmux_device_free(struct qmi_device *device)
+{
+	struct qmi_device_qmux *qmux;
+
+	if (!device)
+		return;
+
+	__qmi_device_free(device);
+
+	qmux = l_container_of(device, struct qmi_device_qmux, super);
+	if (qmux->shutting_down) {
+		qmux->destroyed = true;
+		return;
+	}
+
+	__qmux_device_free(qmux);
+}
+
 struct qmi_device_qrtr {
 	struct qmi_device super;
 };
@@ -2194,20 +2194,11 @@ error:
 	return rc;
 }
 
-static void qmi_device_qrtr_destroy(struct qmi_device *device)
-{
-	struct qmi_device_qrtr *qrtr =
-		l_container_of(device, struct qmi_device_qrtr, super);
-
-	l_free(qrtr);
-}
-
 static const struct qmi_device_ops qrtr_ops = {
 	.write = qmi_device_qrtr_write,
 	.discover = qmi_device_qrtr_discover,
 	.client_release = NULL,
 	.shutdown = NULL,
-	.destroy = qmi_device_qrtr_destroy,
 };
 
 struct qmi_device *qmi_qrtr_node_new(uint32_t node)
@@ -2232,6 +2223,19 @@ struct qmi_device *qmi_qrtr_node_new(uint32_t node)
 	return &qrtr->super;
 }
 
+void qmi_qrtr_node_free(struct qmi_device *device)
+{
+	struct qmi_device_qrtr *node;
+
+	if (!device)
+		return;
+
+	__qmi_device_free(device);
+
+	node = l_container_of(device, struct qmi_device_qrtr, super);
+	l_free(node);
+}
+
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
 						uint32_t type)
 {
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 0d2ffb61fdea..35ff62ff5a31 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -71,7 +71,7 @@ typedef void (*qmi_qmux_device_create_client_func_t)(struct qmi_service *,
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
 struct qmi_device *qmi_qmux_device_new(const char *device);
-void qmi_device_free(struct qmi_device *device);
+void qmi_qmux_device_free(struct qmi_device *device);
 
 bool qmi_qmux_device_create_client(struct qmi_device *device,
 				uint16_t service_type,
@@ -97,6 +97,7 @@ bool qmi_device_set_expected_data_format(struct qmi_device *device,
 			enum qmi_device_expected_data_format format);
 
 struct qmi_device *qmi_qrtr_node_new(uint32_t node);
+void qmi_qrtr_node_free(struct qmi_device *device);
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
 						uint32_t type);
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 59b459beb995..49d3ae2d304e 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -188,7 +188,7 @@ static void gobi_remove(struct ofono_modem *modem)
 
 	cleanup_services(data);
 
-	qmi_device_free(data->device);
+	qmi_qmux_device_free(data->device);
 
 	l_free(data);
 }
@@ -217,7 +217,7 @@ static void shutdown_cb(void *user_data)
 
 	data->discover_attempts = 0;
 
-	qmi_device_free(data->device);
+	qmi_qmux_device_free(data->device);
 	data->device = NULL;
 
 	ofono_modem_set_powered(modem, FALSE);
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 1c503c2d6cde..23fd6e165bf4 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -111,7 +111,7 @@ static void qrtrqmi_deinit(struct qrtrqmi_data *data)
 {
 	qmi_service_free(data->dms);
 	data->dms = NULL;
-	qmi_device_free(data->node);
+	qmi_qrtr_node_free(data->node);
 	data->node = NULL;
 }
 
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 4ea9c736c284..4c035db3c9c9 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -170,7 +170,7 @@ static void test_cleanup(struct test_info *info)
 
 	l_free(info->received);
 	l_timeout_remove(info->timeout);
-	qmi_device_free(info->node);
+	qmi_qrtr_node_free(info->node);
 
 	/* The qrtr services will be destroyed automatically. */
 	for (i = 0; i < TEST_SERVICE_COUNT; ++i)
-- 
2.45.0

