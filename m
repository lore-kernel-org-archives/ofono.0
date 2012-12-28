Content-Type: multipart/mixed; boundary="===============6264376920436632434=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 2/8] sierramodem: Add skeleton cdma netreg driver
Date: Fri, 28 Dec 2012 14:34:58 -0500
Message-ID: <20121228193458.GH18339@alittletooquiet.net>
In-Reply-To: <20121228193141.GF18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6264376920436632434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

---
 Makefile.am                       |    3 +-
 drivers/sierramodem/cdma-netreg.c |   85 +++++++++++++++++++++++++++++++++=
++++
 drivers/sierramodem/sierramodem.c |    3 +
 drivers/sierramodem/sierramodem.h |    3 +
 4 files changed, 93 insertions(+), 1 deletions(-)
 create mode 100644 drivers/sierramodem/cdma-netreg.c

diff --git a/Makefile.am b/Makefile.am
index ca488a7..074326c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -320,7 +320,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 builtin_modules +=3D sierramodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/sierramodem/sierramodem.h \
-			drivers/sierramodem/sierramodem.c
+			drivers/sierramodem/sierramodem.c \
+			drivers/sierramodem/cdma-netreg.c
 =

 if PHONESIM
 builtin_modules +=3D phonesim
diff --git a/drivers/sierramodem/cdma-netreg.c b/drivers/sierramodem/cdma-n=
etreg.c
new file mode 100644
index 0000000..109b245
--- /dev/null
+++ b/drivers/sierramodem/cdma-netreg.c
@@ -0,0 +1,85 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  Outpost Embedded, LLC. All rights reserved.
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
+#include <glib.h>
+#include <errno.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/cdma-netreg.h>
+
+#include "gatchat.h"
+
+#include "sierramodem.h"
+
+struct sierra_netreg_data {
+	GAtChat *chat;
+};
+
+static int sierra_cdma_netreg_probe(struct ofono_cdma_netreg *netreg,
+				unsigned int vendor, void *chat)
+{
+	struct sierra_netreg_data *data;
+
+	data =3D g_try_new0(struct sierra_netreg_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_cdma_netreg_set_data(netreg, data);
+
+	data->chat =3D g_at_chat_clone(chat);
+
+	ofono_cdma_netreg_register(netreg);
+
+	return 0;
+}
+
+static void sierra_cdma_netreg_remove(struct ofono_cdma_netreg *netreg)
+{
+	struct sierra_netreg_data *data =3D ofono_cdma_netreg_get_data(netreg);
+
+	ofono_cdma_netreg_set_data(netreg, NULL);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+}
+
+static struct ofono_cdma_netreg_driver driver =3D {
+	.name	=3D "sierramodem",
+	.probe	=3D sierra_cdma_netreg_probe,
+	.remove	=3D sierra_cdma_netreg_remove,
+};
+
+void sierra_cdma_netreg_init(void)
+{
+	ofono_cdma_netreg_driver_register(&driver);
+}
+
+void sierra_cdma_netreg_exit(void)
+{
+	ofono_cdma_netreg_driver_unregister(&driver);
+}
diff --git a/drivers/sierramodem/sierramodem.c b/drivers/sierramodem/sierra=
modem.c
index f31dd84..8f42aff 100644
--- a/drivers/sierramodem/sierramodem.c
+++ b/drivers/sierramodem/sierramodem.c
@@ -35,11 +35,14 @@
 =

 static int sierramodem_init(void)
 {
+	sierra_cdma_netreg_init();
+
 	return 0;
 }
 =

 static void sierramodem_exit(void)
 {
+	sierra_cdma_netreg_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(sierramodem, "Sierra Wireless modem driver", VERSION,
diff --git a/drivers/sierramodem/sierramodem.h b/drivers/sierramodem/sierra=
modem.h
index 35e8b49..c225e86 100644
--- a/drivers/sierramodem/sierramodem.h
+++ b/drivers/sierramodem/sierramodem.h
@@ -21,3 +21,6 @@
  */
 =

 #include <drivers/atmodem/atutil.h>
+
+extern void sierra_cdma_netreg_init(void);
+extern void sierra_cdma_netreg_exit(void);
-- =

1.7.0.4

--===============6264376920436632434==--

