Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA601468E0
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468926; cv=none; b=RgUFLguAllGbjzDOjvDLLsW/BSZe0/TodinTwVn05xc2wNGbg0+nkXuTMUGNaUNWoemc5yp/nC1V9Ci917VF4C6FToCnQyf3dQOw8dKr6ZSssoFcxl9u9NnqZOEXjfMZuP38N76T6jJXeICypm3COcSSFMhbfan7JOro/KnqvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468926; c=relaxed/simple;
	bh=if2CZNJ0qIOL5MDsiw3rQ9BRo8SzIdSocUN8j3tfyyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Du92MsbVoPKmZCN5ZS55E5llv2NKNEZpHV5e7a80NNjYX+ukX60AXe88N1tg3BE8rekMEMLxYuTsxHdgkuUHdRnJbR4aM0JZnT0OhOVkiL2BEqxdwwQXeMGn6pgZecVTzWqy+AFHro7LYQaKPQe3Dl39+fbuRJQ0lUVthInfzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZMQHeE4; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZMQHeE4"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-204235d0913so3759458fac.1
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 14:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468923; x=1709073723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y56zb0+xyFv/JiVTwipsKTYobWIQ1w7D+moGGFVJfys=;
        b=SZMQHeE4cA0wq/5Np4P281gsERCoM0OYCODRgkROddpRLPUtT3H3Vqv6yyz6j4h+g3
         vS6uNGqCYxQJGAGOXTccqdNED+G4EfZ7Rrg8TQSEdxYQGZS7XHBuBY62HpC/e2jTi4gF
         Q3ZydPYyv/LJV11zj9Uvn+5SorFPzlBnlhlOQTqWpOCNC3jkZ+gGgLSi+HPRHYrZXp3V
         mY+YS3wTqZKbjekCCq2VJXm5tboINtYEHkhXClC3Hs6XY17WMq3kDKQ0FUZzdbGL8eQu
         9PmmZ52+2SVUEseBLTqs2TQ7BDrR4O7r+CmGsUikZ+K/Hk1Z4tYm5Nf3dDMqisWThA7H
         ctiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468923; x=1709073723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y56zb0+xyFv/JiVTwipsKTYobWIQ1w7D+moGGFVJfys=;
        b=RhOtsewnwsIfGNsk8WAkv2g2g8Pi1uysXywb04jjYJ64KKAJ8cRmRH8eTAkTM+7Mob
         ZTj5mSa5I0zlq5dXVKGs835FxBLTxuy1mkF5SBcuK2XLSStRsP405PhcD8PA32JiloeA
         yDr1ik2UjbJCmdghqRNhTKvCOVSw39SaKjCZbQmS8d2sFp5Vxa1pp6TTw+eFCmEXFHO+
         rF0plRBfDr7GNYCKk9UvmTO8MV12TKWnUInM3p5WLN75qu2bUNF+dFR3v+mP9g8n958r
         GGm3ojiLm9q6Hy/JyAy75M2/m0jYFNXZSRGgFHt8IxqtkbjLx3175bZEmZtOMcoq23rg
         3cEQ==
X-Gm-Message-State: AOJu0YzcjyqtCekDRtOz3SmtYlVyCDan8/O4dD6xvQITir3lHC2d5U5C
	Rt8DiOy+o81G2RVZ7Z4hTJlsO0nV4lEnZXJD83tflZGqYXorYho/sodfmIRb
X-Google-Smtp-Source: AGHT+IEJqqPOVymAJDsMmCVXcbXElwc/249e5iiZ9mRH7YYHp/Fr+kHZJ1cI8WEAJlLvz8i9yqHu1g==
X-Received: by 2002:a05:6870:5588:b0:21e:ddc2:c15b with SMTP id qj8-20020a056870558800b0021eddc2c15bmr7213669oac.14.1708468923181;
        Tue, 20 Feb 2024 14:42:03 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nd15-20020a056871440f00b0021a1492f000sm2056403oab.38.2024.02.20.14.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:42:02 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/7] qmi: Remove qmi_device_sync
Date: Tue, 20 Feb 2024 16:40:54 -0600
Message-ID: <20240220224115.1254853-1-denkenz@gmail.com>
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
 drivers/qmimodem/qmi.c | 88 +++++++++++++++++-------------------------
 drivers/qmimodem/qmi.h |  5 ---
 plugins/gobi.c         | 10 ++---
 3 files changed, 39 insertions(+), 64 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c9c809757427..ee51a7db2368 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1176,6 +1176,35 @@ static void discover_data_free(gpointer user_data)
 	g_free(data);
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
@@ -1249,6 +1278,13 @@ done:
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
 
@@ -1414,58 +1450,6 @@ bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
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
-	g_free(data);
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
-	func_data = g_new0(struct sync_data, 1);
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

