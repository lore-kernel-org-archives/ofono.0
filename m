Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C633C5
	for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707981492; cv=none; b=U0vE+P7VsKwzY+LHHhgsVRrJaE5Tp1GnSQBMQH9J5UWr4RcdIKVyPCQ52MgnjZNSibUBQ2qND/pS36zsHqHjfsmBfd90WJPPl9m5ut1/hZyw7vleASIWUr7moxUU2XwqQbjvvF8X3rfJSOqoBkfBqy8WwPHHS/wkBTdiLXU3BOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707981492; c=relaxed/simple;
	bh=8NARh7sk5RcmauTqHDOXQmnn3mPWGKzQHGrFsITFRrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EGJG6PLJM4YB5vSg3OtsBnyP7LhcslVFRQ97R/Dme5Hffn+7n4l0Wz0yA5LNtguvjT8sWvvUbQB3VGy6KABgdfYTDtnYPvxCkVimNbeSMLruLxDmxKSbzjZbJjtxvpVjyDqVD6lzfmXAyNKEY8at0Xtz6TJMYVUWM8ZdrQK61/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBtimbdB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBtimbdB"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so684690a12.1
        for <ofono@lists.linux.dev>; Wed, 14 Feb 2024 23:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707981489; x=1708586289; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QxqGeUPcOZljKrUsEY8LRPyDDnN0zBJmTLLoI0x9rMc=;
        b=MBtimbdBJzzRO3hJiD8m670UdnYnojYINVOSupPwBmO70J80pXO9vcV4/IAx6yYXqX
         0hcxxvA5onhj5QK5JbjgTFLz6f5N7pCA6ZGxHLv3yjE9GSPMcj7r+BFCLHrT9MGh+aKU
         KlUbzgViorK6Qh6sXrOKWc9dYWP6xtrD4YW1cjzI2rwQmC9kuEEUojheNHLyVckYbyEU
         WfPmcfTDeUfdN3GcnN6w0ePlRLQJRk3jhNIthhn+fNuwGRk97wZqffvz+dPmD+a30aBU
         hLJkf09rfDX1khDZ2xeCFOy3HPwl8splj5tgL0O1KMqIbMNLEuRTMpgFEg67OmNK+uGe
         wq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707981489; x=1708586289;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxqGeUPcOZljKrUsEY8LRPyDDnN0zBJmTLLoI0x9rMc=;
        b=Lsu1cj9pZwhdiBqr/rbkxaB74zBTuCLV4uXfOr5mioxEdzsGdHuG7oIgXwzBROTItP
         R3bF1kfDPMrcMZAUTjvwCCifKRjjUMA008lz//HTuRBGGTWZ6BXO5svJdsrtFV4fzzWf
         i7YJ/i9B3AIagT18IO1buOzm52h2bNJXbiZXtWiWP9GE73M+/yz8eAbkD2e+OMMYs3zp
         3GFhpTp4D0kOh70foeBSKXOP0CBY1wuDh/Tgd9qxcn+7KnfXqFyMxsvj7DWlpTxhA0Wg
         W8v+rb/wWUhNLnW7LgM5L7PpvdB352YqSDLkU4lpK0wjW6pEIrBc9tWGRlazGeJOA7q9
         Ulqg==
X-Gm-Message-State: AOJu0Yw4kIV2juBsTU1x3HNr+B+aNmhxL5pjdRsJrjzxnxslMO1GjhIJ
	uF1PsrkbZwYSEX6WvmTBldOCNF0mOFaFA+GWPHhMYfowYAzEZXXNqFdA5RYm
X-Google-Smtp-Source: AGHT+IGSk+BrpwhkD1Q9iw5+ORi0vGnu+LnXXECGlXx5CyEEhs5k7+vYukkaXNXVL3IxAzj6LOacuA==
X-Received: by 2002:aa7:d38e:0:b0:562:f25:b125 with SMTP id x14-20020aa7d38e000000b005620f25b125mr647971edq.36.1707981488705;
        Wed, 14 Feb 2024 23:18:08 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id v28-20020a50955c000000b0056003b75400sm293671eda.44.2024.02.14.23.18.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2024 23:18:08 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/2] qmimodem: implement call-barring driver
Date: Thu, 15 Feb 2024 09:17:46 +0200
Message-Id: <1707981467-2955-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1707981467-2955-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1707981467-2955-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 Makefile.am                     |   3 +-
 drivers/qmimodem/call-barring.c | 264 ++++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/qmi.c          |   1 +
 drivers/qmimodem/voice.h        |   2 +
 plugins/gobi.c                  |   2 +
 5 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 drivers/qmimodem/call-barring.c

