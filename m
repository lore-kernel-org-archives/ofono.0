Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEDA149DFA
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314912; cv=none; b=KCPsWhw6n8l0C+HcpaXJFJU8OvrZ5vO72+oEd/rzC67idaM8f5i++6deaYPGR3X/v8yC6EwYkv6iI2v5Qi3hNdR74DKtU34sbVRwL9KwQUGhkw243KDKrDYrbjMYMWhCG5M0D0cez2q0WM5LxIsKMGBjfQD8EeQj2cQxJ8agETk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314912; c=relaxed/simple;
	bh=VtKlecnWaKy1v+FZXs9+kRI4Djw9IPrUYvfH1fcBVWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJ9NE4e0j0E/Ll+5bzr5GXj29GGSESTxp1+Zv1swsN/m3rZMoEiFeu0lPSb6++oiCH0NVSeC1SlFy7bDtStv7X8QzQSZOtxnHkLKK9Y2jjf6eIwDxyTrPHy4XgStXdslfQLFYzwPvGmztS6O9N8pCssLHnih69CzPsURHCCSovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzU4UpzD; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzU4UpzD"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f8edde24b3so879325a34.2
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314910; x=1718919710; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eg8Rm8Z35K3O5WUGa2SC5AaT7K/qn0BBD7rtdxwVJg=;
        b=SzU4UpzDe44FFsHKJXDhletgdZhZIiadFflLFnB5HAKiMnyEp0UOyT7S25Wi6/yVxf
         G7YA5j0uM45UZWo0g9Lrv1yEzqV2JAilnw2H88KgB1iEYpSjBjJGIXMksdW7Ukix0wAt
         0lX8fIufAB0jrBrO7YTxjWvtEvJlgCEqOeCypqNamsUXMRBFI0iilAkflY0WRdj0bXLy
         Efy4CRYJtNDhOe7PVMkDEn1xRlT9SVROuSvvtXiIMA2iUzOCP7rm//fQoRC8wVC1buPm
         bVDSyhCWB39krfqemnQqDXHabfM3b+0eqlFtuvf8evlmkeSabbEXvNzrNyj4whwuqUgO
         YW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314910; x=1718919710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eg8Rm8Z35K3O5WUGa2SC5AaT7K/qn0BBD7rtdxwVJg=;
        b=ts3UZwoBc3mnqhzO9ng7TgyYzyKIecA4GkRV+diM2LBYY5X+p9G3XIdvSQKcL7nPk9
         1cvt8I+2qWqDR7wuNao26leUzZbb0gJJiKTgn6EnpN7F0bNdBwe2fqm/gslxDkbxSqJ8
         vlLiolfbeBPX8wi8ClPjWZetnQAbjbkFEBufDE/5DfhP9UOu0e/d7e0IIX9si3ztCXww
         vlD+i2uSuIxR0fASZsYj62v7KNmk1dmNqPWkXID9DCM+FofUYLBvroKUTZldLNOMkRpb
         ekIoUVLvjxrYlsqH74fxfpsqvAhCV/hkDFhwCLLDMSJM02+G/F+cynWnqafv0ZfhEeuQ
         afbw==
X-Gm-Message-State: AOJu0YwijsaBbDKisyR6rNO6RbOV8laYjimHwXj1X7YPhOuZb7v83Epd
	KMDSlYnvr/vxopudbjMtdx0GoFxgl4vUHwECSqVHfh2RodBmYAm5ox/WZw==
X-Google-Smtp-Source: AGHT+IE4eJkASo3VlBZHS7QtlD0id6mgt8lt8goCuPKqj4sOiFA8WKCxIYEeU5YTulG/3Ys4bBJNVw==
X-Received: by 2002:a05:6871:5c9:b0:254:a753:d1bc with SMTP id 586e51a60fabf-25842ba2060mr991328fac.37.1718314910157;
        Thu, 13 Jun 2024 14:41:50 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 20/23] qmi: gprs-context: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:29 -0500
Message-ID: <20240613214134.1056517-20-denkenz@gmail.com>
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
 drivers/qmimodem/gprs-context.c | 70 +++++++++++++--------------------
 plugins/gobi.c                  |  4 +-
 2 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 625fd0b8f193..aae058f35a9b 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -22,7 +22,6 @@
 
 struct gprs_context_data {
 	struct qmi_service *wds;
-	struct qmi_device *dev;
 	unsigned int active_context;
 	uint32_t pkt_handle;
 	uint8_t mux_id;
@@ -480,9 +479,10 @@ static void bind_mux_data_port_cb(struct qmi_result *result, void *user_data)
 	}
 }
 
