Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762F16DC3C
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740972; cv=none; b=UCtISohupfHXL+ai9Xp/Zd9/rvkRDBu9/MHPjteSMENrQX5PWSjS7Q0zzjQsxbOEaCj9r0slkAWNsJGeXW929CleFPWU5vKAVGeuJTN3Iex/gDUPkQ269bzA0rLkuOyaJ9J8l+d/D+CeiK5F5z8dpkajyqTw/R1Suup3i12xJqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740972; c=relaxed/simple;
	bh=6dq4bavJ1om0VXsee4PAdABfdZL7XD9OlXZuhL+HQCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOSKnT9oD/OYndVlgNeMlW3h6oB80mrSGK2HPQY4z9WPeJHhs1s1cNt6ISeECLaLJwXJZCb6wJHNnwWZyQ0E/Dwxf2CF/KR58RBHJgwLcPoWtcFHUuSLhnYBrLKjXftj8j5BZxDKjR938zBdp38/Sr26vKDrH3otjDbA02++YTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bea6tAiJ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bea6tAiJ"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2550aa6f994so3592103fac.3
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740970; x=1719345770; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIsgHn3lNx3+Rn+eb9tzPvQN8z07VPYftJj2ND4AnLA=;
        b=Bea6tAiJWqPFWp8/I3P2haSYyDWuhYipBNOs2AZRKZ9PfyS7BR1PCmSA/2NSEylXtB
         JxA8KnMzJ+7V71/sDzXpUiuCZa//vK/wxJnWKhoNMOQTmp2VFHyEiDNfse2FrP3sKXTp
         iepop7FO2J+UzoyHN2GLV/6I0YR9jSoOpkpqdiDnU+sV4TRvnYXMLtEeiuXQlGYzhA1E
         NqTOrc0oFZXQPMQimCwIGLq4jaPP6zk8UKZmc1UM8h04AEczW+nXO9HxeMrhuJjY0cn8
         ZoHiyBbFveYHLKNdHwC/B5JIbRdB0D+2xhtXWNRKYA019f9VHBqpCKc1DUcVqwSoZtcn
         ikqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740970; x=1719345770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIsgHn3lNx3+Rn+eb9tzPvQN8z07VPYftJj2ND4AnLA=;
        b=feKJ8RmHAR6sppxAll+w7oHXVHBapyfJ21HflTdWad6edTZmMXm23mXXrYe/WNxo12
         j2tDlvKveXjwr95tl4qHUOEdWagq2Dslnj9cNepVsBBOqeq6RlK1UaJpun4YNBBSK2MF
         t7u+ax3btEcHvpdQIXHv8gt8NPhyiBXyJVSWLT0xqqT3HRtjPUjk7LsdZys0fBBZEuMJ
         p4GM5sJywPYTj+J4ghWfJi2YBqegRKW1jUdfEekl3zqpxePrEnf/w+DcXTtSuOYEee1F
         yMtp47d8stFVjirsG1obkSNWFKMrrOFLlRt6NS+Cv7x5B1m4exaEzcQ6EYVzhMF1yKmU
         e3bQ==
X-Gm-Message-State: AOJu0YyWM1D/uIdgeBKAI5W0SJrD/ryZcnUwDDOLsnISpUR3lsCZjkft
	dyEvObAPCjtrXKbvXn9C4aCY1Zw+6Pf++nDvSaFJH4jnxsLPxXqK262ocQ==
X-Google-Smtp-Source: AGHT+IFYhesGJsVyh658OoruQJGWym1Shh0EkcX0skvPthAO14xVA2JHjJnVArR+up5AIS9urH+RAA==
X-Received: by 2002:a05:6870:5247:b0:254:adee:216a with SMTP id 586e51a60fabf-25c94dfe3d4mr1000105fac.41.1718740970289;
        Tue, 18 Jun 2024 13:02:50 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 21/33] qmi: split qmi_device_has_service into QRTR and QMUX version
Date: Tue, 18 Jun 2024 15:02:03 -0500
Message-ID: <20240618200231.1129282-21-denkenz@gmail.com>
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

---
 drivers/qmimodem/qmi.c | 13 ++++++++++++-
 drivers/qmimodem/qmi.h |  4 ++--
 plugins/gobi.c         | 14 +++++++-------
 plugins/qrtrqmi.c      | 10 +++++-----
 4 files changed, 26 insertions(+), 15 deletions(-)

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
index 3ab2efc39186..d37829204464 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -446,19 +446,19 @@ static void discover_cb(void *user_data)
 
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
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_VOICE))
 			data->features |= GOBI_VOICE;
 
 	if (qmi_qmux_device_get_service_version(data->device, QMI_SERVICE_WMS,
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 31c02b1cd981..745cfd760029 100644
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

