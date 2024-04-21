Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E6111AD
	for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728983; cv=none; b=lnX5wiOcz/vzuU/chEztsRzDkrLN4svtzOGXHUyTTwR7T9ntzz8puT0Go2c4m4F7ADS/x3iyf6HLovMsEZn/cYGIcPhGPOFwvPyQKD4Ib6mjXzJnDvLtK+SW0hg1hbXcTjZuPg7kxzbiJudmOf1/JjnbBcIc+DSU160BzkJyBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728983; c=relaxed/simple;
	bh=EXRVrXzOTtHanjNl+8DcPp3jW7YCkVIX0/+JiUBZmQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOxG5GKy0LY7HK3ElQG61ZSdjB1e/KuHtcLxzUmAp73WYrNNaWSfru1Vts41ypPAFfBgtSC6FPkXMICYa9wrpO6DzRdpCeootgyQOPBDhHhbRYNc3UQ5rC9igYe+MLRYFVnwEaqAjNUt8UG/qKsOL6Uh+dCeY1VmNooNGh6GlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glayFZwb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glayFZwb"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3465921600dso3286013f8f.3
        for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 12:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713728980; x=1714333780; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBA/w4e9EGprRO54+H1zZnnD6BoS3h9gx6NZ4XvKCV4=;
        b=glayFZwbtasYLs+Il/DEsRJeAuaWim8sx0xBx1wsbK0K8YNaA8ybB3JBvIXxQ9XAjN
         ZzWP2Agyooq5jguNHII3N+dyEeyw04XP8HCW5KR0vzt2O77KtFK7Og8dXg2gQacDF/k5
         VooUt3ao6N5frtHoFw1CsBb2mjsJfPMjCsETWDL7ELjUfPntKnwXUebnYsYmIWlUKPGf
         PAJZYpJoPCq5Cv7s83c8dLuLxvrE2X8bTC4vHRVR5mFCNtlhL11qtz8AJzK6QdpbYZ58
         ItH/HrnqGXHFrN1b7QTW77lBNr4YKo+4DPUcs6+clNcy81GPBikiMJ+ScD2HIZv2ylLu
         OCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713728980; x=1714333780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBA/w4e9EGprRO54+H1zZnnD6BoS3h9gx6NZ4XvKCV4=;
        b=tYUeUWDwHm39SGRlkGh/KBs0VicwTfItSpdZm6UkdNSeNbTWpf0WHyA93No/H3oTq6
         I+PJiQZ4yWVgspdOjBK7EB68v0XqDKB5a3638ixflHHKTg3FGfJnZx7lhykgcfGyQnPc
         mjGF8uibu3v4Q12E6lcAI5pfzwLLYfDhwd1Es+Q7DAkxtJwRfLSFRmXjI70+mQ0QsTv6
         rXl+BdCgRBhtnDm3c0yrlvUOLh2nsgSNxvL6PL39oOrUmjE3BvZgN3F3gt6DPiR67OJw
         XUo9ADBu65DGVaXkNFdyD2O8KTvfkiAfs5ka6Zo1yG/JYVY3yI6nwDy/DaRDsXxh9HzM
         ZDzA==
X-Gm-Message-State: AOJu0YzhYdjfqiwUcsdAbWgpl6YoDjNuYyAGC/bNSEuU8hdg1UwcN1ir
	JtOtRZoIDdEAf4sYAEVmM/+BPlN7ytKEK2a8FxD31sMPxIW7aa+0twSUOw==
X-Google-Smtp-Source: AGHT+IHYog/UIqyFB8ZF6KRDH6peOcJ6EtF36n4NISXpbwBXjg6QnYkdLp80WIZdOGYJookO9QhhGg==
X-Received: by 2002:adf:ff8e:0:b0:34a:56e7:5cc4 with SMTP id j14-20020adfff8e000000b0034a56e75cc4mr5399916wrr.2.1713728980202;
        Sun, 21 Apr 2024 12:49:40 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm10018521wrs.53.2024.04.21.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 12:49:39 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH 4/4] qmimodem: voicecall: Implement DTMF tones
Date: Sun, 21 Apr 2024 20:49:06 +0100
Message-ID: <20240421194926.13149-4-adam@piggz.co.uk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421194926.13149-1-adam@piggz.co.uk>
References: <20240421194926.13149-1-adam@piggz.co.uk>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The send_dtmf function sets up a call to send_one_dtmf, which will call
the QMI_VOICE_START_CONTINUOUS_DTMF service function.  The parameters to
this call are a hard coded call-id and the DTMF character to send.
start_cont_dtmf_cb will then be called which will set up a call to
QMI_VOICE_STOP_CONTINUOUS_DTMF to stop the tone.  Finally,
stop_cont_dtmf_cb will check the final status.

