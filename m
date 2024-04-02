Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26E15E1F3
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093205; cv=none; b=LgrvImnZvAaiY0QNoZctwepp4FIBJW0KQrEnd17HH1okv07kdUCErCLgx7fXlw3keJXXddQ/5OBXj+WCepYtLyX8kXoTD91Nf7i4pUn8rtWuzHRHVArIqQ/6CSHk9J5wKzLscJPt88ADORCRst1S7q5Yz33f0XZ+COIuZbIrAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093205; c=relaxed/simple;
	bh=7/1OUGNgTsBugKyMOvEtdmKQOn8LhoxU5RQrJWP0gLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJJnkyrbWmY5cis7etHtQn8e+7n0a8g+BhlUWMy0ZGjh/LeYnoDwhj1BZ3gWaVtBlasJ46EamyUiOX60fMBhokWmRkN2hQxd0XYDG9zcKOdx3YXPa0rtTEhxUCYcEfwGm0egmUQWRNYRVMm1OrW5CcOQ8P6Cgc5uQVlw4KkQm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPiheEsz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPiheEsz"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34356c24701so723612f8f.1
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712093202; x=1712698002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXnmq4zWsC0VWYqb8Lo6ZfP0xrXT14MD46tG9HaS8fY=;
        b=NPiheEszroqRM3lkYEYaoSrrrtkXKI7G+Q60bpktH3KoqkuPrP0LlScG3K/yCP7B/Y
         I4yBDnu+3UVj9JP+a6CNPpyqgY5hJtWNXug8/SUSGfl6FAv4hsHMnRG++waaOa5NxZ6I
         XZPKntDLxgciaM4L/uEY01ul5D+WPO77MLLUZnRiN5EEG9eJPMOktBltSr/TC74FuJ5T
         sBJXPnPu0jl4Y40ayv/R+KvILXASavrza2ngTIFEQA1Ii6WIzV143lkUSs8kejp3ltA7
         m124mdJN3NaIL5dgq4PxWzHdsGZONnMtJnAMsrvfZKTpXetUtHXOWVHj1EdDdpDOmipV
         gbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093202; x=1712698002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FXnmq4zWsC0VWYqb8Lo6ZfP0xrXT14MD46tG9HaS8fY=;
        b=jtUr364v5co+7G8cEL0EfCHAi5HEgCq7Eavrw2WB1nDW7mbDJqWFzZNw+pbIIKd5eQ
         rYee4vnjWSAnYY/9dtRuwvlpQZ21A1Smy26TGNGJcm71DUFJz0p55frH4PqzHTq8yizj
         fapEACEGEC+zcT92PUKS3G0IEh9eIWRavdwh40QV3Q3zR0ou0sj9DdaKENJ8bwSTeL+P
         mBbl3jmURhl7tscIH5A0D3sJ6kaWO43RMUFRhNW3NyUu8Kvm9oo40BfNrupEf+OBjuaV
         5af7BadUoBFXxLnsq1gOOYANVrxcL+nqJ8FydcZxwPjjDH1Oi12wNs0h8E/5xnfi7sB9
         cpfA==
X-Gm-Message-State: AOJu0YyVj97ktH9SJtwCXX1fqnRJwo5jaqYbvg9HXUJjtSistZ2HTBm1
	PqKbttP6/EJwmTQdFkXyPeW6G/FZHg8XTydD0HnauFv2LEBGmKaIfzZ97QwzDvw=
X-Google-Smtp-Source: AGHT+IEDku+LHRRSvJbta2ZSe6uij/Ru3vcDiI8q2uP9aBqsDEtTzLuMP/komDu4iPfhN1K0mInahQ==
X-Received: by 2002:adf:9bcf:0:b0:343:796f:70c6 with SMTP id e15-20020adf9bcf000000b00343796f70c6mr1298599wrc.17.1712093202009;
        Tue, 02 Apr 2024 14:26:42 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b0033b6e26f0f9sm15215643wrp.42.2024.04.02.14.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:26:41 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v3 2/4] qmimodem: voicecall: Implement call answer
Date: Tue,  2 Apr 2024 22:25:16 +0100
Message-ID: <20240402212625.5348-2-adam@piggz.co.uk>
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

The answer function set up the parameters for a call to the service
function QMI_VOICE_ANSWER_CALL.  The only parameter is the call-id.
anser_cb will then be called which retrieves the call-id and checks
the status of the result.
---
 drivers/qmimodem/voice.h     |  1 +
 drivers/qmimodem/voicecall.c | 65 ++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index 2344fd50..a524cf98 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -51,6 +51,7 @@ enum voice_commands {
 	QMI_VOICE_DIAL_CALL =			0x20,
 	QMI_VOICE_ALL_CALL_STATUS_IND =		0x2e,
 	QMI_VOICE_GET_ALL_CALL_INFO =		0x2f,
+	QMI_VOICE_ANSWER_CALL =			0x22,
 	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
 	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
 	QMI_VOICE_GET_CALL_WAITING =		0x34,
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index cadb5adf..8ee49acf 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -508,6 +508,70 @@ error:
 	l_free(param);
 }
 
+static void answer_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_voicecall_cb_t cb = cbd->cb;
+	uint16_t error;
+	uint8_t call_id;
+
+	static const uint8_t QMI_VOICE_ANSWER_RETURN_CALL_ID = 0x10;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	if (qmi_result_get_uint8(result, QMI_VOICE_ANSWER_RETURN_CALL_ID, &call_id))
+		DBG("Received answer result with call id %d", call_id);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void answer(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct ofono_call *call;
+	struct qmi_param *param = NULL;
+
+	static const uint8_t QMI_VOICE_ANSWER_CALL_ID = 0x01;
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
+		DBG("Can not find a call to pick up");
+		goto error;
+	}
+
+	param = qmi_param_new();
+	if (!param)
+		goto error;
+
+	if (!qmi_param_append_uint8(param, QMI_VOICE_ANSWER_CALL_ID,
+		call->id))
+		goto error;
+
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_ANSWER_CALL, param,
+		answer_cb, cbd, l_free) > 0)
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
@@ -574,6 +638,7 @@ static const struct ofono_voicecall_driver driver = {
 	.probe		= qmi_voicecall_probe,
 	.remove		= qmi_voicecall_remove,
 	.dial		= dial,
+	.answer		= answer,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

