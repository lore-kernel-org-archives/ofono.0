Content-Type: multipart/mixed; boundary="===============7529852740081188559=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 5/8] mbmmodem: add gps atom
Date: Thu, 16 Dec 2010 17:30:20 -0300
Message-ID: <1292531423-22316-6-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1292531423-22316-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7529852740081188559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                 |    3 +-
 drivers/mbmmodem/gps.c      |  185 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/mbmmodem/mbmmodem.c |    2 +
 drivers/mbmmodem/mbmmodem.h |    3 +
 4 files changed, 192 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mbmmodem/gps.c

diff --git a/Makefile.am b/Makefile.am
index 45f1ba3..4b8cb51 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -202,7 +202,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/mbmmodem/mbmmodem.h \
 			drivers/mbmmodem/mbmmodem.c \
 			drivers/mbmmodem/gprs-context.c \
-			drivers/mbmmodem/stk.c
+			drivers/mbmmodem/stk.c \
+			drivers/mbmmodem/gps.c
 =

 builtin_modules +=3D hsomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/mbmmodem/gps.c b/drivers/mbmmodem/gps.c
new file mode 100644
index 0000000..5bcfeb5
--- /dev/null
+++ b/drivers/mbmmodem/gps.c
@@ -0,0 +1,185 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ProFUSION embedded systems.
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gps.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "mbmmodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *e2gpsctl_prefix[] =3D { "*E2GPSCTL:", NULL };
+
+struct gps_data {
+	GAtChat *chat;
+};
+
+static void mbm_gps_query_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gps_query_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int value;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "*E2GPSCTL:") =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
+		goto error;
+
+	if ((value !=3D 0) && (value !=3D 1))
+		goto error;
+
+	cb(&error, value, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void mbm_query_gps(struct ofono_gps *g,
+				ofono_gps_query_cb_t cb,
+				void *data)
+{
+	struct gps_data *gd =3D ofono_gps_get_data(g);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(gd->chat, "AT*E2GPSCTL?", e2gpsctl_prefix,
+					mbm_gps_query_cb, cbd, g_free) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+	}
+}
+
+static void mbm_e2gpsctl_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gps_set_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void mbm_set_gps(struct ofono_gps *g,
+				gboolean value,
+				ofono_gps_set_cb_t cb,
+				void *data)
+{
+	struct gps_data *gd =3D ofono_gps_get_data(g);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[20];
+
+	snprintf(buf, sizeof(buf), "AT*E2GPSCTL=3D%u,5,1", value);
+
+	if (g_at_chat_send(gd->chat, buf, none_prefix,
+					mbm_e2gpsctl_cb, cbd, g_free) > 0)
+		return;
+
+	/* error */
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void mbm_gps_support_cb(gboolean ok, GAtResult *result, gpointer us=
er_data)
+{
+	struct ofono_gps *gps =3D user_data;
+
+	if (!ok)
+		return;
+
+	ofono_gps_register(gps);
+}
+
+static int mbm_gps_probe(struct ofono_gps *g,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct gps_data *gd;
+
+	gd =3D g_try_new0(struct gps_data, 1);
+	if (gd =3D=3D NULL)
+		return -ENOMEM;
+
+	gd->chat =3D g_at_chat_clone(chat);
+
+	ofono_gps_set_data(g, gd);
+
+	g_at_chat_send(gd->chat, "AT*E2GPSCTL=3D?", e2gpsctl_prefix,
+					mbm_gps_support_cb, g, NULL);
+
+	return 0;
+}
+
+static void mbm_gps_remove(struct ofono_gps *g)
+{
+	struct gps_data *gd =3D ofono_gps_get_data(g);
+
+	ofono_gps_set_data(g, NULL);
+
+	g_at_chat_unref(gd->chat);
+	g_free(gd);
+}
+
+static struct ofono_gps_driver driver =3D {
+	.name			=3D "mbmmodem",
+	.probe			=3D mbm_gps_probe,
+	.remove			=3D mbm_gps_remove,
+	.query_gps		=3D mbm_query_gps,
+	.set_gps		=3D mbm_set_gps
+};
+
+void mbm_gps_init()
+{
+	ofono_gps_driver_register(&driver);
+}
+
+void mbm_gps_exit()
+{
+	ofono_gps_driver_unregister(&driver);
+}
diff --git a/drivers/mbmmodem/mbmmodem.c b/drivers/mbmmodem/mbmmodem.c
index 03b61b3..ea56cd4 100644
--- a/drivers/mbmmodem/mbmmodem.c
+++ b/drivers/mbmmodem/mbmmodem.c
@@ -36,12 +36,14 @@ static int mbmmodem_init(void)
 {
 	mbm_gprs_context_init();
 	mbm_stk_init();
+	mbm_gps_init();
 =

 	return 0;
 }
 =

 static void mbmmodem_exit(void)
 {
+	mbm_gps_exit();
 	mbm_stk_exit();
 	mbm_gprs_context_exit();
 }
diff --git a/drivers/mbmmodem/mbmmodem.h b/drivers/mbmmodem/mbmmodem.h
index 65786d7..d1e96fa 100644
--- a/drivers/mbmmodem/mbmmodem.h
+++ b/drivers/mbmmodem/mbmmodem.h
@@ -26,3 +26,6 @@ extern void mbm_gprs_context_exit();
 =

 extern void mbm_stk_init();
 extern void mbm_stk_exit();
+
+extern void mbm_gps_init();
+extern void mbm_gps_exit();
-- =

1.7.2.3


--===============7529852740081188559==--

