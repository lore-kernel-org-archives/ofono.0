Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355E1AE84E
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895131; cv=none; b=jgC7Up53EUfq19vLkjTxtiGVBTaTZK6LVj/CtFA3mxXtso3V5Ik6sF6ivAfA2WNWH60qReF9qbU/UPju5CnJQWHoD3xvvzgWP6URFsOyHZDwxGk/soDhQKEeFNjjE28ukIpvaJj1gnNwmz/IRTVzNB1lkN/6UXUWzfaLgDbWkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895131; c=relaxed/simple;
	bh=56Ot0PTEwhfavemaDQDb1TUNTYk8+UKWRxv0q2CRkaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtnROqigZOe1xqT80Q+JbuV3kH3uBIsZdv7pQD/vcgj2OMS6zSxlcPghdtuBquNlL92smDrWEYLZMPjo2gTwhZmFOQAJdNS14+1v79eOl2HCZSBXXaLwpyKH+UGeg556EiJk0qF4N8tyGYH9FH31longhw00UjjJ7OTmQlIDDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQWQFVjT; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQWQFVjT"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9b94951cfso524519b6e.3
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895129; x=1719499929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haYp4EdraWRaqbVvQB/vcBkBIMuPxjy+EIeO3xWFwBw=;
        b=lQWQFVjTbQ9R9Lw8WAvxvrSTTriR1w5q8r7MnelGgHz12zU77xG1abHWxapP20ukUd
         jh368/hFrk3xMveoeW61sEt4Mq8LDgk4N/0Dvr0MTlnFstFOz1rzXAzT7h7Ms334I72j
         4PMjJ7SiIGJGCUs12l0HZ0TEcvlSqs6EqIKhI4WYcJSQslg6OlZdBmnWcDsAphndGhxq
         +oPWuwqbrJvdCqu61sz068KFUpfVkeL59Ojf4I4u5OXbS8looCw/r6AKD0dGeofLjx7S
         Hjw5cxf3JErc/yfa/IILvoyJA87SDQxl4xVTILwslQm65KioGF0uSEohFaE3gNQCLlgu
         e1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895129; x=1719499929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haYp4EdraWRaqbVvQB/vcBkBIMuPxjy+EIeO3xWFwBw=;
        b=aQKY3BL5fq9VcfBsT7rnZ3fmIQMgehD8uzEuMR7ompUQnPy6yRlCidWjhTc739Dtyv
         bDn4BhHWNGp4cZ5LmnzpDVZzpeeykaOgQwdVGxM/F9TeaGn0mn2ZaEt21qfolJ3NIKiE
         mqrR+0Dqdnq/ubWhYB8IdPxqVGMUvWZPy7VQCFgUqRTB0o4cSN/DGOl2gJxnSoGu6rG2
         Wu9y32rgpD2wVLK9MVBDUuorWVpMnswHmWmZmYp9M2GhSkPvrQG6C9bsc1xmfWg1OweQ
         wYi/Qf3pq3s1LACrM0ETHQ35fZuclwfeCNjkp7ogzrm2sNA1GjDIYevOa6blUK3TjqzI
         4PHw==
X-Gm-Message-State: AOJu0YwELGRugB9APca7v4HZsYhu7tx6Etqu7ovDGjedE1f0H2Aua5Sg
	leB6Jx1YDkR6UNiYbkjmX9YNID5jqkE4+gZGmSOGRk/MUYf96kn7U6iiZg==
X-Google-Smtp-Source: AGHT+IG9Ljlx3BWgf643uAeLo6Qk763CUV8oEyM2E1vNI04nDLadv+pzL4U1VsSjEXaMss41G0XL+Q==
X-Received: by 2002:a05:6808:300a:b0:3d2:2a17:9208 with SMTP id 5614622812f47-3d51badd4d2mr5694726b6e.51.1718895129461;
        Thu, 20 Jun 2024 07:52:09 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:09 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 21/33] qmi: split qmi_device_has_service into QRTR and QMUX version
Date: Thu, 20 Jun 2024 09:51:08 -0500
Message-ID: <20240620145139.1135899-21-denkenz@gmail.com>
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

