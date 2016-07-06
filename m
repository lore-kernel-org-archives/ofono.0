Content-Type: multipart/mixed; boundary="===============4470949936560384754=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] sim: Query the status of SC facility lock
Date: Wed, 06 Jul 2016 19:02:25 +0300
Message-ID: <1467820945-16764-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4470949936560384754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Resending after adjusting code style.
---
 src/sim.c | 72 +++++++++++++++++++++++++++++++----------------------------=
----
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index aedc617..e2da78d 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2449,58 +2449,50 @@ static void sim_free_state(struct ofono_sim *sim)
 	sim_free_main_state(sim);
 }
 =

-static void sim_query_fac_imsilock_cb(const struct ofono_error *error,
-				ofono_bool_t status,
-				void *data)
+static void sim_set_locked_pin(struct ofono_sim *sim,
+			enum ofono_sim_password_type type, gboolean locked)
 {
-	struct ofono_sim *sim =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path =3D __ofono_atom_get_path(sim->atom);
 	char **locked_pins;
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		ofono_error("Querying Facility Lock for IMSI Lock failed");
+	if (sim->locked_pins[type] =3D=3D locked)
 		return;
-	}
-
-	sim->locked_pins[OFONO_SIM_PASSWORD_PHSIM_PIN] =3D status;
 =

+	sim->locked_pins[type] =3D locked;
 	locked_pins =3D get_locked_pins(sim);
 =

-	ofono_dbus_signal_array_property_changed(conn,
-				path,
-				OFONO_SIM_MANAGER_INTERFACE,
-				"LockedPins", DBUS_TYPE_STRING,
-				&locked_pins);
+	ofono_dbus_signal_array_property_changed(ofono_dbus_get_connection(),
+				__ofono_atom_get_path(sim->atom),
+				OFONO_SIM_MANAGER_INTERFACE, "LockedPins",
+				DBUS_TYPE_STRING, &locked_pins);
 =

 	g_strfreev(locked_pins);
 }
 =

-static void sim_query_fac_networklock_cb(const struct ofono_error *error,
-				ofono_bool_t status,
-				void *data)
+static void sim_query_fac_imsilock_cb(const struct ofono_error *error,
+				ofono_bool_t status, void *data)
 {
-	struct ofono_sim *sim =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path =3D __ofono_atom_get_path(sim->atom);
-	char **locked_pins;
-
-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		ofono_error("Querying Facility Lock for Network Lock failed");
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
 		return;
-	}
 =

-	sim->locked_pins[OFONO_SIM_PASSWORD_PHNET_PIN] =3D status;
+	sim_set_locked_pin(data, OFONO_SIM_PASSWORD_PHSIM_PIN, status);
+}
 =

-	locked_pins =3D get_locked_pins(sim);
+static void sim_query_fac_networklock_cb(const struct ofono_error *error,
+				ofono_bool_t status, void *data)
+{
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		return;
 =

-	ofono_dbus_signal_array_property_changed(conn,
-				path,
-				OFONO_SIM_MANAGER_INTERFACE,
-				"LockedPins", DBUS_TYPE_STRING,
-				&locked_pins);
+	sim_set_locked_pin(data, OFONO_SIM_PASSWORD_PHNET_PIN, status);
+}
 =

-	g_strfreev(locked_pins);
+static void sim_query_fac_pinlock_cb(const struct ofono_error *error,
+				ofono_bool_t status, void *data)
+{
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		return;
+
+	sim_set_locked_pin(data, OFONO_SIM_PASSWORD_SIM_PIN, status);
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
@@ -2529,14 +2521,20 @@ void ofono_sim_inserted_notify(struct ofono_sim *si=
m, ofono_bool_t inserted)
 	call_state_watches(sim);
 =

 	if (inserted) {
-		sim->driver->query_facility_lock(sim,
+		if (sim->driver->query_facility_lock) {
+			sim->driver->query_facility_lock(sim,
 					OFONO_SIM_PASSWORD_PHSIM_PIN,
 					sim_query_fac_imsilock_cb, sim);
 =

-		sim->driver->query_facility_lock(sim,
+			sim->driver->query_facility_lock(sim,
 					OFONO_SIM_PASSWORD_PHNET_PIN,
 					sim_query_fac_networklock_cb, sim);
 =

+			sim->driver->query_facility_lock(sim,
+					OFONO_SIM_PASSWORD_SIM_PIN,
+					sim_query_fac_pinlock_cb, sim);
+		}
+
 		sim_initialize(sim);
 	} else {
 		sim->pin_type =3D OFONO_SIM_PASSWORD_NONE;
-- =

1.9.1


--===============4470949936560384754==--

