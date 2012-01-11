Content-Type: multipart/mixed; boundary="===============0264443580458884417=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH v4 1/3] SIMCOM SIM900 module support
Date: Wed, 11 Jan 2012 17:59:01 +0400
Message-ID: <1326290343-21973-1-git-send-email-r.r.zaripov@gmail.com>
In-Reply-To: <4EFB3BA1.9060805@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0264443580458884417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

This patch add support for SIM900 GSM module
http://wm.sim.com/Sim/FrontShow_en/wireless/detail.aspx?cid=3D6&nid=3D770
---
 Makefile.am      |    3 +
 plugins/sim900.c |  261 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 264 insertions(+), 0 deletions(-)
 create mode 100644 plugins/sim900.c

v4: Removed CNMI and CMGF commands in sim900_enable.
Calling ofono_netreg_create moved in post_online.
ofono_modem_set_powered(modem, FALSE) handled in sim900_disable by calling =
cfun_disable.

diff --git a/Makefile.am b/Makefile.am
index 6ef8549..64a7070 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -346,6 +346,9 @@ builtin_sources +=3D plugins/speedupcdma.c
 builtin_modules +=3D samsung
 builtin_sources +=3D plugins/samsung.c
 =

+builtin_modules +=3D sim900
+builtin_sources +=3D plugins/sim900.c
+
 if BLUETOOTH
 builtin_modules +=3D bluetooth
 builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
diff --git a/plugins/sim900.c b/plugins/sim900.c
new file mode 100644
index 0000000..68bb0da
--- /dev/null
+++ b/plugins/sim900.c
@@ -0,0 +1,261 @@
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
+#include <ofono/sms.h>
+#include <ofono/ussd.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/phonebook.h>
+#include <ofono/history.h>
+#include <ofono/log.h>
+
+#include <drivers/atmodem/vendor.h>
+
+static const char *none_prefix[] =3D { NULL };
+
+struct sim900_data {
+	GAtChat *modem;
+};
+
+static int sim900_probe(struct ofono_modem *modem)
+{
+	struct sim900_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct sim900_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void sim900_remove(struct ofono_modem *modem)
+{
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_at_chat_unref(data->modem);
+
+	g_free(data);
+}
+
+static void sim900_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static GAtChat *open_device(struct ofono_modem *modem,
+			    const char *key, char *debug)
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
+	g_hash_table_insert(options, "Parity", "none");
+	g_hash_table_insert(options, "StopBits", "1");
+	g_hash_table_insert(options, "DataBits", "8");
+	g_hash_table_insert(options, "XonXoff", "off");
+	g_hash_table_insert(options, "Local", "off");
+	g_hash_table_insert(options, "RtsCts", "off");
+
+	channel =3D g_at_tty_open(device, options);
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
+		g_at_chat_set_debug(chat, sim900_debug, debug);
+
+	return chat;
+}
+
+static void cfun_enable(gboolean ok, GAtResult * result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!ok) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+	}
+
+	ofono_modem_set_powered(modem, ok);
+}
+
+static int sim900_enable(struct ofono_modem *modem)
+{
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->modem =3D open_device(modem, "Device", "Device: ");
+	if (data->modem =3D=3D NULL) {
+		DBG("return -EINVAL");
+		return -EINVAL;
+	}
+
+	g_at_chat_send(data->modem, "ATE0", NULL, NULL, NULL, NULL);
+
+	/* For obtain correct sms service number */
+	g_at_chat_send(data->modem, "AT+CSCS=3D\"GSM\"", NULL, =

+			NULL, NULL, NULL);
+
+	g_at_chat_send(data->modem, "AT+CFUN=3D1", none_prefix,
+			cfun_enable, modem, NULL); =

+
+	return -EINPROGRESS;
+}
+
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+        struct ofono_modem *modem =3D user_data;
+        struct sim900_data *data =3D ofono_modem_get_data(modem);
+
+        DBG("");
+
+        g_at_chat_unref(data->modem);
+        data->modem =3D NULL;
+
+        if (ok)
+                ofono_modem_set_powered(modem, FALSE);
+}
+
+static int sim900_disable(struct ofono_modem *modem)
+{
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_cancel_all(data->modem);
+	g_at_chat_unregister_all(data->modem);
+
+	g_at_chat_send(data->modem, "AT+CFUN=3D4", none_prefix,
+		cfun_disable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void sim900_pre_sim(struct ofono_modem *modem)
+{
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->modem);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->modem);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void sim900_post_sim(struct ofono_modem *modem)
+{
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", data->modem);
+
+	ofono_sms_create(modem, 0, "atmodem", data->modem);
+}
+
+static void sim900_post_online(struct ofono_modem *modem)
+{
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+	=

+	ofono_netreg_create(modem, OFONO_VENDOR_NOKIA, "atmodem", data->modem);
+}
+
+static struct ofono_modem_driver sim900_driver =3D {
+	.name =3D "sim900",
+	.probe =3D sim900_probe,
+	.remove =3D sim900_remove,
+	.enable =3D sim900_enable,
+	.disable =3D sim900_disable,
+	.pre_sim =3D sim900_pre_sim,
+	.post_sim =3D sim900_post_sim,
+	.post_online =3D sim900_post_online,
+};
+
+static int sim900_init(void)
+{
+	return ofono_modem_driver_register(&sim900_driver);
+}
+
+static void sim900_exit(void)
+{
+	ofono_modem_driver_unregister(&sim900_driver);
+}
+
+OFONO_PLUGIN_DEFINE(sim900, "SIM900 modem driver", VERSION,
+		    OFONO_PLUGIN_PRIORITY_DEFAULT, sim900_init, sim900_exit)
-- =

1.7.7.3


--===============0264443580458884417==--

