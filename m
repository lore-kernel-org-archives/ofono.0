Content-Type: multipart/mixed; boundary="===============9086195790871038713=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/4] sim: add barred dialing support
Date: Mon, 25 Oct 2010 04:34:15 -0700
Message-ID: <1288006457-5415-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1288006457-5415-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9086195790871038713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
---
 1 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 699ebe9..c631e31 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -73,6 +73,7 @@ struct ofono_sim {
 	unsigned char *efsst;
 	unsigned char efsst_length;
 	gboolean fixed_dialing;
+	gboolean barred_dialing;
 =

 	char *imsi;
 =

@@ -288,6 +289,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 	const char *pin_name;
 	dbus_bool_t present =3D sim->state !=3D OFONO_SIM_STATE_NOT_PRESENT;
 	dbus_bool_t fdn;
+	dbus_bool_t bdn;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (!reply)
@@ -315,6 +317,9 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 	fdn =3D sim->fixed_dialing;
 	ofono_dbus_dict_append(&dict, "FixedDialing", DBUS_TYPE_BOOLEAN, &fdn);
 =

+	bdn =3D sim->barred_dialing;
+	ofono_dbus_dict_append(&dict, "BarredDialing", DBUS_TYPE_BOOLEAN, &bdn);
+
 	if (sim->mnc_length && sim->imsi) {
 		char mcc[OFONO_MAX_MCC_LENGTH + 1];
 		char mnc[OFONO_MAX_MNC_LENGTH + 1];
@@ -1261,6 +1266,57 @@ static void sim_fdn_enabled(struct ofono_sim *sim)
 						DBUS_TYPE_BOOLEAN, &val);
 }
 =

+static void sim_bdn_enabled(struct ofono_sim *sim)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	dbus_bool_t val;
+
+	sim->barred_dialing =3D TRUE;
+
+	val =3D sim->barred_dialing;
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"BarredDialing",
+						DBUS_TYPE_BOOLEAN, &val);
+}
+
+static void sim_efbdn_info_read_cb(int ok, unsigned char file_status,
+					int total_length, int record_length,
+					void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	if (!ok)
+		goto out;
+
+	if (file_status =3D=3D SIM_FILE_STATUS_VALID)
+		sim_bdn_enabled(sim);
+
+out:
+	if (sim->fixed_dialing !=3D TRUE &&
+			sim->barred_dialing !=3D TRUE)
+		sim_retrieve_imsi(sim);
+}
+
+static gboolean check_bdn_status(struct ofono_sim *sim)
+{
+	/*
+	 * Check the status of Barred Dialing in the SIM-card
+	 * (TS 11.11/TS 51.011, Section 11.5.1: BDN capability request).
+	 * If BDN is allocated, activated in EFsst and EFbdn is validated,
+	 * halt the SIM initialization.
+	 */
+	if (sim_sst_is_active(sim->efsst, sim->efsst_length,
+			SIM_SST_SERVICE_BDN)) {
+		sim_fs_read_info(sim->simfs, SIM_EFBDN_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_FIXED,
+				sim_efbdn_info_read_cb, sim);
+		return TRUE;
+	}
+	return FALSE;
+}
+
 static void sim_efadn_info_read_cb(int ok, unsigned char file_status,
 					int total_length, int record_length,
 					void *userdata)
@@ -1270,13 +1326,15 @@ static void sim_efadn_info_read_cb(int ok, unsigned=
 char file_status,
 	if (!ok)
 		goto out;
 =

-	if (file_status !=3D SIM_FILE_STATUS_VALID) {
+	if (file_status !=3D SIM_FILE_STATUS_VALID)
 		sim_fdn_enabled(sim);
-		return;
-	}
 =

 out:
-	sim_retrieve_imsi(sim);
+	if (check_bdn_status(sim) !=3D TRUE) {
+		if (sim->fixed_dialing !=3D TRUE &&
+				sim->barred_dialing !=3D TRUE)
+			sim_retrieve_imsi(sim);
+	}
 }
 =

 static void sim_efsst_read_cb(int ok, int length, int record,
@@ -1310,6 +1368,9 @@ static void sim_efsst_read_cb(int ok, int length, int=
 record,
 		return;
 	}
 =

+	if (check_bdn_status(sim) =3D=3D TRUE)
+		return;
+
 out:
 	sim_retrieve_imsi(sim);
 }
@@ -1337,13 +1398,22 @@ static void sim_efest_read_cb(int ok, int length, i=
nt record,
 	 * If FDN is activated, don't continue initialization routine.
 	 */
 	if (sim_est_is_active(sim->efest, sim->efest_length,
-				SIM_EST_SERVICE_FDN)) {
+				SIM_EST_SERVICE_FDN))
 		sim_fdn_enabled(sim);
-		return;
-	}
+
+	/*
+	 * Check the status of Barred Dialing in the USIM-card
+	 * (TS 31.102, Section 5.3.2: BDN capability request).
+	 * If BDN service is enabled, halt the USIM initialization.
+	 */
+	if (sim_est_is_active(sim->efest, sim->efest_length,
+				SIM_EST_SERVICE_BDN))
+		sim_bdn_enabled(sim);
 =

 out:
-	sim_retrieve_imsi(sim);
+	if (sim->fixed_dialing !=3D TRUE &&
+			sim->barred_dialing !=3D TRUE)
+		sim_retrieve_imsi(sim);
 }
 =

 static void sim_efust_read_cb(int ok, int length, int record,
@@ -1922,6 +1992,7 @@ static void sim_free_state(struct ofono_sim *sim)
 	sim->iidf_image =3D NULL;
 =

 	sim->fixed_dialing =3D FALSE;
+	sim->barred_dialing =3D FALSE;
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
-- =

1.7.0.4


--===============9086195790871038713==--

