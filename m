Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9735644F
	for <ofono@lists.linux.dev>; Sat, 13 Apr 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045216; cv=none; b=HZbODdGLzytoImMuqCZ5Iiu3ps3nQV84Gu3M6sOlHhUbHlECgozkBP11YnGILGYo25d9q8ayOe7ZQWU8Jdbl6QpXCcu9D47Mhljd7mmatk376dyjXXOqjgikgLzvYWe+YF0Dow9HjCD2ebf3WFiJ0EotOw/vwi31RTYNOP94H94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045216; c=relaxed/simple;
	bh=GIguqfzvHtp8l6hpGN3RGpdMKEfMeETBKg6DIEFD2lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tk0BCczBpoFnb0re8KtsXFkQ1pFlErqMdWNGvaJL/bfpFkDFdsMPRY7H2F1DSAWUs1+X5mzqEmlHom5nX81FFhq0xiBHzYNlAH4KDesrz2nluSRzRQSQBQPuX1UOUPro41VNlqmu/a9oLsqE1ZgTPW+RTKukfQMeof+/Zgn7bGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJReNux+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJReNux+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so1594489f8f.1
        for <ofono@lists.linux.dev>; Sat, 13 Apr 2024 14:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713045212; x=1713650012; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYmx1RIrc1Skj3YIS5zoF+kfyXrwdMx07Aw1IN/qMEY=;
        b=XJReNux+q8IFQAV7mvE1T/MP3Foc/LuqZwP40FANMHpf+SqSSQXGEArY87nAuh6940
         yLuE8yFHOesoai6v+Y9Ea88UucyzZ1e7P7nkQTLRCbrxvMSVojDHEp0yTnKYJupysib9
         WLsR/mURGd6jPOH7mIceYVUxyMwPCl9AG+5N4D3dWZBAyugY/MqN/Od8s/rOubZt1Tv5
         siDT8X/Y//D873nkwlM3tBpXQM/3IMTPbfB298bvR3cY91fJ2uiEP7vs+RnG4uwJYCPM
         oOfTIUmaGyEgev37upOEbrimkZidlRYc0tTeXvRqui3tT2jSbNQNMa5HGU+atomtd8Cf
         PncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045212; x=1713650012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SYmx1RIrc1Skj3YIS5zoF+kfyXrwdMx07Aw1IN/qMEY=;
        b=S+J77pXcBlIw+vgtxsRCMqt572MFepyGKwpTjK+FyyM++eb1FiwcBxUWOj8A6ijF2F
         8S2QNO2HN/uSEZmdDh6KseXUMKbmRmO1hEv7XB5qfdGM/GtIFEWzfARJ8ibQFvIhJHN+
         UadVJzgoCAtEkIOW1nEkcUaQIHaR9fXAQvd+SE9lUDekoMuzfSrJWUxz0MuVFhVF5HbO
         MmLYqB6aaHojIGrTux5YernfxtSHIPCnSfieSLhY4vHpyBNgiANZ/nL+F1CwcBBYMydE
         PR3hsopRHTF3poakGoKi9hfX19X98Dokt8q3t6BWUTq7WE3KomuUdFcGDsrGvXLQ+dKm
         IiQg==
X-Gm-Message-State: AOJu0Yw8Kb8sc7BIqgB/ExIind8CwPLnWRf5nCrM2FzoTrr9MmYcBYec
	jQS7ZYyImfN7TjYBK5l3ALy7b0x2fTxIrSqgXbUQJLF0AacRVW0V81e/Ww==
X-Google-Smtp-Source: AGHT+IFAW46oJ4fqwNrFiNhLjO9GU0zFoMt09jPohfPg4O1B15m1M/E1SxpsZaG4rezUDjC4Fw/6EQ==
X-Received: by 2002:a05:6000:912:b0:346:f79c:3256 with SMTP id cw18-20020a056000091200b00346f79c3256mr3742949wrb.7.1713045212455;
        Sat, 13 Apr 2024 14:53:32 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([90.246.103.111])
        by smtp.gmail.com with ESMTPSA id r9-20020adff109000000b00341de3abb0esm7423472wro.20.2024.04.13.14.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 14:53:31 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v4 2/4] qmimodem: voicecall: Implement call answer
Date: Sat, 13 Apr 2024 22:53:11 +0100
Message-ID: <20240413215318.12236-2-adam@piggz.co.uk>
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

The answer function set up the parameters for a call to the service
function QMI_VOICE_ANSWER_CALL.  The only parameter is the call-id.
answer_cb will then be called which retrieves the call-id and checks
the status of the result.

---
Changed in V4
-Minor rework to the answer function
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
index 8c86eee7..4b87921e 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -93,6 +93,14 @@ static bool ofono_call_compare_by_id(const void *a, const void *b)
 	return (call->id == id);
 }
 
+static bool ofono_call_compare_by_status(const void *a, const void *b)
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
@@ -465,6 +473,67 @@ error:
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
+	struct cb_data *cbd;
+	struct ofono_call *call;
+	struct qmi_param *param = NULL;
+
+	static const uint8_t QMI_VOICE_ANSWER_CALL_ID = 0x01;
+
+	DBG("");
+
+	call = l_queue_find(vd->call_list,
+					ofono_call_compare_by_status,
+					L_UINT_TO_PTR(CALL_STATUS_INCOMING));
+
+	if (call == NULL) {
+		DBG("Can not find a call to pick up");
+		return;
+	}
+
+	param = qmi_param_new();
+	cbd = cb_data_new(cb, data);
+	cbd->user = vc;
+
+	if (!qmi_param_append_uint8(param, QMI_VOICE_ANSWER_CALL_ID,
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
@@ -531,6 +600,7 @@ static const struct ofono_voicecall_driver driver = {
 	.probe		= qmi_voicecall_probe,
 	.remove		= qmi_voicecall_remove,
 	.dial		= dial,
+	.answer		= answer,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

