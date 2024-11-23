Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EDB257D
	for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732352756; cv=none; b=FJmYUKh2Mjvj3ENXKgzrEaZlRP87J6/tSzMKqw7f99AtKc5Iu2xcq+RPAgUtHkttOjlxFdrN/QBebRljP3ICUVbKewWGVUHgRQTjXJN0QMFJdI7YiaBXg6qc05cCR4qNpH0cZNgAzB0NHtsioWV5NDYCJyeOq+fIGd9DzcArIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732352756; c=relaxed/simple;
	bh=FE3vaLyR+bwcI5mdQ6s/4bkG/0dX9Q02jOnFYfd4nD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cJCwo7I88cOFJRLDACB3LtUqSojWgRhNEaAPZswLDJFHqyRYciWVsYaelq/Tktn/prelF7CpzeN8S/UpE+Dvm6ySxGWL42dR5fsMw0vLoXEMP/tgcWZwwsDG40yW8JQxfzF3vlQ1ncHTne/A4pdW25iD74DLio34nOh9MkjR86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzqFwDZT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzqFwDZT"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-382411ea5eeso1646429f8f.0
        for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 01:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732352753; x=1732957553; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4LPmm/l6a9crMPw4FV8MthZoupAGUct1pPBeunG65j8=;
        b=RzqFwDZTotkcHK3pss82VgV38soPp3wpf3EkwmEpmVrHg5jiWSGw7kLMWEiSid4K79
         n+LuGOnVznp5wrwWcWy9fE/7tFv3lk6/q+F/55UbvqxN59bTBKYhH8NpC3to0xUv5J0a
         iOZvjIeTXmtFy8BXD8UCEBFQTEXaGOVnTYPu4XBVMgddfVQuBRLAghuhpH1cMGJUy3mn
         0UFT3E9YFlHFQJOo7ktZQi8iOKwuPUa7UEpMoRvvNNZNwhyLWwo4T+7sa/CXEnBWxaIE
         Bo9NAoJZ/Wwfefj2fsuS54gATJObUbRD4ckkI6MqUs6vWjoruEkbaiBQewP47aoVUD+G
         Npyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732352753; x=1732957553;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LPmm/l6a9crMPw4FV8MthZoupAGUct1pPBeunG65j8=;
        b=RKNyWN8fKprRwcHI+4/oQE5c5txFop9UbbowE+62Aelv8aNP/6AvH4Q6YJzMEaMvvD
         0t0/0jWmSwXvpAVlN6gp6oOissdCxpm/4RxrgxiXYPQJkVx/ROQMQRWYdzWcaNPLDQ6y
         DNqLHly6zhFczTYFUMf+SlMGKhdSLNglzeYmqsOsY809ZVAENOP/tRIJuwIUVfJnJmAX
         OF5szwWVZtjLiR+8C9BuvoenMdAQHvUP89zBz2k6L3g56+JGP3qXz7Bhijl3gbOz5H4f
         Apq7BhH3XjL4mApA8JVt8N5yWR7OgAax7Q7uZh8B+TpVCteqEq3T/Un7tKCoWnP9LesO
         0n6A==
X-Gm-Message-State: AOJu0YwNHkbF2RGKM4syQ8AJH01ps2NwDmnOpcV9hg4I1SlvZqmt8Nlo
	YjvuPOIyy9O3CQ9cLZB3KNi7Uc27kADZlOK7ACoutOqDtB358mQkbOe2NQ==
X-Gm-Gg: ASbGncug2Pjt72zwLo3jQmD2c9QsXi832y6eTVcZozK7P5L3eZ7CbDDrAuMkpvLPZkn
	jty0zYCfZ4vPb5rioyMslRM1gBdVMWeg/Bky7/jcx+cm1z59R/lvzm5AqZtBQZuleYkHS0kRO7Q
	/XGiB0tLb08kJl7Uo9+mSZ8lh7mAJUPoCZzVmo/z+zeSAVT/83SjBMUEgQmUop+DQNrTYRz+DEe
	QWLRFcyRxlSyRP/RUDbbxcoagUg634AMfy8cm48tHIdtQueLCVj3d0dKaknpbI3Av0f
X-Google-Smtp-Source: AGHT+IH4UPWYqh5ZfrJ+616aqzRmpz0Gki6lOcTeTtf4Bqph2fOaezaLs0xNOG3X1xS953GBbmM/ZQ==
X-Received: by 2002:a05:6000:4025:b0:382:46d2:52b6 with SMTP id ffacd0b85a97d-38260072dc4mr5444040f8f.0.1732352753053;
        Sat, 23 Nov 2024 01:05:53 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad658esm4782814f8f.8.2024.11.23.01.05.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2024 01:05:52 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/4] qmi: sim: Implement query_facility_lock(LockedPins property)
Date: Sat, 23 Nov 2024 11:05:32 +0200
Message-Id: <1732352735-31944-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 drivers/qmimodem/sim.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 1fffae2..a700f31 100644
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
@@ -486,6 +488,9 @@ static bool get_card_status(const struct qmi_uim_slot_info *slot,
 		break;
 	}
 
+	sim_stat->pin1_state = info2->pin1_state;
+	sim_stat->pin2_state = info2->pin2_state;
+
 	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PIN] = info2->pin1_retries;
 	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PUK] = info2->puk1_retries;
 
@@ -752,6 +757,74 @@ error:
 	l_free(cbd);
 }
 
+static void query_locked_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_query_facility_lock_cb_t cb = cbd->cb;
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
+	if (L_PTR_TO_UINT(cbd->user) == OFONO_SIM_PASSWORD_SIM_PIN)
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
+	cbd->user = L_UINT_TO_PTR(passwd_type);
+
+	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
+			query_locked_cb, cbd, cb_data_unref) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+
+	l_free(cbd);
+}
+
 static void get_card_status_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sim *sim = user_data;
@@ -894,6 +967,7 @@ static const struct ofono_sim_driver driver = {
 	.query_passwd_state	= qmi_query_passwd_state,
 	.query_pin_retries	= qmi_query_pin_retries,
 	.send_passwd		= qmi_pin_send,
+	.query_facility_lock	= qmi_query_locked,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(sim, qmimodem, &driver)
-- 
2.7.4

