Content-Type: multipart/mixed; boundary="===============4255898781767300243=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] Add Palm Pre plugin
Date: Tue, 10 Nov 2009 07:30:23 +0100
Message-ID: <1257834623-22438-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4255898781767300243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    3 +
 plugins/modemconf.c |    3 +-
 plugins/palmpre.c   |  219 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 224 insertions(+), 1 deletions(-)
 create mode 100644 plugins/palmpre.c

diff --git a/Makefile.am b/Makefile.am
index c3e06b4..0e08349 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -168,6 +168,9 @@ builtin_sources +=3D plugins/novatel.c
 =

 builtin_modules +=3D hfp
 builtin_sources +=3D plugins/hfp.c
+
+builtin_modules +=3D palmpre
+builtin_sources +=3D plugins/palmpre.c
 endif
 =

 if MAINTAINER_MODE
diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index 4b66590..39a62b8 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -127,7 +127,8 @@ static struct ofono_modem *create_modem(GKeyFile *keyfi=
le, const char *group)
 =

 	if (!g_strcmp0(driver, "atgen") || !g_strcmp0(driver, "g1") ||
 						!g_strcmp0(driver, "calypso") ||
-						!g_strcmp0(driver, "hfp"))
+						!g_strcmp0(driver, "hfp") ||
+						!g_strcmp0(driver, "palmpre"))
 		set_device(modem, keyfile, group);
 =

 	g_free(driver);
diff --git a/plugins/palmpre.c b/plugins/palmpre.c
new file mode 100644
index 0000000..37cb7b6
--- /dev/null
+++ b/plugins/palmpre.c
@@ -0,0 +1,219 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
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
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+#include <ofono/message-waiting.h>
+#include <ofono/netreg.h>
+#include <ofono/sim.h>
+#include <ofono/phonebook.h>
+#include <ofono/voicecall.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+
+#include <drivers/atmodem/vendor.h>
+
+struct palmpre_data {
+	GAtChat *chat;
+};
+
+static int palmpre_probe(struct ofono_modem *modem)
+{
+	struct palmpre_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct palmpre_data, 1);
+	if (!data)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void palmpre_remove(struct ofono_modem *modem)
+{
+	struct palmpre_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_free(data);
+	ofono_modem_set_data(modem, NULL);
+}
+
+static void palmpre_debug(const char *str, void *user_data)
+{
+	ofono_info("%s", str);
+}
+
+static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	ofono_modem_set_powered(modem, ok);
+}
+
+static int palmpre_enable(struct ofono_modem *modem)
+{
+	struct palmpre_data *data =3D ofono_modem_get_data(modem);
+	GIOChannel *io;
+	GAtSyntax *syntax;
+	const char *device;
+	GHashTable *options;
+
+	DBG("%p", modem);
+
+	device =3D ofono_modem_get_string(modem, "Device");
+	if (!device)
+		device =3D "/dev/modem0";
+
+	options =3D g_hash_table_new(g_str_hash, g_str_equal);
+	if (!options)
+		return -ENOMEM;
+
+	g_hash_table_insert(options, "Baud", "115200");
+
+	io =3D g_at_tty_open(device, options);
+	g_hash_table_destroy(options);
+
+	if (!io)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	data->chat =3D g_at_chat_new(io, syntax);
+	g_io_channel_unref(io);
+	g_at_syntax_unref(syntax);
+
+	if (!data->chat)
+		return -ENOMEM;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->chat, palmpre_debug, NULL);
+
+	/* Ensure terminal is in a known state */
+	g_at_chat_send(data->chat, "ATZ E0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+
+	/* Power modem up */
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
+			cfun_set_on_cb, modem, NULL);
+
+	return 0;
+}
+
+static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	GAtChat *chat =3D user_data;
+
+	DBG("");
+
+	g_at_chat_unref(chat);
+}
+
+static int palmpre_disable(struct ofono_modem *modem)
+{
+	struct palmpre_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	/* Power modem down */
+	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL,
+			cfun_set_off_cb, data->chat, NULL);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	data->chat =3D NULL;
+
+	return 0;
+}
+
+static void palmpre_pre_sim(struct ofono_modem *modem)
+{
+	struct palmpre_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
+	ofono_sim_create(modem, OFONO_VENDOR_MSM, "atmodem", data->chat);
+	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+}
+
+static void palmpre_post_sim(struct ofono_modem *modem)
+{
+	struct palmpre_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, 0, "atmodem", data->chat);
+	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver palmpre_driver =3D {
+	.name		=3D "palmpre",
+	.probe		=3D palmpre_probe,
+	.remove		=3D palmpre_remove,
+	.enable		=3D palmpre_enable,
+	.disable	=3D palmpre_disable,
+	.pre_sim	=3D palmpre_pre_sim,
+	.post_sim	=3D palmpre_post_sim
+};
+
+static int palmpre_init(void)
+{
+	return ofono_modem_driver_register(&palmpre_driver);
+}
+
+static void palmpre_exit(void)
+{
+	ofono_modem_driver_unregister(&palmpre_driver);
+}
+
+OFONO_PLUGIN_DEFINE(palmpre, "Palm Pre driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, palmpre_init, palmpre_exit)
-- =

1.6.1


--===============4255898781767300243==--