-static void qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc)
+static int qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc,
+					struct qmi_service *wds,
+					uint8_t mux_id)
 {
-	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
 	struct ofono_modem *modem = ofono_gprs_context_get_modem(gc);
 	struct qmi_param *param;
 	const char *interface_number;
@@ -496,7 +496,7 @@ static void qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc)
 	bus = ofono_modem_get_string(modem, "Bus");
 	if (!bus) {
 		ofono_error("%s: Missing 'Bus'", ofono_modem_get_path(modem));
-		goto error;
+		return -EINVAL;
 	}
 
 	if (!strcmp(bus, "pcie"))
@@ -508,7 +508,7 @@ static void qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc)
 	else {
 		ofono_error("%s: Invalid 'Bus' value",
 				ofono_modem_get_path(modem));
-		goto error;
+		return -ENOTSUP;
 	}
 
 	switch (endpoint_info.endpoint_type) {
@@ -528,68 +528,54 @@ static void qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc)
 
 		ofono_error("%s: Missing or invalid 'InterfaceNumber'",
 					ofono_modem_get_path(modem));
-		/* Fall through */
+		return -EINVAL;
 	default:
-		goto error;
+		return -ENOTSUP;
 	}
 
 	DBG("interface_number: %d", endpoint_info.interface_number);
-	DBG("mux_id: %hhx", data->mux_id);
+	DBG("mux_id: %hhx", mux_id);
 
 	param = qmi_param_new();
 
 	qmi_param_append(param, 0x10, sizeof(endpoint_info), &endpoint_info);
-	qmi_param_append_uint8(param, 0x11, data->mux_id);
+	qmi_param_append_uint8(param, 0x11, mux_id);
 	qmi_param_append_uint32(param, 0x13, QMI_WDS_CLIENT_TYPE_TETHERED);
 
-	if (qmi_service_send(data->wds, QMI_WDS_BIND_MUX_DATA_PORT, param,
+	if (qmi_service_send(wds, QMI_WDS_BIND_MUX_DATA_PORT, param,
 				bind_mux_data_port_cb, gc, NULL) > 0)
-		return;
+		return 0;
 
 	qmi_param_free(param);
-error:
-	ofono_error("Failed to BIND_MUX_DATA_PORT");
-	ofono_gprs_context_remove(gc);
+	return -EIO;
 }
 
-static void create_wds_cb(struct qmi_service *service, void *user_data)
+static int qmi_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int vendor, void *user_data)
 {
-	struct ofono_gprs_context *gc = user_data;
-	struct gprs_context_data *data = ofono_gprs_context_get_data(gc);
+	struct qmi_service *wds = user_data;
+	struct gprs_context_data *data;
 
 	DBG("");
 
-	if (!service) {
-		ofono_error("Failed to request WDS service");
-		ofono_gprs_context_remove(gc);
-		return;
+	if (vendor) {
+		int r = qmi_gprs_context_bind_mux(gc, wds, vendor);
+
+		if (r < 0) {
+			qmi_service_free(wds);
+			return r;
+		}
 	}
 
-	data->wds = service;
+	data = l_new(struct gprs_context_data, 1);
+	data->wds = wds;
+	data->mux_id = vendor;
 
 	qmi_service_register(data->wds, QMI_WDS_PACKET_SERVICE_STATUS,
 					pkt_status_notify, gc, NULL);
 
-	if (data->mux_id)
-		qmi_gprs_context_bind_mux(gc);
-}
-
-static int qmi_gprs_context_probe(struct ofono_gprs_context *gc,
-					unsigned int vendor, void *user_data)
-{
-	struct qmi_device *device = user_data;
-	struct gprs_context_data *data;
-
-	DBG("");
-
-	data = l_new(struct gprs_context_data, 1);
-
 	ofono_gprs_context_set_data(gc, data);
-	data->dev = device;
-	data->mux_id = vendor;
 
-	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
-									NULL);
 	return 0;
 }
 
@@ -601,9 +587,7 @@ static void qmi_gprs_context_remove(struct ofono_gprs_context *gc)
 
 	ofono_gprs_context_set_data(gc, NULL);
 
-	if (data->wds)
-		qmi_service_free(data->wds);
-
+	qmi_service_free(data->wds);
 	l_free(data);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 6d48f0d1bc5b..65629e92ba09 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -752,7 +752,7 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 		interface = ofono_modem_get_string(modem, "NetworkInterface");
 
 		gc = ofono_gprs_context_create(modem, 0, "qmimodem",
-							data->device);
+						qmi_service_clone(data->wds));
 		if (!gc) {
 			ofono_warn("Unable to create gprs-context for: %s",
 					ofono_modem_get_path(modem));
@@ -778,7 +778,7 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 		mux_id = ofono_modem_get_integer(modem, buf);
 
 		gc = ofono_gprs_context_create(modem, mux_id, "qmimodem",
-							data->device);
+						qmi_service_clone(data->wds));
 
 		if (!gc) {
 			ofono_warn("gprs-context creation failed for [%d] %s",
-- 
2.45.0

