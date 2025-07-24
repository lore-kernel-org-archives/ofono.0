Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294821FC3
	for <ofono@lists.linux.dev>; Thu, 24 Jul 2025 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753335195; cv=none; b=SZXdyDRi4OYu2kGQh8kVSHs/CjUnQHT10ln+mMl7xIAHfXUNv/EGJ1R9RxnL7ft+6/bg8Q/d0a/GF/Zp0fKlf6q0D+d7vfMVqGEFa164NqtaJhMzc49PnoSkQxK1wDBsJ4Kxy0uWgCxeY5PbdOQNFNScoMctexnJbX18MWeImaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753335195; c=relaxed/simple;
	bh=jmBcPGMXUHJmlbScufSvSYuL9z/QGc5HDRdk/GnXQeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PuA93pTBRoi0vvKEZpViIKpMx6hwpix6R5DAHePqhzgxaNzhDufg3EPaQ5crRO03rfXD5cMehbZMUffzFUbiX47cISfWUjVxrRmKEnX7rbTnfZtp8iNC0zL3XA784ApmEF2jfDECqdaRBG6jDgk7Eti3J1UU2iNZ32QRMr9XVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2U9jz7+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2U9jz7+"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-612b67dcb89so1076133a12.1
        for <ofono@lists.linux.dev>; Wed, 23 Jul 2025 22:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753335191; x=1753939991; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI+BghCXT0asUHGPotqXM1F+QS9JByW+r1ViAOHbNTU=;
        b=V2U9jz7+5Wfz97tlw7NlCiPErFn7gYVT1pKqOZOUvOxWcOfUa3UsqZHh+VhBOFlWJc
         SWSLFBWBgNO29+5gKrwwJKq8LCwUUj12lvyKHV46KrIarHyGECeNErqNxXYinV4GoXp2
         ZAQ69DVfgzvokOxQm231TeFuuwoAkYCaDfyRE4ahJus4vw3o13RJyIH/oafLJv6or/gj
         TtE2mmDuEBYgxX6dMsxL6Ds/sTPksaaxvX215zmHpi74yoj/aBvotvVGGunfmJipV6ws
         ozcGn5dAeq3M3jJvDCDWq+KfUXG750LlGyRhwCqFkKw3aqVmAA1o469Cls/83Pt2TsYh
         8vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753335191; x=1753939991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZI+BghCXT0asUHGPotqXM1F+QS9JByW+r1ViAOHbNTU=;
        b=FfZMsfTCYizS+5GijlXopmTjwEjna6sEZK4IX6mWCEhLK6FYNCxUxh9EHcbcUPdgQa
         FX0uqkSVAvwqbRflPaXaMpuhUqwtw5cKtzPtwD9RIearOPHlDAwo0Vi5ePZYKQIJBQPz
         lcR/iVXIFIeIx7dp34HA6n7ygu3PxYCxaN5DC6yCli7GU2rxwqBHvsPWFSIsdDUOg8IA
         CawxvXA+hT7PYKAMMhhJbmoC5TI+fFDY5q7rffxXxdnsGwv3AU2P8A4kHad2MjSJ0lGw
         LUfD4d76HZAT/udED50zwdZw+k0G5Eelcgl6NLbFzTQgaaf7jGrUU80w1flabEO7EbJH
         1cDQ==
X-Gm-Message-State: AOJu0YwyKNh0AC6WlnWBGVitYiSIVkzWhR00qvw0PmWr593UwPKNrrI2
	ARVkNBfoKagYaBpkwWaYGZb5S3JcrQDnwPvACnAc8t7d1hocrxVgtsrwssyAvQ==
