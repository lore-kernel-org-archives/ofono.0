Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A7111A9
	for <ofono@lists.linux.dev>; Wed, 14 Feb 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892355; cv=none; b=BdWaa5fpnCyxBBPLZiUXPDrsxrCpPrcJ8jJL8pRdPYDVxEUUKjs7viZDqCEN93D0oeifft6PefEjsl+CmBoM8vjWJ+QGDE9a0oEMbUlvDqJI2JdNiEq8yXUVBK2rGneXMoCs85oEClpVi+hugsRlRgFLdj0wthfC6KZ5HxbiH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892355; c=relaxed/simple;
	bh=Dv9+fQQE0TL9DuEDH9CTNs4hmcH/81VrCgvk7QIanpo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DhFDc/j1GQLUw0zvSrzHvLMvb2po2ejQxrAoFivPWcu3BpiIazkfvjB7AAmxs3seEqYFSdhRgBQ5GIIxHPkVeRavQBYDzs4dc+0sfffwhJSHGfopC3lRJa6wDyrfLk0qTlDX//vlHfDJcG12MLTwxM7SexZlsegprFwO6G52/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaGBoE1P; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaGBoE1P"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3d5181b3a7so22235066b.1
        for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 22:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707892352; x=1708497152; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLYyyqBPh9z0jrnCc1vy4VNrSiO3DCUqc9WoieCDW0g=;
        b=NaGBoE1P+bz3YW9ZpRo09I9ZxND4b6h5t/NNgyfCNFrAKFl9GMv2x3T73IAnZ5gSmg
         jwus063cAq+umQS5s0tPz6kP7RueUY9Nz9RdltIQMZiT/o9LFK6cGFBGwrW4a/0Z9m5K
         YEWloN06/4sH8uNA4MD8hQCvHAhb+f7KuWdGCXJPXVwhFMvDDP+PBbRTpCSW3ZeMtdDU
         LSwvjPyqZQ5nDJpqnJTMheX8jxoFvlab3L4J4PpHtddJtiB/p8Uv7ZU9rDqSp1RBPaUY
         bsNbOl7awQ0VGwFIDdc0UZ2WTSgjwpzB6dbJ8Xql3v6eHxlXbd4Md9kNh5hdAda6gFQ5
         CB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892352; x=1708497152;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLYyyqBPh9z0jrnCc1vy4VNrSiO3DCUqc9WoieCDW0g=;
        b=OJNWb7TW8+gBsFRtBGieMZN6qW81b3Gq70AhJ/EJ87DsL4/puJ017YUWrXcuXRS5fi
         o3RhtWVOxu9DQyVCLRax1rrH9JaQwd3u+3IW5ZybgKzFidMDPTeajS4xvsUIzpO1oyF0
         Fc2wxfwVwdFjRDfL17xLB49PWEbYhB9YPNh2VzrX3N8+l9gqX7lHawdWZt2VDWmWyLuQ
         Vy4EPt8nAp7VF5XaOR5w3p/cxBa4Ql+jQOYldh8+XYIcrtWdLS4cBbKjtpW8AWTjKZQK
         /GiiuatNNrzLi0NKoe3SonH8CrhWDU/ydIj09+cnRnBcEnDuzUihGRnchwYqwOwJyVSI
         DmwA==
X-Gm-Message-State: AOJu0YxhLPQ0MeFxPOyTTnoiW1OIICogpXWQJOvMzzFEzviezh6kFQhF
	X4+d2sJTdaaBC9Z1qDmcND7OrRdW7aRf1vo8HuHvNEkcSKKnCnjYzLOPYKUD
X-Google-Smtp-Source: AGHT+IGs2BZBHO4vNTllvh+tV7sBXTAONF8Po4KNJtIjVfTQBnE6ru82ls/VWaK0KRRzyBpX9sThaA==
X-Received: by 2002:a17:906:f812:b0:a38:3eb1:40a1 with SMTP id kh18-20020a170906f81200b00a383eb140a1mr845213ejb.26.1707892351711;
        Tue, 13 Feb 2024 22:32:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXa86YROJ+gASqrZXrQCBkufd/eaaMmUe8VWhruNrJzXpZnNt2GD8Q9zoY2gt/frswBbSxwBqFN+iSMoIY15+p/mHx+evM4JOh47UHViLCfDxEHMoxyVSINoctlR0DH
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906250800b00a37624d003fsm1988595ejb.121.2024.02.13.22.32.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2024 22:32:31 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmimodem: implement CallSettings
Date: Wed, 14 Feb 2024 08:32:08 +0200
Message-Id: <1707892328-16334-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 Makefile.am                      |   3 +-
 drivers/qmimodem/call-settings.c | 346 +++++++++++++++++++++++++++++++
 drivers/qmimodem/voice.h         |  45 +++-
 plugins/gobi.c                   |   5 +-
 4 files changed, 392 insertions(+), 7 deletions(-)
 create mode 100644 drivers/qmimodem/call-settings.c

