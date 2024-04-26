Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3A374C6
	for <ofono@lists.linux.dev>; Fri, 26 Apr 2024 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714166569; cv=none; b=oHBKGKBgnYF8rkbWGEayFuRkFo4kWI5PgyTxdxzGbEowXWBZdSVwIc5mC5pHN7NvLT3wiw1CnSOAO9vgN+PDW/hXjXmeuJ4EehdeDsdbRKsAXx9LDzwh8xRXICztxOf8FkPZ7Qv/HUYnGK2lNLko/2pv/vweWUNudU1d/bgzY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714166569; c=relaxed/simple;
	bh=g9PB64zl6N4MzJIvCae392q+DYqgvBi/fDmG4cQIOj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arbvZWQONEYN3HEzJkz9FJ9REnFn8rsZ+w/jEKlL/33jEiqiya5cbWXFhHkopsEkreCzm+YV6eW+iD465w2HstxRcKfZTM9A5V/HFru1oRDHwu9jUMIrsVabC4aqdpIfsACNdQfpk7WA5UjTjXs5hGkX/1Ix89vpTnWa9tkDv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOpXZiBs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOpXZiBs"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b794510cdso11644075e9.2
        for <ofono@lists.linux.dev>; Fri, 26 Apr 2024 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714166566; x=1714771366; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=aE/TfLEwqTsInPFrrP5MXDgKvulqVBXCvFS6+kYOxTY=;
        b=iOpXZiBsR44nIh73o6xnhtF8mpB/iKLOQjpCyVzy8MOaT3DOX5tMIEJHPuAzRgz0Q4
         OPShYPcawYrDhSxlr3JhAqF2j22F9LbEZzcPD0oxlF/QvRm4eO0ZkjFogIm62JxE6Amt
         U/rB2Mvc+qSIqucG2wp2b5v9kx6Cg4OSMPJTINH9TeUdhyFy1Org+qfutEX1AVPm5pTb
         4eZOiHiyADxddl0nX32ecpQVc0f5RL+6nkAYb200U3Z8uyAIxuNYSXTkN/3irUrHQabC
         WviesEflr8VetCQq/xSQABkDvv4sawKlP6TirA2mBMHaJi7Eww4ChHuBEJQsO+3nXIMj
         IG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714166566; x=1714771366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aE/TfLEwqTsInPFrrP5MXDgKvulqVBXCvFS6+kYOxTY=;
        b=sD8BX0UAiBy0ds2zpWiqmvA7o9V7PEbxrfGKE4jbgAzIJqkTos99QZfnon6XpxnD4r
         zAGu3hPQam8Xp5SeKqvqaRlodQeGRRIm+wzx41WH198niDpvKR3J4U+dWJf/wICNnhPg
         9aS9RrOixlJXB33aOYmgjgr3/tpIq9Rb8Fv9F2ZXYtp0APEjVA4iQVzTH7c5fr7rtSE9
         7M8fdNmBFslnfyucNmcGA9kGk9kyfQ9yyWK0XYBeQlMzGC0DS3eEwinGLCvI41pnjqM7
         zYNEiQefhybla5PMf56RqjDq82yX8SYVAr/c3NT+7T5SkYKQ601fRuk9LmeMv5lHpxAC
         eFcQ==
X-Gm-Message-State: AOJu0Yy34iEIXc3Tz5/HUwf3FdJ765mfEyOsVf+lWucQw+FOIKAxZEPc
	LXUUKuAVD6lopOcRMH2PzSVC/WTm+DoOB5ZGSVKltCFI0XzOw6buGoQP2A==
X-Google-Smtp-Source: AGHT+IG75fV9P4ulPiHYpRSIuCqnGEqzUq1SCNCFKqje9fI4Ikd7lShIg9vdBeOrd6aCPYGg6e90Jg==
X-Received: by 2002:a05:600c:19d3:b0:417:fbc2:caf8 with SMTP id u19-20020a05600c19d300b00417fbc2caf8mr2718673wmq.23.1714166565675;
        Fri, 26 Apr 2024 14:22:45 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm36303444wmo.5.2024.04.26.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:22:45 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v6] qmimodem: voicecall: Implement DTMF tones
Date: Fri, 26 Apr 2024 22:22:03 +0100
Message-ID: <20240426212235.2627-1-adam@piggz.co.uk>
X-Mailer: git-send-email 2.44.0
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

Changes in V5/V6
-Store the core cb and cbd obejects in the voicall_data struct
-Fix incorrect free calls
---
---
 drivers/qmimodem/voice.h     |   6 ++
 drivers/qmimodem/voicecall.c | 127 +++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index caedb079..92186b72 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -53,6 +53,8 @@ enum voice_commands {
 	QMI_VOICE_GET_ALL_CALL_INFO =		0x2f,
 	QMI_VOICE_END_CALL =			0x21,
 	QMI_VOICE_ANSWER_CALL =			0x22,
+	QMI_VOICE_START_CONTINUOUS_DTMF =       0x29,
+	QMI_VOICE_STOP_CONTINUOUS_DTMF =        0x2A,
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
index 7c9326fe..0df65226 100644
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
@@ -599,6 +603,127 @@ static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
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
+		CALLBACK_WITH_FAILURE(cb, cbd);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd);
+}
+
+static void start_cont_dtmf_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_voicecall_cb_t cb = cbd->cb;
+	struct ofono_voicecall *vc = cbd->user;
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	uint16_t error;
+	struct qmi_param *param;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd);
+		return;
+	}
+
+	param = qmi_param_new();
+
+	if (!qmi_param_append_uint8(param, QMI_VOICE_DTMF_DATA, 0xff))
+		goto error;
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_STOP_CONTINUOUS_DTMF, param,
+			stop_cont_dtmf_cb, cbd, cb_data_unref) > 0) {
+		cb_data_ref(cbd);
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	l_free(param);
+}
+
+static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = data;
+	struct qmi_param *param;
+	uint8_t param_body[2];
+	struct cb_data *cbd = cb_data_new(cb, data);
+
+	DBG("");
+
+	cbd->user = vc;
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
+			start_cont_dtmf_cb, cbd, cb_data_unref) > 0)
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
+	struct ofono_voicecall *vc = cbd->user;
+	struct voicecall_data *vd = cbd->data;
+
+	DBG("");
+
+	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
+			*vd->next_dtmf == 0) {
+		if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
+			CALLBACK_WITH_SUCCESS(vd->send_dtmf_cb, vd->send_dtmf_data);
+		else
+			CALLBACK_WITH_FAILURE(vd->send_dtmf_cb, vd->send_dtmf_data);
+
+		l_free(vd->full_dtmf);
+		vd->full_dtmf = NULL;
+	} else {
+		send_one_dtmf(vc,
+				*(vd->next_dtmf++),
+				send_one_dtmf_cb, vd);
+	}
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
+	vd->send_dtmf_data = data;
+	vd->send_dtmf_cb = cb;
+
+	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, vd);
+}
+
 static void create_voice_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_voicecall *vc = user_data;
@@ -656,6 +781,7 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
 	qmi_service_free(data->voice);
 
 	l_queue_destroy(data->call_list, l_free);
+	l_free(data->full_dtmf);
 	l_free(data);
 }
 
@@ -666,6 +792,7 @@ static const struct ofono_voicecall_driver driver = {
 	.answer		= answer,
 	.hangup_active  = hangup_active,
 	.release_specific  = release_specific,
+	.send_tones     = send_dtmf,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