diff --git a/Makefile.am b/Makefile.am
index d8766e0..98f41e0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -387,7 +387,8 @@ builtin_sources += $(qmi_sources) \
 			drivers/qmimodem/radio-settings.c \
 			drivers/qmimodem/location-reporting.c \
 			drivers/qmimodem/netmon.c \
-			drivers/qmimodem/call-settings.c
+			drivers/qmimodem/call-settings.c \
+			drivers/qmimodem/call-barring.c
 
 builtin_modules += gobi
 builtin_sources += plugins/gobi.c
diff --git a/drivers/qmimodem/call-barring.c b/drivers/qmimodem/call-barring.c
new file mode 100644
index 0000000..dc84026
--- /dev/null
+++ b/drivers/qmimodem/call-barring.c
@@ -0,0 +1,264 @@
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
+#include <ofono/call-barring.h>
+
+#include "qmi.h"
+#include "voice.h"
+#include "util.h"
+
+struct call_barring_data {
+	struct qmi_service *voice;
+};
+
+static uint8_t lock_code_to_reason(const char *lock)
+{
+	if (!strcmp(lock, "AO"))
+		return QMI_VOICE_SS_RSN_ALL_OUTGOING;
+	else if (!strcmp(lock, "OI"))
+		return QMI_VOICE_SS_RSN_OUT_INT;
+	else if (!strcmp(lock, "OX"))
+		return QMI_VOICE_SS_RSN_OUT_INT_EXT_TO_HOME;
+	else if (!strcmp(lock, "AI"))
+		return QMI_VOICE_SS_RSN_ALL_IN;
+	else if (!strcmp(lock, "IR"))
+		return QMI_VOICE_SS_RSN_IN_ROAMING;
+	else if (!strcmp(lock, "AB"))
+		return QMI_VOICE_SS_RSN_BAR_ALL;
+	else if (!strcmp(lock, "AG"))
+		return QMI_VOICE_SS_RSN_BAR_ALL_OUTGOING;
+	else if (!strcmp(lock, "AC"))
+		return QMI_VOICE_SS_RSN_BAR_ALL_IN;
+	else {
+		DBG("Unknown lock code %s", lock);
+		return 0;
+	}
+}
+
+static void set_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_call_barring_set_cb_t cb = cbd->cb;
+	uint16_t error;
+
+	DBG("");
+
+	if (!qmi_result_set_error(result, &error))
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else {
+		/* Check for invalid password error */
+		if (error != 92 ||
+				!qmi_result_get_uint16(result, 0x10, &error) ||
+				error != 129)
+			CALLBACK_WITH_FAILURE(cb, cbd->data);
+		else
+			CALLBACK_WITH_CME_ERROR(cb, 16, cbd->data);
+	}
+}
+
+static void qmi_set(struct ofono_call_barring *barr, const char *lock,
+			int enable, const char *passwd, int cls,
+			ofono_call_barring_set_cb_t cb, void *data)
+{
+	struct call_barring_data *bd = ofono_call_barring_get_data(barr);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param;
+	struct __attribute__((__packed__)) {
+		uint8_t service;
+		uint8_t reason;
+	} ssd;
+
+	DBG("");
+
+	ssd.reason = lock_code_to_reason(lock);
+
+	if (!bd || !ssd.reason)
+		goto error;
+
+	ssd.service = enable ? QMI_VOICE_SS_ACTION_ACTIVATE :
+				QMI_VOICE_SS_ACTION_DEACTIVATE;
+
+	param = qmi_param_new();
+	qmi_param_append(param, 0x01, sizeof(ssd), &ssd);
+
+	if (cls != 7 /* BEARER_CLASS_DEFAULT */)
+		qmi_param_append_uint8(param, 0x10, cls);
+
+	qmi_param_append(param, 0x11, 4, passwd);
+
+	if (qmi_service_send(bd->voice, QMI_VOICE_SET_SUPS_SERVICE, param,
+				set_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void query_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_call_barring_query_cb_t cb = cbd->cb;
+	uint8_t mask;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL) ||
+			!qmi_result_get_uint8(result, 0x10, &mask)) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+}
+
+static void qmi_query(struct ofono_call_barring *barr, const char *lock,
+			int cls, ofono_call_barring_query_cb_t cb, void *data)
+{
+	struct call_barring_data *bd = ofono_call_barring_get_data(barr);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param;
+	uint8_t reason = lock_code_to_reason(lock);
+
+	DBG("");
+
+	if (!bd || !reason)
+		goto error;
+
+	param = qmi_param_new();
+	qmi_param_append_uint8(param, 0x01, reason);
+
+	if (cls != 7 /* BEARER_CLASS_DEFAULT */)
+		qmi_param_append_uint8(param, 0x10, cls);
+
+	if (qmi_service_send(bd->voice, QMI_VOICE_GET_CALL_BARRING, param,
+				query_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void qmi_set_passwd(struct ofono_call_barring *barr, const char *lock,
+				const char *old_passwd, const char *new_passwd,
+				ofono_call_barring_set_cb_t cb, void *data)
+{
+	struct call_barring_data *bd = ofono_call_barring_get_data(barr);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param;
+	struct __attribute__((__packed__)) {
+		uint8_t reason;
+		uint8_t old_passwd[4];
+		uint8_t new_passwd[4];
+		uint8_t new_passwd_rpt[4];
+	} ssd;
+
+	DBG("");
+
+	if (!bd)
+		goto error;
+
+	ssd.reason = lock_code_to_reason(lock);
+	memcpy(&ssd.old_passwd, old_passwd, 4);
+	memcpy(&ssd.new_passwd, new_passwd, 4);
+	memcpy(&ssd.new_passwd_rpt, new_passwd, 4);
+
+	param = qmi_param_new();
+
+	qmi_param_append(param, 0x01, sizeof(ssd), &ssd);
+
+	if (qmi_service_send(bd->voice, QMI_VOICE_SET_CALL_BARRING_PWD, param,
+				set_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void create_voice_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_call_barring *barr = user_data;
+	struct call_barring_data *bd = ofono_call_barring_get_data(barr);
+
+	DBG("");
+
+	if (!service) {
+		ofono_error("Failed to request Voice service");
+		ofono_call_barring_remove(barr);
+		return;
+	}
+
+	bd->voice = qmi_service_ref(service);
+
+	ofono_call_barring_register(barr);
+}
+
+static int qmi_call_barring_probe(struct ofono_call_barring *barr,
+					unsigned int vendor, void *user_data)
+{
+	struct qmi_device *device = user_data;
+	struct call_barring_data *bd;
+
+	DBG("");
+
+	bd = g_new0(struct call_barring_data, 1);
+
+	ofono_call_barring_set_data(barr, bd);
+
+	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
+					create_voice_cb, barr, NULL);
+
+	return 0;
+}
+
+static void qmi_call_barring_remove(struct ofono_call_barring *barr)
+{
+	struct call_barring_data *bd = ofono_call_barring_get_data(barr);
+
+	DBG("");
+
+	ofono_call_barring_set_data(barr, NULL);
+
+	if (bd->voice)
+		qmi_service_unref(bd->voice);
+
+	g_free(bd);
+}
+
+static const struct ofono_call_barring_driver driver = {
+	.probe			= qmi_call_barring_probe,
+	.remove			= qmi_call_barring_remove,
+	.set			= qmi_set,
+	.query			= qmi_query,
+	.set_passwd		= qmi_set_passwd
+};
+
+OFONO_ATOM_DRIVER_BUILTIN(call_barring, qmimodem, &driver)
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index fe663ec..7f0d605 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -466,6 +466,7 @@ static const struct {
 	{ 0x0053, "HARDWARE_RESTRICTED"		},
 	{ 0x0054, "ACK_NOT_SENT"		},
 	{ 0x0055, "INJECT_TIMEOUT"		},
+	{ 0x005c, "SUPS_FAILURE_CAUSE"		},
 	{ }
 };
 
diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
index 7755d2e..472d724 100644
--- a/drivers/qmimodem/voice.h
+++ b/drivers/qmimodem/voice.h
@@ -51,8 +51,10 @@ enum voice_commands {
 	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
 	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
 	QMI_VOICE_GET_CALL_WAITING =		0x34,
+	QMI_VOICE_GET_CALL_BARRING =		0x35,
 	QMI_VOICE_GET_CLIP =			0x36,
 	QMI_VOICE_GET_CLIR =			0x37,
+	QMI_VOICE_SET_CALL_BARRING_PWD = 	0x39,
 	QMI_VOICE_CANCEL_USSD =			0x3c,
 	QMI_VOICE_USSD_RELEASE_IND =		0x3d,
 	QMI_VOICE_USSD_IND =			0x3e,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index a550016..a7ef552 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -33,6 +33,7 @@
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
 #include <ofono/modem.h>
+#include <ofono/call-barring.h>
 #include <ofono/call-settings.h>
 #include <ofono/devinfo.h>
 #include <ofono/netreg.h>
@@ -757,6 +758,7 @@ static void gobi_post_online(struct ofono_modem *modem)
 	if (data->features & GOBI_VOICE) {
 		ofono_ussd_create(modem, 0, "qmimodem", data->device);
 		ofono_call_settings_create(modem, 0, "qmimodem", data->device);
+		ofono_call_barring_create(modem, 0, "qmimodem", data->device);
 	}
 }
 
-- 
1.9.1

