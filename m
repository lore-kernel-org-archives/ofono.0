Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D945C911
	for <ofono@lists.linux.dev>; Tue, 26 Mar 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448474; cv=none; b=tOXhD2sKggkUscIpVVj6GgzocynN7DviaIBRDw3MKXqZFm/14J9es4ayYfDGC/OFJs1CVoouLD2+HssmfGP9ogJdtU+NvDZ9EJPtjJYLL5yBKN2FyT4cUCPrtyfgSCkUEMcCH4d8dnF9D850H8zFavJROSnZ7ipWpoB+s8sZEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448474; c=relaxed/simple;
	bh=+g4tZvvAAAL4kmeDR74bUCEV/OlAhvS6cP5ahOUGUDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0dw27IdFGHQJlCm6IjCnOf3gWX4P+WWQNiO8lSCuxm+ZtH4WU1B7urznQKrnDpqjk5QixqYnRUYhLRNLfqS8aP7RUcCfixQzHSf8jjFSwX311DE5mgodQv3y61KJts147WIVtJiCeZPry834yoypKXnqYHJD6XnZLmQUWGpQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=capmv6eR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="capmv6eR"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6ee81bc87so2899471fa.1
        for <ofono@lists.linux.dev>; Tue, 26 Mar 2024 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711448470; x=1712053270; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7VXp38LaXSrk70hU1xw56MvwtvFlGNSK5bLHR7W3tM=;
        b=capmv6eR9QQMezm113BKopKQDS8Cpmb0LlLAUOoRkFeV55D2YjoAbRQnvy578IEUVk
         x217zfvmnuF8OcsYIZFCOLvYkQJZZcKP/XsppBOpX190SJ8TIZk+ZrsllPjtV7JoSRY+
         bEt+PqGD7LPdk9t7WbOXEnv0lVtNrmoCHL9VvvGuaWrfoKAcubVnd5X4BL3OkfBmtFez
         Eb60Z27lMEb7zu80zyDABk+TJQrlS9GW6I8q10uH33GLWN8ztt/FWtWpzoATGMMzAR5W
         U051rS7dtUsTcxEj8MYKGqWaT3dANvGmgycxyz7hvSGHZz7cAfPn8mZVNbMziSnDss2t
         WeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448470; x=1712053270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V7VXp38LaXSrk70hU1xw56MvwtvFlGNSK5bLHR7W3tM=;
        b=UvprpoegN++jNz/YSqoNpo8zqW31tOXS14ehqmwygItBRJzHIDs2ZdEg6HAAL98EtD
         T9Jbn+VSvTiK8kugkPHqnnMBQ+MlI/J25NZWlGLqwhSvIOqON8uchCR+9Jg1FTe/hP60
         jqUZj74GOP8okV7Ur4j51HwFWNHtM2OYSqazXKvWZKxSAAXvR1fza65FuocHeCnP7ybl
         myoFhyU2n5Vc2uH2jrAmIJ56AbT3CZkyczOaHIXznu7FZfl2t0NxSWaAPW68F6av3XZg
         Fmxi/b3PTRucyh6qE7zbP38KNlHa1aZp3Zv1M3vSrlC3c46ALzu4mx0UJVwr/sLAKPff
         dIXA==
X-Gm-Message-State: AOJu0YyVrBKVrlxET1fQn8IHPbHHX+RZUs8UjwLYukrveeS5io4EqFfy
	Ayd1bsy2o7Bb45eAk6U9DoSMdWQK/RlyI8P1TnSc4Ys/hphG8OOrqIb/cFaCde4=
X-Google-Smtp-Source: AGHT+IE1+yOKZl70BnMvJwZkXtzQ1RSXhaTooaqu8pqRANXmwo7MUaTLxZ92LXrMF//3NfhfleROow==
X-Received: by 2002:a2e:b0f8:0:b0:2d3:1dcc:3b25 with SMTP id h24-20020a2eb0f8000000b002d31dcc3b25mr6264449ljl.10.1711448467397;
        Tue, 26 Mar 2024 03:21:07 -0700 (PDT)
Received: from adam-laptop-hp.lan ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b00414903d20aesm676366wmq.11.2024.03.26.03.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:21:06 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v2 4/4] [qmimodem][voicecall] Implement DTMF tones
Date: Tue, 26 Mar 2024 10:19:59 +0000
Message-ID: <20240326102054.30946-4-adam@piggz.co.uk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326102054.30946-1-adam@piggz.co.uk>
References: <20240326102054.30946-1-adam@piggz.co.uk>
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

