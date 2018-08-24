Content-Type: multipart/mixed; boundary="===============3688269641351554298=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [RFC] m95: Add driver for Quectel M95 modem
Date: Fri, 24 Aug 2018 13:34:20 +0200
Message-ID: <20180824113420.9919-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3688269641351554298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So far the driver is only tested with GPRS.

The modem uses GSM 07.10 multiplexing, which breaks when changing
functional modes (i.e. going from CFUN=3D4 to CFUN=3D1), the driver doesn't
implement online/offline states. It does support disabling the device to
save power though, but users must go through the full setup procedure to
enable the device again.
---
 Makefile.am      |   3 +
 plugins/m95.c    | 492 +++++++++++++++++++++++++++++++++++++++++++++++
 plugins/udevng.c |   1 +
 3 files changed, 496 insertions(+)
 create mode 100644 plugins/m95.c

diff --git a/Makefile.am b/Makefile.am
index 6dee4ce3..6fe4258a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -511,6 +511,9 @@ builtin_sources +=3D plugins/telit.c
 builtin_modules +=3D quectel
 builtin_sources +=3D plugins/quectel.c
 =

+builtin_modules +=3D m95
+builtin_sources +=3D plugins/m95.c
+
 builtin_modules +=3D ublox
 builtin_sources +=3D plugins/ublox.c
 =

