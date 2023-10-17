Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B5381BD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="QCWdvQ3G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Aq7C6GCxectA0PBjzy5gUkySY010Y+UX2L9SX8Az0k8=; t=1697539784; x=1697629784; 
	b=QCWdvQ3GahhJ6V+AGMiUHq6hhKuDsoUPjfjLGztpKV9ccBIWrNnkSa3+n+XhBVjiUkBFkbOUGTH
	GBcnHHjaWVnS8w3ylryTsmWvvgXP6+TGsPktxCI2yuIrXTwsBX5WfJ2OrFTFg/BddxY0F4uDg3pgt
	65YLGfMqzgdcTg7OfSk=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshds-00Ab9o-1A; Tue, 17 Oct 2023 13:49:41 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 02/15] drivers: adding support for the SIMCom A7605E-H
Date: Tue, 17 Oct 2023 15:48:49 +0500
Message-Id: <20231017104902.717947-2-m.lyubimov@aqsi.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp38.i.mail.ru; auth=pass smtp.auth=m.lyubimov@aqsi.ru smtp.mailfrom=m.lyubimov@aqsi.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF12F77ADD25EC5C9658AC0226C7A531B7182A05F538085040948FFE1E219EF00E5A75BD6C2E4F08FC8EA112DC096B9FC738670BBFA519B280
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CF4D16325FBE1EEDEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375E5376F82D9E62E48638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FEC5C548CB87A12EACAE3B35D2F05CA5117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC587F3D2152687E5CA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10F28451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE437C869540D2AB0F302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C31DEE520572A3537776E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C224911E5B64A728E1589E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B64D76635298CFB1CF089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A55E2F6615CDB55AB065C29474C6E1BB28F703B7445E9822CAF87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF2A409C845CE69C50842D06DDBA4248735B89958009CBD7A780B32DD43736C3C3FB7A4CF61EC7A84FEBFDF7752E1FC33750AABFDDDFAAF8AF74453DFC7A3A8E1D40B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJA4aOdSE+ozmg==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF7466E79D22025AFFC19A0702D06D97054970EBF8F32C5C62C245D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The features of the SIMCom A7605E-H modem are taken into account in the atmodem driver
---
 drivers/atmodem/gprs.c               |  59 ++++++-
 drivers/atmodem/sim.c                |   7 +-
 drivers/simcommodem/radio-settings.c | 236 +++++++++++++++++++++++++++
 3 files changed, 298 insertions(+), 4 deletions(-)
 create mode 100644 drivers/simcommodem/radio-settings.c

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 8c352ba6..530d86a5 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -41,6 +41,7 @@
 #include "gatchat.h"
 #include "gatresult.h"
 
+#include "common.h"
 #include "vendor.h"
 
 #define MAX_CONTEXTS 255
@@ -544,6 +545,54 @@ static void telit_mode_notify(GAtResult *result, gpointer user_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 
+static void simcom_mode_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs = user_data;
+	GAtResultIter iter;
+	gint stat, bearer;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CNSMOD:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter,&stat))
+		return;
+
+	switch (stat) {
+	case 0:
+		bearer = PACKET_BEARER_NONE;
+		break;
+	case 1:
+	case 2:
+		bearer = PACKET_BEARER_GPRS;
+		break;
+	case 3:
+		bearer = PACKET_BEARER_EGPRS;
+		break;
+	case 4:
+		bearer = PACKET_BEARER_UMTS;
+		break;
+	case 5:
+		bearer = PACKET_BEARER_HSDPA;
+		break;
+	case 6:
+		bearer = PACKET_BEARER_HSUPA;
+		break;
+	case 7:
+		bearer = PACKET_BEARER_HSUPA_HSDPA;
+		break;
+	case 8:
+		bearer = PACKET_BEARER_EPS;
+		break;
+	default:
+		bearer = PACKET_BEARER_NONE;
+		break;
+	}
+
+	ofono_gprs_bearer_notify(gprs, bearer);
+}
+
 static void ublox_ureg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs = user_data;
