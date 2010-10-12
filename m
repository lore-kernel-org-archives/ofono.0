Content-Type: multipart/mixed; boundary="===============5664400403174020783=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 7/8] sim: check if Fixed Dialing is enabled in the SIM-card
Date: Tue, 12 Oct 2010 18:18:13 +0300
Message-ID: <1286896694-3054-8-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1286896694-3054-7-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5664400403174020783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If FD is enabled, halt SIM initialization procedure.
New property (FixedDialing) is added. If FD is enabled,
this has been signalled via DBUS.
---
 src/sim.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
----
 1 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index f0633bb..4836f55 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -71,6 +71,7 @@ struct ofono_sim {
 	unsigned char efest_length;
 	unsigned char *efsst;
 	unsigned char efsst_length;
+	gboolean fixed_dialing;
 =

 	char *imsi;
 =

@@ -307,6 +308,9 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 		ofono_dbus_dict_append(&dict, "SubscriberIdentity",
 					DBUS_TYPE_STRING, &sim->imsi);
 =

+	ofono_dbus_dict_append(&dict, "FixedDialing", DBUS_TYPE_BOOLEAN,
+				&sim->fixed_dialing);
+
 	if (sim->mnc_length) {
 		char mcc[OFONO_MAX_MCC_LENGTH + 1];
 		char mnc[OFONO_MAX_MNC_LENGTH + 1];
@@ -1061,12 +1065,41 @@ static void sim_retrieve_imsi(struct ofono_sim *sim)
 	sim->driver->read_imsi(sim, sim_imsi_cb, sim);
 }
 =

+static void sim_info_read_cb(int ok, int length, int record,
+					const unsigned char *file_status,
+					int record_length, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+
+	if (!ok)
+		goto out;
+
+	if (*file_status !=3D SIM_FILE_STATUS_NOT_INVALID) {
+
+		sim->fixed_dialing =3D TRUE;
+
+		ofono_dbus_signal_property_changed(conn, path,
+					OFONO_SIM_MANAGER_INTERFACE,
+					"FixedDialing",
+					DBUS_TYPE_BOOLEAN,
+					&sim->fixed_dialing);
+		return;
+	}
+
+out:
+	sim_retrieve_imsi(sim);
+}
+
 static void sim_efsst_read_cb(int ok, int length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
 {
 	struct ofono_sim *sim =3D userdata;
 =

+	sim->fixed_dialing =3D FALSE;
+
 	if (!ok)
 		goto out;
 =

@@ -1078,6 +1111,21 @@ static void sim_efsst_read_cb(int ok, int length, in=
t record,
 	sim->efsst =3D g_memdup(data, length);
 	sim->efsst_length =3D length;
 =

+	/*
+	 * Check if Fixed Dialing is enabled in the SIM-card
+	 * (TS 11.11/TS 51.011, Section 9.3: FDN capability request).
+	 * If FDN is activated and ADN is invalidated,
+	 * don't continue initialization routine.
+	 */
+	if (sim_sst_is_active(sim->efsst, sim->efsst_length,
+				SIM_SST_SERVICE_FDN)) {
+
+		ofono_sim_read_info(sim, SIM_EFADN_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_FIXED,
+					sim_info_read_cb, sim);
+		return;
+	}
+
 out:
 	sim_retrieve_imsi(sim);
 }
@@ -1087,6 +1135,8 @@ static void sim_efest_read_cb(int ok, int length, int=
 record,
 				int record_length, void *userdata)
 {
 	struct ofono_sim *sim =3D userdata;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
 =

 	if (!ok)
 		goto out;
@@ -1099,6 +1149,24 @@ static void sim_efest_read_cb(int ok, int length, in=
t record,
 	sim->efest =3D g_memdup(data, length);
 	sim->efest_length =3D length;
 =

+	/*
+	 * Check if Fixed Dialing is enabled in the USIM-card
+	 * (TS 31.102, Section 5.3.2: FDN capability request).
+	 * If FDN is activated, don't continue initialization routine.
+	 */
+	if (sim_est_is_active(sim->efest, sim->efest_length,
+				SIM_EST_SERVICE_FDN)) {
+
+		sim->fixed_dialing =3D TRUE;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"FixedDialing",
+						DBUS_TYPE_BOOLEAN,
+						&sim->fixed_dialing);
+		return;
+	}
+
 out:
 	sim_retrieve_imsi(sim);
 }
@@ -1109,6 +1177,8 @@ static void sim_efust_read_cb(int ok, int length, int=
 record,
 {
 	struct ofono_sim *sim =3D userdata;
 =

+	sim->fixed_dialing =3D FALSE;
+
 	if (!ok)
 		goto out;
 =

@@ -1183,15 +1253,6 @@ static void sim_efphase_read_cb(int ok, int length, =
int record,
 		sim->phase =3D data[0];
 }
 =

-static void sim_info_read_cb(int ok, int length, int record,
-					const unsigned char *file_status,
-					int record_length, void *userdata)
-{
-	DBG("OK: %d, length: %d, record: %d, \
-		file_status: %x, record_length: %d",
-		ok, length, record, file_status[0], record_length);
-}
-
 static void sim_initialize_after_pin(struct ofono_sim *sim)
 {
 	ofono_sim_read(sim, SIM_EFPHASE_FILEID,
@@ -1691,6 +1752,8 @@ static void sim_free_state(struct ofono_sim *sim)
 		sim->efimg =3D NULL;
 		sim->efimg_length =3D 0;
 	}
+
+	sim->fixed_dialing =3D FALSE;
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
-- =

1.6.3.3



--===============5664400403174020783==--

