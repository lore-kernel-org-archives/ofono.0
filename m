Content-Type: multipart/mixed; boundary="===============2235478435597285637=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v2, 1/2] cdmamodem: Add CDMA devinfo support
Date: Thu, 13 Jan 2011 12:52:15 -0800
Message-ID: <1294951936-23868-2-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2235478435597285637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                   |    3 +-
 drivers/cdmamodem/cdmamodem.c |    2 +
 drivers/cdmamodem/cdmamodem.h |    2 +
 drivers/cdmamodem/devinfo.c   |  188 +++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 194 insertions(+), 1 deletions(-)
 create mode 100644 drivers/cdmamodem/devinfo.c

diff --git a/Makefile.am b/Makefile.am
index a68fc36..014af8f 100644
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
index dec44a4..9eddd88 100644
--- a/drivers/cdmamodem/cdmamodem.c
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -35,6 +35,7 @@
 static int cdmamodem_init(void)
 {
 	cdma_voicecall_init();
+	cdma_devinfo_init();
 =

 	return 0;
 }
@@ -42,6 +43,7 @@ static int cdmamodem_init(void)
 static void cdmamodem_exit(void)
 {
 	cdma_voicecall_exit();
+	cdma_devinfo_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(cdmamodem, "CDMA AT modem driver", VERSION,
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
index b085541..3f9a198 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -23,3 +23,5 @@
 =

 extern void cdma_voicecall_init();
 extern void cdma_voicecall_exit();
+extern void cdma_devinfo_init(void);
+extern void cdma_devinfo_exit(void);
diff --git a/drivers/cdmamodem/devinfo.c b/drivers/cdmamodem/devinfo.c
new file mode 100644
index 0000000..540c49f
--- /dev/null
+++ b/drivers/cdmamodem/devinfo.c
@@ -0,0 +1,188 @@
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
+static void attr_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+         struct cb_data *cbd =3D user_data;
+         ofono_devinfo_query_cb_t cb =3D cbd->cb;
+         const char *prefix =3D cbd->user;
+         struct ofono_error error;
+         const char *attr;
+
+         decode_at_error(&error, g_at_result_final_response(result));
+
+         if (!ok) {
+                 cb(&error, NULL, cbd->data);
+                 return;
+         }
+
+         if (at_util_parse_attr(result, prefix, &attr) =3D=3D FALSE) {
+                 CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+                 return;
+         }
+
+         cb(&error, attr, cbd->data);
+}
+
+static void cdma_query_manufacturer(struct ofono_devinfo *info,
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
+	if (g_at_chat_send(chat, "AT+GMI", NULL, attr_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void cdma_query_model(struct ofono_devinfo *info,
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
+	if (g_at_chat_send(chat, "AT+GMM", NULL, attr_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void cdma_query_revision(struct ofono_devinfo *info,
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
+	if (g_at_chat_send(chat, "AT+GMR", NULL, attr_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void cdma_query_serial(struct ofono_devinfo *info,
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
+	if (g_at_chat_send(chat, "AT+GSN", NULL, attr_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static gboolean cdma_devinfo_register(gpointer user_data)
+{
+	struct ofono_devinfo *info =3D user_data;
+
+	ofono_devinfo_register(info);
+
+	return FALSE;
+}
+
+static int cdma_devinfo_probe(struct ofono_devinfo *info,
+				unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+
+	ofono_devinfo_set_data(info, g_at_chat_clone(chat));
+	g_idle_add(cdma_devinfo_register, info);
+
+	return 0;
+}
+
+static void cdma_devinfo_remove(struct ofono_devinfo *info)
+{
+	GAtChat *chat =3D ofono_devinfo_get_data(info);
+
+	g_at_chat_unref(chat);
+	ofono_devinfo_set_data(info, NULL);
+}
+
+static struct ofono_devinfo_driver driver =3D {
+	.name 			=3D "cdmamodem",
+	.probe	 		=3D cdma_devinfo_probe,
+	.remove			=3D cdma_devinfo_remove,
+	.query_manufacturer	=3D cdma_query_manufacturer,
+	.query_model		=3D cdma_query_model,
+	.query_revision		=3D cdma_query_revision,
+	.query_serial		=3D cdma_query_serial
+};
+
+void cdma_devinfo_init(void)
+{
+	ofono_devinfo_driver_register(&driver);
+}
+
+void cdma_devinfo_exit(void)
+{
+	ofono_devinfo_driver_unregister(&driver);
+}
-- =

1.7.0.4


--===============2235478435597285637==--

