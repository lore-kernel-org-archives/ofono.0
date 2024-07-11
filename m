Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8BA16D4C6
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716584; cv=none; b=hF2+jOKscn8nTRd24PHMXiXnyG9seGcHGxCaB/fDCVn8R1sZQNr69xFhsVCK5ySf4eqFAQaIwfd3W34+KIEHrm1NMWXcBOTo9cBLz9MXf94ACw9PXXcFhrblsMql33YBSNmj7GRY5otUXTkkHTrmr+CJy8iBG1is/U1ZE4FUiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716584; c=relaxed/simple;
	bh=iZlHt/A2O6grO/X1yTE1vnMtETKWcpgDowWu9LQLCbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWNKNA1uQY+Qb3alznml8boPfaK1Kix8SNT0Y/oMaa6StZ3MFR8A1aMv4CJKoYmU7TyCTs55tPk2FXNj4xqGeh049+8gf7ULxblDgHrtSOSC5qvgtzmsY29wYwSaa9Qj1RUb5wF2bRZnMutm/tiLWdrKsycUjuvor1jqgAM3AQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axhbxdW4; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axhbxdW4"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7035d5eec5aso511434a34.1
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716581; x=1721321381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxcAHt31rhaZUfXbtRdoehzVhraF5OL1R/CyD/8mu7M=;
        b=axhbxdW4HVLxhdxA/+fx7pi1YlWf9cgrj3sBRkz66AqsOIbWlDqBFkGxwfKoVcUHcA
         BcJ7acqP8BogyrOBJhKHoR4m/hNwspqUAJxZ1vvsx6LUwQYCD8pww+YPRpLzJuH1dGWt
         eIUJfff56KxRnweI6N6AuhqOBmNwJidrPS36LSULNYvIPwTdpHFadDkIBDA6S0Ewgo2B
         7Q3BO/jRHPZtEfeGL+PfFKtVJz09k1ugvwS3vggffFfPjw2EXBJy6jt5MHQeGhSKBcPD
         6RqVZxIgrQs7IRda5vESZuBQBgEonYwqBVoKgtv5ZylF+cu92JBiYYDuKXOuVq0u8BB7
         8n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716581; x=1721321381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxcAHt31rhaZUfXbtRdoehzVhraF5OL1R/CyD/8mu7M=;
        b=mNnwbZuL5/S2KCh82wSWBBci6kGBn6F8LgdgYSLQpE2T1GSZsqWG8J5Osw0bTWWJbJ
         VXnFsKJCxFIYaK8KnwygDbkESFSC24tFAHdpNAtwqvq6327NkJkVewNSDKFsgwxNOUvk
         1OW/YAhlaXa+yKkEtEaqft5GCE01iX8Lt6nMD9ZR+FnnOzE5A2L/jwXLknIRX5RRo7MR
         sjAHLdPxxyyagWJ0fTF1PHajlf4MgwuWUD8qfYTskpifOJRmTN5RKoporEx2MgHeVlkB
         s7fcEdSq5xJjTwCbjvnkg15KymcbQqcsZ4A7JuRHkWYErcXAPIHvvfRYMZQzo+fqhL75
         kADg==
X-Gm-Message-State: AOJu0Yz5huJtG3CBfj/4nMQL4QudHq+OF85exxs6eecIIQTQeL42xb+I
	49hoi0Xc2bJ348X4OPF/uOGamfVcjhM7Vp4UPmvzuqy3WnvE5cxAquSmXg==
X-Google-Smtp-Source: AGHT+IG8EJEXi2hsXqDVygasiBQyIm6VFpqHpDb9rFvdzq+61QsR/WF4Qfw27bQoO1ZJ2ZR5dHTWuA==
X-Received: by 2002:a9d:480a:0:b0:703:7871:c71e with SMTP id 46e09a7af769-7037871ce5amr9027743a34.1.1720716581370;
        Thu, 11 Jul 2024 09:49:41 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:41 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 05/11] qmi: Pass two dedicated WDS services to gprs-context
Date: Thu, 11 Jul 2024 11:49:27 -0500
Message-ID: <20240711164936.1688973-5-denkenz@gmail.com>
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

