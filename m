Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D91F3FC7
	for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 18:11:27 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id h16so8241883wrz.12
        for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 10:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lVD0j28XAkVvv06PwA95eILLqiRwBAJAqWHx/aooHw=;
        b=Pb0d39j8st3BueSlKyN+tWvB17+4jgj0OmTCqK2O3+bda8rY6WW1aS+V66iIzjy0ul
         NRewbvvR/kOVdV5OPuIAAi2Xsro3yMttXnMdZftgY/TghmSfoJ3A6CNNIV/YoE2Pdf7C
         R637h6TRIATzmY0vwqaJfPC+cdzt0JAAJNI4bBqnC6IB1H8VFrKkYDFpiPgBmPAu119U
         rBIBC25EImZ61i9AFi2/hgH4cGKEPBTk5AKvQXQxJOswchPooMFukP22usKQJb+aHdY7
         BjMUDFtBrE4CGXwuqGWjlF62vqL79UipLbaD50K+jYh4ELJvYz5t3LfEUZoiHdciO0w1
         JP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lVD0j28XAkVvv06PwA95eILLqiRwBAJAqWHx/aooHw=;
        b=xM+1UC1fNPtRRzxoV/J+WpCaZOgcFbpTAO5mL/RhZm9Uxz/dzx7a9RV05yo95eisVE
         /bPeQsA/GDys1cij/jfcwasef772K86wPE9CZs8vTvxSWqGEDQwiKgeNWa2GirMhCBjJ
         sikmUlfCp4P4u7QLrRSaXTY5UoPR4vf1pxuqZLVxWPudclRyZGb3zOI5SKcXjXKblafI
         NbJpCHnwQViYDASITSMJGBdWtomRRIZ2872Xwhy8PusPs5tJFckyY/Txyv3p6945LF9H
         oO9XkpS2wC98ymE+Wyj77v79dXiSAHwJjs8NCT/3UNnz7CBqBRsVNdlHBI7s9TgngTIq
         yPTQ==
X-Gm-Message-State: AO0yUKVIvDdKOvCeUw0H5D421aLO3tkrxizuYSlmodfrn1HfC2fXZ6Tr
	2/M46tu4S+XSJ8BSOqZTgsf80T7Cad2qBMENKh3gtA==
X-Google-Smtp-Source: AK7set84XyueWRZri+fyt+JEiV00P/e07+KZ8DbaC0VrCKodv2/5q1ywvATQNdEWFO+oj7DpbSSiGA==
X-Received: by 2002:adf:f450:0:b0:2c5:5331:5516 with SMTP id f16-20020adff450000000b002c553315516mr345169wrp.51.1676139085196;
        Sat, 11 Feb 2023 10:11:25 -0800 (PST)
Received: from neptune.. ([188.27.130.91])
        by smtp.gmail.com with ESMTPSA id j4-20020adff544000000b002c54fb024b2sm1716825wrp.61.2023.02.11.10.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 10:11:24 -0800 (PST)
From: Alexandru Ardelean <alex@shruggie.ro>
To: ofono@lists.linux.dev
Cc: alex@shruggie.ro,
	patrick.frick@stihl.de,
	matthias.gruhler@stihl.de,
	mircea.caprioru@flowkernel.ro,
	stephanie.altenburg@stihl.de
Subject: [RESEND PATCH 5/5] quectel: add support for BG95
Date: Sat, 11 Feb 2023 20:11:05 +0200
Message-Id: <20230211181105.7220-6-alex@shruggie.ro>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230211181105.7220-1-alex@shruggie.ro>
References: <20230211181105.7220-1-alex@shruggie.ro>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mircea Caprioru <mircea.caprioru@flowkernel.ro>

This adds support for the Quectel BG95 modem (family).
There are about 7 models for BG95 (according to their docs):
BG95-{M1,M2,M3,M4,M5,M6,MF}.
But, we've tested and validated just the BG95-M3.

It does not support QMI (like BG96), it uses only AT commands.
The AT commands are similar between models, so the hope is that the work on
M3 works for all. At least the ones used by ofono are supported by all
models (according to the Quectel docs).

The behavior of the BG95 is quite similar with the one for EC21 and EC200
(in terms of AT commands), but it differs in a few aspects.
Which is why the OFONO_VENDOR_QUECTEL_EC2X ID is used.

The 'AT+QINDCFG' supports slightly different commands than EC2XX.
The one that is common with EC2XX is 'AT+QINDCFG="csq",1'.
The 'AT+QINDCFG="act",1' is not supported; that means that this command
will error out, but that's fine.

