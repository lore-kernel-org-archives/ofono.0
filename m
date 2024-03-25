Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59574425
	for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405164; cv=none; b=lEYcz+mrtAWTyoYlPyuNDlzfHtM0HeQYzyVbacxCwYWcATJz+h8dHBNg8OO6IBNat1yuR414bS/CUvXt23Tmiu71hLgcFporrsBj4MEXsTK4WbMJCEe+zAFbcnHpIz/fw28EJ1SwqFjFH8a13hB/rcCnF2agkIPtsULDM/thT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405164; c=relaxed/simple;
	bh=WnwaaPKrWgKSrvzOmqNx7RNKJVzgogHouH5GdDs3B44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cp+YtT0Faa/XkadZquGqV92N0XBnospN1MVoK+EVErz0WwH7mj/K42IHn6junBfQmiRhxdNCys3jw3DRYDCUbpVaTMj0QxbUmaKCkpBQbSjenWVZOD8vmQwjpLiWFWiIR+UdGmTmR+y7yX3cZ1Eee4NANxnWOocMxnBPyFw6TI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn2hFlDm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn2hFlDm"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e285a33bdso2722223f8f.2
        for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711405160; x=1712009960; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVALEPoqc2Tr2C+yYZLPDF+N1+efHbf3BA5QneM5oCI=;
        b=jn2hFlDm8m2mJkHThCGOlrRTS18ZNQqtqLf7GICYNyWx9NTp6wUDPZrlde98hI2y5q
         53glVe+bqI3zlehXxY13GziLpllH68SuXE8UNoMA+PrvVBQu+RTUeSFRqKdwI6jBMhC3
         ubavywkRE1qgv5dm4o7dJ3XUuy4mOEo1/ewF716p9uIGeJhnbzHq3eMAz6VUPGkujrsq
         OQHxTyFp0xpRQBKKt+Ha1+C8zG6ekMaF3aKvF3pznra5CRYO4jM3pm0MvwbkLE+Qg0ih
         41Nwto0v1N9w9FCq/F0ljmbqu0D/9ayJfTE3z8OqVizoDOKdQdd4gG0mPZDBwV06Ttzp
         eLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405160; x=1712009960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GVALEPoqc2Tr2C+yYZLPDF+N1+efHbf3BA5QneM5oCI=;
        b=hsuOg+ctXYqXUBIQWtSsW/qsmGyV0Mhbshr43ftbUSvVDKZaqdiA8xHLOb3nIR60TS
         7wxzMjrnV6Yz5jeodARVNCjpB/qoRQ2Zia+Es1HzOkSv+Py2xIfmw58AFs6937P5a73T
         bVwzUkjeW5/kiteikGymI73OV8Q0glh6Of5VOjrudd/mjZlHtqRVEy1WLhzgx5hb2iCe
         stkoitH6myVv4rAVIsejE06XLI0WNgOWmhnWLdN0lDfyM+KNLArDz9JHg52ljRzeGrg7
         RCf0GwYtfKag9DwggfwTlcnWMyTn3yVzsVoPSp3Nr6REpy4cHfQjO74Y2hF5fKYT+xaM
         PI6g==
X-Gm-Message-State: AOJu0YxyJI2S/f++g5PeUSZJld9te8ZhjsyXlyj0f7BJ9CDBDq+h3UkG
	iLwQ1Fs7nprjUx0PtD7TtFwL3o9Laj/z61Uk8+I0fq5Wp744iWyt76+6t9cXVsU=
X-Google-Smtp-Source: AGHT+IFsA3PQEC0C3pCSd2Dx46hWzzCLuse3FgDbVNlIzW7yUpXr0roXBD6c/rVDZgg1TcAynZM1jw==
X-Received: by 2002:adf:f04c:0:b0:341:6aa6:6985 with SMTP id t12-20020adff04c000000b003416aa66985mr4600693wro.65.1711405160568;
        Mon, 25 Mar 2024 15:19:20 -0700 (PDT)
