Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA869257D
	for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732352759; cv=none; b=X9llOBXckpFigsYUo3SJzgUiHm787gys9vyVMdkbi+LcSnYbUmu1hejXww8GlCp5UBYn7dvaZ4yHlbtEMJoDGmjF4Ll5SR11C7x/IvOmPFqlBQZQRogg+pfbCrNSXzdnVKg2NF5f1GSPG2JvrV0IZiGvF/weRt3MORk0Chd57y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732352759; c=relaxed/simple;
	bh=SOp+m3G6yP2iu9WujcqytDloyhyAF7KXT9xNr42cMww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jMT5bGJE9o/olgEfThYUJpLC/dd/PA6sIjpw2bNhWuUzif+nNlDursTIP32ZjmUPvt+jLysi/EQ+SP8gkzFHJRi2VuAk5pEmHLttgsA9WULa9H/UocN4KrhsHTM9ZcdQJPdZ3tulN0mXF6Dy/KrHWpBVRkaLJFGKk6Ly2ZbRTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLnNBCrQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLnNBCrQ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-382378f359dso1965695f8f.1
        for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 01:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732352756; x=1732957556; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFRi8guJPa9M3nipkID+QHkHmVAs4s32oYXTFsp2AxM=;
        b=lLnNBCrQCCZ/ydLgjBf4PqLx7/zXgTSM05SKpAo3dsME8uyKklsBkwoJaTuud3SHWu
         APZygDLEEXgH55xkTwiUtfm3ozBPayzjtvIo01VXtfOk5ZBkEcDgIUAotDVL4MqIo2KL
         n8X7zaszNxGPt9+mEze8uIe0P+vWCmbLW0z8vkaeApP0AVxYdkZDkBKvE/hqaMi1nEAf
         AdH+3BmpYOyDu0gEvZupmg8CJF9gQU4x2m/epKU7Nk3tieO6SBnAyjj5d37IBETFW4Zk
         HcOxuwyGhNKEx2/M7jon+VAv9ZTPMrWVfD+z4a2oREoLHmKiApvYXFicbQ/UjGgrxNnp
         h6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732352756; x=1732957556;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFRi8guJPa9M3nipkID+QHkHmVAs4s32oYXTFsp2AxM=;
        b=wKPMdsjXa47Z92X/p+KHbbQT/KMJ+zVergFIZZOwVRjPDM1eO8ApfgbT0h3crrXmw5
         l7+jnJ5MeOUy8gRbEs63AptRVc8QvlA75NaXDUOD/9GiUE2OGc/BywI/VDTaPutWiPoX
         i5qYxvTW6dvbFLcLNsDyjJmczJSl7s8giF+DzCZsz5EnErzqLyVK2h4EY3wWZOXSqZD1
         Bf4x43DTAdghdBlIAaeK0dG3VEbxfSKqp+h1o7jKoxU/Jc1Gp6u1xHZwho/zX1fpurT8
         uXiibkkJVA1is0PAuSqNPlCbw35NCFdxzTZHQnDojRq7ddCy80U+VeJBZi1v9G70elc/
         H2sQ==
X-Gm-Message-State: AOJu0Yy7IhWqIcEu9lD32wTWIaJZmCURbcLb2DkPqeC2D5+IrC6FIqxU
	c5kc20M+haLqiJ93JrdWtWpps76Qhyfiuti4u6MCYwlgT0yT26e+12iRsA==
X-Gm-Gg: ASbGncttGpgDLdD9ooRjILo5wf7gq+VZTYqTroiQA4FRzTyBIQUK+XjTRo4xJRbxxyv
	RmRG1lCW+4ShTiTD/ueruNUyej09utohH63W6LlxvJXgQCJQcOKLVeXgZI8ShCEgBQMv8qSrHCk
	KEm0NaAX2XUyNPJUYQfZtl5lhXE4mK7rXAw1hYNqKceQlsbz6xPRZj/VbqUbS/UzOvB4NxJwXi0
	ajAc0u+zEiUi0je1IPpZRI1V4wC/AwYTmWUaeDaSN7GrU8M7ARfdxLAmkWd0OJcjKtL
X-Google-Smtp-Source: AGHT+IHzBqEl1M6wDn5WDGY7EnGpv7TJRP9wW+GXRBTj0gnt81kXa+CNHkh3idwsQ8LADs69pYD9OA==
X-Received: by 2002:a05:6000:2c6:b0:382:43ee:9f70 with SMTP id ffacd0b85a97d-38260b73bf6mr4944202f8f.22.1732352756021;
        Sat, 23 Nov 2024 01:05:56 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad658esm4782814f8f.8.2024.11.23.01.05.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2024 01:05:55 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/4] qmi: sim: use struct/enum for session type when sending pin
