Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81A1A2FA3
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391202; cv=none; b=BnajxQUa5/nAMI3Wild+9p1bK6xwrviVaGOuV6Sq2Lv9/rIhk5S8vc4Uac//yFZ44eqFwUJEav0iEUGIlGWDGSbA6wqr5q7sVE0w3xmhPIyYacx4V6vBGWOMZeo/FCnVWS7icuIZsBTHSVfMycbN1ITHWQFCqmazupSjKVY+hLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391202; c=relaxed/simple;
	bh=zPDlb02fJL/DD9cwHwetPEFmWq6xL/Voz5O6BZIEIy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyNQ5TZWvbE4Wieo04c71/BDy8fgqW2xY1gcoys2jcnRbKQvxSfDBeJEQ0Fl10UELfg/zLL7AjNiLCdduUeWODD73UDbk/45vrKonTCW9Jl/qaWUyqbXVL8e1dkruzpvgp5TwI2lLAx2eZ13CeP8UwNTvPWPM0kq/36BA73RmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frK0W0Ix; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frK0W0Ix"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25528eb4078so1319203fac.0
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391199; x=1718995999; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bshcXeXSDhZFRgatMw1P004sdpU765Buy+jcTDZJ0qY=;
        b=frK0W0Ixi26ArR9f0qGyIuYkpCk5+uVsVy5lucynqgXW0Q+n76TsYOdHA307Cfn11Z
         2Ac7f5vabYpMGwPMbYuY6F98cvTQjCMuHeqfbw048S0A+NOnlXMC8Ofn5LC3nRVpm/jM
         XWKAFmCx2CK67RHQVL5KyWnFajvoUgkxea7SQTVUjlazzqexs3c+1YajigNiVIHLF1RY
         KuhB26Elm0nag7uVaq+1sMEqcV93jyjjVobg5dTgpS6140B8TC02Aa84zf9rlq75uL8b
         AgSFGiK0N0LM8vln3iF/4JUHOcEXAwzKfmDMtI0vfPgX38gpUhc9vxil0G9ZD3EA88TO
         SNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391199; x=1718995999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bshcXeXSDhZFRgatMw1P004sdpU765Buy+jcTDZJ0qY=;
        b=egFf6GQK2DqMrmhiWCuk553ljyIvrLypGlj4YLB+0NGPEMBFE19hBK0hg0I9XYkO5i
         35NgTKm2pNHc1KfFhmRQ/gwThl6RtB72Nqn0J8ejvrdfBMW3N7Gvj6qej2uAqFsUAGyK
         Ed6uq3sL94VEDDkaa4tfDviscLgPZWzmlBEXPOTOeqFt78kFumSRMU+dtkSTcKYylFVI
         wyGuebo9rF3vNRuScN12csnhsha3KFMTpwkXei/UUPGLzrOC73sEN8JfFEjHGn061Y7g
         puPEKqyWSKxXINbhpxzCfFjTRukAQp39QGw/TgrWD00N4Q5uMOV1x0HXZeCq7ICt4pEu
         KdXA==
X-Gm-Message-State: AOJu0YxOoG+mbRfC9uv7w2bpT4P82vFSaptjlU47qLYNKl/N/rXip2Nu
	2NGBbyfgy48TSNECPuI04zU6EJixVpMe4izB/jYeCgz+2JXqWkBOQhaiYA==
X-Google-Smtp-Source: AGHT+IFjF/d7Lex2uD3/+BmweNYqXt0bP85pwnqmBgvufkvZQNPitAJ0MBD2LHIwcG4q2LyOYd3xAQ==
X-Received: by 2002:a05:6871:295:b0:254:ccac:133c with SMTP id 586e51a60fabf-25842ba2085mr3796419fac.41.1718391198598;
        Fri, 14 Jun 2024 11:53:18 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:18 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 21/27] qmi: split qmi_device_set_debug into QRTR and QMUX versions
