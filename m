Content-Type: multipart/mixed; boundary="===============1477419440530096011=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] Watch files that ofono keeps in memory.
Date: Fri, 04 Feb 2011 02:20:33 +0100
Message-ID: <1296782434-11008-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1296782434-11008-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1477419440530096011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add mostly dummy watches on files who's state is kept in memory,
just to ensure that on a refresh affecting any of those files ofono
re-reads them from SIM.  Only EFmsisdn, EFsdn and EFecc changes are
handled without changing sim state right now.
---
 src/call-forwarding.c |   10 ++++-
 src/cbs.c             |    2 +
 src/message-waiting.c |   13 +++++++
 src/network.c         |    9 +++++
 src/sim.c             |   95 ++++++++++++++++++++++++++++++++++++++++++++-=
----
 src/voicecall.c       |   24 +++++++++----
 6 files changed, 135 insertions(+), 18 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index ca6dad9..0e15563 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1362,14 +1362,20 @@ static void sim_read_cf_indicator(struct ofono_call=
_forwarding *cf)
 {
 	if (__ofono_sim_service_available(cf->sim,
 			SIM_UST_SERVICE_CFIS,
-			SIM_SST_SERVICE_CFIS) =3D=3D TRUE)
+			SIM_SST_SERVICE_CFIS) =3D=3D TRUE) {
 		ofono_sim_read(cf->sim_context, SIM_EFCFIS_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				sim_cfis_read_cb, cf);
-	else
+		ofono_sim_add_file_watch(cf->sim_context, SIM_EFCFIS_FILEID,
+						NULL, cf);
+	} else {
 		ofono_sim_read(cf->sim_context, SIM_EF_CPHS_CFF_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_cphs_cff_read_cb, cf);
+		ofono_sim_add_file_watch(cf->sim_context,
+						SIM_EF_CPHS_CFF_FILEID,
+						NULL, cf);
+	}
 }
 =

 int ofono_call_forwarding_driver_register(const struct ofono_call_forwardi=
ng_driver *d)
diff --git a/src/cbs.c b/src/cbs.c
index 1220d0b..e50e0d0 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -928,6 +928,8 @@ static void cbs_got_imsi(struct ofono_cbs *cbs)
 	ofono_sim_read(cbs->sim_context, SIM_EFCBMID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_cbmid_read_cb, cbs);
+	ofono_sim_add_file_watch(cbs->sim_context, SIM_EFCBMID_FILEID,
+					NULL, cbs);
 }
 =

 static gboolean reset_base_station_name(gpointer user)
diff --git a/src/message-waiting.c b/src/message-waiting.c
index c0293e7..6a959ec 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -981,6 +981,19 @@ void ofono_message_waiting_register(struct ofono_messa=
ge_waiting *mw)
 		ofono_sim_read(mw->sim_context, SIM_EF_CPHS_MWIS_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				mw_cphs_mwis_read_cb, mw);
+
+		ofono_sim_add_file_watch(mw->sim_context, SIM_EFMWIS_FILEID,
+						NULL, mw);
+		ofono_sim_add_file_watch(mw->sim_context,
+						SIM_EF_CPHS_MWIS_FILEID,
+						NULL, mw);
+		ofono_sim_add_file_watch(mw->sim_context, SIM_EFMBI_FILEID,
+						NULL, mw);
+		ofono_sim_add_file_watch(mw->sim_context, SIM_EFMBDN_FILEID,
+						NULL, mw);
+		ofono_sim_add_file_watch(mw->sim_context,
+						SIM_EF_CPHS_MBDN_FILEID,
+						NULL, mw);
 	}
 =

 	__ofono_atom_register(mw->atom, message_waiting_unregister);
diff --git a/src/network.c b/src/network.c
index d94f696..8190142 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1826,6 +1826,15 @@ void ofono_netreg_register(struct ofono_netreg *netr=
eg)
 		ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_spn_read_cb, netreg);
+
+		ofono_sim_add_file_watch(netreg->sim_context, SIM_EFPNN_FILEID,
+						NULL, netreg);
+		ofono_sim_add_file_watch(netreg->sim_context, SIM_EFSPN_FILEID,
+						NULL, netreg);
+		ofono_sim_add_file_watch(netreg->sim_context, SIM_EFSPDI_FILEID,
+						NULL, netreg);
+		ofono_sim_add_file_watch(netreg->sim_context, SIM_EFOPL_FILEID,
+						NULL, netreg);
 	}
 =

 	__ofono_atom_register(netreg->atom, netreg_unregister);
