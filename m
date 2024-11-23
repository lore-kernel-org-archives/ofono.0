Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A77257D
	for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732352761; cv=none; b=W7HpMGMUbQFmbBhiyNy9EgdptJVPS095ZASM377mo+w9gsDFfKv1jCL9CIaXJbhrF8ZFdxPOEgK+h/qTFdLsUAqGrymAmfca3dOJRzcRO4xOB6YQkUJnEgO2I+vJ4BAgyeogJ/0Z6WaJQWaJVRVzbCDRKfh0FiEkXL/82V1VDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732352761; c=relaxed/simple;
	bh=OEoCajIp62h0SOdaZUMYvcl+GqqIOJK+7QMsPmAOZiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Fvk69Axf8Mwad2qaJM8gxSag+D5ktXo6NFX+jeqTdRnXCYr7JlGulvD4K86niD2ivW4UT4y6u2DAa+kjMYRAb/Ydl1vPGA+sLrOkIrUcYXzOGYOmVyhOpGQT8PerDBAAYF/OcehTvgfSPUTPGyYvgLF84glLRY1YizadEydC34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbJfULHT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbJfULHT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so26847085e9.3
        for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 01:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732352758; x=1732957558; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/N2yFMzV3JbmMVYsR7Eh2ElkXw/5CKT3FL1WygMokDk=;
        b=MbJfULHTsZmzbEk96TWHOXPtAlIWTZKBZOUY+AN71f3j8pWeIWW/4Jf9I4jW+i6kGK
         zplnrOd1Yp6JAhgox+CkjsGKgydmb75n2kDgYS6pnWd972F24ECPQ1RpPujSAS7r+xpY
         uoSsfYf5JzmO10caTV5eDFWCFODfogqWJ2j+i/Us0ExgQ0idaPY+gsOzvUeMF1N3E2lo
         dFpx4dDY2NFtuYUux3xILG/TEZyOxsT8EOIdbCjlqB2NNFSHJg18yTU+NEz4UasSwQCM
         DS9q3uOb1Gqxienw+Y9TnMNj/awfcougBXQgbEO/xrRbT7eXz8WbITGYKv8j9317xHa1
         dNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732352758; x=1732957558;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/N2yFMzV3JbmMVYsR7Eh2ElkXw/5CKT3FL1WygMokDk=;
        b=WzEvSh6/v/CixZx+PKzcaVuAsLB3i6pwGqqWZA4vytrK23ifFbfp/9cs85FJnodIog
         U59g3ez4WX5IX1P2x4gDJadSs0dyuqX49kNJM9iy/NBlg0HvUYPSivJ3XcfXLFI6ovGd
         KOB0BS0PqsViHqn5UzH5Ou2OZ0crP9LGKgXee8PD55Y3NGKLROetunzvANlgIXERC6J6
         OZ/EqXe8pwRl/5tgkg5ZwQSrq4mbok8ti7kbnwRAGCfIU3hUDiJpqefKnagKNE7G15FO
         efQEOj0/ssKTeJMM0hihFfW7dpmd/xbkNaemHRm2FWx+2XgEiUc9JCsv2DfUYBW9A8Z0
         C1uw==
X-Gm-Message-State: AOJu0YyBwiGk+j9D+dgV19j/xiWBbp3zBejhwWWYLP3NwQuTZZLEx4r2
	/1ih9EfNvpD8/4atBrbeqg/3T3/nCEDcvsxoY1ngb6eHmkCAtkkBviJlPQ==
X-Gm-Gg: ASbGncsyirgOTZxd8yhXvcOjd4BL4wHiINRX23slxC4fT/006zCfoizZ/z2u7l10OgM
	XFVPm84ZghC8mhc8MAnuXrZNRZRosGVhjTOolejSPE3YHcfMfpO/beckF2/GpIjrxs1/iiRMmtG
	uAxIB4XXRJKl/KvfHkcr8HPH23+4PGVBTKXKwKmSJWvx9tf6UBaRyM/wv7fC+exG3idDV6GnwIK
	9hHuUUBwPNhwEzXHpBUWv+NlSlRj9143dehY2v17vzqKm/EwdveL6ueNR9TU2lVVboZ
X-Google-Smtp-Source: AGHT+IFoZQpnaP1lpgMirtWeS3UShtKhd9SBCO6ULw+6JPPkfnJCebKQiayuIsnRaG64y/sXbEOuIQ==
X-Received: by 2002:a05:600c:34c3:b0:431:46fe:4cad with SMTP id 5b1f17b1804b1-433ce41c7acmr54698665e9.9.1732352757803;
        Sat, 23 Nov 2024 01:05:57 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad658esm4782814f8f.8.2024.11.23.01.05.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2024 01:05:57 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 3/4] qmi: sim: implement lock(LockPin method)
Date: Sat, 23 Nov 2024 11:05:34 +0200
Message-Id: <1732352735-31944-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 drivers/qmimodem/sim.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/uim.h |  1 +
 2 files changed, 64 insertions(+)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 724a3d3..c980203 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -821,6 +821,68 @@ static void qmi_query_locked(struct ofono_sim *sim,
 	l_free(cbd);
 }
 
+static void qmi_lock(struct ofono_sim *sim,
+		enum ofono_sim_password_type passwd_type,
+		int enable, const char *passwd,
+		ofono_sim_lock_unlock_cb_t cb, void *user_data)
+{
+	struct sim_data *data = ofono_sim_get_data(sim);
+	struct cb_data *cbd = cb_data_new(cb, user_data);
+	int passwd_len;
+	uint16_t info_len;
+	uint8_t pin_id;
+	struct qmi_param *param;
+	struct qmi_uim_param_session_info session;
+	struct {
+		uint8_t id;
+		uint8_t enabled;
+		uint8_t length;
+		uint8_t pin[0];
+	} __attribute__((__packed__)) *info;
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
+	passwd_len = strlen(passwd);
+	param = qmi_param_new();
+
+	/* info */
+	info_len = sizeof(*info) + passwd_len;
+	info = alloca(info_len);
+	info->id = pin_id;
+	info->enabled = enable ? 0x01 : 0x00;
+	info->length = (uint8_t) passwd_len;
+	memcpy(info->pin, passwd, passwd_len);
+
+	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_INFO, info_len, info);
+
+	/* session */
+	session.type = QMI_UIM_SESSION_TYPE_CS1;
+	session.aid_length = 0;
+	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_SESSION_INFO,
+					sizeof(session), &session);
+
+	if (qmi_service_send(data->uim, QMI_UIM_ENABLE_PIN, param,
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
@@ -964,6 +1026,7 @@ static const struct ofono_sim_driver driver = {
 	.query_pin_retries	= qmi_query_pin_retries,
 	.send_passwd		= qmi_pin_send,
 	.query_facility_lock	= qmi_query_locked,
+	.lock			= qmi_lock,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(sim, qmimodem, &driver)
diff --git a/drivers/qmimodem/uim.h b/drivers/qmimodem/uim.h
index 92cd963..95ba053 100644
--- a/drivers/qmimodem/uim.h
+++ b/drivers/qmimodem/uim.h
@@ -11,6 +11,7 @@
 #define QMI_UIM_WRITE_RECORD		35	/* Write a record */
 #define QMI_UIM_GET_FILE_ATTRIBUTES	36	/* Get file attributes */
 
+#define QMI_UIM_ENABLE_PIN		37	/* Set PIN protection */
 #define QMI_UIM_VERIFY_PIN		38	/* Verify PIN */
 
 #define QMI_UIM_EVENT_REGISTRATION	46	/* Register for indications */
-- 
2.7.4

