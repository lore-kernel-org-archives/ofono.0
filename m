Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A55C911
	for <ofono@lists.linux.dev>; Tue, 26 Mar 2024 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448468; cv=none; b=J3YHErLKS3HPanCBD582uKkOUhhph2NxpgOgqCfHB9Q8JO6i/XcSFDq4wE8w2LE7g3wQoy8UcYn08U2ArZiZlUc5E7VgZ0ol7qMVcoWofxz07A8vnoa2b2m/idyK5kLS70Kattly3nKlQrXEfpoac09hd6kyeibF1a7TdflUdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448468; c=relaxed/simple;
	bh=Kma3YkR0nFAtfbtCcM7tCSaN8X+E5lpmMXrCS0p9Zvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLr4jX8jPv12pgWN1YiquLN22A8bKwnNPVpbqyxF8wOhbUsizUHUfbfH6nHPvn6fq9Y7EDCTj2imM1fvWkB7Nwh1xLxyuqxdVzDrDifvEkKtdPOTv7K8GfLU+Dtxdc8GTrBtrNUlhQ5hOO0TqO9E5zR0ViTJ7MzC+Qb0/a/uADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzYOhV0m; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzYOhV0m"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d24a727f78so59930591fa.0
        for <ofono@lists.linux.dev>; Tue, 26 Mar 2024 03:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711448464; x=1712053264; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYrRsY44ChALgOxh7gfaEXOX4VP63na72Fb8ig4xK4Q=;
        b=XzYOhV0m4R5w24yXtEgfDV+akwOKgbdpDsn9ZW8ghDPjF1FT9jsWMuPPy+T/MiE8HF
         n1vGq9NpPe3BqNoD01u+5GeqJ0QU37bFRShiq45YDPffq7kvowBFiM8RG4v/PxLUjB/X
         A9ic/E8WD2vq3cofC3yuWnUNK0gQXKgzg+6r1wLpRAYFVh+PkpVT3u+pqSjlblDoDtMM
         cgk1J8b2HJ2X0eloGLB21A3jcOBETBqJYC8OQqHEylz/cKovL1b9R5ymOSPU6oa5rzYB
         6IT2LFoZDuxlTT+CvmG0/hqtKepyhvWc7kQ+8zCRZb6auQ4Qn/2jWmf9G8Iv1xVVnS4p
         JHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448464; x=1712053264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zYrRsY44ChALgOxh7gfaEXOX4VP63na72Fb8ig4xK4Q=;
        b=NNLybobCGc3k4sL/vfvNy4vOR9lK8Gmju5TEt66rGAT2A9o47vzaocElTa2E+dPilr
         vZ7Y9Z5TJm5heMBGFcEqrFFSBfbnIbRdxlrTDmus+UiEAj+SIvu16FadrPtPieJfpdwu
         dEieD1/UyLqveoFZRq8ZSngJNauixzp5AwrISS3goW/tZfUwFLZgIyp1NpdqKqY2lNee
         asyKP11uk75Ua/mi2rUthXYoonXmPvWC6NxX3Qf66QljR83gXeYSXsQ3vQpPKk6obFsb
         a7gBMIQnIPdknSf0W2JZ2rW3dyXhqD5Z/eElCAhsoC0yUKp95i6hCwItNZkoVZKnW4qF
         iU9w==
X-Gm-Message-State: AOJu0YzWQCbF+sJNvRMfLuaxg6Kiym6WtIyLL2N1MVxpUktrKxZZH9l/
	ixx9t/zMLKvWCm21Cp7hU8gu3Y4zrO89R/pp3Qlty7EaoMG8XT+FoHsX87Gj0cM=
X-Google-Smtp-Source: AGHT+IEX9bAICyVRjHBcqZrEXl/D48A35uqhZ1695G7BV0KkPyWdxdvggwNJKYrx1Tu7W9aI1q3FVQ==
X-Received: by 2002:a2e:b8c2:0:b0:2d4:6a6a:22bf with SMTP id s2-20020a2eb8c2000000b002d46a6a22bfmr1899534ljp.23.1711448463664;
        Tue, 26 Mar 2024 03:21:03 -0700 (PDT)
