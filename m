Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85375644A
	for <ofono@lists.linux.dev>; Sat, 13 Apr 2024 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045221; cv=none; b=fjvaCoGrggbEYlJ8kxCJOLaF08AeMUqlkn2tgNfAd/2XJSimUT6AsqyAJJPbCnPJ9KQkBeTkEqWwKBuyTKaV0VSCKrus+oKl6qx8KBm8o72VGnSf5Uwi8g5F4v9VISqsQOyyYXxqGIy7aii2ionOmYMBEEeSlYQkKI2ZYrJIoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045221; c=relaxed/simple;
	bh=sFrdFQOmRUlrDBXVwdzhI2YLW5GX4GIWdS+9Lyf16tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1+ls5IqNWursgzHGW6Qj5afmnTsCz2hhegbMIE8DSfO5qTtgkOwp8JI+TKWqLOkXpZk6G4/AyaaXDapRyiUOqZH4Y4oViNB4rQCpcS5WQAV5iHWS+9KQVcuzW5qBPLa7S2KwpmoJC5JCT6lxzLL6f1LN2dTh/Zk7UsmTw7jbd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HweKVOks; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HweKVOks"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343c891bca5so1275987f8f.2
        for <ofono@lists.linux.dev>; Sat, 13 Apr 2024 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713045218; x=1713650018; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smp6WNlNlvIgb1U+cCIO7RG8nmCsf+scXTqZp+fCqJE=;
        b=HweKVOksJLZR033yLv4ytKK6IECP1b9/2igqdB161g5jmv3mmbPReJ8iTj4KMfKfwl
         6JDCqRpTr8NMDvVXUzjnxMUFHnzURZImy1lRQZainK1SjFAVmUAKi+rex0b7t0+lvLzT
         LsHZrc+lmCAUVqARJenlYG5ycx0kpJKJBuAxH/kQh5LKWjyzQfOVNpHBrhrLVTv8PwJG
         gZ8ht4tkklFjD+BykPPuFLW8l1rwrWcYnLxIuZlusQpXXL3wHntulTcdtmDq8nUJyDoM
         d0Fp85c6U28MjJ7v/nnHJle5BvfuWN5j+9eh/gv/vd9woBiM9Vo0LvErKkPnDIbZ1wHp
         oihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045218; x=1713650018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smp6WNlNlvIgb1U+cCIO7RG8nmCsf+scXTqZp+fCqJE=;
        b=kcY0rKe9R4Gy4iWdTvWPDCxaMSqSm5s2g0rq7J52GdPlJXlv8oquMf5CfhIvb61IKR
         fm0S5X8cm10GQIabhXftYeRauprAhnAzpHeifPC/BUOW3PZaheLltc+dKUYJPZGflkHo
         FIjqGxQqJcVezPhqHl40nIZhbcVt76phvqVQRc7dVwj0tiNK1vwqXeEOMb/WFql5O0M/
         ZzNxOUusVp70fvn0ixx+U0sT8SPqdHZZkv8uwFrG3BnIUv/d+ds3hW4owRDx1JGtR9oW
         sBhvgEZlAR5bHD2lUP4fqm5U+t9hOQ4NeRVfc5MC4HVDgRsHAlTRsbSRLuigUxVVP5qS
         uBmw==
X-Gm-Message-State: AOJu0YzuoXbrZ0f0V7uYFIiDrPHm7TA4lXXnr30ShjumvQBrNx1yk8xK
	jGN/M1eOx30VPevtEgcXsRCOCUdeuwaDjk9j8iLVVWiw8gRwESXlRfXe9w==
X-Google-Smtp-Source: AGHT+IESMmxc78jHG2rTTxF2rjviojTF9HHoaTRv0qnwWCvRSqhtVmw1JOAiqOJ2/X5txr9gNiVrGA==
X-Received: by 2002:a5d:59a5:0:b0:343:41ef:ab30 with SMTP id p5-20020a5d59a5000000b0034341efab30mr6016388wrr.47.1713045218054;
        Sat, 13 Apr 2024 14:53:38 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([90.246.103.111])
        by smtp.gmail.com with ESMTPSA id r9-20020adff109000000b00341de3abb0esm7423472wro.20.2024.04.13.14.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 14:53:37 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v4 4/4] qmimodem: voicecall: Implement DTMF tones
Date: Sat, 13 Apr 2024 22:53:13 +0100
Message-ID: <20240413215318.12236-4-adam@piggz.co.uk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413215318.12236-1-adam@piggz.co.uk>
References: <20240413215318.12236-1-adam@piggz.co.uk>
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
---
---
 drivers/qmimodem/voice.h     |   6 ++
 drivers/qmimodem/voicecall.c | 131 +++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

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
index 396732ad..f3111c9d 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -42,6 +42,8 @@ struct voicecall_data {
 	uint16_t minor;
 	struct l_queue *call_list;
 	struct ofono_phone_number dialed;
+	char *full_dtmf;
+	const char *next_dtmf;
 };
 
 struct qmi_voice_call_information_instance {
@@ -614,6 +616,133 @@ static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
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
+	struct qmi_param *param;
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
+	cb_data_ref(cbd);
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
+			*vd->next_dtmf == 0) {
+		if (error->type == OFONO_ERROR_TYPE_NO_ERROR)
+			CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		else
+			CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+		l_free(vd->full_dtmf);
+		vd->full_dtmf = NULL;
+		l_free(cbd);
+	} else {
+		send_one_dtmf(cbd->user,
+				*(vd->next_dtmf++),
+				send_one_dtmf_cb, data);
+	}
+}
+
+static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct cb_data *cbd = cb_data_new(cb, data);
+
+	DBG("");
+
+	l_free(vd->full_dtmf);
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
@@ -673,6 +802,7 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
 	qmi_service_unref(data->voice);
 
 	l_queue_destroy(data->call_list, l_free);
+	l_free(data->full_dtmf);
 	l_free(data);
 }
 
@@ -683,6 +813,7 @@ static const struct ofono_voicecall_driver driver = {
 	.answer		= answer,
 	.hangup_active  = hangup_active,
 	.release_specific  = release_specific,
+	.send_tones	= send_dtmf,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