Received: from adam-laptop-hp.lan ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id n12-20020a056000170c00b00341d1da721dsm2163805wrc.65.2024.03.25.15.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:19:20 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH 4/4] [qmimodem][voicecall] Implement DTMF tones
Date: Mon, 25 Mar 2024 22:17:02 +0000
Message-ID: <20240325221742.5931-4-adam@piggz.co.uk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325221742.5931-1-adam@piggz.co.uk>
References: <20240325221742.5931-1-adam@piggz.co.uk>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/voice.h     |   6 ++
 drivers/qmimodem/voicecall.c | 154 +++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+)

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index 244a6f85..42b6b9b6 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -56,6 +56,8 @@ enum voice_commands {
 	QMI_VOICE_DIAL_CALL =			0x20,
 	QMI_VOICE_END_CALL =			0x21,
 	QMI_VOICE_ANSWER_CALL =			0x22,
+	QMI_VOICE_START_CONTINUOUS_DTMF =	0x29,
+	QMI_VOICE_STOP_CONTINUOUS_DTMF =	0x2A,
 	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
 	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
 	QMI_VOICE_GET_CALL_WAITING =		0x34,
@@ -128,6 +130,10 @@ enum qmi_voice_call_end_return {
 	QMI_VOICE_END_RETURN_CALL_ID = 0x10,
 };
 
+enum qmi_voice_call_dtmf_param {
+	QMI_VOICE_DTMF_DATA = 0x01,
+};
+
 enum parse_error {
 	NONE = 0,
 	MISSING_MANDATORY = 1,
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 4ef8adc1..ab4bd655 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -117,6 +117,21 @@ struct qmi_voice_end_call_result {
 	uint8_t call_id;
 };
 
+struct send_one_dtmf_cb_data {
+	const char *full_dtmf;
+	const char *next_dtmf;
+	struct ofono_voicecall *vc;
+};
+
+struct qmi_voice_start_cont_dtmf_arg {
+	uint8_t call_id;
+	uint8_t dtmf_char;
+};
+
+struct qmi_voice_stop_cont_dtmf_arg {
+	uint8_t call_id;
+};
+
 int ofono_call_compare(const void *a, const void *b, void *data)
 {
 	const struct ofono_call *ca = a;
@@ -742,6 +757,144 @@ static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
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
+}
+
+static void start_cont_dtmf_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_voicecall_cb_t cb = cbd->cb;
+	struct ofono_voicecall *vc = cbd->user;
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct qmi_voice_stop_cont_dtmf_arg arg;
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
+	arg.call_id = 0xff;
+
+	param = qmi_param_new();
+	if (!param) {
+		goto error;
+	}
+
+	if (!qmi_param_append_uint8(param, QMI_VOICE_DTMF_DATA, arg.call_id)) {
+		goto error;
+	}
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_STOP_CONTINUOUS_DTMF, param,
+			     stop_cont_dtmf_cb, cbd, NULL) > 0) {
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	l_free(param);
+}
+
+static void send_one_dtmf(struct ofono_voicecall *vc, const char dtmf,
+			  ofono_voicecall_cb_t cb, void *data)
+{
+	struct qmi_voice_start_cont_dtmf_arg arg;
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct qmi_param *param = NULL;
+	uint8_t param_body[2];
+	struct cb_data *cbd = cb_data_new(cb, data);
+
+	DBG("");
+
+	arg.call_id = 0xff;
+	arg.dtmf_char = (uint8_t)dtmf;
+
+	cbd->user = vc;
+
+	param = qmi_param_new();
+	if (!param)
+		goto error;
+
+	param_body[0] = arg.call_id;
+	param_body[1] = arg.dtmf_char;
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
+	ofono_voicecall_cb_t cb = cbd->cb;
+	struct send_one_dtmf_cb_data *send_one_dtmf_cb_data = cbd->user;
+
+	DBG("");
+
+	if (error->type != OFONO_ERROR_TYPE_NO_ERROR ||
+	    *send_one_dtmf_cb_data->next_dtmf == 0) {
+		if (error->type == OFONO_ERROR_TYPE_NO_ERROR) {
+			CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		} else {
+			CALLBACK_WITH_FAILURE(cb, cbd->data);
+		}
+		l_free((void *)send_one_dtmf_cb_data->full_dtmf);
+		l_free(send_one_dtmf_cb_data);
+		l_free(cbd);
+	} else {
+		send_one_dtmf(send_one_dtmf_cb_data->vc,
+			      *(send_one_dtmf_cb_data->next_dtmf++),
+			      send_one_dtmf_cb, data);
+	}
+}
+
+static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
+		      ofono_voicecall_cb_t cb, void *data)
+{
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct send_one_dtmf_cb_data *send_one_dtmf_cb_data =
+		l_new(struct send_one_dtmf_cb_data, 1);
+
+	DBG("");
+
+	send_one_dtmf_cb_data->full_dtmf = l_strdup(dtmf);
+	send_one_dtmf_cb_data->next_dtmf = &send_one_dtmf_cb_data->full_dtmf[1];
+	send_one_dtmf_cb_data->vc = vc;
+	cbd->user = send_one_dtmf_cb_data;
+
+	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, cbd);
+}
+
 static void create_voice_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_voicecall *vc = user_data;
@@ -810,6 +963,7 @@ static const struct ofono_voicecall_driver driver = {
 	.answer		= answer,
 	.hangup_active  = hangup_active,
 	.release_specific  = release_specific,
+	.send_tones	= send_dtmf,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

