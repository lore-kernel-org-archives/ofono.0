Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856633C5
	for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707981495; cv=none; b=ZCaGGHuiDIoT0gl4QvdwLSjqrkS+NEXsTkOCPUS7QpsXJqhOm05Ooqw57ZEfoViJuVnQazOcSfaUAjJ/Cwq5U9kzJcXGSXeZHs+TAogbMI9+FfknHmyfeey+C7ZNZoU7x4RqTmdl9TKg2zCoxaVg3MVheJyBlL01/T3Tj8HlE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707981495; c=relaxed/simple;
	bh=JxRq1tZrQO++pyshQxpKFqadptkrfSDh9pYWzVvaTNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dil1fjVydJ/Zx2uUNfFFk8xGHdTPveer2L7Yl3XrZntgkYfmBd8Nv31IogIdFC2rwYJ8MTaECYGr97BqmfhDNXtImX7mk1qQA1IoGNAyZknSB0fMh16U/5vEpZu8Di5kJEF0IfBU29MVXyuTSXjdTJLNi0og/t8xyzkE69WKgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1D6UkEJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1D6UkEJ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so656143e87.3
        for <ofono@lists.linux.dev>; Wed, 14 Feb 2024 23:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707981491; x=1708586291; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n9eaJ6O6VEn9nDgBeSQZCXRmdo59/l8xGBTgYDWe0Dw=;
        b=c1D6UkEJu4Nr2+ip7hULXeBywX4oyQE1/6o1mX1r6RFL4idV3q3MTFxMESk8Df2NOG
         5YffUTiHYheNTmp/pPLfIY55G6axwDq5sYkvdciXr1Bli2pM3GL5FPAU4OcXXT1h/TZ7
         w0rCsvkGnPQyUa6oCImyiH2g6md9fZULSiedHBrBoMUyyCW/quub5wCVyfqJLtfqs86V
         yOKtJLmfTOUQRukDFoeq16xpZ5rEoE20xcxoC7RxsPRGpcscJWVzBVoweIfbU6Ty7pvg
         JO4+WCeG73GoJB8xIGuOndAvERq2MqqYDwi3JHGDM/jpxjVs/x8ApaLMHaZHJrSNe5Cb
         9Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707981491; x=1708586291;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9eaJ6O6VEn9nDgBeSQZCXRmdo59/l8xGBTgYDWe0Dw=;
        b=CsgN5aMqVVb9VyrB3SVRxvt7uQhqf9JFFoM6VnykXPLkw3mVjQlD8aZsWOI6hPfyqE
         sFWnMeX6yXoxYhBXnBLlOqbdEiVZURR+W7dL4LZZfsxklWz8oz48tYEzx4oI7yCRzM+P
         15ii8lhN8GMnEssrpIC8DR8VBkjxPf91zFrYszFvzRxnzf/ARbeiMqIVf47LkNDiXGxV
         5ooE6mAZGI3L9oUcNOQecwWah2iPs/sI2NKue2MCIra7425n2+SUJU9d022gQ1V/6nUo
         kv+YHMUfmREpklx2oXmJmAcpq5JwBpNJWKils50g/B4n6vA4aJ2FSzYh6E1dP4CKes8N
         6lZw==
X-Gm-Message-State: AOJu0YxsVuvk7wJ/Gcimcx0jXnT8R2xrQEAVHadL45odVU02VknVxUg7
	BPl3AO8mEP0bN+ch+S9fn22TAeh+KUoP8yionaW3WVaneJC7FUPmsrS+YRgR
X-Google-Smtp-Source: AGHT+IENYPoy2CjjR4SjTYZV+M+lTmZF1FM0Mp0/HuFX4iUN9zmhXGr7+r/7gkdwDMyk22T0sM6WSg==
X-Received: by 2002:ac2:518e:0:b0:511:6764:a8c7 with SMTP id u14-20020ac2518e000000b005116764a8c7mr779174lfi.10.1707981490240;
        Wed, 14 Feb 2024 23:18:10 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id v28-20020a50955c000000b0056003b75400sm293671eda.44.2024.02.14.23.18.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2024 23:18:10 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/2] qmimodem: implement call-forwarding driver
