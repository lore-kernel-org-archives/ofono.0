Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C31474CC
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314913; cv=none; b=JSiWGdDxlzIHUbHkFw3nRhzIjqLEIrogZcLZYQSAUSaZngW/xLzlkVvdJhoirn+grMy8tJX8kCrprrPnaZVsGqmD3adu0QUQJoxxy2mhXvVN27FppcZxiZrHAAzYS0XIDUEYhlB0YT8xO6M+CHuQXRZJ1o8GecSLg6lYvoaa7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314913; c=relaxed/simple;
	bh=erhE26Tah8EhqtMcTdHywPBO4QQKdsUhXl/3VPciB1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tve5NaB/yzpXCz96uqQ7xuWftPYWGC2ianyyWXg2cm3QXbAi+iZ5tsizs3a/VUwXig5Dq/PZOZ6d3fYq2YMCk7f/SFFIozCX1dQ4ol7KOtdktml3Klglpuh/4InVXbd36LnTtleT07tKepzgdmZdS6IQI0n0AyiJ1JIA5TcdqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbhTTitO; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbhTTitO"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f97a4c4588so865812a34.2
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314911; x=1718919711; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6doADjhR3/6vf/kwwBjBRt4gMtz7KBOLEestHrhR/BU=;
        b=MbhTTitORxam/4XK0snAUI/kmea2YVsVU74ATixEZy5MPVv66Ga21m4xWA+rTAunu1
         5qc15uAo9CAIFdPjo4g2bxfBwEI0/Qwqg5qEmFo9Om6EQqPJUYOGDMpB1scmt/99VWPj
         BrwF/fboVSTRfgcQ2E1ZKdc1A4ifLL1Mj9N/8p4XnCILc7BX+1nwBtuLLYm5zcdBNgpf
         zUbuPv/acSDgr1DrFXRwUjcHd6XxsDyF1ABsRbt1K/Moboe23Ebk4Uu10Ty/p9IODLi8
         B2Ob8SV05CJLsCbV929S2rna8c3SffyYk/PBm2hEEUccqzLHFCEoS57Hevy3PoQAW74o
         CQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314911; x=1718919711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6doADjhR3/6vf/kwwBjBRt4gMtz7KBOLEestHrhR/BU=;
        b=KqU7zZDBmPWrZwUyZsj2IicKppj7Lsc44RHzn4IcjIzk+WNs355WgXnHUI61X00iEH
         OQ2TppiVnr+29TDa/5928atncLYDZeNtb0/kb9xnGhSPe+s2E/SK44oMhGvJ5MjCLBhO
         ikWywSOivbYHB3PwwhADMnH07oI0y7B8yx50vdcaj8ggpHBfwrni18puzPvzDTLuUJ/N
         vUr4FPBnxomqpvlwxpwYFhzivWVNqAMcSsGTDx7jsiiZLhR0sO1A1bsUDsCCyZVIjBCO
         q5w9Dq1oK+JNesHL5zP3F2I2xnVMGN2duCnNVrU3MzXBIa2mNNvAfSdLXL4esSUSRgun
         /2PA==
X-Gm-Message-State: AOJu0YzzmuoJvL841Fa3TpN3waJcU/qErhQ3CX3OkWapdzSWZXpileSf
	uz8wHXBNS8qoNFBOKX1c/8rcFip0WuodxYYtvw0XrGUJqgkFVK2JtXME6Q==
X-Google-Smtp-Source: AGHT+IHjrC7BiZm/Ur6LX0yjpXksiWz3VKyW2iV6nie8OCncW/21hQ9A68pVZoxFQpM6EEoGd10LvA==
X-Received: by 2002:a05:6870:f145:b0:24f:d9bd:2754 with SMTP id 586e51a60fabf-25842af0687mr926689fac.40.1718314910987;
        Thu, 13 Jun 2024 14:41:50 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:50 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 21/23] qmi: sim: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:30 -0500