Date: Fri, 14 Jun 2024 13:52:33 -0500
Message-ID: <20240614185300.1086701-21-denkenz@gmail.com>
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

While here, rework how debugging works by introducing an auxiliary
structure to house debug callback and user_data.  Replace __debug_device
with a DEBUG macro that uses l_util_debug.  The use of this macro alows
function and line information to be automagically included in the debug
output.
---
 drivers/qmimodem/qmi.c   | 177 ++++++++++++++++++++-------------------
 drivers/qmimodem/qmi.h   |   8 +-
 plugins/gobi.c           |   2 +-
 plugins/qrtrqmi.c        |   2 +-
 unit/test-qmimodem-qmi.c |   2 +-
 5 files changed, 97 insertions(+), 94 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index f4d32bd702b1..b5fb27c51a31 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -31,6 +31,10 @@
 
 #define DISCOVER_TIMEOUT 5
 
+#define DEBUG(debug, fmt, args...)					\
+	l_util_debug((debug)->func, (debug)->user_data, "%s:%i " fmt,	\
+			__func__, __LINE__, ## args)
+
 typedef void (*qmi_message_func_t)(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data);
 
@@ -71,6 +75,11 @@ struct qmi_device_ops {
 			void *user, qmi_destroy_func_t destroy);
 };
 
