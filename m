Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CA168AEF
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605709; cv=none; b=dzRqZMZl2a5QjGyWRmTDIiIZJ48kMABCMp+TxWeYEOU7bW9Znqvh/MWuOJpjcSP13+S/yRDR2kXyQtf53IVi4CeivZ4lyXW63LKUnd02Dveef9oY636iMg9ao0eDCSH1Jy6fK0Iv3dGyb3nosDQA1ABCtwcjdz/U9u4z7tVLaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605709; c=relaxed/simple;
	bh=mRikR+TPi0u8mzUB3SReiH/SNsNVudtIi7iY4VVZBfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT9F2DQrLJsE4v7QvWIZ+LghSP/e4IWxUbVjclW8QUP9sqc5OLXQ2Vq4leruFEMv07t/wb22jIAE3Wm/q8fI5GaSkiQRLWEExap0ymIavw6mSiFEOcK+z/PbJYSruUypT6Ux7h3PCX6l/v5byUD0jxerEGWUITwtELJdc7xmj0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO26dVHY; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO26dVHY"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ef94f1ce39so894159a34.3
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714605707; x=1715210507; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz6f/mYgDeRduQdrtX2spyDbk2Ot7vDBmYMs0Vn0VIA=;
        b=WO26dVHYVQ6QpCttEBiJlbbAGBTYSBZ1jLybgGcOf0hd3Ru+bU8n7KtEPBSmVESdzF
         IttBC6d67yKBnnQ8eulklzrrQXHWUcyugzJMcnOleA1D/cifYyu/iybc6RzxNrB4769e
         T8pz6uMunE+wygsHo4bsJKJJZzQMHVk4GHeditRyQpmWO7089nBZJHgujfYXyb5jLPgq
         xYpack5kBxfh/HrQml86gVW/TlUktVi0czo01KCzJKQKn18fl7Ps+XqhQltYj2BMUrv6
         oYIP7o8Om/LtwQHgoQ+iAsxmd7/QMQg2P8EzQbB24hXGZfin1n4qV2Kz8/FX8wx1l2RN
         HXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605707; x=1715210507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz6f/mYgDeRduQdrtX2spyDbk2Ot7vDBmYMs0Vn0VIA=;
        b=iFNhqzEI+mQTpremY02v5+pTDnNfwFb9dNI7NRa5K8V+QiGLKU1scgcszAPv1bsOiP
         8VC61pwRVWfd94US6mhx03l3pD5/CYQ+UugEEOVoW1KLfAqcjgYw93NRHmvFd9LIMKF1
         rik+RTY7jJ/wYOLYYPU537LF6THos2Q4eyHTdpi7Y0xWzsQ0IsyoVWpPSVIRFNcniznX
         u6Oxv6nBwj60bZ0a/1IzPZasCuff6dWzEYWlVLWYqJo7lDt5Ai4pBj6t9tWBRTFLmZ2+
         fuT6EZtSbAHsTW60n8Cl2gd8sadyajB09WO7ctgVpa88PvttziyMsfjdanHr/U1ZTidZ
         GLkQ==
X-Gm-Message-State: AOJu0Yw8HLINquZmfYLQsA/TDK0aigI9buwzVa5mqcaZEDajc4xtrjSZ
	up7v+DFiqPXj3sodMTIBIo5Yl9alkmxDeZnSDr9D4q5eWwKACTo7D58ewg==
X-Google-Smtp-Source: AGHT+IGPYlit3D1oz8EZZEcitOO/ZmBdDW5YrT5qjbNbCUZGO7Izd5HCpIEdO7DzPMPcmcqTzhdy6g==
X-Received: by 2002:a05:6830:1daa:b0:6eb:8fc7:c570 with SMTP id z10-20020a0568301daa00b006eb8fc7c570mr421842oti.33.1714605707375;
        Wed, 01 May 2024 16:21:47 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id x11-20020a056830278b00b006ee4e216d02sm1128040otu.14.2024.05.01.16.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:21:47 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 2/6] qmi: gprs: Split out GET_DEFAULT_PROFILE_NUMBER request
Date: Wed,  1 May 2024 18:21:29 -0500
Message-ID: <20240501232144.14025-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501232144.14025-1-denkenz@gmail.com>
References: <20240501232144.14025-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow request to be re-arranged into a new sequence
easier in the future.
---
 drivers/qmimodem/gprs.c | 42 +++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index bca1897ea02f..dbd461731d94 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -101,7 +101,7 @@ static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 	DBG("");
 
 	if (qmi_result_set_error(result, &error)) {
-		ofono_error("Failed to query LTE attach params: %hd", error);
+		ofono_error("get_lte_attach_param_cb: %hd", error);
 		goto noapn;
 	}
 
@@ -275,7 +275,8 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 	l_free(cbd);
 }
 
-static void get_default_profile_cb(struct qmi_result *result, void *user_data)
+static void get_default_profile_number_cb(struct qmi_result *result,
+								void *user_data)
 {
 	static const uint8_t RESULT_DEFAULT_PROFILE_NUMBER = 0x1;
 	struct ofono_gprs *gprs = user_data;
@@ -312,9 +313,8 @@ error:
 	ofono_gprs_remove(gprs);
 }
 
-static void create_wds_cb(struct qmi_service *service, void *user_data)
+static int get_default_profile_number_request(struct ofono_gprs *gprs)
 {
-	struct ofono_gprs *gprs = user_data;
 	struct gprs_data *data = ofono_gprs_get_data(gprs);
 	struct {
 		uint8_t type;
@@ -323,7 +323,27 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 		.type = QMI_WDS_PROFILE_TYPE_3GPP,
 		.family = QMI_WDS_PROFILE_FAMILY_EMBEDDED,
 	};
-	struct qmi_param *param;
+	struct qmi_param *param = qmi_param_new();
+
+	/*
+	 * Query the default profile.  We never change the default profile
+	 * number, so querying it once should be sufficient
+	 */
+	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
+
+	if (qmi_service_send(data->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
+				param, get_default_profile_number_cb,
+				gprs, NULL) > 0)
+		return 0;
+
+	qmi_param_free(param);
+	return -EIO;
+}
+
+static void create_wds_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_gprs *gprs = user_data;
+	struct gprs_data *data = ofono_gprs_get_data(gprs);
 
 	DBG("");
 
@@ -334,18 +354,8 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 
 	data->wds = service;
 
-	/*
-	 * Query the default profile.  We never change the default profile
-	 * number, so querying it once should be sufficient
-	 */
-	param = qmi_param_new();
-	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
-
-	if (qmi_service_send(data->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
-				param, get_default_profile_cb, gprs, NULL) > 0)
+	if (get_default_profile_number_request(gprs) >= 0)
 		return;
-
-	qmi_param_free(param);
 error:
 	ofono_gprs_remove(gprs);
 }
-- 
2.44.0

