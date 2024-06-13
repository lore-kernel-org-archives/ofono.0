Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B913E03B
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314910; cv=none; b=pAJP0iqbun+WVhhXy3XyDTsk0ApOTd2ts+acidpB3Te150FrbunHjqELD+Ca609vVEWhujNFZifHRfcwZgAgJItTBco8dN0cEcPaYwmHNO8y5DBaHzvbjsn9cPs2rZm4MKsvIxfYiN/zNGPrXS2a8Q1lEGqCjZUdniRhWzwMp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314910; c=relaxed/simple;
	bh=6ry95od5dvfdTZ05opWvIQFEO0jJGxLHS/XDfWkpd84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLHFaZRDeTjotDTjNVXCWr2DHBhyMBN/txgtLu/FnU83XJi35BBFQvibbyHNMFHoDc/mj2nvRAocpDLsNOaQpRjnZdsmHrI5PwGjQFrlb+x2P/pT38j+UokJj+ZHck3RQHvZ4wrIr0K6J+ER2xv//kkAo8CXMfsnBWVKHneBlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIvJvtgY; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIvJvtgY"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2506fc3a6cfso706929fac.2
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314907; x=1718919707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyVENghjreLJDIhPqQXX6lCWh/kuD0T4H2XDx7rysrQ=;
        b=aIvJvtgYik60cjJBvoN/OLGSMBLI71oToAF2DJ4eVdZFK3zfZJV90LNgia0Wklc2tQ
         gE9OdTLFgMFaLQoBmh2um90YUhTiZDcokJtQpj3rOuy5oNtUukbUWWEr/nWqVRTbVvYg
         KHdX3i9UDoILgo3pw1X5SLDNMFNPM0fX8JrxYgO6GJSb8BDVWBcX4oQ1HtmbfqZmGLn9
         8mI3a6xaPgTCI78na7D4UBujk4SOHiEy5lBfrMfHWEDgxZUAUm2KKEWlBcrfO5ztJhA4
         3a09uIn/o5fbwdI6CE2/mRN2pxnM2cz2cJKRFzXuIYky/vYtPvajcGQ47Ww9/0JZS3Sn
         j4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314907; x=1718919707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyVENghjreLJDIhPqQXX6lCWh/kuD0T4H2XDx7rysrQ=;
        b=gglaUe6jE/2uBsUmOMFlquF35nI6I8MLk6MSCnXL5zIUIVMQLNrJGAmXUKv5XzMLI6
         EsnlNA2/7crJy9zI2uLvRDtS9CE7vdOX7xPRR2xaRMgXcNNYqC9ruuWnwZVoVefEfhND
         21NIpAeqqRJslm96vY9CbJNeeyTekybZtvewMppBIqp82MYLi5PXVylof6CgM9cSuZ75
         dHSO/oXvz43F23D44KCAHqhLEgwQfe8x7OmysJin4ZJaGts4kqVRfqnNYrFbj4wg9E1n
         xUXd+/4AS/GlEtWcfiU6ssqs2h0auj80Sv5+3ouh7Yga7+nkPUq/0U/iJq5bFeoA/Sj3
         HiIA==
X-Gm-Message-State: AOJu0YzbbF0yDk6WZldA+9WHfuuO1GDMoQdyO+lE1oxqrJsnHudKmU5z
	W6KkMCLxh3hVbDly1ebjJYh5kQtYRCy1iKkmiZbzPYiSwNK5tJG89CjjkA==
X-Google-Smtp-Source: AGHT+IFy2AOpEo7bv/0BKrS5hlvJYNvbnK+k7Xjn97ssy6C68MWMByRc74KHX75sS7Wg/aRwC7D+bQ==
X-Received: by 2002:a05:6870:b14a:b0:254:a8d3:6fbb with SMTP id 586e51a60fabf-2584297b247mr961510fac.24.1718314907481;
        Thu, 13 Jun 2024 14:41:47 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:47 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 16/23] qmi: sms: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:25 -0500
