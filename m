Content-Type: multipart/mixed; boundary="===============2332365618632421819=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 1/3] message-waiting: check for NULL argument
Date: Fri, 21 Jan 2011 14:44:04 +0200
Message-ID: <1295613846-19309-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2332365618632421819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/message-waiting.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index d8bfe34..0e376b6 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -926,11 +926,18 @@ static void message_waiting_unregister(struct ofono_a=
tom *atom)
 =

 void ofono_message_waiting_register(struct ofono_message_waiting *mw)
 {
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path =3D __ofono_atom_get_path(mw->atom);
-	struct ofono_modem *modem =3D __ofono_atom_get_modem(mw->atom);
+	DBusConnection *conn;
+	const char *path;
+	struct ofono_modem *modem;
 	struct ofono_atom *sim_atom;
 =

+	if (mw =3D=3D NULL)
+		return;
+
+	conn =3D ofono_dbus_get_connection();
+	modem =3D __ofono_atom_get_modem(mw->atom);
+	path =3D __ofono_atom_get_path(mw->atom);
+
 	if (!g_dbus_register_interface(conn, path,
 					OFONO_MESSAGE_WAITING_INTERFACE,
 					message_waiting_methods,
-- =

1.7.1


--===============2332365618632421819==--

