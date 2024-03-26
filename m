Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8C4F1F8
	for <ofono@lists.linux.dev>; Tue, 26 Mar 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448466; cv=none; b=BIO8iLb+kF3sb9do3+hce5P2IUY0IQ/iHwZ7ECMmcfeKO+LelGw2d9skOHA8VZMXu9MMA6ckHt7fEOq46IeVlV8xot4+Yr1aNJeJbEOO2Mf/XfqjWS+xTlGvzEHbXF5jK1wGXia/u+MEUdwhr0lIZG18omRcimZaSc5FvWq74sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448466; c=relaxed/simple;
	bh=58vIO2w5Jog4hiVan5jvxZUXp0KCus75799cvHa96lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btK4kUT11GCGSLAihHuKWzF/ZuxDyszeQ4oGlSx5I5/n+lgZSdhOIRwbhEK+hnc3UJ5r2xJ/X3tBL81KWH+ZPUrjROwiEdv4Ea+Fe8Vy3xZSNJI6REAz0JCFUNkkdiIDvCtDC2iNhdnGyNze1qClXOjzJrsy+iW8eYuEFyXxBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpeAlJxj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpeAlJxj"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so3923227f8f.0
        for <ofono@lists.linux.dev>; Tue, 26 Mar 2024 03:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711448462; x=1712053262; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hxSCWzBSrwMJI0Z5mf7aIuBqSgtb1wxxveC+twb5O/k=;
        b=PpeAlJxjIMlg4/S6QtRqfP0JJni8q5o1kErj1gxKPuQTxllQ3nzLzMpzwZir4TiMRU
         6QcubQbVZ4OXPeI42iMUBYigV3cpXDMJKfA+qKdGsyH/pTgwDYn4U88VDFHlglwgVAbY
         5TUa8xu0RFX5rYgboQ3KZgNp+K+hkV8Bb0XOhddliiYIKmzFBmWOXlg91m19h+UXawIX
         uHqhBq9w6nqxPXn4PYEF/khEPHypveTRdknqI3EeCdC3GV8W55wAClrE8yW6UTPaCv1d
         aFdlHh6LANQTBC1zgmsHl0kqbx0vPS2c9Nsi6QQTasrsQEqU5bNHRRN1uL2YRVHIV4U2
         bUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448462; x=1712053262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxSCWzBSrwMJI0Z5mf7aIuBqSgtb1wxxveC+twb5O/k=;
        b=rpSIgJ8CZ+3EPkhX3bxxJ83zx62Kfj9GCmPhApNXKBJK78JLK7Q6BteN3iKYKkXJLn
         o9H0hLwJ6NK9+2Ll0a5IU/BBQHYuhSDr0q9pThU38Ks+DH7A6Pq8FGz7jNlJp4aOdFPm
         sot2MLJroDC1wAJi3wdyXaNzw/CSZl3HKvdiVH6E2TTs+8P0esLsmLTMsg2RPGUSRRe3
         hqLMBeAxCuab0pzoUkKSA1gcwYOyKrW9cPZnxpzW7alEhFBcXGeU5w9l8WVkqCvDl//J
         ZM6AP3WdRp84fzOAONWoLTY50R6EmumS7qIiZTlr3ujJ7QdB20QIkqepY6KRwc5pAu+5
         qJGA==
X-Gm-Message-State: AOJu0Yyjvc7FbZa/KexNsAKrNfxJneCP8AZP1sHnynF4asx62XBXWQcj
	ebnWCn9r3HYWvm9wewMoJqgdZ20PWM2RItU2H4/ss0tTFq6VjkxR+WnOcWBE3IE=
X-Google-Smtp-Source: AGHT+IFrRFOai/uvgux3qpQIf0iKX4Xrm7jy2DITGc9MysW4p2CJed3gh4LEjgrT21O+3gflP2A+kA==
X-Received: by 2002:a5d:50c9:0:b0:33e:ca1f:1401 with SMTP id f9-20020a5d50c9000000b0033eca1f1401mr991054wrt.4.1711448461748;
        Tue, 26 Mar 2024 03:21:01 -0700 (PDT)
Received: from adam-laptop-hp.lan ([90.246.50.91])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b00414903d20aesm676366wmq.11.2024.03.26.03.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:21:01 -0700 (PDT)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev
Cc: Adam Pigg <adam@piggz.co.uk>
Subject: [PATCH v2 1/4] [qmimodem][voicecall] Implement call dialing
Date: Tue, 26 Mar 2024 10:19:56 +0000
Message-ID: <20240326102054.30946-1-adam@piggz.co.uk>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add voicecall dialling to the qmimodem driver
Includes required infratructure and setup of the QMI services

