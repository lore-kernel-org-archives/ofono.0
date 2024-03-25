Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546170CC2
	for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405161; cv=none; b=rDDVgicgpGgAs/eWGAgTFyE5AJZQG5QwjkWmR8Qd2X3mMDMnHOMyA3SFkhpkrzpgkNezMN92rBNyuC9Zc5eBpMn9ZgUIrq792x3pcMs8rUm0WpngLEM4dwV6RaAWB7cc4PE3pzEKMg5+ZBwJItbDRSFw4jDV/fYEhsGffRoE+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405161; c=relaxed/simple;
	bh=d7AHsFiFMjKzBcBuLcwK2xd3KlO2zJzNogMcasNmlig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uypc58cF1ZjJcNzJMa2uJl1Lnu8p33CQWkeIyAM7P+2YpQfwazTxeH1Ud1yZSG7aK3NBGGvCA2P3yWv3BZ9HaC1KMK/IRVgNcOfWqYHR/08GrWVNKrU0LHuoo/IseKuwvjYvrlgGj+uvCpHlG1vuVSmM67gJ14nYtUaL+eri5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjFDyuXX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjFDyuXX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4148e14799eso632735e9.0
        for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711405157; x=1712009957; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyXYh4eaD0d23/nVbgaicoFQTexRgy+8G09cRZW8G70=;
        b=GjFDyuXX+jwod1zgZf9atbWRtkL2EejkdYQP7634HvNa6wnUyERPqcie+J5KWMZ2Mr
         PcpVGteYHvlH+bStzRh9ePOzBc9lD5nTtXSH2H800bqF28NqjD4KX6f62l/GkUZqoaUA
         PHzigZy2JdBWNAtCJxhj/vpuv0bYLmhdlxpRVLZUctRDhvXMcmSY/xZfHrpSbh+lV3Pt
         AXfjJG3SzE9E+IsZzKf3BNhU77ScAkTZQ1D4QTWqHa8nVzqyG/JHNAzlBMlyjWpkpWs+
         gXF19ewFoJW91igjzlbnCjoVOnFVsBv22YPvdGwPGcnbi/sJXyn75W8MtYSgtAHZYnJH
         uKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405157; x=1712009957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gyXYh4eaD0d23/nVbgaicoFQTexRgy+8G09cRZW8G70=;
        b=vCVLrBHcYKlQQS+XO8oALw7mh9GWNc7yaStOH+jI9v08ndxpFGWxGuMuwoefJeqYMs
         RhxHOkEBx3owiDVmgHEoiC0/xsrjPuFr7L8Lk2Md43REEdYGGiOzbzYsGZo3foeoSz3l
         Q4AdDq2+mXjrT5zXJ/0ywPIGsnuiD4wWceAvMt9GzweTWgWVDajleSobCy6Kss9B6CjZ
         wS7ox1NqeqlpTbNy8K7SWpMER1HiHNhobUjUqGLwVNmKG1Vav8SX7ZIkZdznnxNsIIAX
         5F492yToEgjAr7BFV/ZvtqC3tcUgTMHJMxjHWNT91jGAbKWcdcfmVdRhteVNp/BDu0ju
         i7LQ==
X-Gm-Message-State: AOJu0YyiWd6tXvcyG7o7L4WyO6VLLtsz7BhD2yoRRpJRVLkAN0Q6D5lZ
	2JIYAOVPrGgRP0OneQFsqv+MggjDTHkx5WvCvgrbBarYgzmiQzQ0h05ieLQlpEM=
X-Google-Smtp-Source: AGHT+IFUwGgYmZEQGrdIX6oBUQImiJRrHUtpfgMnJ5lNYErSRwt6ZRerTt/wC5GBpbeID2UUAP9BOg==
X-Received: by 2002:a05:6000:1841:b0:341:ccea:5573 with SMTP id c1-20020a056000184100b00341ccea5573mr3900586wri.69.1711405157174;
        Mon, 25 Mar 2024 15:19:17 -0700 (PDT)
Received: from adam-laptop-hp.lan ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id n12-20020a056000170c00b00341d1da721dsm2163805wrc.65.2024.03.25.15.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:19:16 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH 2/4] [qmimodem][voicecall] Implement call answer
Date: Mon, 25 Mar 2024 22:17:00 +0000
Message-ID: <20240325221742.5931-2-adam@piggz.co.uk>
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
 drivers/qmimodem/voice.h     |   9 ++++
 drivers/qmimodem/voicecall.c | 100 ++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

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
index ba5ed9e4..7c6bc113 100644
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
@@ -577,7 +675,6 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 					create_voice_cb, vc, NULL);
 
 	return 0;
-
 }
 
 static void qmi_voicecall_remove(struct ofono_voicecall *vc)
@@ -599,6 +696,7 @@ static const struct ofono_voicecall_driver driver = {
 	.probe		= qmi_voicecall_probe,
 	.remove		= qmi_voicecall_remove,
 	.dial		= dial,
+	.answer		= answer,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

