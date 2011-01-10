Content-Type: multipart/mixed; boundary="===============9064602705731824164=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] Watch files that ofono keeps in memory.
Date: Mon, 10 Jan 2011 12:01:34 +0100
Message-ID: <1294657295-14041-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1294657295-14041-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9064602705731824164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These are (mostly) dummy watches on files who's state is kept in memory,
just to ensure that on a refresh affecting any of those files ofono
re-reads them from SIM.  Only EFmsisdn, EFsdn and EFecc changes are
handled without changing sim state right now.
---
 src/call-forwarding.c |   18 ++++++++-
 src/cbs.c             |    6 +++
 src/message-waiting.c |   30 ++++++++++++++++
 src/network.c         |   24 +++++++++++++
 src/sim.c             |   92 +++++++++++++++++++++++++++++++++++++++++++++=
++--
 src/voicecall.c       |   28 +++++++++++----
 6 files changed, 186 insertions(+), 12 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 512f223..981f4a6 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1362,14 +1362,21 @@ static void sim_read_cf_indicator(struct ofono_call=
_forwarding *cf)
 {
 	if (__ofono_sim_service_available(cf->sim,
 			SIM_UST_SERVICE_CFIS,
-			SIM_SST_SERVICE_CFIS) =3D=3D TRUE)
+			SIM_SST_SERVICE_CFIS) =3D=3D TRUE) {
 		ofono_sim_read(cf->sim, SIM_EFCFIS_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				sim_cfis_read_cb, cf);
-	else
+		ofono_sim_add_file_watch(cf->sim, SIM_EFCFIS_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, cf);
+	} else {
 		ofono_sim_read(cf->sim, SIM_EF_CPHS_CFF_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_cphs_cff_read_cb, cf);
+		ofono_sim_add_file_watch(cf->sim, SIM_EF_CPHS_CFF_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, cf);
+	}
 }
 =

 int ofono_call_forwarding_driver_register(const struct ofono_call_forwardi=
ng_driver *d)
@@ -1407,6 +1414,13 @@ static void call_forwarding_unregister(struct ofono_=
atom *atom)
 =

 	if (cf->ussd_watch)
 		__ofono_modem_remove_atom_watch(modem, cf->ussd_watch);
+
+	if (cf->sim) {
+		ofono_sim_remove_file_watch(cf->sim, SIM_EFCFIS_FILEID,
+						NULL, cf);
+		ofono_sim_remove_file_watch(cf->sim, SIM_EF_CPHS_CFF_FILEID,
+						NULL, cf);
+	}
 }
 =

 static void call_forwarding_remove(struct ofono_atom *atom)
diff --git a/src/cbs.c b/src/cbs.c
index 8e4afc1..4efa7b2 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -605,6 +605,10 @@ static void cbs_unregister(struct ofono_atom *atom)
 		cbs->efcbmid_contents =3D NULL;
 	}
 =

+	if (cbs->sim)
+		ofono_sim_remove_file_watch(cbs->sim, SIM_EFCBMID_FILEID,
+						NULL, cbs);
+
 	cbs->sim =3D NULL;
 	cbs->stk =3D NULL;
 =

@@ -922,6 +926,8 @@ static void cbs_got_imsi(struct ofono_cbs *cbs)
 	ofono_sim_read(cbs->sim, SIM_EFCBMID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_cbmid_read_cb, cbs);
+	ofono_sim_add_file_watch(cbs->sim, SIM_EFCBMID_FILEID,
+					OFONO_SIM_STATE_READY, NULL, cbs);
 }
 =

 static gboolean reset_base_station_name(gpointer user)
