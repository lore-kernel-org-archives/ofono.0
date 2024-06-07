Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23615572E
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800488; cv=none; b=BFirtI95hvP1jzd1eSAHKD6DXtj5MfEKAh0+n1EvlBtT0GE7rONu5bEWyG5xGNOgXkyUpSOGiE/1gZh9mzmKulhwSiuiXEc6UOCirAeJOnU18k6sIgakaLAz7swS0zIikhr2T1ha0mCH6/xLbTUA3BydwrSroX1QpijIlV6zubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800488; c=relaxed/simple;
	bh=s0IvtF+LWC0iH0uuzhoie5XKTJ2+1EXgXGJtRacn60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKcDqtXFASYo7upl6tIaB28DQZI4jEsyw0GgpGpW6EtkSmeEUKgbHvCa5XWmrQWP6s/0rMMrfLEW1QjVQw6rEIztDncNT3U5pFbv0O47p9kN2QFOv9k5ZE4r+Z4lIt+47YVy3WgKyJCFH6FzQnXkR0Jm7abdKDHCQmjo/Ub8hf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arad2801; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arad2801"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2ed25b337so1455887eaf.0
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800486; x=1718405286; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlWXLrumlNL/wJBuQP2B4HVw9eIJiZQj7NOcoPGpK0s=;
        b=arad2801aPo8dYhTZxQGf00F1VDdiWjPJ2/HIXu41ngLvVlHmMpVAKjNwP30elgLQO
         kkj8R9mAui3dyaOD4MNobNVQWrSoCinzV99FF9F3/CozdRSWzVEADKXyTG3mXmESEZWo
         3jL664GkwAeUWNwqb7NtdsFbmBlz0OZ+D90wUS/w2VXAT/Gk5nfvTiFoe8/sxzjw13TQ
         ryh7PhXV39M+VXqP7tOm/9qpVl9SKv/1QT1JR3kB12XU/Gxb5bV1tgVqVha6QaiLWCSZ
         SiYl59iF2n23D+gjY+9C1/gfWCmBl2h53cGQqDwVM4Md2bOJnRqL5lSv6wM/zqaqokn4
         QoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800486; x=1718405286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlWXLrumlNL/wJBuQP2B4HVw9eIJiZQj7NOcoPGpK0s=;
        b=R8qGbXeMg2wwF87l3N+4KQOa55fPMnBEnelzny62HN4deY2j015YgGGsxcfzpZxBZ2
         jq0bTV70MKvPGEj1wzd1uPojqXYafl7A93b1s09pc9z1ttkZeBN7vUGhk/w0IVzLhPfd
         lecJwZ8hV5A9JTAfVeKmrD20HL7LKGQvpRJmv6OWy0yUkoWzMjSiJ9SBLauRYet27G1p
         wG2XqhUKi2K/ogIJu5CC++HguRgBtaJ/xeYNfUrS0w6Rb4Fz67yEY0AzWTkQSHxM3anb
         IUbKWrmE08qnX+WRsh8ksWl2ROv8U8f2FTn2AzFnhWEE+vQDEcsOmAE6VCgVt4ZGIFtG
         wbpw==
X-Gm-Message-State: AOJu0Yz/FYK+mxIDGqvZMSdI0U6jB6VuqxI6F+1pfdhzgVA3fVOAHaSu
	PY5VoIR749obx9LgPnrrO4WbWUVoTf3V9JyQ5aTMYD41ljviyMm1NMZE7A==
X-Google-Smtp-Source: AGHT+IExf/au42wLm89oyGns/Rg9i+IGwoiIzfgGAG9pDY3lQ67wgk5r505Vwy0cjR2erm3qWtdgdQ==
X-Received: by 2002:a05:6820:1689:b0:5b9:8a06:c49 with SMTP id 006d021491bc7-5baae50a4afmr4188275eaf.2.1717800486206;
        Fri, 07 Jun 2024 15:48:06 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:48:05 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 22/23] qmi: gprs: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:22 -0500
