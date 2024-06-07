Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA297155390
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800476; cv=none; b=JSBUEy2xibpbx45wDlpUalbXHQ2neO7gFcPL7OZ3CKugunSNJEqE0NU6IlpQNCNKfDnI+2fvngJjf7aBsMj05CfFbiwF0to7kLqk1DeARvdaG7lJvDiO0hWGi03uvtDerEETgAjtdGg0pn4CZtBM2IazqN5O9blwjelSVeATtEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800476; c=relaxed/simple;
	bh=MWdjsAWYmmbE7/zvOXe4RhU/0EJAqazgrpugKPkfbmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kukjl/7afc8zOvHKYQHT9kPrVe5NwegSzREidSgYPFLateiABE/u6u1Jr7QmtAh9MyEkF46g67YBQZMlmI8k+MdgdHgGI/LIPGuRPFUUercAK1rkWROqTuO5bLzzDXsS5E2rHGqC+EVQ9/Wi08n2xRYRxB6s59LCQF21epXiAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2X37upc; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2X37upc"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b997b8a7efso1045306eaf.0
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800474; x=1718405274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOccx9sH5t7MoQApYdFurfu/tU3tLahsUCaTcDvCZJY=;
        b=d2X37upc0Mzt9/wL9zjzaT2XQePQZk9xG1Kyao+K61py+VTWCoN4Kl23dpZfOMPuS2
         eoTKymtk2J7ajUZU8JCWQAf7+NcNDq2HenoV0t3I+WpBh3K1IStXjXNkY1Cl7EFMkkxV
         OVhRv2KRZF4eA29lx+NywEs3DBmfUFAOIBRdcsvfXttPln8ezTFIzqTisbKbwHiRC05t
         sUQIee05FtSNwu73X0KocWWcw1X1pZ6E+Ag1Nkhbi5MIs6ipiXBVFxnVEv0StFsB+Imm
         Gz0MTcUms2CK6RQw8HwBKwfbe10r1Aj+1qcahQXyf2VgD/wQUspravFNBsfg6g6nQ3o5
         TDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800474; x=1718405274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOccx9sH5t7MoQApYdFurfu/tU3tLahsUCaTcDvCZJY=;
        b=JIWjJfQBQOr4yQPzBAovnqS23DUs20AMcx1RoE9w7xPi7o5jwuRtliBjCmzvMXq56l
         qay2K0cyMpQmLQpvj6q2WzYWEClTBBuvV+Kghy1HyP7LWQWd5ePYmgNzGRa+fmxCY1Ql
         ZoZWgWrudgG/oKtW49hUyUeDT1TTHPq0eIDgS3Kx18+ganhuIX6CHG5z3rXvCkj0Qfca
         0UaME1mybelpL5W/0HeE6mrbkOfKPpFqsU7wjMDV2QM+9M9mWkmC99KkVk/NUnApJP1M
         d+7GQDVnxIRCv4gfti7yKUrs2GpkTYfsWOU2+DKCNOMs1nRJuVUw4of22LivntIBf93n
         COTg==
X-Gm-Message-State: AOJu0Yy1cgZZPHsJVcmaHZWmnNk1UsBSIUOeWrZmI1jJPFfhlZR5gpNu
	zyq6+57+xY/QI9gYsoJ3V8oBE7/d0bvedYer1soKVG5mAKkPcMfBNB69CA==
X-Google-Smtp-Source: AGHT+IHIiAETB/2ggJd2mqF0GzgeHyFxbjNGQbJaMQmHF0s5mFgEnScN6GdzCFwBQhAOzqVUZ+bu4A==
X-Received: by 2002:a05:6820:82b:b0:5ba:6687:a4dd with SMTP id 006d021491bc7-5baae8d0d41mr4281697eaf.8.1717800473558;
        Fri, 07 Jun 2024 15:47:53 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:53 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/23] gobi: request needed services at .enable()
Date: Fri,  7 Jun 2024 17:47:07 -0500
Message-ID: <20240607224746.903769-7-denkenz@gmail.com>
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

Request all needed services when the modem is being powered up via
.enable method.
---
 plugins/gobi.c | 100 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 15 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 147f572a799a..c82dd70d25e1 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -63,10 +63,24 @@ enum qmi_protocol {
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
@@ -164,6 +178,24 @@ static void cleanup_services(struct gobi_data *data)
 
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
@@ -186,6 +218,21 @@ static void gobi_remove(struct ofono_modem *modem)
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
@@ -379,34 +426,42 @@ error:
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
@@ -446,11 +501,26 @@ static void discover_cb(void *user_data)
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