diff --git a/src/sim.c b/src/sim.c
index 55d4d75..dd1efce 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -980,6 +980,7 @@ static void sim_iidf_read_cb(int ok, int length, int re=
cord,
 	/* read the clut data */
 	ofono_sim_read_bytes(sim->context, iidf_id, offset, clut_len,
 					sim_iidf_read_clut_cb, sim);
+	ofono_sim_add_file_watch(sim->context, iidf_id, NULL, sim);
 }
 =

 static void sim_get_image(struct ofono_sim *sim, unsigned char id,
@@ -1249,10 +1250,12 @@ out:
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

@@ -1265,6 +1268,21 @@ check:
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
@@ -1272,6 +1290,13 @@ static void sim_own_numbers_update(struct ofono_sim =
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
@@ -1316,16 +1341,46 @@ static void sim_efimg_read_cb(int ok, int length, i=
nt record,
 static void sim_ready(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_sim *sim =3D user;
+	int i, iidf_id;
+
+	if (new_state !=3D OFONO_SIM_STATE_READY) {
+		if (sim->context =3D=3D NULL)
+			return;
+
+		ofono_sim_remove_file_watch(sim->context, SIM_EFMSISDN_FILEID,
+						sim_own_numbers_changed, sim);
+		ofono_sim_remove_file_watch(sim->context, SIM_EFSDN_FILEID,
+						sim_service_numbers_changed,
+						sim);
+		ofono_sim_remove_file_watch(sim->context, SIM_EFIMG_FILEID,
+						NULL, sim);
+
+		if (sim->efimg =3D=3D NULL)
+			return;
+
+		for (i =3D sim->efimg_length / 9 - 1; i >=3D 0; i--) {
+			iidf_id =3D (sim->efimg[i * 9 + 3] << 8) |
+				sim->efimg[i * 9 + 4];
+
+			ofono_sim_remove_file_watch(sim->context, iidf_id,
+							NULL, sim);
+		}
 =

-	if (new_state !=3D OFONO_SIM_STATE_READY)
 		return;
+	}
 =

 	sim_own_numbers_update(sim);
+	ofono_sim_add_file_watch(sim->context, SIM_EFMSISDN_FILEID,
+					sim_own_numbers_changed, sim);
 =

 	ofono_sim_read(sim->context, SIM_EFSDN_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_sdn_read_cb, sim);
+	ofono_sim_add_file_watch(sim->context, SIM_EFSDN_FILEID,
+					sim_service_numbers_changed, sim);
+
 	ofono_sim_read(sim->context, SIM_EFIMG_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_efimg_read_cb, sim);
+	ofono_sim_add_file_watch(sim->context, SIM_EFIMG_FILEID, NULL, sim);
 }
 =

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
@@ -1444,6 +1499,9 @@ static gboolean check_bdn_status(struct ofono_sim *si=
m)
 		sim_fs_read_info(sim->context, SIM_EFBDN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				sim_efbdn_info_read_cb, sim);
+		sim_add_file_watch(sim->context, SIM_EFBDN_FILEID,
+					TRUE, NULL, sim);
+
 		return TRUE;
 	}
 =

@@ -1498,6 +1556,9 @@ static void sim_efsst_read_cb(int ok, int length, int=
 record,
 		sim_fs_read_info(sim->context, SIM_EFADN_FILEID,
 					OFONO_SIM_FILE_STRUCTURE_FIXED,
 					sim_efadn_info_read_cb, sim);
+		sim_add_file_watch(sim->context, SIM_EFADN_FILEID,
+					TRUE, NULL, sim);
+
 		return;
 	}
 =

@@ -1588,6 +1649,8 @@ static void sim_efust_read_cb(int ok, int length, int=
 record,
 		ofono_sim_read(sim->context, SIM_EFEST_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_efest_read_cb, sim);
+		sim_add_file_watch(sim->context, SIM_EFEST_FILEID,
+					TRUE, NULL, sim);
 =

 		return;
 	}
@@ -1649,6 +1712,8 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 		ofono_sim_read(sim->context, SIM_EFUST_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_efust_read_cb, sim);
+		sim_add_file_watch(sim->context, SIM_EFUST_FILEID,
+					TRUE, NULL, sim);
 =

 		return;
 	}
@@ -1671,6 +1736,7 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 	ofono_sim_read(sim->context, SIM_EFSST_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efsst_read_cb, sim);
+	sim_add_file_watch(sim->context, SIM_EFSST_FILEID, TRUE, NULL, sim);
 }
 =

 static void sim_initialize_after_pin(struct ofono_sim *sim)
@@ -1678,10 +1744,12 @@ static void sim_initialize_after_pin(struct ofono_s=
im *sim)
 	ofono_sim_read(sim->context, SIM_EFPHASE_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efphase_read_cb, sim);
