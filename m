Content-Type: multipart/mixed; boundary="===============0908687679530885095=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH v4, 6/7] test: Add CDMA SMS Support
Date: Tue, 18 Jan 2011 14:54:22 -0800
Message-ID: <1295391263-31592-4-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <Y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0908687679530885095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    6 ++-
 unit/test-cdmasms.c |  116 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 121 insertions(+), 1 deletions(-)
 create mode 100644 unit/test-cdmasms.c

diff --git a/Makefile.am b/Makefile.am
index 7548942..11fc274 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -489,7 +489,7 @@ dist_man_MANS =3D doc/ofonod.8
 noinst_PROGRAMS =3D unit/test-common unit/test-util unit/test-idmap \
 					unit/test-sms unit/test-simutil \
 					unit/test-mux unit/test-caif \
-					unit/test-stkutil
+					unit/test-stkutil unit/test-cdmasms
 =

 unit_objects =3D
 =

@@ -509,6 +509,10 @@ unit_test_sms_SOURCES =3D unit/test-sms.c src/util.c s=
rc/smsutil.c src/storage.c
 unit_test_sms_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_sms_OBJECTS)
 =

+unit_test_cdmasms_SOURCES =3D unit/test-cdmasms.c src/cdma-smsutil.c
+unit_test_cdmasms_LDADD =3D @GLIB_LIBS@
+unit_objects +=3D $(unit_test_cdmasms_OBJECTS)
+
 unit_test_simutil_SOURCES =3D unit/test-simutil.c src/util.c \
 				src/simutil.c src/smsutil.c src/storage.c
 unit_test_simutil_LDADD =3D @GLIB_LIBS@
diff --git a/unit/test-cdmasms.c b/unit/test-cdmasms.c
new file mode 100644
index 0000000..5140bc7
--- /dev/null
+++ b/unit/test-cdmasms.c
@@ -0,0 +1,116 @@
+/*
+ * oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010-2011 Nokia Corporation.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
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
+
+#include "cdma-smsutil.h"
+
+static inline void check_text(const char *decoded, const char *expected)
+{
+	if (expected =3D=3D NULL) {
+		g_assert(decoded =3D=3D NULL);
+		return;
+	}
+
+	g_assert(decoded !=3D NULL);
+	g_assert(g_str_equal(decoded, expected));
+}
+
+struct wmt_deliver_test {
+	const guint8 *tpdu;
+	guint8 tpdu_len;
+	const char *text;
+	const char *oaddr;
+};
+
+guint8 wmt_deliver_1[] =3D {0x00, 0x00, 0x02, 0x10, 0x02, 0x02, 0x05, 0x01,
+				0xC4, 0x8D, 0x15, 0x9C, 0x08, 0x0D, 0x00,
+				0x03, 0x1B, 0xEE, 0xF0, 0x01, 0x06, 0x10,
+				0x2C, 0x8C, 0xBB, 0x36, 0x6F};
+
+guint8 wmt_deliver_2[] =3D {0x00, 0x00, 0x02, 0x10, 0x02, 0x02, 0x07, 0x02,
+				0xA1, 0x62, 0x51, 0x55, 0xA6, 0x40, 0x08,
+				0x18, 0x00, 0x03, 0x10, 0x00, 0x40, 0x01,
+				0x06, 0x10, 0x25, 0x4C, 0xBC, 0xFA, 0x00,
+				0x03, 0x06, 0x03, 0x08, 0x20, 0x13, 0x43,
+				0x12, 0x0D, 0x01, 0x01};
+
+static struct wmt_deliver_test wmt_deliver_data_1 =3D {
+	.tpdu =3D wmt_deliver_1,
+	.tpdu_len =3D sizeof(wmt_deliver_1),
+	.text =3D "Hello",
+	.oaddr =3D "1234567"
+};
+
+static struct wmt_deliver_test wmt_deliver_data_2 =3D {
+	.tpdu =3D wmt_deliver_2,
+	.tpdu_len =3D sizeof(wmt_deliver_2),
+	.text =3D "Test",
+	.oaddr =3D "8589455699"
+};
+
+static void test_wmt_deliver(gconstpointer data)
+{
+	const struct wmt_deliver_test *test =3D data;
+	gboolean ret;
+	struct cdma_sms s;
+	const char *addr;
+	char *message;
+
+	memset(&s, 0, sizeof(struct cdma_sms));
+
+	ret =3D cdma_sms_decode(test->tpdu, test->tpdu_len, &s);
+
+	g_assert(ret =3D=3D TRUE);
+
+	g_assert(s.type =3D=3D CDMA_SMS_TP_MSG_TYPE_P2P);
+
+	g_assert(s.p2p_msg.teleservice_id =3D=3D CDMA_SMS_TELESERVICE_ID_WMT);
+
+	addr =3D cdma_sms_address_to_string(&s.p2p_msg.oaddr);
+	check_text(addr, test->oaddr);
+
+	message =3D cdma_sms_decode_text(&s.p2p_msg.bd.wmt_deliver.ud);
+	check_text(message, test->text);
+
+	g_free(message);
+
+	return;
+}
+
+int main(int argc, char **argv)
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_data_func("/test-cdmasms/WMT DELIVER 1",
+			&wmt_deliver_data_1, test_wmt_deliver);
+
+	g_test_add_data_func("/test-cdmasms/WMT DELIVER 2",
+			&wmt_deliver_data_2, test_wmt_deliver);
+
+	return g_test_run();
+}
-- =

1.7.0.4


--===============0908687679530885095==--