X-Gm-Gg: ASbGnctv1cTT8ytjff1IOodvYhlvSrn90h4Vh8OV7Uv8R0i1+9POkv/9O6enOY7X86F
	LD9IiMSQWJYWSDDRW6oJsURGHKdy4bhor/CADWzNrLMkOSmtkZsdYnk8GQx64/8C1RVcHlBNsbL
	o8IjQo876zB2apDuyVT0/JdySWgg94op7W/PJtwT++odsRyynSpkBBmMkcIMqiBpE1938t2zAxC
	40GveOilnIN+FJizhhpK8zRW+YPs1/j8DnlBpB3JC26+Cgfc3Qz5/B7dQB+wub+hIF3DOG7/XUl
	G0temyeU/W+n59JYwQIKiBj1nD6VDlFNTOPoPJNhsYOf+QSndn9EsACH8dEggUkq63Uu3cR6J2+
	4LweS2cFPrvwdS1vkbDetp9c44KGYFtwLn4XQ6VsXAdpX
X-Google-Smtp-Source: AGHT+IF6DGIHsT7K/zKVoZD73zkzHKKE8T0EoeDt6AVfuoQZYapyZkeT7sZ7vgxJp7ru5vmnv1J6ig==
X-Received: by 2002:a17:906:c114:b0:ae3:74be:4998 with SMTP id a640c23a62f3a-af2f66c20admr559683566b.11.1753335191128;
        Wed, 23 Jul 2025 22:33:11 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c495dbesm59528766b.3.2025.07.23.22.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 22:33:10 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] plugins: droid: migrate to QMI from AT
Date: Thu, 24 Jul 2025 08:32:51 +0300
Message-Id: <20250724053251.592383-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop GAtChat usage and move to qmimodem
---
 plugins/droid.c  | 487 +++++++++++++++++++++++++++++++++++++++++------
 plugins/udevng.c |  30 ++-
 2 files changed, 450 insertions(+), 67 deletions(-)

diff --git a/plugins/droid.c b/plugins/droid.c
index 1dfae9ee..b77e88d7 100644
--- a/plugins/droid.c
+++ b/plugins/droid.c
@@ -11,12 +11,9 @@
 #include <config.h>
 #endif
 
-#include <stdlib.h>
 #include <errno.h>
-
-#include <glib.h>
-#include <gatchat.h>
-#include <gattty.h>
+#include <fcntl.h>
+#include <unistd.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -27,16 +24,46 @@
 #include <ofono/call-meter.h>
 #include <ofono/call-settings.h>
 #include <ofono/devinfo.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/location-reporting.h>
 #include <ofono/message-waiting.h>
+#include <ofono/netmon.h>
 #include <ofono/netreg.h>
 #include <ofono/phonebook.h>
+#include <ofono/radio-settings.h>
 #include <ofono/sim.h>
+#include <ofono/stk.h>
 #include <ofono/sms.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 
-#include <drivers/atmodem/atutil.h>
-#include <drivers/atmodem/vendor.h>
+#include <drivers/qmimodem/qmi.h>
+#include <drivers/qmimodem/dms.h>
+#include <drivers/qmimodem/wda.h>
+#include <drivers/qmimodem/wms.h>
+#include <drivers/qmimodem/util.h>
+
+struct service_request {
+	struct qmi_service **member;
+	uint32_t service_type;
+};
+
+struct droid_data {
+	struct qmi_qmux_device *qmux;
+	struct qmi_service *dms;
+	struct qmi_service *uim;
+	struct qmi_service *voice;
+	struct qmi_service *pds;
+	struct qmi_service *wms;
+	struct qmi_service *nas;
+	struct qmi_service *wds;
+	struct qmi_service *wds_ip4;
+	struct qmi_service *wds_ip6;
+	unsigned long features;
+	uint8_t oper_mode;
+	struct l_queue *service_requests;
+};
 
 static void droid_debug(const char *str, void *user_data)
 {
@@ -45,119 +72,463 @@ static void droid_debug(const char *str, void *user_data)
 	ofono_info("%s%s", prefix, str);
 }
 
-/* Detect hardware, and initialize if found */
+static void droid_io_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	ofono_debug("%s%s", prefix, str);
+}
+
 static int droid_probe(struct ofono_modem *modem)
 {
-	DBG("");
+	struct droid_data *data;
+
+	DBG("%p", modem);
+
+	data = l_new(struct droid_data, 1);
+	if (!data)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
 
 	return 0;
 }
 
