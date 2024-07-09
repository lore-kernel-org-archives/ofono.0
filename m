Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B4156F43
	for <ofono@lists.linux.dev>; Tue,  9 Jul 2024 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565453; cv=none; b=GdqNU9o4XCCyWqkubYWCZLmrsMEEXIVn3sKR3j2qSoAN/bQgnw2oRxD5Qe3oWuFioc43N26yIX+uyLlH1+jQ9GnD3VmV+7crhQ85xy7DQJ8+CZFCQ+phhrf/O6SNc1AoJv7nucj84zDAxwNb0Ti/VQ576UEBFVKDYS/oZqQ/JSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565453; c=relaxed/simple;
	bh=iZlHt/A2O6grO/X1yTE1vnMtETKWcpgDowWu9LQLCbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCTkTKLLcvJa8LAnBN5uXi2QDVlOscSpw3cmeMArKYZDScOJts2KZDCvgEMnBkzlH47DzzSCGx2+K42YaCd29cwD7+Uy5pTmRO13NDf6i3ZzNqf4IijYS6pMdm+w6G4BzSXilr1XDMFBe4UcKUYAy/UQbsByRzexUEYwrdUgxSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/5KIstG; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/5KIstG"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3839d74a2abso20108395ab.1
        for <ofono@lists.linux.dev>; Tue, 09 Jul 2024 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720565451; x=1721170251; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxcAHt31rhaZUfXbtRdoehzVhraF5OL1R/CyD/8mu7M=;
        b=g/5KIstGv7JDORlTPWpwIh08Lv/8Yw1daAuSrDFOURhL8ONNhWuoWht2bmur1sCYSv
         ZbbSts0lB6yvM963jl8iUdWav6gsXROg/X1MBhB41R/GUyh89J5Cdedlk1pI4egsfrCW
         /B+crwmQkUSvaPFO4yOEUZoy3MiBLRY2yK2HSRja1I40K9tXKaSBohiIWiN9DE+by4mA
         B3jPEkBKTbe24kwq9PUy3vjyeIJY2TbI1rMZqfP+l135WX0iVCTWCsdsVsYsg1Gd/hTe
         EExlTa3Qog+TybvFdFXlGerGc3TIlfgnsJn48XT3nHEViddX/x6/0otH0o8pHmP33Ss1
         zvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565451; x=1721170251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxcAHt31rhaZUfXbtRdoehzVhraF5OL1R/CyD/8mu7M=;
        b=JU52oMGimEp0p9iKhy3AbpZ3Gbnh56Cai2anMipqOrxeZtbThUoRf/stoIk6DPgWFA
         OfDPXuyFceReQLfb/bB7rtZTGsTjmz3ZnTMI3PkcCTMfkN/Vw+tIziNMU8GF0QlZIcYf
         24fAh0aa/z5RRCTbPebUj//Su//E7XiUgYFy+bUL/7CKozYUN/SEpAy7C2+Rno7bCGXP
         1X0nrx09de91GwmFELnVFpf14AobYipDaP3zR20PSKIE9MbvYQqZRvwvGxnZdNdaREoQ
         mmZtYpzH9ZYaxSvr5bQuJ8MMLt9pam03TLnbl74wpX3FNvWlJzl7/hlSUbkXWyJdMf6s
         IugQ==
X-Gm-Message-State: AOJu0YxgEmLa6XsvgEdO9MPsxakUG5mzdRkAFXfQCRPBA9VFEp+dl6Nc
	Oec30CB5QMfsKyqHgmFJaGRS97DAsL5ni4guxY2THk6QVxPnnxvSnE7pDA==
X-Google-Smtp-Source: AGHT+IFrf3x4S2PlePnzUsVgHQ6mpEcmOjeelNzDbl9zoqjAgLYIjJvKgZClflVm4TNjVkh3gHub8Q==
X-Received: by 2002:a05:6e02:1d0f:b0:377:1611:1b49 with SMTP id e9e14a558f8ab-38a59d923e7mr40520755ab.25.1720565451216;
        Tue, 09 Jul 2024 15:50:51 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49075808sm6300075ab.15.2024.07.09.15.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:50:50 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/11] qmi: Pass two dedicated WDS services to gprs-context
Date: Tue,  9 Jul 2024 17:50:24 -0500
Message-ID: <20240709225047.1427626-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709225047.1427626-1-denkenz@gmail.com>
References: <20240709225047.1427626-1-denkenz@gmail.com>
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

