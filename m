Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1F16DC21
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740968; cv=none; b=Odd5GtJflagA99RCaYZUYNVe2zyoS33wO/JylIbrqCOS8iaj4IjeyIysq8al8IOFIf5tqOtNcs5celG+TXwLr+IvCt3D+xhupsaNnGV8Nrwjfj3W7DVqPxc2bQpRvQGD4vOw3GaI/GzYLsoMsa6eKnud2fqf6hf1n340Y7bqyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740968; c=relaxed/simple;
	bh=mbGPjn8vEREaGryrfwrAFP197XAHAet6GON6MNGWSw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGalu96rhn+NdCdfiSaF4xbd4+/WXFka+qRqDF6ia5ciqXJVudj9pUYjcdvp08z1FyomepuXj2Hkd0HGjsYr24GNMI71rNCCV0BYZRlIjhbrJb53UTj4EHEbkNVbAthAAULm1G5X8j5R9+bDnXvMwFpHkWNrUK/ogA+/xbiuAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUQSL6M0; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUQSL6M0"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-254e42df409so3652558fac.0
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740966; x=1719345766; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U2l8mxFICX6hZ5C5qX4FKms7BlvGzmOmlHfLDlvOCc=;
        b=JUQSL6M0pxCu99gVFSBy0w/4FKAz8n+bGEv6NRQ5A5V+UMm1TDuopuzm2wYgpBIueQ
         II8x/anj1jszPJvk06jNX/P8I6mIm60Wxe3PhZyJss79eE4LaAr1Xp8Kg2wSIrpP7CNj
         gtBNhjhkvvfhGMavxuPIu9Nhwxm25k0ps4kWSR+lnBgW66v2qp5b6RDNs3AKLsrMKGlJ
         W2ttfSEiGLn0ySMB6K9AGVigV0GZgg+0lA5aaAV7TTgYe9hxYP1R1JEGT7o8TtYoVxM9
         JSSueYKiXYGoAQM44N64Z1OPC/h7f+6Uycxo8YLZ6sVZhEGuywLSNmBZhacVEu8LvgMw
         Ou1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740966; x=1719345766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U2l8mxFICX6hZ5C5qX4FKms7BlvGzmOmlHfLDlvOCc=;
        b=svJr1aPXnXjF0QSFBr0RNxv+TVd4Hn4l8Shj9hLomgyf5SuX0Sj9vmVemGDIJbHAZ+
         iRzz3+GTJhm2w550LkcwayxBEpXy0/8fZeDjn+/MEHfyFyxfQIHM6VD9gcJXH85/rkXm
         8024vz0e7L4lX3drci2mvYspBcCUOim7ClProv14AqkfGLREHjLOpSCxLArb8Ds9QBoc
         UcMoJywfLzPuJ4yVcmBUvuudegzjScm+EFDuvuAkNhv2m4n49TjnpDbVJ22Csd43ursy
         hk1CRMGk2uum3+DXyA+58WKMIEl07nBVHglYEch/1sX3efL4O2kwNxLLXjYMp4Q3ytxN
         MuTg==
X-Gm-Message-State: AOJu0YwH96/97zybnzEMdepL4cR/EisKpzIU97+UjYBJKRLVIVSC6HCu
	XJBN1oosxt3p6A/1EelIp6twmC7iNbFPEApW9UWxQMG1qn/i4dS7dFUbHA==
X-Google-Smtp-Source: AGHT+IHJayD/c8hUBgqIfAqQz1GEqKeKBfNIAv/d+YwG/ivpTRqgdLSRS9ZZuovfVWyn3HWwK3Hcpg==
X-Received: by 2002:a05:6870:c796:b0:254:9ec6:c8cc with SMTP id 586e51a60fabf-25c94dac897mr617719fac.48.1718740966234;
        Tue, 18 Jun 2024 13:02:46 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:45 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 16/33] qmi: sms: Require at WMS version 1.2+
