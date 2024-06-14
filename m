Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253B51A2C0D
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391196; cv=none; b=X1WSuLjzzV8URNqILoO8MMvzcgWKL7peNwjo/lOROiry9GBWZ5wzzirxVEzp6+Jfs6FnegqtOXaI4ngTpLQmrCRL+yQPWCexsuo9rQDPCnyNmy6RxoD/7iF74JSWeEU4do3dadh8imUkTgFqTYgcy06ap5ArPFi/9h02kMpeHgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391196; c=relaxed/simple;
	bh=I1CQjNSKE1xedYxPd1hRE1/8IHQ1KxbrVocsu63+LlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJf2SMxkeWQNIu5MvJhjjlM+eBuPYsaZjd9Ys6kWlGp3P4NmR1B/uMJkWLI5vOKmA71+1ejpaIU1HfQSatpBkzkH9l3+qMgt4jZpXHayzvecQcTTTm/LCKAuZeRuVswe8VQcwnSRUArmO9oRRyXcJSg8aU0CNmMMYIOOwKl68Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWcjMCnv; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWcjMCnv"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2547e1c7bbeso1251983fac.2
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391194; x=1718995994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNzPk/sIxYazZyUBDJ20Joqqf1efnIiXezANz7ujrfk=;
        b=lWcjMCnvOOl7+fjRgHaLHkN/FRQuiXLqBWOJq0UE+DbchwoslbmAZaYArKvNLDrbs0
         U03XyCJm5ywTyVv4K3bvCBWdEehPzV2dMxlj437uXTxBMpDuDX+kTc5WcEx1SV1LtROd
         KZKBRjpwDLu1ai4/9OS70oPgUE8RadH8NuyUtJ9I8lxxEMIiKbA8zi05ipB/WxWaAX0G
         OZIzFXCzve9+/QVIiFhTsd6u4rpWSrqM6R5yGvogmIZyrDrz5tXpE01L9iopbF4VVOOA
         5Zy5a3hjeF/Gi98HLpPUtm5uOyduEoJXOoflD5d18C+iKF8+8bf6rYuC4p9VauGLr7Dz
         LCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391194; x=1718995994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNzPk/sIxYazZyUBDJ20Joqqf1efnIiXezANz7ujrfk=;
        b=rBqU0O/zghYgxt/bbzH3hklytym5A5hE+UH/n7VD1p+QciKmOgO1MmV5SrvhcSnUQm
         x/9Y4jwlXvKiq34LbyjXpo/s7ick252UZ9yEsRMjjV1H/cqz7uYAgwtMHwWy/mrD3RfC
         Bu6bCmqid2+quXbcnB9rF5Qea8cX0KJlV8FlsIImdS6jvFmiDvDrApHne+7Flsijh1f8
         vY+aYCdvMsTOY6uGivuZfcCXxe+FYUldHCdlp9qiWE22DLLlAx0MtB/Lbwyv1CSfPxBs
         MHuDJwcazXgnnL6NrDBkj+uEePAIkWFG5q2rjMOBqjw8WP2RyHY2UyYmN1dkdd2mcSqj
         fXvw==
X-Gm-Message-State: AOJu0YzDd7RSx2t3199Y7BoQCL8Xz81qiqQVvTdE4sLcl+p83v+G+Uby
	IErFicIyqbEM/PENhJNwM7ckBPA6rLnjzqgbrkYoVw4oU2TmyIiwC/Y2pQ==
X-Google-Smtp-Source: AGHT+IE1sYPt5/pi3pM6phmQntUoO1PFPq8pQChC85EEngNGG9FdXXenLivkmepJ+ZzNfqIJUF1dog==
X-Received: by 2002:a05:6870:1586:b0:24f:e427:f684 with SMTP id 586e51a60fabf-2584288bcc9mr3656311fac.8.1718391194131;
        Fri, 14 Jun 2024 11:53:14 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:13 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 15/27] qmi: sms: Require at WMS version 1.2+
Date: Fri, 14 Jun 2024 13:52:27 -0500
Message-ID: <20240614185300.1086701-15-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614185300.1086701-1-denkenz@gmail.com>
References: <20240614185300.1086701-1-denkenz@gmail.com>
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
index 56245a496bcc..59b459beb995 100644
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

