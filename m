Content-Type: multipart/mixed; boundary="===============8256777193128023124=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 1/8] bluez5: Add SCO socket declarations
Date: Mon, 28 Jan 2013 18:11:01 -0300
Message-ID: <1359407468-5110-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359407468-5110-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8256777193128023124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds local copy of SCO Bluetooth sockets declarations, since the
objective to avoid including BlueZ library headers.
---
 plugins/bluez5.c        |  3 +++
 plugins/bluez5.h        | 28 ++++++++++++++++++++++++++++
 plugins/hfp_hf_bluez5.c |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 8d8b565..d471454 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -24,6 +24,9 @@
 #endif
 =

 #include <errno.h>
+#include <stdint.h>
+#include <sys/socket.h>
+
 #include <glib.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 3aa8ffe..fd0704e 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -28,6 +28,34 @@
 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 =

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
+/* SCO socket address */
+struct sockaddr_sco {
+	sa_family_t	sco_family;
+	bdaddr_t	sco_bdaddr;
+};
+
 int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object);
 =

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index f6ceb76..0e496ee 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -24,9 +24,11 @@
 #endif
 =

 #include <errno.h>
+#include <stdint.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
+#include <sys/socket.h>
 =

 #include <glib.h>
 =

-- =

1.7.11.7


--===============8256777193128023124==--