+static void cleanup_services(struct droid_data *data)
+{
+	if (data->service_requests) {
+		l_queue_destroy(data->service_requests, l_free);
+		data->service_requests = NULL;
+	}
+
+	qmi_service_free(data->wds_ip4);
+	data->wds_ip4 = NULL;
+	qmi_service_free(data->wds_ip6);
+	data->wds_ip6 = NULL;
+	qmi_service_free(data->wds);
+	data->wds = NULL;
+	qmi_service_free(data->nas);
+	data->nas = NULL;
+	qmi_service_free(data->wms);
+	data->wms = NULL;
+	qmi_service_free(data->pds);
+	data->pds = NULL;
+	qmi_service_free(data->voice);
+	data->voice = NULL;
+	qmi_service_free(data->uim);
+	data->uim = NULL;
+	qmi_service_free(data->dms);
+	data->dms = NULL;
+}
+
 static void droid_remove(struct ofono_modem *modem)
 {
-	GAtChat *chat = ofono_modem_get_data(modem);
+	struct droid_data *data = ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	cleanup_services(data);
+	ofono_modem_set_data(modem, NULL);
+	qmi_qmux_device_free(data->qmux);
+
+	l_free(data);
+}
+
+static void shutdown_cb(void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct droid_data *data = ofono_modem_get_data(modem);
 
 	DBG("");
 
-	if (chat) {
-		g_at_chat_unref(chat);
-		ofono_modem_set_data(modem, NULL);
+	qmi_qmux_device_free(data->qmux);
+	data->qmux = NULL;
+
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static void shutdown_device(struct ofono_modem *modem)
+{
+	struct droid_data *data = ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	cleanup_services(data);
+
+	qmi_qmux_device_shutdown(data->qmux, shutdown_cb, modem, NULL);
+}
+
+static void power_reset_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL)) {
+		shutdown_device(modem);
+		return;
 	}
+
+	ofono_modem_set_powered(modem, TRUE);
 }
 
-static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
+static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
+	struct droid_data *data = ofono_modem_get_data(modem);
+	struct qmi_param *param;
+	uint8_t mode;
 
 	DBG("");
 
-	if (ok)
+	if (qmi_result_set_error(result, NULL)) {
+		shutdown_device(modem);
+		return;
+	}
+
+	if (!qmi_result_get_uint8(result, QMI_DMS_RESULT_OPER_MODE, &mode)) {
+		shutdown_device(modem);
+		return;
+	}
+
+	data->oper_mode = mode;
+
+	switch (data->oper_mode) {
+	case QMI_DMS_OPER_MODE_ONLINE:
+		param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
+					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
+		if (!param) {
+			shutdown_device(modem);
+			return;
+		}
+
+		if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
+					power_reset_cb, modem, NULL) > 0)
+			return;
+
+		shutdown_device(modem);
+		break;
+	default:
 		ofono_modem_set_powered(modem, TRUE);
+		break;
+	}
 }
 
-/* power up hardware */
-static int droid_enable(struct ofono_modem *modem)
+static void get_caps_cb(struct qmi_result *result, void *user_data)
 {
-	GAtChat *chat;
+	struct ofono_modem *modem = user_data;
+	struct droid_data *data = ofono_modem_get_data(modem);
+	const struct qmi_dms_device_caps *caps;
+	uint16_t len;
+	uint8_t i;
 
 	DBG("");
 
-	chat = at_util_open_device(modem, "Device", droid_debug, "", NULL);
-	ofono_modem_set_data(modem, chat);
+	if (qmi_result_set_error(result, NULL))
+		goto error;
 
-	/* ensure modem is in a known state; verbose on, echo/quiet off */
-	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+	caps = qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, &len);
+	if (!caps)
+		goto error;
 
-	/* power up modem */
-	g_at_chat_send(chat, "AT+CFUN=1", NULL, cfun_set_on_cb, modem, NULL);
+	DBG("service capabilities %d", caps->data_capa);
+	DBG("sim supported %d", caps->sim_supported);
 