Message-ID: <20240613214134.1056517-16-denkenz@gmail.com>
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
 drivers/qmimodem/sms.c | 56 +++++++++++-------------------------------
 plugins/gobi.c         |  3 ++-
 2 files changed, 17 insertions(+), 42 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 65909c6a71f6..4238665a5e8d 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -725,58 +725,33 @@ static void set_event_cb(struct qmi_result *result, void *user_data)
 	ofono_sms_register(sms);
 }
 
-static void create_wms_cb(struct qmi_service *service, void *user_data)
+static int qmi_sms_probe(struct ofono_sms *sms,
+				unsigned int vendor, void *user_data)
 {
-	struct ofono_sms *sms = user_data;
-	struct sms_data *data = ofono_sms_get_data(sms);
+	struct qmi_service *wms = user_data;
 	struct qmi_param *param;
+	struct sms_data *data;
 
 	DBG("");
 
-	if (!service) {
-		ofono_error("Failed to request WMS service");
-		ofono_sms_remove(sms);
-		return;
-	}
+	param = qmi_param_new_uint8(QMI_WMS_PARAM_NEW_MSG_REPORT, 0x01);
 
-	if (!qmi_service_get_version(service, &data->major, &data->minor)) {
-		ofono_error("Failed to get WMS service version");
-		ofono_sms_remove(sms);
-		return;
+	if (!qmi_service_send(wms, QMI_WMS_SET_EVENT, param,
+					set_event_cb, sms, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(wms);
+		return -EIO;
 	}
 
-	data->wms = service;
-
+	data = l_new(struct sms_data, 1);
+	data->wms = wms;
 	memset(&data->rd_msg_id, 0, sizeof(data->rd_msg_id));
 	data->msg_mode = QMI_WMS_MESSAGE_MODE_GSMWCDMA;
-
-	qmi_service_register(data->wms, QMI_WMS_EVENT,
-					event_notify, sms, NULL);
-
-	param = qmi_param_new_uint8(QMI_WMS_PARAM_NEW_MSG_REPORT, 0x01);
-
-	if (qmi_service_send(data->wms, QMI_WMS_SET_EVENT, param,
-					set_event_cb, sms, NULL) > 0)
-		return;
-
-	ofono_sms_register(sms);
-}
-
-static int qmi_sms_probe(struct ofono_sms *sms,
-				unsigned int vendor, void *user_data)
-{
-	struct qmi_device *device = user_data;
-	struct sms_data *data;
-
-	DBG("");
-
-	data = l_new(struct sms_data, 1);
+	qmi_service_get_version(data->wms, &data->major, &data->minor);
+	qmi_service_register(data->wms, QMI_WMS_EVENT, event_notify, sms, NULL);
 
 	ofono_sms_set_data(sms, data);
 
-	qmi_service_create_shared(device, QMI_SERVICE_WMS, create_wms_cb, sms,
-					NULL);
-
 	return 0;
 }
 
@@ -788,11 +763,10 @@ static void qmi_sms_remove(struct ofono_sms *sms)
 
 	ofono_sms_set_data(sms, NULL);
 
-	qmi_service_free(data->wms);
-
 	if (data->msg_list)
 		l_free(data->msg_list);
 
+	qmi_service_free(data->wms);
 	l_free(data);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index a0f2fac3dede..da27930c1e94 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -806,7 +806,8 @@ static void gobi_post_sim(struct ofono_modem *modem)
 		ofono_radio_settings_create(modem, 0, "qmimodem", data->device);
 
 	if (data->features & GOBI_WMS)
-		ofono_sms_create(modem, 0, "qmimodem", data->device);
+		ofono_sms_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->wms));
 
 	if ((data->features & GOBI_WMS) && (data->features & GOBI_UIM) &&
 			!ofono_modem_get_boolean(modem, "ForceSimLegacy")) {
-- 
2.45.0

