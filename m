Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36415AAA7
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093207; cv=none; b=TVDqEwcp4gvkCEVHS3ijynlF1tON/Pj2MRUnlMJfjOQ9/5176Nv6gg31UN4N4ZD8qKLuumuqpoLj1Q4TZimbP+EfK/dkeKOQHKUC/dibjoFoE3VoznYivsvvSGLA0YSolgVd9XkN3+dRPlqYZAeWHBdpXyxHa0r7K4lA5gd975s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093207; c=relaxed/simple;
	bh=WAOX32xmnVjpsxOAjhsEKxEtw8H1SAdpoOLu8WePGc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrUJPHztlrWWeh+Blv06B7lDBcmgvH05nVIrM50PRP/2eu+6PoK+mzTMhl8jr+R95ensqRjetmRkhceYauPPhzRm2+GPeHQq+wx9WXxlaYzamAPAg/Lj82woDdRYJDtgRtRYgpd4QOY0QTZYX2G1x1zAFfo3rB0f1X/6Y2CQmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKfqk7Kt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKfqk7Kt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-415446af364so1722555e9.0
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712093204; x=1712698004; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOFt0gjXeOf7nxE6RbtJOgCDN6R9zL6aBzXDEya3f1U=;
        b=aKfqk7KtOhcs14vf4KMLxZSrPkLW0LPDQJbP3F9s29DDN4U0IbiEuGX33PomIDQsBK
         vZyeca8DvxLpyGpy/XlEUbi+9w0+EXNOjozlfdTiFCsljNXi6QzNqmN3q9j4d1d3dhiq
         EXwWC2kqVp91conDbvkn2dgC6XmjVw4+O2J53cRdNOTSQXBD1CycSX00J0YJAvqA78Je
         zOfpFwU73XkG+SK/zdWvTS/P9I9yd7rnJC3lRw1t60b9+e0/M8/mW074TA/YGP1bKnkJ
         8+Z+1N6L70OXvyPqmWx3DTqIOECSXEFUbCci7UaKwEG+hiRdm4LgaQyIWbZ315RdUZvo
         m1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093204; x=1712698004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOFt0gjXeOf7nxE6RbtJOgCDN6R9zL6aBzXDEya3f1U=;
        b=kq46/foFQEOVbHH23oPUR/V/a4H+XGOlz5zkLrPJHaNyfq7DIRLL+ck7MSxRJF5NfA
         JTnRpKMVb4ES5Obv8PC0vQNxpLeFtGe3yaik89kv4KYl99fYJ8gEeFziKbIa/mH5vAOY
         u5EUG0rQOJ52gjVy8m6+d5AJYY+5Cv/fK5sLRF7IiI0F4q1PxuJGPIZ6oqR+vfujV+83
         lAxR3d2XTN6asvhLSUSH+mo4aWzswXZAW2aosWv9LOLvce1msWtVDxwfyiRtG/3XvVT3
         LPAh6pdhM/9mhjBqThxau+fT/I6c18z0Bb3aXigBZpvG6HA49uIKGpAtl5igAoMyclgq
         ZCaQ==
X-Gm-Message-State: AOJu0Yw1g9JxjacfcdNXVbndNCaV+N6E2mWcELQ3MqqyCvEMYM9miMwA
	saywxu0n1/UPEKNmQ9mjYBAB5LSRHaRE/e0sQDDSv5Zi4VyIZJfs6sGbUfAl9w4=
X-Google-Smtp-Source: AGHT+IH91SLyVwdUB3DCU3wldV7bF9dbWDJOAcomjbb4Q8SCbFk4k5h18PKYjPtltVjOxztKm6B6GQ==
X-Received: by 2002:a05:6000:1149:b0:341:c9bc:6340 with SMTP id d9-20020a056000114900b00341c9bc6340mr584938wrx.12.1712093204252;
        Tue, 02 Apr 2024 14:26:44 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b0033b6e26f0f9sm15215643wrp.42.2024.04.02.14.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:26:43 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v3 4/4] qmimodem: voicecall: Implement DTMF tones
