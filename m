Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9619BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="mujSCJkJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=xQ2Wh1eJD+SMZRmuIwMKzb9ZX/52ULNxNCS54D7k2gQ=; t=1697528108; x=1697618108; 
	b=mujSCJkJyVqn7+tOFrFrh26/3Ffnm++iVwBNOSG3v0ppbHras6eWrbmvXGfQDDnpoteEGWwZUTg
	3JEW0j3Us7oLfLlkOWrhPNOy1o0ccXHVB7N1wAkQRyy7Or8B/daiZftEgIdF4mE2HCFrhkSvdh9bz
	+8f/CD6ImgA0/HWEyZs=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsebW-004oe4-1r; Tue, 17 Oct 2023 10:35:04 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 05/18] drivers: simcom: Add radio settings
Date: Tue, 17 Oct 2023 12:33:29 +0500
Message-Id: <20231017073342.673160-5-m.lyubimov@aqsi.ru>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF12F77ADD25EC5C9658AC0226C7A531B7182A05F5380850406370FF762FA26051BAEBF38A988C6B0C627A2F4F251AFDD527416F35F345AB94
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B9FBA884A7C9B8BAEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006376EC5B14D896A2D978638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D88CD404A9963C851EB5C9639435C6436A117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCE2CCD8F0CAA010FB389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC817119E5299B287EEF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CB355ED1E20F5346ABA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6E9458D376F2992EE3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FCC2ED6D5310B1F811E2021AF6380DFAD18AA50765F7900637F09814068C508CC822CA9DD8327EE493B89ED3C7A628178179C543ECCDAE434EC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A577105EA0D2475E8EDC415D92B1A1BB05704932623D02D7DDF87CCE6106E1FC07E67D4AC08A07B9B0A816C540FC8EEC309C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE335F2A6D9F9EFD193E18F87DEDD7DF0BCB9045B886783B419199E5D809C6581E98901B1639BBD63EBFDF7752E1FC3374D09A41F07369EBDD7EADDFD92900E6940B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJBHtQzbK3M58g==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9B8C67EAEDF92F742C64BA6A2DABABD93BA272E20C90909CE5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 drivers/simcommodem/radio-settings.c | 245 +++++++++++++++++++++++++++
 drivers/simcommodem/simcommodem.c    |  49 ++++++
 drivers/simcommodem/simcommodem.h    |  25 +++
 3 files changed, 319 insertions(+)
 create mode 100644 drivers/simcommodem/radio-settings.c
 create mode 100644 drivers/simcommodem/simcommodem.c
 create mode 100644 drivers/simcommodem/simcommodem.h

diff --git a/drivers/simcommodem/radio-settings.c b/drivers/simcommodem/radio-settings.c
new file mode 100644
index 00000000..7addc12d
--- /dev/null
+++ b/drivers/simcommodem/radio-settings.c
@@ -0,0 +1,245 @@
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
+#include "simcommodem.h"
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
+	.name			= "simcommodem",
+	.probe			= simcom_radio_settings_probe,
+	.remove			= simcom_radio_settings_remove,
+	.query_rat_mode		= simcom_query_rat_mode,
+	.set_rat_mode		= simcom_set_rat_mode,
+	.query_available_rats	= simcom_query_available_rats
+};
+
+void simcom_radio_settings_init(void)
+{
+	ofono_radio_settings_driver_register(&driver);
+}
+
+void simcom_radio_settings_exit(void)
+{
+	ofono_radio_settings_driver_unregister(&driver);
+}
diff --git a/drivers/simcommodem/simcommodem.c b/drivers/simcommodem/simcommodem.c
new file mode 100644
index 00000000..d39b05de
--- /dev/null
+++ b/drivers/simcommodem/simcommodem.c
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
+#include "simcommodem.h"
+
+static int simcommodem_init(void)
+{
+	simcom_radio_settings_init();
+
+	return 0;
+}
+
+static void simcommodem_exit(void)
+{
+	simcom_radio_settings_exit();
+}
+
+OFONO_PLUGIN_DEFINE(simcommodem, "Simcom modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			simcommodem_init, simcommodem_exit)
diff --git a/drivers/simcommodem/simcommodem.h b/drivers/simcommodem/simcommodem.h
new file mode 100644
index 00000000..4156de76
--- /dev/null
+++ b/drivers/simcommodem/simcommodem.h
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
+extern void simcom_radio_settings_init(void);
+extern void simcom_radio_settings_exit(void);
-- 
2.25.1

