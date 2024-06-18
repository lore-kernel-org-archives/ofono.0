Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB116EB57
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740980; cv=none; b=r/qCbjN9a0ZpCaHUueJfz1Zkq21ff4j2mjGt/VX/zcj7zeL7Kxi0KqvZ/oK0wCYLvXmEbARoJcjEDgW4aJCysPV4UvIz9OYgsWyLvg2EJEePShZ+meA9qxe3h3x93oyCDtBCLyocyaRrELgW9POrGia70rCzhyOJNiUJoYTd7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740980; c=relaxed/simple;
	bh=CslnnGa1m9DfUWAjjHEotmzteKzeUqGJLcAA1PuLjOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdtykDl0qnED/0NT0UVnc02NqLOu6zlx86oHj/95B/o7qbQymxgKKwIxSv4C8zZXyvwN6+e094L6xin/YRm2DZmrHBU3W1WwaaGV7azm/G7c5PKtxBQfxYdi79VLMqY2bEBEKYJviXwYyS46wL3tIij93zSm7u2p7RLgmmXahlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKO98hun; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKO98hun"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2598a57b2c1so314384fac.0
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740978; x=1719345778; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud+nxUAFMEuWeebql4YXA4OOlpC4063orE/63Kn5S28=;
        b=UKO98hunwVMnVu0lfETdjphXMq8QXudIan0zVH0b5Fs2cjz0511w+gvADFFEfOmV1N
         14NK5zYSursrcMgFDVOMaolDmPID8/BPamJntdiMpjU/A5/7popJZZZbfUoX7f/KmBB/
         n2Jq7iH9+92sECY+YK+9TGCR1kSMvLXKIgNvbkFiOD8SNewSF2qGLL7XyfIcroQ16kJZ
         n1pxXSrRD2LXg5pKNOuW1U/gbsXlrG4se9FbvYbDm1Mqq5EGtsdfhELVYiKAMZsMLksE
         ffbpFjqqGGWmZV7KbcmFwmHWYBGxFkPjfxv/3x/hsyUF5uLE4FULBFZBkoTKZiFrSEB+
         Bu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740978; x=1719345778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ud+nxUAFMEuWeebql4YXA4OOlpC4063orE/63Kn5S28=;
        b=fw368JnnoiyGokDndH7Uehju68ojovPbzT6sBIDIyMIAi6LJp8zF1mUAT/eg+E+BQ6
         auZiO+QN82x0p8T1V6h5FF/P/48rC4dMyynYyWAEOg2Zr84xVA/3sHfksHwQ6yf/2JuY
         PCdaDRsesiLEBmVzT6yRAgd2j26Z/bBmIhvbim3vXNxCsUpjbQOBkXEbox4AxF1aBymO
         wba5z2Z6W1r1wzGRPAXSO0/NXQNjVzRG+mQ8yRksIFY/I3r3tHg0Hi0Z4I8j/gXxW4R0
         n05Udr0tYiCDnO3zBqG5ljKaktglC2RbjrJcQULW3P5uNA0b4EBL81hzsmIc20YtD6so
         5a0w==
X-Gm-Message-State: AOJu0YzSNgWwIYCs9QLJ1PmneUFpD68vkmy6bz9c+pyqx3iyWx3HhFm3
	r7laY3NNySLM2zBhwdzAucRrBTOdAL2zKlVCxD2Dgm63tjHyQlUPeQqBoA==
X-Google-Smtp-Source: AGHT+IF8M/ONfU3R/fmLkP0zY/0RYpQY2D8WGclxQfXjXqrjeT55smXLJg3mIywx4dbW9+EXb1pyog==
X-Received: by 2002:a05:6870:9121:b0:259:89cc:d80b with SMTP id 586e51a60fabf-25c94a0e4cemr855006fac.32.1718740978453;
        Tue, 18 Jun 2024 13:02:58 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:58 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 33/33] qmi: non-premultiplexed MHI devices
