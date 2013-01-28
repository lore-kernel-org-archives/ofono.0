Content-Type: multipart/mixed; boundary="===============0655009835456230242=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 5/8] bluez5: Add bt_bacmp()
Date: Mon, 28 Jan 2013 18:11:05 -0300
Message-ID: <1359407468-5110-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359407468-5110-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0655009835456230242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds a copy of BlueZ bacmp() function.
---
 plugins/bluez5.c | 5 +++++
 plugins/bluez5.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index d7e85f2..d5c566e 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -52,6 +52,11 @@ int bt_ba2str(const bdaddr_t *ba, char *str)
 		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
 }
 =

+int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
+{
+	return memcmp(ba1, ba2, sizeof(bdaddr_t));
+}
+
 static void profile_register_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 204c41d..95914c2 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -60,6 +60,8 @@ void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src);
 =

 int bt_ba2str(const bdaddr_t *ba, char *str);
 =

+int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2);
+
 int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object);
 =

-- =

1.7.11.7


--===============0655009835456230242==--

