Content-Type: multipart/mixed; boundary="===============8074733824532155562=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 2/7] voicecall: Rename callbacks/functions related to dialing
 the last called number
Date: Wed, 06 Dec 2017 17:35:59 +0200
Message-ID: <20171206153604.15080-3-philippedeswert@gmail.com>
In-Reply-To: <20171206153604.15080-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8074733824532155562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Calling from memory index is very similar in functionality to dialing the
last called number. So we rename the functions so we can reuse them, to deal
with memory index calling.

---
 src/voicecall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 9f323c6e..67384cf2 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1577,7 +1577,7 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 	return __ofono_error_failed(msg);
 }
 =

-static void manager_dial_last_callback(const struct ofono_error *error,
+static void manager_dial_shortcut_callback(const struct ofono_error *error,
 								void *data)
 {
 	struct ofono_voicecall *vc =3D data;
@@ -1605,7 +1605,7 @@ error:
 					__ofono_error_failed(vc->pending));
 }
 =

-static int voicecall_dial_last(struct ofono_voicecall *vc, enum ofono_clir=
_option clir,
+static int voicecall_dial_shortcut(struct ofono_voicecall *vc, enum ofono_=
clir_option clir,
 					ofono_voicecall_cb_t cb, void *data)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
@@ -1654,7 +1654,7 @@ static DBusMessage *manager_dial_last(DBusConnection =
*conn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

-	err =3D voicecall_dial_last(vc, clir, manager_dial_last_callback, vc);
+	err =3D voicecall_dial_shortcut(vc, clir, manager_dial_shortcut_callback,=
 vc);
 =

 	if (err >=3D 0)
 		return NULL;
-- =

2.11.0


--===============8074733824532155562==--

