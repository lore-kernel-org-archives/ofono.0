Content-Type: multipart/mixed; boundary="===============0968344830081013422=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v3, Part2, 1/3] nokiacdma: Add plugin and CDMA MO Call Support
Date: Tue, 21 Dec 2010 11:23:28 -0800
Message-ID: <1292959410-6566-2-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0968344830081013422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    3 +
 plugins/nokiacdma.c |  275 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 278 insertions(+), 0 deletions(-)
 create mode 100644 plugins/nokiacdma.c

diff --git a/Makefile.am b/Makefile.am
index 32ded3d..74b6759 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -293,6 +293,9 @@ builtin_sources +=3D plugins/ste.c
 =

 builtin_modules +=3D caif
 builtin_sources +=3D plugins/caif.c
+
+builtin_modules +=3D nokiacdma
+builtin_sources +=3D plugins/nokiacdma.c
 endif
 =

 if MAINTAINER_MODE
diff --git a/plugins/nokiacdma.c b/plugins/nokiacdma.c
new file mode 100644
index 0000000..3cf2de0
--- /dev/null
+++ b/plugins/nokiacdma.c
@@ -0,0 +1,275 @@
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
+	ofono_bool_t online;
+	ofono_bool_t registration_status;
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
+	if (data->chat)
+		g_at_chat_unref(data->chat);
+
+	g_free(data);
+}
+
+static GAtChat *create_port(const char *device)
+{
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	GAtChat *chat;
+
+	channel =3D g_at_tty_open(device, NULL);
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsmv1();
+
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	return chat;
+}
+
+static GAtChat *open_device(struct ofono_modem *modem,
+				const char *key, char *debug)
+{
+	const char *device;
+	GAtChat *chat;
+
+	device =3D ofono_modem_get_string(modem, key);
+	if (device =3D=3D NULL)
+		return NULL;
+
+	DBG("%s %s", key, device);
+
+	chat =3D create_port(device);
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	g_at_chat_add_terminator(chat, "COMMAND NOT SUPPORT", -1, FALSE);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, nokiacdma_debug, debug);
+
+	return chat;
+}
+
+static void nokiacdma_disconnect(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	data->chat =3D open_device(modem, "Device", "CDMA Device: ");
+	if (data->chat =3D=3D NULL)
+		return;
+
+	g_at_chat_set_disconnect_function(data->chat,
+			nokiacdma_disconnect, modem);
+}
+
+/* power up hardware */
+static int nokiacdma_enable(struct ofono_modem *modem)
+{
+	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_boolean(modem, "no_sim_required", TRUE);
+
+	data->chat =3D open_device(modem, "Device", "CDMA Device: ");
+	if (data->chat =3D=3D NULL)
+		return -EINVAL;
+
+	g_at_chat_set_disconnect_function(data->chat,
+			nokiacdma_disconnect, modem);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->chat, nokiacdma_debug,
+				"CDMA Generic: ");
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
+	if (data->chat) {
+		g_at_chat_cancel_all(data->chat);
+		g_at_chat_unregister_all(data->chat);
+		g_at_chat_unref(data->chat);
+		data->chat =3D NULL;
+	}
+
+	return 0;
+}
+
+static void nokiacdma_pre_sim(struct ofono_modem *modem)
+{
+	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_cdma_voicecall_create(modem, 0, "cdmamodem",
+				data->chat);
+}
+
+static void nokiacdma_post_sim(struct ofono_modem *modem)
+{
+}
+
+static gboolean nokiacdma_set_online_cb(gpointer cb_data)
+{
+	struct cb_data *cbd =3D cb_data;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+	g_free(cbd);
+
+	/* do not call again */
+	return FALSE;
+}
+
+static void nokiacdma_set_online(struct ofono_modem *modem, ofono_bool_t o=
nline,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	data->online =3D online;
+
+	/* TODO: Fix this when network registration implemented */
+	if (online)
+		data->registration_status =3D
+		    NETWORK_REGISTRATION_STATUS_REGISTERED;
+
+	nokiacdma_set_online_cb(cbd);
+	return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
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
+	.set_online		=3D nokiacdma_set_online,
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


--===============0968344830081013422==--