diff --git a/Makefile.am b/Makefile.am
index a82340eb..d8766e08 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -386,7 +386,8 @@ builtin_sources += $(qmi_sources) \
 			drivers/qmimodem/lte.c \
 			drivers/qmimodem/radio-settings.c \
 			drivers/qmimodem/location-reporting.c \
-			drivers/qmimodem/netmon.c
+			drivers/qmimodem/netmon.c \
+			drivers/qmimodem/call-settings.c
 
 builtin_modules += gobi
 builtin_sources += plugins/gobi.c
diff --git a/drivers/qmimodem/call-settings.c b/drivers/qmimodem/call-settings.c
new file mode 100644
index 00000000..cca1d2aa
--- /dev/null
+++ b/drivers/qmimodem/call-settings.c
@@ -0,0 +1,346 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2024 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-settings.h>
+
+#include "qmi.h"
+#include "voice.h"
+#include "util.h"
+
+struct call_settings_data {
+	struct qmi_service *voice;
+	uint16_t sups_ind_id;
+};
+
+static void query_status(struct ofono_call_settings *cs, uint16_t message,
+			     qmi_result_func_t fn,
+			     ofono_call_settings_status_cb_t cb, void *data)
+{
+	struct call_settings_data *csd = ofono_call_settings_get_data(cs);
+	struct cb_data *cbd = cb_data_new(cb, data);
+
+	DBG("");
+
+	if (!csd)
+		goto error;
+
+	if (qmi_service_send(csd->voice, message, NULL, fn, cbd, g_free) > 0)
+		return;
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void cw_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_call_settings_status_cb_t cb = cbd->cb;
+	uint8_t status;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL) ||
+	    !qmi_result_get_uint8(result, 0x10, &status)) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
+}
+
+static void qmi_cw_query(struct ofono_call_settings *cs, int cls,
+			 ofono_call_settings_status_cb_t cb, void *data)
+{
+	query_status(cs, QMI_VOICE_GET_CALL_WAITING, cw_cb, cb, data);
+}
+
+static void status_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_call_settings_status_cb_t cb = cbd->cb;
+	uint16_t len;
+	const struct __attribute__((__packed__)) {
+		uint8_t active;
+		uint8_t provisioned;
+	} *rsp;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	rsp = qmi_result_get(result, 0x10, &len);
+	if (!rsp || len != sizeof(*rsp))
+		goto error;
+
+	CALLBACK_WITH_SUCCESS(cb, rsp->provisioned, cbd->data);
+	return;
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void qmi_clip_query(struct ofono_call_settings *cs,
+			   ofono_call_settings_status_cb_t cb, void *data)
+{
+	query_status(cs, QMI_VOICE_GET_CLIP, status_cb, cb, data);
+}
+
+static void qmi_colp_query(struct ofono_call_settings *cs,
+			   ofono_call_settings_status_cb_t cb, void *data)
+{
+	query_status(cs, QMI_VOICE_GET_COLP, status_cb, cb, data);
+}
+
+static void qmi_colr_query(struct ofono_call_settings *cs,
+			   ofono_call_settings_status_cb_t cb, void *data)
+{
+	query_status(cs, QMI_VOICE_GET_COLR, status_cb, cb, data);
+}
+
+static void qmi_cnap_query(struct ofono_call_settings *cs,
+			   ofono_call_settings_status_cb_t cb, void *data)
+{
+	query_status(cs, QMI_VOICE_GET_CNAP, status_cb, cb, data);
+}
+
+static void clir_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_call_settings_clir_cb_t cb = cbd->cb;
+	uint16_t len;
+	const struct __attribute__((__packed__)) {
+		uint8_t active;
+		uint8_t provisioned;
+	} *rsp;
+	uint8_t network;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	rsp = qmi_result_get(result, 0x10, &len);
+	if (!rsp || len != sizeof(*rsp))
+		goto error;
+
+	network = rsp->provisioned;
+	/* we do not have UNKNOWN */
+	if (network > 1)
+		network++;
+
+	CALLBACK_WITH_SUCCESS(cb, rsp->active, network, cbd->data);
+	return;
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, -1, cbd->data);
+}
+
+static void qmi_clir_query(struct ofono_call_settings *cs,
+			 ofono_call_settings_clir_cb_t cb, void *data)
+{
+	struct call_settings_data *csd = ofono_call_settings_get_data(cs);
+	struct cb_data *cbd = cb_data_new(cb, data);
+
+	DBG("");
+
+	if (!csd)
+		goto error;
+
+	if (qmi_service_send(csd->voice, QMI_VOICE_GET_CLIR, NULL, clir_cb, cbd,
+			     g_free) > 0)
+		return;
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, -1, -1, data);
+}
+
+static void cw_set_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_call_settings_set_cb_t cb = cbd->cb;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL)) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void qmi_cw_set(struct ofono_call_settings *cs, int mode, int cls,
+		       ofono_call_settings_set_cb_t cb, void *data)
+{
+	struct call_settings_data *csd = ofono_call_settings_get_data(cs);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param;
+	struct __attribute__((__packed__)) {
+		uint8_t service;
+		uint8_t reason;
+	} ssd;
+
+	DBG("");
+
+	if (!csd)
+		goto error;
+
+	param = qmi_param_new();
+
+	ssd.service = mode ? QMI_VOICE_SS_ACTION_ACTIVATE :
+			     QMI_VOICE_SS_ACTION_DEACTIVATE;
+	ssd.reason = QMI_VOICE_SS_RSN_CALL_WAITING;
+
+	qmi_param_append(param, 0x01, sizeof(ssd), &ssd);
+
+	if (cls != 7 /* BEARER_CLASS_DEFAULT */)
+		qmi_param_append_uint8(param, 0x10, cls);
+
+	if (qmi_service_send(csd->voice, QMI_VOICE_SET_SUPS_SERVICE, param,
+			     cw_set_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+/* call_settings API lacks change notifications, just log data for now */
+static void sups_ind(struct qmi_result *result, void *user_data)
+{
+	const struct __attribute__((__packed__)) {
+		uint8_t request;
+		uint8_t mod_cc;
+	} *info;
+	const struct __attribute__((__packed__)) {
+		uint8_t active;
+		uint8_t status;
+	} *clir;
+	const struct __attribute__((__packed__)) {
+		uint8_t active;
+		uint8_t provisioned;
+	} *clip;
+	uint8_t cls;
+	uint8_t reason;
+	uint8_t data;
+	uint16_t len;
+
+	DBG("SS notification");
+
+	if ((info = qmi_result_get(result, 0x01, &len)) && len == sizeof(*info))
+		DBG("request %d", info->request);
+
+	if (qmi_result_get_uint8(result, 0x10, &cls))
+		DBG("class %d", cls);
+
+	if (qmi_result_get_uint8(result, 0x11, &reason))
+		DBG("reason %d", reason);
+
+	if (qmi_result_get_uint8(result, 0x19, &data))
+		DBG("data %d", data);
+
+	if ((clir = qmi_result_get(result, 0x1c, &len)) &&
+	    len == sizeof(*clir)) {
+		DBG("clir active %d, status %d", clir->active, clir->status);
+	}
+
+	if ((clip = qmi_result_get(result, 0x1d, &len)) &&
+	    len == sizeof(*clip)) {
+		DBG("clip active %d, provisioned %d", clip->active,
+		    clip->provisioned);
+	}
+}
+
+static void create_voice_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_call_settings *cs = user_data;
+	struct call_settings_data *csd = ofono_call_settings_get_data(cs);
+
+	DBG("");
+
+	if (!service) {
+		ofono_error("Failed to request Voice service");
+		ofono_call_settings_remove(cs);
+		return;
+	}
+
+	csd->voice = qmi_service_ref(service);
+
+	csd->sups_ind_id = qmi_service_register(csd->voice, QMI_VOICE_SUPS_IND,
+						sups_ind, cs, NULL);
+
+	ofono_call_settings_register(cs);
+}
+
+static int qmi_call_settings_probe(struct ofono_call_settings *cs,
+				   unsigned int vendor, void *user_data)
+{
+	struct qmi_device *device = user_data;
+	struct call_settings_data *csd;
+
+	DBG("");
+
+	csd = g_new0(struct call_settings_data, 1);
+
+	ofono_call_settings_set_data(cs, csd);
+
+	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
+				  create_voice_cb, cs, NULL);
+
+	return 0;
+}
+
+static void qmi_call_settings_remove(struct ofono_call_settings *cs)
+{
+	struct call_settings_data *csd = ofono_call_settings_get_data(cs);
+
+	DBG("");
+
+	ofono_call_settings_set_data(cs, NULL);
+
+	if (csd->voice) {
+		qmi_service_unregister(csd->voice, csd->sups_ind_id);
+		qmi_service_unref(csd->voice);
+	}
+
+	g_free(csd);
+}
+
+static const struct ofono_call_settings_driver driver = {
+	.probe			= qmi_call_settings_probe,
+	.remove			= qmi_call_settings_remove,
+	.clip_query		= qmi_clip_query,
+	.colp_query		= qmi_colp_query,
+	.colr_query		= qmi_colr_query,
+	.cnap_query		= qmi_cnap_query,
+	.clir_query		= qmi_clir_query,
+	.cw_query		= qmi_cw_query,
+	.cw_set			= qmi_cw_set
+};
+
+OFONO_ATOM_DRIVER_BUILTIN(call_settings, qmimodem, &driver)
diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index ca146491..7755d2e0 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -48,11 +48,19 @@ enum qmi_ussd_user_required {
 
 /* QMI service voice. Using an enum to prevent doublicated entries */
 enum voice_commands {
-	QMI_VOICE_CANCEL_USSD =		0x3c,
-	QMI_VOICE_USSD_RELEASE_IND =	0x3d,
-	QMI_VOICE_USSD_IND =		0x3e,
-	QMI_VOICE_SUPS_IND =		0x42,
-	QMI_VOICE_ASYNC_ORIG_USSD =	0x43,
+	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
+	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
+	QMI_VOICE_GET_CALL_WAITING =		0x34,
+	QMI_VOICE_GET_CLIP =			0x36,
+	QMI_VOICE_GET_CLIR =			0x37,
+	QMI_VOICE_CANCEL_USSD =			0x3c,
+	QMI_VOICE_USSD_RELEASE_IND =		0x3d,
+	QMI_VOICE_USSD_IND =			0x3e,
+	QMI_VOICE_SUPS_IND =			0x42,
+	QMI_VOICE_ASYNC_ORIG_USSD =		0x43,
+	QMI_VOICE_GET_COLP =			0x4b,
+	QMI_VOICE_GET_COLR =			0x4c,
+	QMI_VOICE_GET_CNAP =			0x4d
 };
 
 struct qmi_ussd_data {
@@ -60,3 +68,30 @@ struct qmi_ussd_data {
 	uint8_t length;
 	uint8_t data[0];
 } __attribute__((__packed__));
+
+enum qmi_ss_action {
+	QMI_VOICE_SS_ACTION_ACTIVATE =		0x01,
+	QMI_VOICE_SS_ACTION_DEACTIVATE =	0x02,
+	QMI_VOICE_SS_ACTION_REGISTER =		0x03,
+	QMI_VOICE_SS_ACTION_ERASE =		0x04
+};
+
+enum qmi_ss_reason {
+	QMI_VOICE_SS_RSN_FWD_UNCONDITIONAL =	0x01,
+	QMI_VOICE_SS_RSN_FWD_MOBILE_BUSY =	0x02,
+	QMI_VOICE_SS_RSN_FWD_NO_REPLY  =	0x03,
+	QMI_VOICE_SS_RSN_FWD_UNREACHABLE =	0x04,
+	QMI_VOICE_SS_RSN_FWD_ALL =		0x05,
+	QMI_VOICE_SS_RSN_FWD_ALL_CONDITIONAL =	0x06,
+	QMI_VOICE_SS_RSN_ALL_OUTGOING =		0x07,
+	QMI_VOICE_SS_RSN_OUT_INT =		0x08,
+	QMI_VOICE_SS_RSN_OUT_INT_EXT_TO_HOME =	0x09,
+	QMI_VOICE_SS_RSN_ALL_IN =		0x0A,
+	QMI_VOICE_SS_RSN_IN_ROAMING =		0x0B,
+	QMI_VOICE_SS_RSN_BAR_ALL =		0x0C,
+	QMI_VOICE_SS_RSN_BAR_ALL_OUTGOING =	0x0D,
+	QMI_VOICE_SS_RSN_BAR_ALL_IN =		0x0E,
+	QMI_VOICE_SS_RSN_CALL_WAITING =		0x0F,
+	QMI_VOICE_SS_RSN_CLIP =			0x10,
+	QMI_VOICE_SS_RSN_CLIR =			0x11
+};
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 21f70d1e..a5500166 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -33,6 +33,7 @@
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
 #include <ofono/modem.h>
+#include <ofono/call-settings.h>
 #include <ofono/devinfo.h>
 #include <ofono/netreg.h>
 #include <ofono/netmon.h>
@@ -753,8 +754,10 @@ static void gobi_post_online(struct ofono_modem *modem)
 		ofono_netmon_create(modem, 0, "qmimodem", data->device);
 	}
 
-	if (data->features & GOBI_VOICE)
+	if (data->features & GOBI_VOICE) {
 		ofono_ussd_create(modem, 0, "qmimodem", data->device);
+		ofono_call_settings_create(modem, 0, "qmimodem", data->device);
+	}
 }
 
 static struct ofono_modem_driver gobi_driver = {
-- 
2.30.2

