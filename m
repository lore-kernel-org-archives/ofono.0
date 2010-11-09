Content-Type: multipart/mixed; boundary="===============6648128083843619376=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 8/8] Add gprs drivers for dunmodem
Date: Tue, 09 Nov 2010 02:43:01 -0200
Message-ID: <1289277781-6378-9-git-send-email-gustavo@padovan.org>
In-Reply-To: <1289277781-6378-8-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6648128083843619376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                 |    3 +-
 drivers/dunmodem/dunmodem.c |    2 +
 drivers/dunmodem/dunmodem.h |    4 ++
 drivers/dunmodem/gprs.c     |  110 +++++++++++++++++++++++++++++++++++++++=
++++
 plugins/dun.c               |    6 ++
 5 files changed, 124 insertions(+), 1 deletions(-)
 create mode 100644 drivers/dunmodem/gprs.c

diff --git a/Makefile.am b/Makefile.am
index 344fda6..4dd0da0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -199,7 +199,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 builtin_modules +=3D dunmodem
 builtin_sources +=3D drivers/dunmodem/dunmodem.h \
 			drivers/dunmodem/dunmodem.c \
-			drivers/dunmodem/network-registration.c
+			drivers/dunmodem/network-registration.c \
+			drivers/dunmodem/gprs.c
 =

 builtin_modules +=3D mbmmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/dunmodem/dunmodem.c b/drivers/dunmodem/dunmodem.c
index 565b40e..3f118f4 100644
--- a/drivers/dunmodem/dunmodem.c
+++ b/drivers/dunmodem/dunmodem.c
@@ -41,6 +41,7 @@
 static int dunmodem_init(void)
 {
 	dun_netreg_init();
+	dun_gprs_init();
 =

 	return 0;
 }
@@ -48,6 +49,7 @@ static int dunmodem_init(void)
 static void dunmodem_exit(void)
 {
 	dun_netreg_exit();
+	dun_gprs_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(dunmodem, "Dial-up Networking Driver", VERSION,
diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
index 3af1fec..690cc13 100644
--- a/drivers/dunmodem/dunmodem.h
+++ b/drivers/dunmodem/dunmodem.h
@@ -26,7 +26,11 @@ struct dun_data {
 	char *rfcomm;
 	GAtChat *chat;
 	struct ofono_gprs_context *gc;
+	struct ofono_gprs *gprs;
 };
 =

 void dun_netreg_init();
 void dun_netreg_exit();
+
+void dun_gprs_init();
+void dun_gprs_exit();
diff --git a/drivers/dunmodem/gprs.c b/drivers/dunmodem/gprs.c
new file mode 100644
index 0000000..24be251
--- /dev/null
+++ b/drivers/dunmodem/gprs.c
@@ -0,0 +1,110 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 Gustavo F. Padovan <gustavo@padovan.org>
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
+struct gprs_data {
+	GAtChat *chat;
+	unsigned int vendor;
+};
+
+static void dun_gprs_registration_status(struct ofono_gprs *gprs,
+					ofono_gprs_status_cb_t cb,
+					void *data)
+{
+	struct ofono_error error;
+
+	error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+	cb(&error, 1, data);
+}
+
+static void dun_gprs_set_attached(struct ofono_gprs *gprs, int attached,
+					ofono_gprs_cb_t cb, void *data)
+{
+	struct ofono_error error;
+
+	error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+	cb(&error, data);
+}
+
+static int dun_gprs_probe(struct ofono_gprs *gprs,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct gprs_data *gd;
+
+	gd =3D g_new0(struct gprs_data, 1);
+	gd->chat =3D g_at_chat_clone(chat);
+
+	ofono_gprs_set_data(gprs, gd);
+
+	ofono_gprs_set_cid_range(gprs, 2, 2);
+
+	ofono_gprs_register(gprs);
+
+	return 0;
+}
+
+static void dun_gprs_remove(struct ofono_gprs *gprs)
+{
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	ofono_gprs_set_data(gprs, NULL);
+
+	g_at_chat_unref(gd->chat);
+	g_free(gd);
+}
+
+static struct ofono_gprs_driver driver =3D {
+	.name			=3D "dunmodem",
+	.probe			=3D dun_gprs_probe,
+	.remove			=3D dun_gprs_remove,
+	.set_attached		=3D dun_gprs_set_attached,
+	.attached_status	=3D dun_gprs_registration_status,
+};
+
+void dun_gprs_init()
+{
+	ofono_gprs_driver_register(&driver);
+}
+
+void dun_gprs_exit()
+{
+	ofono_gprs_driver_unregister(&driver);
+}
diff --git a/plugins/dun.c b/plugins/dun.c
index dff0d4c..766f924 100644
--- a/plugins/dun.c
+++ b/plugins/dun.c
@@ -316,7 +316,13 @@ static void dun_post_sim(struct ofono_modem *modem)
 {
 	struct dun_data *data =3D ofono_modem_get_data(modem);
 =

+	DBG("%p", modem);
+
+	data->gprs =3D ofono_gprs_create(modem, 0, "dunmodem", data->chat);
 	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+
+		if (data->gprs && data->gc)
+			ofono_gprs_add_context(data->gprs, data->gc);
 }
 =

 static struct ofono_modem_driver dun_driver =3D {
-- =

1.7.3


--===============6648128083843619376==--

