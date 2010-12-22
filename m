Content-Type: multipart/mixed; boundary="===============1410064795006350828=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH v2, 5/7] cdmamodem: Add CDMA SMS driver support
Date: Tue, 21 Dec 2010 16:02:27 -0800
Message-ID: <1292976149-15598-6-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1410064795006350828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                   |    3 +-
 drivers/cdmamodem/cdmamodem.c |    2 +
 drivers/cdmamodem/cdmamodem.h |    3 +
 drivers/cdmamodem/sms.c       |  153 +++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 160 insertions(+), 1 deletions(-)
 create mode 100644 drivers/cdmamodem/sms.c

diff --git a/Makefile.am b/Makefile.am
index 69ee02d..3035b69 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -245,7 +245,8 @@ endif
 if CDMA_ATMODEM
 builtin_modules +=3D cdma_atmodem
 builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
-			drivers/cdmamodem/cdmamodem.c
+			drivers/cdmamodem/cdmamodem.c \
+			drivers/cdmamodem/sms.c
 endif
 =

 builtin_modules +=3D g1
diff --git a/drivers/cdmamodem/cdmamodem.c b/drivers/cdmamodem/cdmamodem.c
index 25bd0f3..34829e1 100644
--- a/drivers/cdmamodem/cdmamodem.c
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -34,11 +34,13 @@
 =

 static int cdma_atmodem_init(void)
 {
+	cdma_at_sms_init();
 	return 0;
 }
 =

 static void cdma_atmodem_exit(void)
 {
+	cdma_at_sms_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(cdma_atmodem, "CDMA AT modem driver", VERSION,
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
index 114d1fd..6f1c915 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -20,3 +20,6 @@
  */
 =

 #include <drivers/atmodem/atutil.h>
+
+extern void cdma_at_sms_init();
+extern void cdma_at_sms_exit();
diff --git a/drivers/cdmamodem/sms.c b/drivers/cdmamodem/sms.c
new file mode 100644
index 0000000..de90224
--- /dev/null
+++ b/drivers/cdmamodem/sms.c
@@ -0,0 +1,153 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation. All rights reserved.
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
+#include <ofono/cdma-sms.h>
+#include "util.h"
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "cdmamodem.h"
+
+struct cdma_sms_data {
+	unsigned int vendor;
+	GAtChat *chat;
+};
+
+static gboolean at_parse_pdu_common(GAtResult *result,
+					const char *prefix,
+					const char **pdu,
+					int *pdulen)
+{
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, prefix))
+		return FALSE;
+
+	if (!strcmp(prefix, "+CMT:") && !g_at_result_iter_skip_next(&iter))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, pdulen))
+		return FALSE;
+
+	*pdu =3D g_at_result_pdu(result);
+
+	return TRUE;
+}
+
+static void at_cmt_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_sms *cdma_sms =3D user_data;
+	const char *hexpdu;
+	long pdu_len;
+	int tpdu_len;
+	unsigned char pdu[256];
+
+	if (!at_parse_pdu_common(result, "+CMT:", &hexpdu, &tpdu_len)) {
+		ofono_error("Unable to parse CMT notification");
+		return;
+	}
+
+	if (strlen(hexpdu) > sizeof(pdu) * 2) {
+		ofono_error("Bad PDU length in CMT notification");
+		return;
+	}
+
+	DBG("Got new SMS Deliver PDU via CMT: %s, %d", hexpdu, tpdu_len);
+
+	decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
+	ofono_cdma_sms_deliver_notify(cdma_sms, pdu, pdu_len);
+}
+
+static void at_sms_initialized(struct ofono_cdma_sms *cdma_sms)
+{
+	struct cdma_sms_data *data =3D ofono_cdma_sms_get_data(cdma_sms);
+
+	g_at_chat_register(data->chat, "+CMT:",
+				at_cmt_notify, TRUE, cdma_sms, NULL);
+
+	ofono_cdma_sms_register(cdma_sms);
+}
+
+static int at_sms_probe(struct ofono_cdma_sms *cdma_sms,
+				unsigned int vendor, void *user)
+{
+	GAtChat *chat =3D user;
+	struct cdma_sms_data *data;
+
+	data =3D g_new0(struct cdma_sms_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	data->chat =3D g_at_chat_clone(chat);
+	if (data->chat =3D=3D NULL)
+		return -ENOMEM;
+
+	data->vendor =3D vendor;
+
+	ofono_cdma_sms_set_data(cdma_sms, data);
+
+	at_sms_initialized(cdma_sms);
+
+	return 0;
+}
+
+static void at_sms_remove(struct ofono_cdma_sms *cdma_sms)
+{
+	struct cdma_sms_data *data =3D ofono_cdma_sms_get_data(cdma_sms);
+
+	ofono_cdma_sms_set_data(cdma_sms, NULL);
+
+	g_at_chat_unref(data->chat);
+	g_free(data);
+}
+
+static struct ofono_cdma_sms_driver driver =3D {
+	.name		=3D "cdmamodem",
+	.probe		=3D at_sms_probe,
+	.remove		=3D at_sms_remove,
+};
+
+void cdma_at_sms_init()
+{
+	ofono_cdma_sms_driver_register(&driver);
+}
+
+void cdma_at_sms_exit()
+{
+	ofono_cdma_sms_driver_unregister(&driver);
+}
-- =

1.7.0.4


--===============1410064795006350828==--

