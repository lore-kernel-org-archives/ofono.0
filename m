Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBD183CB0
	for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732352763; cv=none; b=OSjfpMoPB3H2gYKmWr8BHqC6kuDks3gpPk1IPdE73h8B6P06dLWePW+Z5eW7a/wu+G0u+CE7izgPIzDlznadnmdXT/8ptOIJNU3qRzWg+gsHD8ttKRIgGFxNZbEOVfWTaQblYLNEM9srypbPaGtfMRlBCiZzXKK8R4TIzezs4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732352763; c=relaxed/simple;
	bh=xeGRmOMMy4z8xw4ZtNWZjRJQSPZjF0cte0MinqiRDuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZDpno+foFHbXnrQgRCYoagrAQme5eRUOEqCCFJn6dKrnwkc+B00mSkoO4eqks7UKkuM86fO4ybAeFgaEPyY6gs3htJjVh8W80MVCzDOA9oaARL/CSi73QMR33GVUjX0a1TfDmfXW9RtlGwqOtMeapGViND/BDPdsuDDS5cEHxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxV7Bt6t; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxV7Bt6t"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38246333e12so2755328f8f.1
        for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 01:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732352760; x=1732957560; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pb4ZpXTmW3NcM7fGSsrkOz0WHJYbGoSkraQXA+E+CpI=;
        b=fxV7Bt6tqFG3NgNiJ3/Nr3hGE+mTEW16qB/8A+n1+CVsUopShOksVLtYvFWTOPBz9A
         pTMsRXNmfSM+2xovwMjux7B2q/GZx6EEy29+uHhHCiYa76ctHeOG6drwb3gucazgcM5S
         6VHFrgNEqy5TSDVRZEyEuNiOWdQRxCxJimpsgJCXtGFAqhutfX1OCH7hHUtUAzAEZ0QR
         Ypq+0P8ZGOJeEr+4HDwkNkjlKCxQzLS37TKB3rI9CLa5pzqS4D3/6n3Qt7IbawvmYA/u
         LQJva5GRcU5pg7617DUAt9UWxJ7t9/+js4jxxiEYI9W25Zo7nlicYQOpFuuhNzQ1y4bO
         o4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732352760; x=1732957560;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb4ZpXTmW3NcM7fGSsrkOz0WHJYbGoSkraQXA+E+CpI=;
        b=usAz26fQuJyxYPWhuMdnr8iRU8W69MlnslYDoF/O9tAQjRsWpjda6uD7mH2cJT14ZO
         UKon4+WtozZuxG4uANl02LLbeKNJxQiJbnZRCdZPJR1kDh0qjRPeYIG1ru8DElaStPW8
         65VS1R4jqQG/0EY95Ca3F2bnxD/G8zJRxrD4kEpirTZCALRy9iBaeCgGe66LXTPgFBeq
         MrT4/qpUWJwnPa4ALiF12sz0L+qFBRdl7rYaJq/KDm5VCLw2PiMqRpwZnxRtcgkhoq3v
         DD33oe9I3eg39r6Ttf0EfEtMP3NqNjKmMQecx0DagGRGA3gVwpRQtgSA1782z2+cLdZe
         lS/Q==
X-Gm-Message-State: AOJu0Yw+OsOndW+3aiXShL9r2pizrwtPGG3hJeO4z4WK3F5AeH7WNhIn
	2UZ7w5Q1VMVejeWqtnvTZk6osEgONBfdTpW79E21+rPJOvFdFLGY/WMBHg==
X-Gm-Gg: ASbGncsP4c7feiULA0rNhcBK3L3iGjtx2/kS1IdP5M5I1OPMtLV7yjB0/aVs1uWxCda
	43AXYXzF151nbEtn6w3UBygZ/KUiOQq/OERW2jXYeqndz+oqCR6a+kYW1LnIt9gtW0XqssK2ZEk
	MiISt/XNm/BCp7WbYKYmb6IVaa0DleTHIr5xHv9HabQQFgFfVqkc0Nax2k5q/TrLeyhb4Y/CwRk
	DL2yoBx0NwJ1sOYRzORxmfEgNUVT3UXLljtdwHlHCx7Tc20svIhniZkGda0Eg9mSWZZ