-	return 0;
+	for (i = 0; i < caps->radio_if_count; i++)
+		DBG("radio = %d", caps->radio_if[i]);
+
+	if (qmi_service_send(data->dms, QMI_DMS_GET_OPER_MODE, NULL,
+				get_oper_mode_cb, modem, NULL) > 0)
+		return;
+
+error:
+	shutdown_device(modem);
 }
 
-static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_data)
+static void create_service_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
-	GAtChat *chat = ofono_modem_get_data(modem);
+	struct droid_data *data = ofono_modem_get_data(modem);
+	struct service_request *request = NULL;
 
 	DBG("");
 
-	g_at_chat_unref(chat);
-	ofono_modem_set_data(modem, NULL);
+	if (!service)
+		goto error;
+
+	request = l_queue_pop_head(data->service_requests);
+	*request->member = service;
+	l_free(request);
+	request = l_queue_peek_head(data->service_requests);
 
-	if (ok)
-		ofono_modem_set_powered(modem, FALSE);
+	if (!request) {
+		l_queue_destroy(data->service_requests, NULL);
+		data->service_requests = NULL;
+
+		if (qmi_service_send(data->dms, QMI_DMS_GET_CAPS, NULL,
+					get_caps_cb, modem, NULL) <= 0)
+			goto error;
+
+		return;
+	}
+
+	if (qmi_qmux_device_create_client(data->qmux, request->service_type,
+						create_service_cb, modem, NULL))
+		return;
+
+error:
+	shutdown_device(modem);
 }
 
-static int droid_disable(struct ofono_modem *modem)
+static void create_dms_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct droid_data *data = ofono_modem_get_data(modem);
+	struct service_request *request = NULL;
+
+	DBG("");
+
+	if (!service)
+		goto error;
+
+	data->dms = service;
+	request = l_queue_peek_head(data->service_requests);
+
+	if (qmi_qmux_device_create_client(data->qmux, request->service_type,
+						create_service_cb, modem, NULL))
+		return;
+
+error:
+	shutdown_device(modem);
+}
+
+static struct service_request *new_service_request(
+			struct qmi_service **member, uint32_t service_type)
 {
-	GAtChat *chat = ofono_modem_get_data(modem);
+	struct service_request *request = l_new(struct service_request, 1);
+
+	request->member = member;
+	request->service_type = service_type;
+
+	return request;
+}
+
+static void discover_cb(void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct droid_data *data = ofono_modem_get_data(modem);
 
 	DBG("");
 
-	/* power down modem */
-	g_at_chat_cancel_all(chat);
-	g_at_chat_unregister_all(chat);
-	g_at_chat_send(chat, "AT+CFUN=0", NULL, cfun_set_off_cb, modem, NULL);
+	data->service_requests = l_queue_new();
+
+	l_queue_push_tail(data->service_requests,
+			new_service_request(&data->uim, QMI_SERVICE_UIM));
+	l_queue_push_tail(data->service_requests,
+			new_service_request(&data->voice, QMI_SERVICE_VOICE));
+	l_queue_push_tail(data->service_requests,
+			new_service_request(&data->pds, QMI_SERVICE_PDS));
+	l_queue_push_tail(data->service_requests,
+			new_service_request(&data->wms, QMI_SERVICE_WMS));
+	l_queue_push_tail(data->service_requests,
+			new_service_request(&data->nas, QMI_SERVICE_NAS));
+	l_queue_push_tail(data->service_requests,
+			new_service_request(&data->wds, QMI_SERVICE_WDS));
+	l_queue_push_tail(data->service_requests,
+			new_service_request(&data->wds_ip4, QMI_SERVICE_WDS));
+	l_queue_push_tail(data->service_requests,
+			new_service_request(&data->wds_ip6, QMI_SERVICE_WDS));
+
+	if (qmi_qmux_device_create_client(data->qmux, QMI_SERVICE_DMS,
+					create_dms_cb, modem, NULL))
+		return;
+
+	shutdown_device(modem);
+}
+
+static int droid_enable(struct ofono_modem *modem)
+{
+	struct droid_data *data = ofono_modem_get_data(modem);
+	const char *device;
+
+	DBG("%p", modem);
+
+	device = ofono_modem_get_string(modem, "Device");
+	if (!device)
+		return -EINVAL;
+
+	data->qmux = qmi_qmux_device_new(device, NULL);
+	if (!data->qmux)
+		return -ENOMEM;
+
+	if (getenv("OFONO_QMI_DEBUG"))
+		qmi_qmux_device_set_debug(data->qmux, droid_debug, "QMI: ");
+
+	if (getenv("OFONO_QMI_IO_DEBUG"))
+		qmi_qmux_device_set_io_debug(data->qmux,
+						droid_io_debug, "QMI: ");
+
+	qmi_qmux_device_discover(data->qmux, discover_cb, modem, NULL);
 
 	return -EINPROGRESS;
 }
 
