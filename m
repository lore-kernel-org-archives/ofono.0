Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9E11CAF
	for <ofono@lists.linux.dev>; Sun, 17 Nov 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731841540; cv=none; b=uxF1qKgXgpDzAxIyFGlN8Qy3wm57hX7PFYtkZ1cxGsKtb0g6BqQXfwdUef9e8fyrjssUxB7ghSt0E13qQRN43Pl2KEsi44GzpxMMOUt5Ht7C1Lw/j7jtf/fGk5+eDNFzW9xbMOqzyrADDy2N0zV9k041TKerYk1/JBJ1LbgnthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731841540; c=relaxed/simple;
	bh=qVjJ85S69StcCXImMcGrt8k3ADvRquJPShbUIGtKkyU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GpXXP8PQMMEPJ0gN30Mfuw+MiAwl0PJ0cHTL5FDmpmaL6Ea1zQ2boAtS4nlnZpOaNrEr3AdisL4Ccyv6P7OeDv4s6XtA2mpbvp3Sy4vuyNJ0Ood1BMNU+QRsw/oUt46UDj3My0JopEDj9IX+pxyEvTsL+HXd47/ubxWfal5Zors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2jmIUKN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2jmIUKN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-432d866f70fso28032545e9.2
        for <ofono@lists.linux.dev>; Sun, 17 Nov 2024 03:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731841537; x=1732446337; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fI/K4ImV3UBfPLb4S+7rCoCNN8ZASoPhjm38Sj7x9Qc=;
        b=d2jmIUKNz1JsWHJBLjabZ0+yXjNIOBRz5K5NjT+awzireKpDFKuI4CcJd0dBJONOaK
         mscRZGIngNA7ONwIUgdfIdfQOIf4SGX5/EXX0EIUX7xFLX7KuFAs0PuSPP4P4se8NaTC
         o+m7CZIov4/8lz1I1OCxcqGllDRKXBJOdP0WlCpChhFT223jQH/aCfBE4SPrYgzcbT0r
         zjd1wUsIpnUTvUPLg5/WuMgQFM6foIWhfqoRGBcYnH1SJkoysupn0esA3jkTm76Y2vO5
         sRrvqnahR64BtX7LSHIR5pXilBhQAs3pAmviaBlpdZfCmHA/GR0Q8tg9dNuSlWtTbMIn
         Gbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731841537; x=1732446337;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fI/K4ImV3UBfPLb4S+7rCoCNN8ZASoPhjm38Sj7x9Qc=;
        b=TS/n09cWX+qP4QDqIXzxSbpkogKOdG+xzKanRYkAV8VIhb6ZvD9/TNHRUXIMgerWUD
         UC/grWpy8FGskOLGlFBIxjET90YRepEELiWT5QHGTJhz8KgstMRxGcseti4Mye3dhMZ5
         oNIdykU29YddvP7Y0GGdBcCxFIRfGBeg53tGouISE+E+jbfXcwBKGrUw1PNbpPTc2sR/
         vi69TuZARpzly6Ol1z9+raXgFDNMyRhbd9hdU+qJTUjU1UBA+WenAYOAmeIWlSiXxejf
         0WPAlwjlLC/SogDMhYLM70R1A7Y+tWqMttt5aZgsL02J0F4BWxQ22gWcxpLY2QlI3/1Q
         Q5rg==
X-Gm-Message-State: AOJu0YxPeJA+mL5ukUuroF/x+17HO+/7NaZNArlYIC+PCp0RVUnNTQxe
	C5qMSaZmavOw3tB24GLACaTYYTjFw8VouhWpITMCMLJTYO+Z+g9RUxh+Gg==
X-Google-Smtp-Source: AGHT+IFxHjvqHXp8FZyD57VcuWs7oj6eLgjNb+1+aDRg6r4bBPDh77yKWv5X5o21kokxAw1bgJGLyg==
X-Received: by 2002:a05:600c:3ca3:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-432df72127fmr81018925e9.3.1731841536441;
        Sun, 17 Nov 2024 03:05:36 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da24498csm121488605e9.1.2024.11.17.03.05.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2024 03:05:35 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmi: sim: Implement query_facility_lock(LockedPins property)
