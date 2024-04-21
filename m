Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60816446B6
	for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728977; cv=none; b=HN0urg+fVDCgQsRq6SET+/qwdKLmsdXzt++RObZ8Ss+49mXvNvFqKZSPvMO6jbgbtEohVyVDSyZInPtp0hbqfFRjV2tc7XPGIJ96BqCNDC8jlvVHg1KB/lbIlq+uITUCyF+UPRTbRpMK43Yj23r3itaIQ7hx5n7xVuzOli36wM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728977; c=relaxed/simple;
	bh=mdHR//SYPBl1tyzSzHWSfbv1ukU2Lwr0QMVaZgLW2+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QO5SPbkaay6uG5+3Ni5rUxxnywvSzsHafe6bq1ddZai9Fxuq9hkyFAHzaYhlWbvlhK5O611TvZnUsVqgbe77BbMyHSp2KFWjMsXqG2zJ8un6Q8OjLbzq53J6ACattoMqNDp2MAgCLAfWvgPIup3hcvN29LvSgj03KhONULdb24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJf6fUC1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJf6fUC1"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-344047ac7e4so2765202f8f.0
        for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713728973; x=1714333773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7BH3F6WmB3dIV8eT64QoRVmAkZJFt9RXe+GxxSWfmJE=;
        b=aJf6fUC1J3hudMr2hB0i7cRz5KWGL3r0ni+2ibWCM5a2sLZ1mWoIavn0cAIDvlTA/a
         e+PlZAIHSkcs1qxNTwU9jeIhB7MLkyAu4at6PFt57ZCrUm59PdPr76DRqnfd2ZtcCWxB
         5rlaTnGY9J/HemGB8aIAwbGE0ctj/4tfwb8nGHN3V2C0udZ0GNYpSXXOUN5u2TshzsQp
         QzFJvma/xtuSrv09bK6t58uDkRwxfPGsgcg1WflHA/6+zycIHnGRNk6Qaoa98Lp0IGhQ
         AslU/o+aIbmS9E/TN0LevDhVpObAF2fFV+a8/sSomeQZ6X4rjms4nbLH/6Fkt3JMSmNx
         7p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713728973; x=1714333773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BH3F6WmB3dIV8eT64QoRVmAkZJFt9RXe+GxxSWfmJE=;
        b=pFde/LtG8MA4ytPjLIuvn4TV7rmSLXkd1GRvBPvVos1JizCpyno3Xt3t9LQZ7YASPq
         xEOL66YP4Q/OgL/wWWY2hsFo25xVs2JORnZRF3rQI57RwSaokwWS/iMVxwkgGRvpi5Oq
         LnX3hd60B7M3nq69DMTmytcCk/9cXTDql1+MuJoLh4RpZmf7z6d4Ut4SKcR7qcQWpqUq
         8fpKVvfXwNm07/vXrq/MzY4J/rpOW1TW7AOf51+aD64Um33b6dDxOAKWTRayXBlsINZO
         3DyRoY2Krg0yhlfUOhrXEPhb9A5gSpVV2KoVPrUQEbGQXsxEFaXy/GeH7PBPJN/wnb2C
         EGRw==
X-Gm-Message-State: AOJu0Yw6gaRXUeRxAOfym8Il3HVo3WVK/mlBieWnWozjPBTF/SVlOfiS
	Tua9c2XsNlAKWgEY0fWFxAN1vC/0/w6yKBlTUDXagDT2ikA8+IFVHv26FQ==
X-Google-Smtp-Source: AGHT+IHGncHjqDQ5sCNXArsqYd7cxTTVGFPxZe8VDGvIypsRiJ+82q/pcNQ/1CCBVHCI9sXoSqBZvg==
X-Received: by 2002:a05:6000:c8d:b0:34a:7a56:fb3e with SMTP id dp13-20020a0560000c8d00b0034a7a56fb3emr4864355wrb.2.1713728973034;
        Sun, 21 Apr 2024 12:49:33 -0700 (PDT)
Received: from adam-laptop-hp.turtle-stonecat.ts.net ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm10018521wrs.53.2024.04.21.12.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 12:49:32 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH 1/4] qmimodem: voicecall: Implement call dialing
Date: Sun, 21 Apr 2024 20:49:03 +0100
Message-ID: <20240421194926.13149-1-adam@piggz.co.uk>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add voicecall dialling to the qmimodem driver
Includes required infrastructure and setup of the QMI services

