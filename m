Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6154C3DE
	for <ofono@lists.linux.dev>; Tue, 26 Mar 2024 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448469; cv=none; b=sZ/7mTmMtHnZrHWFdytpvp1vXjhb0BlDFpZ4d1ryIqAzs0cbpdTiCTnMHDYEjBBfNi6Cag1YGaQtNmZ9NoI+XvnsWLhPKTuAp7uZERo1MOrPDhfmuUStKt/ibp3lTC6DwkeD1vJ10ysjKdZJum03T31hFX130NUpvqaMFn3lSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448469; c=relaxed/simple;
	bh=QTTzJHivmA+XhKzw8D0DtDwYt5eIxPJbTaCF19xUMr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhMP6J2X4AQRrsMrc/WstQEVJhHiyUXt+Y5BpjpVcxLo7agAxZrqEQs0hCziIGsxqZEbM9gdCwO0YJctxWBuWlwT21QuK0RFFhR8EObHblcpv5fYQo/nYWPsPsJcjC/74bT3IHz3My8Bdz5IczbNEX7W2lvuTXxDt4Dt2PmYySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdBtSjIH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdBtSjIH"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4148ca200a7so5839885e9.0
        for <ofono@lists.linux.dev>; Tue, 26 Mar 2024 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711448465; x=1712053265; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEZnFbgK2Kv4hBm+O1ve2kqwJAVtiuX2upswO+jYjIo=;
        b=UdBtSjIHTjirtQFdoY6H5yh4kOQlseOYiSsQzkjNiHXQB029/6dYLT4jidGXQfbiEU
         gVIUcItq1VWUPFeL6NR8j+e2qk7hUf6zN3/x6CRErSRq3azMia9GPgMLYbszSy0d0aUR
         JwCT8qp3EZJqwaN/tQpsOLRwP9RfEJIuLFaKkK9LpOu8RBw2X6wDORcknt+7zyxZIQTV
         KhhKjDuhyUPTKUMIhVUHMEAinxk6/zrubIRU3CkidZapppRSjW22YdPCeJNBQdPe08AG
         jWwQ/ltoH98om/F0wdIwtGajW6x591RdtiyJmCVYz7ih7TrMUb47q6geBBUohhACLEoP
         l6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448465; x=1712053265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sEZnFbgK2Kv4hBm+O1ve2kqwJAVtiuX2upswO+jYjIo=;
        b=m2reQCojNpUU8VfS+/7fc29iPnUyVQR9duZfAE1hhDAax0qHJVin76kGW+cvyb4MVN
         gQCM1g8Fg/uloRJtaOsOvpeCZz5S/zKOEfqZml115xUmwfxdjBOTFenitaibf8ZX/Y3U
         o0igVk1LOe/k46LFS4k1USyGBtxV2inWYxijGe48jmvthRCjO6WG/eoOqIic6kugGIIV
         XdnVH8tngFKvrfJpR+abGsaQrGWWJz5yRTP/ofzpd2DLXX7l6JS8E9JzK9H+G+KeYDlr
         1GS7D65WUrstPUCV23nck9Wc65oWvWHx77sfRnBGe9yJGI57D82rhAXVbyjj+0Gx1S5U
         4hgQ==
X-Gm-Message-State: AOJu0YxCCPnoIZYuuvaSmdg4H2YmNAyAMmbFjwvJVVVRM5LlVLfbaqxq
	rBHG3lsrKtXSgzpiXzqtTvGW9uM8YczLalL1R6K1MeWXIu316dmPv1brOEQOKq8=
X-Google-Smtp-Source: AGHT+IGFwqt2ySG4LIK9H+HwY5JSHLQFvFf+UXnlHpW//Rirt2i602yf7PAAJxzBiV2fqcPgc30+Vw==
X-Received: by 2002:a05:600c:548a:b0:414:7384:1ec2 with SMTP id iv10-20020a05600c548a00b0041473841ec2mr638577wmb.9.1711448465460;
        Tue, 26 Mar 2024 03:21:05 -0700 (PDT)
Received: from adam-laptop-hp.lan ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b00414903d20aesm676366wmq.11.2024.03.26.03.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:21:05 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v2 3/4] [qmimodem][voicecall] Implement active call hangup
Date: Tue, 26 Mar 2024 10:19:58 +0000
Message-ID: <20240326102054.30946-3-adam@piggz.co.uk>
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

hangup_active iterates the current list of calls, looking for the first
active call and then calls release_specific.  This then sets up the
parameters for a call to QMI_VOICE_END_CALL, with the only paramters
being the call-id.

end_call_cb will then be called and will parse out the call-id and check
for success.
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