@@ -626,6 +675,12 @@ static void gprs_initialized(gboolean ok, GAtResult *result, gpointer user_data)
 		g_at_chat_send(gd->chat, "AT#PSNT=1", none_prefix,
 						NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_SIMCOM:
+		g_at_chat_register(gd->chat, "+CNSMOD:", simcom_mode_notify,
+						FALSE, gprs, NULL);
+		g_at_chat_send(gd->chat, "AT+CNSMOD=1", none_prefix,
+						NULL, NULL, NULL);
+		break;
 	case OFONO_VENDOR_QUECTEL_EC2X:
 	case OFONO_VENDOR_QUECTEL_SERIAL:
 		break;
@@ -749,7 +804,9 @@ retry:
 		goto error;
 
 	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(gd->chat, "AT+CGAUTO=0", none_prefix, NULL, NULL, NULL);
+	if (gd->vendor != OFONO_VENDOR_SIMCOM) {
+		g_at_chat_send(gd->chat, "AT+CGAUTO=0", none_prefix, NULL, NULL, NULL);
+	}
 
 	switch (gd->vendor) {
 	case OFONO_VENDOR_MBM:
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 3cb8c7bd..8849a129 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1642,9 +1642,10 @@ static void at_discover_apps(struct ofono_sim *sim,
 	struct sim_data *sd = ofono_sim_get_data(sim);
 	struct cb_data *cbd;
 
-	/* QUECTEL EC2X reboots when executing the AT+CUAD command with SIM cards
-	of some operators */
-	if (sd->vendor == OFONO_VENDOR_QUECTEL_EC2X)
+	/* QUECTEL EC2X and SIMCom A7605E-H reboots when executing the AT+CUAD
+	command with SIM cards of some operators */
+	if (sd->vendor == OFONO_VENDOR_QUECTEL_EC2X
+			|| sd->vendor == OFONO_VENDOR_SIMCOM)
 		goto error;
 
 	cbd = cb_data_new(cb, data);
diff --git a/drivers/simcommodem/radio-settings.c b/drivers/simcommodem/radio-settings.c
new file mode 100644
index 00000000..2a856daf
--- /dev/null
+++ b/drivers/simcommodem/radio-settings.c
@@ -0,0 +1,236 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Intel Corporation. All rights reserved.
+ *  Copyright (C) 2021 Sergey Matyukevich. All rights reserved.
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/radio-settings.h>
+
+#include <drivers/atmodem/atutil.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+static const char *none_prefix[] = { NULL };
+static const char *cnmp_prefix[] = { "+CNMP:", NULL };
+
+struct radio_settings_data {
+	GAtChat *chat;
+};
+
+static void cnmp_query_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_radio_settings_rat_mode_query_cb_t cb = cbd->cb;
+	unsigned int mode;
+	struct ofono_error error;
+	int r_mode;
+	GAtResultIter iter;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CNMP:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &r_mode))
+		goto error;
+
+	DBG("r_mode %d", r_mode);
+
+	switch (r_mode) {
+	case 2:
+		mode = OFONO_RADIO_ACCESS_MODE_ANY;
+		break;
+	case 13:
+		mode = OFONO_RADIO_ACCESS_MODE_GSM;
+		break;
+	case 14:
+		mode = OFONO_RADIO_ACCESS_MODE_UMTS;
+		break;
+	case 38:
+		mode = OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	default:
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	cb(&error, mode, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void simcom_query_rat_mode(struct ofono_radio_settings *rs,
+				ofono_radio_settings_rat_mode_query_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd = ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd = cb_data_new(cb, data);
+
+	DBG("");
+
+	if (g_at_chat_send(rsd->chat, "AT+CNMP?", cnmp_prefix,
+				cnmp_query_cb, cbd, g_free) == 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+	}
+}
+
+static void cnmp_modify_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_radio_settings_rat_mode_set_cb_t cb = cbd->cb;
+	struct ofono_error error;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void simcom_set_rat_mode(struct ofono_radio_settings *rs,
+				unsigned int m,
+				ofono_radio_settings_rat_mode_set_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd = ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	int w_mode = 2;
+	char buf[20];
+
+	DBG("mode %d", m);
+
+	switch (m) {
+	case OFONO_RADIO_ACCESS_MODE_ANY:
+		w_mode = 2;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_GSM:
+		w_mode = 13;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_UMTS:
+	case OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM:
+		w_mode = 14;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE:
+	case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM:
+	case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS:
+		w_mode = 38;
+		break;
+	}
+
+	snprintf(buf, sizeof(buf), "AT+CNMP=%u", w_mode);
+
+	if (g_at_chat_send(rsd->chat, buf, none_prefix,
+				cnmp_modify_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void simcom_query_available_rats(struct ofono_radio_settings *rs,
+			ofono_radio_settings_available_rats_query_cb_t cb,
+			void *data)
+{
+	unsigned int available_rats = OFONO_RADIO_ACCESS_MODE_GSM
+				| OFONO_RADIO_ACCESS_MODE_UMTS
+				| OFONO_RADIO_ACCESS_MODE_LTE;
+
+	CALLBACK_WITH_SUCCESS(cb, available_rats, data);
+}
+
+static void cnmp_support_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_radio_settings *rs = user_data;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_radio_settings_remove(rs);
+		return;
+	}
+
+	ofono_radio_settings_register(rs);
+}
+
+static int simcom_radio_settings_probe(struct ofono_radio_settings *rs,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat = data;
+	struct radio_settings_data *rsd;
+
+	DBG("");
+
+	rsd = g_new0(struct radio_settings_data, 1);
+
+	rsd->chat = g_at_chat_clone(chat);
+
+	ofono_radio_settings_set_data(rs, rsd);
+
+	g_at_chat_send(rsd->chat, "AT+CNMP=?", cnmp_prefix,
+			cnmp_support_cb, rs, NULL);
+
+	return 0;
+}
+
+static void simcom_radio_settings_remove(struct ofono_radio_settings *rs)
+{
+	struct radio_settings_data *rsd = ofono_radio_settings_get_data(rs);
+
+	DBG("");
+
+	ofono_radio_settings_set_data(rs, NULL);
+	g_at_chat_unref(rsd->chat);
+	g_free(rsd);
+}
+
+static const struct ofono_radio_settings_driver driver = {
+	.probe			= simcom_radio_settings_probe,
+	.remove			= simcom_radio_settings_remove,
+	.query_rat_mode		= simcom_query_rat_mode,
+	.set_rat_mode		= simcom_set_rat_mode,
+	.query_available_rats	= simcom_query_available_rats
+};
+
+OFONO_ATOM_DRIVER_BUILTIN(radio_settings, simcommodem, &driver)
-- 
2.25.1