Call State Handling
===================
On initialisation, register the all_call_status_ind callback to be
called for QMI_VOICE_IND_ALL_STATUS.  This will handle notification of
call status to the rest of the system

Dial Handling
=============
The dial function sets up the parameters for the QMI_VOICE_DIAL_CALL
service.  The parameters are the number to be called and the call type,
which is currently hard coded to be QMI_VOICE_CALL_TYPE_VOICE.  The
dial_cb callback will then be called and will receive the call-id.

---
Changes in V4
-merged qmi_voice_call_status and all_call_status_ind
-several minor structure/formate changes

Changes in V5
-renames ofono_call_compare_by_id to ofono_call_match_by_id
-updated new_entry pointer to fix use-after-free in
ofono_call_list_notify
-Renamed several constants
-in all_call_status_ind removed error label/gotos after restructuring
-When creating the call list, ensure an upper bound of 16
-Fix out-of-mound-read on remote number due to QMI string not being null
terminated
---
---
 drivers/qmimodem/voice.h     |  17 ++
 drivers/qmimodem/voicecall.c | 426 ++++++++++++++++++++++++++++++++++-
 2 files changed, 442 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index 917e72f7..2344fd50 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -48,6 +48,9 @@ enum qmi_ussd_user_required {
 
 /* QMI service voice. Using an enum to prevent doublicated entries */
 enum voice_commands {
+	QMI_VOICE_DIAL_CALL =			0x20,
+	QMI_VOICE_ALL_CALL_STATUS_IND =		0x2e,
+	QMI_VOICE_GET_ALL_CALL_INFO =		0x2f,
 	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
 	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
 	QMI_VOICE_GET_CALL_WAITING =		0x34,
@@ -66,6 +69,20 @@ enum voice_commands {
 	QMI_VOICE_GET_CNAP =			0x4d
 };
 
+enum qmi_voice_call_state {
+	QMI_VOICE_CALL_STATE_IDLE = 0x0,
+	QMI_VOICE_CALL_STATE_ORIG,
+	QMI_VOICE_CALL_STATE_INCOMING,
+	QMI_VOICE_CALL_STATE_CONV,
+	QMI_VOICE_CALL_STATE_CC_IN_PROG,
+	QMI_VOICE_CALL_STATE_ALERTING,
+	QMI_VOICE_CALL_STATE_HOLD,
+	QMI_VOICE_CALL_STATE_WAITING,
+	QMI_VOICE_CALL_STATE_DISCONNECTING,
+	QMI_VOICE_CALL_STATE_END,
+	QMI_VOICE_CALL_STATE_SETUP
+};
+
 struct qmi_ussd_data {
 	uint8_t dcs;
 	uint8_t length;
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index aa34fc25..7b4813c9 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2011-2012  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2024 Adam Pigg <adam@piggz.co.uk>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -26,6 +27,10 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/voicecall.h>
+#include <src/common.h>
+#include <ell/ell.h>
+
+#include "voice.h"
 
 #include "qmi.h"
 
@@ -35,8 +40,422 @@ struct voicecall_data {
 	struct qmi_service *voice;
 	uint16_t major;
 	uint16_t minor;
+	struct l_queue *call_list;
+	struct ofono_phone_number dialed;
 };
 
+struct qmi_voice_call_information_instance {
+	uint8_t id;
+	uint8_t state;
+	uint8_t type;
+	uint8_t direction;
+	uint8_t mode;
+	uint8_t multipart_indicator;
+	uint8_t als;
+} __attribute__((__packed__));
+
+struct qmi_voice_call_information {
+	uint8_t size;
+	struct qmi_voice_call_information_instance instance[0];
+} __attribute__((__packed__));
+
+struct qmi_voice_remote_party_number_instance {
+	uint8_t call_id;
+	uint8_t presentation_indicator;
+	uint8_t number_size;
+	char number[0];
+} __attribute__((__packed__));
+
+struct qmi_voice_remote_party_number {
+	uint8_t size;
+	struct qmi_voice_remote_party_number_instance instance[0];
+} __attribute__((__packed__));
+
+static int ofono_call_compare(const void *a, const void *b, void *data)
+{
+	const struct ofono_call *ca = a;
+	const struct ofono_call *cb = b;
+
+	if (ca->id < cb->id)
+		return -1;
+
+	if (ca->id > cb->id)
+		return 1;
+
+	return 0;
+}
+
+static bool ofono_call_match_by_id(const void *a, const void *b)
+{
+	const struct ofono_call *call = a;
+	unsigned int id = L_PTR_TO_UINT(b);
+
+	return (call->id == id);
+}
+
+static void ofono_call_list_dial_callback(struct ofono_voicecall *vc,
+						int call_id)
+{
+	struct ofono_call *call;
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct l_queue *call_list = vd->call_list;
+	const struct ofono_phone_number *ph = &vd->dialed;
+
+	/* check if call_id already present */
+	call = l_queue_find(call_list, ofono_call_match_by_id,
+				L_UINT_TO_PTR(call_id));
+
+	if (call)
+		return;
+
+	call = l_new(struct ofono_call, 1);
+	call->id = call_id;
+
+	memcpy(&call->called_number, ph, sizeof(*ph));
+	call->direction = CALL_DIRECTION_MOBILE_ORIGINATED;
+	call->status = CALL_STATUS_DIALING;
+	call->type = 0; /* voice */
+
+	l_queue_insert(call_list, call, ofono_call_compare, NULL);
+
+	ofono_voicecall_notify(vc, call);
+}
+
+static void ofono_call_list_notify(struct ofono_voicecall *vc,
+					struct l_queue *calls)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct l_queue *old_calls = vd->call_list;
+	struct l_queue *new_calls = calls;
+	struct ofono_call *new_call, *old_call;
+	const struct l_queue_entry *old_entry, *new_entry;
+	uint i;
+
+	uint loop_length =
+		MAX(l_queue_length(old_calls), l_queue_length(new_calls));
+
+	old_entry = l_queue_get_entries(old_calls);
+	new_entry = l_queue_get_entries(new_calls);
+
+	for (i = 0; i < loop_length; ++i) {
+		old_call = old_entry ? old_entry->data : NULL;
+		new_call = new_entry ? new_entry->data : NULL;
+
+		if (new_call && new_call->status == CALL_STATUS_DISCONNECTED) {
+			ofono_voicecall_disconnected(
+				vc, new_call->id,
+				OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
+			new_entry = new_entry->next;
+			l_queue_remove(calls, new_call);
+			l_free(new_call);
+			continue;
+		}
+
+		if (old_call &&
+				(!new_call || (new_call->id > old_call->id)))
+			ofono_voicecall_disconnected(
+				vc, old_call->id,
+				OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
+		else if (new_call &&
+				(!old_call || (new_call->id < old_call->id))) {
+			DBG("Notify new call %d", new_call->id);
+			/* new call, signal it */
+			if (new_call->type == 0)
+				ofono_voicecall_notify(vc, new_call);
+		} else if (memcmp(new_call, old_call, sizeof(*new_call)) &&
+				new_call->type == 0)
+			ofono_voicecall_notify(vc, new_call);
+
+		if (old_entry)
+			old_entry = old_entry->next;
+		if (new_entry)
+			new_entry = new_entry->next;
+	}
+
+	l_queue_destroy(old_calls, l_free);
+	vd->call_list = calls;
+}
+
+static const char *qmi_voice_call_state_name(enum qmi_voice_call_state value)
+{
+	switch (value) {
+	case QMI_VOICE_CALL_STATE_IDLE:
+		return "QMI_VOICE_CALL_STATE_IDLE";
+	case QMI_VOICE_CALL_STATE_ORIG:
+		return "QMI_VOICE_CALL_STATE_ORIG";
+	case QMI_VOICE_CALL_STATE_INCOMING:
+		return "QMI_VOICE_CALL_STATE_INCOMING";
+	case QMI_VOICE_CALL_STATE_CONV:
+		return "QMI_VOICE_CALL_STATE_CONV";
+	case QMI_VOICE_CALL_STATE_CC_IN_PROG:
+		return "QMI_VOICE_CALL_STATE_CC_IN_PROG";
+	case QMI_VOICE_CALL_STATE_ALERTING:
+		return "QMI_VOICE_CALL_STATE_ALERTING";
+	case QMI_VOICE_CALL_STATE_HOLD:
+		return "QMI_VOICE_CALL_STATE_HOLD";
+	case QMI_VOICE_CALL_STATE_WAITING:
+		return "QMI_VOICE_CALL_STATE_WAITING";
+	case QMI_VOICE_CALL_STATE_DISCONNECTING:
+		return "QMI_VOICE_CALL_STATE_DISCONNECTING";
+	case QMI_VOICE_CALL_STATE_END:
+		return "QMI_VOICE_CALL_STATE_END";
+	case QMI_VOICE_CALL_STATE_SETUP:
+		return "QMI_VOICE_CALL_STATE_SETUP";
+	}
+	return "QMI_CALL_STATE_<UNKNOWN>";
+}
+
+static bool qmi_to_ofono_status(uint8_t status, int *ret)
+{
+	int err = false;
+
+	switch (status) {
+	case QMI_VOICE_CALL_STATE_IDLE:
+	case QMI_VOICE_CALL_STATE_END:
+	case QMI_VOICE_CALL_STATE_DISCONNECTING:
+		*ret = CALL_STATUS_DISCONNECTED;
+		break;
+	case QMI_VOICE_CALL_STATE_HOLD:
+		*ret = CALL_STATUS_HELD;
+		break;
+	case QMI_VOICE_CALL_STATE_WAITING:
+		*ret = CALL_STATUS_WAITING;
+		break;
+	case QMI_VOICE_CALL_STATE_ORIG:
+		*ret = CALL_STATUS_DIALING;
+		break;
+	case QMI_VOICE_CALL_STATE_SETUP:
+	case QMI_VOICE_CALL_STATE_INCOMING:
+		*ret = CALL_STATUS_INCOMING;
+		break;
+	case QMI_VOICE_CALL_STATE_CONV:
+		*ret = CALL_STATUS_ACTIVE;
+		break;
+	case QMI_VOICE_CALL_STATE_CC_IN_PROG:
+		*ret = CALL_STATUS_DIALING;
+		break;
+	case QMI_VOICE_CALL_STATE_ALERTING:
+		*ret = CALL_STATUS_ALERTING;
+		break;
+	default:
+		err = true;
+	}
+	return err;
+}
+
+static enum call_direction qmi_to_ofono_direction(uint8_t qmi_direction)
+{
+	return qmi_direction - 1;
+}
+
+static void all_call_status_ind(struct qmi_result *result, void *user_data)
+{
+	struct ofono_voicecall *vc = user_data;
+
+	int i;
+	int offset;
+	uint16_t len;
+	bool status = true;
+	int instance_size;
+	const struct qmi_voice_call_information *call_information;
+	const struct qmi_voice_remote_party_number *remote_party_number;
+	const struct qmi_voice_remote_party_number_instance *remote_party_number_inst[16];
+
+	static const uint8_t RESULT_CALL_STATUS_CALL_INFORMATION = 0x01;
+	static const uint8_t RESULT_CALL_STATUS_REMOTE_NUMBER = 0x10;
+	static const uint8_t RESULT_CALL_INFO_CALL_INFORMATION = 0x10;
+	static const uint8_t RESULT_CALL_INFO_REMOTE_NUMBER = 0x11;
+
+	DBG("");
+
+	/* mandatory */
+	call_information = qmi_result_get(
+		result, RESULT_CALL_STATUS_CALL_INFORMATION, &len);
+
+	if (!call_information) {
+		call_information = qmi_result_get(
+			result, RESULT_CALL_INFO_CALL_INFORMATION,
+			&len);
+		status = false;
+	}
+
+	if (!call_information || len < sizeof(call_information->size)) {
+		DBG("Parsing of all call status indication failed");
+		return;
+	}
+
+	if (!call_information->size) {
+		DBG("No call informations received!");
+		return;
+	}
+
+	if (len != call_information->size *
+			sizeof(struct qmi_voice_call_information_instance) +
+			sizeof(call_information->size)) {
+		DBG("Call information size incorrect");
+		return;
+	}
+
+	/* mandatory */
+	remote_party_number = qmi_result_get(
+		result,
+		status ? RESULT_CALL_STATUS_REMOTE_NUMBER :
+			 RESULT_CALL_INFO_REMOTE_NUMBER,
+		&len);
+
+	if (!remote_party_number) {
+		DBG("Unable to retrieve remote numbers");
+		return;
+	}
+
+	/* verify the length */
+	if (len < sizeof(remote_party_number->size)) {
+		DBG("Parsing of remote numbers failed");
+		return;
+	}
+
+	/* expect we have valid fields for every call */
+	if (call_information->size != remote_party_number->size) {
+		DBG("Not all fields have the same size");
+		return;
+	}
+
+	/* pull the remote call info into a local array */
+	instance_size = sizeof(struct qmi_voice_remote_party_number_instance);
+
+	for (i = 0, offset = sizeof(remote_party_number->size);
+			offset < len && i < 16 && i < remote_party_number->size;
+			i++) {
+		const struct qmi_voice_remote_party_number_instance *instance;
+
+		if (offset + instance_size > len) {
+			DBG("Error parsing remote numbers");
+			return;
+		}
+
+		instance = (void *)remote_party_number + offset;
+		if (offset + instance_size + instance->number_size > len) {
+			DBG("Error parsing remote numbers");
+			return;
+		}
+
+		remote_party_number_inst[i] = instance;
+		offset +=
+			sizeof(struct qmi_voice_remote_party_number_instance) +
+			instance->number_size;
+	}
+
+	struct l_queue *calls = l_queue_new();
+
+	for (i = 0; i < call_information->size && i < 16; i++) {
+		struct ofono_call *call = l_new(struct ofono_call, 1);
+		struct qmi_voice_call_information_instance call_info;
+		const struct qmi_voice_remote_party_number_instance
+			*remote_party = remote_party_number_inst[i];
+		int number_size;
+
+		call_info = call_information->instance[i];
+
+		call->id = call_info.id;
+		call->direction = qmi_to_ofono_direction(call_info.direction);
+		call->type = 0; /* always voice */
+
+		number_size = MIN(remote_party->number_size, OFONO_MAX_PHONE_NUMBER_LENGTH);
+		char *tmp = l_strndup(remote_party->number, number_size);
+		l_strlcpy(call->phone_number.number, tmp, sizeof(call->phone_number.number));
+		l_free(tmp);
+
+		if (strlen(call->phone_number.number) > 0)
+			call->clip_validity = 0;
+		else
+			call->clip_validity = 2;
+
+		if (qmi_to_ofono_status(call_info.state, &call->status)) {
+			DBG("Ignore call id %d, because can not convert QMI state 0x%x to ofono.",
+				call_info.id, call_info.state);
+			l_free(call);
+			continue;
+		}
+
+		DBG("Call %d in state %s(%d)", call_info.id,
+			qmi_voice_call_state_name(call_info.state),
+			call_info.state);
+
+		l_queue_push_tail(calls, call);
+	}
+
+	ofono_call_list_notify(vc, calls);
+}
+
+static void dial_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	struct ofono_voicecall *vc = cbd->user;
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
+	if (!qmi_result_get_uint8(result, RESULT_CALL_ID,
+			&call_id)) {
+		ofono_error("No call id in dial result");
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	DBG("New call QMI id %d", call_id);
+	ofono_call_list_dial_callback(vc, call_id);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void dial(struct ofono_voicecall *vc,
+			const struct ofono_phone_number *ph,
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param;
+	const char *calling_number = phone_number_to_string(ph);
+
+	static const uint8_t PARAM_CALL_NUMBER = 0x01;
+	static const uint8_t PARAM_CALL_TYPE = 0x10;
+	static const uint8_t QMI_VOICE_CALL_TYPE_VOICE = 0x00;
+
+	DBG("");
+
+	cbd->user = vc;
+	memcpy(&vd->dialed, ph, sizeof(*ph));
+
+	param = qmi_param_new();
+
+	if (!qmi_param_append(param, PARAM_CALL_NUMBER,
+			strlen(calling_number), calling_number))
+		goto error;
+
+	qmi_param_append_uint8(param, PARAM_CALL_TYPE,
+				QMI_VOICE_CALL_TYPE_VOICE);
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_DIAL_CALL, param, dial_cb,
+				cbd, l_free) > 0)
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
@@ -58,6 +477,9 @@ static void create_voice_cb(struct qmi_service *service, void *user_data)
 
 	data->voice = qmi_service_ref(service);
 
+	qmi_service_register(data->voice, QMI_VOICE_ALL_CALL_STATUS_IND,
+				all_call_status_ind, vc, NULL);
+
 	ofono_voicecall_register(vc);
 }
 
@@ -70,6 +492,7 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 	DBG("");
 
 	data = l_new(struct voicecall_data, 1);
+	data->call_list = l_queue_new();
 
 	ofono_voicecall_set_data(vc, data);
 
@@ -77,7 +500,6 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 					create_voice_cb, vc, NULL);
 
 	return 0;
-
 }
 
 static void qmi_voicecall_remove(struct ofono_voicecall *vc)
@@ -92,12 +514,14 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
 
 	qmi_service_unref(data->voice);
 
+	l_queue_destroy(data->call_list, l_free);
 	l_free(data);
 }
 
 static const struct ofono_voicecall_driver driver = {
 	.probe		= qmi_voicecall_probe,
 	.remove		= qmi_voicecall_remove,
+	.dial		= dial,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-- 
2.44.0