X-Google-Smtp-Source: AGHT+IG1z+/N9mSEXDeDDYUr0MEJFrfPhtJXNnC710azwwgk6I41zYvlnsSZ2JMSULLF3H79/xgIHQ==
X-Received: by 2002:a05:6000:186c:b0:382:4849:d5c8 with SMTP id ffacd0b85a97d-38260b81082mr6162516f8f.31.1732352759765;
        Sat, 23 Nov 2024 01:05:59 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad658esm4782814f8f.8.2024.11.23.01.05.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2024 01:05:59 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 4/4] qmi: sim: implement change_passwd(ChangePin method)
Date: Sat, 23 Nov 2024 11:05:35 +0200
Message-Id: <1732352735-31944-5-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 drivers/qmimodem/sim.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/uim.h |  1 +
 2 files changed, 77 insertions(+)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index c980203..06ff86d 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -883,6 +883,81 @@ static void qmi_lock(struct ofono_sim *sim,
 	l_free(cbd);
 }
 
+static void qmi_change_passwd(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				const char *old_pwd, const char *new_pwd,
+				ofono_sim_lock_unlock_cb_t cb, void *user_data)
+{
+	struct sim_data *data = ofono_sim_get_data(sim);
+	struct cb_data *cbd = cb_data_new(cb, user_data);
+	int old_pwd_len;
+	int new_pwd_len;
+	uint16_t info_len;
+	uint16_t info1_len;
+	uint16_t info2_len;
+	uint8_t pin_id;
+	struct qmi_param *param;
+	struct qmi_uim_param_session_info session;
+	struct {
+		uint8_t id;
+		uint8_t length;
+		uint8_t pin[0];
+	} __attribute__((__packed__)) *info1;
+	struct {
+		uint8_t length;
+		uint8_t pin[0];
+	} __attribute__((__packed__)) *info2;
+
+	DBG("");
+
+	switch (passwd_type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+		pin_id = 0x01;
+		break;
+	case OFONO_SIM_PASSWORD_SIM_PIN2:
+		pin_id = 0x02;
+		break;
+	default:
+		CALLBACK_WITH_CME_ERROR(cb, 4, cbd->data);
+		return;
+	}
+
+	old_pwd_len = strlen(old_pwd);
+	new_pwd_len = strlen(new_pwd);
+
+	/* info */
+	info1_len = sizeof(*info1) + old_pwd_len;
+	info2_len = sizeof(*info2) + new_pwd_len;
+	info_len = info1_len + info2_len;
+
+	info1 = alloca(info_len);
+	info1->id = pin_id;
+	info1->length = (uint8_t) old_pwd_len;
+	memcpy(info1->pin, old_pwd, old_pwd_len);
+
+	info2 = (void *)&info1->pin[old_pwd_len];
+	info2->length = (uint8_t) new_pwd_len;
+	memcpy(info2->pin, new_pwd, new_pwd_len);
+
+	param = qmi_param_new();
+	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_INFO, info_len, info1);
+
+	/* session */
+	session.type = QMI_UIM_SESSION_TYPE_CS1;
+	session.aid_length = 0;
+	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_SESSION_INFO,
+					sizeof(session), &session);
+
+	if (qmi_service_send(data->uim, QMI_UIM_CHANGE_PIN, param,
+					pin_send_cb, cbd, cb_data_unref) > 0)
+		return;
+
+	qmi_param_free(param);
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	l_free(cbd);
+}
+
 static void get_card_status_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sim *sim = user_data;
@@ -1027,6 +1102,7 @@ static const struct ofono_sim_driver driver = {
 	.send_passwd		= qmi_pin_send,
 	.query_facility_lock	= qmi_query_locked,
 	.lock			= qmi_lock,
+	.change_passwd		= qmi_change_passwd,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(sim, qmimodem, &driver)
diff --git a/drivers/qmimodem/uim.h b/drivers/qmimodem/uim.h
index 95ba053..f3c4fb0 100644
--- a/drivers/qmimodem/uim.h
+++ b/drivers/qmimodem/uim.h
@@ -13,6 +13,7 @@
 
 #define QMI_UIM_ENABLE_PIN		37	/* Set PIN protection */
 #define QMI_UIM_VERIFY_PIN		38	/* Verify PIN */
+#define QMI_UIM_CHANGE_PIN		40	/* Change PIN */
 
 #define QMI_UIM_EVENT_REGISTRATION	46	/* Register for indications */
 #define QMI_UIM_GET_CARD_STATUS		47	/* Get card status */
-- 
2.7.4

