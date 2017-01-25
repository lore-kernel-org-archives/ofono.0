Content-Type: multipart/mixed; boundary="===============3630861079403626825=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 2/4] plugins: support for Telit LE910 V2 modem
Date: Wed, 25 Jan 2017 11:41:26 +0100
Message-ID: <20170125104128.5254-3-gluedig@gmail.com>
In-Reply-To: <20170125104128.5254-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3630861079403626825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LE910 V2 is next generation Telit LTE modem.
It supports 3GPP Rel. 9 LTE Cat. 4 over multiple bands.
Default USB composition uses PID 0x36 and
consists of 6 CDC-ACM serial ports and 1 CDC-NCM network adapter.
---
 Makefile.am       |   3 +
 plugins/le910v2.c | 400 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 403 insertions(+)
 create mode 100644 plugins/le910v2.c

diff --git a/Makefile.am b/Makefile.am
index 2f49027c..72c4fcfc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -501,6 +501,9 @@ builtin_sources +=3D plugins/quectel.c
 builtin_modules +=3D ublox
 builtin_sources +=3D plugins/ublox.c
 =

+builtin_modules +=3D le910v2
+builtin_sources +=3D plugins/le910v2.c
+
 if BLUETOOTH
 if BLUEZ4
 builtin_modules +=3D telit
