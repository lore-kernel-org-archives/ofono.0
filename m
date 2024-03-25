Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579773526
	for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405163; cv=none; b=BJh1UWCvJyNqIkeYUu6t1a3zSfxflJPQymbxWAGSPZORBSz38vD7ti9mh5R34zUFZoHPcmJe8beII3ozvidb3CnWQX9k0HcwnKybVDgDs7hS4dDYtZbqESXjjfTxNF+FkhezOV7bKj/lBIlJilhRmSBAUC0d5j7FaTVi+ESfnf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405163; c=relaxed/simple;
	bh=VMZHQMkuf46iuLDMb6sTLI4b7+E5Lcw3MSpwQ9ALWSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB0V0dmzuVtSLihWXtjxdzlVuChboRbQwjate5KlwWBOyFVgVDg1VNlaBKOrV06h2nRFyhs+QsBbDO/1L4IdjyM6wM0ZEwfpxwZe1VMd0IRjE4+lRebnJINcDA//MoDy/YAR4/SLOhpoTXrvvqIh9x5FGYliHye5mNUYWOd9DQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2l0xD/n; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2l0xD/n"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-341cf28e013so820758f8f.3
        for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711405159; x=1712009959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXhbVdY2gtZolOFyzs6V0IQChpAmU4PQiCJJ4Ukbj7g=;
        b=U2l0xD/nrKYvSj7VpNiuUrDwGWBjjKmDtLPmLOGUh3hIbN1TxKdIzXKZ8335/eJWE9
         COWg/rDTYvNN8PjNRl3Vmn2L4GsqSOliRd3Qdqzz0AE2sujQlA3/+D36wd2DOffGPzke
         yoROqUaU5zsA0QFR+gl3bE7d8xhdsWxQ8Pr6UjCmul+lyxY6ZTnsfHoQ6c5E6pqIiPi5
         brJIGTnqpVdahTMcyqKdYRouThJnoczrZCLYN0kIlZrHXpGyPXdZNx7y5VMobFskFRaW
         8okDse2dIYsLNsWlWJux70s7NUEqSPMkmtUD39SVvEPPMkNyM8JrytAE7xs3krDNoqDG
         GpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405159; x=1712009959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXhbVdY2gtZolOFyzs6V0IQChpAmU4PQiCJJ4Ukbj7g=;
        b=TCe8APW+inx1Vr5m8MnKyyUMD0mzaWH1yhT6qsMDFeaBQMh6wnkbzvWGI1i8GVkCBN
         1pu5twcycYkvvAtBE12AnFw3RSHZi9PoJUCbq8yQDaJccmerVHiJq8drLNumEaE3RbxW
         FJ0rxZvjRrETY2CkXLRrsPSRxpTQzog1NPtL0gHNC6kHGED04UYXHeU2uUOz6e/l6yv1
         QUBOyPcyzNQuYLRqOI3XGG1tea8fhz+pUNbgubqcOZOOrH0h7nDRcxVsT9nJv2uMy3YK
         NQThNkwnuGUxnrZFi52mWojWP+dNdaY7709aCtogLjPJo9IU6lfjiFWQ2NEx1S34V26E
         uLAA==
X-Gm-Message-State: AOJu0Yz16dRO4C8FVhpl++O/MtSd2SenlW7/KOg5ka/u9pgahol31yWl
	6FlACZODFfURPCuxg9JS7L4f1iDWy5PmPovHj6W449VmOOKo91YrFWdKXzeErHs=
X-Google-Smtp-Source: AGHT+IFO5ChY7j4HdVBBSNGp0QaeqLZKiGYn9c7i7fEajWNZVv50x4nqWixrMf+nkQ9WZNHbWbqtFQ==
X-Received: by 2002:a05:6000:1105:b0:33e:798f:6d1e with SMTP id z5-20020a056000110500b0033e798f6d1emr6011775wrw.37.1711405159066;
        Mon, 25 Mar 2024 15:19:19 -0700 (PDT)
