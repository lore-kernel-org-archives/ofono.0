Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F81613FD66
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314904; cv=none; b=bC0rIGh1KwObSy3wYmgtiiBXViST+5tgdBuXyS/cFNYFFTWepNRVn2Dlc7Q35x/Jct6i9FCBqBbCy7KNdAcauKO9FWFEmp4ktzd0X6fvPvn/a8NTwNeTUsmjBXbjCcy8VZU2jFg90V1/gewQYG+jJvi4IGv8mx1gKY8jLB3oMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314904; c=relaxed/simple;
	bh=GAYy0hgVQuau0DVTOTluTy4cwDO1RwIEZz9a3hkOAyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J40kXzLRa1zlBULoG/Uhf0759ZZbhCG1R3ShVwy/jA8rcvX+3C1HiIsk+NvcxHXXyF/6TGff6/eAVJ95mkYwNCeS9b+pmWL7vUENQqVyfwoBntVV7k4eQkcF+k+qwaGEcn6r+OOWQBcUiDXXZPymvVxZgxHsAfnbfW+tNiH3eQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DadHNcdk; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DadHNcdk"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d229baccc4so785162b6e.1
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314902; x=1718919702; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3XD2rV2E6vwHXtFUIJfSGiwX6p4QMJKAlkCKhxbipM=;
        b=DadHNcdkZegcx7LZGCgF9VjP66oh8Iwcg2mHgDvoINmT+ASPgnaunigVcr27LuP4bO
         82ss1R0+zMcd1zgP2fP4N59WVaBpOwQXb6/onoD3UJ05Lw2demojz0/KQmk3f+ZVxCpW
         ACfrAZb17deVfyFnMUAIRQrachfJh19pRVkCAf8tTXWOG+4ymkl+BK/NaUDjhhkpsSIR
         JH5JDtsPHtUeJUzWtuKY3dUsW3IlR/lUxjKC7xxY7lDm//OAevx0Dd0qpC4bPVkoDkTx
         MyFNhgdIwxUiuFgafBCBrUOPQvWi8eKYcdUtiGrGRCQ1PL4LQG1ua7RrLuHpQba1OWsc
         4L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314902; x=1718919702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3XD2rV2E6vwHXtFUIJfSGiwX6p4QMJKAlkCKhxbipM=;
        b=xBgXbbOn01alRDYmBv2aiHkbO2jA0K28PAS0QmPlrbVpXlXRwgUx7C60TwH0Q6SDJW
         SyamruXWizdS3vPsIhkYl6x6atvI+4oOEUzVaC2LIc7caHfV3GVSIQKN+bfbbASB+Hrm
         jzReCnfsiUOmwNGsGd0cIBg6eEix1Yj905M+r5GgOxpRUMNhA91xQ5KHje5ojcNeMLrB
         0dlDcz6qiMUD3dAa6DV99y+0xNpjUlpIOPg7pKLht1u84098b5vp926V2jttNGl91UPq
         fH/esxVjKjepKKZ2ZOfCZTdaKwRtoynaWbnuH4ZtZjOb0ownK4ct2klFTX2UX8pYbDB9
         YPfw==
X-Gm-Message-State: AOJu0YzHTEeRNR9afC2csx1fUjNldhiwmniiAdzcr5kq/NiRBSSh15DM
	/fCn+lDr5VCJQr4Shh/nIM5lhMtKJnTLtoPbFukEYpwd3R5RRNi/YPPWww==
X-Google-Smtp-Source: AGHT+IFjLCVSIYTspwbYwq/ouj0I+8ZrzZr/FbWMQjYbG5pmbY3ERN8XeQwkCNp/tAzBawRkrlDz8w==
X-Received: by 2002:a05:6870:1494:b0:254:f00e:569b with SMTP id 586e51a60fabf-2584289164dmr985492fac.6.1718314902307;
        Thu, 13 Jun 2024 14:41:42 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:42 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 09/23] qmi: sim-legacy: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:18 -0500
Message-ID: <20240613214134.1056517-9-denkenz@gmail.com>
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
index 1817f7b5ee2a..deeccb7879f2 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -709,22 +709,17 @@ static void gobi_set_online(struct ofono_modem *modem, ofono_bool_t online,
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
+	else /* DMS always available */
+		ofono_sim_create(modem, 0, "qmimodem_legacy",
+						qmi_service_clone(data->dms));
 
 	if (data->features & GOBI_VOICE)
 		ofono_voicecall_create(modem, 0, "qmimodem", data->device);
-- 
2.45.0

