Content-Type: multipart/mixed; boundary="===============1082002177795572171=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2] huaweicdma: Create first draft for plugin huaweicdma
Date: Tue, 12 Jul 2011 12:03:10 +0200
Message-ID: <1310464990-20448-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1310464283-20128-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1082002177795572171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add Intel copyright.
---
 Makefile.am          |    3 +
 plugins/huaweicdma.c |  181 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 184 insertions(+), 0 deletions(-)
 create mode 100644 plugins/huaweicdma.c

diff --git a/Makefile.am b/Makefile.am
index c08e09f..2fa8771 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -294,6 +294,9 @@ builtin_sources +=3D plugins/zte.c
 builtin_modules +=3D huawei
 builtin_sources +=3D plugins/huawei.c
 =

+builtin_modules +=3D huaweicdma
+builtin_sources +=3D plugins/huaweicdma.c
+
 builtin_modules +=3D sierra
 builtin_sources +=3D plugins/sierra.c
 =

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
new file mode 100644
index 0000000..cae53fe
--- /dev/null
+++ b/plugins/huaweicdma.c
@@ -0,0 +1,181 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation. All rights reserved.
+ * Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <errno.h>
+#include <termios.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+
+#include <drivers/atmodem/atutil.h>
+#include <ofono/cdma-voicecall.h>
+#include <ofono/devinfo.h>
+#include <ofono/cdma-connman.h>
+
+#include "common.h"
+
+struct huaweicdma_data {
+	GAtChat *chat;
+};
+
+static void huaweicdma_debug(const char *str, void *data)
+{
+	const char *prefix =3D data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static int huaweicdma_probe(struct ofono_modem *modem)
+{
+	struct huaweicdma_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct huaweicdma_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void huaweicdma_remove(struct ofono_modem *modem)
+{
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
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
+static int huaweicdma_enable(struct ofono_modem *modem)
+{
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	const char *device;
+
+	device =3D ofono_modem_get_string(modem, "Device");
+	if (device =3D=3D NULL)
+		return -EINVAL;
+
+	channel =3D g_at_tty_open(device, NULL);
+	if (channel =3D=3D NULL)
+		return -EIO;
+
+	/*
+	 * TODO: Will need a CDMA AT syntax parser later.
+	 * Using GSM V1 for now.
+	 */
+	syntax =3D g_at_syntax_new_gsmv1();
+
+	data->chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (data->chat =3D=3D NULL)
+		return -ENOMEM;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->chat, huaweicdma_debug,
+					"CDMA Device: ");
+
+	return 0;
+}
+
+static int huaweicdma_disable(struct ofono_modem *modem)
+{
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	return 0;
+}
+
+static void huaweicdma_pre_sim(struct ofono_modem *modem)
+{
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_cdma_voicecall_create(modem, 0, "cdmamodem", data->chat);
+	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
+}
+
+static void huaweicdma_post_sim(struct ofono_modem *modem)
+{
+}
+
+static void huaweicdma_post_online(struct ofono_modem *modem)
+{
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
+}
+
+static struct ofono_modem_driver huaweicdma_driver =3D {
+	.name			=3D "huaweicdma",
+	.probe			=3D huaweicdma_probe,
+	.remove			=3D huaweicdma_remove,
+	.enable			=3D huaweicdma_enable,
+	.disable		=3D huaweicdma_disable,
+	.pre_sim		=3D huaweicdma_pre_sim,
+	.post_sim		=3D huaweicdma_post_sim,
+	.post_online		=3D huaweicdma_post_online,
+};
+
+static int huaweicdma_init(void)
+{
+	return ofono_modem_driver_register(&huaweicdma_driver);
+}
+
+static void huaweicdma_exit(void)
+{
+	ofono_modem_driver_unregister(&huaweicdma_driver);
+}
+
+OFONO_PLUGIN_DEFINE(huaweicdma, "Huawei CDMA AT Modem", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			huaweicdma_init, huaweicdma_exit)
-- =

1.7.1


--===============1082002177795572171==--

