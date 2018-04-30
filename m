Content-Type: multipart/mixed; boundary="===============5738948672724588927=="
MIME-Version: 1.0
From: Bob Ham <bob.ham@puri.sm>
Subject: [PATCH] plugins: Add support for SIM7100E by SIMCom
Date: Mon, 30 Apr 2018 13:56:06 +0000
Message-ID: <20180430135606.22571-1-bob.ham@puri.sm>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5738948672724588927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for the SIM7100E modem.  We add a new "sim7100" plugin
because there's no other AT-based modem that has support for both GPRS
and voice calls.
---
 Makefile.am       |   3 +
 plugins/sim7100.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++
 plugins/udevng.c  |  56 +++++++++-
 3 files changed, 327 insertions(+), 3 deletions(-)
 create mode 100644 plugins/sim7100.c

diff --git a/Makefile.am b/Makefile.am
index a921bd2b..6dee4ce3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -499,6 +499,9 @@ builtin_sources +=3D plugins/samsung.c
 builtin_modules +=3D sim900
 builtin_sources +=3D plugins/sim900.c
 =

+builtin_modules +=3D sim7100
+builtin_sources +=3D plugins/sim7100.c
+
 builtin_modules +=3D connman
 builtin_sources +=3D plugins/connman.c
 =

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
new file mode 100644
index 00000000..7986abf2
--- /dev/null
+++ b/plugins/sim7100.c
@@ -0,0 +1,271 @@
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
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
+
+#include <drivers/atmodem/vendor.h>
+
+struct sim7100_data {
+	GAtChat *at;
+	GAtChat *ppp;
+};
+
+static void sim7100_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+/* Detect hardware, and initialize if found */
+static int sim7100_probe(struct ofono_modem *modem)
+{
+	struct sim7100_data *data;
+
+	DBG("");
+
+	data =3D g_try_new0(struct sim7100_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void sim7100_remove(struct ofono_modem *modem)
+{
+	struct sim7100_data *data =3D ofono_modem_get_data(modem);
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
+static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	if (ok)
+		ofono_modem_set_powered(modem, TRUE);
+}
+
+static int open_device(struct ofono_modem *modem, const char *devkey,
+		       GAtChat **chatp)
+{
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	GAtChat *chat;
+	const char *device;
+
+	DBG("devkey=3D%s", devkey);
+
+	device =3D ofono_modem_get_string(modem, devkey);
+	if (device =3D=3D NULL)
+		return -EINVAL;
+
+	channel =3D g_at_tty_open(device, NULL);
+	if (channel =3D=3D NULL)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return -EIO;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, sim7100_debug, "");
+
+	*chatp =3D chat;
+	return 0;
+}
+
+static int sim7100_enable(struct ofono_modem *modem)
+{
+	struct sim7100_data *data =3D ofono_modem_get_data(modem);
+	int err;
+
+	DBG("");
+
+	err =3D open_device(modem, "AT", &data->at);
+	if (err < 0)
+		return err;
+
+	err =3D open_device(modem, "PPP", &data->ppp);
+	if (err < 0)
+		return err;
+
+	/* ensure modem is in a known state; verbose on, echo/quiet off */
+	g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+
+	/* power up modem */
+	g_at_chat_send(data->at, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem, NULL=
);
+
+	return 0;
+}
+
+static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim7100_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(data->ppp);
+	g_at_chat_unref(data->at);
+	data->at =3D data->ppp =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int sim7100_disable(struct ofono_modem *modem)
+{
+	struct sim7100_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	/* power down modem */
+	g_at_chat_cancel_all(data->ppp);
+	g_at_chat_cancel_all(data->at);
+	g_at_chat_unregister_all(data->ppp);
+	g_at_chat_unregister_all(data->at);
+	g_at_chat_send(data->at, "AT+CFUN=3D0", NULL, cfun_set_off_cb, modem, NUL=
L);
+
+	return -EINPROGRESS;
+}
+
+static void sim7100_pre_sim(struct ofono_modem *modem)
+{
+	struct sim7100_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("");
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->at);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->at);
+	ofono_voicecall_create(modem, 0, "atmodem", data->at);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void sim7100_post_sim(struct ofono_modem *modem)
+{
+	struct sim7100_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs =3D NULL;
+	struct ofono_gprs_context *gc =3D NULL;
+
+	DBG("");
+
+	ofono_ussd_create(modem, 0, "atmodem", data->at);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->at);
+	ofono_call_settings_create(modem, 0, "atmodem", data->at);
+	ofono_netreg_create(modem, 0, "atmodem", data->at);
+	ofono_call_meter_create(modem, 0, "atmodem", data->at);
+	ofono_call_barring_create(modem, 0, "atmodem", data->at);
+	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
+	ofono_phonebook_create(modem, 0, "atmodem", data->at);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->at);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->ppp);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver sim7100_driver =3D {
+	.name		=3D "sim7100",
+	.probe		=3D sim7100_probe,
+	.remove		=3D sim7100_remove,
+	.enable		=3D sim7100_enable,
+	.disable	=3D sim7100_disable,
+	.pre_sim	=3D sim7100_pre_sim,
+	.post_sim	=3D sim7100_post_sim,
+};
+
+static int sim7100_init(void)
+{
+	return ofono_modem_driver_register(&sim7100_driver);
+}
+
+static void sim7100_exit(void)
+{
+	ofono_modem_driver_unregister(&sim7100_driver);
+}
+
+OFONO_PLUGIN_DEFINE(sim7100, "SIMCom SIM7100E modem driver", VERSION,
+		    OFONO_PLUGIN_PRIORITY_DEFAULT, sim7100_init, sim7100_exit)
diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff5d41af..cd56fd56 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -710,7 +710,7 @@ static gboolean setup_telitqmi(struct modem_info *modem)
 	return TRUE;
 }
 =

