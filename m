Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AB381AD
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716423; cv=none; b=SsB2r+RRoHciMAU7bHZjwJ5BMbg9Rwh0cPhBu40mA4nXMBiKvcN90DjjKD9mJ2AZ5/g+NlmgJQtwDls6nnZEb/Iw8oH+9eLVchzhvM0CH4thOeEFIHCYWwYI3FQYEH9glgv5K8gDsB4yF5kkJg/+IPKMF/wGvmWQEdpFnRQn3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716423; c=relaxed/simple;
	bh=iZlHt/A2O6grO/X1yTE1vnMtETKWcpgDowWu9LQLCbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1ejB3q/M6Ov1WQDvWPbiUzyJXWB4wCkSfm/vw3El+KjB/0zTrJiHDKfCv6jCwk/m3bowgqCao3iC1FmCp7HgNwTyKdKW6R/KLj7YjtKALnsBPinY9tYIyZ5MRa/Iv3trkUG82dH0h9Sq42pKAYy+wgJAClffhKTRPLRyAbERTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvVdjUIt; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvVdjUIt"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7f70a708f8aso45265339f.2
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716421; x=1721321221; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxcAHt31rhaZUfXbtRdoehzVhraF5OL1R/CyD/8mu7M=;
        b=DvVdjUItdI2YsL0fGQHn9+9s1nlC6XawFUclHQHgpEvI9UWB/o0JJIBqB+/cfu5b6J
         n7RcRnaip9FMaLVv4PHtNLghB+ptlumkYltViqmNhHdlPkBRmgQQREW7wYuDV71vZvXz
         uR+88BhFQzBac9L/GZmgPWsXHXhx3NhEBGYRo4dpSFL4ReRS8N0UKp9jUiMPhP9raABK
         G71w+IWBwE6xKKtKuIa7bs3ckvdayFbV+Hk9WfNwuBGN3HaQUi5Ts6I64d13ZR1FLILi
         YwvkOXN5bFmM8ArPAHiPbsyR8dESy/Q0LArwGJWdjAf8mMUvJqHuw3PwZMy9wvonDT6f
         T1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716421; x=1721321221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxcAHt31rhaZUfXbtRdoehzVhraF5OL1R/CyD/8mu7M=;
        b=i9fdZnlGFLFZgGBSplFxGbXNyh3x9lo56/NcQJvau050S2wuVPDvR/WXMAM3p+gX/M
         NAEOjJcFQ9YGkXfKmF/jErKik+1cOEhisijBB5HzmR8RFkjKjRe7RvfrIq7DBFwDUbny
         NO8t0LYhLbUWSW0pxaJhLM01vzQo+f4yhara0z9d9FbB4KD0Itkf5RFtMbXujqHnohLk
         wyTaAi0ZUS+bYmaQOpyLuGeKFfRmTATAgqp2sox3p4/37705o2Jy/6GzcwjNd2V3zGmZ
         VDPJE3D7jVHvNin0EFZfrXssqD2ctNHm4sDRpU2DnI4nt0xY5RxF0imp1bd4hJYbSi1L
         M9eA==
X-Gm-Message-State: AOJu0Yw7YFC+6KLrGvkrK5mF/Ubp6sbjplyDRz95mq22xVUuU2PODE2O
	z+ewyAGfzk56fhjWZBK61gtcQcUKY0w/Q7qkXxvuT+3h4vw4oMQnFlZcwQ==
X-Google-Smtp-Source: AGHT+IGZFxZMxO0UgboUgIIN/EWKrHMtuGLjXQr4TCC4ACxWD1EQ7a9RGQmhTat+TAUkK3nNG7qE0Q==
X-Received: by 2002:a5d:9304:0:b0:7f9:217c:c109 with SMTP id ca18e2360f4ac-7ffffc36bffmr916072139f.9.1720716421315;
        Thu, 11 Jul 2024 09:47:01 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:47:00 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 08/11] qmi: Pass two dedicated WDS services to gprs-context