-static void droid_pre_sim(struct ofono_modem *modem)
+static void power_disable_cb(struct qmi_result *result, void *user_data)
 {
-	GAtChat *chat = ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
+	struct ofono_modem *modem = user_data;
 
 	DBG("");
 
-	ofono_devinfo_create(modem, 0, "atmodem", chat);
-	sim = ofono_sim_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
-	ofono_voicecall_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
+	shutdown_device(modem);
+}
+
+static int droid_disable(struct ofono_modem *modem)
+{
+	struct droid_data *data = ofono_modem_get_data(modem);
+	struct qmi_param *param;
+
+	DBG("%p", modem);
+
+	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
+				QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
+	if (!param)
+		return -ENOMEM;
+
+	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
+				power_disable_cb, modem, NULL) > 0)
+		return -EINPROGRESS;
 
-	if (sim)
-		ofono_sim_inserted_notify(sim, TRUE);
+	shutdown_device(modem);
+
+	return -EINPROGRESS;
+}
+
+static void set_online_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_modem_online_cb_t cb = cbd->cb;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	else
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void droid_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct droid_data *data = ofono_modem_get_data(modem);
+	struct cb_data *cbd = cb_data_new(cb, user_data);
+	struct qmi_param *param;
+	uint8_t mode;
+
+	DBG("%p %s", modem, online ? "online" : "offline");
+
+	if (online)
+		mode = QMI_DMS_OPER_MODE_ONLINE;
+	else
+		mode = QMI_DMS_OPER_MODE_LOW_POWER;
+
+	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE, mode);
+	if (!param)
+		goto error;
+
+	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
+				set_online_cb, cbd, l_free) > 0)
+		return;
+
+	qmi_param_free(param);
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	l_free(cbd);
+}
+
+/* Only some QMI features are usable, voicecall and sms are custom */
+static void droid_pre_sim(struct ofono_modem *modem)
+{
+	struct droid_data *data = ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "qmimodem",
+				qmi_service_clone(data->dms));
+	ofono_sim_create(modem, 0, "qmimodem",
+				qmi_service_clone(data->dms),
+				qmi_service_clone(data->uim));
+	ofono_voicecall_create(modem, 0, "qmimodem",
+				qmi_service_clone(data->voice));
+	ofono_location_reporting_create(modem, 0, "qmimodem",
+					l_steal_ptr(data->pds));
 }
 
 static void droid_post_sim(struct ofono_modem *modem)
 {
-	GAtChat *chat = ofono_modem_get_data(modem);
+	struct droid_data *data = ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+	const char *interface;
 
-	DBG("");
+	DBG("%p", modem);
+
+/*	ofono_phonebook_create(modem, 0, "qmimodem", data->qmux);*/
+	ofono_radio_settings_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->dms),
+					qmi_service_clone(data->nas));
 
