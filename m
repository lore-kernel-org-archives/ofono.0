Content-Type: multipart/mixed; boundary="===============4512385796746239162=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 3/4] Add support for Intel xmm7xxx series modems
Date: Wed, 13 Sep 2017 07:58:43 +0530
Message-ID: <1505269724-19622-3-git-send-email-ankit.p.navik@intel.com>
In-Reply-To: <1505269724-19622-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4512385796746239162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds plugin for xmm7xxx series modems
---
 Makefile.am       |   3 +
 plugins/xmm7xxx.c | 399 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 402 insertions(+)
 create mode 100644 plugins/xmm7xxx.c

diff --git a/Makefile.am b/Makefile.am
index c46e85a..070821f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -507,6 +507,9 @@ builtin_sources +=3D plugins/quectel.c
 builtin_modules +=3D ublox
 builtin_sources +=3D plugins/ublox.c
 =

+builtin_modules +=3D xmm7xxx
+builtin_sources +=3D plugins/xmm7xxx.c
+
 if BLUETOOTH
 if BLUEZ4
 builtin_modules +=3D sap
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
new file mode 100644
index 0000000..4443d4c
--- /dev/null
+++ b/plugins/xmm7xxx.c
@@ -0,0 +1,399 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#include <ofono/devinfo.h>
+#include <ofono/netreg.h>
+#include <ofono/sim.h>
+#include <ofono/gprs.h>
+#include <ofono/radio-settings.h>
+#include <ofono/gprs-context.h>
+#include <ofono/stk.h>
+#include <ofono/lte.h>
+
+#include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
+
+static const char *none_prefix[] =3D { NULL };
+static const char *xsimstate_prefix[] =3D { "+XSIMSTATE:", NULL };
+
+struct xmm7xxx_data {
+	GAtChat *chat;		/* AT chat */
+	struct ofono_sim *sim;
+	ofono_bool_t have_sim;
+	ofono_bool_t sms_phonebook_added;
+};
+
+static void xmm7xxx_debug(const char *str, void *user_data)
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
+		g_at_chat_set_debug(chat, xmm7xxx_debug, debug);
+
+	return chat;
+}
+
+static void switch_sim_state_status(struct ofono_modem *modem, int status)
+{
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p, SIM status: %d", modem, status);
+
+	switch (status) {
+	case 0:	/* SIM not inserted */
+	case 9:	/* SIM removed */
+		if (data->have_sim =3D=3D TRUE) {
+			ofono_sim_inserted_notify(data->sim, FALSE);
+			data->have_sim =3D FALSE;
+			data->sms_phonebook_added =3D FALSE;
+		}
+		break;
+	case 2:	/* SIM inserted, PIN verification not needed - READY */
+	case 3:	/* SIM inserted, PIN verified - READY */
+	case 7:
+		if (data->have_sim =3D=3D FALSE) {
+			ofono_sim_inserted_notify(data->sim, TRUE);
+			data->have_sim =3D TRUE;
+		}
+		break;
+	default:
+		ofono_warn("Unknown SIM state %d received", status);
+		break;
+	}
+}
+
+static void xsimstate_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	int status;
+	GAtResultIter iter;
+
+	DBG("%p", modem);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XSIM:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &status);
+
+	DBG("status=3D%d\n", status);
+
+	switch_sim_state_status(modem, status);
+}
+
+static void xsimstate_query_cb(gboolean ok, GAtResult *result,
+						gpointer user_data)
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
+	if (!g_at_result_iter_next(&iter, "+XSIMSTATE:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &mode))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	DBG("mode=3D%d, status=3D%d\n", mode, status);
+
+	switch_sim_state_status(modem, status);
+}
+
+static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (!ok) {
+		g_at_chat_unref(data->chat);
+		data->chat =3D NULL;
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
+	g_at_chat_register(data->chat, "+XSIM:", xsimstate_notify,
+				FALSE, modem, NULL);
+
+	g_at_chat_send(data->chat, "AT+XSIMSTATE=3D1", none_prefix,
+			NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "AT+XSIMSTATE?", xsimstate_prefix,
+			xsimstate_query_cb, modem, NULL);
+}
+
+static int xmm7xxx_enable(struct ofono_modem *modem)
+{
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->chat =3D open_device(modem, "Modem", "Modem: ");
+	if (data->chat =3D=3D NULL)
+		return -EIO;
+
+	/*
+	 * Disable command echo and
+	 * enable the Extended Error Result Codes
+	 */
+	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
+				NULL, NULL, NULL);
+
+	/* Set phone functionality */
+	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
+				cfun_enable_cb, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
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
+static int xmm7xxx_disable(struct ofono_modem *modem)
+{
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_cancel_all(data->chat);
+	g_at_chat_unregister_all(data->chat);
+
+	/* Power down modem */
+	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
+				cfun_disable_cb, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void xmm7xxx_pre_sim(struct ofono_modem *modem)
+{
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_IFX, "atmodem",
+					data->chat);
+}
+
+static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void xmm7xxx_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (g_at_chat_send(data->chat, command, none_prefix,
+					set_online_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static void xmm7xxx_post_sim(struct ofono_modem *modem)
+{
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_lte_create(modem, "atmodem", data->chat);
+	ofono_radio_settings_create(modem, 0, "xmm7modem", data->chat);
+}
+
+static void xmm7xxx_post_online(struct ofono_modem *modem)
+{
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
+
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_IFX, "atmodem",
+					data->chat);
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_XMM, "ifxmodem",
+					data->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+}
+
+static int xmm7xxx_probe(struct ofono_modem *modem)
+{
+	struct xmm7xxx_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct xmm7xxx_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void xmm7xxx_remove(struct ofono_modem *modem)
+{
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	/* Cleanup after hot-unplug */
+	g_at_chat_unref(data->chat);
+
+	g_free(data);
+}
+
+static struct ofono_modem_driver xmm7xxx_driver =3D {
+	.name		=3D "xmm7xxx",
+	.probe		=3D xmm7xxx_probe,
+	.remove		=3D xmm7xxx_remove,
+	.enable		=3D xmm7xxx_enable,
+	.disable	=3D xmm7xxx_disable,
+	.set_online	=3D xmm7xxx_set_online,
+	.pre_sim	=3D xmm7xxx_pre_sim,
+	.post_sim	=3D xmm7xxx_post_sim,
+	.post_online	=3D xmm7xxx_post_online,
+};
+
+static int xmm7xxx_init(void)
+{
+	DBG("");
+
+	return ofono_modem_driver_register(&xmm7xxx_driver);
+}
+
+static void xmm7xxx_exit(void)
+{
+	ofono_modem_driver_unregister(&xmm7xxx_driver);
+}
+
+OFONO_PLUGIN_DEFINE(xmm7xxx, "Intel XMM7xxx driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, xmm7xxx_init, xmm7xxx_exit)
-- =

1.9.1


--===============4512385796746239162==--

