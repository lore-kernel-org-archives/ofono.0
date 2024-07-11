Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E684047
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716586; cv=none; b=nMMfxzc3JnCj9BxOCPQMxpluptgJJOYLCTrpwHiaMMMYUaVAkYNmkZZz8cDzQ9VMZSY1bvP3rEh+A4P45e1/ckwW6jEvQ3c6A+Zy8vak1blEVtdAvKyr8mB3c7eZEGU61a+ShxYjEZdaDzcFJd7+f9H2HrIN6Tc9KpHkTsTz33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716586; c=relaxed/simple;
	bh=EkaKgzvy8UfudnBrM3RgzjSrk5inute2DpB+yAyFOb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cd5cz8dM0wWeMCvGYaSkydEM28DQIk3zJBTb+6cFy/3TNkvgY/Nhu7CnIG+Hs5yJsHT/+4+mJO+A8pfmgCqEBnve2v5cpzH5SeK3uSV+umAEr9H9htcDDOGN/1zBZhxSpb8IYbNXvKlhB9AU6xLXd7sEwNDL3GWGJYzCregTB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDrUgv1S; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDrUgv1S"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25e2cc76becso485770fac.3
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716584; x=1721321384; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBzY8p7iQZzTuiydz8/WuUiXtoZIqPdsquhxIPtDQjA=;
        b=JDrUgv1SZsB105c6PD9UnEtJZlv03P7ZfoeGnvIWLawX6c9QjKvVcfqJuwih3ivM+S
         AtVI5Ma67sAt9qz4ayMmKb3zbSiV/lPC1WODN56P5UxOZvRWZ1WaoYKAxj21VuLEJ95o
         2oJ6qCw4b/7SGEvorLv6y3oKKM/dT2EeyqxF0qtN35k6UJe7LC8OF7N5fltHidk8NZzv
         E8CxadmSz2unbxFvljiNlbxY3VBUXjXt62Rwm8XrfQ6x6dq/ky6VHKcLVaZMGzfqA+Ep
         GKhLPQCyUoK7AsHFei+YnzxfFOzTO4IfldIF5CCsJVn6byhPsrOxmQQr+bawuu/wWRk4
         nZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716584; x=1721321384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBzY8p7iQZzTuiydz8/WuUiXtoZIqPdsquhxIPtDQjA=;
        b=whHmfDJv+g1wWXN5hJG5boq4gWDSAzVOf8o1bE3vAiV+dk5k8fc/KcpOvhvWfZoVfL
         Ws44RyNXiqeA0z9L1JNWZg2A0T3Ar9YjuLpbkNjlxEgX1Mb3PmG6FQXjrydeHztG4W5R
         Xr4OrGr+z/UywGE8Q6jhwKUFEQjt2uxS4VagXyFeYK/hFAZmqEx5jr6KHIcfjh6vFqbt
         UKv1MPyyzX2oLrcVhAIDCu6tDvxngea7z7dlmK0bICkbzVkdSAq/8OXkXedHqaggHLxP
         Up+8xzEK4R2DCdE3PHDmrOL8tA8ST2KTaS03Tb6y6S8/4Z74WnOFkVj/BF/AeflvKZjY
         XXNQ==
X-Gm-Message-State: AOJu0YywxsW/QMh++1MNyJX3liEl8X4qGlrTfC6DAF5fy/FJiT16u0jZ
	3yqY6aKemkgZZRmv6KVQ9bLQIrR0yaJ8KfECaO/VCHXJD8gzaNVWUZioHA==
X-Google-Smtp-Source: AGHT+IGb6uzVrcGH8xQk0yiuumW0nOonTn3UpotqaC6Boi/1AxkjK0O/J0AUg2XVm84it3Z6WLE0ng==
X-Received: by 2002:a05:6870:b296:b0:254:bd24:de85 with SMTP id 586e51a60fabf-25eae7b619cmr7354561fac.16.1720716584030;
        Thu, 11 Jul 2024 09:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 09/11] qmi: gprs-context: refactor detach_shutdown path
Date: Thu, 11 Jul 2024 11:49:31 -0500
Message-ID: <20240711164936.1688973-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164936.1688973-1-denkenz@gmail.com>
References: <20240711164936.1688973-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since there will now be up to two WDS clients used (Dual stack
contexts), the detach_shutdown path needs to send a Stop Network
command on any client with an ongoing packet connection.

Implement this by keeping track of WDS clients used for ipv4 and ipv6
families respectively and their respective packet handles.  Rename
member 'wds' to 'ipv4', it is used as-is for currently existing code
paths.  Similarly, rename pkt_handle to packet_handle_ipv4.

