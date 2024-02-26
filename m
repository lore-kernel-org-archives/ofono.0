Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E712B17B
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961708; cv=none; b=Cgpz7cWQ16Rf+Eb2BzaRCIFKTzg6K3BD7ZoE+qk2EgQxFQexK04bxEbeOPq3+o72IFa65uqSAMu/iaEUiq2//47Vtaw90IKKa68UJde0Vqac5VwdHmDz2dvySO1Eoz1aToIJnQpJ4xJMZAPww37+mSjgZOhWIjDrGywXrLDeY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961708; c=relaxed/simple;
	bh=42DhD/l45U1wB+ZMyWe1iMzWQESdF3EbD3zYwsUMslU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq6jWK60H9WTCBz2gxYXT2XGtmvvFzAz4iTZouMtyw8NVWJRu1dGePTrtzgbeQPJFI/yw/lTM1arByQJLa+AMddBkG875ipu65XUtD0mWcwlRK3kxQ2cLDuVO3JAFy0AZFn/n+cQODS/rqHu9PdtXwbHMavdxLWmeCsCB8fS5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci2xR1Eh; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci2xR1Eh"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22008177fbeso849683fac.2
        for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 07:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961706; x=1709566506; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z3t3MvbjxqwZQVFf1sOMongK0S0FnhpqiL/jI14JTA=;
        b=Ci2xR1EhyjQUeU2fAt5CuR2FGlQsY0j+5rAkLSB4gD78BaPyui/3iTVf69ppuYUkKp
         HksCzatYDZSZObyj6GnzLRdQ6HiiT3plEP2k5cAKNF1FMBCFbB9WUSDzFWF9yqpaKvt0
         1z9nRvi6FE2dP4xgjRs/GM8duVL8mJ9rmibQDiokzdHlXRkibv1OHIPyHk8aARN2laIZ
         GNf5v/7oBRTR3nY9ZrweJHUnQ8P8wzBoD5kTJbWCJrRCGWWzQDovroOvLCx29/1vfc9N
         L1iR6Kq3rVhwOi/3HFCIuItrk99JCl+rcs42TrORE2brXPw/gYlLW/VpHgqJdJO39tOm
         vuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961706; x=1709566506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Z3t3MvbjxqwZQVFf1sOMongK0S0FnhpqiL/jI14JTA=;
        b=BrPZmPrUSgxxrwLeqotRWzy08DI3KoCoFqEl0TlvkQ2Dn5OYh2ZpXaei5/WJsKRSEY
         zA7ioOULxijKC6aL+99jo0Fy6+YQrUTXAefzTk2M2vhtSoU+x2SuWw3wAtgosndmur5H
         5nvqDA4xckxTgX1WdKimCQMCcB/ehqk/WDnAM0YJhm42HoS1t9jUfuOhHfu9Vlv+YlW/
         Ia8X2lrQi38a1dVE8Itq2h3UK93rPDMVPRxRk2TuNBAkuN0ibt01SPsS8V4e0ONyZixc
         FUdX4hWbLF/HjwtUHB2ohuAe/bXgDjoMuiYIrJONLhA09t8ctGkqKnqR8WlDZNOFh/RO
         RwNg==
X-Gm-Message-State: AOJu0YzybF7Pm9Noy3/gJoKcglrc7pWLiBaXwbR21TreL619JoNyDPHZ
	IhA9xy+jPA8bJRPSCNFk0VRzF7vjTLMqqOKlhgH/QB4ZLVbW+OoA6yNQbYXC
X-Google-Smtp-Source: AGHT+IHHK0MFFgVRSFvRBR4oOM3T8403GLOH07f9USvnDtf5rs381P2AwGjloZYRaxA4kViuK52RAQ==
X-Received: by 2002:a05:6870:a692:b0:21e:80a1:3155 with SMTP id i18-20020a056870a69200b0021e80a13155mr9247762oam.6.1708961705780;
        Mon, 26 Feb 2024 07:35:05 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eg14-20020a056870988e00b002201144306csm567048oab.53.2024.02.26.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:35:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/8] qmi: Introduce write driver method