Call State Handling
===================
On initialisation, register the all_call_status_ind callback to be
called for QMI_VOICE_IND_ALL_STATUS.  This will handle notificatiof of
call status to the rest of the system

Dial Handling
=============
The dial function sets up the parameters for the QMI_VOICE_DIAL_CALL
service.  The parameters are the number to be called and the call type,
which is currently hard coded to be QMI_VOICE_CALL_TYPE_VOICE.  The
dial_cb callback wi then be called and will receive the call-id.
---
 drivers/qmimodem/voice.h     |  51 ++++
 drivers/qmimodem/voicecall.c | 503 ++++++++++++++++++++++++++++++++++-
 2 files changed, 553 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index 917e72f7..1a584f10 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -15,6 +15,8 @@
  *
  */
 
+#include <stdint.h>
+
 #define QMI_VOICE_PARAM_USS_DATA 0x01
 
 #define QMI_VOICE_PARAM_ASYNC_USSD_ERROR 0x10
@@ -25,6 +27,9 @@
 #define QMI_VOICE_PARAM_USSD_IND_DATA 0x10
 #define QMI_VOICE_PARAM_USSD_IND_UCS2 0x11
 
+#define QMI_VOICE_IND_ALL_STATUS 0x2e
+#define QMI_VOICE_GET_ALL_STATUS 0x2f
+
 /* according to GSM TS 23.038 section 5
  * coding group 1111, No message class, 8 bit data
  */
