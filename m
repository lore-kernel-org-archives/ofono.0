Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053911AE84E
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895127; cv=none; b=U1tEaGZ8FOZOQs5ttZrmNE9xiuL4QXSN67N0SSclWAI1OZJ8QguZvD4gCh2r5Mw8G5mM8Di1Iq/wYstPKT0r2N8+v9C64MkL484zRqy/ZbbulESiOgLuzkA7PYqDkd9yfm+aYBIo/lIiC1ydWiVw88/9TbOeFa9TCdozCPzwM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895127; c=relaxed/simple;
	bh=mbGPjn8vEREaGryrfwrAFP197XAHAet6GON6MNGWSw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F15zYLEcA+K3JN5XKxnBuFurjQJ1NMTKPhkmo9U5eGWWOkERJUwrUi1w6d8dGI4BCLN/zjpVEzWZbypM+zX61lnALSzSF7gEasFwP92wFEW2lqwFTmEYmWtHEYwSa7bCnqpg+BwEZencXZdqXh4aaUhG0FWr9uJDK/tYesEaZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXGF6dOE; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXGF6dOE"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d21f253a53so425745b6e.2
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895125; x=1719499925; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U2l8mxFICX6hZ5C5qX4FKms7BlvGzmOmlHfLDlvOCc=;
        b=jXGF6dOE/onORS5DGvOVr0hgo2nwD5ftb+0JkMLrI26cQpug8gqb9E/WpcwhfpOKa9
         DKpf9iPEtJSOnDZicfDu7PBXRy0MllePQ0bG1kOHru0/TJ/pvtmc7UrP6tqOYKqK8Ubp
         uXh6aCu2A/NJMlHeZzvUuXMpqIoEck9MgEvSUYbA35PmS/f6bsXKesDKR4od4/TPQXTM
         VauiKJ32Bu1mPgl2wCEemh3wuLiNza38P4LEDg0illwn/KZOWkOOzz26tqpN64bwpZBB
         dWP8T8+A6i2X5PjE5To7WktdVAb63YkCaoRrAdrRxXIFE+soJVF8Hy+O2F+TuEgGMxvQ
         Nsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895125; x=1719499925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U2l8mxFICX6hZ5C5qX4FKms7BlvGzmOmlHfLDlvOCc=;
        b=DgNgTVNIKnpr0mNYo5kTU7t0vwM/DxD35FH/7eB8RnSqzgbonbBKiqeD3h/0+odKJX
         41c3aVKieuGhXQxQmV8lpjFMV3IB9ANY5TIHapc/EeWxcHve15XpQzgH43O6KVV+ihY7
         wjKTRe7BTuqYFPimai3rxpICmeBgJdn/6g8AECfe2qemMAWklXvWX0UAVLZkySTnUsm7
         Nh74A3UIxEzfQKjRgH5FVbddubEKeyYP040w9NsEZXmOiD4DErB9B21Wukziq9OX1TlP
         z/nBY+4GHQFkOMiCcf8nkpjp1MU84m/+A00YisTrGhNjup8nqbbeF6Z9JI9wW8VaLgSZ
         R3Fg==
X-Gm-Message-State: AOJu0YzEZnBp7W+VnfCc5YkAPl+enuWxvV6ow/F5QiE6TZD0cltCoKkd
	G4VTJuQ13evFeGkpo+qfQSJ0jsYjFhSep70X3XNzK8orNuUUD8GgZ9X2jw==
X-Google-Smtp-Source: AGHT+IG6Rw5sy7yeLthallpYp9nrGs9s87FgxtC/JA3NXveNeqTqdTOyjLPgassG8hHeCDzdZ8MzaA==
X-Received: by 2002:a05:6808:220c:b0:3d2:281a:31b1 with SMTP id 5614622812f47-3d51ba9feb3mr6185334b6e.34.1718895124956;
        Thu, 20 Jun 2024 07:52:04 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:04 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 16/33] qmi: sms: Require at WMS version 1.2+