+struct debug_data {
+	qmi_debug_func_t func;
+	void *user_data;
+};
+
 struct qmi_device {
 	struct l_io *io;
 	struct l_queue *req_queue;
@@ -79,8 +88,6 @@ struct qmi_device {
 	unsigned int next_group_id;	/* Matches requests with services */
 	unsigned int next_service_handle;
 	uint16_t next_service_tid;
-	qmi_debug_func_t debug_func;
-	void *debug_data;
 	struct l_queue *service_infos;
 	struct l_hashmap *family_list;
 	const struct qmi_device_ops *ops;
@@ -92,6 +99,7 @@ struct qmi_device_qmux {
 	uint16_t control_major;
 	uint16_t control_minor;
 	char *version_str;
+	struct debug_data debug;
 	qmi_shutdown_func_t shutdown_func;
 	void *shutdown_user_data;
 	qmi_destroy_func_t shutdown_destroy;
@@ -501,6 +509,13 @@ int qmi_error_to_ofono_cme(int qmi_error)
 	}
 }
 
+static void __debug_data_init(struct debug_data *debug,
+				qmi_debug_func_t func, void *user_data)
+{
+	debug->func = func;
+	debug->user_data = user_data;
+}
+
 static void __debug_msg(char dir, const struct qmi_message_hdr *msg,
 			uint32_t service_type, uint8_t transaction_type,
 			uint16_t tid, uint8_t client, uint16_t overall_length,
@@ -630,7 +645,7 @@ static void __qmux_debug_msg(const char dir, const void *buf, size_t len,
 
 static void __qrtr_debug_msg(const char dir, const void *buf, size_t len,
 				uint32_t service_type,
-				qmi_debug_func_t function, void *user_data)
+				const struct debug_data *debug)
 {
 	const struct qmi_service_hdr *srv;
 	const struct qmi_message_hdr *msg;
@@ -645,23 +660,7 @@ static void __qrtr_debug_msg(const char dir, const void *buf, size_t len,
 	tid = L_LE16_TO_CPU(srv->transaction);
 
 	__debug_msg(dir, msg, service_type, srv->type >> 1, tid, 0, len,
-						function, user_data);
-}
-
-static void __debug_device(struct qmi_device *device,
-					const char *format, ...)
-{
-	char strbuf[72 + 16];
-	va_list ap;
-
-	if (!device->debug_func)
-		return;
-
-	va_start(ap, format);
-	vsnprintf(strbuf, sizeof(strbuf), format, ap);
-	va_end(ap);
-
-	device->debug_func(strbuf, device->debug_data);
+						debug->func, debug->user_data);
 }
 
 static bool can_write_data(struct l_io *io, void *user_data)
@@ -860,8 +859,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 {
 	long flags;
 
-	__debug_device(device, "device %p new", device);
-
 	flags = fcntl(fd, F_GETFL, NULL);
 	if (flags < 0)
 		return -EIO;
@@ -891,8 +888,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 
 static void __qmi_device_free(struct qmi_device *device)
 {
-	__debug_device(device, "device %p free", device);
-
 	l_queue_destroy(device->service_queue, __request_free);
 	l_queue_destroy(device->req_queue, __request_free);
 	l_queue_destroy(device->discovery_queue, __discovery_free);
@@ -904,16 +899,6 @@ static void __qmi_device_free(struct qmi_device *device)
 	l_queue_destroy(device->service_infos, l_free);
 }
 
-void qmi_device_set_debug(struct qmi_device *device,
-				qmi_debug_func_t func, void *user_data)
-{
-	if (device == NULL)
-		return;
-
-	device->debug_func = func;
-	device->debug_data = user_data;
-}
-
 void qmi_result_print_tlvs(struct qmi_result *result)
 {
 	const void *ptr = result->data;
@@ -1253,10 +1238,10 @@ static int qmi_device_qmux_write(struct qmi_device *device,
 		return -errno;
 
 	l_util_hexdump(false, req->data, bytes_written,
-			device->debug_func, device->debug_data);
+			qmux->debug.func, qmux->debug.user_data);
 
 	__qmux_debug_msg(' ', req->data, bytes_written,
-				device->debug_func, device->debug_data);
+				qmux->debug.func, qmux->debug.user_data);
 
 	hdr = (struct qmi_mux_hdr *) req->data;
 
@@ -1316,7 +1301,7 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 		return true;
 
 	l_util_hexdump(true, buf, bytes_read,
-			qmux->super.debug_func, qmux->super.debug_data);
+			qmux->debug.func, qmux->debug.user_data);
 
 	offset = 0;
 
@@ -1341,7 +1326,7 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 			break;
 
 		__qmux_debug_msg(' ', buf + offset, len,
-				qmux->super.debug_func, qmux->super.debug_data);
+				qmux->debug.func, qmux->debug.user_data);
 
 		msg = buf + offset + QMI_MUX_HDR_SIZE;
 
@@ -1431,10 +1416,6 @@ static struct service_family *service_family_create(struct qmi_device *device,
 
 	memcpy(&family->info, info, sizeof(family->info));
 
-	__debug_device(device, "service family created [client=%d,type=%d]",
-					family->client_id,
-					family->info.service_type);
-
 	return family;
 }
 
@@ -1450,10 +1431,6 @@ static struct qmi_service *service_create(struct service_family *family)
 	service->handle = device->next_service_handle++;
 	service->family = service_family_ref(family);
 
-	__debug_device(device, "service created [client=%d,type=%d]",
-					family->client_id,
-					family->info.service_type);
-
 	return service;
 }
 
