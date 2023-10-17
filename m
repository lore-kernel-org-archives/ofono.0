Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B89C15F
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="oY9DSSln"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=oSYJvrsvP3ZRbN6Os4i7ejr5qEt/676v1om8+MaV3qQ=; t=1697539786; x=1697629786; 
	b=oY9DSSlnv6M1pksRfcHsK8dQz8Q2M9yfQeIl9X+E8KSJRrzd3DEi0+NtVERTb4vbZ0L4mW3kSS7
	kO0pWhIEGekpUBrvUL3GvpjbgHPmqQuXcWBiFcKwl9yvEPcHJCC60r3/BDh0VNYQF4cM1P8X297TW
	66i4EwlR0Xb91xRrG00=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshdt-00Ab9o-2g; Tue, 17 Oct 2023 13:49:42 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 03/15] plugins: adding support for the SIMCom A7605E-H
Date: Tue, 17 Oct 2023 15:48:50 +0500
Message-Id: <20231017104902.717947-3-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF8220711250C2C7F14874E241AD7DC2F9182A05F5380850401B7AC94E49AE6E1FF7C630B3330F62950823825FBAFBC200AF473B291A6A84D7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CAD5D48C92B7716DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063767A3307017EE919D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D81C087F999CA80F3A47C800478FDAAE70117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCB37B5D51F58B3735A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520140C956E756FBB7AF04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE26055571C92BF10F269E641683F5DD3FD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE30A9EC8C3488E7643302FCEF25BFAB345C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CE753FA5741D1AD022E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F443EE4078611238142539A7722CA490CB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5F43BEA286B92C3B565C29474C6E1BB28EBCB193E1290E3C7F87CCE6106E1FC07E67D4AC08A07B9B0251EFD5447B32ED69C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9F42637B17C6241AC38B00A0D271CCF9A8497C1E698732F90CE1E4FE2A6A87C31D17C9D1E1925344EBFDF7752E1FC33733729422F12A183C17CA6DCABEA946A940B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJDporDOsTUZuw==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF74630BC76FB4A68EB6DA0702D06D97054973A7A9A8B07ACFACA5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The udevng plugin has been modified to detect the SIMCom A7605E-H modem and the simcom_a76xx plugin has been added to work with it
---
 plugins/simcom_a76xx.c | 323 +++++++++++++++++++++++++++++++++++++++++
 plugins/udevng.c       |  55 +++++++
 2 files changed, 378 insertions(+)
 create mode 100644 plugins/simcom_a76xx.c