Date: Tue, 18 Jun 2024 15:01:58 -0500
Message-ID: <20240618200231.1129282-16-denkenz@gmail.com>
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

Move the version check from the SMS atom driver to the gobi modem
driver.  Do not request WMS unless version 1.2 is supported.
---
 drivers/qmimodem/sms.c | 12 ------------
 plugins/gobi.c         | 13 +++++++++++--
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 2ac06a40bdd6..3e2bef6e38b7 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -22,8 +22,6 @@
 
 struct sms_data {
 	struct qmi_service *wms;
-	uint16_t major;
-	uint16_t minor;
 	struct qmi_wms_read_msg_id rd_msg_id;
 	struct qmi_wms_result_msg_list *msg_list;
 	uint32_t rd_msg_num;
@@ -263,16 +261,11 @@ static void qmi_bearer_query(struct ofono_sms *sms,
 
 	DBG("");
 
-	if (data->major < 1 || (data->major == 1 && data->minor < 2))
-		goto error;
-
 	if (qmi_service_send(data->wms, QMI_WMS_GET_DOMAIN_PREF, NULL,
 					get_domain_pref_cb, cbd, l_free) > 0)
 		return;
 
-error:
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-
 	l_free(cbd);
 }
 
@@ -301,9 +294,6 @@ static void qmi_bearer_set(struct ofono_sms *sms, int bearer,
 
 	DBG("bearer %d", bearer);
 
-	if (data->major < 1 || (data->major == 1 && data->minor < 2))
-		goto error;
-
 	domain = bearer_to_domain(bearer);
 
 	param = qmi_param_new_uint8(QMI_WMS_PARAM_DOMAIN, domain);
@@ -314,7 +304,6 @@ static void qmi_bearer_set(struct ofono_sms *sms, int bearer,
 
 	qmi_param_free(param);
 
-error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 	l_free(cbd);
 }
@@ -747,7 +736,6 @@ static int qmi_sms_probe(struct ofono_sms *sms,
 	data->wms = wms;
 	memset(&data->rd_msg_id, 0, sizeof(data->rd_msg_id));
 	data->msg_mode = QMI_WMS_MESSAGE_MODE_GSMWCDMA;
-	qmi_service_get_version(data->wms, &data->major, &data->minor);
 	qmi_service_register(data->wms, QMI_WMS_EVENT, event_notify, sms, NULL);
 
 	ofono_sms_set_data(sms, data);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 23d16e251196..63eb847eb680 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -441,6 +441,8 @@ static void discover_cb(void *user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct gobi_data *data = ofono_modem_get_data(modem);
+	uint16_t major;
+	uint16_t minor;
 
 	DBG("");
 
@@ -448,8 +450,6 @@ static void discover_cb(void *user_data)
 		data->features |= GOBI_DMS;
 	if (qmi_device_has_service(data->device, QMI_SERVICE_NAS))
 		data->features |= GOBI_NAS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_WMS))
-		data->features |= GOBI_WMS;
 	if (qmi_device_has_service(data->device, QMI_SERVICE_WDS))
 		data->features |= GOBI_WDS;
 	if (qmi_device_has_service(data->device, QMI_SERVICE_WDA))
@@ -461,6 +461,15 @@ static void discover_cb(void *user_data)
 	if (qmi_device_has_service(data->device, QMI_SERVICE_VOICE))
 			data->features |= GOBI_VOICE;
 
+	if (qmi_qmux_device_get_service_version(data->device, QMI_SERVICE_WMS,
+						&major, &minor)) {
+		if (major < 1 || (major == 1 && minor < 2))
+			ofono_warn("unsupported WMS version: %u.%u, need: 1.2",
+					major, minor);
+		else
+			data->features |= GOBI_WMS;
+	}
+
 	if (!(data->features & GOBI_DMS)) {
 		if (++data->discover_attempts < 3 &&
 				!qmi_device_discover(data->device, discover_cb,
-- 
2.45.0

