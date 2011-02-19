Content-Type: multipart/mixed; boundary="===============8894536494969882284=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] sim: Watch for changes to relevant SIM files.
Date: Sat, 19 Feb 2011 04:54:27 +0100
Message-ID: <1298087669-11558-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8894536494969882284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |  170 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 files changed, 157 insertions(+), 13 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index c39269d..c33fcd5 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -58,6 +58,7 @@ struct ofono_sim {
 	char **language_prefs;
 	unsigned char *efli;
 	unsigned char efli_length;
+	gboolean language_prefs_update;
 =

 	enum ofono_sim_password_type pin_type;
 	gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PINs */
@@ -97,8 +98,10 @@ struct ofono_sim {
 =

 	struct sim_fs *simfs;
 	struct ofono_sim_context *context;
+	struct ofono_sim_context *early_context;
 =

 	unsigned char *iidf_image;
+	unsigned int *iidf_watch_ids;
 =

 	DBusMessage *pending;
 	const struct ofono_sim_driver *driver;
@@ -928,6 +931,11 @@ static void sim_iidf_read_cb(int ok, int length, int r=
ecord,
 					sim_iidf_read_clut_cb, sim);
 }
 =

+static void sim_image_data_changed(int id, void *userdata)
+{
+	/* TODO: notify D-bus clients */
+}
+
 static void sim_get_image(struct ofono_sim *sim, unsigned char id,
 				gpointer user_data)
 {
@@ -941,7 +949,7 @@ static void sim_get_image(struct ofono_sim *sim, unsign=
ed char id,
 =

 	if (image !=3D NULL) {
 		sim_get_image_cb(sim, id, image, FALSE);
-		return;
+		goto watch;
 	}
 =

 	if (sim->efimg_length <=3D (id * 9)) {
@@ -958,6 +966,17 @@ static void sim_get_image(struct ofono_sim *sim, unsig=
ned char id,
 	/* read the image data */
 	ofono_sim_read_bytes(sim->context, iidf_id, iidf_offset, iidf_len,
 				sim_iidf_read_cb, sim);
+
+watch:
+	if (sim->efimg_length <=3D id * 9)
+		return;
+
+	if (sim->iidf_watch_ids[id] > 0)
+		return;
+
+	sim->iidf_watch_ids[id] =3D ofono_sim_add_file_watch(sim->context,
+					iidf_id, sim_image_data_changed,
+					sim, NULL);
 }
 =

 static DBusMessage *sim_get_icon(DBusConnection *conn,
@@ -1197,10 +1216,12 @@ out:
 check:
 	/* All records retrieved */
 	if (sim->service_numbers) {
-		char **service_numbers;
-
 		sim->service_numbers =3D g_slist_reverse(sim->service_numbers);
 		sim->sdn_ready =3D TRUE;
+	}
+
+	if (sim->sdn_ready) {
+		char **service_numbers;
 =

 		service_numbers =3D get_service_numbers(sim->service_numbers);
 =

@@ -1213,6 +1234,21 @@ check:
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
+	ofono_sim_read(sim->context, SIM_EFSDN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_sdn_read_cb, sim);
+}
+
 static void sim_own_numbers_update(struct ofono_sim *sim)
 {
 	ofono_sim_read(sim->context, SIM_EFMSISDN_FILEID,
@@ -1220,6 +1256,13 @@ static void sim_own_numbers_update(struct ofono_sim =
*sim)
 			sim);
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
@@ -1247,6 +1290,11 @@ static void sim_efimg_read_cb(int ok, int length, in=
t record,
 		if (sim->efimg =3D=3D NULL)
 			return;
 =

+		sim->iidf_watch_ids =3D g_try_new0(unsigned int, num_records);
+
+		if (sim->iidf_watch_ids =3D=3D NULL)
+			return;
+
 		sim->efimg_length =3D num_records * 9;
 	}
 =

@@ -1261,6 +1309,33 @@ static void sim_efimg_read_cb(int ok, int length, in=
t record,
 	memcpy(efimg, &data[1], 9);
 }
 =

+static void sim_efimg_changed(int id, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	int i, watch;
+
+	if (sim->efimg !=3D NULL) {
+		for (i =3D sim->efimg_length / 9 - 1; i >=3D 0; i--) {
+			watch =3D sim->iidf_watch_ids[i];
+			if (watch =3D=3D 0)
+				continue;
+
+			ofono_sim_remove_file_watch(sim->context, watch);
+		}
+
+		g_free(sim->efimg);
+		sim->efimg =3D NULL;
+		sim->efimg_length =3D 0;
+		g_free(sim->iidf_watch_ids);
+		sim->iidf_watch_ids =3D NULL;
+	}
+
+	ofono_sim_read(sim->context, SIM_EFIMG_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_efimg_read_cb, sim);
+
+	/* TODO: notify D-bus clients */
+}
+
 static void sim_ready(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_sim *sim =3D user;
@@ -1269,11 +1344,18 @@ static void sim_ready(enum ofono_sim_state new_stat=
e, void *user)
 		return;
 =

 	sim_own_numbers_update(sim);
+	ofono_sim_add_file_watch(sim->context, SIM_EFMSISDN_FILEID,
+					sim_own_numbers_changed, sim, NULL);
 =

 	ofono_sim_read(sim->context, SIM_EFSDN_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_sdn_read_cb, sim);
+	ofono_sim_add_file_watch(sim->context, SIM_EFSDN_FILEID,
+					sim_service_numbers_changed, sim, NULL);
+
 	ofono_sim_read(sim->context, SIM_EFIMG_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_efimg_read_cb, sim);
+	ofono_sim_add_file_watch(sim->context, SIM_EFIMG_FILEID,
+					sim_efimg_changed, sim, NULL);
 }
 =

 static void sim_set_ready(struct ofono_sim *sim)
@@ -1846,7 +1928,15 @@ skip_efpl:
 						DBUS_TYPE_STRING,
 						&sim->language_prefs);
 =

-	sim_pin_check(sim);
+	/* Proceed with sim initialization if we're not merely updating */
+	if (!sim->language_prefs_update) {
+		if (sim->context =3D=3D NULL)
+			sim->context =3D ofono_sim_context_create(sim);
+
+		sim_pin_check(sim);
+	}
+
+	sim->language_prefs_update =3D FALSE;
 }
 =

 static void sim_iccid_read_cb(int ok, int length, int record,
@@ -1872,6 +1962,43 @@ static void sim_iccid_read_cb(int ok, int length, in=
t record,
 						&sim->iccid);
 }
 =

+static void sim_iccid_changed(int id, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	if (sim->iccid) {
+		g_free(sim->iccid);
+		sim->iccid =3D NULL;
+	}
+
+	ofono_sim_read(sim->early_context, SIM_EF_ICCID_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_iccid_read_cb, sim);
+}
+
+static void sim_efli_efpl_changed(int id, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	if (sim->efli !=3D NULL) /* This shouldn't happen */
+		return;
+
+	if (sim->language_prefs) {
+		g_strfreev(sim->language_prefs);
+		sim->language_prefs =3D NULL;
+	}
+
+	sim->language_prefs_update =3D TRUE;
+
+	ofono_sim_read(sim->early_context, SIM_EFLI_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_efli_read_cb, sim);
+
+	ofono_sim_read(sim->early_context, SIM_EFPL_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_efpl_read_cb, sim);
+}
+
 static void sim_initialize(struct ofono_sim *sim)
 {
 	/*
@@ -1900,10 +2027,15 @@ static void sim_initialize(struct ofono_sim *sim)
 	 * in the EFust
 	 */
 =

+	if (sim->early_context =3D=3D NULL)
+		sim->early_context =3D ofono_sim_context_create(sim);
+
 	/* Grab the EFiccid which is always available */
-	ofono_sim_read(sim->context, SIM_EF_ICCID_FILEID,
+	ofono_sim_read(sim->early_context, SIM_EF_ICCID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_iccid_read_cb, sim);
+	ofono_sim_add_file_watch(sim->early_context, SIM_EF_ICCID_FILEID,
+					sim_iccid_changed, sim, NULL);
 =

 	/* EFecc is read by the voicecall atom */
 =

@@ -1915,12 +2047,17 @@ static void sim_initialize(struct ofono_sim *sim)
 	 * However we don't depend on the user interface and so
 	 * need to read both files now.
 	 */
-	ofono_sim_read(sim->context, SIM_EFLI_FILEID,
+	ofono_sim_read(sim->early_context, SIM_EFLI_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efli_read_cb, sim);
-	ofono_sim_read(sim->context, SIM_EFPL_FILEID,
+	ofono_sim_add_file_watch(sim->early_context, SIM_EFLI_FILEID,
+					sim_efli_efpl_changed, sim, NULL);
+
+	ofono_sim_read(sim->early_context, SIM_EFPL_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efpl_read_cb, sim);
+	ofono_sim_add_file_watch(sim->early_context, SIM_EFPL_FILEID,
+					sim_efli_efpl_changed, sim, NULL);
 }
 =

 struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim)
@@ -2069,6 +2206,11 @@ static void sim_free_early_state(struct ofono_sim *s=
im)
 		g_strfreev(sim->language_prefs);
 		sim->language_prefs =3D NULL;
 	}
+
+	if (sim->early_context) {
+		ofono_sim_context_free(sim->early_context);
+		sim->early_context =3D NULL;
+	}
 }
 =

 static void sim_free_main_state(struct ofono_sim *sim)
@@ -2092,6 +2234,7 @@ static void sim_free_main_state(struct ofono_sim *sim)
 				(GFunc)service_number_free, NULL);
 		g_slist_free(sim->service_numbers);
 		sim->service_numbers =3D NULL;
+		sim->sdn_ready =3D FALSE;
 	}
 =

 	if (sim->efust) {
@@ -2118,6 +2261,8 @@ static void sim_free_main_state(struct ofono_sim *sim)
 		g_free(sim->efimg);
 		sim->efimg =3D NULL;
 		sim->efimg_length =3D 0;
+		g_free(sim->iidf_watch_ids);
+		sim->iidf_watch_ids =3D NULL;
 	}
 =

 	g_free(sim->iidf_image);
@@ -2125,6 +2270,11 @@ static void sim_free_main_state(struct ofono_sim *si=
m)
 =

 	sim->fixed_dialing =3D FALSE;
 	sim->barred_dialing =3D FALSE;
+
+	if (sim->context) {
+		ofono_sim_context_free(sim->context);
+		sim->context =3D NULL;
+	}
 }
 =

 static void sim_free_state(struct ofono_sim *sim)
@@ -2304,11 +2454,6 @@ static void sim_remove(struct ofono_atom *atom)
 =

 	sim_free_state(sim);
 =

-	if (sim->context) {
-		ofono_sim_context_free(sim->context);
-		sim->context =3D NULL;
-	}
-
 	sim_fs_free(sim->simfs);
 	sim->simfs =3D NULL;
 =

@@ -2374,7 +2519,6 @@ void ofono_sim_register(struct ofono_sim *sim)
 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
 	sim->state_watches =3D __ofono_watchlist_new(g_free);
 	sim->simfs =3D sim_fs_new(sim, sim->driver);
-	sim->context =3D ofono_sim_context_create(sim);
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
 =

-- =

1.7.1.86.g0e460.dirty


--===============8894536494969882284==--