Date: Mon, 26 Feb 2024 09:34:25 -0600
Message-ID: <20240226153459.1463304-6-denkenz@gmail.com>
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

Introduce a new write driver method which will abstract away the
details of submitting a QMI message to the underlying device / protocol.
qmi_device will continue managing the request queue and setup the l_io
write handler accordingly.
---
 drivers/qmimodem/qmi.c | 68 ++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index fbe4640af6c5..2af1d6463783 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -48,6 +48,15 @@ struct discovery {
 	qmi_destroy_func_t destroy;
 };
 
+struct qmi_request {
+	uint16_t tid;
+	uint8_t client;
+	qmi_message_func_t callback;
+	void *user_data;
+	uint16_t len;
+	uint8_t data[];
+};
+
 struct qmi_version {
 	uint8_t type;
 	uint16_t major;
@@ -56,6 +65,7 @@ struct qmi_version {
 };
 
 struct qmi_device_ops {
+	int (*write)(struct qmi_device *device, struct qmi_request *req);
 	int (*discover)(struct qmi_device *device,
 			qmi_discover_func_t discover_func,
 			void *user, qmi_destroy_func_t destroy);
@@ -126,15 +136,6 @@ struct qmi_result {
 	uint16_t length;
 };
 
-struct qmi_request {
-	uint16_t tid;
-	uint8_t client;
-	qmi_message_func_t callback;
-	void *user_data;
-	uint16_t len;
-	uint8_t data[];
-};
-
 struct qmi_notify {
 	uint16_t id;
 	uint16_t message;
@@ -626,30 +627,18 @@ static void __debug_device(struct qmi_device *device,
 static bool can_write_data(struct l_io *io, void *user_data)
 {
 	struct qmi_device *device = user_data;
-	struct qmi_mux_hdr *hdr;
 	struct qmi_request *req;
-	ssize_t bytes_written;
+	int r;
 
 	req = l_queue_pop_head(device->req_queue);
 	if (!req)
 		return false;
 
-	bytes_written = write(l_io_get_fd(device->io), req->data, req->len);
-	if (bytes_written < 0)
+	r = device->ops->write(device, req);
+	if (r < 0) {
+		__request_free(req);
 		return false;
-
-	l_util_hexdump(false, req->data, bytes_written,
-			device->debug_func, device->debug_data);
-
-	__debug_msg(' ', req->data, bytes_written,
-				device->debug_func, device->debug_data);
-
-	hdr = (struct qmi_mux_hdr *) req->data;
-
-	if (hdr->service == QMI_SERVICE_CONTROL)
-		l_queue_push_tail(device->control_queue, req);
-	else
-		l_queue_push_tail(device->service_queue, req);
+	}
 
 	if (l_queue_length(device->req_queue) > 0)
 		return true;
@@ -1202,6 +1191,32 @@ done:
 	return res;
 }
 
+static int qmi_device_qmux_write(struct qmi_device *device,
+					struct qmi_request *req)
+{
+	struct qmi_mux_hdr *hdr;
+	ssize_t bytes_written;
+
+	bytes_written = write(l_io_get_fd(device->io), req->data, req->len);
+	if (bytes_written < 0)
+		return -errno;
+
+	l_util_hexdump(false, req->data, bytes_written,
+			device->debug_func, device->debug_data);
+
+	__debug_msg(' ', req->data, bytes_written,
+				device->debug_func, device->debug_data);
+
+	hdr = (struct qmi_mux_hdr *) req->data;
+
+	if (hdr->service == QMI_SERVICE_CONTROL)
+		l_queue_push_tail(device->control_queue, req);
+	else
+		l_queue_push_tail(device->service_queue, req);
+
+	return 0;
+}
+
 static void __rx_ctl_message(struct qmi_device_qmux *qmux,
 				uint8_t service_type, uint8_t client_id,
 				const void *buf)
@@ -1822,6 +1837,7 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 }
 
 static const struct qmi_device_ops qmux_ops = {
+	.write = qmi_device_qmux_write,
 	.discover = qmi_device_qmux_discover,
 	.client_create = qmi_device_qmux_client_create,
 	.client_release = qmi_device_qmux_client_release,
-- 
2.43.0