Date: Tue, 18 Jun 2024 15:02:15 -0500
Message-ID: <20240618200231.1129282-33-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MHI devices by default create a single main interface and support a
single bearer over it.  However, this requires a WDS Bind Data Mux
command to be issued with 'mux_id' 0.  Update the qmi gprs_context
atom driver to support multiple arguments, one of them being the mux_id
and the other being the WDS service lightweight handle.  If mux_id is
-1, then the WDS Bind Data Mux command is skipped.  Update gobi and
qrtrqmi drivers to the new API.
---
 drivers/qmimodem/gprs-context.c | 15 ++++++++-------
 plugins/gobi.c                  |  4 ++--
 plugins/qrtrqmi.c               |  9 ++++++++-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index aae058f35a9b..3c18476142ea 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -550,16 +550,17 @@ static int qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc,
 	return -EIO;
 }
 
-static int qmi_gprs_context_probe(struct ofono_gprs_context *gc,
-					unsigned int vendor, void *user_data)
+static int qmi_gprs_context_probev(struct ofono_gprs_context *gc,
+					unsigned int vendor, va_list args)
 {
-	struct qmi_service *wds = user_data;
+	int mux_id = va_arg(args, int);
+	struct qmi_service *wds = va_arg(args, struct qmi_service *);
 	struct gprs_context_data *data;
 
 	DBG("");
 
-	if (vendor) {
-		int r = qmi_gprs_context_bind_mux(gc, wds, vendor);
+	if (mux_id != -1) {
+		int r = qmi_gprs_context_bind_mux(gc, wds, mux_id);
 
 		if (r < 0) {
 			qmi_service_free(wds);
@@ -569,7 +570,7 @@ static int qmi_gprs_context_probe(struct ofono_gprs_context *gc,
 
 	data = l_new(struct gprs_context_data, 1);
 	data->wds = wds;
-	data->mux_id = vendor;
+	data->mux_id = mux_id;
 
 	qmi_service_register(data->wds, QMI_WDS_PACKET_SERVICE_STATUS,
 					pkt_status_notify, gc, NULL);
@@ -593,7 +594,7 @@ static void qmi_gprs_context_remove(struct ofono_gprs_context *gc)
 
 static const struct ofono_gprs_context_driver driver = {
 	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
-	.probe			= qmi_gprs_context_probe,
+	.probev			= qmi_gprs_context_probev,
 	.remove			= qmi_gprs_context_remove,
 	.activate_primary	= qmi_activate_primary,
 	.deactivate_primary	= qmi_deactivate_primary,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index d24b95fffc91..7cdab3dda5f5 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -762,7 +762,7 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 	if (n_premux == 0) {
 		interface = ofono_modem_get_string(modem, "NetworkInterface");
 
-		gc = ofono_gprs_context_create(modem, 0, "qmimodem",
+		gc = ofono_gprs_context_create(modem, 0, "qmimodem", -1,
 						qmi_service_clone(data->wds));
 		if (!gc) {
 			ofono_warn("Unable to create gprs-context for: %s",
@@ -788,7 +788,7 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 		sprintf(buf, "PremuxInterface%dMuxId", i + 1);
 		mux_id = ofono_modem_get_integer(modem, buf);
 
-		gc = ofono_gprs_context_create(modem, mux_id, "qmimodem",
+		gc = ofono_gprs_context_create(modem, 0, "qmimodem", mux_id,
 						qmi_service_clone(data->wds));
 
 		if (!gc) {
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 51e682f7e87c..cc335546caff 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -315,7 +315,7 @@ static int setup_gprs_context(uint8_t mux_id, const char *interface,
 	struct qmi_qrtr_node *node = data->node;
 	struct ofono_gprs_context *gc;
 
-	gc = ofono_gprs_context_create(modem, 0, "qmimodem",
+	gc = ofono_gprs_context_create(modem, 0, "qmimodem", mux_id,
 			qmi_qrtr_node_get_service(node, QMI_SERVICE_WDS));
 	if (!gc) {
 		ofono_warn("Unable to create gprs-context for: %s, %s[%hhu]",
@@ -347,6 +347,13 @@ static void setup_gprs(struct ofono_modem *modem)
 		return;
 	}
 
+	/* Upstream driver default, single interface, single context */
+	if (!n_premux) {
+		interface = ofono_modem_get_string(modem, "NetworkInterface");
+		setup_gprs_context(0, interface, gprs);
+		return;
+	}
+
 	for (i = 0; i < n_premux; i++) {
 		int mux_id;
 
-- 
2.45.0