Date: Sun, 17 Nov 2024 13:04:38 +0200
Message-Id: <1731841478-10479-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 drivers/qmimodem/sim.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 1fffae2..b1d8f22 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -41,6 +41,8 @@ struct sim_status {
 	uint8_t app_type;
 	uint8_t passwd_state;
 	int retries[OFONO_SIM_PASSWORD_INVALID];
+	uint8_t pin1_state;
+	uint8_t pin2_state;
 };
 
 struct sim_data {
@@ -52,6 +54,20 @@ struct sim_data {
 	struct l_timeout *retry_timer;
 };
 
+struct query_locked_data {
+	enum ofono_sim_password_type passwd_type;
+};
+
+static inline void cb_user_data_unref(void *user_data)
+{
+	struct cb_data *cbd = user_data;
+
+	if (cbd->ref == 1 && cbd->user)
+		l_free(cbd->user);
+
+	cb_data_unref(user_data);
+}
+
 static int create_fileid_data(uint8_t app_type, int fileid,
 					const unsigned char *path,
 					unsigned int path_len,
@@ -486,6 +502,9 @@ static bool get_card_status(const struct qmi_uim_slot_info *slot,
 		break;
 	}
 
+	sim_stat->pin1_state = info2->pin1_state;
+	sim_stat->pin2_state = info2->pin2_state;
+
 	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PIN] = info2->pin1_retries;
 	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PUK] = info2->puk1_retries;
 
@@ -752,6 +771,79 @@ error:
 	l_free(cbd);
 }
 
+static void query_locked_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_query_facility_lock_cb_t cb = cbd->cb;
+	struct query_locked_data *qld = cbd->user;
+	struct sim_status sim_stat;
+	uint8_t pin_state;
+	gboolean status;
+
+	DBG("");
+
+	if (handle_get_card_status_result(result, &sim_stat) !=
+					GET_CARD_STATUS_RESULT_OK) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	if (qld->passwd_type == OFONO_SIM_PASSWORD_SIM_PIN)
+		pin_state = sim_stat.pin1_state;
+	else
+		pin_state = sim_stat.pin2_state;
+
+	switch (pin_state) {
+	case 1: /* Enabled and not verified */
+	case 2: /* Enabled and verified */
+		status = TRUE;
+		break;
+	case 0: /* Unknown */
+	case 3: /* Disabled */
+	case 4: /* Blocked */
+	case 5: /* Permanently blocked */
+	default:
+		status = FALSE;
+		break;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
+}
+
+static void qmi_query_locked(struct ofono_sim *sim,
+			enum ofono_sim_password_type passwd_type,
+			ofono_query_facility_lock_cb_t cb, void *user_data)
+{
+	struct sim_data *data = ofono_sim_get_data(sim);
+	struct cb_data *cbd = cb_data_new(cb, user_data);
+	struct query_locked_data *qld;
+
+	DBG("");
+
+	switch (passwd_type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+	case OFONO_SIM_PASSWORD_SIM_PIN2:
+		break;
+	default:
+		CALLBACK_WITH_CME_ERROR(cb, 4, -1, cbd->data);
+		l_free(cbd);
+		return;
+	}
+
+	qld = l_new(struct query_locked_data, 1);
+	qld->passwd_type = passwd_type;
+	cbd->user = qld;
+
+	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
+			query_locked_cb, cbd, cb_user_data_unref) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+
+	l_free(qld);
+	l_free(cbd);
+}
+
 static void get_card_status_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sim *sim = user_data;
@@ -894,6 +986,7 @@ static const struct ofono_sim_driver driver = {
 	.query_passwd_state	= qmi_query_passwd_state,
 	.query_pin_retries	= qmi_query_pin_retries,
 	.send_passwd		= qmi_pin_send,
+	.query_facility_lock	= qmi_query_locked,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(sim, qmimodem, &driver)
-- 
1.9.1

