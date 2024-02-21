Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785078173B
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532665; cv=none; b=Wx1mMSHV7fkv/Eh+/t8iOUKCJYsRI7oPce2bXHU7xO9GJnRqVebDIQQBuejes00P93LxRbeHkPk6IOwLSEIbyfmkw3scQZZsp8YecXRv57Sl/4raP/0Dnk5i+mrEzZKsmHlhJbmqHr5Cgga8LuAI0tl8ELA4WwXycmJpUcpJC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532665; c=relaxed/simple;
	bh=kivg5ioRpPoB6Q3zwKIiGBmbtqRFbz7g2p7u/CR1BpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RytHiMXuZ2hF/rTi+lVn5TQb+XWBxr9JMNNrY/z1Akd5OXX2mqST8BTjBLMfDIU+nomKzIHfwrCJm9UgImLSD/KSD5HMxweoD6+WgPHY7K02Zb6UE+yYrLF1HYg/LDNmMIX/BGrkgV73jJDF3X6JefiIBbk5tWgFIEKOafmBlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7ODQd9C; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7ODQd9C"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59caf51d4bcso1891662eaf.1
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 08:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708532662; x=1709137462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=todh5DbDRtY6KXXkul1NOZ/bnm1sfdin6FSUpI43Feo=;
        b=P7ODQd9CjorLxyWucUIoUy08XoE+EmnxTDbioFiDsK/Rw10c75nDePUKLIZ/UXlNvH
         WLO7tXA/ZystTqv5Vs7kYLcKnSAz1gKyUdnwuLWHphArCxgd5GU0UjUxiZKvf9jeP9KC
         Jxfy1ZEtrg1XBClYHWx3t307tw/XhduSJbUAxZs8dxRrnHatjbe79pitipUv13zYg3W4
         l+igss64LWPUOQ2DVZEyKdlmlKSxM/5JhgdfJ7uSVq4W4dJBoojK9cOPcMT8oaegSKLy
         jUw2GgyBTjpsCrlF449n7Fj2+6Fd22lV6EjFBe7BTV78xhw4b8pYZ2ldPOthZwDCgrpL
         VFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532662; x=1709137462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=todh5DbDRtY6KXXkul1NOZ/bnm1sfdin6FSUpI43Feo=;
        b=v9PWwqsvh5YpRu7Ig+4wclvRFUdj80dI4fdLtn8OUSnKBPva4uMTne1EbgnpazkeP4
         EFVFJPIE59pj075KbAUrxra/sfWXrHpst+2W35V/vQuRJJ+zmVwAYF4TbSZPA3uMT1RM
         yFySn7Soed4Na4oHt/ZifA2N20yxvVOqOs/RXR9XGgWcZUsGy/uHHJYscKReMhd6cM8R
         NYJaPldTdTcHsouhzRqbvi9IdqVaQSJL+HAizViXYvanBd7PHoq44yi4Wy7+DcUO7/uj
         zeZGCyYOdzqICWJX7K0ua+5xk4SGFRbjgBBJ+9/Zl8HwSjNxQuXO/KIn4XkLyZ2wzgd5
         XNmQ==
X-Gm-Message-State: AOJu0Yx5DMenEBD/69yOglYXxzSGNBKLEFWmw9W5P4Cl8CVE+6JEPWhH
	3h+e2c46Xd3PMivpym+X+DN1Y1H5+rLERkiMuLImk/tX2O405aeklL/TNulw
X-Google-Smtp-Source: AGHT+IEjPEsP9dRBpu816M+nR3QNw9KT0qNR2G3OPO5i04COhN3kLB9MS7DTeLhhFmhKAL736xJQ6g==
X-Received: by 2002:a4a:d2d3:0:b0:5a0:19e8:dd9e with SMTP id j19-20020a4ad2d3000000b005a019e8dd9emr729051oos.2.1708532662302;
        Wed, 21 Feb 2024 08:24:22 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j25-20020a4a92d9000000b00594ee4b4339sm1905405ooh.28.2024.02.21.08.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:24:22 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 1/7] qmi: Remove qmi_device_sync
Date: Wed, 21 Feb 2024 10:23:14 -0600
Message-ID: <20240221162335.1258315-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an implementation detail of the QMUX/CTL interface.  Since the
only caller always invokes SYNC after discovery if supported, simplify
the SYNC operation to be part of the discovery procedure and remove the
relevant APIs from qmi_device.
---
 drivers/qmimodem/qmi.c | 89 +++++++++++++++++-------------------------
 drivers/qmimodem/qmi.h |  5 ---
 plugins/gobi.c         | 10 ++---
 3 files changed, 39 insertions(+), 65 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 30c396035593..768fcf12f1eb 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1038,7 +1038,6 @@ void qmi_result_print_tlvs(struct qmi_result *result)
 	}
 }
 