Received: from adam-laptop-hp.lan ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id n12-20020a056000170c00b00341d1da721dsm2163805wrc.65.2024.03.25.15.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:19:18 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH 3/4] [qmimodem][voicecall] Implement active call hangup
Date: Mon, 25 Mar 2024 22:17:01 +0000
Message-ID: <20240325221742.5931-3-adam@piggz.co.uk>
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
 drivers/qmimodem/voice.h     |   9 +++
 drivers/qmimodem/voicecall.c | 113 +++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index 9c31297b..244a6f85 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -54,6 +54,7 @@ enum qmi_ussd_user_required {
 /* QMI service voice. Using an enum to prevent doublicated entries */
 enum voice_commands {
 	QMI_VOICE_DIAL_CALL =			0x20,
+	QMI_VOICE_END_CALL =			0x21,
 	QMI_VOICE_ANSWER_CALL =			0x22,
 	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
 	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
@@ -119,6 +120,14 @@ enum qmi_voice_call_answer_return {
 	QMI_VOICE_ANSWER_RETURN_CALL_ID = 0x10,
 };
 
+enum qmi_voice_call_end_param {
+	QMI_VOICE_END_CALL_ID = 0x01,
+};
+
+enum qmi_voice_call_end_return {
+	QMI_VOICE_END_RETURN_CALL_ID = 0x10,
+};
+
 enum parse_error {
 	NONE = 0,
 	MISSING_MANDATORY = 1,
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 7c6bc113..4ef8adc1 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -107,6 +107,16 @@ struct qmi_voice_answer_call_result {
 	uint8_t call_id;
 };
 
+struct qmi_voice_end_call_arg {
+	bool call_id_set;
+	uint8_t call_id;
+};
+
+struct qmi_voice_end_call_result {
+	bool call_id_set;
+	uint8_t call_id;
+};
+
 int ofono_call_compare(const void *a, const void *b, void *data)
 {
 	const struct ofono_call *ca = a;
@@ -631,6 +641,107 @@ error:
 	l_free(param);
 }
 
+enum parse_error
+qmi_voice_end_call_parse(struct qmi_result *qmi_result,
+			 struct qmi_voice_end_call_result *result)
+{
+	int err = NONE;
+
+	/* optional */
+	if (qmi_result_get_uint8(qmi_result, QMI_VOICE_END_RETURN_CALL_ID, &result->call_id))
+		result->call_id_set = 1;
+
+	return err;
+}
+
+static void end_call_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_voicecall_cb_t cb = cbd->cb;
+	uint16_t error;
+	struct qmi_voice_end_call_result end_result;
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	if (qmi_voice_end_call_parse(result, &end_result) != NONE) {
+		DBG("Received invalid Result");
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void release_specific(struct ofono_voicecall *vc, int id,
+		     ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_voice_end_call_arg arg;
+	struct qmi_param *param = NULL;
+
+	DBG("");
+	cbd->user = vc;
+
+	arg.call_id_set = true;
+	arg.call_id = id;
+
+	param = qmi_param_new();
+	if (!param)
+		goto error;
+
+	if (arg.call_id_set) {
+		if (!qmi_param_append_uint8(param, QMI_VOICE_END_CALL_ID, arg.call_id)) {
+			goto error;
+		}
+	}
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_END_CALL, param, end_call_cb, cbd, l_free) >
+	    0) {
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	l_free(cbd);
+	l_free(param);
+}
+
+static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
+			  void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct ofono_call *call;
+	enum call_status active[] = {
+		CALL_STATUS_ACTIVE,
+		CALL_STATUS_DIALING,
+		CALL_STATUS_ALERTING,
+		CALL_STATUS_INCOMING,
+	};
+	int i;
+
+	DBG("");
+	for (i = 0; i < L_ARRAY_SIZE(active); i++) {
+		call = l_queue_find(vd->call_list, ofono_call_compare_by_status,
+				    L_INT_TO_PTR(active[i]));
+
+		if (call)
+			break;
+	}
+
+	if (call == NULL) {
+		DBG("Can not find a call to hang up");
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	release_specific(vc, call->id, cb, data);
+}
+
 static void create_voice_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_voicecall *vc = user_data;
@@ -697,6 +808,8 @@ static const struct ofono_voicecall_driver driver = {
 	.remove		= qmi_voicecall_remove,
 	.dial		= dial,
 	.answer		= answer,
+	.hangup_active  = hangup_active,
+	.release_specific  = release_specific,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