diff --git a/plugins/le910v2.c b/plugins/le910v2.c
new file mode 100644
index 00000000..e758971d
--- /dev/null
+++ b/plugins/le910v2.c
@@ -0,0 +1,400 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Piotr Haber. All rights reserved.
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
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <termios.h>
+#include <string.h>
+#include <sys/socket.h>
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
+#include <ofono/location-reporting.h>
+#include <ofono/netreg.h>
+#include <ofono/phonebook.h>
+#include <ofono/sim.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/sms.h>
+#include <ofono/ussd.h>
+#include <ofono/voicecall.h>
+
+#include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
+
+static const char *none_prefix[] =3D { NULL };
+static const char *qss_prefix[] =3D { "#QSS:", NULL };
+
+struct le910v2_data {
+	GAtChat *chat;		/* AT chat */
+	GAtChat *modem;		/* Data port */
+	struct ofono_sim *sim;
+	ofono_bool_t have_sim;
+	ofono_bool_t sms_phonebook_added;
+};
+
+static void le910v2_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static GAtChat *open_device(struct ofono_modem *modem,
+				const char *key, char *debug)
+{
+	const char *device;
+	GAtSyntax *syntax;
+	GIOChannel *channel;
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
+	channel =3D g_at_tty_open(device, options);
+	g_hash_table_destroy(options);
+
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, le910v2_debug, debug);
+
+	return chat;
+}
+
+static void switch_sim_state_status(struct ofono_modem *modem, int status)
+{
+	struct le910v2_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p, SIM status: %d", modem, status);
+
+	switch (status) {
+	case 0:	/* SIM not inserted */
+		if (data->have_sim =3D=3D TRUE) {
+			ofono_sim_inserted_notify(data->sim, FALSE);
+			data->have_sim =3D FALSE;
+			data->sms_phonebook_added =3D FALSE;
+		}
+		break;
+	case 1:	/* SIM inserted */
+	case 2:	/* SIM inserted and PIN unlocked */
+		if (data->have_sim =3D=3D FALSE) {
+			ofono_sim_inserted_notify(data->sim, TRUE);
+			data->have_sim =3D TRUE;
+		}
+		break;
+	case 3:	/* SIM inserted, SMS and phonebook ready */
+		if (data->have_sim =3D=3D FALSE) {
+			ofono_sim_inserted_notify(data->sim, TRUE);
+			data->have_sim =3D TRUE;
+		}
+		if (data->sms_phonebook_added =3D=3D FALSE) {
+			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+			ofono_sms_create(modem, 0, "atmodem", data->chat);
+			data->sms_phonebook_added =3D TRUE;
+		}
+		break;
+	default:
+		ofono_warn("Unknown SIM state %d received", status);
+		break;
+	}
+}
+
+static void le910v2_qss_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	int status;
+	GAtResultIter iter;
+
+	DBG("%p", modem);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "#QSS:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &status);
+
+	switch_sim_state_status(modem, status);
+}
+
+static void qss_query_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	int status, mode;
+	GAtResultIter iter;
+
+	DBG("%p", modem);
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "#QSS:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &mode))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	switch_sim_state_status(modem, status);
+}
+
+static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct le910v2_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (!ok) {
+		g_at_chat_unref(data->chat);
+		data->chat =3D NULL;
+
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	/*
+	 * Switch data carrier detect signal off.
+	 * When the DCD is disabled the modem does not hangup anymore
+	 * after the data connection.
+	 */
+	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
+
+	data->have_sim =3D FALSE;
+	data->sms_phonebook_added =3D FALSE;
+
+	ofono_modem_set_powered(modem, TRUE);
+
+	/*
+	 * Tell the modem not to automatically initiate auto-attach
+	 * proceedures on its own.
+	 */
+	g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
+				NULL, NULL, NULL);
+
+	/* Follow sim state */
+	g_at_chat_register(data->chat, "#QSS:", le910v2_qss_notify,
+				FALSE, modem, NULL);
+
+	/* Enable sim state notification */
+	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL);
+
+	g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
+			qss_query_cb, modem, NULL);
+}
+
+static int le910v2_enable(struct ofono_modem *modem)
+{
+	struct le910v2_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL)
+		return -EINVAL;
+
+	data->chat =3D open_device(modem, "Aux", "Aux: ");
+	if (data->chat =3D=3D NULL) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+		return -EIO;
+	}
+
+	/*
+	 * Disable command echo and
+	 * enable the Extended Error Result Codes
+	 */
+	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
+				NULL, NULL, NULL);
+
+	g_at_chat_send(data->modem, "ATE0", none_prefix,
+				NULL, NULL, NULL);
+
+	/* Set phone functionality */
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
+				cfun_enable_cb, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct le910v2_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int le910v2_disable(struct ofono_modem *modem)
+{
+	struct le910v2_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_cancel_all(data->modem);
+	g_at_chat_unregister_all(data->modem);
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	g_at_chat_cancel_all(data->chat);
+	g_at_chat_unregister_all(data->chat);
+
+	/* Power down modem */
+	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
+				cfun_disable_cb, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void le910v2_pre_sim(struct ofono_modem *modem)
+{
+	struct le910v2_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT, "atmodem",
+					data->chat);
+}
+
+static void le910v2_post_online(struct ofono_modem *modem)
+{
+	struct le910v2_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
+					data->chat);
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_TELIT, "telitncmmode=
m",
+					data->modem);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+}
+
+static int le910v2_probe(struct ofono_modem *modem)
+{
+	struct le910v2_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct le910v2_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void le910v2_remove(struct ofono_modem *modem)
+{
+	struct le910v2_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	/* Cleanup after hot-unplug */
+	g_at_chat_unref(data->chat);
+	g_at_chat_unref(data->modem);
+
+	g_free(data);
+}
+
+static struct ofono_modem_driver le910v2_driver =3D {
+	.name		=3D "le910v2",
+	.probe		=3D le910v2_probe,
+	.remove		=3D le910v2_remove,
+	.enable		=3D le910v2_enable,
+	.disable	=3D le910v2_disable,
+	.pre_sim	=3D le910v2_pre_sim,
+	.post_online	=3D le910v2_post_online,
+};
+
+static int le910v2_init(void)
+{
+	DBG("");
+
+	return ofono_modem_driver_register(&le910v2_driver);
+}
+
+static void le910v2_exit(void)
+{
+	ofono_modem_driver_unregister(&le910v2_driver);
+}
+
+OFONO_PLUGIN_DEFINE(le910v2, "Telit LE910 V2 driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, le910v2_init, le910v2_exit)
-- =

2.11.0


--===============3630861079403626825==--

