Content-Type: multipart/mixed; boundary="===============4554338842920030629=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/9] sim: Watch for changes to relevant SIM files.
Date: Tue, 15 Feb 2011 08:58:53 +0100
Message-ID: <1297756739-2958-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1297756739-2958-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4554338842920030629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The watch callbacks are notified when a watched file is changed
during a Refresh.  Currently in most of the callbacks we free all
the information read from the file, and schedule a re-read.  I
wonder if we need some sort of check if a re-read is already in
progress.  We may also need to send PropertyChanged indicating
that the value is invalid until the file read finishes at which
point we send another PropertyChanged.  Otherwise the value of
the property is for a short while inconsistent with what
GetProperties would return (but I note that D-bus is already racy
so maybe it doesn't matter).
---
 src/sim.c |  153 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 143 insertions(+), 10 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 7c2e151..63c1ce9 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -59,6 +59,7 @@ struct ofono_sim {
 	char **language_prefs;
 	unsigned char *efli;
 	unsigned char efli_length;
+	gboolean language_prefs_update;
 =

 	enum ofono_sim_password_type pin_type;
 	gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PINs */
@@ -929,6 +930,11 @@ static void sim_iidf_read_cb(int ok, int length, int r=
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
@@ -959,6 +965,8 @@ static void sim_get_image(struct ofono_sim *sim, unsign=
ed char id,
 	/* read the image data */
 	ofono_sim_read_bytes(sim->context, iidf_id, iidf_offset, iidf_len,
 				sim_iidf_read_cb, sim);
+	ofono_sim_add_file_watch(sim->context, iidf_id,
+					sim_image_data_changed, sim, NULL);
 }
 =

 static DBusMessage *sim_get_icon(DBusConnection *conn,
@@ -1198,10 +1206,12 @@ out:
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

@@ -1214,6 +1224,21 @@ check:
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
@@ -1221,6 +1246,13 @@ static void sim_own_numbers_update(struct ofono_sim =
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
@@ -1262,19 +1294,69 @@ static void sim_efimg_read_cb(int ok, int length, i=
nt record,
 	memcpy(efimg, &data[1], 9);
 }
 =

+static void sim_efimg_changed(int id, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	int i, iidf_id;
+
+	if (sim->efimg !=3D NULL) {
+		for (i =3D sim->efimg_length / 9 - 1; i >=3D 0; i--) {
+			iidf_id =3D (sim->efimg[i * 9 + 3] << 8) |
+				sim->efimg[i * 9 + 4];
+
+			ofono_sim_remove_file_watch(sim->context, iidf_id);
+		}
+
+		g_free(sim->efimg);
+		sim->efimg =3D NULL;
+		sim->efimg_length =3D 0;
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
+	int i, iidf_id;
+
+	if (new_state !=3D OFONO_SIM_STATE_READY) {
+		if (sim->context =3D=3D NULL)
+			return;
+
+		ofono_sim_remove_file_watch(sim->context, SIM_EFMSISDN_FILEID);
+		ofono_sim_remove_file_watch(sim->context, SIM_EFSDN_FILEID);
+		ofono_sim_remove_file_watch(sim->context, SIM_EFIMG_FILEID);
+
+		if (sim->efimg =3D=3D NULL)
+			return;
+
+		for (i =3D sim->efimg_length / 9 - 1; i >=3D 0; i--) {
+			iidf_id =3D (sim->efimg[i * 9 + 3] << 8) |
+				sim->efimg[i * 9 + 4];
+
+			ofono_sim_remove_file_watch(sim->context, iidf_id);
+		}
 =

-	if (new_state !=3D OFONO_SIM_STATE_READY)
 		return;
+	}
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

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
@@ -1873,7 +1955,11 @@ skip_efpl:
 						DBUS_TYPE_STRING,
 						&sim->language_prefs);
 =

-	sim_pin_check(sim);
+	/* Proceed with sim initialization if we're not merely updating */
+	if (!sim->language_prefs_update)
+		sim_pin_check(sim);
+
+	sim->language_prefs_update =3D FALSE;
 }
 =

 static void sim_iccid_read_cb(int ok, int length, int record,
@@ -1899,6 +1985,43 @@ static void sim_iccid_read_cb(int ok, int length, in=
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
+	ofono_sim_read(sim->context, SIM_EF_ICCID_FILEID,
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
+	ofono_sim_read(sim->context, SIM_EFLI_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_efli_read_cb, sim);
+
+	ofono_sim_read(sim->context, SIM_EFPL_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_efpl_read_cb, sim);
+}
+
 static void sim_initialize(struct ofono_sim *sim)
 {
 	/*
@@ -1927,10 +2050,15 @@ static void sim_initialize(struct ofono_sim *sim)
 	 * in the EFust
 	 */
 =

+	if (sim->context =3D=3D NULL)
+		sim->context =3D ofono_sim_context_create(sim);
+
 	/* Grab the EFiccid which is always available */
 	ofono_sim_read(sim->context, SIM_EF_ICCID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_iccid_read_cb, sim);
+	ofono_sim_add_file_watch(sim->context, SIM_EF_ICCID_FILEID,
+					sim_iccid_changed, sim, NULL);
 =

 	/* EFecc is read by the voicecall atom */
 =

@@ -1945,9 +2073,14 @@ static void sim_initialize(struct ofono_sim *sim)
 	ofono_sim_read(sim->context, SIM_EFLI_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efli_read_cb, sim);
+	ofono_sim_add_file_watch(sim->context, SIM_EFLI_FILEID,
+					sim_efli_efpl_changed, sim, NULL);
+
 	ofono_sim_read(sim->context, SIM_EFPL_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efpl_read_cb, sim);
+	ofono_sim_add_file_watch(sim->context, SIM_EFPL_FILEID,
+					sim_efli_efpl_changed, sim, NULL);
 }
 =

 struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim)
@@ -2096,6 +2229,11 @@ static void sim_free_early_state(struct ofono_sim *s=
im)
 		g_strfreev(sim->language_prefs);
 		sim->language_prefs =3D NULL;
 	}
+
+	if (sim->context) {
+		ofono_sim_context_free(sim->context);
+		sim->context =3D NULL;
+	}
 }
 =

 static void sim_free_main_state(struct ofono_sim *sim)
@@ -2119,6 +2257,7 @@ static void sim_free_main_state(struct ofono_sim *sim)
 				(GFunc)service_number_free, NULL);
 		g_slist_free(sim->service_numbers);
 		sim->service_numbers =3D NULL;
+		sim->sdn_ready =3D FALSE;
 	}
 =

 	if (sim->efust) {
@@ -2296,11 +2435,6 @@ static void sim_remove(struct ofono_atom *atom)
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

@@ -2366,7 +2500,6 @@ void ofono_sim_register(struct ofono_sim *sim)
 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
 	sim->state_watches =3D __ofono_watchlist_new(g_free);
 	sim->simfs =3D sim_fs_new(sim, sim->driver);
-	sim->context =3D ofono_sim_context_create(sim);
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
 =

-- =

1.7.1.86.g0e460.dirty


--===============4554338842920030629==--