-	ofono_ussd_create(modem, 0, "atmodem", chat);
-	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
-	ofono_call_settings_create(modem, 0, "atmodem", chat);
-	ofono_netreg_create(modem, 0, "atmodem", chat);
-	/*
-	 * Droid 4 modem has problems with AT+CPUC?, avoid call meter for now.
-	 */
-	ofono_call_barring_create(modem, 0, "atmodem", chat);
-	ofono_sms_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
-	ofono_phonebook_create(modem, 0, "atmodem", chat);
+	ofono_sms_create(modem, 0, "qmimodem",
+				qmi_service_clone(data->wms));
 
 	mw = ofono_message_waiting_create(modem);
 	if (mw)
 		ofono_message_waiting_register(mw);
+
+	gprs = ofono_gprs_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->wds),
+					qmi_service_clone(data->nas));
+	if (!gprs) {
+		ofono_warn("Unable to create gprs for: %s",
+				ofono_modem_get_path(modem));
+		return;
+	}
+
+	gc = ofono_gprs_context_create(modem, 0, "qmimodem", -1,
+					qmi_service_clone(data->wds_ip4),
+					qmi_service_clone(data->wds_ip6));
+	if (!gc) {
+		ofono_warn("Unable to create gprs-context for: %s",
+				ofono_modem_get_path(modem));
+		return;
+	}
+
+	ofono_gprs_add_context(gprs, gc);
+	interface = ofono_modem_get_string(modem, "NetworkInterface");
+	ofono_gprs_context_set_interface(gc, interface);
+}
+
+static void droid_post_online(struct ofono_modem *modem)
+{
+	struct droid_data *data = ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->nas));
+	ofono_netmon_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->nas));
+
+	ofono_ussd_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->voice));
+	ofono_call_settings_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->voice));
+	ofono_call_barring_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->voice));
+	ofono_call_forwarding_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->voice));
 }
 
 static struct ofono_modem_driver droid_driver = {
@@ -165,8 +536,10 @@ static struct ofono_modem_driver droid_driver = {
 	.remove		= droid_remove,
 	.enable		= droid_enable,
 	.disable	= droid_disable,
+	.set_online	= droid_set_online,
 	.pre_sim	= droid_pre_sim,
 	.post_sim	= droid_post_sim,
+	.post_online	= droid_post_online,
 };
 
 OFONO_MODEM_DRIVER_BUILTIN(droid, &droid_driver)
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 320cd3a6..7777996d 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -870,7 +870,9 @@ static gboolean setup_telitqmi(struct modem_info *modem)
 
 static gboolean setup_droid(struct modem_info *modem)
 {
-	const char *at = NULL;
+	const struct device_info *qmi = NULL;
+	const struct device_info *net = NULL;
+
 	GSList *list;
 
 	DBG("%s", modem->syspath);
@@ -878,21 +880,29 @@ static gboolean setup_droid(struct modem_info *modem)
 	for (list = modem->devices; list; list = list->next) {
 		struct device_info *info = list->data;
 		const char *subsystem =
-			udev_device_get_subsystem(info->udev_device);
-
-		DBG("%s %s %s %s %s", info->devnode, info->interface,
-				info->number, info->label, subsystem);
+				udev_device_get_subsystem(info->udev_device);
+		DBG("%s %s %s %s %s %s", info->devnode, info->interface,
+						info->number, info->label,
+						info->sysattr, subsystem);
 
-		if (g_strcmp0(info->interface, "255/255/255") == 0 &&
-				g_strcmp0(info->number, "04") == 0) {
-			at = info->devnode;
+		if (g_strcmp0(subsystem, "usbmisc") == 0) {
+			if (g_strcmp0(info->number, "05") == 0)
+				qmi = info;
+		} else if (g_strcmp0(subsystem, "net") == 0) {
+			if (g_strcmp0(info->number, "05") == 0)
+				net = info;
 		}
 	}
 
-	if (at == NULL)
+	if (qmi == NULL || net == NULL)
+		return FALSE;
+
+	DBG("qmi=%s net=%s", qmi->devnode, get_ifname(net));
+
+
+	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
 
-	ofono_modem_set_string(modem->modem, "Device", at);
 	ofono_modem_set_driver(modem->modem, "droid");
 
 	return TRUE;
-- 
2.25.1

