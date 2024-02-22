Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00D76E5F0
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633011; cv=none; b=lU9ixyiTJ5s7ORT7cv0zeEzvqJJaC1Mwsl3nAGWR/Ouh8U27GDbxCRARL2CcKnei1tVmT9Ob7dICC9YJyDNG+XzsXTrnepGcjAsMtK2YpC2iuo2bVnBchahnEFOtcv9FsdibKMYaYVCGaDhtHOpAkNLkShlEL/3MjWigtDKDlEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633011; c=relaxed/simple;
	bh=F/nEQB0Db8+LnqI1Ce14NlCCo9Gy/giN/SNp3ViBnLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkZTmIHoYdlNpQDZaelFLGyhuT8rtF4qVdIsLopelLwraBEwwEPB58up8E4rH6xSy0SBDt+YscuOgNt66OGH4tKq1e//ez7H9ppEOwnu0CsALb2vmHTiTZBR0QWWzA+oaVnZRi+97jH4KEacCLO01eWW3b3DELhqqyMNQFA4ktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwuAtwjA; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwuAtwjA"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a03417ec1bso105828eaf.0
        for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 12:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708633009; x=1709237809; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KhIswsVx0V1NVFMBzAZCkWObR/s7cESrjTLV1NlC+k=;
        b=LwuAtwjAf5fYL903iMYnAImFa9APnJeGKj/oCLBrAqCAXdlJEWkNAOSPq1f717yHqi
         oNKTzwFyO8yEdyGfZuI58uMVSfqsgRpM1HtiE13OrFepzwUFHNEVxGHOdaJrTSMSfBPO
         misfhzw1Ho6on0wdhRXxUpHui/ymBE19fHMJ7xeXPvZLO9Imh04afdc5Rq4nAwxTsWbq
         bslcEV308TJ2RdYwqHfadz0/T/5S4tvrtfpZG/S5yxit2kyI53TAhvHayMXAqQmVUbNp
         CGG+EkirB/FVuffLoUjbAbYQwnKILrPpo1Z/2HzoV/Rr8BKq99nrR9gMRtBn3430YknR
         t3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633009; x=1709237809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KhIswsVx0V1NVFMBzAZCkWObR/s7cESrjTLV1NlC+k=;
        b=eKrCt/8SsFVN3BklNb1Qk5SSxWpsuXObj5yl8OdKDH0zIYzdnv6A9bu3IU1CxtbJpP
         so0b55I1N70s2vZJD1P5VWNEKIQRnHLwOYoUoVKXAYi+QjDS8LbAwMTFTLWtiSnPs4TP
         AMd+nQo9MhPX6sFjoaDRLFDPP1Blm72JVVIBWujiMFRDlW8l1leMNoT1Z8g2AGxSgorW
         he7oAFcgcyCnfQ00ZTtqZqdIasiRwKhOWHdEYeLO4LsEyyUV6vZpubZSL8QSnknCFXuF
         qlXk5QMTuZWdpIvBOYdpl8OFUm4/ZP4DGFV9qoR2mY+FPLSoONCvKcpxYjtSBLhoXmM6
         /m5A==
X-Gm-Message-State: AOJu0Yz2e8fzAvD8fS1OAB0+/vFaiM89MycxR00FRiApL73MZq+YVn4/
	mDCk7ZPgcgmho5XSWuH0zA69Sa3JuqxZPH6YlfyU8llTkbPPz/NymJJm7gcv
X-Google-Smtp-Source: AGHT+IGGyWeh50NOAC2cUDC3+sy1iQxYCh4N9R7ji9Yhbr9CAuWI/zkCpH9VNlw0OtyVwvCpZQAajw==
X-Received: by 2002:a4a:851c:0:b0:59f:fc2d:8179 with SMTP id k28-20020a4a851c000000b0059ffc2d8179mr12752ooh.9.1708633008799;
        Thu, 22 Feb 2024 12:16:48 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id k1-20020a4a9101000000b0059a14309a29sm2472353oog.16.2024.02.22.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:16:48 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/4] qmimodem: Fail early if discovery already complete
Date: Thu, 22 Feb 2024 14:15:44 -0600
Message-ID: <20240222201559.1293947-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222201559.1293947-1-denkenz@gmail.com>
References: <20240222201559.1293947-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If discovery has been completed successfully, tell the caller right away
by returning a -EALREADY return code instead of scheduling for the
discover callback to be invoked via the idle callback.  Such logic has
no real effect as the underlying CTL service is not queried again.
---
 drivers/qmimodem/qmi.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2a6e79efeed2..268db1f76cc5 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1095,7 +1095,6 @@ struct discover_data {
 	qmi_destroy_func_t destroy;
 	uint16_t tid;
 	struct l_timeout *timeout;
-	struct l_idle *idle;
 };
 
 static void discover_data_free(void *user_data)
@@ -1105,9 +1104,6 @@ static void discover_data_free(void *user_data)
 	if (data->timeout)
 		l_timeout_remove(data->timeout);
 
-	if (data->idle)
-		l_idle_remove(data->idle);
-
 	if (data->destroy)
 		data->destroy(data->user_data);
 
@@ -1524,20 +1520,6 @@ done:
 	__qmi_device_discovery_complete(data->device, &data->super);
 }
 
-static void qmux_discover_reply_idle(struct l_idle *idle, void *user_data)
-{
-	struct discover_data *data = user_data;
-	struct qmi_device *device = data->device;
-
-	l_idle_remove(data->idle);
-	data->idle = NULL;
-
-	if (data->func)
-		data->func(data->user_data);
-
-	__qmi_device_discovery_complete(device, &data->super);
-}
-
 static void qmux_discover_reply_timeout(struct l_timeout *timeout,
 							void *user_data)
 {
@@ -1570,6 +1552,9 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 
 	__debug_device(device, "device %p discover", device);
 
+	if (device->version_list)
+		return -EALREADY;
+
 	data = l_new(struct discover_data, 1);
 
 	data->super.destroy = discover_data_free;
@@ -1578,12 +1563,6 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	if (device->version_list) {
-		data->idle = l_idle_create(qmux_discover_reply_idle, data, NULL);
-		__qmi_device_discovery_started(device, &data->super);
-		return 0;
-	}
-
 	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, qmux_discover_callback, data);
-- 
2.43.0