---
 drivers/qmimodem/qmi.c | 13 ++++++++++++-
 drivers/qmimodem/qmi.h |  4 ++--
 plugins/gobi.c         | 16 ++++++++--------
 plugins/qrtrqmi.c      | 10 +++++-----
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index f1b2247b4178..f4d32bd702b1 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -988,8 +988,11 @@ bool qmi_qmux_device_get_service_version(struct qmi_device *device,
 	return true;
 }
 
-bool qmi_device_has_service(struct qmi_device *device, uint16_t type)
+bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type)
 {
+	if (!device)
+		return false;
+
 	return __find_service_info_by_type(device, type);
 }
 
@@ -2266,6 +2269,14 @@ done:
 	return service_create(family);
 }
 
+bool qmi_qrtr_node_has_service(struct qmi_device *device, uint16_t type)
+{
+	if (!device)
+		return false;
+
+	return __find_service_info_by_type(device, type);
+}
+
 struct qmi_param *qmi_param_new(void)
 {
 	return l_new(struct qmi_param, 1);
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 2b6a4edb8b85..ef0a8b14c0ef 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -81,6 +81,7 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 bool qmi_qmux_device_get_service_version(struct qmi_device *device,
 					uint16_t type,
 					uint16_t *major, uint16_t *minor);
+bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type);
 
 void qmi_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data);
@@ -90,8 +91,6 @@ int qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
-bool qmi_device_has_service(struct qmi_device *device, uint16_t type);
-
 enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 						struct qmi_device *device);
 bool qmi_device_set_expected_data_format(struct qmi_device *device,
@@ -104,6 +103,7 @@ int qmi_qrtr_node_lookup(struct qmi_device *device,
 			void *user_data, qmi_destroy_func_t destroy);
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
 						uint32_t type);
+bool qmi_qrtr_node_has_service(struct qmi_device *device, uint16_t type);
 
 struct qmi_param;
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 3ab2efc39186..323cc50660cb 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -446,20 +446,20 @@ static void discover_cb(void *user_data)
 
 	DBG("");
 
-	if (qmi_device_has_service(data->device, QMI_SERVICE_DMS))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_DMS))
 		data->features |= GOBI_DMS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_NAS))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_NAS))
 		data->features |= GOBI_NAS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_WDS))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_WDS))
 		data->features |= GOBI_WDS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_WDA))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_WDA))
 		data->features |= GOBI_WDA;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_PDS))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_PDS))
 		data->features |= GOBI_PDS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_UIM))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_UIM))
 		data->features |= GOBI_UIM;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_VOICE))
-			data->features |= GOBI_VOICE;
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_VOICE))
+		data->features |= GOBI_VOICE;
 
 	if (qmi_qmux_device_get_service_version(data->device, QMI_SERVICE_WMS,
 						&major, &minor)) {
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 0f9519d819bc..6f8ee9ce5659 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -186,10 +186,10 @@ static void lookup_done(void *user_data)
 
 	DBG("");
 
-	if (!qmi_device_has_service(node, QMI_SERVICE_DMS) ||
-			!qmi_device_has_service(node, QMI_SERVICE_UIM) ||
-			!qmi_device_has_service(node, QMI_SERVICE_WDS) ||
-			!qmi_device_has_service(node, QMI_SERVICE_NAS))
+	if (!qmi_qrtr_node_has_service(node, QMI_SERVICE_DMS) ||
+			!qmi_qrtr_node_has_service(node, QMI_SERVICE_UIM) ||
+			!qmi_qrtr_node_has_service(node, QMI_SERVICE_WDS) ||
+			!qmi_qrtr_node_has_service(node, QMI_SERVICE_NAS))
 		goto error;
 
 	data->dms = qmi_qrtr_node_get_service(node, QMI_SERVICE_DMS);
@@ -381,7 +381,7 @@ static void qrtrqmi_post_sim(struct ofono_modem *modem)
 
 		ofono_sms_create(modem, 0, "qmimodem", wms);
 
-		if (qmi_device_has_service(node, QMI_SERVICE_UIM))
+		if (qmi_qrtr_node_has_service(node, QMI_SERVICE_UIM))
 			mw = ofono_message_waiting_create(modem);
 
 		if (mw)
-- 
2.45.0