+	sim_add_file_watch(sim->context, SIM_EFPHASE_FILEID, TRUE, NULL, sim);
 =

 	ofono_sim_read(sim->context, SIM_EFAD_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_ad_read_cb, sim);
+	sim_add_file_watch(sim->context, SIM_EFAD_FILEID, TRUE, NULL, sim);
 =

 	/*
 	 * Read CPHS-support bits, this is still part of the SIM
@@ -1690,6 +1758,8 @@ static void sim_initialize_after_pin(struct ofono_sim=
 *sim)
 	ofono_sim_read(sim->context, SIM_EF_CPHS_INFORMATION_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_cphs_information_read_cb, sim);
+	sim_add_file_watch(sim->context, SIM_EF_CPHS_INFORMATION_FILEID,
+				TRUE, NULL, sim);
 }
 =

 static void sim_pin_query_cb(const struct ofono_error *error,
@@ -1978,10 +2048,14 @@ static void sim_initialize(struct ofono_sim *sim)
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
+	sim_add_file_watch(sim->context, SIM_EF_ICCID_FILEID, TRUE, NULL, sim);
 =

 	/* EFecc is read by the voicecall atom */
 =

@@ -1996,9 +2070,12 @@ static void sim_initialize(struct ofono_sim *sim)
 	ofono_sim_read(sim->context, SIM_EFLI_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efli_read_cb, sim);
+	sim_add_file_watch(sim->context, SIM_EFLI_FILEID, TRUE, NULL, sim);
+
 	ofono_sim_read(sim->context, SIM_EFPL_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efpl_read_cb, sim);
+	sim_add_file_watch(sim->context, SIM_EFPL_FILEID, TRUE, NULL, sim);
 }
 =

 struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim)
@@ -2151,6 +2228,7 @@ static void sim_free_state(struct ofono_sim *sim)
 				(GFunc)service_number_free, NULL);
 		g_slist_free(sim->service_numbers);
 		sim->service_numbers =3D NULL;
+		sim->sdn_ready =3D FALSE;
 	}
 =

 	if (sim->efli) {
@@ -2190,6 +2268,11 @@ static void sim_free_state(struct ofono_sim *sim)
 		sim->efimg_length =3D 0;
 	}
 =

+	if (sim->context) {
+		ofono_sim_context_free(sim->context);
+		sim->context =3D NULL;
+	}
+
 	g_free(sim->iidf_image);
 	sim->iidf_image =3D NULL;
 =

@@ -2333,11 +2416,6 @@ static void sim_remove(struct ofono_atom *atom)
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

@@ -2409,7 +2487,6 @@ void ofono_sim_register(struct ofono_sim *sim)
 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
 	sim->state_watches =3D __ofono_watchlist_new(g_free);
 	sim->simfs =3D sim_fs_new(sim, sim->driver);
-	sim->context =3D ofono_sim_context_create(sim);
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
 =

diff --git a/src/voicecall.c b/src/voicecall.c
index 7632c0d..1a85f91 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2279,6 +2279,19 @@ struct ofono_voicecall *ofono_voicecall_create(struc=
t ofono_modem *modem,
 	return vc;
 }
 =

+static void read_ecc_numbers(int id, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+
+	/* Try both formats, only one or none will work */
+	ofono_sim_read(vc->sim_context, SIM_EFECC_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			ecc_g2_read_cb, vc);
+	ofono_sim_read(vc->sim_context, SIM_EFECC_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			ecc_g3_read_cb, vc);
+}
+
 static void sim_state_watch(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_voicecall *vc =3D user;
@@ -2288,13 +2301,10 @@ static void sim_state_watch(enum ofono_sim_state ne=
w_state, void *user)
 		if (vc->sim_context =3D=3D NULL)
 			vc->sim_context =3D ofono_sim_context_create(vc->sim);
 =

-		/* Try both formats, only one or none will work */
-		ofono_sim_read(vc->sim_context, SIM_EFECC_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-				ecc_g2_read_cb, vc);
-		ofono_sim_read(vc->sim_context, SIM_EFECC_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_FIXED,
-				ecc_g3_read_cb, vc);
+		read_ecc_numbers(SIM_EFECC_FILEID, vc);
+
+		ofono_sim_add_file_watch(vc->sim_context, SIM_EFECC_FILEID,
+						read_ecc_numbers, vc);
 		break;
 	case OFONO_SIM_STATE_NOT_PRESENT:
 		/* TODO: Must release all non-emergency calls */
-- =

1.7.1.86.g0e460.dirty


--===============1477419440530096011==--

