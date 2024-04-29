Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060308288A
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406251; cv=none; b=RvjAAPIcv26PQGAF1n60npsGysmksM+WLt96jqCUeonzzvWtH8fYnzsgzT81kznUJoiPjNNI+zaXPbkQ1jUBDOjWBB8SunpdwS2h7U2OXVkfBh3v2aPbuiwof6hXs3nxfuYVvloh7JogUrG9Qn2cQlpAEktTQQ70NeYL9nO5uUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406251; c=relaxed/simple;
	bh=/ZPGYhmsxYUgVO1szsDx3qGWmuUlxL7X9b2Au6VtL9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7a5A8YMXPktr+ExKBfROpw70FnwwvWEXqsYJQFfeY7/jUqLlJLG2LA+BLCpuqkEfdOm0yWT8GtcMc3XDcNmxxOB2rrNEVBL1IywiO/a+aUOlty7MHAfiaqFCoy2y4e6oIC3HVuM8CDrPnvwOwp43SyIO/lhGJu4BCT6dImxY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9CRno/K; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9CRno/K"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c868e82bf8so230377b6e.0
        for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714406249; x=1715011049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LNp68X6W7cyV7TzCOqVzJRagrhqyQ3Vzubd4zumI8lY=;
        b=A9CRno/Kr/mKv7FZ3Mk5y3v8V8zKtE/hD7u6+b7+TI1H8BjGGgLK1STMeIvirf7YR+
         sGZPq3LzKf8GLk4QTY15C1N9cGSgMGkYhPZBaX09wi6x2qZf/3rIxOtSM6OHnsubm/un
         F4yHASgUGdpbZcvMto8eMySW0cQfZ7yGgMCtcO/scFGStTscnx6wc5JE/smG2uH4obkm
         ZxpN6fta6Cd01WEzWVEGCOffRBRxetGJrXyHBRTyBA5Q0lgPxfV+lOtw7YfS3khzN/nb
         /a4xM+q31FZdldzaI5gCBnI8E0MkfqxmGqVZhVKKgKuJyciwN0v9pOKzupMModHfdNv4
         hgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406249; x=1715011049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNp68X6W7cyV7TzCOqVzJRagrhqyQ3Vzubd4zumI8lY=;
        b=WdAAfFrT5U2dFoeJC5OiHTZtET+E4oEJ5GvrT5oSRY85MkEkaxA4Y6CEVF3QWjrP5n
         FYmK4NxV8DzJw0ivsVpGKiLRmIcCEj4/zTkrQ75shjpuOQTKnVJ21NMqL9mcjSiFWFtS
         7g90XRtw0QWinrzjZnBX8snZ9MeW7Dqx99RQ7LhYv538gSwl1s4b/2J1Pv2oVstUsj8H
         UfuvvlLvp8Cp3v8pEaRQde4yM25U+8uU1LGo60XP3cWCew7TF4p2CcrvzhHjqBr/mNMX
         V7VHDSQlYmhSCKQ6DGcfnVPt135xoLl3EJyvkFJhqBEj2jvE/ebIPD2r6OJWIdU3m63p
         FFmg==
X-Gm-Message-State: AOJu0YyX4U4k4cfRIJ1/k22AdNIRPjx13rXNb9Jlm7C4nJGO5ZRpdHkQ
	ukKMdEr8JjN0yHdLPOqqizdgOfmpl7JxO3XfrUDd2VCUaEbaFzee2zMMdQ==
X-Google-Smtp-Source: AGHT+IHmrUgCfexeu0U3R4aM4YKUgAd7L8j2cMEmH+0Pvzlhd3imUnf9pH8WUptoteC/pRCWvqaiGg==
X-Received: by 2002:a05:6808:aae:b0:3c8:64d0:c45e with SMTP id r14-20020a0568080aae00b003c864d0c45emr5100825oij.30.1714406248870;
        Mon, 29 Apr 2024 08:57:28 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bf29-20020a056808191d00b003c7443c0efasm3117820oib.1.2024.04.29.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:57:28 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/6] qmi: lte: Remove magic number use
Date: Mon, 29 Apr 2024 10:56:53 -0500
Message-ID: <20240429155726.51479-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several commands were invoked using magic numbers, even though they're
defined inside wds.h.  Remove magic numbers from enumerations by
introducing appropriate enums to wds.h.  Similarly, use defined
constants for parameter and result ids.
---
 drivers/qmimodem/lte.c | 29 +++++++++++++++--------------
 drivers/qmimodem/wds.h | 14 +++++++++++++-
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index 6c08c312b3cb..7633572b39ef 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -73,24 +73,23 @@ static void qmimodem_lte_set_default_attach_info(const struct ofono_lte *lte,
 		uint8_t type;
 		uint8_t index;
 	} __attribute__((packed)) p = {
-		.type = 0, /* 3GPP */
+		.type = QMI_WDS_PROFILE_TYPE_3GPP,
+		.index = ldd->default_profile,
 	};
 
 	DBG("");
 
-	p.index = ldd->default_profile;
-
 	param = qmi_param_new();
 
 	/* Profile selector */
-	qmi_param_append(param, 0x01, sizeof(p), &p);
+	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
 
 	/* WDS APN Name */
 	qmi_param_append(param, QMI_WDS_PARAM_APN,
 				strlen(info->apn), info->apn);
 
 	/* Modify profile */
