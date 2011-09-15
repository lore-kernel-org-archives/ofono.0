Content-Type: multipart/mixed; boundary="===============4478985015517604251=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 03/12] hfpmodem: Driver implements handsfree atom
Date: Thu, 15 Sep 2011 18:34:34 +0200
Message-ID: <1316104483-13144-4-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1316104483-13144-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4478985015517604251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                  |    3 +-
 drivers/hfpmodem/handsfree.c |   98 ++++++++++++++++++++++++++++++++++++++=
++++
 drivers/hfpmodem/hfpmodem.c  |    2 +
 drivers/hfpmodem/hfpmodem.h  |    3 +
 4 files changed, 105 insertions(+), 1 deletions(-)
 create mode 100644 drivers/hfpmodem/handsfree.c

diff --git a/Makefile.am b/Makefile.am
index 9142777..8f7358e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -253,7 +253,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/slc.c \
 			drivers/hfpmodem/voicecall.c \
 			drivers/hfpmodem/network-registration.c \
-			drivers/hfpmodem/call-volume.c
+			drivers/hfpmodem/call-volume.c \
+			drivers/hfpmodem/handsfree.c
 =

 if PHONESIM
 builtin_modules +=3D phonesim
diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
new file mode 100644
index 0000000..9b7b986
--- /dev/null
+++ b/drivers/hfpmodem/handsfree.c
@@ -0,0 +1,98 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#include <unistd.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gatresult.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/handsfree.h>
+
+#include "hfpmodem.h"
+#include "slc.h"
+
+struct hf_data {
+	GAtChat *chat;
+};
+
+static gboolean hfp_handsfree_register(gpointer user_data)
+{
+	struct ofono_handsfree *hf =3D user_data;
+
+	ofono_handsfree_register(hf);
+
+	return FALSE;
+}
+
+static int hfp_handsfree_probe(struct ofono_handsfree *hf,
+				unsigned int vendor, void *data)
+{
+	struct hfp_slc_info *info =3D data;
+	struct hf_data *hd;
+
+	DBG("");
+	hd =3D g_new0(struct hf_data, 1);
+	hd->chat =3D g_at_chat_clone(info->chat);
+
+	ofono_handsfree_set_data(hf, hd);
+
+	g_idle_add(hfp_handsfree_register, hf);
+
+	return 0;
+}
+
+static void hfp_handsfree_remove(struct ofono_handsfree *hf)
+{
+	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
+
+	ofono_handsfree_set_data(hf, NULL);
+
+	g_at_chat_unref(hd->chat);
+	g_free(hd);
+}
+
+static struct ofono_handsfree_driver driver =3D {
+	.name			=3D "hfpmodem",
+	.probe			=3D hfp_handsfree_probe,
+	.remove			=3D hfp_handsfree_remove,
+};
+
+void hfp_handsfree_init(void)
+{
+	ofono_handsfree_driver_register(&driver);
+}
+
+void hfp_handsfree_exit(void)
+{
+	ofono_handsfree_driver_unregister(&driver);
+}
diff --git a/drivers/hfpmodem/hfpmodem.c b/drivers/hfpmodem/hfpmodem.c
index 8e8960b..e2b172d 100644
--- a/drivers/hfpmodem/hfpmodem.c
+++ b/drivers/hfpmodem/hfpmodem.c
@@ -37,6 +37,7 @@ static int hfpmodem_init(void)
 	hfp_voicecall_init();
 	hfp_netreg_init();
 	hfp_call_volume_init();
+	hfp_handsfree_init();
 =

 	return 0;
 }
@@ -46,6 +47,7 @@ static void hfpmodem_exit(void)
 	hfp_voicecall_exit();
 	hfp_netreg_exit();
 	hfp_call_volume_exit();
+	hfp_handsfree_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(hfpmodem, "Hands-Free Profile Driver", VERSION,
diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index 0ad3ab7..643ec33 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -30,3 +30,6 @@ extern void hfp_call_volume_exit(void);
 =

 extern void hfp_voicecall_init(void);
 extern void hfp_voicecall_exit(void);
+
+extern void hfp_handsfree_init(void);
+extern void hfp_handsfree_exit(void);
-- =

1.7.6


--===============4478985015517604251==--