Date: Sat, 23 Nov 2024 11:05:33 +0200
Message-Id: <1732352735-31944-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

drop unnecessary passwd checks in qmi_pin_send() while at it
drop struct qmi_uim_param_message_info as well
---
 drivers/qmimodem/sim.c | 40 ++++++++++++++++++----------------------
 drivers/qmimodem/uim.h | 36 ++++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index a700f31..724a3d3 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -718,33 +718,30 @@ static void qmi_pin_send(struct ofono_sim *sim, const char *passwd,
 	struct cb_data *cbd = cb_data_new(cb, user_data);
 	int passwd_len;
 	struct qmi_param *param;
-	struct qmi_uim_param_message_info *info_data;
-	unsigned char session_info_data[2];
+	struct qmi_uim_param_session_info session;
+	struct {
+		uint8_t id;
+		uint8_t length;
+		uint8_t pin[0];
+	} __attribute__((__packed__)) *info;
 
 	DBG("");
 
-	if (!passwd)
-		goto error;
-
 	passwd_len = strlen(passwd);
-
-	if (passwd_len <= 0 || passwd_len > 0xFF)
-		goto error;
-
 	param = qmi_param_new();
 
-	/* param info */
-	info_data = alloca(2 + passwd_len);
-	info_data->pin_id = 0x01; /* PIN 1 */
-	info_data->length = (uint8_t) passwd_len;
-	memcpy(info_data->pin_value, passwd, passwd_len);
-	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_INFO, 2 + passwd_len,
-					info_data);
-	/* param Session Information */
-	session_info_data[0] = 0x6;
-	session_info_data[1] = 0x0;
-	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_SESSION_INFO, 2,
-					session_info_data);
+	/* info */
+	info = alloca(sizeof(*info) + passwd_len);
+	info->id = 0x01; /* PIN 1 */
+	info->length = (uint8_t) passwd_len;
+	memcpy(info->pin, passwd, passwd_len);
+	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_INFO,
+					sizeof(*info) + passwd_len, info);
+	/* session */
+	session.type = QMI_UIM_SESSION_TYPE_CS1;
+	session.aid_length = 0;
+	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_SESSION_INFO,
+					sizeof(session), &session);
 
 	if (qmi_service_send(data->uim, QMI_UIM_VERIFY_PIN, param,
 					pin_send_cb, cbd, l_free) > 0)
@@ -752,7 +749,6 @@ static void qmi_pin_send(struct ofono_sim *sim, const char *passwd,
 
 	qmi_param_free(param);
 
-error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 	l_free(cbd);
 }
diff --git a/drivers/qmimodem/uim.h b/drivers/qmimodem/uim.h
index 439e25b..92cd963 100644
--- a/drivers/qmimodem/uim.h
+++ b/drivers/qmimodem/uim.h
@@ -80,11 +80,35 @@ struct qmi_uim_file_attributes {
 	uint8_t raw_value[0];
 } __attribute__((__packed__));
 
-/* Verify PIN parameter */
 #define QMI_UIM_PARAM_MESSAGE_SESSION_INFO	0x01
-#define QMI_UIM_PARAM_MESSAGE_INFO	0x02
-struct qmi_uim_param_message_info {
-	uint8_t pin_id;
-	uint8_t length;
-	uint8_t pin_value[0];
+
+enum qmi_uim_session_type {
+	/* Primary GW Provisioning */
+	QMI_UIM_SESSION_TYPE_PGWP =		0x00,
+	/* Primary 1X Provisioning */
+	QMI_UIM_SESSION_TYPE_P1XP =		0x01,
+	/* Secondary GW Provisioning */
+	QMI_UIM_SESSION_TYPE_SGWP =		0x02,
+	/* Secondary 1X Provisioning */
+	QMI_UIM_SESSION_TYPE_S1XP =		0x03,
+	/* NonProvisioning on Slot 1 */
+	QMI_UIM_SESSION_TYPE_NPS1 =		0x04,
+	/* NonProvisioning on Slot 2 */
+	QMI_UIM_SESSION_TYPE_NPS2 =		0x05,
+	/* Card on Slot 1 */
+	QMI_UIM_SESSION_TYPE_CS1 =		0x06,
+	/* Card on Slot 2 */
+	QMI_UIM_SESSION_TYPE_CS2 =		0x07,
+	/* Logical Channel on Slot 1 */
+	QMI_UIM_SESSION_TYPE_LCS1 =		0x08,
+	/* Logical Channel on Slot 2 */
+	QMI_UIM_SESSION_TYPE_LCS2 =		0x09
+};
+
+struct qmi_uim_param_session_info {
+	uint8_t type;
+	uint8_t aid_length;
+	uint8_t aid[0];
 } __attribute__((__packed__));
+
+#define QMI_UIM_PARAM_MESSAGE_INFO	0x02
-- 
2.7.4

