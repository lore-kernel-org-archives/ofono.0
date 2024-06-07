Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012CF155728
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800477; cv=none; b=BfxYieswtQ7J2rUJanp77sUgD5NT0n32EjcrtskeVY191d3Nam6wZ03IkiQtCp0K1ELWjrrbOuXg8Xcezj8/Wx1BXkfyFBIa1CzmQOPM026mXtZgBPtM5ZvqEG0m2dLireBXTG/1K0cLJUZ2DpXdRzeWVjdhaoqyIhd53nB/jZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800477; c=relaxed/simple;
	bh=LkEYvIxUBeEOfdy3LB8JcaPHvOWbC1NDSEXrtCwdm20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c25EHj1TxOag8JwJwqHgdw9FMQMPWLcOOnJWUdZc6EdJvCMIQ0wtcg9tCkzo2SiASw4ciDZ1dj+P8xTkeQ9sqOw+YSR2UvtReJlPTbFan2IC3NjokRKKt3IcafzflXkw9AmY1KQsd6SIwMRtotU0Q+VZo+S4fk0vnfiKA30YXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELo+T6xa; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELo+T6xa"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b97a071c92so1366661eaf.1
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800475; x=1718405275; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAu7nA5L3aL3vM9wjwUJEqCl+QRPuPlG8/beHgKZnGo=;
        b=ELo+T6xaS1ZRLfVxPXjk3kD3pah9ltaoIylUT1TwTLaDj6c+Kr3H6YeGF5jvunu86p
         C16DmMA52SwD79vbxh23flNPNZyHyWgEp+eUvqdST3aK36QkY3/Ita3YGKUekNlzPeXL
         LXW+fBPueMaqgifl0vulQn/xSrPCfjvr/wLl98ksXvygiJHJddMoWOnVTWyoalOWs0bS
         +TmmTi4+RAq4Ur7x94sV/PzOn1hPaxUxL7a5CRvccxJ4gEbVhUzTiePiHAOHbIuT0Qxu
         iE4vGtHOFqNhQ2njkJekZuUEzdyYqU6UIYqIZe1kvzPY5y0HPH3CMNi/4MxpGnpzQUEc
         leow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800475; x=1718405275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAu7nA5L3aL3vM9wjwUJEqCl+QRPuPlG8/beHgKZnGo=;
        b=b/M5eZfzXk+4FQ5KB+gsALaGa0lX9El08nxKAZ7XwF+hyjjUnXIIJCHe0f6lrJf1BR
         L8YuF5TMYXICmOPzlnaZrS775OCRz3+xn+YB7qqwgp6ssvSfzCV64KFQbC+i+PLnEOKu
         IKWI2+QP+hlaFnvPJ1yRC8tBbprecQN9CPgxDZZbC+pW5nyp5IzJSXsDZ63vPaiKlTWm
         A5nark6p5KzKwk1WEcTZ1rTGUvn2N8PSoxM7rXjou4QBrLoZr7ev1obRAOTKU08+327c
         LVc3g3tuKUKvMVZo+pRegjh7/s8f/EIyPC0I2UsgnOsnmKncq0S3D4NuweeOBF3XWS4t
         EY1w==
X-Gm-Message-State: AOJu0YwdFQ3c+ka/2LmC+Fc8uJSuDn9HrznqP8bArTCnrOl319e44PJG
	3JEOBozm44pc2KKskC1Zl3XpY5rBm2Lkdf796E9zWgb80mup86kbQiiNBQ==
X-Google-Smtp-Source: AGHT+IEc2aLX4PsqVqSSd8RvJPqC8rUwDqyb4GBFXZVH3UF5X7ZEMEgo/0Khnb4yTvUDkKwNe3Er0g==
X-Received: by 2002:a05:6820:823:b0:5b9:f440:169d with SMTP id 006d021491bc7-5baae5457c2mr4438938eaf.3.1717800475116;
        Fri, 07 Jun 2024 15:47:55 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:54 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/23] qmi: sim-legacy: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:09 -0500
Message-ID: <20240607224746.903769-9-denkenz@gmail.com>
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

While here, also drop tracking of indication registration.  This is not
needed as qmi_service_free will automatically unregister from all
indications for the cloned handle.
---
 drivers/qmimodem/sim-legacy.c | 57 +++++++++--------------------------
 plugins/gobi.c                | 17 ++++-------
 2 files changed, 20 insertions(+), 54 deletions(-)

diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index aeea5fae22f3..1feaf86976c6 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -27,7 +27,6 @@
 struct sim_data {
 	struct qmi_service *dms;
 	int retries[OFONO_SIM_PASSWORD_INVALID];
-	uint16_t event_indication_id;
 };
 
 static void qmi_read_file_info(struct ofono_sim *sim, int fileid,
@@ -295,59 +294,37 @@ done:
 	ofono_sim_register(sim);
 }
 
-static void create_dms_cb(struct qmi_service *service, void *user_data)
+static int qmi_sim_probe(struct ofono_sim *sim,
+				unsigned int vendor, void *user_data)
 {
-	struct ofono_sim *sim = user_data;
-	struct sim_data *data = ofono_sim_get_data(sim);
+	struct qmi_service *dms = user_data;
 	struct qmi_param *param;
+	struct sim_data *data;
+	int i;
 
 	DBG("");
 
-	if (!service) {
-		ofono_error("Failed to request DMS service");
-		ofono_sim_remove(sim);
-		return;
-	}
-
-	data->dms = service;
-
-	data->event_indication_id =
-		qmi_service_register(data->dms, QMI_DMS_EVENT,
-					event_notify, sim, NULL);
-
 	param = qmi_param_new();
-
 	qmi_param_append_uint8(param, QMI_DMS_PARAM_REPORT_PIN_STATUS, 0x01);
 	qmi_param_append_uint8(param, QMI_DMS_PARAM_REPORT_OPER_MODE, 0x01);
 	qmi_param_append_uint8(param, QMI_DMS_PARAM_REPORT_UIM_STATE, 0x01);
 
-	if (qmi_service_send(data->dms, QMI_DMS_SET_EVENT, param,
-					set_event_cb, sim, NULL) > 0)
-		return;
-
-	qmi_param_free(param);
-
-	ofono_sim_register(sim);
-}
-
-static int qmi_sim_probe(struct ofono_sim *sim,
-				unsigned int vendor, void *user_data)
-{
-	struct qmi_device *device = user_data;
-	struct sim_data *data;
-	int i;
-
-	DBG("");
+	if (!qmi_service_send(dms, QMI_DMS_SET_EVENT, param,
+					set_event_cb, sim, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(dms);
+		return -EIO;
+	}
 
 	data = l_new(struct sim_data, 1);
+	data->dms = dms;
 
 	for (i = 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
 		data->retries[i] = -1;
 
-	ofono_sim_set_data(sim, data);
+	qmi_service_register(dms, QMI_DMS_EVENT, event_notify, sim, NULL);
 
-	qmi_service_create_shared(device, QMI_SERVICE_DMS,
-						create_dms_cb, sim, NULL);
+	ofono_sim_set_data(sim, data);
 
 	return 0;
 }
@@ -360,13 +337,7 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 
 	ofono_sim_set_data(sim, NULL);
 
-	if (data->event_indication_id) {
-		qmi_service_unregister(data->dms, data->event_indication_id);
-		data->event_indication_id = 0;
-	}
-
 	qmi_service_free(data->dms);
-
 	l_free(data);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 1a31e7a2b17d..b0f5896808fa 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -721,22 +721,17 @@ static void gobi_set_online(struct ofono_modem *modem, ofono_bool_t online,
 static void gobi_pre_sim(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
-	const char *sim_driver = NULL;
+	bool legacy = ofono_modem_get_boolean(modem, "ForceSimLegacy");
 
 	DBG("%p", modem);
 
 	ofono_devinfo_create(modem, 0, "qmimodem", qmi_service_clone(data->dms));
 
-	if (data->features & GOBI_UIM)
-		sim_driver = "qmimodem";
-	else if (data->features & GOBI_DMS)
-		sim_driver = "qmimodem_legacy";
-
-	if (ofono_modem_get_boolean(modem, "ForceSimLegacy"))
-		sim_driver = "qmimodem_legacy";
-
-	if (sim_driver)
-		ofono_sim_create(modem, 0, sim_driver, data->device);
+	if ((data->features & GOBI_UIM) && !legacy)
+		ofono_sim_create(modem, 0, "qmimodem", data->device);
+	else /* DMS always availalable */
+		ofono_sim_create(modem, 0, "qmimodem_legacy",
+						qmi_service_clone(data->dms));
 
 	if (data->features & GOBI_VOICE)
 		ofono_voicecall_create(modem, 0, "qmimodem", data->device);
-- 
2.45.0

