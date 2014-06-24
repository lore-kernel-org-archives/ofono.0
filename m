Content-Type: multipart/mixed; boundary="===============7434546014290566969=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 3/4] plugins: add a new driver for Quectel UC15 modules
Date: Tue, 24 Jun 2014 12:08:41 +0200
Message-ID: <1403604522-22645-4-git-send-email-philip@paeps.cx>
In-Reply-To: <1403604522-22645-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7434546014290566969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am       |    3 +
 plugins/quectel.c |  335 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 338 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index cd83ef4..aee28de 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -420,6 +420,9 @@ builtin_sources +=3D plugins/connman.c
 builtin_modules +=3D he910
 builtin_sources +=3D plugins/he910.c
 =

+builtin_modules +=3D quectel
+builtin_sources +=3D plugins/quectel.c
+
 if BLUETOOTH
 if BLUEZ4
 builtin_modules +=3D bluez4
diff --git a/plugins/quectel.c b/plugins/quectel.c
new file mode 100644
index 0000000..d665cbe
--- /dev/null
+++ b/plugins/quectel.c
@@ -0,0 +1,335 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+#include <ofono/netreg.h>
+#include <ofono/sim.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/log.h>
+
+#include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
+
+struct quectel_data {
+	GAtChat *modem;
+	GAtChat *aux;
+	guint enable_timer;
+	guint enable_tries;
+};
+
+#define RESET_DELAY 3 /* seconds */
+#define MAX_RETRIES 5 /* number of attempts */
+
+static void quectel_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static int quectel_probe(struct ofono_modem *modem)
+{
+	struct quectel_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct quectel_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void quectel_remove(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (data->enable_timer)
+		g_source_remove(data->enable_timer);
+
+	ofono_modem_set_data(modem, NULL);
+	g_at_chat_unref(data->aux);
+	g_free(data);
+}
+
+static GAtChat *open_device(struct ofono_modem *modem,
+				const char *key, char *debug)
+{
+	const char *device;
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	GAtChat *chat;
+
+	device =3D ofono_modem_get_string(modem, key);
+	if (device =3D=3D NULL)
+		return NULL;
+
+	DBG("%s %s", key, device);
+
+	channel =3D g_at_tty_open(device, NULL);
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, quectel_debug, debug);
+
+	return chat;
+}
+
+static void verify_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	if (ok) {
+		ofono_modem_set_powered(modem, TRUE);
+		g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
+		g_at_chat_send(data->aux, "AT&C0", NULL, NULL, NULL, NULL);
+	}
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("ok %d (tried %d times)", (int)ok, data->enable_tries);
+
+	if (!ok) {
+		if (data->enable_tries > MAX_RETRIES) {
+			g_at_chat_unref(data->aux);
+			data->aux =3D NULL;
+			g_at_chat_unref(data->modem);
+			data->modem =3D NULL;
+			ofono_modem_set_powered(modem, FALSE);
+			DBG("modem won't enable - giving up");
+		}
+		goto retry;
+	}
+
+	g_at_chat_send(data->aux, "AT+CPIN?", NULL, verify_enable,
+					modem, NULL);
+retry:
+	data->enable_tries++;
+}
+
+static gboolean quectel_start(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	if (ofono_modem_get_powered(modem) =3D=3D FALSE) {
+		g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL, cfun_enable,
+					modem, NULL);
+		return TRUE;
+	}
+
+	data->enable_timer =3D 0;
+
+	return FALSE;
+}
+
+static int quectel_enable(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL)
+		return -EINVAL;
+
+	data->aux =3D open_device(modem, "Aux", "Aux: ");
+	if (data->aux =3D=3D NULL) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+		return -EIO;
+	}
+	g_at_chat_set_slave(data->modem, data->aux);
+
+	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+
+	/* Give the modem a bit more time to power up completely. */
+	data->enable_tries =3D 0;
+	data->enable_timer =3D g_timeout_add_seconds(RESET_DELAY,
+					quectel_start, modem);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int quectel_disable(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	/* Prevent a race with cfun_start() retries. */
+	if (data->enable_timer)
+		g_source_remove(data->enable_timer);
+
+	g_at_chat_cancel_all(data->modem);
+	g_at_chat_unregister_all(data->modem);
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	g_at_chat_cancel_all(data->aux);
+	g_at_chat_unregister_all(data->aux);
+
+	g_at_chat_send(data->aux, "AT+CFUN=3D0", NULL,
+					cfun_disable, modem, NULL);
+
+	return -EINPROGRESS;
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
+static void quectel_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (g_at_chat_send(data->aux, command, NULL, set_online_cb,
+					cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static void quectel_pre_sim(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
+					data->aux);
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void quectel_post_sim(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
+					data->aux);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+}
+
+static void quectel_post_online(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_netreg_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
+					data->aux);
+}
+
+static struct ofono_modem_driver quectel_driver =3D {
+	.name			=3D "quectel",
+	.probe			=3D quectel_probe,
+	.remove			=3D quectel_remove,
+	.enable			=3D quectel_enable,
+	.disable		=3D quectel_disable,
+	.set_online		=3D quectel_set_online,
+	.pre_sim		=3D quectel_pre_sim,
+	.post_sim		=3D quectel_post_sim,
+	.post_online		=3D quectel_post_online,
+};
+
+static int quectel_init(void)
+{
+	return ofono_modem_driver_register(&quectel_driver);
+}
+
+static void quectel_exit(void)
+{
+	ofono_modem_driver_unregister(&quectel_driver);
+}
+
+OFONO_PLUGIN_DEFINE(quectel, "Quectel driver", VERSION,
+    OFONO_PLUGIN_PRIORITY_DEFAULT, quectel_init, quectel_exit)
-- =

1.7.10.4


--===============7434546014290566969==--

