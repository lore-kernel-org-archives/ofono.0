Content-Type: multipart/mixed; boundary="===============4934439507930939215=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/4] Simplify ofono_modem_set_powered() logic
Date: Tue, 16 Nov 2010 18:49:06 -0200
Message-ID: <1289940549-14896-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4934439507930939215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   47 +++++++++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 3776461..3fb6809 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -752,6 +752,7 @@ static GDBusSignalTable modem_signals[] =3D {
 void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t power=
ed)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t dbus_powered =3D powered;
 =

 	if (modem->timeout > 0) {
 		g_source_remove(modem->timeout);
@@ -771,32 +772,34 @@ void ofono_modem_set_powered(struct ofono_modem *mode=
m, ofono_bool_t powered)
 =

 	modem->powered_pending =3D powered;
 =

-	if (modem->powered !=3D powered) {
-		dbus_bool_t dbus_powered =3D powered;
-		modem->powered =3D powered;
+	if (modem->powered =3D=3D powered)
+		goto out;
 =

-		if (modem->driver =3D=3D NULL) {
-			ofono_error("Calling ofono_modem_set_powered on a"
-					"modem with no driver is not valid, "
-					"please fix the modem driver.");
-			return;
-		}
+	modem->powered =3D powered;
 =

-		ofono_dbus_signal_property_changed(conn, modem->path,
-						OFONO_MODEM_INTERFACE,
-						"Powered", DBUS_TYPE_BOOLEAN,
-						&dbus_powered);
+	if (modem->driver =3D=3D NULL) {
+		ofono_error("Calling ofono_modem_set_powered on a"
+				"modem with no driver is not valid, "
+				"please fix the modem driver.");
+		return;
+	}
 =

-		if (powered) {
-			modem_change_state(modem, MODEM_STATE_PRE_SIM);
+	ofono_dbus_signal_property_changed(conn, modem->path,
+					OFONO_MODEM_INTERFACE,
+					"Powered", DBUS_TYPE_BOOLEAN,
+					&dbus_powered);
 =

-			/* Force SIM Ready for devies with no sim atom */
-			if (__ofono_modem_find_atom(modem,
-						OFONO_ATOM_TYPE_SIM) =3D=3D NULL)
-				sim_state_watch(OFONO_SIM_STATE_READY, modem);
-		} else
-			modem_change_state(modem, MODEM_STATE_POWER_OFF);
-	}
+	if (powered) {
+		modem_change_state(modem, MODEM_STATE_PRE_SIM);
+
+		/* Force SIM Ready for devies with no sim atom */
+		if (__ofono_modem_find_atom(modem,
+					OFONO_ATOM_TYPE_SIM) =3D=3D NULL)
+			sim_state_watch(OFONO_SIM_STATE_READY, modem);
+	} else
+		modem_change_state(modem, MODEM_STATE_POWER_OFF);
+
+out:
 =

 	if (powering_down && powered =3D=3D FALSE) {
 		modems_remaining -=3D 1;
-- =

1.7.3.1


--===============4934439507930939215==--