And it uses the Aux interface to talk to the GPRS context.

The rest of the AT commands that ofono uses to talk to EC2X are also
working for BG95.
---
 plugins/quectel.c | 27 ++++++++++++++++++++++-----
 plugins/udevng.c  |  1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 464845ff..71594418 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -64,7 +64,7 @@ static const char *cpin_prefix[] = { "+CPIN:", NULL };
 static const char *cbc_prefix[] = { "+CBC:", NULL };
 static const char *qinistat_prefix[] = { "+QINISTAT:", NULL };
 static const char *cgmm_prefix[] = { "UC15", "Quectel_M95", "Quectel_MC60",
-					"EC21", "EC200", NULL };
+					"EC21", "EC200", "BG95", NULL };
 static const char *none_prefix[] = { NULL };
 
 static const uint8_t gsm0710_terminate[] = {
@@ -85,6 +85,7 @@ enum quectel_model {
 	QUECTEL_MC60,
 	QUECTEL_EC21,
 	QUECTEL_EC200,
+	QUECTEL_BG95,
 };
 
 struct quectel_data {
@@ -133,6 +134,7 @@ static ofono_bool_t quectel_model_supports_lte(enum quectel_model model)
 	switch (model) {
 	case QUECTEL_EC21:
 	case QUECTEL_EC200:
+	case QUECTEL_BG95:
 		return TRUE;
 	default:
 		return FALSE;
@@ -625,7 +627,8 @@ static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_data)
 		break;
 	case QUECTEL_M95:
 	case QUECTEL_MC60:
-		/* M95 and MC60 uses a counter to 3 */
+	case QUECTEL_BG95:
+		/* M95, MC60 and BG95 use a counter to 3 */
 		ready = 3;
 		break;
 	case QUECTEL_UNKNOWN:
@@ -834,7 +837,7 @@ static void setup_aux(struct ofono_modem *modem)
 
 	g_at_chat_set_slave(data->modem, data->aux);
 
-	if (data->model == QUECTEL_EC21) {
+	if (data->model == QUECTEL_EC21 || data->model == QUECTEL_BG95) {
 		g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=1", none_prefix,
 				NULL, NULL, NULL);
 		g_at_chat_send(data->aux, "AT+QURCCFG=\"urcport\",\"uart1\"", none_prefix,
@@ -886,6 +889,14 @@ static void cgmm_cb(int ok, GAtResult *result, void *user_data)
 		DBG("%p model %s", modem, model);
 		data->vendor = OFONO_VENDOR_QUECTEL_EC2X;
 		data->model = QUECTEL_EC200;
+	} else if (strstr(model, "BG95")) {
+		/**
+		 * BG95 is roughly similar to EC2X in terms of the
+		 * AT commands which ofono uses to talk to it.
+		 */
+		DBG("%p model %s", modem, model);
+		data->vendor = OFONO_VENDOR_QUECTEL_EC2X;
+		data->model = QUECTEL_BG95;
 	} else {
 		ofono_warn("%p unknown model: '%s'", modem, model);
 		data->vendor = OFONO_VENDOR_QUECTEL;
@@ -1357,8 +1368,14 @@ static void quectel_post_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 
 	gprs = ofono_gprs_create(modem, data->vendor, "atmodem", data->aux);
-	gc = ofono_gprs_context_create(modem, data->vendor, "atmodem",
-					data->modem);
+
+	/* BG95 uses the aux interface to talk to the context */
+	if (data->model == QUECTEL_BG95)
+		gc = ofono_gprs_context_create(modem, data->vendor, "atmodem",
+						data->aux);
+	else
+		gc = ofono_gprs_context_create(modem, data->vendor, "atmodem",
+						data->modem);
 
 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 34ac1cc0..af6abf5c 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1843,6 +1843,7 @@ static struct {
 	{ "quectelqmi",	"qcserial",	"2c7c", "0125"	},
 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0296"	},
 	{ "quectelqmi",	"qcserial",	"2c7c", "0296"	},
+	{ "quectelqmi",	"qcserial",	"2c7c", "0700"	},
 	{ "ublox",	"cdc_acm",	"1546", "1010"	},
 	{ "ublox",	"cdc_ncm",	"1546", "1010"	},
 	{ "ublox",	"cdc_acm",	"1546", "1102"	},
-- 
2.34.1