Date: Thu, 20 Jun 2024 09:51:03 -0500
Message-ID: <20240620145139.1135899-16-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the version check from the SMS atom driver to the gobi modem
driver.  Do not request WMS unless version 1.2 is supported.
---
 drivers/qmimodem/sms.c | 12 ------------
 plugins/gobi.c         | 13 +++++++++++--
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 2ac06a40bdd6..3e2bef6e38b7 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -22,8 +22,6 @@
 
 struct sms_data {
 	struct qmi_service *wms;
-	uint16_t major;
-	uint16_t minor;
 	struct qmi_wms_read_msg_id rd_msg_id;
 	struct qmi_wms_result_msg_list *msg_list;
 	uint32_t rd_msg_num;
@@ -263,16 +261,11 @@ static void qmi_bearer_query(struct ofono_sms *sms,
 
 	DBG("");
 
-	if (data->major < 1 || (data->major == 1 && data->minor < 2))
-		goto error;
-
 	if (qmi_service_send(data->wms, QMI_WMS_GET_DOMAIN_PREF, NULL,
 					get_domain_pref_cb, cbd, l_free) > 0)
 		return;
 
-error:
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-
 	l_free(cbd);
 }
 
@@ -301,9 +294,6 @@ static void qmi_bearer_set(struct ofono_sms *sms, int bearer,
 
 	DBG("bearer %d", bearer);
 
-	if (data->major < 1 || (data->major == 1 && data->minor < 2))
-		goto error;
-
 	domain = bearer_to_domain(bearer);
 
 	param = qmi_param_new_uint8(QMI_WMS_PARAM_DOMAIN, domain);
@@ -314,7 +304,6 @@ static void qmi_bearer_set(struct ofono_sms *sms, int bearer,
 
 	qmi_param_free(param);
 
-error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 	l_free(cbd);
 }
@@ -747,7 +736,6 @@ static int qmi_sms_probe(struct ofono_sms *sms,
 	data->wms = wms;
 	memset(&data->rd_msg_id, 0, sizeof(data->rd_msg_id));
 	data->msg_mode = QMI_WMS_MESSAGE_MODE_GSMWCDMA;
-	qmi_service_get_version(data->wms, &data->major, &data->minor);
 	qmi_service_register(data->wms, QMI_WMS_EVENT, event_notify, sms, NULL);
 
 	ofono_sms_set_data(sms, data);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 23d16e251196..63eb847eb680 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -441,6 +441,8 @@ static void discover_cb(void *user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct gobi_data *data = ofono_modem_get_data(modem);
+	uint16_t major;
+	uint16_t minor;
 
 	DBG("");
 
@@ -448,8 +450,6 @@ static void discover_cb(void *user_data)
 		data->features |= GOBI_DMS;
 	if (qmi_device_has_service(data->device, QMI_SERVICE_NAS))
 		data->features |= GOBI_NAS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_WMS))
-		data->features |= GOBI_WMS;
 	if (qmi_device_has_service(data->device, QMI_SERVICE_WDS))
 		data->features |= GOBI_WDS;
 	if (qmi_device_has_service(data->device, QMI_SERVICE_WDA))
@@ -461,6 +461,15 @@ static void discover_cb(void *user_data)
 	if (qmi_device_has_service(data->device, QMI_SERVICE_VOICE))
 			data->features |= GOBI_VOICE;
 
+	if (qmi_qmux_device_get_service_version(data->device, QMI_SERVICE_WMS,
+						&major, &minor)) {
+		if (major < 1 || (major == 1 && minor < 2))
+			ofono_warn("unsupported WMS version: %u.%u, need: 1.2",
+					major, minor);
+		else
+			data->features |= GOBI_WMS;
+	}
+
 	if (!(data->features & GOBI_DMS)) {
 		if (++data->discover_attempts < 3 &&
 				!qmi_device_discover(data->device, discover_cb,
-- 
2.45.0

