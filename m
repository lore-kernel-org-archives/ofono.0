Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78D15572D
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800487; cv=none; b=SBaLz487T/pjiEZ1BNsUuu+lUH+GZqiGbSkHkzzYtzYEK3SwRqn8x7a7aUHGmsQT+YBd9paEsNwKlagBwaEyK1QBdoZNYD+8wFZeH/CK43M3RnO8l1QVTlnXsg6ibaIfQQfDlZElD/odAZc22vMmSGmDP0yOV2ZVmVEbOGybj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800487; c=relaxed/simple;
	bh=nA89mQj4IHqzTJQ87D5Kx49Se4PEMStDaDdDdUhhv7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nwae3i+anv04kGOWs3bcoG3nqto1crE7Xo0+gY5hwcGvRCC57pWMFeCYkXF0cLtURxqZ6HZ2FcaBMjPyO4cZx5GzNgueCsDqc2fMqc4ATwfx+NhsvqU/W06a8W7GH2LE5CCiCp3phMmV1VqKwHrOLK5JggXN51GTjnUS/08xz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWyHD8bL; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWyHD8bL"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ba70a0ed75so1458689eaf.1
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800485; x=1718405285; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZvEoY+n75WD/XlJn9EJtDiTKiZa2BG0t/Ag91b9Sbk=;
        b=AWyHD8bLtPtnzgtD7zgo6DT6Q1mnN9s7VjJ9upapH7jDjedEa2U6TEf9ssOKrBwEJ1
         upBtFq/eXj+gnxSY9ruo8BZ1j1KhWPAqvEUJDDnhJSNMQBasVP9X7vcveFbYMfV+vxtX
         asEB9KEmRizQHHHxVoz+MZqVTUt5YfSrO/gEFfyDean2z9gZFuZVbf8BtGzJQa2AFfZt
         68jYph0Uy/BhmLohx/CQ3b+wB3xPFn1w9YaJLH1o0VBXV5i+0gf1xJZzxltfKhlQ7BQ4
         dkOWSymfAxNKBIhJm0e054ZlquxE0v9uJl2It2oNtlsC7fHNTjrRyQ37nGmJqZ1APIMr
         JRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800485; x=1718405285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZvEoY+n75WD/XlJn9EJtDiTKiZa2BG0t/Ag91b9Sbk=;
        b=YRKbSDJEMP8YI+PEWTcQC36eXo4Nvc0MR2HJDIUAW2tOoda/M42xeGZpOE2FB5W6E3
         ds4htz7iihesxDHy6sRBRZ/rHEdO2UFeB1SSuADkc8NS+lgldWGcQNIyRCRe3+2T+Q9N
         ib/TNPRXkw/ySouK1Vs+oQ+e/4sEDsNbxmWU1RV/2MAskpYWc/SRJVlRrr51v3cBRhRb
         bOKLxOe9Z4jTsnX/ikx+EI69vJjRZRdaSH5T9GDDO6CPr9Q7ZbaIouFH3jlB8UGvE8iO
         KW5ec1fS8I9GpftjoO7VBX668EZQMPXFLdqA801ej3eOX65L7CvgVdOJ6R2ecmzG5/x4
         vnhw==
X-Gm-Message-State: AOJu0YzqqxFQw+XKR1l242B/vufAFhVqYxMy3DhpY8mujE4LsJnFI1Xa
	6Up6Icrb4gorilV4aTQOtGulLOcFET9KpeH+bAlfYPl9X0Id+Saeo1JzmA==
X-Google-Smtp-Source: AGHT+IHkApbhOW9QoSolpweObX711tJdPPcwwDYDfGE7kYTGjq8pwI8mIY5XJK8qGmTUKZTfQQaq0g==
X-Received: by 2002:a05:6820:1609:b0:5b2:f2e5:a8c8 with SMTP id 006d021491bc7-5baae8c3542mr5040349eaf.8.1717800484793;
        Fri, 07 Jun 2024 15:48:04 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:48:04 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 20/23] qmi: gprs-context: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:20 -0500
Message-ID: <20240607224746.903769-20-denkenz@gmail.com>
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
index 0e5e6badabd6..8d537b85d8d9 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -763,7 +763,7 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 		interface = ofono_modem_get_string(modem, "NetworkInterface");
 
 		gc = ofono_gprs_context_create(modem, 0, "qmimodem",
-							data->device);
+						qmi_service_clone(data->wds));
 		if (!gc) {
 			ofono_warn("Unable to create gprs-context for: %s",
 					ofono_modem_get_path(modem));
@@ -789,7 +789,7 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 		mux_id = ofono_modem_get_integer(modem, buf);
 
 		gc = ofono_gprs_context_create(modem, mux_id, "qmimodem",
-							data->device);
+						qmi_service_clone(data->wds));
 
 		if (!gc) {
 			ofono_warn("gprs-context creation failed for [%d] %s",
-- 
2.45.0

