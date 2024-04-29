Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF5839E2
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406254; cv=none; b=tM47XZoBbWIGbe2x2S2ftfjjV8tZbd/W9xjPddCuQnn98mw145gVPP2TmBpm+u5pGrGkYMBUTE+YAe3fxPgiSUYqzVH/Zk93v+8+L2GmFJQKsrw1P8Ukk5BolRah5Cg5LEg8ZLftyf2iKDodUC3lobIicPaWwYcXDqG0wr44+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406254; c=relaxed/simple;
	bh=SG7JKdbsgWfF41n8Afado3R7t8hqIbP86hULAkO/L8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtztX+YuA+1JNtK78ng5vrWSQx3IP+rDe5y7vsb55HKhquzjv6N78lTnWGP87zUb+pzwu5sfNTWj9HYmP12dAODbslBesBUCxYWnkBWXhhn6AWovKwpH8WGYNMBGzYEfIxB/56ft3Dwb6ju0NDmXEm9z7mZJBrWpp5wAYXpZVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/VszFzQ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/VszFzQ"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c74ff209f6so3137204b6e.0
        for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714406251; x=1715011051; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8sQVwFw++QoqY5xReCkT4O/Wu5yRIv4jm9NSrIBntU=;
        b=A/VszFzQ44XbiGoxf6xxOerSTi7Rwiyfajof4tIogc9bdfkEm2+2bszf7OStKtmBBF
         C8OohsvCNrwxNIeVFYspaSFaFG7UQS/0QpshfUW694eHASVDg0VfEEirDXlg5vrpAxrY
         saLPy/GT86P6o8NqLS4JhcExQGSoaVYEF0cKHFPufiZZTSb6MV62TzvgqJ9Lq+zr0DZn
         5hK1YXsNb+bwUj0xObRBNyLiF2AbQF33kZc0/Nh6hdapj3UxIf1kWA62EQYMOPMu0fN9
         uF1zyYUDnpTY+gQtYnDlPb4Aq6p89nYPXjHVOmJhBd9ZJGXtRIy5ZthCXGu3f0PRPMtZ
         E3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406251; x=1715011051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8sQVwFw++QoqY5xReCkT4O/Wu5yRIv4jm9NSrIBntU=;
        b=EYPASPvTU98jW8vBb3ZpEAHAfQF7CK33CYCjJY0APbYOWAxtXlCLR2YxzaqC1j9G/F
         Fkk307/8k05KRfQdwoDzfRl1eY3i5rgN/NWJDJDaFab4vzzKlo0rKbth6os54pDV4y9x
         YlnlfT9QX6yj8u7vx5HWI332SOeC37E0fM6qOsBbZosykXpSE7o6Yhly5VxUdgDZ1tFP
         2pebc7cHDigzU3mmfS746pKMd7wTlhWjqJ/JwkWlEni9Kgln+AUvWT1GQ2WylQzNtQlb
         KDRVWiIIhOwRlnVLLVt/YLj9NkSvWx1mKI8rwl64ZbcphQ2BsGus6LayDR1fiHhvFXNJ
         R9mQ==
X-Gm-Message-State: AOJu0Yxkg5RyDTqeFUZFk/ku4VPdgfso/cq0Q5Ju3v+02oVP7ULgdmoI
	CruNOZRYh+Wisf4pM2mIKmP57pTMnA1cEUcwU0WC/S/reGQU5XSBOtIYLw==
X-Google-Smtp-Source: AGHT+IEV/Htn0VE8Upf0XF52oJJ+vqpA+5Ss7QH/xRzmbwkTDjU1/k48+A9cx4G8QXjuJkgsMyS7BQ==
X-Received: by 2002:a05:6808:3d2:b0:3c7:4547:31bf with SMTP id o18-20020a05680803d200b003c7454731bfmr11799771oie.32.1714406251537;
        Mon, 29 Apr 2024 08:57:31 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bf29-20020a056808191d00b003c7443c0efasm3117820oib.1.2024.04.29.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:57:30 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/6] qmi: gprs: Query default profile number at init
Date: Mon, 29 Apr 2024 10:56:56 -0500
Message-ID: <20240429155726.51479-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429155726.51479-1-denkenz@gmail.com>
References: <20240429155726.51479-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current logic queries the default profile id every time the driver
believes the default bearer has been attached.  However, oFono does not
modify the default profile number during its runtime.  Query the default
profile id at initialization time instead.

While here, remove some magic numbers in favor of defined constants.
---
 drivers/qmimodem/gprs.c | 136 ++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 75 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 72509d433bc6..738271905848 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -38,7 +38,7 @@ struct gprs_data {
 	struct qmi_device *dev;
 	struct qmi_service *nas;
 	struct qmi_service *wds;
-	unsigned int last_auto_context_id;
+	unsigned int default_profile;
 	uint16_t serving_system_indication_id;
 };
 
@@ -116,46 +116,12 @@ static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 	if (qmi_result_get_uint8(result, 0x11, &iptype))
 		ofono_info("LTE attach IP type: %hhd", iptype);
 
-	ofono_gprs_cid_activated(gprs, data->last_auto_context_id, apn);
+	ofono_gprs_cid_activated(gprs, data->default_profile, apn);
 	l_free(apn);
 
 	return;
 
 noapn:
