Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048AF604CC
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961707; cv=none; b=T0U3vtWx2rYi5VCecndNI7JAhpfayqa4DSpK7YC868MrVyQEXMEalaDxB9+s9f+VD/q2UeSlA1vgo3SHf0K/7309Nxajp2PjIpm/CmUbUBQ6vIHfembWhZnBNLTombNMLe5gXSBs0obTAIs4TlYbr0JtnfAQ7Jh1vIRYG5PfVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961707; c=relaxed/simple;
	bh=BjQbmdogoCkD9JHW4n9MDQDvcLbZ0losPTQCBQ3r+os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJgQjHaoF2jcNt1KFmGkedakvjQ+u+wQXwT+FCnoi/LsWKyxjbXs6cHQ8ThI02lf8kgk5ARz3oWjh+YksxdH+x25qracxOx4JkFGtc/2fz/L0Cj38O9gDJf0wqyazvTPm3NipBFwxF1+hymFWoGMXGpktEyML/zb+OVEg75BBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu+zknbX; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu+zknbX"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21fa97a9c53so1371898fac.3
        for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961705; x=1709566505; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTiPOC6A8OOZTio+EtQ+HEbW0pT+EHgiuLZy/9I4pBw=;
        b=Mu+zknbXqPJLAx34rYKuSR6qHpYHpEtZpRypyRhexSIAytz4l0aUR4LVcLuxwUe2Vk
         vrrgTeg1INg5hLdM0sL7Dt4mmdZhEc+FPlkW5iAgfDTTHPl2TZ6pa/iLgI34E/PHCo4s
         ytZeu6tg/qbQaLL2c1noUuuF/bZGclrMP5ivi2elqmI411y1LtI0y+Qkw1XbL3k3o+yf
         tjHV6f0JhMwoyuehAFQodHoLTc5M8TvAulboe1AAPsdlc0g3lE3Lo6H+JeTQEFOZBwEL
         R+52aVPPv8hMJKBdqtmRSaYvb6osIB3yNZS9rpbwbBEzP0k57ckx6W7O4Zbrm4kqXNaI
         cRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961705; x=1709566505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTiPOC6A8OOZTio+EtQ+HEbW0pT+EHgiuLZy/9I4pBw=;
        b=OHXn3wMgmSbGivf/o0bHOfrwDNCy2AhyAB7BCTkfTyT/eWtRk7CGeU4ac0yiPNsteJ
         suzWs+w47jv4otnG7ZEiqpamys2ceiYvBHjpJp4kS3H71THrqdmGc/eJkP4hczvnxZFU
         EPgogbR1sPT3PcVYUpf0MnojY/tbgjnT+NLzww3nPCEdzFSJYp/xcpAzYvL/PtgsXpPT
         /pE6/AFzfdjPuxMv+hrjrhDsbOjnzuBKBEwl9A/XupttkZEUPrhaCdblJkveVgUmFpYl
         Dvzt9ycrKZkm0+qEzVZq5I8+c9D0PNh1emQw86fdr7ZCs+UenDmr3q67y+7GQ6nmPPML
         iWlw==
X-Gm-Message-State: AOJu0YwD7fPwDmZH14B4ORwJYKd4nxNBI/HqjraSFpAd5+2OHo4D7LXM
	B2BWwv153fAYuWxYzZcaEmNvoZEuJK+XzORm2h6sAERmIo8x3TTE8aC4YVcF
X-Google-Smtp-Source: AGHT+IEAvwdow+QBRUDJS8v/Sz7J2RduGDik8nR044g+lMypbJpDdfH6G0gvKIiNKKGi5bQtWWj0Tg==
X-Received: by 2002:a05:6870:831c:b0:21f:9f20:2f58 with SMTP id p28-20020a056870831c00b0021f9f202f58mr8223990oae.24.1708961705008;
        Mon, 26 Feb 2024 07:35:05 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eg14-20020a056870988e00b002201144306csm567048oab.53.2024.02.26.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:35:04 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/8] qmi: Split RX path into QMUX and generic parts
Date: Mon, 26 Feb 2024 09:34:24 -0600
Message-ID: <20240226153459.1463304-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226153459.1463304-1-denkenz@gmail.com>
References: <20240226153459.1463304-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_packet currently handles both CTL and generic service messages
coming from the device.  In all cases, QMUX framing is assumed.  Split
up this function into two, one for parsing and handling the CTL packets,
and one for all other service messages.

