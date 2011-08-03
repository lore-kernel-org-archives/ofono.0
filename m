Content-Type: multipart/mixed; boundary="===============0719741330290457691=="
MIME-Version: 1.0
From: mario@tokarz.eu
Subject: [PATCH] dunmodem: Add stub for gprs.
Date: Wed, 03 Aug 2011 15:04:20 +0200
Message-ID: <1312376660-4785-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0719741330290457691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mario Tokarz <mario.tokarz@bmw-carit.de>

---
 Makefile.am                 |    3 +-
 drivers/dunmodem/dunmodem.c |    2 +
 drivers/dunmodem/dunmodem.h |    3 +
 drivers/dunmodem/gprs.c     |   99 +++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 106 insertions(+), 1 deletions(-)
 create mode 100644 drivers/dunmodem/gprs.c

diff --git a/Makefile.am b/Makefile.am
index cef9892..9c56711 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -248,7 +248,8 @@ builtin_modules +=3D dunmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/dunmodem/dunmodem.h \
 			drivers/dunmodem/dunmodem.c \
-			drivers/dunmodem/network-registration.c
+			drivers/dunmodem/network-registration.c \
+			drivers/dunmodem/gprs.c
 =

 builtin_modules +=3D hfpmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/dunmodem/dunmodem.c b/drivers/dunmodem/dunmodem.c
index 67d6257..35a7dbb 100644
--- a/drivers/dunmodem/dunmodem.c
+++ b/drivers/dunmodem/dunmodem.c
@@ -35,6 +35,7 @@
 static int dunmodem_init(void)
 {
 	dun_netreg_init();
+	dun_gprs_init();
 =

 	return 0;
 }
@@ -42,6 +43,7 @@ static int dunmodem_init(void)
 static void dunmodem_exit(void)
 {
 	dun_netreg_exit();
+	dun_gprs_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(dunmodem, "Dialup modem driver", VERSION,
diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
index 9a87841..4fbd4a5 100644
--- a/drivers/dunmodem/dunmodem.h
+++ b/drivers/dunmodem/dunmodem.h
@@ -23,3 +23,6 @@
 =

 extern void dun_netreg_init(void);
 extern void dun_netreg_exit(void);
+
+extern void dun_gprs_init(void);
+extern void dun_gprs_exit(void);
diff --git a/drivers/dunmodem/gprs.c b/drivers/dunmodem/gprs.c
new file mode 100644
index 0000000..fb9755e
--- /dev/null
+++ b/drivers/dunmodem/gprs.c
@@ -0,0 +1,99 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
+#include <ofono/gprs.h>
+
+#include "gatchat.h"
+
+#include "dunmodem.h"
+
+static void dun_gprs_set_attached(struct ofono_gprs *gprs, int attached,
+						ofono_gprs_cb_t cb, void *data)
+{
+	DBG("");
+
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
+static gboolean dun_gprs_finish_registration(gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+
+	ofono_gprs_register(gprs);
+
+	return FALSE;
+}
+
+static int dun_gprs_probe(struct ofono_gprs *gprs,
+					unsigned int vendor, void *data)
+{
+	DBG("");
+
+	g_idle_add(dun_gprs_finish_registration, gprs);
+
+	return 0;
+}
+
+static void dun_gprs_remove(struct ofono_gprs *gprs)
+{
+	DBG("");
+}
+
+static void dun_gprs_attached_status(struct ofono_gprs *gprs,
+						ofono_gprs_status_cb_t cb,
+						void *data)
+{
+	DBG("");
+
+	CALLBACK_WITH_SUCCESS(cb, 1, data);
+}
+
+static struct ofono_gprs_driver driver =3D {
+	.name			=3D "dunmodem",
+	.probe			=3D dun_gprs_probe,
+	.remove			=3D dun_gprs_remove,
+	.set_attached		=3D dun_gprs_set_attached,
+	.attached_status	=3D dun_gprs_attached_status,
+};
+
+void dun_gprs_init(void)
+{
+	ofono_gprs_driver_register(&driver);
+}
+
+void dun_gprs_exit(void)
+{
+	ofono_gprs_driver_unregister(&driver);
+}
-- =

1.7.4.1


--===============0719741330290457691==--

