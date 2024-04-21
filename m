Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D573FE4B
	for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728982; cv=none; b=IH5FJB3wQJZ7fdJnyJNgzcH9R5x94WWADQPahx8dGQvX9tzAGB2SycSWkkPSBkxjrRK2aSyT/2iovFsJ1LdQbYW0+ilcCHeR8NnWFLxgsBWyHlrWRHN0fT/9ntHU/n+QxJlmRFihQwnszlWZ6ZAYaav7nACnVTl08GuiWRHTA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728982; c=relaxed/simple;
	bh=yD7O7W31T+2kKAV3E52LsNbxhQvSeMKBQE9N5O6hb/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqQRKZvjo+R9O1RmVr9yVRcZl8CnTZSOHyWFe8wiimpPr24fDk+V95jwCScuUcIrKTihRnWYdjUcSbO590bRK8gcueM/a8kWdcLKvqE9SjXDyRZAt2Q1ZdiiRLSn1jsSwcSc/0h9Lr8/x53XeXwJ1bDQrVV4DnJGweYWj3EZY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOqDQZFF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOqDQZFF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41a69327d3eso425415e9.0
        for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713728978; x=1714333778; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+24qO9MC3teApNenS+4Mxyv0XGd0Q8G4MSGgs2+p9uI=;
        b=mOqDQZFFxzhOwKoa/SoRcceahAAk3X9/AGfUGUiu0HmZ6cLqQh39/3MgeHCq6HBZwe
         lPEEc55sufFavkSuBInrHJTYbFFnBkrdQd1PF35tJFl+WXM3jNR7srECQgrdF+cl+Lbd
         Be0xPpIDHI7ubGSSIFXnWzeACTM75NhYfw8USqoemzETsoGNVUDi2SA1XeruhxafvZvh
         VpuBBLu3+F/WR9TH2T/FHGXq24bLxwVK/BTiqsa+pCdeZNwiDBr8N5VQ0SRWzz0ebyaw
         lLPX/ZOXUm7rzTl4+JG4BsHT0TZ9TuYFVvksyQajxWWHHoPt0PBp6A5AxkfMTbhkFeXp
         LGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713728978; x=1714333778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+24qO9MC3teApNenS+4Mxyv0XGd0Q8G4MSGgs2+p9uI=;
        b=BbXzooTyAaq5rto0RTcDvgW0AiT3p/1wFwPsSMgnhhKPVVXPSHacqtBAciDDI+qbxN
         48HU6EwirZdd4Xj7WAfXK672eo+w317nxU+ToPK7OIh4yKr9Z9rxgEKno8t9l8Ea8o9v
         t6UY+igtSeSDHtwH5oC6rzTbn+cdKpz3KGF5+J5ZSYgmhEefcAFQPj+XI8E2ww/lsEvo
         QWfLhGtecwPaZCLAxJMo/AZ+veIP/QgUZkcxSZ5wlJLrmUUYHiWV0AtwkOYKUa17dlu9
         6sx8+raoNhbzVvQqdpKwu7Fg0ULpUx86aGv15/JZeCGkMZozBl3n38wQVs6JwpKIk+6J
         6iSg==
X-Gm-Message-State: AOJu0YzpqsTnNMHJ2rrhRK51v5z5Yq2xLYEpu7dBAM764uEnG6Viprnv
	fQf8vGXxYPaBgK4+nNJVybC1OhYKFLSc9mU7gYdA+rgcSx+Eh0rvwOZz1Q==
X-Google-Smtp-Source: AGHT+IHBOKwSOYnUQlIP+bgaMOw/XqheN0gc3THkgMfTugW5Izxk9RZRG7CwP7ln8oaFvUSO7yLHpg==
X-Received: by 2002:adf:e84b:0:b0:348:3fa4:21f8 with SMTP id d11-20020adfe84b000000b003483fa421f8mr6668389wrn.15.1713728978035;
        Sun, 21 Apr 2024 12:49:38 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm10018521wrs.53.2024.04.21.12.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 12:49:37 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH 3/4] qmimodem: voicecall: Implement active call hangup
Date: Sun, 21 Apr 2024 20:49:05 +0100
Message-ID: <20240421194926.13149-3-adam@piggz.co.uk>
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

Changes in V5
-Renamed parameters
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
index 99ec97f9..6b80f576 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -525,6 +525,86 @@ error:
 	l_free(param);
 }
 
+static void end_call_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_voicecall_cb_t cb = cbd->cb;
+	uint16_t error;
+	uint8_t call_id;
+
+	static const uint8_t RESULT_CALL_ID = 0x10;
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	if (qmi_result_get_uint8(result, RESULT_CALL_ID, &call_id))
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
+	static const uint8_t PARAM_CALL_ID = 0x01;
+
+	DBG("");
+
+	param = qmi_param_new();
+	cbd = cb_data_new(cb, data);
+	cbd->user = vc;
+
+	if (!qmi_param_append_uint8(param, PARAM_CALL_ID, id))
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
+		call = l_queue_find(vd->call_list, ofono_call_match_by_status,
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
@@ -592,6 +672,8 @@ static const struct ofono_voicecall_driver driver = {
 	.remove		= qmi_voicecall_remove,
 	.dial		= dial,
 	.answer		= answer,
+	.hangup_active  = hangup_active,
+	.release_specific  = release_specific,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

