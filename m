Content-Type: multipart/mixed; boundary="===============0905511619951907051=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] speedupcdma: add speedup cdma skeleton plugin
Date: Wed, 20 Jul 2011 11:39:08 +0200
Message-ID: <1311154748-1872-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0905511619951907051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    3 +
 plugins/speedupcdma.c |  207 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 plugins/speedupcdma.c

diff --git a/Makefile.am b/Makefile.am
index a4e6c95..4b72091 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -336,6 +336,9 @@ builtin_sources +=3D plugins/telit.c
 builtin_modules +=3D speedup
 builtin_sources +=3D plugins/speedup.c
 =

+builtin_modules +=3D speedupcdma
+builtin_sources +=3D plugins/speedupcdma.c
+
 if BLUETOOTH
 builtin_modules +=3D bluetooth
 builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
new file mode 100644
index 0000000..3c8f1b1
--- /dev/null
+++ b/plugins/speedupcdma.c
@@ -0,0 +1,207 @@
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
+#include <ofono/cdma-connman.h>
+#include <ofono/log.h>
+
+#include <drivers/atmodem/atutil.h>
+
+static const char *none_prefix[] =3D { NULL };
+
+struct speedupcdma_data {
+	GAtChat *chat;
+};
+
+static void speedupcdma_debug(const char *str, void *data)
+{
+	const char *prefix =3D data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static int speedupcdma_probe(struct ofono_modem *modem)
+{
+	struct speedupcdma_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct speedupcdma_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void speedupcdma_remove(struct ofono_modem *modem)
+{
+	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_at_chat_unref(data->chat);
+
+	g_free(data);
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	if (!ok) {
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static int speedupcdma_enable(struct ofono_modem *modem)
+{
+	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	const char *modem_path;
+
+	modem_path =3D ofono_modem_get_string(modem, "Modem");
+	if (modem_path =3D=3D NULL)
+		return -EINVAL;
+
+	DBG("path is: %s", modem_path);
+
+	channel =3D g_at_tty_open(modem_path, NULL);
+	if (channel =3D=3D NULL)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	data->chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+
+	g_io_channel_unref(channel);
+
+	if (data->chat =3D=3D NULL)
+		return -ENOMEM;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->chat, speedupcdma_debug, "Modem: ");
+
+	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
+						NULL, NULL, NULL);
+
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
+					cfun_enable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int speedupcdma_disable(struct ofono_modem *modem)
+{
+	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
+					cfun_disable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void speedupcdma_pre_sim(struct ofono_modem *modem)
+{
+	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
+}
+
+static void speedupcdma_post_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static void speedupcdma_post_online(struct ofono_modem *modem)
+{
+	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
+}
+
+static struct ofono_modem_driver speedupcdma_driver =3D {
+	.name		=3D "speedupcdma",
+	.probe		=3D speedupcdma_probe,
+	.remove		=3D speedupcdma_remove,
+	.enable		=3D speedupcdma_enable,
+	.disable	=3D speedupcdma_disable,
+	.pre_sim	=3D speedupcdma_pre_sim,
+	.post_sim	=3D speedupcdma_post_sim,
+	.post_online	=3D speedupcdma_post_online,
+};
+
+static int speedupcdma_init(void)
+{
+	return ofono_modem_driver_register(&speedupcdma_driver);
+}
+
+static void speedupcdma_exit(void)
+{
+	ofono_modem_driver_unregister(&speedupcdma_driver);
+}
+
+OFONO_PLUGIN_DEFINE(speedupcdma, "Speedup CDMA modem driver", VERSION,
+				OFONO_PLUGIN_PRIORITY_DEFAULT,
+				speedupcdma_init, speedupcdma_exit)
-- =

1.7.1


--===============0905511619951907051==--