Received: from adam-laptop-hp.lan ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b00414903d20aesm676366wmq.11.2024.03.26.03.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:21:03 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v2 2/4] [qmimodem][voicecall] Implement call answer
Date: Tue, 26 Mar 2024 10:19:57 +0000
Message-ID: <20240326102054.30946-2-adam@piggz.co.uk>
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

The answer function set up the parameters for a call to the service
function QMI_VOICE_ANSWER_CALL.  The only parameter is the call-id.
anser_cb will then be called which retrieves the call-id and checks
the status of the result.
---
 drivers/qmimodem/voice.h     |  9 ++++
 drivers/qmimodem/voicecall.c | 99 ++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index 1a584f10..9c31297b 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -54,6 +54,7 @@ enum qmi_ussd_user_required {
 /* QMI service voice. Using an enum to prevent doublicated entries */
 enum voice_commands {
 	QMI_VOICE_DIAL_CALL =			0x20,
+	QMI_VOICE_ANSWER_CALL =			0x22,
 	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
 	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
 	QMI_VOICE_GET_CALL_WAITING =		0x34,
@@ -110,6 +111,14 @@ enum qmi_voice_call_type {
 	QMI_VOICE_CALL_TYPE_VOICE_FORCE,
 };
 
+enum qmi_voice_call_answer_param {
+	QMI_VOICE_ANSWER_CALL_ID = 0x01,
+};
+
+enum qmi_voice_call_answer_return {
+	QMI_VOICE_ANSWER_RETURN_CALL_ID = 0x10,
+};
+
 enum parse_error {
 	NONE = 0,
 	MISSING_MANDATORY = 1,
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 55c7009a..7c6bc113 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -97,6 +97,16 @@ struct qmi_voice_dial_call_result {
 	uint8_t call_id;
 };
 
+struct qmi_voice_answer_call_arg {
+	bool call_id_set;
+	uint8_t call_id;
+};
+
+struct qmi_voice_answer_call_result {
+	bool call_id_set;
+	uint8_t call_id;
+};
+
 int ofono_call_compare(const void *a, const void *b, void *data)
 {
 	const struct ofono_call *ca = a;
@@ -533,6 +543,94 @@ error:
 	l_free(param);
 }
 
+enum parse_error qmi_voice_answer_call_parse(
+	struct qmi_result *qmi_result,
+	struct qmi_voice_answer_call_result *result)
+{
+	int err = NONE;
+
+	/* optional */
+	if (qmi_result_get_uint8(qmi_result, QMI_VOICE_ANSWER_RETURN_CALL_ID, &result->call_id))
+		result->call_id_set = 1;
+
+	return err;
+}
+
+static void answer_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_voicecall_cb_t cb = cbd->cb;
+	uint16_t error;
+	struct qmi_voice_answer_call_result answer_result;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	/* TODO: what happens when calling it with no active call or wrong caller id? */
+	if (qmi_voice_answer_call_parse(result, &answer_result) != NONE) {
+		DBG("Received invalid Result");
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void answer(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_voice_answer_call_arg arg;
+	struct ofono_call *call;
+	struct qmi_param *param = NULL;
+
+	DBG("");
+
+	cbd->user = vc;
+
+	call = l_queue_find(vd->call_list,
+					ofono_call_compare_by_status,
+					L_UINT_TO_PTR(CALL_STATUS_INCOMING));
+
+	if (call == NULL) {
+		DBG("Can not find a call to answer");
+		goto error;
+	}
+
+	arg.call_id_set = true;
+	arg.call_id = call->id;
+
+	param = qmi_param_new();
+	if (!param)
+		goto error;
+
+	if (arg.call_id_set) {
+		if (!qmi_param_append_uint8(
+			param,
+			QMI_VOICE_ANSWER_CALL_ID,
+			arg.call_id))
+			goto error;
+	}
+
+	if (qmi_service_send(vd->voice,
+		QMI_VOICE_ANSWER_CALL,
+		param,
+		answer_cb,
+		cbd,
+		l_free) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	l_free(cbd);
+	l_free(param);
+}
+
 static void create_voice_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_voicecall *vc = user_data;
@@ -598,6 +696,7 @@ static const struct ofono_voicecall_driver driver = {
 	.probe		= qmi_voicecall_probe,
 	.remove		= qmi_voicecall_remove,
 	.dial		= dial,
+	.answer		= answer,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

