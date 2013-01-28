Content-Type: multipart/mixed; boundary="===============1578382234321442455=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 4/8] bluez5: Add bt_ba2str()
Date: Mon, 28 Jan 2013 18:11:04 -0300
Message-ID: <1359407468-5110-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359407468-5110-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1578382234321442455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds a copy of BlueZ ba2str() function.
---
 plugins/bluez5.c        | 7 +++++++
 plugins/bluez5.h        | 2 ++
 plugins/hfp_hf_bluez5.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 876ad2d..d7e85f2 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <stdint.h>
+#include <stdio.h>
 #include <sys/socket.h>
 #include <string.h>
 =

@@ -45,6 +46,12 @@ void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src)
 	memcpy(dst, src, sizeof(bdaddr_t));
 }
 =

+int bt_ba2str(const bdaddr_t *ba, char *str)
+{
+	return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
+}
+
 static void profile_register_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 3921c7b..204c41d 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -58,6 +58,8 @@ struct sockaddr_sco {
 =

 void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src);
 =

+int bt_ba2str(const bdaddr_t *ba, char *str);
+
 int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object);
 =

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index e7d8717..87ae5e3 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -26,6 +26,7 @@
 #include <errno.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include <unistd.h>
 #include <string.h>
 #include <fcntl.h>
-- =

1.7.11.7


--===============1578382234321442455==--