@@ -48,6 +53,7 @@ enum qmi_ussd_user_required {
 
 /* QMI service voice. Using an enum to prevent doublicated entries */
 enum voice_commands {
+	QMI_VOICE_DIAL_CALL =			0x20,
 	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
 	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
 	QMI_VOICE_GET_CALL_WAITING =		0x34,
@@ -66,6 +72,50 @@ enum voice_commands {
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
+enum qmi_voice_call_dial_param {
+	QMI_VOICE_DIAL_CALL_NUMBER = 0x01,
+	QMI_VOICE_DIAL_CALL_TYPE = 0x10
+};
+
+enum qmi_voice_call_dial_return {
+	QMI_VOICE_DIAL_RETURN_CALL_ID = 0x10
+};
+
+enum qmi_voice_all_call_status_commands {
+	QMI_VOICE_ALL_CALL_STATUS_CALL_INFORMATION = 0x01,
+	QMI_VOICE_ALL_CALL_STATUS_REMOTE_NUMBER = 0x10
+};
+
+enum qmi_voice_all_call_info_commands {
+	QMI_VOICE_ALL_CALL_INFO_CALL_INFORMATION = 0x10,
+	QMI_VOICE_ALL_CALL_INFO_REMOTE_NUMBER = 0x11
+};
+
+enum qmi_voice_call_type {
+	QMI_VOICE_CALL_TYPE_VOICE = 0x0,
+	QMI_VOICE_CALL_TYPE_VOICE_FORCE,
+};
+
+enum parse_error {
+	NONE = 0,
+	MISSING_MANDATORY = 1,
+	INVALID_LENGTH = 2,
+};
+
 struct qmi_ussd_data {
 	uint8_t dcs;
 	uint8_t length;
@@ -98,3 +148,4 @@ enum qmi_ss_reason {
 	QMI_VOICE_SS_RSN_CLIP =			0x10,
 	QMI_VOICE_SS_RSN_CLIR =			0x11
 };
+
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index aa34fc25..55c7009a 100644
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
 
@@ -35,8 +40,499 @@ struct voicecall_data {
 	struct qmi_service *voice;
 	uint16_t major;
 	uint16_t minor;
+	struct l_queue *call_list;
+	struct voicecall_static *vs;
+	struct ofono_phone_number dialed;
+};
+
+struct qmi_voice_all_call_status_ind {
+	bool call_information_set;
+	const struct qmi_voice_call_information *call_information;
+	bool remote_party_number_set;
+	uint8_t remote_party_number_size;
+	const struct qmi_voice_remote_party_number_instance
+		*remote_party_number[16];
+};
+
+enum parse_error
+qmi_voice_call_status(struct qmi_result *qmi_result,
+		      struct qmi_voice_all_call_status_ind *result);
+
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
+struct qmi_voice_dial_call_arg {
+	bool calling_number_set;
+	const char *calling_number;
+	bool call_type_set;
+	uint8_t call_type;
+};
+
+struct qmi_voice_dial_call_result {
+	bool call_id_set;
+	uint8_t call_id;
 };
 
+int ofono_call_compare(const void *a, const void *b, void *data)
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
+bool ofono_call_compare_by_status(const void *a, const void *b)
+{
+	const struct ofono_call *call = a;
+	int status = L_PTR_TO_INT(b);
+
+	return status == call->status;
+}
+
+bool ofono_call_compare_by_id(const void *a, const void *b)
+{
+	const struct ofono_call *call = a;
+	unsigned int id = L_PTR_TO_UINT(b);
+
+	return (call->id == id);
+}
+
+void ofono_call_list_dial_callback(struct ofono_voicecall *vc,
+				   struct l_queue **call_list,
+				   const struct ofono_phone_number *ph,
+				   int call_id)
+{
+	struct ofono_call *call;
+
+	/* check if call_id already present */
+	call = l_queue_find(*call_list, ofono_call_compare_by_id,
+			    L_UINT_TO_PTR(call_id));
+
+	if (call) {
+		return;
+	}
+
+	call = l_new(struct ofono_call, 1);
+	call->id = call_id;
+
+	memcpy(&call->called_number, ph, sizeof(*ph));
+	call->direction = CALL_DIRECTION_MOBILE_ORIGINATED;
+	call->status = CALL_STATUS_DIALING;
+	call->type = 0; /* voice */
+
+	l_queue_insert(*call_list, call, ofono_call_compare, NULL);
+
+	ofono_voicecall_notify(vc, call);
+}
+
+void ofono_call_list_notify(struct ofono_voicecall *vc,
+			    struct l_queue **call_list, struct l_queue *calls)
+{
+	struct l_queue *old_calls = *call_list;
+	struct l_queue *new_calls = calls;
+	struct ofono_call *new_call, *old_call;
+	const struct l_queue_entry *old_entry, *new_entry;
+
+	uint loop_length =
+		MAX(l_queue_length(old_calls), l_queue_length(new_calls));
+
+	old_entry = l_queue_get_entries(old_calls);
+	new_entry = l_queue_get_entries(new_calls);
+
+	for (uint i = 0; i < loop_length; ++i) {
+		old_call = old_entry ? old_entry->data : NULL;
+		new_call = new_entry ? new_entry->data : NULL;
+
+		if (new_call && new_call->status == CALL_STATUS_DISCONNECTED) {
+			ofono_voicecall_disconnected(
+				vc, new_call->id,
+				OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
+
+			l_queue_remove(calls, new_call);
+			l_free(new_call);
+			continue;
+		}
+
+		if (old_call &&
+		    (new_call == NULL || (new_call->id > old_call->id))) {
+			ofono_voicecall_disconnected(
+				vc, old_call->id,
+				OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
+		} else if (new_call && (old_call == NULL ||
+					(new_call->id < old_call->id))) {
+			DBG("Notify new call %d", new_call->id);
+			/* new call, signal it */
+			if (new_call->type == 0) {
+				ofono_voicecall_notify(vc, new_call);
+			}
+		} else {
+			if (memcmp(new_call, old_call, sizeof(*new_call)) &&
+			    new_call->type == 0)
+				ofono_voicecall_notify(vc, new_call);
+		}
+		if (old_entry)
+			old_entry = old_entry->next;
+		if (new_entry)
+			new_entry = new_entry->next;
+	}
+
+	l_queue_destroy(*call_list, l_free);
+	*call_list = calls;
+}
+
+#define _(X)    \
+	case X: \
+		return #X
+
+const char *qmi_voice_call_state_name(enum qmi_voice_call_state value)
+{
+	switch (value) {
+		_(QMI_VOICE_CALL_STATE_IDLE);
+		_(QMI_VOICE_CALL_STATE_ORIG);
+		_(QMI_VOICE_CALL_STATE_INCOMING);
+		_(QMI_VOICE_CALL_STATE_CONV);
+		_(QMI_VOICE_CALL_STATE_CC_IN_PROG);
+		_(QMI_VOICE_CALL_STATE_ALERTING);
+		_(QMI_VOICE_CALL_STATE_HOLD);
+		_(QMI_VOICE_CALL_STATE_WAITING);
+		_(QMI_VOICE_CALL_STATE_DISCONNECTING);
+		_(QMI_VOICE_CALL_STATE_END);
+		_(QMI_VOICE_CALL_STATE_SETUP);
+	}
+	return "QMI_CALL_STATE_<UNKNOWN>";
+}
+
+int qmi_to_ofono_status(uint8_t status, int *ret)
+{
+	int err = 0;
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
+		err = 1;
+	}
+	return err;
+}
+
+uint8_t ofono_to_qmi_direction(enum call_direction ofono_direction)
+{
+	return ofono_direction + 1;
+}
+enum call_direction qmi_to_ofono_direction(uint8_t qmi_direction)
+{
+	return qmi_direction - 1;
+}
+
+enum parse_error
+qmi_voice_call_status(struct qmi_result *qmi_result,
+		      struct qmi_voice_all_call_status_ind *result)
+{
+	int err = NONE;
+	int offset;
+	uint16_t len;
+	bool status = true;
+	const struct qmi_voice_remote_party_number *remote_party_number;
+	const struct qmi_voice_call_information *call_information;
+
+	/* mandatory */
+	call_information = qmi_result_get(
+		qmi_result, QMI_VOICE_ALL_CALL_STATUS_CALL_INFORMATION, &len);
+
+	/* This is so ugly! but TLV for indicator and response is different */
+	if (!call_information) {
+		call_information = qmi_result_get(
+			qmi_result, QMI_VOICE_ALL_CALL_INFO_CALL_INFORMATION,
+			&len);
+		status = false;
+	}
+
+	if (call_information) {
+		/* verify the length */
+		if (len < sizeof(call_information->size))
+			return INVALID_LENGTH;
+
+		if (len != call_information->size *
+			sizeof(struct qmi_voice_call_information_instance) +
+			sizeof(call_information->size)) {
+			return INVALID_LENGTH;
+		}
+		result->call_information_set = 1;
+		result->call_information = call_information;
+	} else
+		return MISSING_MANDATORY;
+
+	/* mandatory */
+	remote_party_number = qmi_result_get(
+		qmi_result,
+		status ? QMI_VOICE_ALL_CALL_STATUS_REMOTE_NUMBER :
+			 QMI_VOICE_ALL_CALL_INFO_REMOTE_NUMBER,
+		&len);
+
+	if (remote_party_number) {
+		const struct qmi_voice_remote_party_number_instance *instance;
+		int instance_size =
+			sizeof(struct qmi_voice_remote_party_number_instance);
+		int i;
+
+		/* verify the length */
+		if (len < sizeof(remote_party_number->size))
+			return INVALID_LENGTH;
+
+		for (i = 0, offset = sizeof(remote_party_number->size);
+		     offset <= len && i < 16 && i < remote_party_number->size;
+		     i++) {
+			if (offset == len) {
+				break;
+			} else if (offset + instance_size > len) {
+				return INVALID_LENGTH;
+			}
+
+			instance = (void *)remote_party_number + offset;
+			result->remote_party_number[i] = instance;
+			offset +=
+				sizeof(struct qmi_voice_remote_party_number_instance) +
+				instance->number_size;
+		}
+		result->remote_party_number_set = 1;
+		result->remote_party_number_size = remote_party_number->size;
+	} else
+		return MISSING_MANDATORY;
+
+	return err;
+}
+
+static void all_call_status_ind(struct qmi_result *result, void *user_data)
+{
+	struct ofono_voicecall *vc = user_data;
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct l_queue *calls = NULL;
+	int i;
+	int size = 0;
+	struct qmi_voice_all_call_status_ind status_ind;
+
+	calls = l_queue_new();
+
+	DBG("");
+	if (qmi_voice_call_status(result, &status_ind) != NONE) {
+		DBG("Parsing of all call status indication failed");
+		return;
+	}
+
+	if (!status_ind.remote_party_number_set ||
+	    !status_ind.call_information_set) {
+		DBG("Some required fields are not set");
+		return;
+	}
+
+	size = status_ind.call_information->size;
+	if (!size) {
+		DBG("No call informations received!");
+		return;
+	}
+
+	/* expect we have valid fields for every call */
+	if (size != status_ind.remote_party_number_size) {
+		DBG("Not all fields have the same size");
+		return;
+	}
+
+	for (i = 0; i < size; i++) {
+		struct qmi_voice_call_information_instance call_info;
+		struct ofono_call *call;
+		const struct qmi_voice_remote_party_number_instance
+			*remote_party = status_ind.remote_party_number[i];
+		int number_size;
+
+		call_info = status_ind.call_information->instance[i];
+		call = l_new(struct ofono_call, 1);
+		call->id = call_info.id;
+		call->direction = qmi_to_ofono_direction(call_info.direction);
+
+		if (qmi_to_ofono_status(call_info.state, &call->status)) {
+			DBG("Ignore call id %d, because can not convert QMI state 0x%x to ofono.",
+			    call_info.id, call_info.state);
+			continue;
+		}
+		DBG("Call %d in state %s(%d)", call_info.id,
+		    qmi_voice_call_state_name(call_info.state),
+		    call_info.state);
+
+		call->type = 0; /* always voice */
+		number_size = remote_party->number_size;
+		if (number_size > OFONO_MAX_PHONE_NUMBER_LENGTH)
+			number_size = OFONO_MAX_PHONE_NUMBER_LENGTH;
+		strncpy(call->phone_number.number, remote_party->number,
+			number_size);
+		/* FIXME: set phone_number_type */
+
+		if (strlen(call->phone_number.number) > 0)
+			call->clip_validity = 0;
+		else
+			call->clip_validity = 2;
+
+		l_queue_push_tail(calls, call);
+		DBG("%d", l_queue_length(calls));
+	}
+
+	ofono_call_list_notify(vc, &vd->call_list, calls);
+}
+
+enum parse_error
+qmi_voice_dial_call_parse(struct qmi_result *qmi_result,
+			  struct qmi_voice_dial_call_result *result)
+{
+	int err = NONE;
+
+	/* mandatory */
+	if (qmi_result_get_uint8(qmi_result, QMI_VOICE_DIAL_RETURN_CALL_ID,
+				 &result->call_id))
+		result->call_id_set = 1;
+	else
+		err = MISSING_MANDATORY;
+
+	return err;
+}
+
+static void dial_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	struct ofono_voicecall *vc = cbd->user;
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	ofono_voicecall_cb_t cb = cbd->cb;
+	uint16_t error;
+	struct qmi_voice_dial_call_result dial_result;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("QMI Error %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	if (qmi_voice_dial_call_parse(result, &dial_result) != NONE) {
+		DBG("Received invalid Result");
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	if (!dial_result.call_id_set) {
+		DBG("Didn't receive a call id");
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	DBG("New call QMI id %d", dial_result.call_id);
+	ofono_call_list_dial_callback(vc, &vd->call_list, &vd->dialed,
+				      dial_result.call_id);
+
+	/* FIXME: create a timeout on this call_id */
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void dial(struct ofono_voicecall *vc,
+		 const struct ofono_phone_number *ph,
+		 enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+		 void *data)
+{
+	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_voice_dial_call_arg arg;
+	struct qmi_param *param = NULL;
+
+	DBG("");
+
+	cbd->user = vc;
+	arg.calling_number_set = true;
+	arg.calling_number = phone_number_to_string(ph);
+	memcpy(&vd->dialed, ph, sizeof(*ph));
+
+	arg.call_type_set = true;
+	arg.call_type = QMI_VOICE_CALL_TYPE_VOICE;
+
+	param = qmi_param_new();
+	if (!param)
+		goto error;
+
+	if (arg.calling_number_set) {
+		if (!qmi_param_append(param, QMI_VOICE_DIAL_CALL_NUMBER,
+				      strlen(arg.calling_number),
+				      arg.calling_number)) {
+			goto error;
+		}
+	}
+
+	if (arg.call_type_set)
+		qmi_param_append_uint8(param, QMI_VOICE_DIAL_CALL_TYPE,
+				       arg.call_type);
+
+	if (qmi_service_send(vd->voice, QMI_VOICE_DIAL_CALL, param, dial_cb,
+			     cbd, l_free) > 0) {
+		return;
+	}
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
@@ -58,6 +554,9 @@ static void create_voice_cb(struct qmi_service *service, void *user_data)
 
 	data->voice = qmi_service_ref(service);
 
+	qmi_service_register(data->voice, QMI_VOICE_IND_ALL_STATUS,
+			     all_call_status_ind, vc, NULL);
+
 	ofono_voicecall_register(vc);
 }
 
@@ -70,6 +569,7 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 	DBG("");
 
 	data = l_new(struct voicecall_data, 1);
+	data->call_list = l_queue_new();
 
 	ofono_voicecall_set_data(vc, data);
 
@@ -77,7 +577,6 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 					create_voice_cb, vc, NULL);
 
 	return 0;
-
 }
 
 static void qmi_voicecall_remove(struct ofono_voicecall *vc)
@@ -98,7 +597,9 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
 static const struct ofono_voicecall_driver driver = {
 	.probe		= qmi_voicecall_probe,
 	.remove		= qmi_voicecall_remove,
+	.dial		= dial,
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
 
+
-- 
2.44.0

