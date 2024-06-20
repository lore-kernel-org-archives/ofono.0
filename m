Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C3B1AE84E
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895142; cv=none; b=EgQ96GhD5Fjm63bBhmqogKn64OhauztrTdvGQG6uaDlf9JPqqLrN4w6oRZhq+Zh8tmVyynP8yXam76ZVG4jcW/4HC2vpHppB6X/xrOIYZggR/N7MPh7lngX3h8AgpQ+70QOnsvIWf/W0E6AI87WcxxxBRcW34s+E6w2nziTwgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895142; c=relaxed/simple;
	bh=u4r4Z5B8nPfLOx8kkNZYKuTGuZ/ZqXJ+XTDUWU9gmHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv4I2NGiuD9SkC1BzAulOohZqEE5F25r18vLMOfBVUBl/6eCFU9zaD4JuRpzyWJPM2rC2Xokg5QpQtTQXVL6GJYzc4q+ZaZ0+6Jsb8JJ4MdTHJp1b0GycwaWrLUmfcK1FTV4aZU3wNzdyw7VydU6cmRND8+yJfZHC5Fr/3xsOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noz7NREL; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noz7NREL"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d220039bc6so496510b6e.2
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895140; x=1719499940; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fhBGXltfy/mdExm/l1Sr4wjj3GAkKUjYJEb9m/uMV4=;
        b=noz7NRELCmfn2z2g2MRmr1fJ+nD6U7apKwUkavhxdMDfLJ4+RkxX/rmWT4RZ08dvW4
         4QulcrjtM95NLa+RdDtC3q5oVP4N/HcG9KpVg3vZXx9WRCjOoFA7bQ3QzVrUdmVZmUEW
         fBuNNBXHLxOJgF+oVGA+RPPFEMfrHQJo/bWcWZG/ceTKJlVPG3YSYh7pCd1AesfST8Vn
         GeF1CDIkFLXgoIFJeDBOhpOYsby17IV6wEn7HE0xVrZpCpRQqPisqrurh88DEpaelHKg
         2W/KI0ERcOqPnl/a8qJah2rFR7Lq6B+8Ak2XnJBz6itbo6K97Yx1cTO/sVmxJwy3L8dU
         KQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895140; x=1719499940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fhBGXltfy/mdExm/l1Sr4wjj3GAkKUjYJEb9m/uMV4=;
        b=FJMp4c1gRQKK01UFlSnmdJ2+NBHsFHSRJ7+Eem+0kdtWgxPguMKijJdcz186u9L18p
         pg8vtb6fsxizycBfojLU2kmoOPvxthNNg6CdxOs1EDWol2aIBmXbGRavlNHpJuuPqXHW
         ZBlvkGHl5BD6SeWFBr5ehFpsxuu5WOMNZSJxhQAeHyfZ/d9mWZwMAYrFVnKzcSwBqgFg
         XJx6X2H4jVV136LTSgAQnBkLzeu6jeI+4M1K6dqlfC+id8fO+8DrbkV7uiezYt0bnq55
         BvmENOF6z7zo8gqAD8ndCj9ZsPNBF+BVczE0EDLVwzEgLthiwh/Eg5ITU4e8m5omQBaa
         jnLA==
X-Gm-Message-State: AOJu0YwBzLAQYWVTfO5r2jXefupsuXa+j4ThSKyw1+pwTobTxVKpxWGZ
	6BlkARnQq9p705KA479Piqdq650p63yjNi7xphdNVtaDkMsCl3A8yyxpgQ==
X-Google-Smtp-Source: AGHT+IFpVbKoT6DQgaJb9bt6p7dm0UuBHgB/ZZmwsq+vytVKkiG+rCGMeQhb0ZPZNtJ6+vRmJnR9Sg==
X-Received: by 2002:a05:6808:128b:b0:3d5:1f50:188b with SMTP id 5614622812f47-3d51f502960mr5508374b6e.23.1718895140056;
        Thu, 20 Jun 2024 07:52:20 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:19 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 33/33] qmi: non-premultiplexed MHI devices
Date: Thu, 20 Jun 2024 09:51:20 -0500
Message-ID: <20240620145139.1135899-33-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
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
index 128874f12cfa..e25807753e20 100644
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
index cf04d05f65cc..4117cac11423 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -315,7 +315,7 @@ static int setup_gprs_context(uint8_t mux_id, const char *interface,
 	struct qmi_qrtr_node *node = data->node;
 	struct ofono_gprs_context *gc;
 
-	gc = ofono_gprs_context_create(modem, 0, "qmimodem",
+	gc = ofono_gprs_context_create(modem, 0, "qmimodem", mux_id,
 			qmi_qrtr_node_get_service(node, QMI_SERVICE_WDS));
 	if (!gc) {
 		ofono_warn("Unable to create gprs-context for: %s, %s[%u]",
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