diff --git a/plugins/m95.c b/plugins/m95.c
new file mode 100644
index 00000000..32746996
--- /dev/null
+++ b/plugins/m95.c
@@ -0,0 +1,492 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2018  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+#include <gatmux.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+#include <ofono/netreg.h>
+#include <ofono/sim.h>
+#include <ofono/sms.h>
+#include <ofono/ussd.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/phonebook.h>
+#include <ofono/history.h>
+#include <ofono/log.h>
+#include <ofono/voicecall.h>
+#include <ofono/call-volume.h>
+#include <drivers/atmodem/vendor.h>
+
+#define NUM_DLC 5
+
+#define VOICE_DLC   0
+#define NETREG_DLC  1
+#define SMS_DLC     2
+#define GPRS_DLC    3
+#define SETUP_DLC   4
+
+static char *dlc_prefixes[NUM_DLC] =3D {"Voice: ", "Net: ", "SMS: ",
+				      "GPRS: " , "Setup: "};
+
+static const char *reset_prefix[]   =3D {"+CFUN:", NULL};
+static const char *enable_prefix[]  =3D {"+CPIN:", NULL};
+
+struct m95_data {
+	GIOChannel *tty;
+	GAtMux *mux;
+	GAtChat *dlcs[NUM_DLC];
+	guint cfun_reset;
+	guint cfun_enable;
+	guint cfun_disable_timeout;
+};
+
+static int m95_probe(struct ofono_modem *modem)
+{
+	struct m95_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct m95_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void m95_remove(struct ofono_modem *modem)
+{
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_free(data);
+}
+
+static void m95_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static GAtChat *open_device(struct ofono_modem *modem,
+			const char *key, char *debug)
+{
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+	const char *device;
+	GAtSyntax *syntax;
+	GAtChat *chat;
+	GHashTable *options;
+
+	device =3D ofono_modem_get_string(modem, key);
+	if (device =3D=3D NULL)
+		return NULL;
+
+	DBG("%s %s", key, device);
+
+	options =3D g_hash_table_new(g_str_hash, g_str_equal);
+	if (options =3D=3D NULL)
+		return NULL;
+
+	g_hash_table_insert(options, "Baud", "115200");
+	g_hash_table_insert(options, "Parity", "none");
+	g_hash_table_insert(options, "StopBits", "1");
+	g_hash_table_insert(options, "DataBits", "8");
+	g_hash_table_insert(options, "XonXoff", "off");
+	g_hash_table_insert(options, "Local", "off");
+	g_hash_table_insert(options, "RtsCts", "off");
+	g_hash_table_insert(options, "Read", "on");
+
+	/* open serial device */
+	data->tty =3D g_at_tty_open(device, options);
+	g_hash_table_destroy(options);
+
+	if (data->tty =3D=3D NULL)
+		return NULL;
+
+	/* create AT chat instance */
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(data->tty, syntax);
+	g_at_syntax_unref(syntax);
+
+	if (chat =3D=3D NULL) {
+		g_io_channel_unref(data->tty);
+		data->tty =3D NULL;
+
+		return NULL;
+	}
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, m95_debug, debug);
+
+	return chat;
+}
+
+static GAtChat *create_chat(GIOChannel *channel, struct ofono_modem *modem,
+			    char *debug)
+{
+	GAtSyntax *syntax;
+	GAtChat *chat;
+
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsmv1();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, m95_debug, debug);
+
+	return chat;
+}
+
+static void shutdown_device(struct m95_data *data)
+{
+	int i;
+
+	for (i =3D 0; i < NUM_DLC; i++) {
+		if (data->dlcs[i] =3D=3D NULL)
+			continue;
+
+		DBG("clean AT chat channel %i", i);
+		g_at_chat_cancel_all(data->dlcs[i]);
+		g_at_chat_unregister_all(data->dlcs[i]);
+		g_at_chat_unref(data->dlcs[i]);
+		data->dlcs[i] =3D NULL;
+	}
+
+	if (data->mux) {
+		DBG("clean mux instance");
+		g_at_mux_shutdown(data->mux);
+		g_at_mux_unref(data->mux);
+		data->mux =3D NULL;
+	}
+
+	if (data->tty) {
+		DBG("clean tty io instance");
+		g_io_channel_unref(data->tty);
+		data->tty =3D NULL;
+	}
+}
+
+static void setup_internal_mux(struct ofono_modem *modem)
+{
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+	int i;
+
+	DBG("");
+
+	/* prepare the multiplexing instance */
+	data->mux =3D g_at_mux_new_gsm0710_basic(data->tty, 127);
+	if (data->mux =3D=3D NULL)
+		goto error;
+
+	if (getenv("OFONO_MUX_DEBUG"))
+		g_at_mux_set_debug(data->mux, m95_debug, "MUX: ");
+
+	if (!g_at_mux_start(data->mux)) {
+		g_at_mux_shutdown(data->mux);
+		g_at_mux_unref(data->mux);
+		goto error;
+	}
+
+	/* create multiplexing channels for gprs, net, voice, text, and
+	 * control */
+	for (i =3D 0; i < NUM_DLC; i++) {
+		GIOChannel *channel =3D g_at_mux_create_channel(data->mux);
+
+		data->dlcs[i] =3D create_chat(channel, modem, dlc_prefixes[i]);
+		if (data->dlcs[i] =3D=3D NULL) {
+			ofono_error("Failed to create channel");
+			goto error;
+		}
+
+		g_io_channel_unref(channel);
+	}
+
+	ofono_modem_set_powered(modem, TRUE);
+
+	return;
+
+error:
+	shutdown_device(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static void mux_setup_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!ok)
+		goto error;
+
+	/* free the initial setup channel, as it is going to be created
+	 * using multiplexing */
+	g_at_chat_unref(data->dlcs[SETUP_DLC]);
+	data->dlcs[SETUP_DLC] =3D NULL;
+
+	/* setup multiplexing */
+	setup_internal_mux(modem);
+
+	return;
+
+error:
+	shutdown_device(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static void cfun_enable(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+
+	DBG("%p", modem);
+
+	g_at_result_iter_init(&iter, result);
+	if (!g_at_result_iter_next(&iter, enable_prefix[0]))
+		return;
+
+	/* remove the enable-completed listener */
+	if (data->cfun_enable) {
+		g_at_chat_unregister(data->dlcs[SETUP_DLC], data->cfun_enable);
+		data->cfun_enable =3D 0;
+	}
+
+	/* setup multiplexing */
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CMUX=3D0,0,5,127,10,3,30,10,2",
+		       NULL, mux_setup_cb, modem, NULL);
+}
+
+static void cfun_enable_query(gboolean ok, GAtResult *result,
+			      gpointer user_data)
+{
+	DBG("ok %d", ok);
+
+	if (ok)
+		cfun_enable(result, user_data);
+}
+
+static void cfun_reset(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+
+	DBG("%p", modem);
+
+	g_at_result_iter_init(&iter, result);
+	if (!g_at_result_iter_next(&iter, reset_prefix[0]))
+		return;
+
+	/* remove the reset-completed listener */
+	g_at_chat_unregister(data->dlcs[SETUP_DLC], data->cfun_reset);
+	data->cfun_reset =3D 0;
+
+	/* prepare to enable the modem */
+	g_at_chat_send(data->dlcs[SETUP_DLC], "ATE0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+IFC=3D2,2", NULL, NULL, NULL,
+		       NULL);
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+GMM", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+IPR=3D115200&w", NULL, NULL,
+		       NULL, NULL);
+
+	/* setup a listener to delay multiplex-setup until modem is ready */
+	data->cfun_enable =3D g_at_chat_register(data->dlcs[SETUP_DLC],
+					       "+CPIN:", cfun_enable, FALSE,
+					       modem, NULL);
+
+	/* enable the modem */
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D1", enable_prefix,
+		       cfun_enable_query, modem, NULL);
+}
+
+static void cfun_reset_query(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	DBG("ok %d", ok);
+
+	if (ok)
+		cfun_reset(result, user_data);
+}
+
+static int m95_enable(struct ofono_modem *modem)
+{
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->dlcs[SETUP_DLC] =3D open_device(modem, "Device", "Setup: ");
+	if (data->dlcs[SETUP_DLC] =3D=3D NULL)
+		return -EINVAL;
+
+	/* when issuing the reset below, the modem is not ready until it
+	 * responds with "+CFUN: 0", so set up a listener for this */
+	data->cfun_reset =3D g_at_chat_register(data->dlcs[SETUP_DLC], "+CFUN:",
+					      cfun_reset, FALSE, modem, NULL);
+
+	/* bring the modem into a known state by issuing a reset */
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D4,1", reset_prefix,
+		       cfun_reset_query, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+
+	/* device is now in non-functional mode, so shut down it down */
+	shutdown_device(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static gboolean cfun_disable_timeout(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+
+	/* now put device in non-functional mode */
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D0,1", NULL, cfun_disable,
+		       modem, NULL);
+
+	return FALSE;
+}
+
+static int m95_disable(struct ofono_modem *modem)
+{
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	/* shut down the device to tear down the muxing channels */
+	shutdown_device(data);
+
+	/* reopen device to get a plain AT control channel */
+	data->dlcs[SETUP_DLC] =3D open_device(modem, "Device", "Disable: ");
+	if (data->dlcs[SETUP_DLC] =3D=3D NULL)
+		return -EINVAL;
+
+	/* add a timer to wait for device to drop GSM 07.10 multiplexing */
+	data->cfun_disable_timeout =3D g_timeout_add(500, cfun_disable_timeout,
+						   modem);
+
+	return -EINPROGRESS;
+}
+
+static void m95_pre_sim(struct ofono_modem *modem)
+{
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
+						data->dlcs[VOICE_DLC]);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void m95_post_sim(struct ofono_modem *modem)
+{
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+	ofono_sms_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
+			 data->dlcs[SMS_DLC]);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
+	if (gprs =3D=3D NULL)
+		return;
+
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
+				       data->dlcs[GPRS_DLC]);
+	if (gc)
+		ofono_gprs_add_context(gprs, gc);
+}
+
+static void m95_post_online(struct ofono_modem *modem)
+{
+	struct m95_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
+			    data->dlcs[NETREG_DLC]);
+	ofono_ussd_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+	ofono_voicecall_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+	ofono_call_volume_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+}
+
+static struct ofono_modem_driver m95_driver =3D {
+	.name		=3D "m95",
+	.probe		=3D m95_probe,
+	.remove		=3D m95_remove,
+	.enable		=3D m95_enable,
+	.disable	=3D m95_disable,
+	.pre_sim	=3D m95_pre_sim,
+	.post_sim	=3D m95_post_sim,
+	.post_online	=3D m95_post_online,
+};
+
+static int m95_init(void)
+{
+	return ofono_modem_driver_register(&m95_driver);
+}
+
+static void m95_exit(void)
+{
+	ofono_modem_driver_unregister(&m95_driver);
+}
+
+OFONO_PLUGIN_DEFINE(m95, "Quectel M95 modem driver", VERSION,
+		    OFONO_PLUGIN_PRIORITY_DEFAULT, m95_init, m95_exit)
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 71a70f0b..e58051d4 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1303,6 +1303,7 @@ static struct {
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
+	{ "m95",	setup_serial_modem },
 	{ }
 };
 =

-- =

2.18.0


--===============3688269641351554298==--

