Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796515E1F5
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093207; cv=none; b=RYPB286WnI0sWqbYeoye2BnolUU08i9MftU8xpBUqdVGZRvri3T7dpnPxlzJvMrv3e+LCxK4Qvmclfmwi6qsr+g7Sns6DXyf32i+R09UmkNeIWuyOfqlge75F14MjooqWeIYpp3ia1HcJA0uTxCelN8oJSMrExLsmRlTynVfVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093207; c=relaxed/simple;
	bh=GSPIKFAjOL9z8fgWaqCI5B0Pjm9nSTp9KCd/1YfL2MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgEVIDmzucrw52XnA+2h8/y8s19XOXZ9NnDGY9DVWJt1nTq5uIDPdq8EGTNbxiNejLZxpK93bnaYud+jltyOHVo25eYZR4xYMnXhNjX+JQVWKC+Sfa5WpuIhgAAl8jV018+0/1fAhoD4jS1dVO9w0C1TrtDHXjJgcRHoNUQrqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJQMf9aP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJQMf9aP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-341ccef5058so4134565f8f.2
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712093203; x=1712698003; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhkSB9lbJIfzvwq01KXiL5LedGTWyHyHaGkAPI9PSnM=;
        b=ZJQMf9aP1HGPgrvNFsSdAI/2LDtFezGVsDqEq5zcW35ypEM0ujVsHW5Z8oJ26iO1pA
         8k5B0HTK/RrmHUayGFAFmZfGapJI44AJBJ56BE7XGD8eu5ByXXoQuFoalWEa/A3Qwj3t
         btHyuRc9D53MlcGGcsxgpQmWCg7OS6Xak3pdJ4eEGqzhhjY1MqdfNGiS9btGQLVW64Ot
         uxZZKJiHhI809A8zxvs4IqFmf2ovJCuBiXkD6PE6S6+mlR2qPbAHqcS385jSSyf7mV83
         Uqe1pCO2Fshjg0kOnrqWUSGBkx2gDncv7etFzKEZVAOrHzpjEh8kjtP2tg2RDNyUyWU0
         bdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093203; x=1712698003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhkSB9lbJIfzvwq01KXiL5LedGTWyHyHaGkAPI9PSnM=;
        b=Lhiem7XIcmGjFAL2n+S4iOGHZPreWt6bJrno5nLwkFK/554aro62kvneVkIg5qqNi0
         RpbbnT4H//fnbVbh34fNrZUjeNTviWS5DJ5Y1dxv+lg13q3EGVG/hc+CJpKjHkW/2tSD
         +ZFimIMq4WHfIXaFl5OBaHNGJ8Aag3w8TTz0yRjc5wRW/bL5Eb4AdnHlPgFWD8FNoRJ9
         3AfHNreVet9zezN++58SpiSHGpdpO5D2pMj0ZV0fTSF7qVUN1Tm5UzDmy6TTflkiR5fl
         2MSJu4BljreUxlRmF9B/Cc33nIU+tpZinNEINmdnxCeMt1GTkDmH+bhNRS9ARqtB79Ae
         FLcA==
X-Gm-Message-State: AOJu0YzAxk1gNMbwFYcx8Iyq/osHD9RPoHTGSE6hoZUIT0riqTzlBEYt
	AC8R+fkfD1Yb56/V05pQE75NQfAhuAgPDWIg7RfSCNDHUay+MD/1druTRY+c4bU=
X-Google-Smtp-Source: AGHT+IGRSpPBi9JjHResi8BywV0tfobhBgTHpFwDw/RDAKWoRAOgmE2t2nw61Wt7Bp4c9sd4VY1Elg==
X-Received: by 2002:a05:6000:1d82:b0:33d:a70d:a9b2 with SMTP id bk2-20020a0560001d8200b0033da70da9b2mr10107123wrb.5.1712093202973;
        Tue, 02 Apr 2024 14:26:42 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b0033b6e26f0f9sm15215643wrp.42.2024.04.02.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:26:42 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v3 3/4] qmimodem: voicecall: Implement active call hangup
Date: Tue,  2 Apr 2024 22:25:17 +0100
Message-ID: <20240402212625.5348-3-adam@piggz.co.uk>
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

hangup_active iterates the current list of calls, looking for the first
active call and then calls release_specific.  This then sets up the
parameters for a call to QMI_VOICE_END_CALL, with the only paramters
being the call-id.

end_call_cb will then be called and will parse out the call-id and check
for success.
---
 drivers/qmimodem/voice.h     |  1 +
 drivers/qmimodem/voicecall.c | 84 +++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index a524cf98..caedb079 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -51,6 +51,7 @@ enum voice_commands {
 	QMI_VOICE_DIAL_CALL =			0x20,
 	QMI_VOICE_ALL_CALL_STATUS_IND =		0x2e,
 	QMI_VOICE_GET_ALL_CALL_INFO =		0x2f,
+	QMI_VOICE_END_CALL =			0x21,
 	QMI_VOICE_ANSWER_CALL =			0x22,
 	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
 	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 8ee49acf..627719a8 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -572,6 +572,86 @@ error:
 	l_free(param);
 }
 
+static void end_call_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_voicecall_cb_t cb = cbd->cb;
+	uint16_t error;
+	uint8_t call_id;
+
+	static const uint8_t QMI_VOICE_END_RETURN_CALL_ID = 0x10;
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	if (qmi_result_get_uint8(result, QMI_VOICE_END_RETURN_CALL_ID, &call_id))
+		DBG("Received end call result with call id %d", call_id);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void release_specific(struct ofono_voicecall *vc, int id,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param = NULL;
+
+	static const uint8_t QMI_VOICE_END_CALL_ID = 0x01;
+
+	DBG("");
+	cbd->user = vc;
+
+	param = qmi_param_new();
+	if (!param)
+		goto error;
+
+	if (!qmi_param_append_uint8(param, QMI_VOICE_END_CALL_ID, id))
+		goto error;
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_END_CALL, param, end_call_cb,
+		cbd, l_free) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	l_free(cbd);
+	l_free(param);
+}
+
+static void hangup_active(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
+				void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct ofono_call *call;
+	enum call_status active[] = {
+		CALL_STATUS_ACTIVE,
+		CALL_STATUS_DIALING,
+		CALL_STATUS_ALERTING,
+		CALL_STATUS_INCOMING,
+	};
+
+	DBG("");
+	for (uint32_t i = 0; i < L_ARRAY_SIZE(active); i++) {
+		call = l_queue_find(vd->call_list, ofono_call_compare_by_status,
+			L_INT_TO_PTR(active[i]));
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
@@ -594,7 +674,7 @@ static void create_voice_cb(struct qmi_service *service, void *user_data)
 	data->voice = qmi_service_ref(service);
 
 	qmi_service_register(data->voice, QMI_VOICE_ALL_CALL_STATUS_IND,
-			     all_call_status_ind, vc, NULL);
+				all_call_status_ind, vc, NULL);
 
 	ofono_voicecall_register(vc);
 }
@@ -639,6 +719,8 @@ static const struct ofono_voicecall_driver driver = {
 	.remove		= qmi_voicecall_remove,
 	.dial		= dial,
 	.answer		= answer,
+	.hangup_active  = hangup_active,
+	.release_specific  = release_specific,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