-static gboolean setup_simcom(struct modem_info *modem)
+static gboolean setup_sim900(struct modem_info *modem)
 {
 	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *diag =3D NULL;
 	GSList *list;
@@ -1213,6 +1213,54 @@ static gboolean setup_xmm7xxx(struct modem_info *mod=
em)
 	return TRUE;
 }
 =

+static gboolean setup_sim7100(struct modem_info *modem)
+{
+	const char *at =3D NULL, *ppp =3D NULL, *gps =3D NULL, *diag =3D NULL, *a=
udio =3D NULL;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s", info->devnode, info->number);
+
+		/*
+		 * Serial port layout:
+		 * 0: QCDM/DIAG
+		 * 1: NMEA
+		 * 2: AT
+		 * 3: AT/PPP
+		 * 4: audio
+		 *
+		 * -- https://www.spinics.net/lists/linux-usb/msg135728.html
+		 */
+		if (g_strcmp0(info->number, "00") =3D=3D 0)
+			diag =3D info->devnode;
+		else if (g_strcmp0(info->number, "01") =3D=3D 0)
+			gps =3D info->devnode;
+		else if (g_strcmp0(info->number, "02") =3D=3D 0)
+			at =3D info->devnode;
+		else if (g_strcmp0(info->number, "03") =3D=3D 0)
+			ppp =3D info->devnode;
+		else if (g_strcmp0(info->number, "04") =3D=3D 0)
+			audio =3D info->devnode;
+	}
+
+	if (at =3D=3D NULL)
+		return FALSE;
+
+	DBG("at=3D%s ppp=3D%s gps=3D%s diag=3D%s, audio=3D%s", at, ppp, gps, diag=
, audio);
+
+	ofono_modem_set_string(modem->modem, "AT", at);
+	ofono_modem_set_string(modem->modem, "PPP", ppp);
+	ofono_modem_set_string(modem->modem, "GPS", gps);
+	ofono_modem_set_string(modem->modem, "Diag", diag);
+	ofono_modem_set_string(modem->modem, "Audio", audio);
+
+	return TRUE;
+}
+
 static struct {
 	const char *name;
 	gboolean (*setup)(struct modem_info *modem);
@@ -1232,7 +1280,8 @@ static struct {
 	{ "nokia",	setup_nokia	},
 	{ "telit",	setup_telit,	"device/interface"	},
 	{ "telitqmi",	setup_telitqmi	},
-	{ "simcom",	setup_simcom	},
+	{ "sim900",	setup_sim900	},
+	{ "sim7100",	setup_sim7100	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
 	{ "samsung",	setup_samsung	},
@@ -1596,7 +1645,8 @@ static struct {
 	{ "alcatel",	"option",	"1bbb", "0017"	},
 	{ "novatel",	"option",	"1410"		},
 	{ "zte",	"option",	"19d2"		},
-	{ "simcom",	"option",	"05c6", "9000"	},
+	{ "sim900",	"option",	"05c6", "9000"	},
+	{ "sim7100",	"option",	"1e0e", "9001"	},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
-- =

2.17.0


--===============5738948672724588927==--

