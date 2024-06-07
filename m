Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C221553AB
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800487; cv=none; b=gsIvCHm5A6AbzY3kFxTtLbFn0fj+jBT1c4rT6wKFJd7c+u0EjnH+iky4GdsKGnoQHj/ARLJaOJKloTGDd+VLklAUdJ8M5b/HBwBIDc7rUPWQVF994KraR7RGmynqI3+HJGB78pPi1rtbFt1ZmBptcq1RbCk9uf6pghlLXW2J/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800487; c=relaxed/simple;
	bh=SsV6uVMuTz2IXP5lAaBBxI/8XFl5PvYBgbXRboSJFTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwdWsaIBB3RXstzVVYuk37n26UGdqyBaIaqKgRUDen+NPawRWjiBcLCjWX1I7BS7zU4KMTvjoqxaGY6s8yyjV7CncYkHWKkkBzdSJ37zonAvthH9+v5tr494pJ7akPh424xD0LF9t6buSl0QIJZcQ8y3HBHCTaY7OGIPJNwvHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0AnZN0M; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0AnZN0M"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d1b33e9ac6so1523519b6e.1
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800485; x=1718405285; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVaa0Z0numLrxY/KxHgDBhD/KP5A9wqDJVkmZCuDa2s=;
        b=C0AnZN0MPnQui97sdq1uEVlHewURytJoOBTAJnYrc+LIkcYdwT73wVfmuTvil2zHhJ
         qkRFjzahGrgBHjn+iF84jTDW7gMc0Bxn7NzzN1Y1in023DbAu52/1XF6ztk9IOlcWxYm
         0QKwrToK6ZKkssLchYhri9I2r2RuVJl8m5itz6zpobsjn7tm8inStLsTYhcQCZ+9S4Y5
         8to7ER5c47EhcoR0dYoU7nvKrtvtlHBvuoPgyhbiLKPg9R97Iw1J/HhckDmvNrE/3ilV
         8+kvfrdLoxVdDxK2fz1BzIkU7IJ9z3uvX+eVZ25D+hqkIDUYWtyi4M2SFcNG5A6fRne+
         GrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800485; x=1718405285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVaa0Z0numLrxY/KxHgDBhD/KP5A9wqDJVkmZCuDa2s=;
        b=RBT8LC6PmLsnpyF9q8qOVjC7oi/NQt2/Pjc/1bsVGIhNhpgLjRKJHuNMp6WmGH2mUT
         LVKB0IJiGG89Gyw36dl8fZBWtoParCKghzR/+TZWefKVngZbos0bndrC0LKH6w5WWBLp
         /WPeq7vpwb+zwwsn+zW2dCIs9RjLhZhPHYRI4HRyetiak7VDNoMfv/wxLDtk3Wm7HI9s
         ArI/5njCdUOfK+YvrmwwqqHt3qs1xAa3BXLRPNYdGgfsH+iMnZQssWTReylnrpZB0hPb
         sGAr8HIAuqZlvPPQ8GNrxwSJ1tP+ztX4XaaioNHWOlI2OJRUXOc7BZuA64A6Gheap68P
         fVKA==
X-Gm-Message-State: AOJu0YySGtv0WJ89uVu8b63q6+SSm6ljEsqZSdRhV9YEeg4IoT1axRiA
	eklxuVBzfCyTpOC2d7aBhYyzXDKkXuLvCwuOeMI/I2SjkqdrfbtoZw8Ppg==
X-Google-Smtp-Source: AGHT+IFW5jNBAJoN4dgbsBSsMTZrKC+nQRZtB3rInFM2nD/X7s7LChW84U/RMq9avZcB1PD4eADP3A==
X-Received: by 2002:a05:6808:6190:b0:3d2:1b2e:8c5b with SMTP id 5614622812f47-3d21b2e8efdmr419426b6e.3.1717800485425;
        Fri, 07 Jun 2024 15:48:05 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:48:05 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 21/23] qmi: sim: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:21 -0500
Message-ID: <20240607224746.903769-21-denkenz@gmail.com>
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

Use qmi_device_get_service and qmi_device_add_service_watch
---
 drivers/qmimodem/sim.c | 90 +++++++++---------------------------------
 plugins/gobi.c         |  4 +-
 2 files changed, 21 insertions(+), 73 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 67925239f2b5..29f4eff7bc40 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -44,7 +44,6 @@ struct sim_status {
 };
 
 struct sim_data {
-	struct qmi_device *qmi_dev;
 	struct qmi_service *dms;
 	struct qmi_service *uim;
 	uint32_t event_mask;
@@ -841,68 +840,31 @@ error:
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
 
@@ -915,29 +877,13 @@ static void qmi_sim_remove(struct ofono_sim *sim)
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
index 8d537b85d8d9..d32fb9d75585 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -728,7 +728,9 @@ static void gobi_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "qmimodem", qmi_service_clone(data->dms));
 
 	if ((data->features & GOBI_UIM) && !legacy)
-		ofono_sim_create(modem, 0, "qmimodem", data->device);
+		ofono_sim_create(modem, 0, "qmimodem",
+						qmi_service_clone(data->dms),
+						qmi_service_clone(data->uim));
 	else /* DMS always availalable */
 		ofono_sim_create(modem, 0, "qmimodem_legacy",
 						qmi_service_clone(data->dms));
-- 
2.45.0

