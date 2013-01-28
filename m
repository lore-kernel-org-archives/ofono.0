Content-Type: multipart/mixed; boundary="===============8806884159124961702=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 5/9] bluez5: Add bt_getsockpeers()
Date: Mon, 28 Jan 2013 11:44:15 -0300
Message-ID: <1359384259-5384-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359384259-5384-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8806884159124961702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a generic Bluetooth helper function to allow getting
the adapter and device Bluetooth Address from Bluetooth sockets.
---
 plugins/bluez5.c | 22 ++++++++++++++++++++++
 plugins/bluez5.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index d7e85f2..06629e1 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -52,6 +52,28 @@ int bt_ba2str(const bdaddr_t *ba, char *str)
 		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
 }
 =

+int bt_getsockpeers(int sock, struct sockaddr *src, struct sockaddr *dst,
+								socklen_t len)
+{
+	socklen_t olen;
+
+	if (src) {
+		memset(src, 0, len);
+		olen =3D len;
+		if (getsockname(sock, src, &olen) < 0)
+			return -errno;
+	}
+
+	if (dst) {
+		memset(dst, 0, len);
+		olen =3D len;
+		if (getpeername(sock, dst, &olen) < 0)
+			return -errno;
+	}
+
+	return 0;
+}
+
 static void profile_register_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 204c41d..2d70fbf 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -60,6 +60,9 @@ void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src);
 =

 int bt_ba2str(const bdaddr_t *ba, char *str);
 =

+int bt_getsockpeers(int sock, struct sockaddr *src, struct sockaddr *dst,
+								socklen_t len);
+
 int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object);
 =

-- =

1.7.11.7


--===============8806884159124961702==--

