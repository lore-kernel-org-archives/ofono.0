Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7EB1649CF
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596709; cv=none; b=PcGr3tmcgW4td3jBwFQHidn6sfsjtd90WlnoWjuIrMlPdltoVE+yrUXJUL6rtidhsAAFPq07yKDsXLCHJpSwteXBs7pz+I9pAOFzNrWWgzzbp7fbNY9Q0bIxR+WuXptYi6jk90lo4Ru+FhgX4It8iUdXPHewoaiBitC2XbmZWHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596709; c=relaxed/simple;
	bh=sdIHL4pkY+21nw20w162O+jALIari5/M9hiCYEvfZME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFs0DVeLjTat1l1orJYQbS1jsZBH9lAGhvyngWAMeRr0NMA8cHl3bPasFe00VPmPALOoJM7IxW1iQxKczmvE6UMt5rquZNdOhKxIEAXHb7x8twkfuS33P0ZTdpSZVCohcPKKDx16V1PlIHxCjN4ccfdpCUajCR/A5ZCvuaY9gWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUDwtNJn; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUDwtNJn"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ac8c73cf88so4552346eaf.2
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596707; x=1715201507; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjqP/j6PnixFFFnqp9f/ygGDoivkA9vgewsqaqO5wkQ=;
        b=UUDwtNJn1KHa3TtW0TA+TBS3RvxcdVVpIOoR5HvHCzglKWRN80a8QLkilMfSRDlAoJ
         28iXHNDyX0Zd1eK94TM0Tqofs2ZHLX7bXfyyx0i2bf15HpbSYJ9jsIcDi4FBDIzQ6C8g
         UXx58aqiDEePWT833PrH6bL4uTgGfQotiG3mGfTHawR3UD1mgSsRHMM8eNEtszBG2zj8
         yK1+g+U83hOg2C7gwavteR9eOu0iR26CVxEKFuJm4lUvtvQs7hfjXMlLC8QuteyCRPKo
         Y5ioxm2Rf58rZAKhm303MOqfTFG9AM86NhuRADtel/jnBsnhvvZRzarH/bP1bsYYqh+q
         xlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596707; x=1715201507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjqP/j6PnixFFFnqp9f/ygGDoivkA9vgewsqaqO5wkQ=;
        b=obb9rqFEmJF61zh8w2LAcI9HYtIlug89mleZtPjAxr8Owb2ZDblepMwvdtJ3FMo8Vb
         QMqPQSmnlWI6UAMeTbDNyeritaIHRp4c90c2sNTWBB7QAmnYdgdLyAR28zeWGx0F/uiW
         mi60OKELr1RRFZu9E/MI7w+ioWOkhuXKFk8c9F9Us4Y+WpTRmzTvttE7BmmAShQ9MJ0H
         Ky8+pxvsjNsl4dBUBZOU8O+i4vMDFHPYzTDIQDwKtRTA0Dl+E8J/a241AjLbW0Lk2DpY
         aeWdF7IN76+ow3PRiO8XDmXEWS9/n2uqkgjcKbk1JRpRcwYwOAP1YRRV8p6U384FaS45
         rIGw==
X-Gm-Message-State: AOJu0Yy35vhk1Ci/WcB+SCvXU4zseM6JKvWhJjOp1YcGl70Y5j2PoD8n
	44gquVxd5GKtdYGMqK8WKe1szwICqznW/2A3CIEP40R1kWcscTP9CAQvbA==
X-Google-Smtp-Source: AGHT+IG1VgtWEcRAx+39SUOH4KzTN7MsUVr9SdSnLZev4Y0FRhPbYByj1zVpABXKatwH7v+eaBM0nA==
X-Received: by 2002:a05:6870:b153:b0:23c:58bb:be68 with SMTP id a19-20020a056870b15300b0023c58bbbe68mr4089700oal.6.1714596707570;
        Wed, 01 May 2024 13:51:47 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id or3-20020a0568715c0300b00234bc052521sm5883658oac.10.2024.05.01.13.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:51:47 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/6] qmi: gprs: Register for other notifications
Date: Wed,  1 May 2024 15:51:25 -0500
Message-ID: <20240501205142.12777-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501205142.12777-1-denkenz@gmail.com>
References: <20240501205142.12777-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register for additional notifications via Indication Register command.
---
 drivers/qmimodem/gprs.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index aac28db387bb..8329f56a2ba8 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -191,6 +191,13 @@ static void event_report_notify(struct qmi_result *result, void *user_data)
 	qmi_result_print_tlvs(result);
 }
 
+static void profile_changed_notify(struct qmi_result *result, void *user_data)
+{
+	DBG("");
+
+	qmi_result_print_tlvs(result);
+}
+
 static void attach_detach_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd = user_data;
@@ -282,7 +289,7 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 	l_free(cbd);
 }
 
-static void set_event_report_cb(struct qmi_result *result, void *user_data)
+static void indication_register_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_gprs *gprs = user_data;
 	struct gprs_data *data = ofono_gprs_get_data(gprs);
@@ -308,6 +315,41 @@ error:
 	ofono_gprs_remove(gprs);
 }
 
+static int indication_register_request(struct ofono_gprs *gprs)
+{
+	static const uint8_t PARAM_PROFILE_CHANGES = 0x19;
+
+	struct gprs_data *data = ofono_gprs_get_data(gprs);
+	struct qmi_param *param = qmi_param_new();
+
+	qmi_param_append_uint8(param, PARAM_PROFILE_CHANGES, 1);
+
+	if (qmi_service_send(data->wds, QMI_WDS_INDICATION_REGISTER,
+				param, indication_register_cb, gprs, NULL) > 0)
+		return 0;
+
+	qmi_param_free(param);
+	return -EIO;
+}
+
+static void set_event_report_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_gprs *gprs = user_data;
+	uint16_t error;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		ofono_error("Get default profile error: %hd", error);
+		goto error;
+	}
+
+	if (indication_register_request(gprs) >= 0)
+		return;
+error:
+	ofono_gprs_remove(gprs);
+}
+
 static int set_event_report_request(struct ofono_gprs *gprs)
 {
 	static const uint8_t PARAM_CHANNEL_RATE = 0x10;
@@ -423,6 +465,8 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 	data->wds = service;
 	qmi_service_register(data->wds, QMI_WDS_EVENT_REPORT,
 				event_report_notify, gprs, NULL);
+	qmi_service_register(data->wds, QMI_WDS_PROFILE_CHANGED,
+				profile_changed_notify, gprs, NULL);
 
 	if (get_default_profile_number_request(gprs) >= 0)
 		return;
-- 
2.44.0

