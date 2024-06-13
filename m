Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D3149C7A
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314909; cv=none; b=S84NwHT9gtaBDQL67x6Im1MJGSCcZ6bPlJ/XQOjv8jQcK3EfB3Bnjn8RTLgWoG+WgrcZuv9PAbuhIENuVnrqpB7o2oRTx57MdoarwQINAdj9WRHXaHb1yWo3RYCOEXOrxh1sxWaJEojBA/g8wfRRNskbz4pTVuI3CbaVdR/JjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314909; c=relaxed/simple;
	bh=W9FOmRt8//GX2XPQyKhyQ3Wg0ZpbweoYN2Mz0nVEyUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/Q0ygyg2MVIkFsEB11u+BZ07/0i1QeKvIfMIWNXD2A4NBdNtg4fx0F37hfqG75AGqrgNgeUyUkDrMj5BQyCawVbbf1IuyUIP1+3mD8EcY/NO3NNbN75NGpdhf8arvNe9GtcTd1ls02h72SeTGMplk8Gdw95XAYidzvEbCmPaSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqzGAomQ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqzGAomQ"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2548a00c19eso815018fac.3
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314907; x=1718919707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvx4czkjMt44o8hk1UAtUd2FH3DKAIjFAFWDF6DDg9k=;
        b=VqzGAomQ19X2gbdOgWImvurLWRR0DdMa906a0lhJP4X7Y/qNR8Rd6FN6v+z1wkZCnJ
         +Q6/lf6DVd93QwzkjYUlvVQMLvXXNBNuuo+lPzo8jLxvs2Z0WB+pMmObtYjYHqo9WVRo
         WNM9opl1AUyFcsyPKbjabJmfyJJhBODCJk14oMCrRXLB6Em+uovVWCeGCsHHiy8q5ynb
         kBDnrhVhEDq2o3u7v0uQDVCkd5frGAtN/OuIXjMx92PGYs6SEfLK36vAtkA2r6LzoIyg
         G6ssU1TFNt3SiaeOdT1oAEwY1LxSQ+M08yfN7mggTw1r07jGnPcNj4aOhB14Kk6UT77Y
         Kf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314907; x=1718919707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvx4czkjMt44o8hk1UAtUd2FH3DKAIjFAFWDF6DDg9k=;
        b=brMQzwt9J4XBWib7s2lLJ/yZCwYyN3F93A76NwMpVgl5VV9hlJnafKomRhVd/UBYBq
         B/xv7et/sHddlJpLzFalof3VQr/sHdOx8mw0kmnOZ9WYGLBRnOFPVKY+HppuXoxiNE79
         XFUFm9BHHTkpXsLW9TNQ+aOZ/SjLmTxOiFMX9J7I/LTuxhbYlAm2z9ZSB4ahPWQ8whYE
         ywjMoivqmAytOYsVTw4BaRwyCcaXvLMT+qGN05t0BrlxArl+2eET9U9afZT1twKjJSIw
         oAcsCh0cGbyRYkjbg10D/IPZ7p6JvxMsqQGw8ZZIpT/NdidoS0WJD3jkKUqQJk+WRgl9
         8tqg==
X-Gm-Message-State: AOJu0YwNvbDWSC1ZzG2IV6yKIClk13CWdqu8mlXQRPL2bBnX513YMi2+
	2rKy2qbdzXlQz1UH+lf+nLiT5ol+VHwHkDPGow5qpgDj17pc4EbfPIwUbQ==
X-Google-Smtp-Source: AGHT+IFoxvYKXDXMbuFSwMXeuVgqFxm65MNYv37NQ/ck+sbzUNyk096EoLNrXnsu5zalugExyqAj0A==
X-Received: by 2002:a05:6870:584:b0:258:38d5:652b with SMTP id 586e51a60fabf-2584288c927mr959055fac.1.1718314906708;
        Thu, 13 Jun 2024 14:41:46 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:46 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 15/23] qmi: location-reporting: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:24 -0500
Message-ID: <20240613214134.1056517-15-denkenz@gmail.com>
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

---
 drivers/qmimodem/location-reporting.c | 50 ++++++++-------------------
 plugins/gobi.c                        |  4 +--
 2 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/location-reporting.c
index 669e9e6fdd41..1c9b9c9c3663 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -172,67 +172,46 @@ static void qmi_location_reporting_disable(struct ofono_location_reporting *lr,
 }
 
 static void set_event_cb(struct qmi_result *result, void *user_data)
-{
-	struct ofono_location_reporting *lr = user_data;
-
-	DBG("");
-
-	ofono_location_reporting_register(lr);
-}
-
-static void create_pds_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_location_reporting *lr = user_data;
 	struct location_data *data = ofono_location_reporting_get_data(lr);
-	struct qmi_param *param;
 
 	DBG("");
 
-	if (!service) {
-		ofono_error("Failed to request PDS service");
-		ofono_location_reporting_remove(lr);
-		return;
-	}
-
-	data->pds = service;
-
 	qmi_service_register(data->pds, QMI_PDS_EVENT,
 					event_notify, lr, NULL);
-
 	qmi_service_register(data->pds, QMI_PDS_STATE_IND,
 					state_notify, lr, NULL);
 
-	param = qmi_param_new();
-
-	qmi_param_append_uint8(param, QMI_PDS_PARAM_REPORT_NMEA, 0x01);
-	qmi_param_append_uint8(param, QMI_PDS_PARAM_REPORT_NMEA_DEBUG, 0x00);
-
-	if (qmi_service_send(data->pds, QMI_PDS_SET_EVENT, param,
-					set_event_cb, lr, NULL) > 0)
-		return;
-
-	qmi_param_free(param);
-
 	ofono_location_reporting_register(lr);
 }
 
 static int qmi_location_reporting_probe(struct ofono_location_reporting *lr,
 					unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *pds = user_data;
 	struct location_data *data;
+	struct qmi_param *param;
 
 	DBG("");
 
-	data = l_new(struct location_data, 1);
+	param = qmi_param_new();
+	qmi_param_append_uint8(param, QMI_PDS_PARAM_REPORT_NMEA, 0x01);
+	qmi_param_append_uint8(param, QMI_PDS_PARAM_REPORT_NMEA_DEBUG, 0x00);
+
+	if (!qmi_service_send(pds, QMI_PDS_SET_EVENT, param,
+					set_event_cb, lr, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(pds);
+		return -EIO;
+	}
 
+	data = l_new(struct location_data, 1);
+	data->pds = pds;
 	data->fd = -1;
 
 	ofono_location_reporting_set_data(lr, data);
 
-	qmi_service_create_shared(device, QMI_SERVICE_PDS, create_pds_cb, lr,
-					NULL);
-
 	return 0;
 }
 
@@ -245,7 +224,6 @@ static void qmi_location_reporting_remove(struct ofono_location_reporting *lr)
 	ofono_location_reporting_set_data(lr, NULL);
 
 	qmi_service_free(data->pds);
-
 	l_free(data);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 456a5d2363eb..a0f2fac3dede 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -725,9 +725,9 @@ static void gobi_pre_sim(struct ofono_modem *modem)
 		ofono_voicecall_create(modem, 0, "qmimodem",
 					qmi_service_clone(data->voice));
 
-	if (data->features & GOBI_PDS)
+	if (data->features & GOBI_PDS) /* exclusive use, no need to clone */
 		ofono_location_reporting_create(modem, 0, "qmimodem",
-							data->device);
+						l_steal_ptr(data->pds));
 }
 
 static void gobi_setup_gprs(struct ofono_modem *modem)
-- 
2.45.0

