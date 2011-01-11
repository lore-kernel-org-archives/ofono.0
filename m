Content-Type: multipart/mixed; boundary="===============8639026273293894879=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v5, 3/5] nokiacdma: Add plugin and CDMA MO Call Support
Date: Mon, 10 Jan 2011 17:45:30 -0800
Message-ID: <1294710332-6028-4-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8639026273293894879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    3 +
 plugins/nokiacdma.c |  171 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 174 insertions(+), 0 deletions(-)
 create mode 100644 plugins/nokiacdma.c

diff --git a/Makefile.am b/Makefile.am
index 7bced88..5c9445f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -302,6 +302,9 @@ builtin_sources +=3D plugins/caif.c
 =

 builtin_modules +=3D tc65
 builtin_sources +=3D plugins/tc65.c
+
+builtin_modules +=3D nokiacdma
+builtin_sources +=3D plugins/nokiacdma.c
 endif
 =

 if MAINTAINER_MODE
diff --git a/plugins/nokiacdma.c b/plugins/nokiacdma.c
new file mode 100644
index 0000000..4b11f9d
--- /dev/null
+++ b/plugins/nokiacdma.c
@@ -0,0 +1,171 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
+
+#include "common.h"
+
+struct nokiacdma_data {
+	GAtChat *chat;
+};
+
+static void nokiacdma_debug(const char *str, void *data)
+{
+	const char *prefix =3D data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static int nokiacdma_probe(struct ofono_modem *modem)
+{
+	struct nokiacdma_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct nokiacdma_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void nokiacdma_remove(struct ofono_modem *modem)
+{
+	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
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
+static int nokiacdma_enable(struct ofono_modem *modem)
+{
+	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
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
+	/* TODO: Will need a CDMA AT syntax parser later. Using GSM V1 for now. */
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
+		g_at_chat_set_debug(data->chat, nokiacdma_debug,
+					"CDMA Device: ");
+
+	return 0;
+}
+
+static int nokiacdma_disable(struct ofono_modem *modem)
+{
+	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	return 0;
+}
+
+static void nokiacdma_pre_sim(struct ofono_modem *modem)
+{
+	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_cdma_voicecall_create(modem, 0, "cdmamodem", data->chat);
+}
+
+static void nokiacdma_post_sim(struct ofono_modem *modem)
+{
+}
+
+static void nokiacdma_post_online(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static struct ofono_modem_driver nokiacdma_driver =3D {
+	.name			=3D "nokiacdma",
+	.probe			=3D nokiacdma_probe,
+	.remove			=3D nokiacdma_remove,
+	.enable			=3D nokiacdma_enable,
+	.disable		=3D nokiacdma_disable,
+	.pre_sim		=3D nokiacdma_pre_sim,
+	.post_sim		=3D nokiacdma_post_sim,
+	.post_online		=3D nokiacdma_post_online,
+};
+
+static int nokiacdma_init(void)
+{
+	return ofono_modem_driver_register(&nokiacdma_driver);
+}
+
+static void nokiacdma_exit(void)
+{
+	ofono_modem_driver_unregister(&nokiacdma_driver);
+}
+
+OFONO_PLUGIN_DEFINE(nokiacdma, "Generic CDMA AT Modem", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			nokiacdma_init, nokiacdma_exit)
-- =

1.7.0.4


--===============8639026273293894879==--

