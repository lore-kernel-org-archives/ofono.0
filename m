Content-Type: multipart/mixed; boundary="===============5139841346880977108=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH v4, 5/7] cdmamodem: Add CDMA SMS driver support
Date: Tue, 18 Jan 2011 14:54:21 -0800
Message-ID: <1295391263-31592-3-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <Y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5139841346880977108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                   |    3 +-
 drivers/atmodem/atutil.c      |   21 +++++++
 drivers/atmodem/atutil.h      |    3 +
 drivers/atmodem/sms.c         |   21 -------
 drivers/cdmamodem/cdmamodem.c |    2 +
 drivers/cdmamodem/cdmamodem.h |    2 +
 drivers/cdmamodem/sms.c       |  125 +++++++++++++++++++++++++++++++++++++=
++++
 7 files changed, 155 insertions(+), 22 deletions(-)
 create mode 100644 drivers/cdmamodem/sms.c

diff --git a/Makefile.am b/Makefile.am
index dff5553..7548942 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -253,7 +253,8 @@ builtin_modules +=3D cdmamodem
 builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
 			drivers/cdmamodem/cdmamodem.c \
 			drivers/cdmamodem/voicecall.c \
-			drivers/cdmamodem/devinfo.c
+			drivers/cdmamodem/devinfo.c \
+			drivers/cdmamodem/sms.c
 endif
 =

 builtin_modules +=3D g1
diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index da17253..d567fbe 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -480,3 +480,24 @@ gboolean at_util_parse_attr(GAtResult *result, const c=
har *prefix,
 =

 	return TRUE;
 }
+
+gboolean at_parse_pdu_common(GAtResult *result, const char *prefix,
+				const char **pdu, int *pdulen)
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
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 3d13b84..3f70ac0 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -74,6 +74,9 @@ gboolean at_util_parse_cscs_query(GAtResult *result,
 gboolean at_util_parse_attr(GAtResult *result, const char *prefix,
 				const char **out_attr);
 =

+gboolean at_parse_pdu_common(GAtResult *result, const char *prefix,
+					const char **pdu, int *pdulen);
+
 struct cb_data {
 	void *cb;
 	void *data;
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index c570886..725ed3c 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -339,27 +339,6 @@ static void at_cnma_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 				"Further SMS reception is not guaranteed");
 }
 =

-static gboolean at_parse_pdu_common(GAtResult *result, const char *prefix,
-					const char **pdu, int *pdulen)
-{
-	GAtResultIter iter;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, prefix))
-		return FALSE;
-
-	if (!strcmp(prefix, "+CMT:") && !g_at_result_iter_skip_next(&iter))
-		return FALSE;
-
-	if (!g_at_result_iter_next_number(&iter, pdulen))
-		return FALSE;
-
-	*pdu =3D g_at_result_pdu(result);
-
-	return TRUE;
-}
-
 static inline void at_ack_delivery(struct ofono_sms *sms)
 {
 	struct sms_data *data =3D ofono_sms_get_data(sms);
diff --git a/drivers/cdmamodem/cdmamodem.c b/drivers/cdmamodem/cdmamodem.c
index 9eddd88..f133fb0 100644
--- a/drivers/cdmamodem/cdmamodem.c
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -36,6 +36,7 @@ static int cdmamodem_init(void)
 {
 	cdma_voicecall_init();
 	cdma_devinfo_init();
+	cdma_sms_init();
 =

 	return 0;
 }
@@ -44,6 +45,7 @@ static void cdmamodem_exit(void)
 {
 	cdma_voicecall_exit();
 	cdma_devinfo_exit();
+	cdma_sms_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(cdmamodem, "CDMA AT modem driver", VERSION,
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
index 4365bec..4ce0b3d 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -25,3 +25,5 @@ extern void cdma_voicecall_init(void);
 extern void cdma_voicecall_exit(void);
 extern void cdma_devinfo_init(void);
 extern void cdma_devinfo_exit(void);
+extern void cdma_sms_init(void);
+extern void cdma_sms_exit(void);
diff --git a/drivers/cdmamodem/sms.c b/drivers/cdmamodem/sms.c
new file mode 100644
index 0000000..df61b7d
--- /dev/null
+++ b/drivers/cdmamodem/sms.c
@@ -0,0 +1,125 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation. All rights reserved.
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
+	GAtChat *chat;
+};
+
+static void cdma_cmt_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_sms *cdma_sms =3D user_data;
+	const char *hexpdu;
+	long tpdu_len;
+	int len;
+	unsigned char tpdu[256];
+
+	if (at_parse_pdu_common(result, "+CMT:", &hexpdu, &len) !=3D TRUE) {
+		ofono_error("Unable to parse CMT notification");
+		return;
+	}
+
+	if (strlen(hexpdu) > sizeof(tpdu) * 2) {
+		ofono_error("Bad PDU length in CMT notification");
+		return;
+	}
+
+	DBG("Got new SMS Deliver PDU via CMT: %s, %d", hexpdu, len);
+
+	decode_hex_own_buf(hexpdu, -1, &tpdu_len, 0, tpdu);
+	ofono_cdma_sms_deliver_notify(cdma_sms, tpdu, tpdu_len);
+}
+
+static gboolean cdma_sms_initialized(void *user_data)
+{
+	struct ofono_cdma_sms *cdma_sms =3D user_data;
+	struct cdma_sms_data *data =3D ofono_cdma_sms_get_data(cdma_sms);
+
+	g_at_chat_register(data->chat, "+CMT:",
+				cdma_cmt_notify, TRUE, cdma_sms, NULL);
+
+	ofono_cdma_sms_register(cdma_sms);
+
+	return FALSE;
+}
+
+static int cdma_sms_probe(struct ofono_cdma_sms *cdma_sms,
+				unsigned int vendor, void *user)
+{
+	GAtChat *chat =3D user;
+	struct cdma_sms_data *data;
+
+	data =3D g_new0(struct cdma_sms_data, 1);
+	data->chat =3D g_at_chat_clone(chat);
+
+	ofono_cdma_sms_set_data(cdma_sms, data);
+
+	g_idle_add(cdma_sms_initialized, cdma_sms);
+
+	return 0;
+}
+
+static void cdma_sms_remove(struct ofono_cdma_sms *cdma_sms)
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
+	.probe		=3D cdma_sms_probe,
+	.remove		=3D cdma_sms_remove,
+};
+
+void cdma_sms_init(void)
+{
+	ofono_cdma_sms_driver_register(&driver);
+}
+
+void cdma_sms_exit(void)
+{
+	ofono_cdma_sms_driver_unregister(&driver);
+}
-- =

1.7.0.4


--===============5139841346880977108==--

