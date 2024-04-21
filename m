Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C7111AD
	for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728979; cv=none; b=qyBAYRYeLxcYBpCgsW7seHs6hP1fvrvGjTUihCo8ezp3xCfGU3htkFpr5QtDR6GFcMiR0YHpImi4yaqsboWx9AL3tO40ozS0aLunRvBb5G9ZMRfTyRiQBbmzexaE8biF5e8CL05OmE5VtAUEFt2fb8EXwIURvr55VMqeSFXFogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728979; c=relaxed/simple;
	bh=3iArTPF19gocDR2k/+lng0eVon0ueRmbh9OB9ZtnTks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWnZPaky/cwzJYWrWsZIEWvIDfjIoNy1RMg8SW55/mSra/bTCsMR+GLNXDviY5BDyma2Ha1alq6MBpqFIrPjMEedQ3LR+rIYhHlHo3s+JHA0h6CC3GJDyXIe31fBYk73XQEeoD9xeikAT+ys5aBK0dcpuyX8FVS1kHmoLGJGUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQcWDG9i; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQcWDG9i"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34a7e47d164so1811884f8f.3
        for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713728975; x=1714333775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad34TCKw/ZYYmRxVlUipABIPNiBIVoMbj9jd5/glJ8M=;
        b=NQcWDG9iSKSElgjnyQeV1IwyvtIuCmcmlwbLoWyrqBye6LhMyVtn2NaYfTr5kEJHww
         Rneso4UwQgf/I2yhrZMhDPFHbrcBDRqPYoNSFR4OLsUP+Q2n7q7GuSArRGw4Aew9mAAJ
         cVU4KU9+Pj0p0SSxqWAUbfT4pCeRVJYt6YGjoRWN/v34/DDqR5FR/8vmc9a51FqLFqxQ
         iGM+L/KaaLHgSQP57hNiLBrxjEw5rbcHxumK5nt7I15atsKYArjkHyETpeGM1PC/FOWi
         V60fZHe1fyycJIkau0vY4xovBSDRTJHRg2qRUOyFJwSIXLOVgjpA9LHRw26zQwLrtUlA
         fqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713728975; x=1714333775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ad34TCKw/ZYYmRxVlUipABIPNiBIVoMbj9jd5/glJ8M=;
        b=Vul4OTWkH2MQXexPMm/hvliDdfjVrgM1eKBg95V7a7pMPyS6SdzhmTUP28iNY7m5md
         LP21DMJDCESFdK+2Yc601J9zjN01cnas0th1qDSkfAiYfR8CjedpvEXUdlaqlOg6Thqg
         wQ5muHMf9bo5HvdrNVAJOISlrcLdMeEc1ogZdHJ8i2tJeg+WaRi1FvkmuHAGR+QV5yfw
         1tNd2bKcfsjdLMqNTBJhw2bUbdenbtc3p/iGHGzAYbyMlofOv0mpPmS2Lfr8pFgweW/a
         wBURxAcUwK8BWxr5qRwMTCHHKL1kGVBlerxblkhdl7M2dwwgh7gOkdx3O46JyST4jMkb
         /bzg==
X-Gm-Message-State: AOJu0YwikYb6LDzHi1IgREHTOyneazEQDdYqL7VOSXF0xVJF9MD1mML+
	Qaiaz3h8kmgQBA4VDDxyaby58tokL800Nki3wu8aJtFzH2WHrHc8Ffjkbg==
X-Google-Smtp-Source: AGHT+IFf+me1pDShaNZXxTUjmsHNCtv8V1SUx3vdQBTgkTVQpwYyy9PCAB4kSLGjsvjki2SA4kFXGw==
X-Received: by 2002:a5d:52c7:0:b0:34a:3bbc:a4b5 with SMTP id r7-20020a5d52c7000000b0034a3bbca4b5mr4822619wrv.70.1713728975248;
        Sun, 21 Apr 2024 12:49:35 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm10018521wrs.53.2024.04.21.12.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 12:49:34 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH 2/4] qmimodem: voicecall: Implement call answer
Date: Sun, 21 Apr 2024 20:49:04 +0100
Message-ID: <20240421194926.13149-2-adam@piggz.co.uk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421194926.13149-1-adam@piggz.co.uk>
References: <20240421194926.13149-1-adam@piggz.co.uk>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The answer function setup the parameters for a call to the service
function QMI_VOICE_ANSWER_CALL.  The only parameter is the call-id.
answer_cb will then be called which retrieves the call-id and checks
the status of the result.

---
Changes in V4
-Minor rework to the answer function

Changes in V5
-Renamed ofono_call_compare_by_status ofono_call_match_by_status
-Renamed parameters
-Made answer() ofono_error if call is null
---
---
 drivers/qmimodem/voice.h     |  1 +
 drivers/qmimodem/voicecall.c | 70 ++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

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
index 7b4813c9..99ec97f9 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -93,6 +93,14 @@ static bool ofono_call_match_by_id(const void *a, const void *b)
 	return (call->id == id);
 }
 
+static bool ofono_call_match_by_status(const void *a, const void *b)
+{
+	const struct ofono_call *call = a;
+	int status = L_PTR_TO_INT(b);
+
+	return status == call->status;
+}
+
 static void ofono_call_list_dial_callback(struct ofono_voicecall *vc,
 						int call_id)
 {
@@ -456,6 +464,67 @@ error:
 	l_free(param);
 }
 
+static void answer_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_voicecall_cb_t cb = cbd->cb;
+	uint16_t error;
+	uint8_t call_id;
+
+	static const uint8_t RESULT_CALL_ID = 0x10;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	if (qmi_result_get_uint8(result, RESULT_CALL_ID, &call_id))
+		DBG("Received answer result with call id %d", call_id);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void answer(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct cb_data *cbd;
+	struct ofono_call *call;
+	struct qmi_param *param = NULL;
+
+	static const uint8_t PARAM_CALL_ID = 0x01;
+
+	DBG("");
+
+	call = l_queue_find(vd->call_list,
+					ofono_call_match_by_status,
+					L_UINT_TO_PTR(CALL_STATUS_INCOMING));
+
+	param = qmi_param_new();
+	cbd = cb_data_new(cb, data);
+	cbd->user = vc;
+
+	if (call == NULL) {
+		ofono_error("Can not find a call to pick up");
+		goto error;
+	}
+
+	if (!qmi_param_append_uint8(param, PARAM_CALL_ID,
+			call->id))
+		goto error;
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_ANSWER_CALL, param,
+			answer_cb, cbd, l_free) > 0)
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
@@ -522,6 +591,7 @@ static const struct ofono_voicecall_driver driver = {
 	.probe		= qmi_voicecall_probe,
 	.remove		= qmi_voicecall_remove,
 	.dial		= dial,
+	.answer		= answer,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

