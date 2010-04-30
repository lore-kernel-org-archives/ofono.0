Content-Type: multipart/mixed; boundary="===============7280026390695754063=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2 1/6] atmodem: create struct atmodem_gprs
Date: Fri, 30 Apr 2010 15:54:58 +0300
Message-ID: <20100430125458.30019.94365.stgit@potku.valot.fi>
In-Reply-To: <20100430124405.30019.86945.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7280026390695754063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is need to to provide more chat channels to atmodem gprs module.
---

 drivers/atmodem/gprs.c |    7 ++++---
 drivers/atmodem/gprs.h |   29 +++++++++++++++++++++++++++++
 plugins/hso.c          |    8 +++++++-
 plugins/mbm.c          |    7 ++++++-
 plugins/palmpre.c      |    8 +++++++-
 plugins/phonesim.c     |    7 ++++++-
 plugins/ste.c          |    7 ++++++-
 7 files changed, 65 insertions(+), 8 deletions(-)
 create mode 100644 drivers/atmodem/gprs.h

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 052417a..d12d9eb 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -40,6 +40,7 @@
 =

 #include "atmodem.h"
 #include "vendor.h"
+#include "gprs.h"
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
@@ -291,16 +292,16 @@ error:
 static int at_gprs_probe(struct ofono_gprs *gprs,
 					unsigned int vendor, void *data)
 {
-	GAtChat *chat =3D data;
+	struct atmodem_gprs *atmodem =3D data;
 	struct gprs_data *gd;
 =

 	gd =3D g_new0(struct gprs_data, 1);
-	gd->chat =3D chat;
+	gd->chat =3D atmodem->chat;
 	gd->vendor =3D vendor;
 =

 	ofono_gprs_set_data(gprs, gd);
 =

-	g_at_chat_send(chat, "AT+CGDCONT=3D?", cgdcont_prefix,
+	g_at_chat_send(gd->chat, "AT+CGDCONT=3D?", cgdcont_prefix,
 			at_cgdcont_test_cb, gprs, NULL);
 =

 	return 0;
diff --git a/drivers/atmodem/gprs.h b/drivers/atmodem/gprs.h
new file mode 100644
index 0000000..36388e3
--- /dev/null
+++ b/drivers/atmodem/gprs.h
@@ -0,0 +1,29 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Canonical Ltd. All rights reserved.
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
+struct atmodem_gprs
+{
+	/* primary chat channel */
+	GAtChat *chat;
+
+	/* secondary chat channel for events */
+	GAtChat *event;
+};
diff --git a/plugins/hso.c b/plugins/hso.c
index dd9be67..26f6c81 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -42,6 +43,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/log.h>
 =

+#include <drivers/atmodem/gprs.h>
 #include <drivers/atmodem/vendor.h>
 =

 static const char *none_prefix[] =3D { NULL };
@@ -212,6 +214,7 @@ static void hso_post_sim(struct ofono_modem *modem)
 	struct hso_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	struct atmodem_gprs atmodem_gprs;
 =

 	DBG("%p", modem);
 =

@@ -219,7 +222,10 @@ static void hso_post_sim(struct ofono_modem *modem)
 				"atmodem", data->app);
 	ofono_sms_create(modem, 0, "atmodem", data->app);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
+	memset(&atmodem_gprs, 0, sizeof(atmodem_gprs));
+	atmodem_gprs.chat =3D data->app;
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", &atmodem_gprs);
 	gc =3D ofono_gprs_context_create(modem, 0, "hso", data->control);
 =

 	if (gprs && gc)
diff --git a/plugins/mbm.c b/plugins/mbm.c
index c67c7a5..518aaaa 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -51,6 +52,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/log.h>
+#include <drivers/atmodem/gprs.h>
 #include <drivers/atmodem/vendor.h>
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
@@ -301,6 +303,7 @@ static void mbm_post_sim(struct ofono_modem *modem)
 	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	struct atmodem_gprs atmodem_gprs;
 =

 	DBG("%p", modem);
 =

@@ -317,7 +320,9 @@ static void mbm_post_sim(struct ofono_modem *modem)
 	ofono_sms_create(modem, 0, "atmodem", data->modem_port);
 	ofono_cbs_create(modem, 0, "atmodem", data->modem_port);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->modem_port);
+	memset(&atmodem_gprs, 0, sizeof(atmodem_gprs));
+	atmodem_gprs.chat =3D data->modem_port;
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", &atmodem_gprs);
 	gc =3D ofono_gprs_context_create(modem, 0, "mbm", data->modem_port);
 =

 	if (gprs && gc)
diff --git a/plugins/palmpre.c b/plugins/palmpre.c
index 7d2aeb4..9292e55 100644
--- a/plugins/palmpre.c
+++ b/plugins/palmpre.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -44,6 +45,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/sms.h>
 =

+#include <drivers/atmodem/gprs.h>
 #include <drivers/atmodem/vendor.h>
 =

 struct palmpre_data {
@@ -189,6 +191,7 @@ static void palmpre_post_sim(struct ofono_modem *modem)
 	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	struct atmodem_gprs atmodem_gprs;
 =

 	DBG("%p", modem);
 =

@@ -197,7 +200,10 @@ static void palmpre_post_sim(struct ofono_modem *modem)
 				data->chat);
 	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
+	memset(&atmodem_gprs, 0, sizeof(atmodem_gprs));
+	atmodem_gprs.chat =3D data->chat;
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", &atmodem_gprs);
 	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
 =

 	if (gprs && gc)
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d0cd7f3..becd06a 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -58,6 +58,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 =

+#include <drivers/atmodem/gprs.h>
 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/sim-poll.h>
 =

@@ -301,6 +302,7 @@ static void phonesim_post_sim(struct ofono_modem *modem)
 	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	struct atmodem_gprs atmodem_gprs;
 =

 	DBG("%p", modem);
 =

@@ -326,7 +328,10 @@ static void phonesim_post_sim(struct ofono_modem *mode=
m)
 		ofono_cbs_create(modem, 0, "atmodem", data->chat);
 	}
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
+	memset(&atmodem_gprs, 0, sizeof(atmodem_gprs));
+	atmodem_gprs.chat =3D data->chat;
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", &atmodem_gprs);
 	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
 =

 	if (gprs && gc)
diff --git a/plugins/ste.c b/plugins/ste.c
index f3ae0b2..a744797 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -54,6 +54,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <drivers/atmodem/gprs.h>
 #include <drivers/atmodem/vendor.h>
 =

 #include <drivers/stemodem/caif_socket.h>
@@ -225,6 +226,7 @@ static void ste_post_sim(struct ofono_modem *modem)
 	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	struct atmodem_gprs atmodem_gprs;
 =

 	DBG("%p", modem);
 =

@@ -239,8 +241,11 @@ static void ste_post_sim(struct ofono_modem *modem)
 	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
 	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
 =

+	memset(&atmodem_gprs, 0, sizeof(atmodem_gprs));
+	atmodem_gprs.chat =3D data->chat;
+
 	gprs =3D ofono_gprs_create(modem,
-			OFONO_VENDOR_STE, "atmodem", data->chat);
+			OFONO_VENDOR_STE, "atmodem", &atmodem_gprs);
 	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
 =

 	if (gprs && gc)


--===============7280026390695754063==--