Message-ID: <20240613214134.1056517-21-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613214134.1056517-1-denkenz@gmail.com>
References: <20240613214134.1056517-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use qmi_device_get_service and qmi_device_add_service_watch
---
 drivers/qmimodem/sim.c | 96 +++++++++---------------------------------
 plugins/gobi.c         |  4 +-
 2 files changed, 23 insertions(+), 77 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 67925239f2b5..876274fa87b4 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -44,14 +44,12 @@ struct sim_status {
 };
 
 struct sim_data {
-	struct qmi_device *qmi_dev;
 	struct qmi_service *dms;
 	struct qmi_service *uim;
 	uint32_t event_mask;
 	uint8_t app_type;
 	uint32_t retry_count;
 	struct l_timeout *retry_timer;
-	uint16_t card_status_indication_id;
 };
 
 static int create_fileid_data(uint8_t app_type, int fileid,
@@ -827,9 +825,7 @@ static void event_registration_cb(struct qmi_result *result, void *user_data)
 	DBG("event mask 0x%04x", data->event_mask);
 
 	if (data->event_mask & 0x0001) {
-		data->card_status_indication_id =
-			qmi_service_register(data->uim,
-						QMI_UIM_GET_CARD_STATUS_EVENT,
+		qmi_service_register(data->uim, QMI_UIM_GET_CARD_STATUS_EVENT,
 						card_status_notify, sim, NULL);
 	}
 
@@ -841,68 +837,32 @@ error:
 	ofono_sim_remove(sim);
 }
 
-static void create_uim_cb(struct qmi_service *service, void *user_data)
+static int qmi_sim_probev(struct ofono_sim *sim,
+				unsigned int vendor, va_list args)
 {
-	struct ofono_sim *sim = user_data;
-	struct sim_data *data = ofono_sim_get_data(sim);
-	struct qmi_param *param;
-	uint32_t mask = 0x0003;
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request UIM service");
-		goto error;
-	}
-
-	data->uim = service;
-
-	param = qmi_param_new_uint32(QMI_UIM_PARAM_EVENT_MASK, mask);
-
-	if (qmi_service_send(data->uim, QMI_UIM_EVENT_REGISTRATION, param,
-					event_registration_cb, sim, NULL) > 0)
-		return;
-
-error:
-	ofono_sim_remove(sim);
-}
-
-static void create_dms_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_sim *sim = user_data;
-	struct sim_data *data = ofono_sim_get_data(sim);
+	struct qmi_service *dms = va_arg(args, struct qmi_service *);
+	struct qmi_service *uim = va_arg(args, struct qmi_service *);
+	static const uint32_t mask = 0x0003;
+	struct qmi_param *param =
+		qmi_param_new_uint32(QMI_UIM_PARAM_EVENT_MASK, mask);
+	struct sim_data *data;
 
 	DBG("");
 
-	if (!service) {
-		ofono_error("Failed to request DMS service");
-		ofono_sim_remove(sim);
-		return;
+	if (!qmi_service_send(uim, QMI_UIM_EVENT_REGISTRATION, param,
+					event_registration_cb, sim, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(dms);
+		qmi_service_free(uim);
+		return -EIO;
 	}
 
-	data->dms = service;
-
-	qmi_service_create_shared(data->qmi_dev, QMI_SERVICE_UIM, create_uim_cb,
-					sim, NULL);
-}
-
-static int qmi_sim_probe(struct ofono_sim *sim,
-				unsigned int vendor, void *user_data)
-{
-	struct qmi_device *device = user_data;
-	struct sim_data *data;
-
-	DBG("");
-
 	data = l_new(struct sim_data, 1);
-
-	data->qmi_dev = device;
+	data->uim = uim;
+	data->dms = dms;
 
 	ofono_sim_set_data(sim, data);
 
-	qmi_service_create_shared(device, QMI_SERVICE_DMS,
-						create_dms_cb, sim, NULL);
-
 	return 0;
 }
 
@@ -915,29 +875,13 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 	ofono_sim_set_data(sim, NULL);
 
 	l_timeout_remove(data->retry_timer);
-	data->retry_timer = NULL;
-
-	if (data->uim) {
-		if (data->card_status_indication_id) {
-			qmi_service_unregister(data->uim,
-					data->card_status_indication_id);
-			data->card_status_indication_id = 0;
-		}
-
-		qmi_service_free(data->uim);
-		data->uim = NULL;
-	}
-
-	if (data->dms) {
-		qmi_service_free(data->dms);
-		data->dms = NULL;
-	}
-
+	qmi_service_free(data->uim);
+	qmi_service_free(data->dms);
 	l_free(data);
 }
 
 static const struct ofono_sim_driver driver = {
-	.probe			= qmi_sim_probe,
+	.probev			= qmi_sim_probev,
 	.remove			= qmi_sim_remove,
 	.read_file_info		= qmi_read_attributes,
 	.read_file_transparent	= qmi_read_transparent,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 65629e92ba09..7ded86c52b96 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -716,7 +716,9 @@ static void gobi_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "qmimodem", qmi_service_clone(data->dms));
 
 	if ((data->features & GOBI_UIM) && !legacy)
-		ofono_sim_create(modem, 0, "qmimodem", data->device);
+		ofono_sim_create(modem, 0, "qmimodem",
+						qmi_service_clone(data->dms),
+						qmi_service_clone(data->uim));
 	else /* DMS always available */
 		ofono_sim_create(modem, 0, "qmimodem_legacy",
 						qmi_service_clone(data->dms));
-- 
2.45.0

