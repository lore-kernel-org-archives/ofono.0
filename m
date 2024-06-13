Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3F143743
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314903; cv=none; b=MmatXGvFvnyOAMZu/rSTJYP1HwA1GL2d0EVxVDoaoB6FmUu0O5irySRy8yYfF8ciCS+om/Sd+KugD2AIEJZaplobFnlTPrWIiebaDvIXsqHvAbDUAhozwtwbtyMi9w5sAKY6FzXLgeOFog1iW/pS3c8hT65JOpHgHqNwG9AisT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314903; c=relaxed/simple;
	bh=WrA9m0TXFRn0loJpUZZcqiuLoxBOX1PtmZTmL8QYSnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqr7/S6UyCeoSN7LGp23fyAaHRlUb7Cqzqnt/sugICh3uddjpkLwFqBFOfvx1BtTR2LFupaR/v3HNMoG70qVzM7OmxQFV49e8nfexV6ve0GGaYTSnUuNcVO/QC25E9Wiacnr4pLsCC6jY/3fmSbw8iPAerhN+UjAr/cQAbz1tsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsUt3Lrj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsUt3Lrj"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6fa0d077694so732622a34.0
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314901; x=1718919701; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CpejFktLLO6xCcx9x3+xi+oampP9zSGMTWvJ6CVFX0=;
        b=KsUt3LrjtWnBLYk1jfXTDonqgKtXH38O2HG+nE1hA+hrjD8kY0mr/4wFYWgI0Ri3TX
         lP8Uhg+c/Ocv6USympu1diS4UBI+WGJExuaGDtOJ7+YvmZd26CblH1p5pWRy7BeLQT2d
         UIxzq2bDfpv0HIjB9ekdPGOBa/hzzbsq1EKhvbBka5JZrUDMfKR9VewVx9aXBZoYe9n5
         Mg6lpwPAAW3kJ5G2TjLwbYzxwZsoj9zCT2nZU4MLbvhuyulhiqjbnOZfRIBsbBlYHZ1p
         JTZe+WxJpDpJfnF1o5fVMKp8G9Unq1ZzG0c/E1FNVTUtkBs3RkzU9UUau1lZRuNscQiI
         4Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314901; x=1718919701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CpejFktLLO6xCcx9x3+xi+oampP9zSGMTWvJ6CVFX0=;
        b=nTp9VvkmQpubO0+X5DFs5jiSDvEu48/BF0AV4uN5W7n1dL6awbT5oiKEjiWzFeAkEj
         XEJ9IoFU0e6TuxKyfKxLXMPXnrn4a1PdrpzNg8+YQYAdllrQujwW3W07TMBzT743NKbN
         fj4Jz+YEwU8wXSECCjMdavyuWlvuFkyPKqVqGH5b+0Fr6VU82lqI5cKnxrQU556KtVpe
         8TdoeulzCsrb5iWplLETf8fL4ndwJtMnPY4ShEeKVEp3HPkYhCKhmuwlQB04TQdVunPc
         u8bPKlGEbrMiOa7oHuWiU+6KxGzzF9tR3ccUhCe+UuwoA2VeIY9OoqhTvpB3JJducQoM
         HR6Q==
X-Gm-Message-State: AOJu0Yyyka1R3mDt39xpRJ2wKMe/CyjQ5zE6gKXEmrToH3cCajp79ooe
	5nMYTf1iqxlN/ORYH6ZnwIZrIdErcxxmFpZreVJ/1MCg/BzleRIem5OPsA==
X-Google-Smtp-Source: AGHT+IFvzM0FIhsBZjiX3a4D8LqPed9w8lqL+lUmhu5xwkjk0UiNZAIPkt6d/3YlDbgPRuLUaekqUQ==
X-Received: by 2002:a05:6870:14d4:b0:258:476d:a793 with SMTP id 586e51a60fabf-258476dafe6mr330917fac.19.1718314900947;
        Thu, 13 Jun 2024 14:41:40 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:40 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 07/23] gobi: request needed services at .enable()
Date: Thu, 13 Jun 2024 16:41:16 -0500
Message-ID: <20240613214134.1056517-7-denkenz@gmail.com>
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

Request all needed services when the modem is being powered up via
.enable method.
---
 plugins/gobi.c | 100 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 15 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 10ce2acc0cca..ea4d633c3406 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -60,10 +60,24 @@ enum qmi_protocol {
 	QMI_PROTOCOL_QRTR,
 };
 
