Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565A8173B
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532667; cv=none; b=V7OGknlHud9ERQtFfu5BNsfGZoxFjPUlQJ5R3wzXIsEMLqQw8NXgllDRMDCfUgwtiZcpUJZWiQIEoQ6EcWAGayujuKteOVI98DwDpCviPwvFREEVQIDSoQd5uFm5/AciA1B5aXW0b7o2mZ0f6HfYeAH6Uh85xjm+6IcAxmOoD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532667; c=relaxed/simple;
	bh=xNjM/igVeN3x+ZxzOHSrh+oNrV9Qm+i5zT1fmzVqhS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn3Qs7p0wmWKwiwi2dbz7ztUsJ1HaVivCEKP8g0qD6CHV44SA2IN9nXymzDAJHoE4VGaaLIFAH772Ia2mG6sK8UWwkS7ixSNc+5FTYMuVcHyZzYf96yr2/MKiblSrYjdrhd1YPPJMqSgkj15b4UK6+FF67snwWdd64fVpU5ob7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkYEIyOw; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkYEIyOw"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59fd69bab3bso1064573eaf.2
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 08:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708532664; x=1709137464; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mxtq5LsFZH6DVoNunk8fO4WiGLMQXCj2SSNN5aqRy6c=;
        b=UkYEIyOwtX0g0QO3kpvESK70h0frnF1lkJtQcST7CiByitYiGSq+EjsMDp0LCoeOrZ
         cqeiUUhzCNI7nm7LukoTFXBYupoRSkzzQguN1UB3SujuFXP8PcKyaKeH9jLeF5YTEzPY
         rW4TDSWcClO+elDNjKrsJuKjQAWtijk8UuhfHbsV2UOKKxpmcIN+4JsbS/ESv9OR85i0
         irlS2eJ9rl53wyaTqPcZwGtTh17eNcq1nJEtYRkkBetmwUUZAIwkOekBgkGqIXoJTMnU
         57eoN75rYOxJtMegzkfeVri3sPJKIRlsqSc8AZ2B7P42BURmK2rPHCGx34eQDsRQ1LvE
         7tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532664; x=1709137464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mxtq5LsFZH6DVoNunk8fO4WiGLMQXCj2SSNN5aqRy6c=;
        b=wmLgQ/Z1nkP6Yg46DspX2LuSk3YSWOIw4/pMDhjMzw8fL8YEQXh4J0jP8etLlxicCr
         H+0/nkN951sw8eOsXc+q0IEkzKmlzeXjp7JEaLXDfHwOmXKzQ44O4S1HMdGESQyk8arP
         z1s4rPHmmVV9aiou0HWi18ZfiX0/dj6KY7E2LODuz7325KtnVimQaxx8emNlgk1il4Jr
         utFihv7BAdd9EFGQaxq5y3Z0sJqlGO1n5FEAEkd4b6K+WLX0PP+FLLRvd73fmNy+tzDu
         2NLsgMo1G0B7+Cz+gLQ+AlQK9TVCNtj+8kwTcRh7qHvM5fst6h21TJGwg1w4RWf7wAC8
         o/8g==
X-Gm-Message-State: AOJu0YzRsfZB4XFtbjHjVWhl34Zacl7dpSnSi76Xb7lnSGDNZ8Ppcj9q
	jNreKYXJDW/OXXsQq9NsmQRuJ3jZNljUsFrVM1gNLad01XsCALlvHnQSevSg
X-Google-Smtp-Source: AGHT+IFsdeaTxeELtF3Tx22VkLWCqKW7q7UYQ8D9W0OkL9e8fYgPuUQVtdSVNgaXfi8mNySmb4XWaA==
X-Received: by 2002:a4a:d5cf:0:b0:59f:f90d:49f0 with SMTP id a15-20020a4ad5cf000000b0059ff90d49f0mr5284258oot.2.1708532664631;
        Wed, 21 Feb 2024 08:24:24 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j25-20020a4a92d9000000b00594ee4b4339sm1905405ooh.28.2024.02.21.08.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:24:24 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 4/7] qmi: Move control_{major|minor} to qmux sublcass
Date: Wed, 21 Feb 2024 10:23:17 -0600
Message-ID: <20240221162335.1258315-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221162335.1258315-1-denkenz@gmail.com>
References: <20240221162335.1258315-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the following members to the qmux subclass:
	- control_major
	- control_minor
---
 drivers/qmimodem/qmi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 07af29b42b36..08adb0f5fe02 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -73,8 +73,6 @@ struct qmi_device {
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
 	void *debug_data;
-	uint16_t control_major;
-	uint16_t control_minor;
 	char *version_str;
 	struct qmi_version *version_list;
 	uint8_t version_count;
@@ -91,6 +89,8 @@ struct qmi_device {
 
 struct qmi_device_qmux {
 	struct qmi_device super;
+	uint16_t control_major;
+	uint16_t control_minor;
 };
 
 struct qmi_service {
@@ -1151,6 +1151,8 @@ static void discover_callback(uint16_t message, uint16_t length,
 {
 	struct discover_data *data = user_data;
 	struct qmi_device *device = data->device;
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
 	const struct qmi_result_code *result_code;
 	const struct qmi_service_list *service_list;
 	const void *ptr;
@@ -1194,8 +1196,8 @@ static void discover_callback(uint16_t message, uint16_t length,
 					type, major, minor);
 
 		if (type == QMI_SERVICE_CONTROL) {
-			device->control_major = major;
-			device->control_minor = minor;
+			qmux->control_major = major;
+			qmux->control_minor = minor;
 			continue;
 		}
 
@@ -1218,8 +1220,8 @@ done:
 	device->version_count = count;
 
 	/* if the device support the QMI call SYNC over the CTL interface */
-	if ((device->control_major == 1 && device->control_minor >= 5) ||
-			device->control_major > 1) {
+	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
+			qmux->control_major > 1) {
 		qmi_device_sync(data->device, data);
 		return;
 	}
-- 
2.43.0

