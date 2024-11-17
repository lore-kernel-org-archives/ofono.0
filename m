Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C2194A49
	for <ofono@lists.linux.dev>; Sun, 17 Nov 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731845072; cv=none; b=dmIScoICndkwbRsIUWkX26sjMIFnLAHiaD6L0HsLO740QpMgznvfx89fiLuY0FF5xMStTWuEqt2coIXxSL5l0Eplxb7Bo5WJDiCc01m3j0Pl0QvcZ/14DfBwFfnjJfTjQ3TdT+ixC3vn+LslsdMuM8qjSUhDOAicTf/X1x6Z87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731845072; c=relaxed/simple;
	bh=qcwK2i9FhtuQ1FW0XSbYani+LMRRTWJxs0EoKxddY5c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=E+fQ38FXbmdfBtWPsVLOxSLCo0ORTB3FqTqsRSFKz84MzRHR8HYLvwTdGsQIY7CSZdVpSt9Gfhl9XDYfqK4jYsUeahqWsTDUOsBo7MOmiWX5CuB0K2MC5h+clFVhW5LRJz9/5XC2h11kQmuNbG/c2sgkSH7S2dn/AdcSfdaQl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl681QiT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl681QiT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso16930685e9.0
        for <ofono@lists.linux.dev>; Sun, 17 Nov 2024 04:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731845068; x=1732449868; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWV7NoBMhB5orQsn6PQQj/6pfp9pTm2J2BtR3k3u4oQ=;
        b=Jl681QiTGYWnN/YEwHGHjOFIfE71HfNzWGNbTsTpS4W14P4UAgjf4wRVtEP/ia3ZLw
         RiM4yH6rqXSMbap3p9WB8NRrJKvhjj2PPqrQI8z9633yYHMJk9Kfmlbh+hkjt/a9XoII
         xMufPpfPwb9ayFyUN4S3YvPFQL1Ehu9gv+R/rGqHkJ8ogoltppf5UWurME9GH7WR8PsI
         Je28IS7AWhn0wGoWx7vRkSewereCAIkUulMz64PXroynobtBbu9lEc4Sy37slf+GNzvW
         ujRX4nD3AE62dQJQKRDKikrrc8xEAVeZrHnKsj/aO5yQzeVChCOfqPe2TnqTug/23ZMO
         iW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731845068; x=1732449868;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWV7NoBMhB5orQsn6PQQj/6pfp9pTm2J2BtR3k3u4oQ=;
        b=hu721nmtpROFgBHU69BL/pkEmG2YGqeOm16MOMRn+o/mG9J5vhjhX3fmXbpSoQXEBU
         oJnRfUgz6MP6Z+Fr3SDE/K9a75heJxze4MpcH5NMkWRVFmJHxIoRpijddCS5jpNp8ktU
         N5zQp6LCe0+mlFE0/2ewPd8y8ASRJteAG08/RGS0mOUrFjpZmUTfzdHOFR/m0CgqbcLy
         hOOmrTsMq0pL7NU7MsMV1pFnjG7Af/+yC7BuC8wcH+vfFVVNlCHfqATHGGNvOjhwnPBQ
         Ap/nwC0ApdyLHERE/Vx0bweehnmqtCCvnF57zbIy1NGA3MW4wedSaW+j1NIplVoaheiQ
         ue0A==
X-Gm-Message-State: AOJu0Yzy8DsP4AUt/7gDwsdCL4PShG1EG1m5i6hRbejM2yEpRR7QnIzj
	UmhDmFIjMf0BySxRmVhfz6mUb0669Ju9719QDe6cKd+jZ0dfrBEjOyIxWg==
X-Google-Smtp-Source: AGHT+IFut3wzJbWW9giWd3GaYMep2lVc6YWDPaBCWtbJyZONIAEcye4HlVWYkDyygCk6wGCix7JrUg==
X-Received: by 2002:a05:600c:3583:b0:431:5f8c:ccb9 with SMTP id 5b1f17b1804b1-432df74fc2emr107785885e9.17.1731845068318;
        Sun, 17 Nov 2024 04:04:28 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac21a15sm117190065e9.38.2024.11.17.04.04.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2024 04:04:27 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmi: sim: implement lock(LockPin method)
Date: Sun, 17 Nov 2024 14:03:56 +0200
Message-Id: <1731845036-11874-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 drivers/qmimodem/sim.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/uim.h |  1 +
 2 files changed, 71 insertions(+)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index b1d8f22..65c0fa6 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -844,6 +844,75 @@ static void qmi_query_locked(struct ofono_sim *sim,
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
+	uint8_t session[2];
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
+		goto error;
+	}
+
+	if (!passwd)
+		goto error;
+
+	passwd_len = strlen(passwd);
+
+	if (passwd_len <= 0 || passwd_len > 0xFF)
+		goto error;
+
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
+	session[0] = 0x6; /* card on slot 1 */
+	session[1] = 0x0;
+	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_SESSION_INFO,
+					sizeof(session), session);
+
+	if (qmi_service_send(data->uim, QMI_UIM_ENABLE_PIN, param,
+					pin_send_cb, cbd, cb_data_unref) > 0)
+		return;
+
+	qmi_param_free(param);
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	l_free(cbd);
+}
+
 static void get_card_status_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sim *sim = user_data;
@@ -987,6 +1056,7 @@ static const struct ofono_sim_driver driver = {
 	.query_pin_retries	= qmi_query_pin_retries,
 	.send_passwd		= qmi_pin_send,
 	.query_facility_lock	= qmi_query_locked,
+	.lock			= qmi_lock,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(sim, qmimodem, &driver)
diff --git a/drivers/qmimodem/uim.h b/drivers/qmimodem/uim.h
index 439e25b..602ec0f 100644
--- a/drivers/qmimodem/uim.h
+++ b/drivers/qmimodem/uim.h
@@ -11,6 +11,7 @@
 #define QMI_UIM_WRITE_RECORD		35	/* Write a record */
 #define QMI_UIM_GET_FILE_ATTRIBUTES	36	/* Get file attributes */
 
+#define QMI_UIM_ENABLE_PIN		37	/* Set PIN protection */
 #define QMI_UIM_VERIFY_PIN		38	/* Verify PIN */
 
 #define QMI_UIM_EVENT_REGISTRATION	46	/* Register for indications */
-- 
1.9.1

