Content-Type: multipart/mixed; boundary="===============8004111311189760439=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v2 6/9] cdmagen: Add CDMA MO Call Support
Date: Fri, 17 Dec 2010 15:11:18 -0800
Message-ID: <1292627481-9109-7-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8004111311189760439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am       |    3 +
 plugins/cdmagen.c |  274 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 277 insertions(+), 0 deletions(-)
 create mode 100644 plugins/cdmagen.c

diff --git a/Makefile.am b/Makefile.am
index 50e893f..9949bcc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -293,6 +293,9 @@ builtin_sources +=3D plugins/ste.c
 =

 builtin_modules +=3D caif
 builtin_sources +=3D plugins/caif.c
+
+builtin_modules +=3D cdmagen
+builtin_sources +=3D plugins/cdmagen.c
 endif
 =

 if MAINTAINER_MODE
diff --git a/plugins/cdmagen.c b/plugins/cdmagen.c
new file mode 100644
index 0000000..4ec4614
--- /dev/null
+++ b/plugins/cdmagen.c
@@ -0,0 +1,274 @@
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
+#include <ofono/cdma-voicecall.h>
+#include <drivers/atmodem/atutil.h>
+
+#include "common.h"
+
+struct cdmagen_data {
+	GAtChat *chat;
+	ofono_bool_t online;
+	ofono_bool_t registration_status;
+};
+
+static void cdmagen_debug(const char *str, void *data)
+{
+	const char *prefix =3D data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static int cdmagen_probe(struct ofono_modem *modem)
+{
+	struct cdmagen_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct cdmagen_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void cdmagen_remove(struct ofono_modem *modem)
+{
+	struct cdmagen_data *data =3D ofono_modem_get_data(modem);
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
+		g_at_chat_set_debug(chat, cdmagen_debug, debug);
+
+	return chat;
+}
+
+static void cdmagen_disconnect(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct cdmagen_data *data =3D ofono_modem_get_data(modem);
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
+			cdmagen_disconnect, modem);
+}
+
+/* power up hardware */
+static int cdmagen_enable(struct ofono_modem *modem)
+{
+	struct cdmagen_data *data =3D ofono_modem_get_data(modem);
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
+			cdmagen_disconnect, modem);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->chat, cdmagen_debug,
+				"CDMA Generic: ");
+
+	return 0;
+}
+
+static int cdmagen_disable(struct ofono_modem *modem)
+{
+	struct cdmagen_data *data =3D ofono_modem_get_data(modem);
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
+static void cdmagen_pre_sim(struct ofono_modem *modem)
+{
+	struct cdmagen_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_cdma_voicecall_manager_create(modem, 0, "cdmamodem",
+				data->chat);
+}
+
+static void cdmagen_post_sim(struct ofono_modem *modem)
+{
+}
+
+static gboolean cdmagen_set_online_cb(gpointer cb_data)
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
+static void cdmagen_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct cdmagen_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	data->online =3D online;
+
+	if (online)
+		data->registration_status =3D
+		    NETWORK_REGISTRATION_STATUS_REGISTERED;
+
+	cdmagen_set_online_cb(cbd);
+	return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void cdmagen_post_online(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static struct ofono_modem_driver cdmagen_driver =3D {
+	.name			=3D "cdmagen",
+	.probe			=3D cdmagen_probe,
+	.remove			=3D cdmagen_remove,
+	.enable			=3D cdmagen_enable,
+	.disable		=3D cdmagen_disable,
+	.pre_sim		=3D cdmagen_pre_sim,
+	.post_sim		=3D cdmagen_post_sim,
+	.set_online		=3D cdmagen_set_online,
+	.post_online	=3D cdmagen_post_online,
+};
+
+static int cdmagen_init(void)
+{
+	return ofono_modem_driver_register(&cdmagen_driver);
+}
+
+static void cdmagen_exit(void)
+{
+	ofono_modem_driver_unregister(&cdmagen_driver);
+}
+
+OFONO_PLUGIN_DEFINE(cdmagen, "Generic CDMA AT Modem", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			cdmagen_init, cdmagen_exit)
-- =

1.7.0.4


--===============8004111311189760439==--