Date: Thu, 11 Jul 2024 11:46:25 -0500
Message-ID: <20240711164654.1688558-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
References: <20240711164654.1688558-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gprs-context driver will not take two qmi_service objects, each with a
dedicated WDS service.  This will allow gprs-context to support dual
stack (ipv4 + ipv6) contexts (in future commits).  For now, the behavior
is left unchanged with the second qmi_service being destroyed.
---
 drivers/qmimodem/gprs-context.c |  8 +++++---
 plugins/gobi.c                  | 11 +++++++++--
 plugins/qrtrqmi.c               |  7 +++++--
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 7d13889bf603..5582a8052c0b 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -554,21 +554,23 @@ static int qmi_gprs_context_probev(struct ofono_gprs_context *gc,
 					unsigned int vendor, va_list args)
 {
 	int mux_id = va_arg(args, int);
-	_auto_(qmi_service_free) struct qmi_service *wds =
+	_auto_(qmi_service_free) struct qmi_service *ipv4 =
+					va_arg(args, struct qmi_service *);
+	_auto_(qmi_service_free) struct qmi_service *ipv6 =
 					va_arg(args, struct qmi_service *);
 	struct gprs_context_data *data;
 
 	DBG("");
 
 	if (mux_id != -1) {
-		int r = qmi_gprs_context_bind_mux(gc, wds, mux_id);
+		int r = qmi_gprs_context_bind_mux(gc, ipv4, mux_id);
 
 		if (r < 0)
 			return r;
 	}
 
 	data = l_new(struct gprs_context_data, 1);
-	data->wds = l_steal_ptr(wds);
+	data->wds = l_steal_ptr(ipv4);
 	data->mux_id = mux_id;
 
 	qmi_service_register(data->wds, QMI_WDS_PACKET_SERVICE_STATUS,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 76e1e133860d..cb20824cc424 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -803,10 +803,14 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 
 	/* Simple case of 802.3 interface, no QMAP */
 	if (data->n_premux == 0) {
+		struct qmi_service *ipv4 = data->context_services[0].wds_ipv4;
+		struct qmi_service *ipv6 = data->context_services[0].wds_ipv6;
+
 		interface = ofono_modem_get_string(modem, "NetworkInterface");
 
 		gc = ofono_gprs_context_create(modem, 0, "qmimodem", -1,
-						qmi_service_clone(data->wds));
+						qmi_service_clone(ipv4),
+						qmi_service_clone(ipv6));
 		if (!gc) {
 			ofono_warn("Unable to create gprs-context for: %s",
 					ofono_modem_get_path(modem));
@@ -826,13 +830,16 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 	DBG("max_aggregation_size: %u", data->max_aggregation_size);
 
 	for (i = 0; i < data->n_premux; i++) {
+		struct qmi_service *ipv4 = data->context_services[i].wds_ipv4;
+		struct qmi_service *ipv6 = data->context_services[i].wds_ipv6;
 		int mux_id;
 
 		sprintf(buf, "PremuxInterface%dMuxId", i + 1);
 		mux_id = ofono_modem_get_integer(modem, buf);
 
 		gc = ofono_gprs_context_create(modem, 0, "qmimodem", mux_id,
-						qmi_service_clone(data->wds));
+						qmi_service_clone(ipv4),
+						qmi_service_clone(ipv6));
 
 		if (!gc) {
 			ofono_warn("gprs-context creation failed for [%d] %s",
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index b64ab355a2e8..21103371046a 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -324,10 +324,13 @@ static int setup_gprs_context(uint8_t mux_id, const char *interface,
 	struct ofono_modem *modem = ofono_gprs_get_modem(gprs);
 	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
 	struct qmi_qrtr_node *node = data->node;
+	struct qmi_service *ipv4 = qmi_qrtr_node_get_dedicated_service(node,
+								QMI_SERVICE_WDS);
+	struct qmi_service *ipv6 = qmi_qrtr_node_get_dedicated_service(node,
+								QMI_SERVICE_WDS);
 	struct ofono_gprs_context *gc;
 
-	gc = ofono_gprs_context_create(modem, 0, "qmimodem", mux_id,
-			qmi_qrtr_node_get_service(node, QMI_SERVICE_WDS));
+	gc = ofono_gprs_context_create(modem, 0, "qmimodem", mux_id, ipv4, ipv6);
 	if (!gc) {
 		ofono_warn("Unable to create gprs-context for: %s, %s[%u]",
 				ofono_modem_get_path(modem), interface, mux_id);
-- 
2.45.2