diff --git a/src/message-waiting.c b/src/message-waiting.c
index d8bfe34..0ff2fb4 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -915,10 +915,24 @@ void __ofono_message_waiting_mwi(struct ofono_message=
_waiting *mw,
 =

 static void message_waiting_unregister(struct ofono_atom *atom)
 {
+	struct ofono_message_waiting *mw =3D __ofono_atom_get_data(atom);
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
 =

+	if (mw->sim) {
+		ofono_sim_remove_file_watch(mw->sim, SIM_EFMWIS_FILEID,
+						NULL, mw);
+		ofono_sim_remove_file_watch(mw->sim, SIM_EF_CPHS_MWIS_FILEID,
+						NULL, mw);
+		ofono_sim_remove_file_watch(mw->sim, SIM_EFMBI_FILEID,
+						NULL, mw);
+		ofono_sim_remove_file_watch(mw->sim, SIM_EFMBDN_FILEID,
+						NULL, mw);
+		ofono_sim_remove_file_watch(mw->sim, SIM_EF_CPHS_MBDN_FILEID,
+						NULL, mw);
+	}
+
 	g_dbus_unregister_interface(conn, path,
 					OFONO_MESSAGE_WAITING_INTERFACE);
 	ofono_modem_remove_interface(modem, OFONO_MESSAGE_WAITING_INTERFACE);
@@ -961,6 +975,22 @@ void ofono_message_waiting_register(struct ofono_messa=
ge_waiting *mw)
 		ofono_sim_read(mw->sim, SIM_EF_CPHS_MWIS_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				mw_cphs_mwis_read_cb, mw);
+
+		ofono_sim_add_file_watch(mw->sim, SIM_EFMWIS_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, mw);
+		ofono_sim_add_file_watch(mw->sim, SIM_EF_CPHS_MWIS_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, mw);
+		ofono_sim_add_file_watch(mw->sim, SIM_EFMBI_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, mw);
+		ofono_sim_add_file_watch(mw->sim, SIM_EFMBDN_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, mw);
+		ofono_sim_add_file_watch(mw->sim, SIM_EF_CPHS_MBDN_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, mw);
 	}
 =

 	__ofono_atom_register(mw->atom, message_waiting_unregister);
diff --git a/src/network.c b/src/network.c
index eb0f797..ba3e962 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1708,6 +1708,17 @@ static void netreg_unregister(struct ofono_atom *ato=
m)
 		netreg->settings =3D NULL;
 	}
 =

+	if (netreg->sim) {
+		ofono_sim_remove_file_watch(netreg->sim, SIM_EFPNN_FILEID,
+						NULL, netreg);
+		ofono_sim_remove_file_watch(netreg->sim, SIM_EFSPN_FILEID,
+						NULL, netreg);
+		ofono_sim_remove_file_watch(netreg->sim, SIM_EFSPDI_FILEID,
+						NULL, netreg);
+		ofono_sim_remove_file_watch(netreg->sim, SIM_EFOPL_FILEID,
+						NULL, netreg);
+	}
+
 	g_dbus_unregister_interface(conn, path,
 					OFONO_NETWORK_REGISTRATION_INTERFACE);
 	ofono_modem_remove_interface(modem,
@@ -1845,6 +1856,19 @@ void ofono_netreg_register(struct ofono_netreg *netr=
eg)
 		ofono_sim_read(netreg->sim, SIM_EFSPN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_spn_read_cb, netreg);
+
+		ofono_sim_add_file_watch(netreg->sim, SIM_EFPNN_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, netreg);
+		ofono_sim_add_file_watch(netreg->sim, SIM_EFSPN_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, netreg);
+		ofono_sim_add_file_watch(netreg->sim, SIM_EFSPDI_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, netreg);
+		ofono_sim_add_file_watch(netreg->sim, SIM_EFOPL_FILEID,
+						OFONO_SIM_STATE_READY,
+						NULL, netreg);
 	}
 =

 	__ofono_atom_register(netreg->atom, netreg_unregister);