Message-ID: <20240607224746.903769-22-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240607224746.903769-1-denkenz@gmail.com>
References: <20240607224746.903769-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/gprs.c | 85 +++++++++--------------------------------
 plugins/gobi.c          |  4 +-
 2 files changed, 22 insertions(+), 67 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 03ee377e8916..da7ad63c49cb 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -21,7 +21,6 @@
 #include "util.h"
 
 struct gprs_data {
-	struct qmi_device *dev;
 	struct qmi_service *nas;
 	struct qmi_service *wds;
 	unsigned int default_profile;
@@ -405,9 +404,12 @@ error:
 	ofono_gprs_remove(gprs);
 }
 
-static int get_default_profile_number_request(struct ofono_gprs *gprs)
+static int qmi_gprs_probev(struct ofono_gprs *gprs,
+				unsigned int vendor, va_list args)
 {
-	struct gprs_data *data = ofono_gprs_get_data(gprs);
+	struct qmi_service *wds = va_arg(args, struct qmi_service *);
+	struct qmi_service *nas = va_arg(args, struct qmi_service *);
+	struct gprs_data *data;
 	struct {
 		uint8_t type;
 		uint8_t family;
@@ -423,77 +425,29 @@ static int get_default_profile_number_request(struct ofono_gprs *gprs)
 	 */
 	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
 
-	if (qmi_service_send(data->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
+	if (!qmi_service_send(wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
 				param, get_default_profile_number_cb,
-				gprs, NULL) > 0)
-		return 0;
-
-	qmi_param_free(param);
-	return -EIO;
-}
-
-static void create_wds_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_gprs *gprs = user_data;
-	struct gprs_data *data = ofono_gprs_get_data(gprs);
+				gprs, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(nas);
+		qmi_service_free(wds);
 
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request WDS service");
-		goto error;
+		return -EIO;
 	}
 
-	data->wds = service;
-	qmi_service_register(data->wds, QMI_WDS_EVENT_REPORT,
-				event_report_notify, gprs, NULL);
-	qmi_service_register(data->wds, QMI_WDS_PROFILE_CHANGED,
-				profile_changed_notify, gprs, NULL);
-
-	if (get_default_profile_number_request(gprs) >= 0)
-		return;
-error:
-	ofono_gprs_remove(gprs);
-}
-
-static void create_nas_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_gprs *gprs = user_data;
-	struct gprs_data *data = ofono_gprs_get_data(gprs);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request NAS service");
-		ofono_gprs_remove(gprs);
-		return;
-	}
+	data = l_new(struct gprs_data, 1);
+	data->wds = wds;
+	data->nas = nas;
 
-	data->nas = service;
 	qmi_service_register(data->nas, QMI_NAS_SERVING_SYSTEM_INDICATION,
 					ss_info_notify, gprs, NULL);
-
-	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS,
-						create_wds_cb, gprs, NULL);
-}
-
-static int qmi_gprs_probe(struct ofono_gprs *gprs,
-				unsigned int vendor, void *user_data)
-{
-	struct qmi_device *device = user_data;
-	struct gprs_data *data;
-
-	DBG("");
-
-	data = l_new(struct gprs_data, 1);
+	qmi_service_register(data->wds, QMI_WDS_EVENT_REPORT,
+					event_report_notify, gprs, NULL);
+	qmi_service_register(data->wds, QMI_WDS_PROFILE_CHANGED,
+					profile_changed_notify, gprs, NULL);
 
 	ofono_gprs_set_data(gprs, data);
 
-	data->dev = device;
-
-	qmi_service_create_shared(device, QMI_SERVICE_NAS,
-						create_nas_cb, gprs, NULL);
-
 	return 0;
 }
 
@@ -507,12 +461,11 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 
 	qmi_service_free(data->wds);
 	qmi_service_free(data->nas);
-
 	l_free(data);
 }
 
 static const struct ofono_gprs_driver driver = {
-	.probe			= qmi_gprs_probe,
+	.probev			= qmi_gprs_probev,
 	.remove			= qmi_gprs_remove,
 	.set_attached		= qmi_set_attached,
 	.attached_status	= qmi_attached_status,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index d32fb9d75585..b7a8240edd3c 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -753,7 +753,9 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 	char buf[256];
 	int i;
 
-	gprs = ofono_gprs_create(modem, 0, "qmimodem", data->device);
+	gprs = ofono_gprs_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->wds),
+					qmi_service_clone(data->nas));
 	if (!gprs) {
 		ofono_warn("Unable to create gprs for: %s",
 					ofono_modem_get_path(modem));
-- 
2.45.0