-	if (qmi_service_send(ldd->wds, 0x28, param,
+	if (qmi_service_send(ldd->wds, QMI_WDS_MODIFY_PROFILE, param,
 					modify_profile_cb, cbd, l_free) > 0)
 		return;
 
@@ -114,6 +113,7 @@ static void reset_profile_cb(struct qmi_result *result, void *user_data)
 
 static void get_default_profile_cb(struct qmi_result *result, void *user_data)
 {
+	static const uint8_t RESULT_DEFAULT_PROFILE_NUMBER = 0x1;
 	struct ofono_lte *lte = user_data;
 	struct lte_data *ldd = ofono_lte_get_data(lte);
 	uint16_t error;
@@ -123,7 +123,7 @@ static void get_default_profile_cb(struct qmi_result *result, void *user_data)
 		uint8_t type;
 		uint8_t index;
 	} __attribute__((packed)) p = {
-		.type = 0, /* 3GPP */
+		.type = QMI_WDS_PROFILE_TYPE_3GPP,
 	};
 
 	DBG("");
@@ -134,7 +134,8 @@ static void get_default_profile_cb(struct qmi_result *result, void *user_data)
 	}
 
 	/* Profile index */
-	if (!qmi_result_get_uint8(result, 0x01, &index)) {
+	if (!qmi_result_get_uint8(result, RESULT_DEFAULT_PROFILE_NUMBER,
+								&index)) {
 		ofono_error("Failed query default profile");
 		goto error;
 	}
@@ -148,10 +149,10 @@ static void get_default_profile_cb(struct qmi_result *result, void *user_data)
 	param = qmi_param_new();
 
 	/* Profile selector */
-	qmi_param_append(param, 0x01, sizeof(p), &p);
+	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
 
 	/* Reset profile */
-	if (qmi_service_send(ldd->wds, 0x4b, param,
+	if (qmi_service_send(ldd->wds, QMI_WDS_RESET_PROFILE, param,
 				reset_profile_cb, lte, NULL) > 0)
 		return;
 
@@ -171,8 +172,8 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 		uint8_t type;
 		uint8_t family;
 	} __attribute((packed)) p = {
-		.type = 0,   /* 3GPP */
-		.family = 0, /* embedded */
+		.type = QMI_WDS_PROFILE_TYPE_3GPP,
+		.family = QMI_WDS_PROFILE_FAMILY_EMBEDDED,
 	};
 
 	DBG("");
@@ -189,11 +190,11 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 	param = qmi_param_new();
 
 	/* Profile type */
-	qmi_param_append(param, 0x1, sizeof(p), &p);
+	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
 
 	/* Get default profile */
-	if (qmi_service_send(ldd->wds, 0x49, param,
-				get_default_profile_cb, lte, NULL) > 0)
+	if (qmi_service_send(ldd->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
+				param, get_default_profile_cb, lte, NULL) > 0)
 		return;
 
 	qmi_param_free(param);
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 3c9b534c1f82..6d7071fe244f 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -20,13 +20,13 @@
  */
 
 /* Start WDS network interface */
+#define QMI_WDS_PARAM_PROFILE_TYPE		0x01
 #define QMI_WDS_PARAM_APN			0x14	/* string */
 #define QMI_WDS_PARAM_IP_FAMILY			0x19	/* uint8 */
 #define QMI_WDS_PARAM_USERNAME			0x17	/* string */
 #define QMI_WDS_PARAM_PASSWORD			0x18	/* string */
 #define QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE	0x16	/* uint8 */
 
-
 enum qmi_wds_authentication {
 	QMI_WDS_AUTHENTICATION_PAP	= 0x1,
 	QMI_WDS_AUTHENTICATION_CHAP	= 0x2,
@@ -57,6 +57,17 @@ enum qmi_wds_client_type {
 	QMI_WDS_CLIENT_TYPE_TETHERED = 0x01,
 };
 
+enum qmi_wds_profile_type {
+	QMI_WDS_PROFILE_TYPE_3GPP =	0x00,
+	QMI_WDS_PROFILE_TYPE_3GPP2 =	0x01,
+	QMI_WDS_PROFILE_TYPE_EPC =	0x02,
+};
+
+enum qmi_wds_profile_family {
+	QMI_WDS_PROFILE_FAMILY_EMBEDDED =	0x00,
+	QMI_WDS_PROFILE_FAMILY_TETHERED =	0x01,
+};
+
 enum qmi_wds_command {
 	QMI_WDS_RESET					= 0x00,
 	QMI_WDS_EVENT_REPORT				= 0x01,
@@ -83,6 +94,7 @@ enum qmi_wds_command {
 	QMI_WDS_GET_CURRENT_DATA_BEARER_TECHNOLOGY 	= 0x44,
 	QMI_WDS_GET_DEFAULT_PROFILE_NUMBER		= 0x49,
 	QMI_WDS_SET_DEFAULT_PROFILE_NUMBER		= 0x4A,
+	QMI_WDS_RESET_PROFILE				= 0x4B,
 	QMI_WDS_SET_IP_FAMILY				= 0x4D,
 	QMI_WDS_SET_AUTOCONNECT_SETTINGS		= 0x51,
 	QMI_WDS_GET_PDN_THROTTLE_INFO			= 0x6C,
-- 
2.44.0

