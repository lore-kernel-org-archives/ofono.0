Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267665644F
	for <ofono@lists.linux.dev>; Sat, 13 Apr 2024 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045219; cv=none; b=mwNcbKlCjsjPAa+yV+sPAxcRSj8vuPERlTu4uiflqHhBU7hU0WJZBuoDBSOUcr+nuZGuZwHyeJ4ZDAAsQzq/qmuTeCDWm+YIrIVRo5UPpIK3MyHl0f5R0qt/4Cil4FFBjstDVIgA7wBIM0kRdJIQbP37bqbkI79fXglkGhpbETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045219; c=relaxed/simple;
	bh=r3R855SyZBfDjkmespWoQdJQRW+ax6WrADoMem7EeHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMUyrDQ2gpjeYD7q6yW8YFjHSp3R4oOBIJWsbEtfFlrl4R5JFQPRI5F2Z8v9cS2AC3iKGk2LgRfi5yUf6PL/H1ZN13GMRGD1yz9IL50Xhu5B/XxV66zuw3dWCCRSq8OfvnQnJo77idSGmxS/zwwfK88uag3ntialweetUyXb3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h721fFF7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h721fFF7"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343b7c015a8so1440716f8f.1
        for <ofono@lists.linux.dev>; Sat, 13 Apr 2024 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713045216; x=1713650016; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m68b/eoX9kaFQlfc15r8E7BQLVdz6kAoD5TfCrZur04=;
        b=h721fFF7AozOVlWSTt+w4PNy3UsTBkozbfTkdpBn74xU6NoOwFJR1Vu4UnmRsjqpma
         XmIlDt0Yww0UJ05+VO+OnGQ3dUhlgYLPhIwoscWuAFrs+L7/xGzu08iJ8w3Pqn2wpLDq
         cWWlTy0gGHd8zFvz9ocDjHWiPMzKzsn0wL5jFgdOAIsDtO61FzebV0mAMNq/ZRR4xdMF
         YJ09c9snPskIhxVw7SnLzAorknYt7Fj54L+Y1ZqXyxZ/FHKBcX7yGbePPDnKtMylx+ia
         saf8yb3i+/Tfg95sqltLkVYi67bqpmBf/m+V7k9+OrmYLupu5YDWqsg2TjjOIe/rO2RY
         qdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045216; x=1713650016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m68b/eoX9kaFQlfc15r8E7BQLVdz6kAoD5TfCrZur04=;
        b=D4VBeAEn/Fv5ZgPlWBBrbzecr8SjPdE/nu9aDzlJMM8AdbKP5P7k/hp7vOMhuB34cQ
         ivMpNAN/qLFcRI8RqUZcb3d3L7CcoZShKJDRjAO+FUIYO3+zLlKrdV/sAR4unm9X/HuB
         kGsTIV+N0Mqgw9j9uG6pvaH/grNWyBvSFKPg8W+rNkzZ5WitWTJEw8JPJ0Upmrw/FOc9
         zuNP1eqHpWIOPMarEwZCIORTUYLZIrRyW21r1Lq693u8+1kSOnj9J+5BFsDsCji2H2z5
         ueULWICPRHM6+XGSMNbKxeL5VXPS2wHTliHg8YtEr+UloVDXedwWV7aL6dEc767Zkr/G
         kviA==
X-Gm-Message-State: AOJu0Yw276wlc/KcPrUzcAlDLEGqrzQqakZ1gt7rKf2NJ9uOf24O2CLA
	FH9ru7gvysSHy/TVsX5ABFXo8EL0+7i30zI5bgiPz/edagIfZvYB0oKCsw==
X-Google-Smtp-Source: AGHT+IE3+0vSECMzWFsOLbWii3DjFImxERbI6hFEuTyGW41a7Z2Srtxzm0ZY0qFKO4ZlfVCvYOQScA==
X-Received: by 2002:a05:6000:4007:b0:345:5f6a:cc05 with SMTP id cp7-20020a056000400700b003455f6acc05mr4414851wrb.34.1713045216146;
        Sat, 13 Apr 2024 14:53:36 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([90.246.103.111])
        by smtp.gmail.com with ESMTPSA id r9-20020adff109000000b00341de3abb0esm7423472wro.20.2024.04.13.14.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 14:53:35 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v4 3/4] qmimodem: voicecall: Implement active call hangup
Date: Sat, 13 Apr 2024 22:53:12 +0100
Message-ID: <20240413215318.12236-3-adam@piggz.co.uk>
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

hangup_active iterates the current list of calls, looking for the first
active call and then calls release_specific.  This then sets up the
parameters for a call to QMI_VOICE_END_CALL, with the only parameters
being the call-id.

end_call_cb will then be called and will parse out the call-id and check
for success.

---
Changes in V4
-Minor rework to hangup_active
-Removed unnescessary changes
---
---
 drivers/qmimodem/voice.h     |  1 +
 drivers/qmimodem/voicecall.c | 82 ++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

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
index 4b87921e..396732ad 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -534,6 +534,86 @@ error:
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
+	struct cb_data *cbd;
+	struct qmi_param *param = NULL;
+
+	static const uint8_t QMI_VOICE_END_CALL_ID = 0x01;
+
+	DBG("");
+
+	param = qmi_param_new();
+	cbd = cb_data_new(cb, data);
+	cbd->user = vc;
+
+	if (!qmi_param_append_uint8(param, QMI_VOICE_END_CALL_ID, id))
+		goto error;
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_END_CALL, param, end_call_cb,
+			cbd, l_free) > 0)
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
+
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
@@ -601,6 +681,8 @@ static const struct ofono_voicecall_driver driver = {
 	.remove		= qmi_voicecall_remove,
 	.dial		= dial,
 	.answer		= answer,
+	.hangup_active  = hangup_active,
+	.release_specific  = release_specific,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

