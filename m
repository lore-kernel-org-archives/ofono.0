Content-Type: multipart/mixed; boundary="===============3932031288749502427=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] Don't use g_slist_length to check for empty lists.
Date: Thu, 30 Jul 2009 10:05:10 +0200
Message-ID: <1248941110-13176-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3932031288749502427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A glib Anti-pattern according to http://www.burtonini.com/blog
---
 src/voicecall.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 409d97a..b343ed6 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -897,7 +897,7 @@ static DBusMessage *manager_hangup_all(DBusConnection *=
conn,
 	if (!calls->ops->release_specific)
 		return dbus_gsm_not_implemented(msg);
 =

-	if (g_slist_length(calls->call_list) =3D=3D 0) {
+	if (calls->call_list =3D=3D NULL) {
 		DBusMessage *reply =3D dbus_message_new_method_return(msg);
 		return reply;
 	}
@@ -1009,7 +1009,7 @@ static DBusMessage *multiparty_hangup(DBusConnection =
*conn,
 	if (!calls->ops->release_all_active)
 		return dbus_gsm_not_implemented(msg);
 =

-	if (g_slist_length(calls->multiparty_list) =3D=3D 0) {
+	if (calls->multiparty_list =3D=3D NULL) {
 		DBusMessage *reply =3D dbus_message_new_method_return(msg);
 		return reply;
 	}
@@ -1362,7 +1362,7 @@ static void multirelease_callback(const struct ofono_=
error *error, void *data)
 	DBusConnection *conn =3D dbus_gsm_connection();
 	DBusMessage *reply;
 =

-	if (g_slist_length(calls->release_list)) {
+	if (calls->release_list !=3D NULL) {
 		voicecalls_release_next(modem);
 		return;
 	}
-- =

1.6.1


--===============3932031288749502427==--

