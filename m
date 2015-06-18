Content-Type: multipart/mixed; boundary="===============7290912181573748828=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 1/2] [sim] Emit LockedPins after pin_type is queried
Date: Thu, 18 Jun 2015 14:46:56 +0300
Message-ID: <1434628017-28441-2-git-send-email-tommi.kenakkala@tieto.com>
In-Reply-To: <1434628017-28441-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7290912181573748828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes property change not being emited when hot-swapping a
PIN-enabled card.
---
 src/sim.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/sim.c b/src/sim.c
index b5badf1..0bcafe0 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2737,6 +2737,10 @@ static void sim_pin_query_cb(const struct ofono_erro=
r *error,
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(sim->atom);
 	const char *pin_name;
+	char **locked_pins;
+	gboolean lock_changed;
+
+	DBG("sim->pin_type: %d, pin_type: %d", sim->pin_type, pin_type);
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Querying PIN authentication state failed");
@@ -2751,9 +2755,23 @@ static void sim_pin_query_cb(const struct ofono_erro=
r *error,
 				password_is_pin(pin_type) =3D=3D FALSE)
 			pin_type =3D puk2pin(pin_type);
 =

-		if (pin_type !=3D OFONO_SIM_PASSWORD_INVALID)
+		if (pin_type !=3D OFONO_SIM_PASSWORD_INVALID) {
+			lock_changed =3D !sim->locked_pins[pin_type];
+
 			sim->locked_pins[pin_type] =3D TRUE;
 =

+			if (lock_changed) {
+				locked_pins =3D get_locked_pins(sim);
+
+				ofono_dbus_signal_array_property_changed(conn,
+						path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"LockedPins", DBUS_TYPE_STRING,
+						&locked_pins);
+
+				g_strfreev(locked_pins);
+			}
+		}
 		ofono_dbus_signal_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
 						"PinRequired", DBUS_TYPE_STRING,
-- =

1.7.9.5


--===============7290912181573748828==--

