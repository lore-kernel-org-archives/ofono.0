Content-Type: multipart/mixed; boundary="===============8273437508947969680=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 2/8] bluez5: Add bt_bacpy()
Date: Mon, 28 Jan 2013 18:11:02 -0300
Message-ID: <1359407468-5110-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359407468-5110-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8273437508947969680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds a copy of BlueZ bacpy() function.
---
 plugins/bluez5.c | 6 ++++++
 plugins/bluez5.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index d471454..876ad2d 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -26,6 +26,7 @@
 #include <errno.h>
 #include <stdint.h>
 #include <sys/socket.h>
+#include <string.h>
 =

 #include <glib.h>
 =

@@ -39,6 +40,11 @@
 =

 #define BLUEZ_PROFILE_MGMT_INTERFACE   BLUEZ_SERVICE ".ProfileManager1"
 =

+void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src)
+{
+	memcpy(dst, src, sizeof(bdaddr_t));
+}
+
 static void profile_register_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index fd0704e..3921c7b 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -56,6 +56,8 @@ struct sockaddr_sco {
 	bdaddr_t	sco_bdaddr;
 };
 =

+void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src);
+
 int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object);
 =

-- =

1.7.11.7


--===============8273437508947969680==--

