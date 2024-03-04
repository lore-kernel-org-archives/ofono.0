Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7CDF5A
	for <ofono@lists.linux.dev>; Mon,  4 Mar 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584514; cv=none; b=kgnV5Tkxxu/gC8xYBfSF2hfZZTt54VEr9iwfpWGWo+OOMFw2cm0929eOHBs9u8no3WZP2WQPN8Uw9G+gLdvmFuh6aumz9cr7faurNCDldF3qmQ8uULFesSzjoXVXncicyjFvu99ZszYCbYlwi3L75dXVZeVzI2sIFb31rHp6pZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584514; c=relaxed/simple;
	bh=cm/TnaIVQzXSZVSzZ7Y2Fg7HTpWUkYy9RwpeSBvQAHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtRITKasWQqpvfBBxD6jWH8vWb+vbp1RGwvrpq1MlvFjdLleMaCb4pT9aa8mgQvODSTPL8M/vJzIEr+sJaUXb1Gt7HX+Q9bzalD9UdOtdjWqhJCgiaUNRI/p+k5O3SExSMw1ifv+JkJhDWBxHv7A/0BR3MRv0bRdYgRyZAEmiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0Qi25MJ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0Qi25MJ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1a3384741so3565354b6e.0
        for <ofono@lists.linux.dev>; Mon, 04 Mar 2024 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709584510; x=1710189310; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UahHhUaWvUGUKPgOD/0XKCM7ZE40FT2q1XKj7QIsDac=;
        b=S0Qi25MJigJ/BO3vSp32S48FKz7M0r9sqKWesjP8XUPPXk6wWHosSEUmUTHDP08lb2
         a2RtPg0VZtbv/8HPr2PUkery/fj61otv3TIqLBHuk6YVyU9G2juc04GOX7ONwJZ6IPk0
         qQGOhU+BjGtxGpJQzyW2xpqwddDj+JsYLHkRqJRWRkANsW0rN6O79FDV9m+doImPgCdG
         xJvCJcpSyfDaDZHlKLM9SuAn5vmTsUCbyM5YI4gh3HFen8eNtUAzzBsidj1f5YAZbInd
         upeGV5DBQf0rW+3PjY1gnd8czPMmJ6C2yCii/btqK//CN/FqYGbL8cnw2ATOlPzqtUAg
         rBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584510; x=1710189310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UahHhUaWvUGUKPgOD/0XKCM7ZE40FT2q1XKj7QIsDac=;
        b=hj+yJmFMucb2Zxo3Lm2s9YI+5wKbwAoQl1fJ92c4QRAeQdH7mXu0bgslyk3p4XyApX
         LXjlxUdWE74/HQAW3gVg4dPXT0lzC2XnLSBKX+2a/F1DLqO7TeB5oLYNfKRXCBjzAqbC
         7TFLx7ixPF4eZTSs0bZ+KbQHtea7qLIoekxLP4IuMQ+TiwzqPsMNBOwyL6lUPbnbp/66
         GQ7xY3BR6Tl8Gke+mb2vear2c1RoA8Ha+EyFRvAIz+krVzrwmK8YG+WkG7BhDmzA8FNZ
         Jkky0zgcltH2eYHNrty8aar66l3U4Ezmpnvh/MHC0smBSviqdBSUNE0C5L6fjUvu+Vct
         AvZw==
X-Gm-Message-State: AOJu0YwpObJr9Ehza6xyudjdu9s8/SZry+p4pkElX7cutBVRRHwn47MP
	ooqbKrdhuM5BCX+0yAOmTeN374x3v4s+lgTC7jlS9F6UR/ZGqIiTQpv4+co1
X-Google-Smtp-Source: AGHT+IEHEDM0EQPvB9wHoqwAhJKPljcALq/K8b39c9AQE1dIsTvVlr4EeM3d41YuZTh1POEW7R91PA==
X-Received: by 2002:a05:6808:88:b0:3c1:f3ce:5e54 with SMTP id s8-20020a056808008800b003c1f3ce5e54mr2284492oic.23.1709584509728;
        Mon, 04 Mar 2024 12:35:09 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 1-20020aca2101000000b003c0408e5b06sm1642582oiz.55.2024.03.04.12.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:35:09 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/5] qmimodem: Use l_new / l_free
Date: Mon,  4 Mar 2024 14:34:51 -0600
Message-ID: <20240304203506.1725220-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304203506.1725220-1-denkenz@gmail.com>
References: <20240304203506.1725220-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert from using GLib g_new0 / g_free to use ell
---
 drivers/qmimodem/call-barring.c         | 16 +++++------
 drivers/qmimodem/call-forwarding.c      | 22 +++++++-------
 drivers/qmimodem/call-settings.c        | 16 +++++------
 drivers/qmimodem/devinfo.c              | 20 ++++++-------
 drivers/qmimodem/gprs-context.c         | 22 +++++++-------
 drivers/qmimodem/gprs.c                 | 14 ++++-----
 drivers/qmimodem/location-reporting.c   | 12 ++++----
 drivers/qmimodem/lte.c                  | 10 +++----
 drivers/qmimodem/netmon.c               | 10 +++----
 drivers/qmimodem/network-registration.c | 38 ++++++++++---------------
 drivers/qmimodem/radio-settings.c       | 14 ++++-----
 drivers/qmimodem/sim-legacy.c           | 16 +++++------
 drivers/qmimodem/sim.c                  | 36 +++++++++++------------
 drivers/qmimodem/sms.c                  | 33 ++++++++++-----------
 drivers/qmimodem/ussd.c                 | 10 +++----
 drivers/qmimodem/util.h                 |  5 ++--
 drivers/qmimodem/voicecall.c            |  4 +--
 17 files changed, 141 insertions(+), 157 deletions(-)

