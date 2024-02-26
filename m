Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862D12B145
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961706; cv=none; b=Wnsm82hcK9kpdnQTHJo14seR4uxYANQKL752pk+gb2Zld6wYWsjJ2r/hEvCVTLMlvqBTqnklHuWdL4jey7MB7X1UmN9xQezYecBMhaOempUBEgTIEAswy724O0X2hCbU+VmCRwIfLx5WY8HGY1/dJG4nT9FzZYwPm4ZEP3Jy9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961706; c=relaxed/simple;
	bh=bOLefyq4VsPxX2+Fzh2TMs7+zXfBrA3IZKlnTBDZKw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6ErrQAKxAb/AYbnBfsQnkxto/lhtQzV3LqtNJb0dyJLXDsvtj7gTmpyKpkPPG5yhcXGuTHtbTeaxzsgWwpjlcbt4fbMzWxdJyYc+ar1woALW8IWSsN2TIJYba716x7/fLou2bjzHo9+SNmNaQ3MMWKvFqdLDGfflMi4VymjajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djeRJDkH; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djeRJDkH"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e49872f576so664109a34.1
        for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961704; x=1709566504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wXErfSU1dvEl7jqeJK3F4EXaY2fMsk/4RCro+WDqhU=;
        b=djeRJDkHDqcmlZ5/3EH694iRzRl006cdcmXcOcxnOgQPPmUaasEiv6V14HzNOst3ka
         F61PXnXtkG+LPz9vVR1GVghBM4aGvIN4iLsJGOga7xv66rnO/HobzBmIWHhW0Rv+V6/r
         iTArNQIPpUG4/Q1VG/MkJ/LgJQJroVIHEawy6vHTXNNL5ir27q/kUjz5V1E3gaY1oc2s
         CWJSaLr1ymlRBcUrYvszzJ4GrFNxiWKMmL0pgA9cP0eVJU47dBf1plIjjdw5jH003hvb
         liaKKFQBVh6NrmbQIJMcGzyFoeb3AuVOaOyxjGuMViRUARsBfHjwUFus7O+LgNjVnKZq
         ZYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961704; x=1709566504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wXErfSU1dvEl7jqeJK3F4EXaY2fMsk/4RCro+WDqhU=;
        b=HoUtcKfJ4Woh5SoE6pmmEUtJe5wtv89BKtcXSnSmKgKF89ev6kzPmJKdvz5kyA8DgU
         0TKfXnM6y+BFY4sPlfVWapGhxG/SbhH0AcKg0X+P2S3BAJQ0UPOdhFF9wnhvO047oN3s
         sq1MrTPaOYq9m1AWe/E6D0npsWzugHY5uu5Xwj+jsLNsrC9Q3XTYPk2dUM2sjtbUbTM6
         J58AbjQLpw27I0wRyncpcMuiTDkfKfewXGB2jYKdZLz/tCICfYiU3SqWThhrB9caXxce
         eQTyj2vG5a7UorNVH/Vedu/lgUAFgVtdw1nenRkPmMPdhm1bb5m5FnawR/pAhuOe2Q9Y
         WZAw==
X-Gm-Message-State: AOJu0Yxj3wtexqAUwRhFaH1f6A5TMRMmuq6zXgozgdEeeck+Hzu/xyji
	gDDJg4OEXGxXAZM8I06RQeE3L6D1l536WqG/POOGNBqgOPZ1Oni27mobpqVW
X-Google-Smtp-Source: AGHT+IHgbpeQ6GFn92HH4fsN6cQz4lZ4jGCpvRpHMMi7q8mMSgAHasJM7tSb8yAnsVB2Nt8hFihmFw==
X-Received: by 2002:a05:6870:b61c:b0:21e:635c:a5b9 with SMTP id cm28-20020a056870b61c00b0021e635ca5b9mr8385758oab.52.1708961703563;
        Mon, 26 Feb 2024 07:35:03 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eg14-20020a056870988e00b002201144306csm567048oab.53.2024.02.26.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:35:03 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/8] qmi: Move and rename QMUX sync logic
Date: Mon, 26 Feb 2024 09:34:22 -0600
Message-ID: <20240226153459.1463304-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226153459.1463304-1-denkenz@gmail.com>
References: <20240226153459.1463304-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This logic is QMUX only, move it to be spatially near the rest of QMUX
specific logic and just above where these functions are used.
---
 drivers/qmimodem/qmi.c | 58 +++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index be6f6f7bd601..b08c1642c8c1 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1079,34 +1079,6 @@ static void discover_data_free(void *user_data)
 	l_free(data);
 }
 
-static void qmi_device_sync_callback(uint16_t message, uint16_t length,
-					const void *buffer, void *user_data)
-{
-	struct discover_data *data = user_data;
-
-	if (data->func)
-		data->func(data->user_data);
-
-	__qmi_device_discovery_complete(data->device, &data->super);
-}
-
-/* sync will release all previous clients */
-static bool qmi_device_sync(struct qmi_device *device,
-				struct discover_data *data)
-{
-	struct qmi_request *req;
-
-	__debug_device(device, "Sending sync to reset QMI");
-
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-				QMI_CTL_SYNC, NULL, 0,
-				qmi_device_sync_callback, data);
-
-	__request_submit(device, req);
-
-	return true;
-}
-
 int qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
@@ -1402,6 +1374,34 @@ static struct qmi_request *find_control_request(struct qmi_device *device,
 	return req;
 }
 
+static void qmux_sync_callback(uint16_t message, uint16_t length,
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
+static bool qmi_device_qmux_sync(struct qmi_device *device,
+					struct discover_data *data)
+{
+	struct qmi_request *req;
+
+	__debug_device(device, "Sending sync to reset QMI");
+
+	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+				QMI_CTL_SYNC, NULL, 0,
+				qmux_sync_callback, data);
+
+	__request_submit(device, req);
+
+	return true;
+}
+
 static void qmux_discover_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
@@ -1479,7 +1479,7 @@ done:
 	/* if the device support the QMI call SYNC over the CTL interface */
 	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
 			qmux->control_major > 1) {
-		qmi_device_sync(data->device, data);
+		qmi_device_qmux_sync(data->device, data);
 		return;
 	}
 
-- 
2.43.0