As a result, the reader handler is renamed to received_qmux_data() and
set into l_io inside qmi_device_new_qmux() constructor.
---
 drivers/qmimodem/qmi.c | 211 +++++++++++++++++++++--------------------
 1 file changed, 110 insertions(+), 101 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 9843a9b33e5c..fbe4640af6c5 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -751,65 +751,30 @@ static void handle_indication(struct qmi_device *device,
 	service_notify(NULL, service, &result);
 }
 
-static void handle_packet(struct qmi_device *device,
-				const struct qmi_mux_hdr *hdr, const void *buf)
+static void __rx_message(struct qmi_device *device,
+				uint8_t service_type, uint8_t client_id,
+				const void *buf)
 {
+	const struct qmi_service_hdr *service = buf;
+	const struct qmi_message_hdr *msg = buf + QMI_SERVICE_HDR_SIZE;
+	const void *data = buf + QMI_SERVICE_HDR_SIZE + QMI_MESSAGE_HDR_SIZE;
 	struct qmi_request *req;
-	uint16_t message, length;
-	const void *data;
-
-	if (hdr->service == QMI_SERVICE_CONTROL) {
-		const struct qmi_control_hdr *control = buf;
-		const struct qmi_message_hdr *msg;
-		unsigned int tid;
-
-		/* Ignore control messages with client identifier */
-		if (hdr->client != 0x00)
-			return;
-
-		msg = buf + QMI_CONTROL_HDR_SIZE;
-
-		message = L_LE16_TO_CPU(msg->message);
-		length = L_LE16_TO_CPU(msg->length);
-
-		data = buf + QMI_CONTROL_HDR_SIZE + QMI_MESSAGE_HDR_SIZE;
-
-		tid = control->transaction;
-
-		if (control->type == 0x02 && control->transaction == 0x00) {
-			handle_indication(device, hdr->service, hdr->client,
-							message, length, data);
-			return;
-		}
-
-		req = l_queue_remove_if(device->control_queue,
-						__request_compare,
-						L_UINT_TO_PTR(tid));
-	} else {
-		const struct qmi_service_hdr *service = buf;
-		const struct qmi_message_hdr *msg;
-		unsigned int tid;
-
-		msg = buf + QMI_SERVICE_HDR_SIZE;
-
-		message = L_LE16_TO_CPU(msg->message);
-		length = L_LE16_TO_CPU(msg->length);
-
-		data = buf + QMI_SERVICE_HDR_SIZE + QMI_MESSAGE_HDR_SIZE;
+	unsigned int tid;
+	uint16_t message;
+	uint16_t length;
 
-		tid = L_LE16_TO_CPU(service->transaction);
+	message = L_LE16_TO_CPU(msg->message);
+	length = L_LE16_TO_CPU(msg->length);
+	tid = L_LE16_TO_CPU(service->transaction);
 
-		if (service->type == 0x04) {
-			handle_indication(device, hdr->service, hdr->client,
-							message, length, data);
-			return;
-		}
-
-		req = l_queue_remove_if(device->service_queue,
-						__request_compare,
-						L_UINT_TO_PTR(tid));
+	if (service->type == 0x04) {
+		handle_indication(device, service_type, client_id,
+					message, length, data);
+		return;
 	}
 
+	req = l_queue_remove_if(device->service_queue, __request_compare,
+						L_UINT_TO_PTR(tid));
 	if (!req)
 		return;
 
@@ -819,53 +784,6 @@ static void handle_packet(struct qmi_device *device,
 	__request_free(req);
 }
 
-static bool received_data(struct l_io *io, void *user_data)
-{
-	struct qmi_device *device = user_data;
-	struct qmi_mux_hdr *hdr;
-	unsigned char buf[2048];
-	ssize_t bytes_read;
-	uint16_t offset;
-
-	bytes_read = read(l_io_get_fd(device->io), buf, sizeof(buf));
-	if (bytes_read < 0)
-		return true;
-
-	l_util_hexdump(true, buf, bytes_read,
-			device->debug_func, device->debug_data);
-
-	offset = 0;
-
-	while (offset < bytes_read) {
-		uint16_t len;
-
-		/* Check if QMI mux header fits into packet */
-		if (bytes_read - offset < QMI_MUX_HDR_SIZE)
-			break;
-
-		hdr = (void *) (buf + offset);
-
-		/* Check for fixed frame and flags value */
-		if (hdr->frame != 0x01 || hdr->flags != 0x80)
-			break;
-
-		len = L_LE16_TO_CPU(hdr->length) + 1;
-
-		/* Check that packet size matches frame size */
-		if (bytes_read - offset < len)
-			break;
-
-		__debug_msg(' ', buf + offset, len,
-				device->debug_func, device->debug_data);
-
-		handle_packet(device, hdr, buf + offset + QMI_MUX_HDR_SIZE);
-
-		offset += len;
-	}
-
-	return true;
-}
-
 static void __qmi_device_discovery_started(struct qmi_device *device,
 						struct discovery *d)
 {
@@ -911,7 +829,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 
 	device->io = l_io_new(fd);
 	l_io_set_close_on_destroy(device->io, true);
-	l_io_set_read_handler(device->io, received_data, device, NULL);
 
 	device->req_queue = l_queue_new();
 	device->control_queue = l_queue_new();
@@ -1285,6 +1202,97 @@ done:
 	return res;
 }
 
+static void __rx_ctl_message(struct qmi_device_qmux *qmux,
+				uint8_t service_type, uint8_t client_id,
+				const void *buf)
+{
+	const struct qmi_control_hdr *control = buf;
+	const struct qmi_message_hdr *msg = buf + QMI_CONTROL_HDR_SIZE;
+	const void *data = buf + QMI_CONTROL_HDR_SIZE + QMI_MESSAGE_HDR_SIZE;
+	struct qmi_request *req;
+	uint16_t message;
+	uint16_t length;
+	unsigned int tid;
+
+	/* Ignore control messages with client identifier */
+	if (client_id != 0x00)
+		return;
+
+	message = L_LE16_TO_CPU(msg->message);
+	length = L_LE16_TO_CPU(msg->length);
+	tid = control->transaction;
+
+	if (control->type == 0x02 && control->transaction == 0x00) {
+		handle_indication(&qmux->super, service_type, client_id,
+					message, length, data);
+		return;
+	}
+
+	req = l_queue_remove_if(qmux->super.control_queue, __request_compare,
+						L_UINT_TO_PTR(tid));
+	if (!req)
+		return;
+
+	if (req->callback)
+		req->callback(message, length, data, req->user_data);
+
+	__request_free(req);
+}
+
+static bool received_qmux_data(struct l_io *io, void *user_data)
+{
+	struct qmi_device_qmux *qmux = user_data;
+	struct qmi_mux_hdr *hdr;
+	unsigned char buf[2048];
+	ssize_t bytes_read;
+	uint16_t offset;
+
+	bytes_read = read(l_io_get_fd(qmux->super.io), buf, sizeof(buf));
+	if (bytes_read < 0)
+		return true;
+
+	l_util_hexdump(true, buf, bytes_read,
+			qmux->super.debug_func, qmux->super.debug_data);
+
+	offset = 0;
+
+	while (offset < bytes_read) {
+		uint16_t len;
+		const void *msg;
+
+		/* Check if QMI mux header fits into packet */
+		if (bytes_read - offset < QMI_MUX_HDR_SIZE)
+			break;
+
+		hdr = (void *) (buf + offset);
+
+		/* Check for fixed frame and flags value */
+		if (hdr->frame != 0x01 || hdr->flags != 0x80)
+			break;
+
+		len = L_LE16_TO_CPU(hdr->length) + 1;
+
+		/* Check that packet size matches frame size */
+		if (bytes_read - offset < len)
+			break;
+
+		__debug_msg(' ', buf + offset, len,
+				qmux->super.debug_func, qmux->super.debug_data);
+
+		msg = buf + offset + QMI_MUX_HDR_SIZE;
+
+		if (hdr->service == QMI_SERVICE_CONTROL)
+			__rx_ctl_message(qmux, hdr->service, hdr->client, msg);
+		else
+			__rx_message(&qmux->super,
+					hdr->service, hdr->client, msg);
+
+		offset += len;
+	}
+
+	return true;
+}
+
 struct service_create_shared_data {
 	struct discovery super;
 	struct qmi_service *service;
@@ -1839,6 +1847,7 @@ struct qmi_device *qmi_device_new_qmux(const char *device)
 	}
 
 	qmux->next_control_tid = 1;
+	l_io_set_read_handler(qmux->super.io, received_qmux_data, qmux, NULL);
 
 	return &qmux->super;
 }
-- 
2.43.0

