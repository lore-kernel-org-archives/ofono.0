Content-Type: multipart/mixed; boundary="===============3388919689645420238=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 2/6] Use ofono_bool_t with D-Bus API.
Date: Thu, 27 May 2010 19:12:44 +0300
Message-ID: <1274976768-1555-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1274976768-1555-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3388919689645420238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index ce262cb..2cb3e50 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -595,13 +595,11 @@ static gboolean set_powered_timeout(gpointer user)
 =

 	if (modem->powered_pending =3D=3D FALSE) {
 		DBusConnection *conn =3D ofono_dbus_get_connection();
-		dbus_bool_t powered =3D FALSE;
-
 		modem->powered =3D FALSE;
 		ofono_dbus_signal_property_changed(conn, modem->path,
 						OFONO_MODEM_INTERFACE,
 						"Powered", DBUS_TYPE_BOOLEAN,
-						&powered);
+						&modem->powered);
 	} else {
 		modem->powered_pending =3D modem->powered;
 	}
@@ -720,7 +718,6 @@ void ofono_modem_set_powered(struct ofono_modem *modem,=
 ofono_bool_t powered)
 	modem->powered_pending =3D powered;
 =

 	if (modem->powered !=3D powered) {
-		dbus_bool_t dbus_powered =3D powered;
 		modem->powered =3D powered;
 =

 		if (modem->driver =3D=3D NULL) {
@@ -733,7 +730,7 @@ void ofono_modem_set_powered(struct ofono_modem *modem,=
 ofono_bool_t powered)
 		ofono_dbus_signal_property_changed(conn, modem->path,
 						OFONO_MODEM_INTERFACE,
 						"Powered", DBUS_TYPE_BOOLEAN,
-						&dbus_powered);
+						&powered);
 =

 		if (powered)
 			modem_change_state(modem, MODEM_STATE_PRE_SIM);
-- =

1.6.3.3


--===============3388919689645420238==--