diff --git a/src/sim.c b/src/sim.c
index 7923302..89f7d58 100644
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
@@ -1193,16 +1218,44 @@ static void sim_efimg_read_cb(int ok, int length, i=
nt record,
 static void sim_ready(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_sim *sim =3D user;
+	int i, iidf_id;
+
+	if (new_state !=3D OFONO_SIM_STATE_READY) {
+		ofono_sim_remove_file_watch(sim, SIM_EFMSISDN_FILEID,
+						sim_own_numbers_changed, sim);
+		ofono_sim_remove_file_watch(sim, SIM_EFSDN_FILEID,
+						sim_service_numbers_changed,
+						sim);
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
@@ -1466,6 +1519,9 @@ static void sim_efust_read_cb(int ok, int length, int=
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
@@ -1527,6 +1583,9 @@ static void sim_efphase_read_cb(int ok, int length, i=
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
@@ -1549,6 +1608,8 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 	ofono_sim_read(sim, SIM_EFSST_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efsst_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFSST_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 }
 =

 static void sim_initialize_after_pin(struct ofono_sim *sim)
@@ -1556,10 +1617,14 @@ static void sim_initialize_after_pin(struct ofono_s=
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
@@ -1568,6 +1633,8 @@ static void sim_initialize_after_pin(struct ofono_sim=
 *sim)
 	ofono_sim_read(sim, SIM_EF_CPHS_INFORMATION_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_cphs_information_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EF_CPHS_INFORMATION_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 }
 =

 static void sim_pin_query_cb(const struct ofono_error *error,
@@ -1858,6 +1925,8 @@ static void sim_initialize(struct ofono_sim *sim)
 	ofono_sim_read(sim, SIM_EF_ICCID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_iccid_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EF_ICCID_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 =

 	/* EFecc is read by the voicecall atom */
 =

@@ -1872,9 +1941,14 @@ static void sim_initialize(struct ofono_sim *sim)
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
@@ -1995,6 +2069,7 @@ static void sim_free_state(struct ofono_sim *sim)
 				(GFunc)service_number_free, NULL);
 		g_slist_free(sim->service_numbers);
 		sim->service_numbers =3D NULL;
+		sim->sdn_ready =3D FALSE;
 	}
 =

 	if (sim->efli) {
@@ -2039,6 +2114,17 @@ static void sim_free_state(struct ofono_sim *sim)
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
diff --git a/src/voicecall.c b/src/voicecall.c
index 97fc36b..5df3314 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2246,19 +2246,30 @@ struct ofono_voicecall *ofono_voicecall_create(stru=
ct ofono_modem *modem,
 	return vc;
 }
 =

+static void read_ecc_numbers(int id, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+
+	/* Try both formats, only one or none will work */
+	ofono_sim_read(vc->sim, SIM_EFECC_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			ecc_g2_read_cb, vc);
+	ofono_sim_read(vc->sim, SIM_EFECC_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			ecc_g3_read_cb, vc);
+}
+
 static void sim_state_watch(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_voicecall *vc =3D user;
 =

 	switch (new_state) {
 	case OFONO_SIM_STATE_INSERTED:
-		/* Try both formats, only one or none will work */
-		ofono_sim_read(vc->sim, SIM_EFECC_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-				ecc_g2_read_cb, vc);
-		ofono_sim_read(vc->sim, SIM_EFECC_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_FIXED,
-				ecc_g3_read_cb, vc);
+		read_ecc_numbers(SIM_EFECC_FILEID, vc);
+
+		ofono_sim_add_file_watch(vc->sim, SIM_EFECC_FILEID,
+						OFONO_SIM_STATE_INSERTED,
+						read_ecc_numbers, vc);
 		break;
 	case OFONO_SIM_STATE_NOT_PRESENT:
 		/* TODO: Must release all non-emergency calls */
@@ -2275,6 +2286,9 @@ static void sim_state_watch(enum ofono_sim_state new_=
state, void *user)
 =

 		add_to_en_list(&vc->new_en_list, default_en_list_no_sim);
 		set_new_ecc(vc);
+
+		ofono_sim_remove_file_watch(vc->sim, SIM_EFECC_FILEID,
+						read_ecc_numbers, vc);
 	default:
 		break;
 	}
-- =

1.7.1.86.g0e460.dirty


--===============9064602705731824164==--

