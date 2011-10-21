Content-Type: multipart/mixed; boundary="===============7559376570344920451=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 11/12] hfpmodem: devinfo atom added to export BT address
Date: Fri, 21 Oct 2011 18:51:36 +0200
Message-ID: <1319215897-6310-12-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319215897-6310-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7559376570344920451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                 |    1 +
 drivers/hfpmodem/devinfo.c  |  109 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/hfpmodem/hfpmodem.c |    2 +
 drivers/hfpmodem/hfpmodem.h |    3 +
 4 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hfpmodem/devinfo.c

diff --git a/Makefile.am b/Makefile.am
index 8771cb2..83b7737 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -255,6 +255,7 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/voicecall.c \
 			drivers/hfpmodem/network-registration.c \
 			drivers/hfpmodem/call-volume.c \
+			drivers/hfpmodem/devinfo.c \
 			drivers/hfpmodem/handsfree.c
 =

 if PHONESIM
diff --git a/drivers/hfpmodem/devinfo.c b/drivers/hfpmodem/devinfo.c
new file mode 100644
index 0000000..04929c9
--- /dev/null
+++ b/drivers/hfpmodem/devinfo.c
@@ -0,0 +1,109 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#include <string.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gatresult.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+
+#include "hfpmodem.h"
+
+struct devinfo_data {
+	char *device_address;
+	guint register_source;
+};
+
+static void hfp_query_serial(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
+	CALLBACK_WITH_SUCCESS(cb, dev->device_address, data);
+}
+
+static gboolean hfp_devinfo_register(gpointer user_data)
+{
+	struct ofono_devinfo *info =3D user_data;
+	struct devinfo_data *dd =3D ofono_devinfo_get_data(info);
+
+	dd->register_source =3D 0;
+
+	ofono_devinfo_register(info);
+
+	return FALSE;
+}
+
+static int hfp_devinfo_probe(struct ofono_devinfo *info, unsigned int vend=
or,
+				void *user)
+{
+	const char *device_address =3D user;
+	struct devinfo_data *dd;
+
+	dd =3D g_new0(struct devinfo_data, 1);
+	dd->device_address =3D g_strdup(device_address);
+
+	ofono_devinfo_set_data(info, dd);
+
+	dd->register_source =3D g_idle_add(hfp_devinfo_register, info);
+	return 0;
+}
+
+static void hfp_devinfo_remove(struct ofono_devinfo *info)
+{
+	struct devinfo_data *dd =3D ofono_devinfo_get_data(info);
+
+	ofono_devinfo_set_data(info, NULL);
+	if (dd =3D=3D NULL)
+		return;
+
+	if (dd->register_source !=3D 0)
+		g_source_remove(dd->register_source);
+
+	g_free(dd->device_address);
+	g_free(dd);
+}
+
+static struct ofono_devinfo_driver driver =3D {
+	.name			=3D "hfpmodem",
+	.probe			=3D hfp_devinfo_probe,
+	.remove			=3D hfp_devinfo_remove,
+	.query_serial		=3D hfp_query_serial
+};
+
+void hfp_devinfo_init(void)
+{
+	ofono_devinfo_driver_register(&driver);
+}
+
+void hfp_devinfo_exit(void)
+{
+	ofono_devinfo_driver_unregister(&driver);
+}
diff --git a/drivers/hfpmodem/hfpmodem.c b/drivers/hfpmodem/hfpmodem.c
index 13d7766..1348beb 100644
--- a/drivers/hfpmodem/hfpmodem.c
+++ b/drivers/hfpmodem/hfpmodem.c
@@ -35,6 +35,7 @@
 static int hfpmodem_init(void)
 {
 	hfp_voicecall_init();
+	hfp_devinfo_init();
 	hfp_netreg_init();
 	hfp_call_volume_init();
 	hfp_handsfree_init();
@@ -45,6 +46,7 @@ static int hfpmodem_init(void)
 static void hfpmodem_exit(void)
 {
 	hfp_voicecall_exit();
+	hfp_devinfo_exit();
 	hfp_netreg_exit();
 	hfp_call_volume_exit();
 	hfp_handsfree_exit();
diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index 4a996cf..ef7aea5 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -33,3 +33,6 @@ extern void hfp_voicecall_exit(void);
 =

 extern void hfp_handsfree_init(void);
 extern void hfp_handsfree_exit(void);
+
+extern void hfp_devinfo_init(void);
+extern void hfp_devinfo_exit(void);
-- =

1.7.6.4


--===============7559376570344920451==--

