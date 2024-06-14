Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477C81A2C12
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391200; cv=none; b=VEVXv+BWk/vs+/WQZbut7gcXmF+wFtGfPIaSDBc6z49V4b667YR9jzppDG1afIfx+twUqiyLcyYMfzbI334xX2pltueeaDDWQxFcQdysXR8Lzgq6oxUrw1qubjR+xIhmRARJc26C2cjEBtSNPMGhsIkssgxrM/de7G2nzEciWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391200; c=relaxed/simple;
	bh=VzB/c1omH9XA1ThUVtQupOYmQCyr+02h11Mqfw/kLC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWRpp7k8MEtvoOvAiEJ9a/tvMV2g0aH8oyU9LIlq44O7Nkl8X5wwtgPCIj/Mkc2P8DxgofB6AcjZ/+32YUiCZ+kaisU/BVGCU7hCiHB9+987cSXWDHwB4DobCF1uhKZ2iQ8VnAijdO5SdUrpoXQsl88GkfoQOMdG2deba4wUTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5Vmg8si; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5Vmg8si"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f97a4c4588so1418942a34.2
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391198; x=1718995998; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bL74BORxDwFs5wgKMHrIl90ZJbffbgaf2EFTPeePqC0=;
        b=U5Vmg8siMVFcX3g5MFlzwRL6Plk7b0dR0NUgJgRsjqalymMMx/5qLm6lhEszogK9HJ
         j7YSLelqVh+7kwzPxiA+2QzslbrRRlLQUqHwraE2XpM+44bh/r9mZtEROsYRTS9gOiHo
         Ao7IIjJ/fO6K94MoIq+aRvkz3Qa2GNkB7PYZzDQ3kiftvAnxtD9SYeNoNSoCJwl1N6kR
         NpCSqIeG6a5LiRXKwswA9Fd1+ybLDyR1HrsCmkW86FqUFUk5Vs10kH1FzEiSazKM7d3Z
         wFJcOojMRnDUjIiZ0KxkSbrxNzGW7IwebwPpYVdbrRDmhBPiYTpDbxHQms/BKAQ2Uy2B
         jdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391198; x=1718995998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bL74BORxDwFs5wgKMHrIl90ZJbffbgaf2EFTPeePqC0=;
        b=LHsYbxOuSTRJeBjF9xvf5eZht8Wg4F5/SaSOAjnXnQ42loCSHT/xncSMcsvINRjwuR
         l7f8a0ea1ylU07jHykCBBLZe+chXZtI8Tb6ZwKv6bKLwCc47A+8Z88ETCzwodWJCxf4q
         8MWYnPeZl3fvK7gihbhlaKQC53aCGhUSXEeLen4c+tf8ac9rqrT0HPvEYk7LDk3Ap9Ip
         zmYIQ49I89mgk3WRpr2TFFCHFSQLvp0cs7y7EBRznbG1rKBXArs4U2gtN762giYhM+Bw
         W+M7hxSg7Fn2eRAYoFUeSumdsWpcU7iLxTenLx4dSYXas+sNZeS0khdi1pMDa57VTW9d
         Qysw==
X-Gm-Message-State: AOJu0YxX7wnzL5ymHMvFhF7q8HHfyo4Tsn1ymUfaW8NfFQiJTbEb7rk1
	sT02y253YtZvRUNqp2hltSuFad95mQ0et2PB7ZCZ4yH2C6tlpc8G+sarBQ==
X-Google-Smtp-Source: AGHT+IE1EzWkDon2HLlfcW4GaS9O7+1v1uz3GT7BlSYV+xQDOl4k0JUIactn/2gTDYrW7Z8muIdDRg==
X-Received: by 2002:a05:6870:f69f:b0:258:42bd:d916 with SMTP id 586e51a60fabf-25842be0213mr3969438fac.14.1718391197797;
        Fri, 14 Jun 2024 11:53:17 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:17 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 20/27] qmi: split qmi_device_has_service into QRTR and QMUX version
Date: Fri, 14 Jun 2024 13:52:32 -0500
Message-ID: <20240614185300.1086701-20-denkenz@gmail.com>
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

