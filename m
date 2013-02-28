Content-Type: multipart/mixed; boundary="===============1818530807919768612=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 01/10] bluetooth: Add new Bluetooth header
Date: Thu, 28 Feb 2013 15:52:43 -0300
Message-ID: <1362077572-28049-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1818530807919768612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch moves the Bluetooth utility funtions and socket type
declarations to a new header src/bluetooth.h, allowing to share it
between core, and plugins.
---
 Makefile.am             |  2 +-
 plugins/bluez5.c        | 17 ------------
 plugins/bluez5.h        | 41 ----------------------------
 plugins/hfp_hf_bluez5.c |  1 +
 src/bluetooth.h         | 71 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 73 insertions(+), 59 deletions(-)
 create mode 100644 src/bluetooth.h

diff --git a/Makefile.am b/Makefile.am
index 557f499..3b998af 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -509,7 +509,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/cdma-smsutil.h src/cdma-smsutil.c \
 			src/cdma-sms.c src/private-network.c src/cdma-netreg.c \
 			src/cdma-provision.c src/handsfree.c \
-			src/handsfree-audio.c
+			src/handsfree-audio.c src/bluetooth.h
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -ldl
 =

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 788f3a2..278f062 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -26,7 +26,6 @@
 #include <errno.h>
 #include <stdint.h>
 #include <stdio.h>
-#include <sys/socket.h>
 #include <string.h>
 =

 #include <glib.h>
@@ -48,22 +47,6 @@ struct finish_callback {
 	char *member;
 };
 =

-void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src)
-{
-	memcpy(dst, src, sizeof(bdaddr_t));
-}
-
-int bt_ba2str(const bdaddr_t *ba, char *str)
-{
-	return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
-}
-
-int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
-{
-	return memcmp(ba1, ba2, sizeof(bdaddr_t));
-}
-
 static void profile_register_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 1432068..f6c3b66 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -28,47 +28,6 @@
 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 =

-#ifndef AF_BLUETOOTH
-#define AF_BLUETOOTH		31
-#define PF_BLUETOOTH		AF_BLUETOOTH
-#endif
-
-#define BTPROTO_SCO		2
-
-#define SOL_SCO			17
-
-#ifndef SOL_BLUETOOTH
-#define SOL_BLUETOOTH		274
-#endif
-
-#define BT_DEFER_SETUP		7
-
-/* BD Address */
-typedef struct {
-	uint8_t b[6];
-} __attribute__((packed)) bdaddr_t;
-
-#define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
-
-/* RFCOMM socket address */
-struct sockaddr_rc {
-	sa_family_t	rc_family;
-	bdaddr_t	rc_bdaddr;
-	uint8_t		rc_channel;
-};
-
-/* SCO socket address */
-struct sockaddr_sco {
-	sa_family_t	sco_family;
-	bdaddr_t	sco_bdaddr;
-};
-
-void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src);
-
-int bt_ba2str(const bdaddr_t *ba, char *str);
-
-int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2);
-
 int bt_register_profile(DBusConnection *conn, const char *uuid,
 					uint16_t version, const char *name,
 					const char *object);
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2db2fa5..dea0f34 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -51,6 +51,7 @@
 =

 #include <drivers/hfpmodem/slc.h>
 =

+#include "bluetooth.h"
 #include "bluez5.h"
 =

 #ifndef DBUS_TYPE_UNIX_FD
diff --git a/src/bluetooth.h b/src/bluetooth.h
new file mode 100644
index 0000000..1584109
--- /dev/null
+++ b/src/bluetooth.h
@@ -0,0 +1,71 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+#ifndef AF_BLUETOOTH
+#define AF_BLUETOOTH		31
+#define PF_BLUETOOTH		AF_BLUETOOTH
+#endif
+
+#define BTPROTO_SCO		2
+
+#define SOL_SCO			17
+
+#ifndef SOL_BLUETOOTH
+#define SOL_BLUETOOTH		274
+#endif
+
+#define BT_DEFER_SETUP		7
+
+/* BD Address */
+typedef struct {
+	uint8_t b[6];
+} __attribute__((packed)) bdaddr_t;
+
+#define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
+
+/* RFCOMM socket address */
+struct sockaddr_rc {
+	sa_family_t	rc_family;
+	bdaddr_t	rc_bdaddr;
+	uint8_t		rc_channel;
+};
+
+/* SCO socket address */
+struct sockaddr_sco {
+	sa_family_t	sco_family;
+	bdaddr_t	sco_bdaddr;
+};
+
+static inline void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src)
+{
+	memcpy(dst, src, sizeof(bdaddr_t));
+}
+
+static inline int bt_ba2str(const bdaddr_t *ba, char *str)
+{
+	return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
+}
+
+static inline int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
+{
+	return memcmp(ba1, ba2, sizeof(bdaddr_t));
+}
-- =

1.7.11.7


--===============1818530807919768612==--