+struct service_request {
+	struct qmi_service **member;
+	uint32_t service_type;
+};
+
 struct gobi_data {
 	struct qmi_device *device;
 	struct qmi_service *dms;
 	struct qmi_service *wda;
+	struct qmi_service *nas;
+	struct qmi_service *wds;
+	struct qmi_service *wms;
+	struct qmi_service *voice;
+	struct qmi_service *pds;
+	struct qmi_service *uim;
+	struct service_request service_requests[16];
+	int cur_service_request;
+	int num_service_requests;
 	unsigned long features;
 	unsigned int discover_attempts;
 	uint8_t oper_mode;
@@ -161,6 +175,24 @@ static void cleanup_services(struct gobi_data *data)
 
 	qmi_service_free(data->wda);
 	data->wda = NULL;
+
+	qmi_service_free(data->nas);
+	data->nas = NULL;
+
+	qmi_service_free(data->wds);
+	data->wds = NULL;
+
+	qmi_service_free(data->wms);
+	data->wms = NULL;
+
+	qmi_service_free(data->voice);
+	data->voice = NULL;
+
+	qmi_service_free(data->pds);
+	data->pds = NULL;
+
+	qmi_service_free(data->uim);
+	data->uim = NULL;
 }
 
 static void gobi_remove(struct ofono_modem *modem)
@@ -183,6 +215,21 @@ static void gobi_remove(struct ofono_modem *modem)
 	l_free(data);
 }
 
+static void add_service_request(struct gobi_data *data,
+					struct qmi_service **member,
+					uint32_t service_type)
+{
+	struct service_request req = { .member = member,
+					.service_type = service_type };
+
+	if (data->num_service_requests == L_ARRAY_SIZE(data->service_requests)) {
+		ofono_error("No room to add service request");
+		return;
+	}
+
+	data->service_requests[data->num_service_requests++] = req;
+}
+
 static void shutdown_cb(void *user_data)
 {
 	struct ofono_modem *modem = user_data;
@@ -376,34 +423,42 @@ error:
 	shutdown_device(modem);
 }
 
-static void create_dms_cb(struct qmi_service *service, void *user_data)
+static void request_service_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct gobi_data *data = ofono_modem_get_data(modem);
+	struct service_request *req =
+		&data->service_requests[data->cur_service_request];
 
 	DBG("");
 
 	if (!service)
 		goto error;
 
-	data->dms = service;
+	*req->member = service;
 
-	if (qmi_service_create_shared(data->device, QMI_SERVICE_WDA,
-					create_wda_cb, modem, NULL))
+	data->cur_service_request += 1;
+	if (data->cur_service_request == data->num_service_requests) {
+		DBG("All services requested, proceeding to create WDA");
+
+		if (qmi_service_create_shared(data->device, QMI_SERVICE_WDA,
+						create_wda_cb, modem, NULL))
+			return;
+
+		goto error;
+	}
+
+	req = &data->service_requests[data->cur_service_request];
+	DBG("Requesting: %u", req->service_type);
+
+	if (qmi_service_create_shared(data->device, req->service_type,
+					request_service_cb, modem, NULL))
 		return;
 
 error:
 	shutdown_device(modem);
 }
 
-static void create_shared_dms(struct ofono_modem *modem)
-{
-	struct gobi_data *data = ofono_modem_get_data(modem);
-
-	qmi_service_create_shared(data->device, QMI_SERVICE_DMS,
-						create_dms_cb, modem, NULL);
-}
-
 static void discover_cb(void *user_data)
 {
 	struct ofono_modem *modem = user_data;
@@ -434,11 +489,26 @@ static void discover_cb(void *user_data)
 								modem, NULL))
 			return;
 
-		shutdown_device(modem);
-		return;
+		goto error;
 	}
 
-	create_shared_dms(modem);
+	add_service_request(data, &data->dms, QMI_SERVICE_DMS);
+	if (data->features & GOBI_NAS)
+		add_service_request(data, &data->nas, QMI_SERVICE_NAS);
+	if (data->features & GOBI_WDS)
+		add_service_request(data, &data->wds, QMI_SERVICE_WDS);
+	if (data->features & GOBI_WMS)
+		add_service_request(data, &data->wms, QMI_SERVICE_WMS);
+	if (data->features & GOBI_VOICE)
+		add_service_request(data, &data->voice, QMI_SERVICE_VOICE);
+	if (data->features & GOBI_UIM)
+		add_service_request(data, &data->uim, QMI_SERVICE_UIM);
+
+	if (qmi_service_create_shared(data->device, QMI_SERVICE_DMS,
+					request_service_cb, modem, NULL) > 0)
+		return;
+error:
+	shutdown_device(modem);
 }
 
 static int gobi_enable(struct ofono_modem *modem)
-- 
2.45.0

