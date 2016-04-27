Content-Type: multipart/mixed; boundary="===============4386879415027134032=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] sim: Add support for query facility lock
Date: Wed, 27 Apr 2016 20:52:12 +0530
Message-ID: <1461770532-2676-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4386879415027134032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |  6 ++++++
 src/sim.c     | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 68 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index ed850f9..9470d4d 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -121,6 +121,9 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const struct=
 ofono_error *error,
 typedef void (*ofono_sim_locked_cb_t)(const struct ofono_error *error,
 					int locked, void *data);
 =

+typedef void (*ofono_query_facility_lock_cb_t)(const struct ofono_error *e=
rror,
+					ofono_bool_t status, void *data);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -173,6 +176,9 @@ struct ofono_sim_driver {
 	void (*query_locked)(struct ofono_sim *sim,
 			enum ofono_sim_password_type type,
 			ofono_sim_locked_cb_t cb, void *data);
+	void (*query_facility_lock)(struct ofono_sim *sim,
+			enum ofono_sim_password_type lock,
+			ofono_query_facility_lock_cb_t cb, void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
diff --git a/src/sim.c b/src/sim.c
index 94d8840..aedc617 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2449,6 +2449,60 @@ static void sim_free_state(struct ofono_sim *sim)
 	sim_free_main_state(sim);
 }
 =

+static void sim_query_fac_imsilock_cb(const struct ofono_error *error,
+				ofono_bool_t status,
+				void *data)
+{
+	struct ofono_sim *sim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	char **locked_pins;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Querying Facility Lock for IMSI Lock failed");
+		return;
+	}
+
+	sim->locked_pins[OFONO_SIM_PASSWORD_PHSIM_PIN] =3D status;
+
+	locked_pins =3D get_locked_pins(sim);
+
+	ofono_dbus_signal_array_property_changed(conn,
+				path,
+				OFONO_SIM_MANAGER_INTERFACE,
+				"LockedPins", DBUS_TYPE_STRING,
+				&locked_pins);
+
+	g_strfreev(locked_pins);
+}
+
+static void sim_query_fac_networklock_cb(const struct ofono_error *error,
+				ofono_bool_t status,
+				void *data)
+{
+	struct ofono_sim *sim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	char **locked_pins;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Querying Facility Lock for Network Lock failed");
+		return;
+	}
+
+	sim->locked_pins[OFONO_SIM_PASSWORD_PHNET_PIN] =3D status;
+
+	locked_pins =3D get_locked_pins(sim);
+
+	ofono_dbus_signal_array_property_changed(conn,
+				path,
+				OFONO_SIM_MANAGER_INTERFACE,
+				"LockedPins", DBUS_TYPE_STRING,
+				&locked_pins);
+
+	g_strfreev(locked_pins);
+}
+
 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
 {
 	if (sim->state =3D=3D OFONO_SIM_STATE_RESETTING && inserted) {
@@ -2475,6 +2529,14 @@ void ofono_sim_inserted_notify(struct ofono_sim *sim=
, ofono_bool_t inserted)
 	call_state_watches(sim);
 =

 	if (inserted) {
+		sim->driver->query_facility_lock(sim,
+					OFONO_SIM_PASSWORD_PHSIM_PIN,
+					sim_query_fac_imsilock_cb, sim);
+
+		sim->driver->query_facility_lock(sim,
+					OFONO_SIM_PASSWORD_PHNET_PIN,
+					sim_query_fac_networklock_cb, sim);
+
 		sim_initialize(sim);
 	} else {
 		sim->pin_type =3D OFONO_SIM_PASSWORD_NONE;
-- =

1.9.1


--===============4386879415027134032==--