-	data->last_auto_context_id = 0;
-	ofono_error("LTE bearer established but APN not set");
-}
-
-static void get_default_profile_cb(struct qmi_result *result, void *user_data)
-{
-	struct ofono_gprs* gprs = user_data;
-	struct gprs_data *data = ofono_gprs_get_data(gprs);
-	uint16_t error;
-	uint8_t index;
-
-	DBG("");
-
-	if (qmi_result_set_error(result, &error)) {
-		ofono_error("Get default profile error: %hd", error);
-		goto error;
-	}
-
-	/* Profile index */
-	if (!qmi_result_get_uint8(result, 0x01, &index)) {
-		ofono_error("Failed query default profile");
-		goto error;
-	}
-
-	DBG("Default profile index: %hhd", index);
-
-	data->last_auto_context_id = index;
-
-	if (qmi_service_send(data->wds, QMI_WDS_GET_LTE_ATTACH_PARAMETERS,
-				NULL, get_lte_attach_param_cb, gprs, NULL) > 0)
-		return;
-
-error:
-	data->last_auto_context_id = 0;
 	ofono_error("LTE bearer established but APN not set");
 }
 
@@ -167,41 +133,16 @@ error:
 static void get_lte_attach_params(struct ofono_gprs* gprs)
 {
 	struct gprs_data *data = ofono_gprs_get_data(gprs);
-	struct {
-		uint8_t type;
-		uint8_t family;
-	} __attribute((packed)) p = {
-		.type = 0,   /* 3GPP */
-		.family = 0, /* embedded */
-	};
-	struct qmi_param *param;
 
 	DBG("");
 
-	if (data->last_auto_context_id != 0)
-		return; /* Established or in progress */
-
-	/* Set query in progress */
-	data->last_auto_context_id = -1;
-
-	/* First we query the default profile in order to find out which
-	 * context the modem has activated.
-	 */
-	param = qmi_param_new();
-
-	/* Profile type */
-	qmi_param_append(param, 0x1, sizeof(p), &p);
-
-	if (qmi_service_send(data->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
-				param, get_default_profile_cb, gprs, NULL) > 0)
+	if (qmi_service_send(data->wds, QMI_WDS_GET_LTE_ATTACH_PARAMETERS,
+				NULL, get_lte_attach_param_cb, gprs, NULL) > 0)
 		return;
-
-	qmi_param_free(param);
 }
 
 static int handle_ss_info(struct qmi_result *result, struct ofono_gprs *gprs)
 {
-	struct gprs_data *data = ofono_gprs_get_data(gprs);
 	int status;
 	int tech;
 	int bearer_tech;
@@ -222,8 +163,6 @@ static int handle_ss_info(struct qmi_result *result, struct ofono_gprs *gprs)
 			 */
 			get_lte_attach_params(gprs);
 		}
-	} else {
-		data->last_auto_context_id = 0;
 	}
 
 	/* DC is optional so only notify on successful extraction */
@@ -337,20 +276,29 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 	l_free(cbd);
 }
 
-static void create_wds_cb(struct qmi_service *service, void *user_data)
+static void get_default_profile_cb(struct qmi_result *result, void *user_data)
 {
+	static const uint8_t RESULT_DEFAULT_PROFILE_NUMBER = 0x1;
 	struct ofono_gprs *gprs = user_data;
 	struct gprs_data *data = ofono_gprs_get_data(gprs);
+	uint16_t error;
+	uint8_t index;
 
-	DBG("");
+	if (qmi_result_set_error(result, &error)) {
+		ofono_error("Get default profile error: %hd", error);
+		goto error;
+	}
 
-	if (!service) {
-		ofono_error("Failed to request WDS service");
-		ofono_gprs_remove(gprs);
-		return;
+	/* Profile index */
+	if (!qmi_result_get_uint8(result, RESULT_DEFAULT_PROFILE_NUMBER,
+								&index)) {
+		ofono_error("Failed query default profile");
+		goto error;
 	}
 
-	data->wds = service;
+	DBG("Default profile index: %hhd", index);
+	data->default_profile = index;
+	ofono_gprs_set_cid_range(gprs, index, index);
 
 	/*
 	 * First get the SS info - the modem may already be connected,
@@ -358,15 +306,53 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 	 */
 	qmi_service_send(data->nas, QMI_NAS_GET_SERVING_SYSTEM, NULL,
 					ss_info_notify, gprs, NULL);
-
 	data->serving_system_indication_id =
 		qmi_service_register(data->nas,
 					QMI_NAS_SERVING_SYSTEM_INDICATION,
 					ss_info_notify, gprs, NULL);
 
-	ofono_gprs_set_cid_range(gprs, 1, 1);
-
 	ofono_gprs_register(gprs);
+	return;
+error:
+	ofono_gprs_remove(gprs);
+}
+
+static void create_wds_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_gprs *gprs = user_data;
+	struct gprs_data *data = ofono_gprs_get_data(gprs);
+	struct {
+		uint8_t type;
+		uint8_t family;
+	} __attribute((packed)) p = {
+		.type = QMI_WDS_PROFILE_TYPE_3GPP,
+		.family = QMI_WDS_PROFILE_FAMILY_EMBEDDED,
+	};
+	struct qmi_param *param;
+
+	DBG("");
+
+	if (!service) {
+		ofono_error("Failed to request WDS service");
+		goto error;
+	}
+
+	data->wds = service;
+
+	/*
+	 * Query the default profile.  We never change the default profile
+	 * number, so querying it once should be sufficient
+	 */
+	param = qmi_param_new();
+	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
+
+	if (qmi_service_send(data->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
+				param, get_default_profile_cb, gprs, NULL) > 0)
+		return;
+
+	qmi_param_free(param);
+error:
+	ofono_gprs_remove(gprs);
 }
 
 static void create_nas_cb(struct qmi_service *service, void *user_data)
-- 
2.44.0