Date: Tue,  2 Apr 2024 22:25:18 +0100
Message-ID: <20240402212625.5348-4-adam@piggz.co.uk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402212625.5348-1-adam@piggz.co.uk>
References: <20240402212625.5348-1-adam@piggz.co.uk>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The send_dtmf function sets up a call to send_one_dtmf, which will call
the QMI_VOICE_START_CONTINUOUS_DTMF service function.  The paramters to
this call are a hard coded call-id and the DTMF character to send.
start_cont_dtmf_cb will then be called which will set up a call to
QMI_VOICE_STOP_CONTINUOUS_DTMF to stop the tone.  Finally,
stop_cont_dtmf_cb will check the final status.
---
 drivers/qmimodem/voice.h     |  12 ++++
 drivers/qmimodem/voicecall.c | 131 +++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index caedb079..5b777af8 100644
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
@@ -85,6 +87,16 @@ enum qmi_voice_call_state {
 	QMI_VOICE_CALL_STATE_SETUP
 };
 
+enum qmi_voice_call_dtmf_param {
+	QMI_VOICE_DTMF_DATA = 0x01,
+};
+
+enum parse_error {
+	NONE = 0,
+	MISSING_MANDATORY = 1,
+	INVALID_LENGTH = 2,
+};
+
 struct qmi_ussd_data {
 	uint8_t dcs;
 	uint8_t length;
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 627719a8..4bdb64b7 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -42,6 +42,8 @@ struct voicecall_data {
 	uint16_t minor;
 	struct l_queue *call_list;
 	struct ofono_phone_number dialed;
+	char *full_dtmf;
+	char *next_dtmf;
 };
 
 struct qmi_voice_all_call_status_ind {
@@ -652,6 +654,134 @@ static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
 	release_specific(vc, call->id, cb, data);
 }
 
+static void stop_cont_dtmf_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_voicecall_cb_t cb = cbd->cb;
+
+	uint16_t error;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	l_free(cbd);
+}
+
+static void start_cont_dtmf_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_voicecall_cb_t cb = cbd->cb;
+	struct ofono_voicecall *vc = cbd->user;
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	uint16_t error;
+	struct qmi_param *param = NULL;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	param = qmi_param_new();
+	if (!param)
+		goto error;
+
+	if (!qmi_param_append_uint8(param, QMI_VOICE_DTMF_DATA, 0xff))
+		goto error;
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_STOP_CONTINUOUS_DTMF, param,
+			     stop_cont_dtmf_cb, cbd, NULL) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	l_free(cbd);
+	l_free(param);
+}
+
+static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct qmi_param *param = NULL;
+	uint8_t param_body[2];
+	struct cb_data *cbd = cb_data_new(cb, data);
+
+	DBG("");
+
+	cbd->user = vc;
+
+	param = qmi_param_new();
+	if (!param)
+		goto error;
+
+	param_body[0] = 0xff;
+	param_body[1] = (uint8_t)dtmf;
+
+	if (!qmi_param_append(param, QMI_VOICE_DTMF_DATA, sizeof(param_body),
+			      param_body)) {
+		goto error;
+	}
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_START_CONTINUOUS_DTMF, param,
+			     start_cont_dtmf_cb, cbd, NULL) > 0) {
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	l_free(cbd);
+	l_free(param);
+}
+
+static void send_one_dtmf_cb(const struct ofono_error *error, void *data)
+{
+	struct cb_data *cbd = data;
+	struct voicecall_data *vd = ofono_voicecall_get_data(cbd->user);
+	ofono_voicecall_cb_t cb = cbd->cb;
+
+	DBG("");
+
+	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
+	    *vd->next_dtmf == 0) {
+		if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
+			CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		else
+			CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+		l_free(vd->full_dtmf);
+		l_free(cbd);
+	} else {
+		send_one_dtmf(cbd->user,
+				*(vd->next_dtmf++),
+				send_one_dtmf_cb, data);
+	}
+}
+
+static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
+		      ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct cb_data *cbd = cb_data_new(cb, data);
+
+	DBG("");
+
+	vd->full_dtmf = l_strdup(dtmf);
+	vd->next_dtmf = &vd->full_dtmf[1];
+
+	cbd->user = vc;
+
+	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, cbd);
+}
+
 static void create_voice_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_voicecall *vc = user_data;
@@ -721,6 +851,7 @@ static const struct ofono_voicecall_driver driver = {
 	.answer		= answer,
 	.hangup_active  = hangup_active,
 	.release_specific  = release_specific,
+	.send_tones	= send_dtmf,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