---
Changes in V4
-Removed unused enum
-Minor formatting fixes
-Ensure data->full_dtmf is free'd
-Use cb_data_ref/unref between chains of dtmf calls

Changes in V5
-Store the cb and cbd obejects in the voicall_data  struct
---
---
 drivers/qmimodem/voice.h     |   6 ++
 drivers/qmimodem/voicecall.c | 114 +++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index caedb079..961fe19f 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -53,6 +53,8 @@ enum voice_commands {
 	QMI_VOICE_GET_ALL_CALL_INFO =		0x2f,
 	QMI_VOICE_END_CALL =			0x21,
 	QMI_VOICE_ANSWER_CALL =			0x22,
+	QMI_VOICE_START_CONTINUOUS_DTMF =	0x29,
+	QMI_VOICE_STOP_CONTINUOUS_DTMF =	0x2A,
 	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
 	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
 	QMI_VOICE_GET_CALL_WAITING =		0x34,
@@ -85,6 +87,10 @@ enum qmi_voice_call_state {
 	QMI_VOICE_CALL_STATE_SETUP
 };
 
+enum qmi_voice_call_dtmf_param {
+	QMI_VOICE_DTMF_DATA = 0x01,
+};
+
 struct qmi_ussd_data {
 	uint8_t dcs;
 	uint8_t length;
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 6b80f576..f51452e5 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -42,6 +42,10 @@ struct voicecall_data {
 	uint16_t minor;
 	struct l_queue *call_list;
 	struct ofono_phone_number dialed;
+	char *full_dtmf;
+	const char *next_dtmf;
+	ofono_voicecall_cb_t send_dtmf_cb;
+	struct cb_data *send_dtmf_data;
 };
 
 struct qmi_voice_call_information_instance {
@@ -605,6 +609,114 @@ static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
 	release_specific(vc, call->id, cb, data);
 }
 
+static void stop_cont_dtmf_cb(struct qmi_result *result, void *user_data)
+{
+	struct voicecall_data *vd = user_data;
+	uint16_t error;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd->send_dtmf_data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd->send_dtmf_data);
+}
+
+static void start_cont_dtmf_cb(struct qmi_result *result, void *user_data)
+{
+	struct voicecall_data *vd = user_data;
+	uint16_t error;
+	struct qmi_param *param;
+
+	DBG("");
+
+	param = qmi_param_new();
+
+	if (qmi_result_set_error(result, &error))
+		goto error;
+
+	if (!qmi_param_append_uint8(param, QMI_VOICE_DTMF_DATA, 0xff))
+		goto error;
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_STOP_CONTINUOUS_DTMF, param,
+			stop_cont_dtmf_cb, vd, NULL) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd->send_dtmf_data);
+	l_free(param);
+}
+
+static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct qmi_param *param = NULL;
+	uint8_t param_body[2];
+
+	DBG("");
+
+	param = qmi_param_new();
+
+	param_body[0] = 0xff;
+	param_body[1] = (uint8_t)dtmf;
+
+	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, sizeof(param_body),
+			param_body))
+		goto error;
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_START_CONTINUOUS_DTMF, param,
+			start_cont_dtmf_cb, vd, NULL) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	l_free(param);
+}
+
+static void send_one_dtmf_cb(const struct ofono_error *error, void *data)
+{
+	struct cb_data *cbd = data;
+	struct voicecall_data *vd = ofono_voicecall_get_data(cbd->user);
+	ofono_voicecall_cb_t cb = vd->send_dtmf_cb;
+
+	DBG("");
+
+	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
+			*vd->next_dtmf == 0) {
+		if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
+			CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		else
+			CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+		l_free(vd->full_dtmf);
+		vd->full_dtmf = NULL;
+	} else
+		send_one_dtmf(cbd->user,
+				*(vd->next_dtmf++),
+				send_one_dtmf_cb, vd->send_dtmf_data);
+}
+
+static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+
+	DBG("");
+
+	l_free(vd->full_dtmf);
+	vd->full_dtmf = l_strdup(dtmf);
+	vd->next_dtmf = &vd->full_dtmf[1];
+
+	vd->send_dtmf_data = data;
+	vd->send_dtmf_cb = cb;
+
+	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, NULL);
+}
+
 static void create_voice_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_voicecall *vc = user_data;
@@ -664,6 +776,7 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
 	qmi_service_unref(data->voice);
 
 	l_queue_destroy(data->call_list, l_free);
+	l_free(data->full_dtmf);
 	l_free(data);
 }
 
@@ -674,6 +787,7 @@ static const struct ofono_voicecall_driver driver = {
 	.answer		= answer,
 	.hangup_active  = hangup_active,
 	.release_specific  = release_specific,
+	.send_tones	= send_dtmf,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