diff --git a/plugins/simcom_a76xx.c b/plugins/simcom_a76xx.c
new file mode 100644
index 00000000..059773b5
--- /dev/null
+++ b/plugins/simcom_a76xx.c
@@ -0,0 +1,323 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2009  Collabora Ltd. All rights reserved.
+ *  Copyright 2018 Purism SPC
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
+/*
+ * This file was originally copied from g1.c and
+ * modified by Bob Ham <bob.ham@puri.sm>
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-barring.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-meter.h>
+#include <ofono/call-settings.h>
+#include <ofono/devinfo.h>
+#include <ofono/message-waiting.h>
+#include <ofono/netreg.h>
+#include <ofono/phonebook.h>
+#include <ofono/sim.h>
+#include <ofono/sms.h>
+#include <ofono/ussd.h>
+#include <ofono/voicecall.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/lte.h>
+#include <ofono/radio-settings.h>
+
+#include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/atutil.h>
+
+struct simcom_a76xx_data {
+	GAtChat *at;
+	GAtChat *ppp;
+};
+
+static const char *cfun_prefix[] = { "+CFUN:", NULL };
+
+static void simcom_a76xx_debug(const char *str, void *user_data)
+{
+	ofono_info("%s%s", (const char *)user_data, str);
+}
+
+/* Detect hardware, and initialize if found */
+static int simcom_a76xx_probe(struct ofono_modem *modem)
+{
+	struct simcom_a76xx_data *data;
+
+	DBG("");
+
+	data = g_try_new0(struct simcom_a76xx_data, 1);
+	if (data == NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void simcom_a76xx_remove(struct ofono_modem *modem)
+{
+	struct simcom_a76xx_data *data = ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!data)
+		return;
+
+	if (data->at)
+		g_at_chat_unref(data->at);
+
+	if (data->ppp)
+		g_at_chat_unref(data->ppp);
+
+	ofono_modem_set_data(modem, NULL);
+	g_free (data);
+}
+
+static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct simcom_a76xx_data *data = ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (ok)
+		ofono_modem_set_powered(modem, TRUE);
+}
+
+static int open_device(struct ofono_modem *modem, const char *devkey,
+			GAtChat **chatp)
+{
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	GAtChat *chat;
+	const char *device;
+
+	DBG("devkey=%s", devkey);
+
+	device = ofono_modem_get_string(modem, devkey);
+	if (device == NULL)
+		return -EINVAL;
+
+	channel = g_at_tty_open(device, NULL);
+	if (channel == NULL)
+		return -EIO;
+
+	syntax = g_at_syntax_new_gsm_permissive();
+	chat = g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (chat == NULL)
+		return -EIO;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, simcom_a76xx_debug, (void*) devkey);
+
+	*chatp = chat;
+	return 0;
+}
+
+static int simcom_a76xx_enable(struct ofono_modem *modem)
+{
+	struct simcom_a76xx_data *data = ofono_modem_get_data(modem);
+	int err;
+
+	DBG("");
+
+	err = open_device(modem, "AT", &data->at);
+	if (err < 0)
+		return err;
+
+	err = open_device(modem, "PPP", &data->ppp);
+	if (err < 0)
+		return err;
+
+	g_at_chat_set_slave(data->ppp, data->at);
+
+	/* ensure modem is in a known state; verbose on, echo/quiet off */
+	g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+
+	g_at_chat_send(data->at, "AT+CATR=3", NULL, NULL, NULL, NULL);
+
+	/* power up modem */
+	g_at_chat_send(data->at, "AT+CFUN=4", NULL, cfun_set_on_cb,
+								modem, NULL);
+
+	return 0;
+}
+
+static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct simcom_a76xx_data *data = ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(data->ppp);
+	g_at_chat_unref(data->at);
+	data->at = data->ppp = NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int simcom_a76xx_disable(struct ofono_modem *modem)
+{
+	struct simcom_a76xx_data *data = ofono_modem_get_data(modem);
+
+	DBG("");
+
+	/* power down modem */
+	g_at_chat_cancel_all(data->ppp);
+	g_at_chat_cancel_all(data->at);
+	g_at_chat_unregister_all(data->ppp);
+	g_at_chat_unregister_all(data->at);
+	g_at_chat_send(data->at, "AT+CFUN=0", NULL, cfun_set_off_cb,
+								modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_modem_online_cb_t cb = cbd->cb;
+	struct ofono_error error;
+
+	DBG("%p", user_data);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void simcom_a76xx_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct simcom_a76xx_data *data = ofono_modem_get_data(modem);
+	struct cb_data *cbd = cb_data_new(cb, user_data);
+	char const *command = online ? "AT+CFUN=1" : "AT+CFUN=4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (g_at_chat_send(data->at, command, cfun_prefix, set_online_cb, cbd,
+				g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static void simcom_a76xx_pre_sim(struct ofono_modem *modem)
+{
+	struct simcom_a76xx_data *data = ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("");
+
+	ofono_devinfo_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
+	sim = ofono_sim_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
+	ofono_voicecall_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
+
+	if (sim) {
+		ofono_sim_inserted_notify(sim, TRUE);
+	}
+}
+
+static void simcom_a76xx_post_sim(struct ofono_modem *modem)
+{
+	struct simcom_a76xx_data *data = ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs = NULL;
+	struct ofono_gprs_context *gc = NULL;
+
+	DBG("");
+
+	ofono_ussd_create(modem, 0, "atmodem", data->at);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->at);
+	ofono_call_settings_create(modem, 0, "atmodem", data->at);
+	ofono_call_meter_create(modem, 0, "atmodem", data->at);
+	ofono_call_barring_create(modem, 0, "atmodem", data->at);
+	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
+	ofono_phonebook_create(modem, 0, "atmodem", data->at);
+	ofono_radio_settings_create(modem, 0, "simcommodem", data->at);
+
+	gprs = ofono_gprs_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
+	gc = ofono_gprs_context_create(modem, 0, "atmodem", data->ppp);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+
+	mw = ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static void simcom_a76xx_post_online(struct ofono_modem *modem)
+{
+	struct simcom_a76xx_data *data = ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
+}
+
+static struct ofono_modem_driver simcom_a76xx_driver = {
+	.name			= "simcom_a76xx",
+	.probe			= simcom_a76xx_probe,
+	.remove			= simcom_a76xx_remove,
+	.enable			= simcom_a76xx_enable,
+	.disable		= simcom_a76xx_disable,
+	.set_online		= simcom_a76xx_set_online,
+	.pre_sim		= simcom_a76xx_pre_sim,
+	.post_sim		= simcom_a76xx_post_sim,
+	.post_online	= simcom_a76xx_post_online,
+};
+
+static int simcom_a76xx_init(void)
+{
+	return ofono_modem_driver_register(&simcom_a76xx_driver);
+}
+
+static void simcom_a76xx_exit(void)
+{
+	ofono_modem_driver_unregister(&simcom_a76xx_driver);
+}
+
+OFONO_PLUGIN_DEFINE(simcom_a76xx, "SIMCom A76xx modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, simcom_a76xx_init, simcom_a76xx_exit)
diff --git a/plugins/udevng.c b/plugins/udevng.c
index f6580aba..7fccf670 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1554,6 +1554,59 @@ static gboolean setup_sim7x00(struct modem_info *modem)
 	return TRUE;
 }
 
+static gboolean setup_simcom_a76xx(struct modem_info *modem)
+{
+	const char *diag = NULL, *gps = NULL;
+	const char *mdm = NULL, *ppp = NULL;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list = modem->devices; list; list = list->next) {
+		struct device_info *info = list->data;
+		const char *subsystem =
+				udev_device_get_subsystem(info->udev_device);
+
+		DBG("%s %s %s %s %s %s", info->devnode, info->interface,
+						info->number, info->label,
+						info->sysattr, subsystem);
+
+		/*
+		 * SIMCom a76xx serial port layout:
+		 * 2: DIAG
+		 * 3: NMEA
+		 * 4: AT
+		 * 5: AT/PPP
+		 */
+		if (g_strcmp0(subsystem, "tty") == 0) {
+			if (g_strcmp0(info->interface, "255/0/0") == 0) {
+				if (g_strcmp0(info->number, "02") == 0)
+					diag = info->devnode;
+				else if (g_strcmp0(info->number, "03") == 0)
+					gps = info->devnode;
+				else if (g_strcmp0(info->number, "04") == 0)
+					mdm = info->devnode;
+				else if (g_strcmp0(info->number, "05") == 0)
+					ppp = info->devnode;
+			}
+		}
+	}
+
+	if (mdm == NULL)
+		return FALSE;
+
+	DBG("at=%s ppp=%s gps=%s diag=%s",
+						mdm, ppp, gps, diag);
+
+	ofono_modem_set_driver(modem->modem, "simcom_a76xx");
+
+	ofono_modem_set_string(modem->modem, "Diag", diag);
+	ofono_modem_set_string(modem->modem, "GPS", gps);
+	ofono_modem_set_string(modem->modem, "AT", mdm);
+	ofono_modem_set_string(modem->modem, "PPP", ppp);
+	return TRUE;
+}
+
 static struct {
 	const char *name;
 	gboolean (*setup)(struct modem_info *modem);
@@ -1574,6 +1627,7 @@ static struct {
 	{ "telitqmi",	setup_telitqmi	},
 	{ "simcom",	setup_simcom	},
 	{ "sim7x00",	setup_sim7x00	},
+	{ "simcom_a76xx",	setup_simcom_a76xx	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
 	{ "samsung",	setup_samsung	},
@@ -1951,6 +2005,7 @@ static struct {
 	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "sim7x00",	"option",	"1e0e", "9001"	},
 	{ "sim7x00",	"qmi_wwan",	"1e0e",	"9001"	},
+	{ "simcom_a76xx",	"option",	"1e0e", "9011"	},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
-- 
2.25.1

