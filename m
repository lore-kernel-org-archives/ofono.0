Content-Type: multipart/mixed; boundary="===============3772344906296463394=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 1/2] Add SpeedUp plugin
Date: Wed, 06 Jul 2011 19:25:58 +0200
Message-ID: <1309973159-4446-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3772344906296463394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am       |    3 +
 plugins/speedup.c |  334 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 337 insertions(+), 0 deletions(-)
 create mode 100644 plugins/speedup.c

diff --git a/Makefile.am b/Makefile.am
index ef6196b..c08e09f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -330,6 +330,9 @@ builtin_sources +=3D plugins/linktop.c
 builtin_modules +=3D telit
 builtin_sources +=3D plugins/telit.c
 =

+builtin_modules +=3D speedup
+builtin_sources +=3D plugins/speedup.c
+
 if BLUETOOTH
 builtin_modules +=3D bluetooth
 builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
diff --git a/plugins/speedup.c b/plugins/speedup.c
new file mode 100644
index 0000000..7e89b6f
--- /dev/null
+++ b/plugins/speedup.c
@@ -0,0 +1,334 @@
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
+#include <stdio.h>
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
+#include <ofono/cbs.h>
+#include <ofono/sms.h>
+#include <ofono/ussd.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/phonebook.h>
+#include <ofono/log.h>
+
+#include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
+
+static const char *none_prefix[] =3D { NULL };
+
+struct speedup_data {
+	GAtChat *modem;
+	GAtChat *aux;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+};
+
+static int speedup_probe(struct ofono_modem *modem)
+{
+	struct speedup_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct speedup_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void speedup_remove(struct ofono_modem *modem)
+{
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_at_chat_unref(data->modem);
+	g_at_chat_unref(data->aux);
+
+	g_free(data);
+}
+
+static void speedup_debug(const char *str, void *user_data)
+{
+        const char *prefix =3D user_data;
+
+        ofono_info("%s%s", prefix, str);
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
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, speedup_debug, debug);
+
+	return chat;
+}
+
+static void speedup_disconnect(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	ofono_gprs_context_remove(data->gc);
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL)
+		return;
+
+	g_at_chat_set_disconnect_function(data->modem,
+						speedup_disconnect, modem);
+
+	ofono_info("Reopened GPRS context channel");
+
+	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+
+	if (data->gprs && data->gc)
+		ofono_gprs_add_context(data->gprs, data->gc);
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	ofono_modem_set_powered(modem, ok);
+}
+
+static int speedup_enable(struct ofono_modem *modem)
+{
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL)
+		return -EINVAL;
+
+	g_at_chat_set_disconnect_function(data->modem,
+						speedup_disconnect, modem);
+
+	data->aux =3D open_device(modem, "Aux", "Aux: ");
+	if (data->aux =3D=3D NULL) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+		return -EIO;
+	}
+
+	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
+						NULL, NULL, NULL);
+
+	g_at_chat_send(data->aux, "AT+CFUN=3D1", none_prefix,
+					cfun_enable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
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
+static int speedup_disable(struct ofono_modem *modem)
+{
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (data->modem) {
+		g_at_chat_cancel_all(data->modem);
+		g_at_chat_unregister_all(data->modem);
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+	}
+
+	if (data->aux =3D=3D NULL)
+		return 0;
+
+	g_at_chat_cancel_all(data->aux);
+	g_at_chat_unregister_all(data->aux);
+	g_at_chat_send(data->aux, "AT+CFUN=3D0", none_prefix,
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
+static void speedup_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+	GAtChat *chat =3D data->aux;
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (chat =3D=3D NULL)
+		goto error;
+
+	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void speedup_pre_sim(struct ofono_modem *modem)
+{
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+				"atmodem", data->aux);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void speedup_post_sim(struct ofono_modem *modem)
+{
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
+
+	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+					"atmodem", data->aux);
+
+	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->aux);
+
+	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+
+	if (data->gprs && data->gc)
+		ofono_gprs_add_context(data->gprs, data->gc);
+}
+
+static void speedup_post_online(struct ofono_modem *modem)
+{
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, OFONO_VENDOR_ZTE, "atmodem", data->aux);
+
+	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+					"atmodem", data->aux);
+	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+					"atmodem", data->aux);
+}
+
+static struct ofono_modem_driver speedup_driver =3D {
+	.name		=3D "speedup",
+	.probe		=3D speedup_probe,
+	.remove		=3D speedup_remove,
+	.enable		=3D speedup_enable,
+	.disable	=3D speedup_disable,
+	.set_online     =3D speedup_set_online,
+	.pre_sim	=3D speedup_pre_sim,
+	.post_sim	=3D speedup_post_sim,
+	.post_online    =3D speedup_post_online,
+};
+
+static int speedup_init(void)
+{
+	return ofono_modem_driver_register(&speedup_driver);
+}
+
+static void speedup_exit(void)
+{
+	ofono_modem_driver_unregister(&speedup_driver);
+}
+
+OFONO_PLUGIN_DEFINE(speedup, "SpeedUp modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, speedup_init, speedup_exit)
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============3772344906296463394==--