Note that the dedicated WDS client associated with the 'ipv6'
qmi_service handle is effectively not used as of this commit.  This is
because packet_handle_ipv6 is never set.  IPv6-only context activations
will continue using 'ipv4' and 'packet_handle_ipv4'.  This will be
addressed in follow-on commits.
---
 drivers/qmimodem/gprs-context.c | 114 ++++++++++++++++++++++++++------
 1 file changed, 95 insertions(+), 19 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 456f46ead6d5..f4846f0299e7 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -21,13 +21,26 @@
 #include "util.h"
 
 struct gprs_context_data {
-	struct qmi_service *wds;
+	struct qmi_service *ipv4;
 	struct qmi_service *ipv6;
 	unsigned int active_context;
-	uint32_t pkt_handle;
+	uint32_t packet_handle_ipv4;
+	uint32_t packet_handle_ipv6;
 	uint8_t mux_id;
 };
 
+static void check_all_deactivated(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+
+	if (data->packet_handle_ipv4 || data->packet_handle_ipv6)
+		return;
+
+	/* All families have been disconnected */
+	ofono_gprs_context_deactivated(gc, data->active_context);
+	data->active_context = 0;
+}
+
 static void pkt_status_notify(struct qmi_result *result, void *user_data)
 {
 	static const uint8_t RESULT_CONN_STATUS = 0x01;
@@ -54,12 +67,11 @@ static void pkt_status_notify(struct qmi_result *result, void *user_data)
 
 	switch (status->status) {
 	case QMI_WDS_CONNECTION_STATUS_DISCONNECTED:
-		if (data->pkt_handle) {
-			/* The context has been disconnected by the network */
-			ofono_gprs_context_deactivated(gc, data->active_context);
-			data->pkt_handle = 0;
-			data->active_context = 0;
+		if (data->packet_handle_ipv4) {
+			data->packet_handle_ipv4 = 0;
+			check_all_deactivated(gc);
 		}
+
 		break;
 	}
 }
@@ -227,7 +239,7 @@ static void start_net_cb(struct qmi_result *result, void *user_data)
 
 	DBG("packet handle %d", handle);
 
-	data->pkt_handle = handle;
+	data->packet_handle_ipv4 = handle;
 
 	/*
 	 * Explicitly request certain information to be provided.  The requested
@@ -243,7 +255,7 @@ static void start_net_cb(struct qmi_result *result, void *user_data)
 	param = qmi_param_new_uint32(PARAM_REQUESTED_SETTINGS,
 						requested_settings);
 
-	if (qmi_service_send(data->wds, QMI_WDS_GET_CURRENT_SETTINGS, param,
+	if (qmi_service_send(data->ipv4, QMI_WDS_GET_CURRENT_SETTINGS, param,
 				get_settings_cb, cbd, cb_data_unref) > 0) {
 		cb_data_ref(cbd);
 		return;
@@ -292,7 +304,7 @@ static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 
 	param = qmi_param_new_uint8(QMI_WDS_PARAM_IP_FAMILY, ip_family);
 
-	if (qmi_service_send(data->wds, QMI_WDS_START_NETWORK, param,
+	if (qmi_service_send(data->ipv4, QMI_WDS_START_NETWORK, param,
 					start_net_cb, cbd, cb_data_unref) > 0) {
 		cb_data_ref(cbd);
 		return;
@@ -322,7 +334,7 @@ static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
 
 	DBG("cid %u", cid);
 
-	if (qmi_service_send(data->wds, QMI_WDS_GET_LTE_ATTACH_PARAMETERS,
+	if (qmi_service_send(data->ipv4, QMI_WDS_GET_LTE_ATTACH_PARAMETERS,
 				NULL, get_lte_attach_param_cb, cbd,
 				cb_data_unref) > 0) {
 		data->active_context = cid;
@@ -381,7 +393,7 @@ static void qmi_activate_primary(struct ofono_gprs_context *gc,
 		qmi_param_append(param, QMI_WDS_PARAM_PASSWORD,
 					strlen(ctx->password), ctx->password);
 
-	if (qmi_service_send(data->wds, QMI_WDS_START_NETWORK, param,
+	if (qmi_service_send(data->ipv4, QMI_WDS_START_NETWORK, param,
 					start_net_cb, cbd, cb_data_unref) > 0)
 		return;
 
@@ -395,6 +407,24 @@ error:
 	l_free(cbd);
 }
 
+static uint32_t send_stop_net(struct qmi_service *wds, uint32_t packet_handle,
+				qmi_service_result_func_t func,
+				void *user_data, qmi_destroy_func_t destroy)
+{
+	static const uint8_t PARAM_PACKET_HANDLE = 0x01;
+	struct qmi_param *param = qmi_param_new_uint32(PARAM_PACKET_HANDLE,
+							packet_handle);
+	uint32_t id;
+
+	id = qmi_service_send(wds, QMI_WDS_STOP_NETWORK, param,
+				func, user_data, destroy);
+
+	if (!id)
+		qmi_param_free(param);
+
+	return id;
+}
+
 static void stop_net_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd = user_data;
@@ -410,7 +440,7 @@ static void stop_net_cb(struct qmi_result *result, void *user_data)
 		return;
 	}
 
-	data->pkt_handle = 0;
+	data->packet_handle_ipv4 = 0;
 
 	if (cb)
 		CALLBACK_WITH_SUCCESS(cb, cbd->data);
@@ -433,9 +463,10 @@ static void qmi_deactivate_primary(struct ofono_gprs_context *gc,
 
 	cbd->user = gc;
 
-	param = qmi_param_new_uint32(PARAM_PACKET_HANDLE, data->pkt_handle);
+	param = qmi_param_new_uint32(PARAM_PACKET_HANDLE,
+						data->packet_handle_ipv4);
 
-	if (qmi_service_send(data->wds, QMI_WDS_STOP_NETWORK, param,
+	if (qmi_service_send(data->ipv4, QMI_WDS_STOP_NETWORK, param,
 					stop_net_cb, cbd, l_free) > 0)
 		return;
 
@@ -447,12 +478,57 @@ static void qmi_deactivate_primary(struct ofono_gprs_context *gc,
 	l_free(cbd);
 }
 
+static void stop_net_detach_ipv4_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_gprs_context *gc = user_data;
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+	uint16_t error;
+
+	if (!qmi_result_set_error(result, &error))
+		error = 0;
+
+	DBG("error: %u", error);
+
+	data->packet_handle_ipv4 = 0;
+	check_all_deactivated(gc);
+}
+
+static void stop_net_detach_ipv6_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_gprs_context *gc = user_data;
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+	uint16_t error;
+
+	if (!qmi_result_set_error(result, &error))
+		error = 0;
+
+	DBG("error: %u", error);
+
+	data->packet_handle_ipv6 = 0;
+	check_all_deactivated(gc);
+}
+
 static void qmi_gprs_context_detach_shutdown(struct ofono_gprs_context *gc,
 						unsigned int cid)
 {
+	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+
 	DBG("");
 
-	qmi_deactivate_primary(gc, cid, NULL, NULL);
+	if (data->packet_handle_ipv6 &&
+			!send_stop_net(data->ipv6, data->packet_handle_ipv6,
+					stop_net_detach_ipv6_cb, gc, NULL))
+		data->packet_handle_ipv6 = 0;
+
+	if (data->packet_handle_ipv4 &&
+			!send_stop_net(data->ipv4, data->packet_handle_ipv4,
+					stop_net_detach_ipv4_cb, gc, NULL))
+		data->packet_handle_ipv4 = 0;
+
+	if (data->packet_handle_ipv4 || data->packet_handle_ipv6)
+		return;
+
+	data->active_context = 0;
 }
 
 static void set_ip_family_preference_cb(struct qmi_result *result,
@@ -603,11 +679,11 @@ static int qmi_gprs_context_probev(struct ofono_gprs_context *gc,
 		return r;
 
 	data = l_new(struct gprs_context_data, 1);
-	data->wds = l_steal_ptr(ipv4);
+	data->ipv4 = l_steal_ptr(ipv4);
 	data->ipv6 = l_steal_ptr(ipv6);
 	data->mux_id = mux_id;
 
-	qmi_service_register(data->wds, QMI_WDS_PACKET_SERVICE_STATUS,
+	qmi_service_register(data->ipv4, QMI_WDS_PACKET_SERVICE_STATUS,
 					pkt_status_notify, gc, NULL);
 	qmi_service_register(data->ipv6, QMI_WDS_PACKET_SERVICE_STATUS,
 					pkt_status_notify, gc, NULL);
@@ -625,7 +701,7 @@ static void qmi_gprs_context_remove(struct ofono_gprs_context *gc)
 
 	ofono_gprs_context_set_data(gc, NULL);
 
-	qmi_service_free(data->wds);
+	qmi_service_free(data->ipv4);
 	qmi_service_free(data->ipv6);
 	l_free(data);
 }
-- 
2.45.2