@@ -1489,7 +1466,7 @@ static bool qmi_device_qmux_sync(struct qmi_device_qmux *qmux,
 {
 	struct qmi_request *req;
 
-	__debug_device(&qmux->super, "Sending sync to reset QMI");
+	DEBUG(&qmux->debug, "Sending sync to reset QMI");
 
 	req = __control_request_alloc(QMI_CTL_SYNC, NULL, 0,
 					qmux_sync_callback, data);
@@ -1536,10 +1513,10 @@ static void qmux_discover_callback(uint16_t message, uint16_t length,
 		struct qmi_service_info info;
 
 		if (name)
-			__debug_device(device, "found service [%s %d.%d]",
+			DEBUG(&qmux->debug, "discovered service [%s %d.%d]",
 					name, major, minor);
 		else
-			__debug_device(device, "found service [%d %d.%d]",
+			DEBUG(&qmux->debug, "discovered service [%d %d.%d]",
 					type, major, minor);
 
 		if (type == QMI_SERVICE_CONTROL) {
@@ -1561,7 +1538,7 @@ static void qmux_discover_callback(uint16_t message, uint16_t length,
 		goto done;
 
 	qmux->version_str = l_strndup(ptr + 1, *((uint8_t *) ptr));
-	__debug_device(device, "version string: %s", qmux->version_str);
+	DEBUG(&qmux->debug, "version string: %s", qmux->version_str);
 
 done:
 	/* if the device support the QMI call SYNC over the CTL interface */
@@ -1605,7 +1582,7 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 	struct discover_data *data;
 	struct qmi_request *req;
 
-	__debug_device(device, "device %p discover", device);
+	DEBUG(&qmux->debug, "device %p", qmux);
 
 	if (l_queue_length(device->service_infos) > 0)
 		return -EALREADY;
@@ -1666,7 +1643,7 @@ static void qmux_client_create_timeout(struct l_timeout *timeout,
 		l_container_of(device, struct qmi_device_qmux, super);
 	struct qmi_request *req;
 
-	__debug_device(device, "client creation timed out");
+	DEBUG(&qmux->debug, "");
 
 	l_timeout_remove(data->timeout);
 	data->timeout = NULL;
@@ -1684,6 +1661,8 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 {
 	struct qmux_client_create_data *data = user_data;
 	struct qmi_device *device = data->device;
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
 	struct service_family *family = NULL;
 	struct qmi_service *service = NULL;
 	struct qmi_service_info info;
@@ -1715,6 +1694,9 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	info.minor = data->minor;
 
 	family = service_family_create(device, &info, client_id->client);
+	DEBUG(&qmux->debug, "service family created [client=%d,type=%d]",
+			family->client_id, family->info.service_type);
+
 	family = service_family_ref(family);
 	hash_id = family_list_create_hash(family->info.service_type,
 							family->client_id);
@@ -1763,7 +1745,7 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 	create_data->user_data = user_data;
 	create_data->destroy = destroy;
 
-	__debug_device(device, "service create [type=%d]", service_type);
+	DEBUG(&qmux->debug, "creating client [type=%d]", service_type);
 
 	req = __control_request_alloc(QMI_CTL_GET_CLIENT_ID,
 					client_req, sizeof(client_req),
@@ -1856,7 +1838,7 @@ static int qmi_device_qmux_shutdown(struct qmi_device *device,
 	if (qmux->shutdown_idle)
 		return -EALREADY;
 
-	__debug_device(&qmux->super, "device %p shutdown", &qmux->super);
+	DEBUG(&qmux->debug, "device %p", &qmux);
 
 	qmux->shutdown_idle = l_idle_create(qmux_shutdown_callback, qmux,
 						qmux_shutdown_destroy);
@@ -1909,9 +1891,10 @@ void qmi_qmux_device_free(struct qmi_device *device)
 	if (!device)
 		return;
 
+	qmux = l_container_of(device, struct qmi_device_qmux, super);
+	DEBUG(&qmux->debug, "device %p", qmux);
 	__qmi_device_free(device);
 
-	qmux = l_container_of(device, struct qmi_device_qmux, super);
 	if (qmux->shutting_down) {
 		qmux->destroyed = true;
 		return;
@@ -1920,8 +1903,21 @@ void qmi_qmux_device_free(struct qmi_device *device)
 	__qmux_device_free(qmux);
 }
 
+void qmi_qmux_device_set_debug(struct qmi_device *device,
+				qmi_debug_func_t func, void *user_data)
+{
+	struct qmi_device_qmux *qmux;
+
+	if (device == NULL)
+		return;
+
+	qmux = l_container_of(device, struct qmi_device_qmux, super);
+	__debug_data_init(&qmux->debug, func, user_data);
+}
+
 struct qmi_device_qrtr {
 	struct qmi_device super;
+	struct debug_data debug;
 	struct {
 		qmi_qrtr_node_lookup_done_func_t func;
 		void *user_data;
@@ -1933,7 +1929,7 @@ struct qmi_device_qrtr {
 static void __qrtr_lookup_finished(struct qmi_device_qrtr *node)
 {
 	if (!node->lookup.func) {
-		__debug_device(&node->super, "No lookup in progress");
+		DEBUG(&node->debug, "No lookup in progress");
 		return;
 	}
 
@@ -1949,6 +1945,8 @@ static void __qrtr_lookup_finished(struct qmi_device_qrtr *node)
 static int qmi_device_qrtr_write(struct qmi_device *device,
 					struct qmi_request *req)
 {
+	struct qmi_device_qrtr *node =
+		l_container_of(device, struct qmi_device_qrtr, super);
 	struct sockaddr_qrtr addr;
 	uint8_t *data;
 	uint16_t len;
@@ -1967,16 +1965,15 @@ static int qmi_device_qrtr_write(struct qmi_device *device,
 	bytes_written = sendto(fd, data, len, 0, (struct sockaddr *) &addr,
 							sizeof(addr));
 	if (bytes_written < 0) {
-		__debug_device(device, "sendto: %s", strerror(errno));
+		DEBUG(&node->debug, "sendto: %s", strerror(errno));
 		return -errno;
 	}
 
 	l_util_hexdump(false, data, bytes_written,
-			device->debug_func, device->debug_data);
+			node->debug.func, node->debug.user_data);
 
 	__qrtr_debug_msg(' ', data, bytes_written,
-			req->info.service_type, device->debug_func,
-			device->debug_data);
+			req->info.service_type, &node->debug);
 
 	l_queue_push_tail(device->service_queue, req);
 
@@ -1984,13 +1981,12 @@ static int qmi_device_qrtr_write(struct qmi_device *device,
 }
 
 static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
-					qmi_debug_func_t function,
-					void *user_data)
+					const struct debug_data *debug)
 {
 	char strbuf[72 + 16], *str;
 	const char *type;
 
-	if (!function)
+	if (!debug->func)
 		return;
 
 	str = strbuf;
@@ -2002,7 +1998,7 @@ static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
 	str += sprintf(str, "%s cmd=%d", type,
 				L_LE32_TO_CPU(packet->cmd));
 
-	function(strbuf, user_data);
+	debug->func(strbuf, debug->user_data);
 }
 
 static void qrtr_received_control_packet(struct qmi_device_qrtr *node,
@@ -2019,22 +2015,21 @@ static void qrtr_received_control_packet(struct qmi_device_qrtr *node,
 	uint32_t qrtr_port;
 
 	if (len < sizeof(*packet)) {
-		__debug_device(device, "qrtr packet is too small");
+		DEBUG(&node->debug, "packet is too small");
 		return;
 	}
 
-	qrtr_debug_ctrl_request(packet, device->debug_func, device->debug_data);
+	qrtr_debug_ctrl_request(packet, &node->debug);
 
 	cmd = L_LE32_TO_CPU(packet->cmd);
 	if (cmd != QRTR_TYPE_NEW_SERVER) {
-		__debug_device(device, "Unknown command: %d", cmd);
+		DEBUG(&node->debug, "Unknown command: %d", cmd);
 		return;
 	}
 
 	if (!packet->server.service && !packet->server.instance &&
 			!packet->server.node && !packet->server.port) {
-		__debug_device(device,
-				"Initial service discovery has completed");
+		DEBUG(&node->debug, "Service lookup complete");
 		__qrtr_lookup_finished(node);
 		return;
 	}
@@ -2046,8 +2041,7 @@ static void qrtr_received_control_packet(struct qmi_device_qrtr *node,
 	qrtr_node = L_LE32_TO_CPU(packet->server.node);
 	qrtr_port = L_LE32_TO_CPU(packet->server.port);
 
-	__debug_device(device,
-			"New server: %d Version: %d Node/Port: %d/%d",
+	DEBUG(&node->debug, "New server: %d Version: %d Node/Port: %d/%d",
 			type, version, qrtr_node, qrtr_port);
 
 	memset(&info, 0, sizeof(info));
@@ -2065,11 +2059,12 @@ static void qrtr_received_control_packet(struct qmi_device_qrtr *node,
 	l_timeout_modify(node->lookup.timeout, DISCOVER_TIMEOUT);
 }
 
-static void qrtr_received_service_message(struct qmi_device *device,
+static void qrtr_received_service_message(struct qmi_device_qrtr *node,
 						uint32_t qrtr_node,
 						uint32_t qrtr_port,
 						const void *buf, size_t len)
 {
+	struct qmi_device *device = &node->super;
 	const struct l_queue_entry *entry;
 	uint32_t service_type = 0;
 
@@ -2085,14 +2080,12 @@ static void qrtr_received_service_message(struct qmi_device *device,
 	}
 
 	if (!service_type) {
-		__debug_device(device, "Message from unknown at node/port %d/%d",
+		DEBUG(&node->debug, "Message from unknown at node/port %d/%d",
 				qrtr_node, qrtr_port);
 		return;
 	}
 
-	__qrtr_debug_msg(' ', buf, len, service_type,
-				device->debug_func, device->debug_data);
-
+	__qrtr_debug_msg(' ', buf, len, service_type, &node->debug);
 	__rx_message(device, service_type, 0, buf);
 }
 
@@ -2107,19 +2100,19 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	addr_size = sizeof(addr);
 	bytes_read = recvfrom(l_io_get_fd(qrtr->super.io), buf, sizeof(buf), 0,
 				(struct sockaddr *) &addr, &addr_size);
-	__debug_device(&qrtr->super, "Received %zd bytes from Node: %d Port: %d",
+	DEBUG(&qrtr->debug, "Received %zd bytes from Node: %d Port: %d",
 			bytes_read, addr.sq_node, addr.sq_port);
 
 	if (bytes_read < 0)
 		return true;
 
-	l_util_hexdump(true, buf, bytes_read, qrtr->super.debug_func,
-			qrtr->super.debug_data);
+	l_util_hexdump(true, buf, bytes_read,
+			qrtr->debug.func, qrtr->debug.user_data);
 
 	if (addr.sq_port == QRTR_PORT_CTRL)
 		qrtr_received_control_packet(qrtr, buf, bytes_read);
 	else
-		qrtr_received_service_message(&qrtr->super, addr.sq_node,
+		qrtr_received_service_message(qrtr, addr.sq_node,
 						addr.sq_port, buf, bytes_read);
 
 	return true;
@@ -2170,6 +2163,18 @@ void qmi_qrtr_node_free(struct qmi_device *device)
 	l_free(node);
 }
 
+void qmi_qrtr_node_set_debug(struct qmi_device *device,
+				qmi_debug_func_t func, void *user_data)
+{
+	struct qmi_device_qrtr *node;
+
+	if (device == NULL)
+		return;
+
+	node = l_container_of(device, struct qmi_device_qrtr, super);
+	__debug_data_init(&node->debug, func, user_data);
+}
+
 static void qrtr_lookup_reply_timeout(struct l_timeout *timeout,
 							void *user_data)
 {
@@ -2196,7 +2201,7 @@ int qmi_qrtr_node_lookup(struct qmi_device *device,
 	if (node->lookup.func)
 		return -EALREADY;
 
-	__debug_device(device, "node %p discover", node);
+	DEBUG(&node->debug, "node %p", node);
 
 	fd = l_io_get_fd(device->io);
 
@@ -2206,13 +2211,12 @@ int qmi_qrtr_node_lookup(struct qmi_device *device,
 	 */
 	addr_len = sizeof(addr);
 	if (getsockname(fd, (struct sockaddr *) &addr, &addr_len) < 0) {
-		__debug_device(device, "getsockname failed: %s",
-				strerror(errno));
+		DEBUG(&node->debug, "getsockname failed: %s", strerror(errno));
 		return -errno;
 	}
 
 	if (addr.sq_family != AF_QIPCRTR || addr_len != sizeof(addr)) {
-		__debug_device(device, "Unexpected sockaddr family: %d size: %d",
+		DEBUG(&node->debug, "Unexpected sockaddr family: %d size: %d",
 				addr.sq_family, addr_len);
 		return -EIO;
 	}
@@ -2225,13 +2229,12 @@ int qmi_qrtr_node_lookup(struct qmi_device *device,
 				sizeof(packet), 0,
 				(struct sockaddr *) &addr, addr_len);
 	if (bytes_written < 0) {
-		__debug_device(device, "Failure sending data: %s",
-				strerror(errno));
+		DEBUG(&node->debug, "sendto failed: %s", strerror(errno));
 		return -errno;
 	}
 
 	l_util_hexdump(false, &packet, bytes_written,
-			device->debug_func, device->debug_data);
+			node->debug.func, node->debug.user_data);
 
 	node->lookup.func = func;
 	node->lookup.user_data = user_data;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index b255d9b83a3e..9f782478311d 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -73,7 +73,8 @@ typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
 struct qmi_device *qmi_qmux_device_new(const char *device);
 void qmi_qmux_device_free(struct qmi_device *device);
-
+void qmi_qmux_device_set_debug(struct qmi_device *device,
+				qmi_debug_func_t func, void *user_data);
 bool qmi_qmux_device_create_client(struct qmi_device *device,
 				uint16_t service_type,
 				qmi_qmux_device_create_client_func_t func,
@@ -83,9 +84,6 @@ bool qmi_qmux_device_get_service_version(struct qmi_device *device,
 					uint16_t *major, uint16_t *minor);
 bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type);
 
-void qmi_device_set_debug(struct qmi_device *device,
-				qmi_debug_func_t func, void *user_data);
-
 int qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
@@ -98,6 +96,8 @@ bool qmi_device_set_expected_data_format(struct qmi_device *device,
 
 struct qmi_device *qmi_qrtr_node_new(uint32_t node);
 void qmi_qrtr_node_free(struct qmi_device *device);
+void qmi_qrtr_node_set_debug(struct qmi_device *device,
+				qmi_debug_func_t func, void *user_data);
 int qmi_qrtr_node_lookup(struct qmi_device *device,
 			qmi_qrtr_node_lookup_done_func_t func,
 			void *user_data, qmi_destroy_func_t destroy);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index bb972977ce0a..422a853c4c7f 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -515,7 +515,7 @@ static int gobi_enable(struct ofono_modem *modem)
 		return -EIO;
 
 	if (getenv("OFONO_QMI_DEBUG"))
-		qmi_device_set_debug(data->device, gobi_debug, "QMI: ");
+		qmi_qmux_device_set_debug(data->device, gobi_debug, "QMI: ");
 
 	r = qmi_device_discover(data->device, discover_cb, modem, NULL);
 	if (!r)
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index d3aee5f4f4ff..6a7d2687791d 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -211,7 +211,7 @@ static int qrtrqmi_enable(struct ofono_modem *modem)
 		return -EIO;
 
 	if (getenv("OFONO_QMI_DEBUG"))
-		qmi_device_set_debug(data->node, qrtrqmi_debug, "QRTR: ");
+		qmi_qrtr_node_set_debug(data->node, qrtrqmi_debug, "QRTR: ");
 
 	r = qmi_qrtr_node_lookup(data->node, lookup_done, modem, NULL);
 	if (!r)
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index b6537629f86d..12fab71ba271 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -156,7 +156,7 @@ static struct test_info *test_setup(void)
 	assert(info->node);
 
 	/* Enable ofono logging */
-	qmi_device_set_debug(info->node, debug_log, NULL);
+	qmi_qrtr_node_set_debug(info->node, debug_log, NULL);
 
 	info->timeout = l_timeout_create(TEST_TIMEOUT, test_timeout_cb, info,
 								NULL);
-- 
2.45.0