diff --git a/drivers/qmimodem/call-barring.c b/drivers/qmimodem/call-barring.c
index dc84026a638b..6224893871a0 100644
--- a/drivers/qmimodem/call-barring.c
+++ b/drivers/qmimodem/call-barring.c
@@ -110,12 +110,12 @@ static void qmi_set(struct ofono_call_barring *barr, const char *lock,
 	qmi_param_append(param, 0x11, 4, passwd);
 
 	if (qmi_service_send(bd->voice, QMI_VOICE_SET_SUPS_SERVICE, param,
-				set_cb, cbd, g_free) > 0)
+				set_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 
@@ -156,12 +156,12 @@ static void qmi_query(struct ofono_call_barring *barr, const char *lock,
 		qmi_param_append_uint8(param, 0x10, cls);
 
 	if (qmi_service_send(bd->voice, QMI_VOICE_GET_CALL_BARRING, param,
-				query_cb, cbd, g_free) > 0)
+				query_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 
@@ -194,12 +194,12 @@ static void qmi_set_passwd(struct ofono_call_barring *barr, const char *lock,
 	qmi_param_append(param, 0x01, sizeof(ssd), &ssd);
 
 	if (qmi_service_send(bd->voice, QMI_VOICE_SET_CALL_BARRING_PWD, param,
-				set_cb, cbd, g_free) > 0)
+				set_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 
@@ -229,7 +229,7 @@ static int qmi_call_barring_probe(struct ofono_call_barring *barr,
 
 	DBG("");
 
-	bd = g_new0(struct call_barring_data, 1);
+	bd = l_new(struct call_barring_data, 1);
 
 	ofono_call_barring_set_data(barr, bd);
 
@@ -250,7 +250,7 @@ static void qmi_call_barring_remove(struct ofono_call_barring *barr)
 	if (bd->voice)
 		qmi_service_unref(bd->voice);
 
-	g_free(bd);
+	l_free(bd);
 }
 
 static const struct ofono_call_barring_driver driver = {
diff --git a/drivers/qmimodem/call-forwarding.c b/drivers/qmimodem/call-forwarding.c
index 5972055feb74..2a415b2a9c11 100644
--- a/drivers/qmimodem/call-forwarding.c
+++ b/drivers/qmimodem/call-forwarding.c
@@ -110,7 +110,7 @@ static void query_cb(struct qmi_result *result, void *user_data)
 
 		num = *p++;
 
-		list = g_new0(struct ofono_call_forwarding_condition, num);
+		list = l_new(struct ofono_call_forwarding_condition, num);
 
 		for (i = 0; i < num; i++) {
 			struct call_forwarding_info_ext *info = (void *)p;
@@ -119,7 +119,7 @@ static void query_cb(struct qmi_result *result, void *user_data)
 			/* do not try to access beyond buffer end */
 			if (p + sizeof(*info) > end ||
 					p + sizeof(*info) + info->len > end) {
-				g_free(list);
+				l_free(list);
 				goto error;
 			}
 
@@ -135,7 +135,7 @@ static void query_cb(struct qmi_result *result, void *user_data)
 		}
 
 		CALLBACK_WITH_SUCCESS(cb, num, list, cbd->data);
-		g_free(list);
+		l_free(list);
 		return;
 	}
 
@@ -163,12 +163,12 @@ static void qmi_query(struct ofono_call_forwarding *cf, int type, int cls,
 		qmi_param_append_uint8(param, 0x10, cls);
 
 	if (qmi_service_send(cfd->voice, QMI_VOICE_GET_CALL_FWDING, param,
-				query_cb, cbd, g_free) > 0)
+				query_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, 0, NULL, data);
 }
 
@@ -224,12 +224,12 @@ static void qmi_register(struct ofono_call_forwarding *cf, int type, int cls,
 	qmi_param_append(param, 0x14, sizeof(tpd), &tpd);
 
 	if (qmi_service_send(cfd->voice, QMI_VOICE_SET_SUPS_SERVICE, param,
-				set_cb, cbd, g_free) > 0)
+				set_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 
@@ -261,13 +261,13 @@ static void qmi_set(struct ofono_call_forwarding *cf, int type, int cls,
 		qmi_param_append_uint8(param, 0x10, cls);
 
 	if (qmi_service_send(cfd->voice, QMI_VOICE_SET_SUPS_SERVICE, param,
-				set_cb, cbd, g_free) > 0)
+				set_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 
@@ -315,7 +315,7 @@ static int qmi_call_forwarding_probe(struct ofono_call_forwarding *cf,
 
 	DBG("");
 
-	cfd = g_new0(struct call_forwarding_data, 1);
+	cfd = l_new(struct call_forwarding_data, 1);
 
 	ofono_call_forwarding_set_data(cf, cfd);
 
@@ -336,7 +336,7 @@ static void qmi_call_forwarding_remove(struct ofono_call_forwarding *cf)
 	if (cfd->voice)
 		qmi_service_unref(cfd->voice);
 
-	g_free(cfd);
+	l_free(cfd);
 }
 
 static const struct ofono_call_forwarding_driver driver = {
diff --git a/drivers/qmimodem/call-settings.c b/drivers/qmimodem/call-settings.c
index 07b9d543be37..53b2f1f21fc9 100644
--- a/drivers/qmimodem/call-settings.c
+++ b/drivers/qmimodem/call-settings.c
@@ -49,10 +49,10 @@ static void query_status(struct ofono_call_settings *cs, uint16_t message,
 	if (!csd)
 		goto error;
 
-	if (qmi_service_send(csd->voice, message, NULL, fn, cbd, g_free) > 0)
+	if (qmi_service_send(csd->voice, message, NULL, fn, cbd, l_free) > 0)
 		return;
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 
@@ -171,10 +171,10 @@ static void qmi_clir_query(struct ofono_call_settings *cs,
 		goto error;
 
 	if (qmi_service_send(csd->voice, QMI_VOICE_GET_CLIR, NULL,
-						clir_cb, cbd, g_free) > 0)
+						clir_cb, cbd, l_free) > 0)
 		return;
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, -1, -1, data);
 }
 
@@ -221,12 +221,12 @@ static void qmi_cw_set(struct ofono_call_settings *cs, int mode, int cls,
 		qmi_param_append_uint8(param, 0x10, cls);
 
 	if (qmi_service_send(csd->voice, QMI_VOICE_SET_SUPS_SERVICE, param,
-				cw_set_cb, cbd, g_free) > 0)
+				cw_set_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 
@@ -304,7 +304,7 @@ static int qmi_call_settings_probe(struct ofono_call_settings *cs,
 
 	DBG("");
 
-	csd = g_new0(struct call_settings_data, 1);
+	csd = l_new(struct call_settings_data, 1);
 
 	ofono_call_settings_set_data(cs, csd);
 
@@ -327,7 +327,7 @@ static void qmi_call_settings_remove(struct ofono_call_settings *cs)
 		qmi_service_unref(csd->voice);
 	}
 
-	g_free(csd);
+	l_free(csd);
 }
 
 static const struct ofono_call_settings_driver driver = {
diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index 96224d3db361..0172614b8aae 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -71,12 +71,12 @@ static void qmi_query_manufacturer(struct ofono_devinfo *devinfo,
 	DBG("");
 
 	if (qmi_service_send(data->dms, QMI_DMS_GET_MANUFACTURER, NULL,
-						string_cb, cbd, g_free) > 0)
+						string_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void qmi_query_model(struct ofono_devinfo *devinfo,
@@ -88,12 +88,12 @@ static void qmi_query_model(struct ofono_devinfo *devinfo,
 	DBG("");
 
 	if (qmi_service_send(data->dms, QMI_DMS_GET_MODEL_ID, NULL,
-					string_cb, cbd, g_free) > 0)
+					string_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void qmi_query_revision(struct ofono_devinfo *devinfo,
@@ -105,12 +105,12 @@ static void qmi_query_revision(struct ofono_devinfo *devinfo,
 	DBG("");
 
 	if (qmi_service_send(data->dms, QMI_DMS_GET_REV_ID, NULL,
-					string_cb, cbd, g_free) > 0)
+					string_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void get_ids_cb(struct qmi_result *result, void *user_data)
@@ -166,12 +166,12 @@ static void qmi_query_serial(struct ofono_devinfo *devinfo,
 	cbd->user = devinfo;
 
 	if (qmi_service_send(data->dms, QMI_DMS_GET_IDS, NULL,
-					get_ids_cb, cbd, g_free) > 0)
+					get_ids_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void get_caps_cb(struct qmi_result *result, void *user_data)
@@ -246,7 +246,7 @@ static int qmi_devinfo_probe(struct ofono_devinfo *devinfo,
 
 	DBG("");
 
-	data = g_new0(struct devinfo_data, 1);
+	data = l_new(struct devinfo_data, 1);
 
 	ofono_devinfo_set_data(devinfo, data);
 
@@ -266,7 +266,7 @@ static void qmi_devinfo_remove(struct ofono_devinfo *devinfo)
 
 	qmi_service_unref(data->dms);
 
-	g_free(data);
+	l_free(data);
 }
 
 static const struct ofono_devinfo_driver driver = {
diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index f575c5e2e1be..fb2069020833 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -30,8 +30,6 @@
 #include <ofono/modem.h>
 #include <ofono/gprs-context.h>
 
-#include <ell/ell.h>
-
 #include "qmi.h"
 #include "wds.h"
 #include "util.h"
@@ -96,7 +94,7 @@ static void get_settings_cb(struct qmi_result *result, void *user_data)
 	apn = qmi_result_get_string(result, QMI_WDS_RESULT_APN);
 	if (apn) {
 		DBG("APN: %s", apn);
-		g_free(apn);
+		l_free(apn);
 	}
 
 	if (qmi_result_get_uint8(result, QMI_WDS_RESULT_PDP_TYPE, &pdp_type))
@@ -173,7 +171,7 @@ static void start_net_cb(struct qmi_result *result, void *user_data)
 	cbd->user = gc;
 
 	if (qmi_service_send(data->wds, QMI_WDS_GET_CURRENT_SETTINGS, NULL,
-					get_settings_cb, cbd, g_free) > 0)
+					get_settings_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
@@ -207,14 +205,14 @@ static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
 	cbd->user = gc;
 
 	if (qmi_service_send(data->wds, QMI_WDS_START_NETWORK, NULL,
-					start_net_cb, cbd, g_free) > 0)
+					start_net_cb, cbd, l_free) > 0)
 		return;
 
 	data->active_context = 0;
 
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static uint8_t auth_method_to_qmi_auth(enum ofono_gprs_auth_method method)
@@ -279,7 +277,7 @@ static void qmi_activate_primary(struct ofono_gprs_context *gc,
 					strlen(ctx->password), ctx->password);
 
 	if (qmi_service_send(data->wds, QMI_WDS_START_NETWORK, param,
-					start_net_cb, cbd, g_free) > 0)
+					start_net_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
@@ -289,7 +287,7 @@ error:
 
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void stop_net_cb(struct qmi_result *result, void *user_data)
@@ -333,7 +331,7 @@ static void qmi_deactivate_primary(struct ofono_gprs_context *gc,
 						data->pkt_handle);
 
 	if (qmi_service_send(data->wds, QMI_WDS_STOP_NETWORK, param,
-					stop_net_cb, cbd, g_free) > 0)
+					stop_net_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
@@ -341,7 +339,7 @@ static void qmi_deactivate_primary(struct ofono_gprs_context *gc,
 	if (cb)
 		CALLBACK_WITH_FAILURE(cb, user_data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void qmi_gprs_context_detach_shutdown(struct ofono_gprs_context *gc,
@@ -459,7 +457,7 @@ static int qmi_gprs_context_probe(struct ofono_gprs_context *gc,
 
 	DBG("");
 
-	data = g_new0(struct gprs_context_data, 1);
+	data = l_new(struct gprs_context_data, 1);
 
 	ofono_gprs_context_set_data(gc, data);
 	data->dev = device;
@@ -483,7 +481,7 @@ static void qmi_gprs_context_remove(struct ofono_gprs_context *gc)
 		qmi_service_unref(data->wds);
 	}
 
-	g_free(data);
+	l_free(data);
 }
 
 static const struct ofono_gprs_context_driver driver = {
diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 5dd23329eca2..a66863834a5f 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -117,7 +117,7 @@ static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 		ofono_info("LTE attach IP type: %hhd", iptype);
 
 	ofono_gprs_cid_activated(gprs, data->last_auto_context_id, apn);
-	g_free(apn);
+	l_free(apn);
 
 	return;
 
@@ -286,12 +286,12 @@ static void qmi_set_attached(struct ofono_gprs *gprs, int attached,
 	param = qmi_param_new_uint8(QMI_NAS_PARAM_ATTACH_ACTION, action);
 
 	if (qmi_service_send(data->nas, QMI_NAS_ATTACH_DETACH, param,
-					attach_detach_cb, cbd, g_free) > 0)
+					attach_detach_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void get_ss_info_cb(struct qmi_result *result, void *user_data)
@@ -329,12 +329,12 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 
 	cbd->user = gprs;
 	if (qmi_service_send(data->nas, QMI_NAS_GET_SERVING_SYSTEM, NULL,
-					get_ss_info_cb, cbd, g_free) > 0)
+					get_ss_info_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void create_wds_cb(struct qmi_service *service, void *user_data)
@@ -396,7 +396,7 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
 
 	DBG("");
 
-	data = g_new0(struct gprs_data, 1);
+	data = l_new(struct gprs_data, 1);
 
 	ofono_gprs_set_data(gprs, data);
 
@@ -426,7 +426,7 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 
 	qmi_service_unref(data->nas);
 
-	g_free(data);
+	l_free(data);
 }
 
 static const struct ofono_gprs_driver driver = {
diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/location-reporting.c
index cafc4c059ae1..a32d18245c4f 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -137,12 +137,12 @@ static void qmi_location_reporting_enable(struct ofono_location_reporting *lr,
 	param = qmi_param_new_uint8(QMI_PDS_PARAM_AUTO_TRACKING, 0x01);
 
 	if (qmi_service_send(data->pds, QMI_PDS_SET_AUTOTRACK, param,
-					autotrack_enable_cb, cbd, g_free) > 0)
+					autotrack_enable_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void autotrack_disable_cb(struct qmi_result *result, void *user_data)
@@ -177,12 +177,12 @@ static void qmi_location_reporting_disable(struct ofono_location_reporting *lr,
 	param = qmi_param_new_uint8(QMI_PDS_PARAM_AUTO_TRACKING, 0x00);
 
 	if (qmi_service_send(data->pds, QMI_PDS_SET_AUTOTRACK, param,
-					autotrack_disable_cb, cbd, g_free) > 0)
+					autotrack_disable_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void set_event_cb(struct qmi_result *result, void *user_data)
@@ -238,7 +238,7 @@ static int qmi_location_reporting_probe(struct ofono_location_reporting *lr,
 
 	DBG("");
 
-	data = g_new0(struct location_data, 1);
+	data = l_new(struct location_data, 1);
 
 	data->fd = -1;
 
@@ -261,7 +261,7 @@ static void qmi_location_reporting_remove(struct ofono_location_reporting *lr)
 
 	qmi_service_unref(data->pds);
 
-	g_free(data);
+	l_free(data);
 }
 
 static const struct ofono_location_reporting_driver driver = {
diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index fcc1d2bd935c..921d6e81933e 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -91,12 +91,12 @@ static void qmimodem_lte_set_default_attach_info(const struct ofono_lte *lte,
 
 	/* Modify profile */
 	if (qmi_service_send(ldd->wds, 0x28, param,
-					modify_profile_cb, cbd, g_free) > 0)
+					modify_profile_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void reset_profile_cb(struct qmi_result *result, void *user_data)
@@ -210,9 +210,7 @@ static int qmimodem_lte_probe(struct ofono_lte *lte,
 
 	DBG("qmimodem lte probe");
 
-	ldd = g_try_new0(struct lte_data, 1);
-	if (!ldd)
-		return -ENOMEM;
+	ldd = l_new(struct lte_data, 1);
 
 	ofono_lte_set_data(lte, ldd);
 
@@ -232,7 +230,7 @@ static void qmimodem_lte_remove(struct ofono_lte *lte)
 
 	qmi_service_unref(ldd->wds);
 
-	g_free(ldd);
+	l_free(ldd);
 }
 
 static const struct ofono_lte_driver driver = {
diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
index 1190a37d66a7..e8a020d734e8 100644
--- a/drivers/qmimodem/netmon.c
+++ b/drivers/qmimodem/netmon.c
@@ -29,8 +29,6 @@
 #include <string.h>
 #include <errno.h>
 
-#include <glib.h>
-
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/netmon.h>
@@ -203,12 +201,12 @@ static void qmi_netmon_request_update(struct ofono_netmon *netmon,
 	qmi_param_append_uint16(param, 0x10, 255);
 
 	if (qmi_service_send(data->nas, QMI_NAS_GET_SIGNAL_STRENGTH, param,
-					get_rssi_cb, cbd, g_free) > 0)
+					get_rssi_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void create_nas_cb(struct qmi_service *service, void *user_data)
@@ -237,7 +235,7 @@ static int qmi_netmon_probe(struct ofono_netmon *netmon,
 
 	DBG("");
 
-	nmd = g_new0(struct netmon_data, 1);
+	nmd = l_new(struct netmon_data, 1);
 
 	ofono_netmon_set_data(netmon, nmd);
 
@@ -257,7 +255,7 @@ static void qmi_netmon_remove(struct ofono_netmon *netmon)
 
 	qmi_service_unref(nmd->nas);
 
-	g_free(nmd);
+	l_free(nmd);
 }
 
 static const struct ofono_netmon_driver driver = {
diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/network-registration.c
index a1c507eb371f..c37e4f4f4938 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -32,8 +32,6 @@
 #include <ofono/modem.h>
 #include <ofono/netreg.h>
 
-#include <ell/ell.h>
-
 #include "qmi.h"
 #include "nas.h"
 #include "util.h"
@@ -268,12 +266,12 @@ static void qmi_registration_status(struct ofono_netreg *netreg,
 	cbd->user = data;
 
 	if (qmi_service_send(data->nas, QMI_NAS_GET_SERVING_SYSTEM, NULL,
-					get_ss_info_cb, cbd, g_free) > 0)
+					get_ss_info_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void qmi_current_operator(struct ofono_netreg *netreg,
@@ -312,17 +310,11 @@ static void scan_nets_cb(struct qmi_result *result, void *user_data)
 	netlist = ptr;
 
 	num = L_LE16_TO_CPU(netlist->count);
-
 	DBG("found %d operators", num);
-
-	list = g_try_new0(struct ofono_network_operator, num);
-	if (!list) {
-		CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
-		return;
-	}
-
 	offset = 2;
 
+	list = l_new(struct ofono_network_operator, num);
+
 	for (i = 0; i < num; i++) {
 		const struct qmi_nas_network_info *netinfo = ptr + offset;
 		uint16_t mcc = L_LE16_TO_CPU(netinfo->mcc);
@@ -374,7 +366,7 @@ static void scan_nets_cb(struct qmi_result *result, void *user_data)
 done:
 	CALLBACK_WITH_SUCCESS(cb, num, list, cbd->data);
 
-	g_free(list);
+	l_free(list);
 }
 
 static void qmi_list_operators(struct ofono_netreg *netreg,
@@ -386,12 +378,12 @@ static void qmi_list_operators(struct ofono_netreg *netreg,
 	DBG("");
 
 	if (qmi_service_send(data->nas, QMI_NAS_NETWORK_SCAN, NULL,
-					scan_nets_cb, cbd, g_free) > 0)
+					scan_nets_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void register_net_cb(struct qmi_result *result, void *user_data)
@@ -431,12 +423,12 @@ static void qmi_register_auto(struct ofono_netreg *netreg,
 					QMI_NAS_REGISTER_ACTION_AUTO);
 
 	if (qmi_service_send(data->nas, QMI_NAS_NETWORK_REGISTER, param,
-					register_net_cb, cbd, g_free) > 0)
+					register_net_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void qmi_register_manual(struct ofono_netreg *netreg,
@@ -461,12 +453,12 @@ static void qmi_register_manual(struct ofono_netreg *netreg,
 						sizeof(info), &info);
 
 	if (qmi_service_send(data->nas, QMI_NAS_NETWORK_REGISTER, param,
-					register_net_cb, cbd, g_free) > 0)
+					register_net_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static int dbm_to_strength(int8_t dbm)
@@ -524,12 +516,12 @@ static void qmi_signal_strength(struct ofono_netreg *netreg,
 	DBG("");
 
 	if (qmi_service_send(data->nas, QMI_NAS_GET_SIGNAL_STRENGTH, NULL,
-					get_rssi_cb, cbd, g_free) > 0)
+					get_rssi_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void system_info_notify(struct qmi_result *result, void *user_data)
@@ -689,7 +681,7 @@ static int qmi_netreg_probe(struct ofono_netreg *netreg,
 
 	DBG("");
 
-	data = g_new0(struct netreg_data, 1);
+	data = l_new(struct netreg_data, 1);
 
 	data->operator.name[0] = '\0';
 	data->operator.mcc[0] = '\0';
@@ -743,7 +735,7 @@ static void qmi_netreg_remove(struct ofono_netreg *netreg)
 
 	qmi_service_unref(data->nas);
 
-	g_free(data);
+	l_free(data);
 }
 
 static const struct ofono_netreg_driver driver = {
diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-settings.c
index ffd8a05923c6..08e08f50b113 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -86,7 +86,7 @@ static void qmi_query_rat_mode(struct ofono_radio_settings *rs,
 
 	if (qmi_service_send(data->nas,
 				QMI_NAS_GET_SYSTEM_SELECTION_PREFERENCE, NULL,
-				get_system_selection_pref_cb, cbd, g_free) > 0)
+				get_system_selection_pref_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, -1, data);
@@ -144,12 +144,12 @@ static void qmi_set_rat_mode(struct ofono_radio_settings *rs, unsigned int mode,
 
 	if (qmi_service_send(data->nas,
 				QMI_NAS_SET_SYSTEM_SELECTION_PREFERENCE, param,
-				set_system_selection_pref_cb, cbd, g_free) > 0)
+				set_system_selection_pref_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 	CALLBACK_WITH_FAILURE(cb, user_data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void get_caps_cb(struct qmi_result *result, void *user_data)
@@ -204,11 +204,11 @@ static void qmi_query_available_rats(struct ofono_radio_settings *rs,
 		goto error;
 
 	if (qmi_service_send(rsd->dms, QMI_DMS_GET_CAPS, NULL,
-					get_caps_cb, cbd, g_free) > 0)
+					get_caps_cb, cbd, l_free) > 0)
 		return;
 
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 
@@ -257,7 +257,7 @@ static int qmi_radio_settings_probe(struct ofono_radio_settings *rs,
 
 	DBG("");
 
-	data = g_new0(struct settings_data, 1);
+	data = l_new(struct settings_data, 1);
 
 	ofono_radio_settings_set_data(rs, data);
 
@@ -280,7 +280,7 @@ static void qmi_radio_settings_remove(struct ofono_radio_settings *rs)
 	qmi_service_unref(data->dms);
 	qmi_service_unref(data->nas);
 
-	g_free(data);
+	l_free(data);
 }
 
 static const struct ofono_radio_settings_driver driver = {
diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index 12e5ab079111..e9ed0a9ec4c1 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -110,14 +110,14 @@ static void qmi_read_file_transparent(struct ofono_sim *sim,
 	switch (fileid) {
 	case SIM_EF_ICCID_FILEID:
 		if (qmi_service_send(data->dms, QMI_DMS_GET_ICCID, NULL,
-						get_iccid_cb, cbd, g_free) > 0)
+						get_iccid_cb, cbd, l_free) > 0)
 			return;
 		break;
 	}
 
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void get_imsi_cb(struct qmi_result *result, void *user_data)
@@ -153,12 +153,12 @@ static void qmi_read_imsi(struct ofono_sim *sim,
 	DBG("");
 
 	if (qmi_service_send(data->dms, QMI_DMS_GET_IMSI, NULL,
-					get_imsi_cb, cbd, g_free) > 0)
+					get_imsi_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void get_pin_status_cb(struct qmi_result *result, void *user_data)
@@ -226,12 +226,12 @@ static void qmi_query_passwd_state(struct ofono_sim *sim,
 	cbd->user = data;
 
 	if (qmi_service_send(data->dms, QMI_DMS_GET_PIN_STATUS, NULL,
-					get_pin_status_cb, cbd, g_free) > 0)
+					get_pin_status_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void qmi_query_pin_retries(struct ofono_sim *sim,
@@ -351,7 +351,7 @@ static int qmi_sim_probe(struct ofono_sim *sim,
 
 	DBG("");
 
-	data = g_new0(struct sim_data, 1);
+	data = l_new(struct sim_data, 1);
 
 	for (i = 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
 		data->retries[i] = -1;
@@ -379,7 +379,7 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 
 	qmi_service_unref(data->dms);
 
-	g_free(data);
+	l_free(data);
 }
 
 static const struct ofono_sim_driver driver = {
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 07cbbaa47992..110af6686627 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -188,7 +188,7 @@ static void qmi_read_attributes(struct ofono_sim *sim, int fileid,
 	qmi_param_append(param, 0x02, fileid_len, fileid_data);
 
 	if (qmi_service_send(data->uim, QMI_UIM_GET_FILE_ATTRIBUTES, param,
-				get_file_attributes_cb, cbd, g_free) > 0)
+				get_file_attributes_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
@@ -196,7 +196,7 @@ static void qmi_read_attributes(struct ofono_sim *sim, int fileid,
 error:
 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL,
 					EF_STATUS_INVALIDATED, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void read_generic_cb(struct qmi_result *result, void *user_data)
@@ -255,14 +255,14 @@ static void qmi_read_transparent(struct ofono_sim *sim,
 	qmi_param_append(param, 0x03, sizeof(read_data), read_data);
 
 	if (qmi_service_send(data->uim, QMI_UIM_READ_TRANSPARENT, param,
-					read_generic_cb, cbd, g_free) > 0)
+					read_generic_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 
 error:
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, user_data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void qmi_read_record(struct ofono_sim *sim,
@@ -298,14 +298,14 @@ static void qmi_read_record(struct ofono_sim *sim,
 	qmi_param_append(param, 0x03, sizeof(read_data), read_data);
 
 	if (qmi_service_send(data->uim, QMI_UIM_READ_RECORD, param,
-					read_generic_cb, cbd, g_free) > 0)
+					read_generic_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 
 error:
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, user_data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void write_generic_cb(struct qmi_result *result, void *user_data)
@@ -380,14 +380,14 @@ static void write_generic(struct ofono_sim *sim,
 	qmi_param_append(param, 0x03, 4 + length, write_data);
 
 	if (qmi_service_send(data->uim, qmi_message, param,
-					write_generic_cb, cbd, g_free) > 0)
+					write_generic_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 
 error:
 	CALLBACK_WITH_FAILURE(cb, user_data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void qmi_write_transparent(struct ofono_sim *sim,
@@ -456,12 +456,12 @@ static void qmi_read_imsi(struct ofono_sim *sim,
 	DBG("");
 
 	if (qmi_service_send(data->dms, QMI_DMS_GET_IMSI, NULL,
-					get_imsi_cb, cbd, g_free) > 0)
+					get_imsi_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 /* Return true if a retry could give another (better) result */
@@ -651,12 +651,12 @@ static void qmi_query_passwd_state(struct ofono_sim *sim,
 	cbd->user = sim;
 
 	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
-					query_passwd_state_cb, cbd, g_free) > 0)
+					query_passwd_state_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void query_pin_retries_cb(struct qmi_result *result, void *user_data)
@@ -689,12 +689,12 @@ static void qmi_query_pin_retries(struct ofono_sim *sim,
 	DBG("");
 
 	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
-					query_pin_retries_cb, cbd, g_free) > 0)
+					query_pin_retries_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void pin_send_cb(struct qmi_result *result, void *user_data)
@@ -748,14 +748,14 @@ static void qmi_pin_send(struct ofono_sim *sim, const char *passwd,
 					session_info_data);
 
 	if (qmi_service_send(data->uim, QMI_UIM_VERIFY_PIN, param,
-					pin_send_cb, cbd, g_free) > 0)
+					pin_send_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 
 error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void get_card_status_cb(struct qmi_result *result, void *user_data)
@@ -898,7 +898,7 @@ static int qmi_sim_probe(struct ofono_sim *sim,
 
 	DBG("");
 
-	data = g_new0(struct sim_data, 1);
+	data = l_new(struct sim_data, 1);
 
 	data->qmi_dev = device;
 
@@ -937,7 +937,7 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 		data->dms = NULL;
 	}
 
-	g_free(data);
+	l_free(data);
 }
 
 static const struct ofono_sim_driver driver = {
diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index f8ed96c435e0..498a6d778303 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -97,12 +97,12 @@ static void qmi_sca_query(struct ofono_sms *sms,
 	DBG("");
 
 	if (qmi_service_send(data->wms, QMI_WMS_GET_SMSC_ADDR, NULL,
-					get_smsc_addr_cb, cbd, g_free) > 0)
+					get_smsc_addr_cb, cbd, l_free) > 0)
 		return;
 
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void set_smsc_addr_cb(struct qmi_result *result, void *user_data)
@@ -152,14 +152,14 @@ static void qmi_sca_set(struct ofono_sms *sms,
 						strlen(type), type);
 
 	if (qmi_service_send(data->wms, QMI_WMS_SET_SMSC_ADDR, param,
-					set_smsc_addr_cb, cbd, g_free) > 0)
+					set_smsc_addr_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 
 error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void raw_send_cb(struct qmi_result *result, void *user_data)
@@ -205,12 +205,12 @@ static void qmi_submit(struct ofono_sms *sms,
 	qmi_param_append(param, QMI_WMS_PARAM_MESSAGE, 3 + pdu_len, message);
 
 	if (qmi_service_send(data->wms, QMI_WMS_RAW_SEND, param,
-					raw_send_cb, cbd, g_free) > 0)
+					raw_send_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static int domain_to_bearer(uint8_t domain)
@@ -281,13 +281,13 @@ static void qmi_bearer_query(struct ofono_sms *sms,
 		goto error;
 
 	if (qmi_service_send(data->wms, QMI_WMS_GET_DOMAIN_PREF, NULL,
-					get_domain_pref_cb, cbd, g_free) > 0)
+					get_domain_pref_cb, cbd, l_free) > 0)
 		return;
 
 error:
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void set_domain_pref_cb(struct qmi_result *result, void *user_data)
@@ -323,14 +323,14 @@ static void qmi_bearer_set(struct ofono_sms *sms, int bearer,
 	param = qmi_param_new_uint8(QMI_WMS_PARAM_DOMAIN, domain);
 
 	if (qmi_service_send(data->wms, QMI_WMS_SET_DOMAIN_PREF, param,
-					set_domain_pref_cb, cbd, g_free) > 0)
+					set_domain_pref_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 
 error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-	g_free(cbd);
+	l_free(cbd);
 }
 
 static void delete_msg_cb(struct qmi_result *result, void *user_data)
@@ -492,7 +492,7 @@ static void get_msg_list_cb(struct qmi_result *result, void *user_data)
 
 	/* free list from last time */
 	if (data->msg_list) {
-		g_free(data->msg_list);
+		l_free(data->msg_list);
 		data->msg_list = NULL;
 	}
 
@@ -500,10 +500,7 @@ static void get_msg_list_cb(struct qmi_result *result, void *user_data)
 	if (cnt) {
 		int msg_size = cnt * sizeof(list->msg[0]);
 
-		data->msg_list = g_try_malloc0(sizeof(list->cnt) + msg_size);
-		if (data->msg_list == NULL)
-			goto done;
-
+		data->msg_list = l_malloc(sizeof(list->cnt) + msg_size);
 		data->msg_list->cnt = cnt;
 		memcpy(data->msg_list->msg, list->msg, msg_size);
 
@@ -785,7 +782,7 @@ static int qmi_sms_probe(struct ofono_sms *sms,
 
 	DBG("");
 
-	data = g_new0(struct sms_data, 1);
+	data = l_new(struct sms_data, 1);
 
 	ofono_sms_set_data(sms, data);
 
@@ -807,9 +804,9 @@ static void qmi_sms_remove(struct ofono_sms *sms)
 	qmi_service_unref(data->wms);
 
 	if (data->msg_list)
-		g_free(data->msg_list);
+		l_free(data->msg_list);
 
-	g_free(data);
+	l_free(data);
 }
 
 static const struct ofono_sms_driver driver = {
diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
index cfdf3ed97ce5..67dd649f360b 100644
--- a/drivers/qmimodem/ussd.c
+++ b/drivers/qmimodem/ussd.c
@@ -197,7 +197,7 @@ static int qmi_ussd_probe(struct ofono_ussd *ussd,
 
 	DBG("");
 
-	data = g_new0(struct ussd_data, 1);
+	data = l_new(struct ussd_data, 1);
 
 	ofono_ussd_set_data(ussd, data);
 
@@ -217,7 +217,7 @@ static void qmi_ussd_remove(struct ofono_ussd *ussd)
 
 	qmi_service_unref(data->voice);
 
-	g_free(data);
+	l_free(data);
 }
 
 static void qmi_ussd_cancel(struct ofono_ussd *ussd,
@@ -292,7 +292,7 @@ static void qmi_ussd_request(struct ofono_ussd *ussd, int dcs,
 	qmi_ussd->dcs = QMI_USSD_DCS_ASCII;
 	qmi_ussd->length = len;
 	memcpy(qmi_ussd->data, utf8, utf8_len);
-	g_free(utf8);
+	l_free(utf8);
 
 	param = qmi_param_new();
 	if (param == NULL)
@@ -302,12 +302,12 @@ static void qmi_ussd_request(struct ofono_ussd *ussd, int dcs,
 			sizeof(struct qmi_ussd_data) + utf8_len, qmi_ussd);
 
 	if (qmi_service_send(ud->voice, QMI_VOICE_ASYNC_ORIG_USSD, param,
-					qmi_ussd_request_cb, cbd, g_free) > 0)
+					qmi_ussd_request_cb, cbd, l_free) > 0)
 		return;
 
 	qmi_param_free(param);
 error:
-	g_free(cbd);
+	l_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 
diff --git a/drivers/qmimodem/util.h b/drivers/qmimodem/util.h
index 7e049322636a..68bc93837c71 100644
--- a/drivers/qmimodem/util.h
+++ b/drivers/qmimodem/util.h
@@ -20,6 +20,7 @@
  */
 
 #include <glib.h>
+#include <ell/ell.h>
 
 struct cb_data {
 	void *cb;
@@ -32,7 +33,7 @@ static inline struct cb_data *cb_data_new(void *cb, void *data)
 {
 	struct cb_data *ret;
 
-	ret = g_new0(struct cb_data, 1);
+	ret = l_new(struct cb_data, 1);
 	ret->cb = cb;
 	ret->data = data;
 	ret->user = NULL;
@@ -54,7 +55,7 @@ static inline void cb_data_unref(gpointer user_data)
 	if (--cbd->ref)
 		return;
 
-	g_free(cbd);
+	l_free(cbd);
 }
 
 #define CALLBACK_WITH_CME_ERROR(cb, err, args...)	\
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 059edbae9ac5..aa34fc25a860 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -69,7 +69,7 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 
 	DBG("");
 
-	data = g_new0(struct voicecall_data, 1);
+	data = l_new(struct voicecall_data, 1);
 
 	ofono_voicecall_set_data(vc, data);
 
@@ -92,7 +92,7 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
 
 	qmi_service_unref(data->voice);
 
-	g_free(data);
+	l_free(data);
 }
 
 static const struct ofono_voicecall_driver driver = {
-- 
2.43.0

