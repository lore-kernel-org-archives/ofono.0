Content-Type: multipart/mixed; boundary="===============2864574223570764821=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH 5/5] test: Add CDMA SMS unit test code
Date: Wed, 08 Dec 2010 16:35:51 -0800
Message-ID: <1291854951-2378-6-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2864574223570764821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    6 ++-
 unit/test-cdmasms.c |  134 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 139 insertions(+), 1 deletions(-)
 create mode 100644 unit/test-cdmasms.c

diff --git a/Makefile.am b/Makefile.am
index 44a6395..4a91993 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -458,7 +458,7 @@ dist_man_MANS =3D doc/ofonod.8
 noinst_PROGRAMS =3D unit/test-common unit/test-util unit/test-idmap \
 					unit/test-sms unit/test-simutil \
 					unit/test-mux unit/test-caif \
-					unit/test-stkutil
+					unit/test-stkutil unit/test-cdmasms
 =

 unit_objects =3D
 =

@@ -478,6 +478,10 @@ unit_test_sms_SOURCES =3D unit/test-sms.c src/util.c s=
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
index 0000000..9aabd2b
--- /dev/null
+++ b/unit/test-cdmasms.c
@@ -0,0 +1,134 @@
+/*
+ * oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation.  All rights reserved.
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
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
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
+
+#include "cdma-smsutil.h"
+
+static void cdmasms_receive_test1()
+{
+	gboolean ret;
+	struct cdma_sms s;
+	char *addr;
+	char *message;
+
+    /*
+		0x00,  :P2P
+		0x00, 0x02, 0x10, 0x02, :Teleservice Id
+		0x02, 0x05, 0x01, 0xC4, 0x8D, 0x15, 0x9C, :Orig Addr
+		0x08, 0x0D, :Bearer Data
+			0x00, 0x03, 0x1B, 0xEE, 0xF0, 0x01, :Message Id
+			0x06, 0x10, 0x2C, 0x8C, 0xBB, 0x36, 0x6F :User Data
+	*/
+	guint8 mt_sms_pdu[] =3D {
+		0x00, 0x00, 0x02, 0x10, 0x02, 0x02, 0x05, 0x01, 0xC4, 0x8D, 0x15,
+		0x9C, 0x08, 0x0D, 0x00, 0x03, 0x1B, 0xEE, 0xF0, 0x01, 0x06, 0x10,
+		0x2C, 0x8C, 0xBB, 0x36, 0x6F
+	};
+
+	memset(&s, 0, sizeof(struct cdma_sms));
+
+	/* Decode the incoming SMS TPDU */
+	ret =3D cdmasms_decode(mt_sms_pdu, sizeof(mt_sms_pdu), &s);
+
+	g_assert(ret =3D=3D TRUE);
+
+	/* Verify message type is Point to Point */
+	g_assert(s.type =3D=3D CDMASMS_P2P);
+
+	/* Verify teleservice id is WMT */
+	g_assert(s.p2p_msg.teleservice_id =3D=3D TELESERVICE_WMT);
+
+	addr =3D cdmasms_address_to_string(&s.p2p_msg.oaddr);
+	g_assert(strcmp(addr, "1234567") =3D=3D 0);
+
+	message =3D cdmasms_decode_text(&s.p2p_msg.bearer_data.ud);
+	g_assert(strcmp(message, "Hello") =3D=3D 0);
+
+	return;
+}
+
+static void cdmasms_receive_test2()
+{
+	gboolean ret;
+	struct cdma_sms s;
+	char *addr;
+	char *message;
+
+	/*
+		0x00, :Point-to-Point
+		0x00, 0x02, 0x10, 0x02, :Teleservie ID
+		0x02, 0x07, 0x02, 0xA1, 0x62, 0x51, 0x55, 0xA6, 0x40, :Orig Address
+		0x08, 0x18, :Bearer Data
+		0x00, 0x03, 0x10, 0x00, 0x40, :Message Identifier
+		0x01, 0x06, 0x10, 0x25, 0x4C, 0xBC, 0xFA, 0x00, :User Data
+		0x03, 0x06, 0x03, 0x08, 0x20, 0x13, 0x43, 0x12, :MC Time Stamp
+		0x0D, 0x01, 0x01 :Language Indicator
+	*/
+	guint8 mt_sms_pdu[] =3D {
+		0x00, 0x00, 0x02, 0x10, 0x02, 0x02, 0x07, 0x02, 0xA1, 0x62, 0x51,
+		0x55, 0xA6, 0x40, 0x08, 0x18, 0x00, 0x03, 0x10, 0x00, 0x40, 0x01,
+		0x06, 0x10, 0x25, 0x4C, 0xBC, 0xFA, 0x00, 0x03, 0x06, 0x03, 0x08,
+		0x20, 0x13, 0x43, 0x12, 0x0D, 0x01, 0x01
+	};
+
+	memset(&s, 0, sizeof(struct cdma_sms));
+
+	/* Decode the incoming SMS TPDU */
+	ret =3D cdmasms_decode(mt_sms_pdu, sizeof(mt_sms_pdu), &s);
+
+	g_assert(ret =3D=3D TRUE);
+
+	/* Verify message type is Point to Point */
+	g_assert(s.type =3D=3D CDMASMS_P2P);
+
+	/* Verify teleservice id is WMT */
+	g_assert(s.p2p_msg.teleservice_id =3D=3D TELESERVICE_WMT);
+
+	addr =3D cdmasms_address_to_string(&s.p2p_msg.oaddr);
+	g_assert(strcmp(addr, "8589455699") =3D=3D 0);
+
+	message =3D cdmasms_decode_text(&s.p2p_msg.bearer_data.ud);
+	g_assert(s.p2p_msg.bearer_data.ud.num_fields =3D=3D 4);
+	g_assert(strcmp(message, "Test") =3D=3D 0);
+
+	return;
+}
+
+
+int main(int argc, char **argv)
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_func("/test-cdmasms/Test Simple Msg Receive 1",
+			cdmasms_receive_test1);
+
+	g_test_add_func("/test-cdmasms/Test Simple Msg Receive 2",
+			cdmasms_receive_test2);
+
+	return g_test_run();
+}
-- =

1.7.0.4


--===============2864574223570764821==--