Date: Thu, 15 Feb 2024 09:17:47 +0200
Message-Id: <1707981467-2955-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1707981467-2955-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1707981467-2955-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 Makefile.am                        |   3 +-
 drivers/qmimodem/call-forwarding.c | 352 +++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/voice.h           |   1 +
 plugins/gobi.c                     |   3 +
 4 files changed, 358 insertions(+), 1 deletion(-)
 create mode 100644 drivers/qmimodem/call-forwarding.c

diff --git a/Makefile.am b/Makefile.am
index 98f41e0..77df87a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -388,7 +388,8 @@ builtin_sources += $(qmi_sources) \
 			drivers/qmimodem/location-reporting.c \
 			drivers/qmimodem/netmon.c \
 			drivers/qmimodem/call-settings.c \
-			drivers/qmimodem/call-barring.c
+			drivers/qmimodem/call-barring.c \
+			drivers/qmimodem/call-forwarding.c
 
 builtin_modules += gobi
 builtin_sources += plugins/gobi.c
diff --git a/drivers/qmimodem/call-forwarding.c b/drivers/qmimodem/call-forwarding.c
new file mode 100644
index 0000000..45f25ae
--- /dev/null
+++ b/drivers/qmimodem/call-forwarding.c
@@ -0,0 +1,352 @@
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
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-forwarding.h>
+
+#include "qmi.h"
+#include "voice.h"
+#include "util.h"
+
+struct call_forwarding_data {
+	struct qmi_service *voice;
+};
+
+struct call_forwarding_info_ext {
+	uint8_t active;
+	uint8_t cls;
+	uint8_t time;
+	uint8_t pind;
+	uint8_t sind;
+	uint8_t type;
+	uint8_t plan;
+	uint8_t len;
+	uint8_t number[0];
+};
+
+static int forw_type_to_reason(int type)
+{
+	switch (type) {
+	case 0:
+		return QMI_VOICE_SS_RSN_FWD_UNCONDITIONAL;
+	case 1:
+		return QMI_VOICE_SS_RSN_FWD_MOBILE_BUSY;
+	case 2:
+		return QMI_VOICE_SS_RSN_FWD_NO_REPLY;
+	case 3:
+		return QMI_VOICE_SS_RSN_FWD_UNREACHABLE;
+	case 4:
+		return QMI_VOICE_SS_RSN_FWD_ALL;
+	case 5:
+		return QMI_VOICE_SS_RSN_FWD_ALL_CONDITIONAL;
+	default:
+		DBG("Unknown forwarding type %d", type);
+		return 0;
+	}
+}
+
+static void set_fwd_cond(struct ofono_call_forwarding_condition *cond,
+				int status, int cls, int time, int type,
+				uint8_t *number, uint8_t nlen)
+{
+	uint8_t maxlen = OFONO_MAX_PHONE_NUMBER_LENGTH;
+
+	cond->status = status;
+	cond->cls = cls;
+	cond->time = time;
+	cond->phone_number.type = type;
+
+	if (nlen < maxlen)
+		maxlen = nlen;
+
+	memcpy(&cond->phone_number.number, number, maxlen);
+	cond->phone_number.number[maxlen] = 0;
+}
+
+static void query_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_call_forwarding_query_cb_t cb = cbd->cb;
+	const uint8_t *p;
+	uint8_t num;
+	uint16_t length;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	/*
+	 * we want extended info, because of the number type.
+	 * FIXME - shall we fallback to 0x10 if there is no extended info?
+	 */
+	p = qmi_result_get(result, 0x16, &length);
+	if (p) {
+		struct ofono_call_forwarding_condition *list;
+		const uint8_t *end = p + length;
+		int i;
+
+		num = *p++;
+
+		list = g_new0(struct ofono_call_forwarding_condition, num);
+
+		for (i = 0; i < num; i++) {
+			struct call_forwarding_info_ext *info = (void *)p;
+			int type;
+
+			/* do not try to access beyond buffer end */
+			if (p + sizeof(*info) > end ||
+					p + sizeof(*info) + info->len > end) {
+				g_free(list);
+				goto error;
+			}
+
+			if (info->type == 1)
+				type = OFONO_NUMBER_TYPE_INTERNATIONAL;
+			else
+				type = OFONO_NUMBER_TYPE_UNKNOWN;
+
+			set_fwd_cond(&list[i], info->active, info->cls,
+					info->time, type, info->number,
+					info->len);
+			p += sizeof(*info) + info->len;
+		}
+
+		CALLBACK_WITH_SUCCESS(cb, num, list, cbd->data);
+		g_free(list);
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+}
+
+static void qmi_query(struct ofono_call_forwarding *cf, int type, int cls,
+			ofono_call_forwarding_query_cb_t cb, void *data)
+{
+	struct call_forwarding_data *cfd = ofono_call_forwarding_get_data(cf);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param;
+	uint8_t reason = forw_type_to_reason(type);
+
+	DBG("");
+
+	if (!cfd || !reason)
+		goto error;
+
+	param = qmi_param_new();
+	qmi_param_append_uint8(param, 0x01, reason);
+
+	if (cls != 7 /* BEARER_CLASS_DEFAULT */)
+		qmi_param_append_uint8(param, 0x10, cls);
+
+	if (qmi_service_send(cfd->voice, QMI_VOICE_GET_CALL_FWDING, param,
+				query_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, 0, NULL, data);
+}
+
+static void set_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_call_forwarding_set_cb_t cb = cbd->cb;
+
+	DBG("");
+
+	if (!qmi_result_set_error(result, NULL))
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void qmi_register(struct ofono_call_forwarding *cf, int type, int cls,
+				const struct ofono_phone_number *ph, int time,
+				ofono_call_forwarding_set_cb_t cb, void *data)
+{
+	struct call_forwarding_data *cfd = ofono_call_forwarding_get_data(cf);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param;
+	struct __attribute__((__packed__)) {
+		uint8_t service;
+		uint8_t reason;
+	} ssd;
+	struct __attribute__((__packed__)) {
+		uint8_t type;
+		uint8_t plan;
+	} tpd;
+
+	DBG("");
+
+	ssd.reason = forw_type_to_reason(type);
+
+	if (!cfd || !ssd.reason)
+		goto error;
+
+	ssd.service = QMI_VOICE_SS_ACTION_REGISTER;
+
+	param = qmi_param_new();
+	qmi_param_append(param, 0x01, sizeof(ssd), &ssd);
+
+	if (cls != 7 /* BEARER_CLASS_DEFAULT */)
+		qmi_param_append_uint8(param, 0x10, cls);
+
+	qmi_param_append(param, 0x12, strlen(ph->number), ph->number);
+	qmi_param_append_uint8(param, 0x13, time);
+
+	tpd.type = ph->type == OFONO_NUMBER_TYPE_INTERNATIONAL ? 1 : 0;
+	tpd.plan = tpd.type;
+	qmi_param_append(param, 0x14, sizeof(tpd), &tpd);
+
+	if (qmi_service_send(cfd->voice, QMI_VOICE_SET_SUPS_SERVICE, param,
+				set_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void qmi_set(struct ofono_call_forwarding *cf, int type, int cls,
+			int service, ofono_call_forwarding_set_cb_t cb,
+			void *data)
+{
+	struct call_forwarding_data *cfd = ofono_call_forwarding_get_data(cf);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param;
+	struct __attribute__((__packed__)) {
+		uint8_t service;
+		uint8_t reason;
+	} ssd;
+
+	DBG("");
+
+	ssd.reason = forw_type_to_reason(type);
+
+	if (!cfd || !ssd.reason)
+		goto error;
+
+	ssd.service = service;
+
+	param = qmi_param_new();
+	qmi_param_append(param, 0x01, sizeof(ssd), &ssd);
+
+	if (cls != 7 /* BEARER_CLASS_DEFAULT */)
+		qmi_param_append_uint8(param, 0x10, cls);
+
+	if (qmi_service_send(cfd->voice, QMI_VOICE_SET_SUPS_SERVICE, param,
+				set_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void qmi_activate(struct ofono_call_forwarding *cf, int type, int cls,
+				ofono_call_forwarding_set_cb_t cb, void *data)
+{
+	qmi_set(cf, type, cls, QMI_VOICE_SS_ACTION_ACTIVATE, cb, data);
+}
+
+static void qmi_deactivate(struct ofono_call_forwarding *cf, int type, int cls,
+				ofono_call_forwarding_set_cb_t cb, void *data)
+{
+	qmi_set(cf, type, cls, QMI_VOICE_SS_ACTION_DEACTIVATE, cb, data);
+}
+
+static void qmi_erase(struct ofono_call_forwarding *cf, int type, int cls,
+			ofono_call_forwarding_set_cb_t cb, void *data)
+{
+	qmi_set(cf, type, cls, QMI_VOICE_SS_ACTION_ERASE, cb, data);
+}
+
+static void create_voice_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_call_forwarding *cf = user_data;
+	struct call_forwarding_data *cfd = ofono_call_forwarding_get_data(cf);
+
+	DBG("");
+
+	if (!service) {
+		ofono_error("Failed to request Voice service");
+		ofono_call_forwarding_remove(cf);
+		return;
+	}
+
+	cfd->voice = qmi_service_ref(service);
+
+	ofono_call_forwarding_register(cf);
+}
+
+static int qmi_call_forwarding_probe(struct ofono_call_forwarding *cf,
+					unsigned int vendor, void *user_data)
+{
+	struct qmi_device *device = user_data;
+	struct call_forwarding_data *cfd;
+
+	DBG("");
+
+	cfd = g_new0(struct call_forwarding_data, 1);
+
+	ofono_call_forwarding_set_data(cf, cfd);
+
+	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
+					create_voice_cb, cf, NULL);
+
+	return 0;
+}
+
+static void qmi_call_forwarding_remove(struct ofono_call_forwarding *cf)
+{
+	struct call_forwarding_data *cfd = ofono_call_forwarding_get_data(cf);
+
+	DBG("");
+
+	ofono_call_forwarding_set_data(cf, NULL);
+
+	if (cfd->voice)
+		qmi_service_unref(cfd->voice);
+
+	g_free(cfd);
+}
+
+static const struct ofono_call_forwarding_driver driver = {
+	.probe			= qmi_call_forwarding_probe,
+	.remove			= qmi_call_forwarding_remove,
+	.registration		= qmi_register,
+	.activation		= qmi_activate,
+	.query			= qmi_query,
+	.deactivation		= qmi_deactivate,
+	.erasure		= qmi_erase
+};
+
+OFONO_ATOM_DRIVER_BUILTIN(call_forwarding, qmimodem, &driver)
diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index 472d724..12c87be 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -54,6 +54,7 @@ enum voice_commands {
 	QMI_VOICE_GET_CALL_BARRING =		0x35,
 	QMI_VOICE_GET_CLIP =			0x36,
 	QMI_VOICE_GET_CLIR =			0x37,
+	QMI_VOICE_GET_CALL_FWDING = 		0x38,
 	QMI_VOICE_SET_CALL_BARRING_PWD = 	0x39,
 	QMI_VOICE_CANCEL_USSD =			0x3c,
 	QMI_VOICE_USSD_RELEASE_IND =		0x3d,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index a7ef552..e98a07b 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -34,6 +34,7 @@
 #include <ofono/plugin.h>
 #include <ofono/modem.h>
 #include <ofono/call-barring.h>
+#include <ofono/call-forwarding.h>
 #include <ofono/call-settings.h>
 #include <ofono/devinfo.h>
 #include <ofono/netreg.h>
@@ -759,6 +760,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 		ofono_ussd_create(modem, 0, "qmimodem", data->device);
 		ofono_call_settings_create(modem, 0, "qmimodem", data->device);
 		ofono_call_barring_create(modem, 0, "qmimodem", data->device);
+		ofono_call_forwarding_create(modem, 0, "qmimodem",
+						data->device);
 	}
 }
 
-- 
1.9.1