-
 static const void *tlv_get(const void *data, uint16_t size,
 					uint8_t type, uint16_t *length)
 {
@@ -1122,6 +1121,35 @@ static void discover_data_free(gpointer user_data)
 	l_free(data);
 }
 
+static void qmi_device_sync_callback(uint16_t message, uint16_t length,
+					const void *buffer, void *user_data)
+{
+	struct discover_data *data = user_data;
+
+	if (data->func)
+		data->func(data->user_data);
+
+	__qmi_device_discovery_complete(data->device, &data->super);
+}
+
+/* sync will release all previous clients */
+static bool qmi_device_sync(struct qmi_device *device,
+				struct discover_data *data)
+{
+	struct qmi_request *req;
+
+	__debug_device(device, "Sending sync to reset QMI");
+
+	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+				QMI_CTL_SYNC, NULL, 0,
+				qmi_device_sync_callback, data);
+
+	__request_submit(device, req);
+
+	return true;
+}
+
+
 static void discover_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
@@ -1193,6 +1221,13 @@ done:
 	device->version_list = list;
 	device->version_count = count;
 
+	/* if the device support the QMI call SYNC over the CTL interface */
+	if ((device->control_major == 1 && device->control_minor >= 5) ||
+			device->control_major > 1) {
+		qmi_device_sync(data->device, data);
+		return;
+	}
+
 	if (data->func)
 		data->func(data->user_data);
 
@@ -1352,58 +1387,6 @@ bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 	return true;
 }
 
-struct sync_data {
-	qmi_sync_func_t func;
-	void *user_data;
-};
-
-static void qmi_device_sync_callback(uint16_t message, uint16_t length,
-				     const void *buffer, void *user_data)
-{
-	struct sync_data *data = user_data;
-
-	if (data->func)
-		data->func(data->user_data);
-
-	l_free(data);
-}
-
-/* sync will release all previous clients */
-bool qmi_device_sync(struct qmi_device *device,
-		     qmi_sync_func_t func, void *user_data)
-{
-	struct qmi_request *req;
-	struct sync_data *func_data;
-
-	if (!device)
-		return false;
-
-	__debug_device(device, "Sending sync to reset QMI");
-
-	func_data = l_new(struct sync_data, 1);
-	func_data->func = func;
-	func_data->user_data = user_data;
-
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_SYNC,
-			NULL, 0,
-			qmi_device_sync_callback, func_data);
-
-	__request_submit(device, req);
-
-	return true;
-}
-
-/* if the device support the QMI call SYNC over the CTL interface */
-bool qmi_device_is_sync_supported(struct qmi_device *device)
-{
-	if (device == NULL)
-		return false;
-
-	return (device->control_major > 1 ||
-		(device->control_major == 1 && device->control_minor >= 5));
-}
-
 static bool get_device_file_name(struct qmi_device *device,
 					char *file_name, int size)
 {
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 21537a76c64e..fc2a309578c4 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -78,7 +78,6 @@ typedef void (*qmi_destroy_func_t)(void *user_data);
 struct qmi_device;
 
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
-typedef void (*qmi_sync_func_t)(void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(void *user_data);
 
@@ -101,10 +100,6 @@ bool qmi_device_has_service(struct qmi_device *device, uint16_t type);
 bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
 					uint16_t *major, uint16_t *minor);
 
-bool qmi_device_sync(struct qmi_device *device,
-		     qmi_sync_func_t func, void *user_data);
-bool qmi_device_is_sync_supported(struct qmi_device *device);
-
 enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 						struct qmi_device *device);
 bool qmi_device_set_expected_data_format(struct qmi_device *device,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 76c9d68d2df5..020d6ba2685e 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -364,13 +364,12 @@ error:
 	shutdown_device(modem);
 }
 
-static void create_shared_dms(void *user_data)
+static void create_shared_dms(struct ofono_modem *modem)
 {
-	struct ofono_modem *modem = user_data;
 	struct gobi_data *data = ofono_modem_get_data(modem);
 
 	qmi_service_create_shared(data->device, QMI_SERVICE_DMS,
-				  create_dms_cb, modem, NULL);
+						create_dms_cb, modem, NULL);
 }
 
 static void discover_cb(void *user_data)
@@ -417,10 +416,7 @@ static void discover_cb(void *user_data)
 		return;
 	}
 
-	if (qmi_device_is_sync_supported(data->device))
-		qmi_device_sync(data->device, create_shared_dms, modem);
-	else
-		create_shared_dms(modem);
+	create_shared_dms(modem);
 }
 
 static int gobi_enable(struct ofono_modem *modem)
-- 
2.43.0

