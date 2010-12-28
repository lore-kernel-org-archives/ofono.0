Content-Type: multipart/mixed; boundary="===============4154633029962240293=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] sim: Watch files that ofono keeps in memory.
Date: Tue, 28 Dec 2010 10:17:57 +0100
Message-ID: <1293527879-3369-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1293527879-3369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4154633029962240293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These are dummy watches on files who's state is kept in memory, just
to ensure that on a refresh affecting any of those files ofono
re-reads them from SIM.  Only EFmsisdn and EFsdn changes are handled
without changing sim state right now.
---
 src/sim.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+--
 1 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 3f79c6a..8f69b4c 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -890,6 +890,8 @@ static void sim_get_image(struct ofono_sim *sim, unsign=
ed char id,
 	/* read the image data */
 	ofono_sim_read_bytes(sim, iidf_id, iidf_offset, iidf_len,
 				sim_iidf_read_cb, sim);
+	ofono_sim_add_file_watch(sim, iidf_id,
+					OFONO_SIM_STATE_READY, NULL, sim);
 }
 =

 static DBusMessage *sim_get_icon(DBusConnection *conn,
@@ -1127,11 +1129,12 @@ out:
 check:
 	/* All records retrieved */
 	if (sim->service_numbers) {
-		char **service_numbers;
-
 		sim->service_numbers =3D g_slist_reverse(sim->service_numbers);
 		sim->sdn_ready =3D TRUE;
+	}
 =

+	if (sim->sdn_ready) {
+		char **service_numbers;
 		service_numbers =3D get_service_numbers(sim->service_numbers);
 =

 		ofono_dbus_signal_dict_property_changed(conn, path,
@@ -1143,12 +1146,34 @@ check:
 	}
 }
 =

+static void sim_service_numbers_changed(int id, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	if (sim->service_numbers) {
+		g_slist_foreach(sim->service_numbers,
+				(GFunc)service_number_free, NULL);
+		g_slist_free(sim->service_numbers);
+		sim->service_numbers =3D NULL;
+	}
+
+	ofono_sim_read(sim, SIM_EFSDN_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
+			sim_sdn_read_cb, sim);
+}
+
 static void sim_own_numbers_update(struct ofono_sim *sim)
 {
 	ofono_sim_read(sim, SIM_EFMSISDN_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
 			sim_msisdn_read_cb, sim);
 }
 =

+static void sim_own_numbers_changed(int id, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	sim_own_numbers_update(sim);
+}
+
 static void sim_efimg_read_cb(int ok, int length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
@@ -1193,16 +1218,42 @@ static void sim_efimg_read_cb(int ok, int length, i=
nt record,
 static void sim_ready(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_sim *sim =3D user;
+	int i, iidf_id;
+
+	if (new_state !=3D OFONO_SIM_STATE_READY) {
+		ofono_sim_remove_file_watch(sim, SIM_EFMSISDN_FILEID,
+						NULL, sim);
+		ofono_sim_remove_file_watch(sim, SIM_EFSDN_FILEID, NULL, sim);
+		ofono_sim_remove_file_watch(sim, SIM_EFIMG_FILEID, NULL, sim);
+
+		if (sim->efimg =3D=3D NULL)
+			return;
+
+		for (i =3D sim->efimg_length / 9 - 1; i >=3D 0; i--) {
+			iidf_id =3D (sim->efimg[i * 9 + 3] << 8) |
+				sim->efimg[i * 9 + 4];
+
+			ofono_sim_remove_file_watch(sim, iidf_id, NULL, sim);
+		}
 =

-	if (new_state !=3D OFONO_SIM_STATE_READY)
 		return;
+	}
 =

 	sim_own_numbers_update(sim);
+	ofono_sim_add_file_watch(sim, SIM_EFMSISDN_FILEID,
+					OFONO_SIM_STATE_READY,
+					sim_own_numbers_changed, sim);
 =

 	ofono_sim_read(sim, SIM_EFSDN_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
 			sim_sdn_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFSDN_FILEID,
+					OFONO_SIM_STATE_READY,
+					sim_service_numbers_changed, sim);
+
 	ofono_sim_read(sim, SIM_EFIMG_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
 			sim_efimg_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFIMG_FILEID,
+					OFONO_SIM_STATE_READY, NULL, sim);
 }
 =

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
@@ -1466,6 +1517,9 @@ static void sim_efust_read_cb(int ok, int length, int=
 record,
 		ofono_sim_read(sim, SIM_EFEST_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_efest_read_cb, sim);
+		ofono_sim_add_file_watch(sim, SIM_EFEST_FILEID,
+						OFONO_SIM_STATE_INSERTED,
+						NULL, sim);
 =

 		return;
 	}
@@ -1527,6 +1581,9 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 		ofono_sim_read(sim, SIM_EFUST_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_efust_read_cb, sim);
+		ofono_sim_add_file_watch(sim, SIM_EFUST_FILEID,
+						OFONO_SIM_STATE_INSERTED,
+						NULL, sim);
 =

 		return;
 	}
@@ -1549,6 +1606,8 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 	ofono_sim_read(sim, SIM_EFSST_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efsst_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFSST_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 }
 =

 static void sim_initialize_after_pin(struct ofono_sim *sim)
@@ -1556,10 +1615,14 @@ static void sim_initialize_after_pin(struct ofono_s=
im *sim)
 	ofono_sim_read(sim, SIM_EFPHASE_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efphase_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFPHASE_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 =

 	ofono_sim_read(sim, SIM_EFAD_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_ad_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFAD_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 =

 	/*
 	 * Read CPHS-support bits, this is still part of the SIM
@@ -1568,6 +1631,8 @@ static void sim_initialize_after_pin(struct ofono_sim=
 *sim)
 	ofono_sim_read(sim, SIM_EF_CPHS_INFORMATION_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_cphs_information_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EF_CPHS_INFORMATION_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 }
 =

 static void sim_pin_query_cb(const struct ofono_error *error,
@@ -1858,6 +1923,8 @@ static void sim_initialize(struct ofono_sim *sim)
 	ofono_sim_read(sim, SIM_EF_ICCID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_iccid_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EF_ICCID_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 =

 	/* EFecc is read by the voicecall atom */
 =

@@ -1872,9 +1939,14 @@ static void sim_initialize(struct ofono_sim *sim)
 	ofono_sim_read(sim, SIM_EFLI_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efli_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFLI_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
+
 	ofono_sim_read(sim, SIM_EFPL_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efpl_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFPL_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 }
 =

 int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
@@ -1995,6 +2067,7 @@ static void sim_free_state(struct ofono_sim *sim)
 				(GFunc)service_number_free, NULL);
 		g_slist_free(sim->service_numbers);
 		sim->service_numbers =3D NULL;
+		sim->sdn_ready =3D FALSE;
 	}
 =

 	if (sim->efli) {
@@ -2039,6 +2112,17 @@ static void sim_free_state(struct ofono_sim *sim)
 =

 	sim->fixed_dialing =3D FALSE;
 	sim->barred_dialing =3D FALSE;
+
+	ofono_sim_remove_file_watch(sim, SIM_EFUST_FILEID, NULL, sim);
+	ofono_sim_remove_file_watch(sim, SIM_EFEST_FILEID, NULL, sim);
+	ofono_sim_remove_file_watch(sim, SIM_EFSST_FILEID, NULL, sim);
+	ofono_sim_remove_file_watch(sim, SIM_EFPHASE_FILEID, NULL, sim);
+	ofono_sim_remove_file_watch(sim, SIM_EFAD_FILEID, NULL, sim);
+	ofono_sim_remove_file_watch(sim, SIM_EF_CPHS_INFORMATION_FILEID,
+					NULL, sim);
+	ofono_sim_remove_file_watch(sim, SIM_EF_ICCID_FILEID, NULL, sim);
+	ofono_sim_remove_file_watch(sim, SIM_EFLI_FILEID, NULL, sim);
+	ofono_sim_remove_file_watch(sim, SIM_EFPL_FILEID, NULL, sim);
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
-- =

1.7.1.86.g0e460.dirty


--===============4154633029962240293==--

