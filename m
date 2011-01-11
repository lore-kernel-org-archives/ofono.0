Content-Type: multipart/mixed; boundary="===============6471142716846627587=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 2/3] cdmamodem: Add CDMA devinfo support
Date: Tue, 11 Jan 2011 13:45:00 -0800
Message-ID: <1294782301-8592-3-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6471142716846627587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                   |    3 +-
 drivers/cdmamodem/cdmamodem.c |    2 +
 drivers/cdmamodem/cdmamodem.h |    2 +
 drivers/cdmamodem/devinfo.c   |  169 +++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 175 insertions(+), 1 deletions(-)
 create mode 100644 drivers/cdmamodem/devinfo.c

diff --git a/Makefile.am b/Makefile.am
index 5c9445f..da57645 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -249,7 +249,8 @@ if CDMAMODEM
 builtin_modules +=3D cdmamodem
 builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
 			drivers/cdmamodem/cdmamodem.c \
-			drivers/cdmamodem/voicecall.c
+			drivers/cdmamodem/voicecall.c \
+			drivers/cdmamodem/devinfo.c
 endif
 =

 builtin_modules +=3D g1
diff --git a/drivers/cdmamodem/cdmamodem.c b/drivers/cdmamodem/cdmamodem.c
index 1c15da0..0ed8414 100644
--- a/drivers/cdmamodem/cdmamodem.c
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -35,6 +35,7 @@
 static int cdmamodem_init(void)
 {
 	cdma_at_voicecall_init();
+	cdma_at_devinfo_init();
 =

 	return 0;
 }
@@ -42,6 +43,7 @@ static int cdmamodem_init(void)
 static void cdmamodem_exit(void)
 {
 	cdma_at_voicecall_exit();
+	cdma_at_devinfo_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(cdmamodem, "CDMA AT modem driver", VERSION,
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
index a5991cf..ef4fad3 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -23,3 +23,5 @@
 =

 extern void cdma_at_voicecall_init();
 extern void cdma_at_voicecall_exit();
+extern void cdma_at_devinfo_init();
+extern void cdma_at_devinfo_exit();
diff --git a/drivers/cdmamodem/devinfo.c b/drivers/cdmamodem/devinfo.c
new file mode 100644
index 0000000..efa140a
--- /dev/null
+++ b/drivers/cdmamodem/devinfo.c
@@ -0,0 +1,169 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010 Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011 Nokia Corporation. All rights reserved.
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
+#include <string.h>
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "cdmamodem.h"
+
+static void cdma_at_query_manufacturer(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb, void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	GAtChat *chat =3D ofono_devinfo_get_data(info);
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	cbd->user =3D "AT+GMI";
+
+	if (g_at_chat_send(chat, "AT+GMI", NULL,
+				at_util_attr_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void cdma_at_query_model(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb, void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	GAtChat *chat =3D ofono_devinfo_get_data(info);
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	cbd->user =3D "AT+GMM";
+
+	if (g_at_chat_send(chat, "AT+GMM", NULL,
+				at_util_attr_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void cdma_at_query_revision(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb, void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	GAtChat *chat =3D ofono_devinfo_get_data(info);
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	cbd->user =3D "AT+GMR";
+
+	if (g_at_chat_send(chat, "AT+GMR", NULL,
+				at_util_attr_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void cdma_at_query_serial(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb, void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	GAtChat *chat =3D ofono_devinfo_get_data(info);
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	cbd->user =3D "AT+GSN";
+
+	if (g_at_chat_send(chat, "AT+GSN", NULL,
+				at_util_attr_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static gboolean cdma_at_devinfo_register(gpointer user_data)
+{
+	struct ofono_devinfo *info =3D user_data;
+
+	ofono_devinfo_register(info);
+
+	return FALSE;
+}
+
+static int cdma_at_devinfo_probe(struct ofono_devinfo *info,
+				unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+
+	ofono_devinfo_set_data(info, g_at_chat_clone(chat));
+	g_idle_add(cdma_at_devinfo_register, info);
+
+	return 0;
+}
+
+static void cdma_at_devinfo_remove(struct ofono_devinfo *info)
+{
+	GAtChat *chat =3D ofono_devinfo_get_data(info);
+
+	g_at_chat_unref(chat);
+	ofono_devinfo_set_data(info, NULL);
+}
+
+static struct ofono_devinfo_driver driver =3D {
+	.name 			=3D "cdmamodem",
+	.probe	 		=3D cdma_at_devinfo_probe,
+	.remove			=3D cdma_at_devinfo_remove,
+	.query_manufacturer	=3D cdma_at_query_manufacturer,
+	.query_model		=3D cdma_at_query_model,
+	.query_revision		=3D cdma_at_query_revision,
+	.query_serial		=3D cdma_at_query_serial
+};
+
+void cdma_at_devinfo_init(void)
+{
+	ofono_devinfo_driver_register(&driver);
+}
+
+void cdma_at_devinfo_exit(void)
+{
+	ofono_devinfo_driver_unregister(&driver);
+}
-- =

1.7.0.4


--===============6471142716846627587==--