---
 drivers/qmimodem/qmi.c | 13 ++++++++++++-
 drivers/qmimodem/qmi.h |  4 ++--
 plugins/gobi.c         | 14 +++++++-------
 plugins/qrtrqmi.c      | 10 +++++-----
 4 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index f1b2247b4178..f4d32bd702b1 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -988,8 +988,11 @@ bool qmi_qmux_device_get_service_version(struct qmi_device *device,
 	return true;
 }
 
-bool qmi_device_has_service(struct qmi_device *device, uint16_t type)
+bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type)
 {
+	if (!device)
+		return false;
+
 	return __find_service_info_by_type(device, type);
 }
 
@@ -2266,6 +2269,14 @@ done:
 	return service_create(family);
 }
 
+bool qmi_qrtr_node_has_service(struct qmi_device *device, uint16_t type)
+{
+	if (!device)
+		return false;
+
+	return __find_service_info_by_type(device, type);
+}
+
 struct qmi_param *qmi_param_new(void)
 {
 	return l_new(struct qmi_param, 1);
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 68d5cca6d9d2..b255d9b83a3e 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -81,6 +81,7 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 bool qmi_qmux_device_get_service_version(struct qmi_device *device,
 					uint16_t type,
 					uint16_t *major, uint16_t *minor);
+bool qmi_qmux_device_has_service(struct qmi_device *device, uint16_t type);
 
 void qmi_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data);
@@ -90,8 +91,6 @@ int qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
-bool qmi_device_has_service(struct qmi_device *device, uint16_t type);
-
 enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 						struct qmi_device *device);
 bool qmi_device_set_expected_data_format(struct qmi_device *device,
@@ -104,6 +103,7 @@ int qmi_qrtr_node_lookup(struct qmi_device *device,
 			void *user_data, qmi_destroy_func_t destroy);
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
 						uint32_t type);
+bool qmi_qrtr_node_has_service(struct qmi_device *device, uint16_t type);
 
 struct qmi_param;
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 49d3ae2d304e..bb972977ce0a 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -446,19 +446,19 @@ static void discover_cb(void *user_data)
 
 	DBG("");
 
-	if (qmi_device_has_service(data->device, QMI_SERVICE_DMS))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_DMS))
 		data->features |= GOBI_DMS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_NAS))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_NAS))
 		data->features |= GOBI_NAS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_WDS))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_WDS))
 		data->features |= GOBI_WDS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_WDA))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_WDA))
 		data->features |= GOBI_WDA;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_PDS))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_PDS))
 		data->features |= GOBI_PDS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_UIM))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_UIM))
 		data->features |= GOBI_UIM;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_VOICE))
+	if (qmi_qmux_device_has_service(data->device, QMI_SERVICE_VOICE))
 			data->features |= GOBI_VOICE;
 
 	if (qmi_qmux_device_get_service_version(data->device, QMI_SERVICE_WMS,
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 6765f0644e98..d3aee5f4f4ff 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -184,10 +184,10 @@ static void lookup_done(void *user_data)
 
 	DBG("");
 
-	if (!qmi_device_has_service(node, QMI_SERVICE_DMS) ||
-			!qmi_device_has_service(node, QMI_SERVICE_UIM) ||
-			!qmi_device_has_service(node, QMI_SERVICE_WDS) ||
-			!qmi_device_has_service(node, QMI_SERVICE_NAS))
+	if (!qmi_qrtr_node_has_service(node, QMI_SERVICE_DMS) ||
+			!qmi_qrtr_node_has_service(node, QMI_SERVICE_UIM) ||
+			!qmi_qrtr_node_has_service(node, QMI_SERVICE_WDS) ||
+			!qmi_qrtr_node_has_service(node, QMI_SERVICE_NAS))
 		goto error;
 
 	data->dms = qmi_qrtr_node_get_service(node, QMI_SERVICE_DMS);
@@ -323,7 +323,7 @@ static void qrtrqmi_post_sim(struct ofono_modem *modem)
 
 		ofono_sms_create(modem, 0, "qmimodem", wms);
 
-		if (qmi_device_has_service(node, QMI_SERVICE_UIM))
+		if (qmi_qrtr_node_has_service(node, QMI_SERVICE_UIM))
 			mw = ofono_message_waiting_create(modem);
 
 		if (mw)
-- 
2.45.0

