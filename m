Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A119BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="q2hE5f2S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=S4Y3i8I0PwYF1lOMlHAV6yWYB9caexRJqfycBRCg09c=; t=1697528119; x=1697618119; 
	b=q2hE5f2S+eo2MLohcZDLkM1Vm5VEQzYmFp7x5j9CfInJM0OApyj2i1t3MDQlAYEVnwP3GK2axO+
	1MdZ33MqeRDDkr2rFPcX/1YXaGITbSvVgSRA6jYyVCYrp9KaZ/kr34meGr6CTXKpQJ0v8aRAz6khE
	/pzQJMZX+BvIA3fZ57k=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsebj-004oe4-0s; Tue, 17 Oct 2023 10:35:16 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 08/18] drivers: quectel: Add radio settings
Date: Tue, 17 Oct 2023 12:33:32 +0500
Message-Id: <20231017073342.673160-8-m.lyubimov@aqsi.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017073342.673160-1-m.lyubimov@aqsi.ru>
References: <20231017073342.673160-1-m.lyubimov@aqsi.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp63.i.mail.ru; auth=pass smtp.auth=m.lyubimov@aqsi.ru smtp.mailfrom=m.lyubimov@aqsi.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF026BA05CDB6F6D46C5D78B698F2A6AC182A05F5380850408496D7FBEE6CB4F7D20578184EC6D2488352E38D7C1F98BC959172F71C13842B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F1942E6D70B4A2F0EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D08ED87D5614270A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E3B74FE430B34C0C50960583CBAF8B27117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC1A9C11735BBA05FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520B1593CA6EC85F86DCB629EEF1311BF91D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA91133410A2FE6C23AD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3034D30FDF2F620DBAD7EC71F1DB88427C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CF254576263B31EA92E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F1FC58B5115ECA9A26D8C47C27EEC5E9FB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5086F3CB95CFD7A75DC415D92B1A1BB051BABD895796BE0FBF87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A092FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFFBC38FED9010CCFB03DF125F2D43E8107D4CE8D7381CC7B7C4304B1EE20391129DCE6E1EBC7C769EEBFDF7752E1FC3377CF179D12E561CB1C22C07A161F93CC040B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJBuEMxggzWiYw==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA93C3AAF3340D72B5DC64BA6A2DABABD931271C29BF1EAE7275D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 drivers/quectelmodem/quectelmodem.c   |  49 +++++
 drivers/quectelmodem/quectelmodem.h   |  25 +++
 drivers/quectelmodem/radio-settings.c | 269 ++++++++++++++++++++++++++
 3 files changed, 343 insertions(+)
 create mode 100644 drivers/quectelmodem/quectelmodem.c
 create mode 100644 drivers/quectelmodem/quectelmodem.h
 create mode 100644 drivers/quectelmodem/radio-settings.c

diff --git a/drivers/quectelmodem/quectelmodem.c b/drivers/quectelmodem/quectelmodem.c
new file mode 100644
index 00000000..868ee0c1
--- /dev/null
+++ b/drivers/quectelmodem/quectelmodem.c
@@ -0,0 +1,49 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
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
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+
+#include "quectelmodem.h"
+
+static int quectelmodem_init(void)
+{
+	quectel_radio_settings_init();
+
+	return 0;
+}
+
+static void quectelmodem_exit(void)
+{
+	quectel_radio_settings_exit();
+}
+
+OFONO_PLUGIN_DEFINE(quectelmodem, "Quectel modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			quectelmodem_init, quectelmodem_exit)
diff --git a/drivers/quectelmodem/quectelmodem.h b/drivers/quectelmodem/quectelmodem.h
new file mode 100644
index 00000000..53ea1df8
--- /dev/null
+++ b/drivers/quectelmodem/quectelmodem.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
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
+#include <drivers/atmodem/atutil.h>
+
+extern void quectel_radio_settings_init(void);
+extern void quectel_radio_settings_exit(void);
diff --git a/drivers/quectelmodem/radio-settings.c b/drivers/quectelmodem/radio-settings.c
new file mode 100644
index 00000000..dbc46ee1
--- /dev/null
+++ b/drivers/quectelmodem/radio-settings.c
@@ -0,0 +1,269 @@
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
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "quectelmodem.h"
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
+	.name			= "quectelmodem",
+	.probe			= quectel_radio_settings_probe,
+	.remove			= quectel_radio_settings_remove,
+	.query_rat_mode		= quectel_query_rat_mode,
+	.set_rat_mode		= quectel_set_rat_mode,
+	.query_available_rats	= quectel_query_available_rats
+};
+
+void quectel_radio_settings_init(void)
+{
+	ofono_radio_settings_driver_register(&driver);
+}
+
+void quectel_radio_settings_exit(void)
+{
+	ofono_radio_settings_driver_unregister(&driver);
+}
-- 
2.25.1

