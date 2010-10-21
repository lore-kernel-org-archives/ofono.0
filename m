Content-Type: multipart/mixed; boundary="===============0133877386485165259=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 3/5] sim: check if Fixed Dial is enabled in SIM-card
Date: Thu, 21 Oct 2010 17:58:11 +0300
Message-ID: <1287673093-3022-4-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1287673093-3022-3-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0133877386485165259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If SIM-card is inserted, status is checked from EFsst
(is FDN activated) and EFadn (is ADN invalidated).
If USIM-card is inserted, status is checked from EFest
(is FDN activated).

If FD is enabled, halt SIM initialization procedure.
New property (FixedDialing) is added. If FD is enabled,
this has been signalled via DBUS.
---
 src/sim.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index fe34188..ef2a237 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -72,6 +72,7 @@ struct ofono_sim {
 	unsigned char efest_length;
 	unsigned char *efsst;
 	unsigned char efsst_length;
+	gboolean fixed_dialing;
 =

 	char *imsi;
 =

@@ -310,6 +311,9 @@ static DBusMessage *sim_get_properties(DBusConnection *=
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
@@ -1241,6 +1245,33 @@ static void sim_retrieve_imsi(struct ofono_sim *sim)
 	sim->driver->read_imsi(sim, sim_imsi_cb, sim);
 }
 =

+static void sim_efadn_info_read_cb(int ok, unsigned char file_status,
+					int total_length, int record_length,
+					void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	if (!ok)
+		goto out;
+
+	if (file_status !=3D SIM_FILE_STATUS_VALID) {
+		DBusConnection *conn =3D ofono_dbus_get_connection();
+		const char *path =3D __ofono_atom_get_path(sim->atom);
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
 int ofono_sim_read_info(struct ofono_sim *sim, int id,
 			enum ofono_sim_file_structure expected_type,
 			ofono_sim_fs_read_info_cb_t cb, void *data)
@@ -1268,6 +1299,21 @@ static void sim_efsst_read_cb(int ok, int length, in=
t record,
 	sim->efsst =3D g_memdup(data, length);
 	sim->efsst_length =3D length;
 =

+	/*
+	 * Check if Fixed Dialing is enabled in the SIM-card
+	 * (TS 11.11/TS 51.011, Section 11.5.1: FDN capability request).
+	 * If FDN is activated and ADN is invalidated,
+	 * don't continue initialization routine.
+	 */
+	if (sim_sst_is_active(sim->efsst, sim->efsst_length,
+				SIM_SST_SERVICE_FDN)) {
+
+		ofono_sim_read_info(sim, SIM_EFADN_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_FIXED,
+					sim_efadn_info_read_cb, sim);
+		return;
+	}
+
 out:
 	sim_retrieve_imsi(sim);
 }
@@ -1289,6 +1335,26 @@ static void sim_efest_read_cb(int ok, int length, in=
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
+		DBusConnection *conn =3D ofono_dbus_get_connection();
+		const char *path =3D __ofono_atom_get_path(sim->atom);
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
@@ -1867,6 +1933,8 @@ static void sim_free_state(struct ofono_sim *sim)
 =

 	g_free(sim->iidf_image);
 	sim->iidf_image =3D NULL;
+
+	sim->fixed_dialing =3D FALSE;
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
-- =

1.6.3.3



--===============0133877386485165259==--

