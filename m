Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8338DCE
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="Sl1vH8Jk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=JZbS8mLCqp6b1zfhYUb4eeCsJkh+TU18zWNxi4y+kRk=; t=1697539789; x=1697629789; 
	b=Sl1vH8Jk8votgOTWMrAb16kDpwPI06QbeUKO4xqCisIwEmz2u5Wsc4FpoKi0FOiiZHWPkU/Ls/M
	+UtzMwe49/YjEBzok0kLKXJ7QvKvmCVB1A9AmZInLsPCsuv1dGzfhc2+OjH63dGHEoaFtt4zwb8iW
	EvKXju4DjkO25TEfD+c=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshdw-00Ab9o-2T; Tue, 17 Oct 2023 13:49:45 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 05/15] drivers: quectel: Add radio settings
Date: Tue, 17 Oct 2023 15:48:52 +0500
Message-Id: <20231017104902.717947-5-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFE894D0B694AE649AA7A71757303D0C60182A05F5380850405C67E7440DE92D1BF7C630B3330F6295A1A55C54835761567393E985559AC9E3
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE771540F9ECFC94C4BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637160171C9EBC7AFE48638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8F87D91B832C5C88AD3776FFC6652BB47117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCF77088377309FF52A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10F28451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE437C869540D2AB0F302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C31DEE520572A3537776E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C224931C0090ACECF247DE827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B64D76635298CFB1CF089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A505B381FF8251CBE965C29474C6E1BB28E5E8BF0B34EF2CF6F87CCE6106E1FC07E67D4AC08A07B9B0B355ED1E20F5346A9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF36FD5B9A53220BBDD8160B43DB487709387D39FC739CAB31895A9AC9C23F5A877649A938D59E33EDEBFDF7752E1FC337DEA108633C9664AD353A44D06ECC7C2940B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJCWplDausznGA==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF746AEBB0E0818C4AC0BA0702D06D9705497A32AB15EA70FF3FB5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 drivers/quectelmodem/radio-settings.c | 260 ++++++++++++++++++++++++++
 1 file changed, 260 insertions(+)
 create mode 100644 drivers/quectelmodem/radio-settings.c

diff --git a/drivers/quectelmodem/radio-settings.c b/drivers/quectelmodem/radio-settings.c
new file mode 100644
index 00000000..2bc42ef7
--- /dev/null
+++ b/drivers/quectelmodem/radio-settings.c
@@ -0,0 +1,260 @@
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
+static const char *qcfg_prefix[] = { "+QCFG:", NULL };
+
+struct radio_settings_data {
+	GAtChat *chat;
+};
+
+static void qcfg_query_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_radio_settings_rat_mode_query_cb_t cb = cbd->cb;
+	unsigned int mode;
+	struct ofono_error error;
+	int nwscanseq;
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
+	if (!g_at_result_iter_next(&iter, "+QCFG: \"nwscanseq\","))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &nwscanseq))
+		goto error;
+
+	DBG("nwscanseq %d", nwscanseq);
+
+	switch (nwscanseq) {
+	case 0:
+	case 4:
+	case 5:
+	case 12:
+		mode = OFONO_RADIO_ACCESS_MODE_ANY;
+		break;
+	case 1:
+		mode = OFONO_RADIO_ACCESS_MODE_GSM;
+		break;
+	case 2:
+		mode = OFONO_RADIO_ACCESS_MODE_UMTS;
+		break;
+	case 3:
+		mode = OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	case 6:
+	case 8:
+		mode = OFONO_RADIO_ACCESS_MODE_UMTS |
+			OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	case 7:
+	case 10:
+		mode = OFONO_RADIO_ACCESS_MODE_GSM |
+			OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	case 9:
+	case 11:
+		mode = OFONO_RADIO_ACCESS_MODE_GSM |
+			OFONO_RADIO_ACCESS_MODE_UMTS;
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
+static void quectel_query_rat_mode(struct ofono_radio_settings *rs,
+				ofono_radio_settings_rat_mode_query_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd = ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd = cb_data_new(cb, data);
+
+	DBG("");
+
+	if (g_at_chat_send(rsd->chat, "AT+QCFG=\"nwscanseq\"", qcfg_prefix,
+				qcfg_query_cb, cbd, g_free) == 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+	}
+}
+
+static void qcfg_modify_cb(gboolean ok, GAtResult *result, gpointer user_data)
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
+static void quectel_set_rat_mode(struct ofono_radio_settings *rs,
+				unsigned int m,
+				ofono_radio_settings_rat_mode_set_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd = ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd = cb_data_new(cb, data);
+	int nwscanseq;
+	char buf[30];
+
+	DBG("mode %d", m);
+
+	switch (m) {
+	case OFONO_RADIO_ACCESS_MODE_ANY:
+		nwscanseq = 0;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_GSM:
+		nwscanseq = 1;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_UMTS:
+		nwscanseq = 2;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE:
+		nwscanseq = 3;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM:
+		nwscanseq = 9;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS:
+		nwscanseq = 6;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM:
+		nwscanseq = 7;
+		break;
+	}
+
+	snprintf(buf, sizeof(buf), "AT+QCFG=\"nwscanseq\",%u", nwscanseq);
+
+	if (g_at_chat_send(rsd->chat, buf, none_prefix,
+				qcfg_modify_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void quectel_query_available_rats(struct ofono_radio_settings *rs,
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
+static void qcfg_support_cb(gboolean ok, GAtResult *result, gpointer user_data)
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
+static int quectel_radio_settings_probe(struct ofono_radio_settings *rs,
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
+	g_at_chat_send(rsd->chat, "AT+QCFG=\"nwscanseq\"", qcfg_prefix,
+			qcfg_support_cb, rs, NULL);
+
+	return 0;
+}
+
+static void quectel_radio_settings_remove(struct ofono_radio_settings *rs)
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
+	.probe			= quectel_radio_settings_probe,
+	.remove			= quectel_radio_settings_remove,
+	.query_rat_mode		= quectel_query_rat_mode,
+	.set_rat_mode		= quectel_set_rat_mode,
+	.query_available_rats	= quectel_query_available_rats
+};
+
+OFONO_ATOM_DRIVER_BUILTIN(radio_settings, quectelmodem, &driver)
-- 
2.25.1

