Content-Type: multipart/mixed; boundary="===============2634223784925010120=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] Implement ofono_sim_context api.
Date: Sat, 29 Jan 2011 01:29:21 +0100
Message-ID: <1296260961-15155-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1296260961-15155-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2634223784925010120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   20 +++++++--
 src/cbs.c             |   14 +++++-
 src/message-waiting.c |   37 ++++++++++++------
 src/network.c         |   18 +++++++--
 src/sim.c             |   82 ++++++++++++++++++++++-----------------
 src/simfs.c           |  102 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 src/simfs.h           |    9 +++-
 src/voicecall.c       |   13 +++++-
 8 files changed, 225 insertions(+), 70 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 512f223..0a7ae73 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -61,6 +61,7 @@ struct ofono_call_forwarding {
 	int query_end;
 	struct cf_ss_request *ss_req;
 	struct ofono_sim *sim;
+	struct ofono_sim_context *sim_context;
 	unsigned char cfis_record_id;
 	struct ofono_ussd *ussd;
 	unsigned int ussd_watch;
@@ -276,7 +277,7 @@ static void sim_set_cf_indicator(struct ofono_call_forw=
arding *cf)
 			data[3] =3D 128;
 		}
 =

-		ofono_sim_write(cf->sim, SIM_EFCFIS_FILEID,
+		ofono_sim_write(cf->sim_context, SIM_EFCFIS_FILEID,
 					sim_cfis_update_cb,
 					OFONO_SIM_FILE_STRUCTURE_FIXED,
 					cf->cfis_record_id, data,
@@ -287,7 +288,7 @@ static void sim_set_cf_indicator(struct ofono_call_forw=
arding *cf)
 	if (cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) {
 		unsigned char cff_voice =3D cfu_voice ? 0x0A : 0x05;
 =

-		ofono_sim_write(cf->sim, SIM_EF_CPHS_CFF_FILEID,
+		ofono_sim_write(cf->sim_context, SIM_EF_CPHS_CFF_FILEID,
 					sim_cphs_cff_update_cb,
 					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 					0, &cff_voice, sizeof(cff_voice), cf);
@@ -1363,11 +1364,11 @@ static void sim_read_cf_indicator(struct ofono_call=
_forwarding *cf)
 	if (__ofono_sim_service_available(cf->sim,
 			SIM_UST_SERVICE_CFIS,
 			SIM_SST_SERVICE_CFIS) =3D=3D TRUE)
-		ofono_sim_read(cf->sim, SIM_EFCFIS_FILEID,
+		ofono_sim_read(cf->sim_context, SIM_EFCFIS_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				sim_cfis_read_cb, cf);
 	else
-		ofono_sim_read(cf->sim, SIM_EF_CPHS_CFF_FILEID,
+		ofono_sim_read(cf->sim_context, SIM_EF_CPHS_CFF_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_cphs_cff_read_cb, cf);
 }
@@ -1402,11 +1403,18 @@ static void call_forwarding_unregister(struct ofono=
_atom *atom)
 	g_dbus_unregister_interface(conn, path,
 					OFONO_CALL_FORWARDING_INTERFACE);
 =

+	if (cf->sim_context) {
+		ofono_sim_context_free(cf->sim_context);
+		cf->sim_context =3D NULL;
+	}
+
 	if (cf->ussd)
 		cf_unregister_ss_controls(cf);
 =

-	if (cf->ussd_watch)
+	if (cf->ussd_watch) {
 		__ofono_modem_remove_atom_watch(modem, cf->ussd_watch);
+		cf->ussd_watch =3D 0;
+	}
 }
 =

 static void call_forwarding_remove(struct ofono_atom *atom)
@@ -1500,6 +1508,8 @@ void ofono_call_forwarding_register(struct ofono_call=
_forwarding *cf)
 	if (sim_atom) {
 		cf->sim =3D __ofono_atom_get_data(sim_atom);
 =

+		cf->sim_context =3D ofono_sim_context_create(cf->sim);
+
 		sim_read_cf_indicator(cf);
 	}
 =

diff --git a/src/cbs.c b/src/cbs.c
index 8e4afc1..8238043 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -57,6 +57,7 @@ struct ofono_cbs {
 	GSList *topics;
 	GSList *new_topics;
 	struct ofono_sim *sim;
+	struct ofono_sim_context *sim_context;
 	struct ofono_stk *stk;
 	struct ofono_netreg *netreg;
 	unsigned int netreg_watch;
@@ -605,6 +606,11 @@ static void cbs_unregister(struct ofono_atom *atom)
 		cbs->efcbmid_contents =3D NULL;
 	}
 =

+	if (cbs->sim_context) {
+		ofono_sim_context_free(cbs->sim_context);
+		cbs->sim_context =3D NULL;
+	}
+
 	cbs->sim =3D NULL;
 	cbs->stk =3D NULL;
 =

@@ -908,10 +914,10 @@ static void cbs_got_imsi(struct ofono_cbs *cbs)
 	 */
 	if (topics_str =3D=3D NULL ||
 			(cbs->topics =3D=3D NULL && topics_str[0] !=3D '\0')) {
-		ofono_sim_read(cbs->sim, SIM_EFCBMI_FILEID,
+		ofono_sim_read(cbs->sim_context, SIM_EFCBMI_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_cbmi_read_cb, cbs);
-		ofono_sim_read(cbs->sim, SIM_EFCBMIR_FILEID,
+		ofono_sim_read(cbs->sim_context, SIM_EFCBMIR_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_cbmir_read_cb, cbs);
 	}
@@ -919,7 +925,7 @@ static void cbs_got_imsi(struct ofono_cbs *cbs)
 	if (topics_str)
 		g_free(topics_str);
 =

-	ofono_sim_read(cbs->sim, SIM_EFCBMID_FILEID,
+	ofono_sim_read(cbs->sim_context, SIM_EFCBMID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_cbmid_read_cb, cbs);
 }
@@ -1067,6 +1073,8 @@ void ofono_cbs_register(struct ofono_cbs *cbs)
 	if (sim_atom) {
 		cbs->sim =3D __ofono_atom_get_data(sim_atom);
 =

+		cbs->sim_context =3D ofono_sim_context_create(cbs->sim);
+
 		if (ofono_sim_get_state(cbs->sim) =3D=3D OFONO_SIM_STATE_READY)
 			cbs_got_imsi(cbs);
 	}
diff --git a/src/message-waiting.c b/src/message-waiting.c
index 0e376b6..4fa4773 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -55,6 +55,7 @@ struct ofono_message_waiting {
 	gboolean cphs_mbdn_not_provided;
 	struct ofono_phone_number mailbox_number[5];
 	struct ofono_sim *sim;
+	struct ofono_sim_context *sim_context;
 	struct ofono_atom *atom;
 };
 =

@@ -202,7 +203,7 @@ static DBusMessage *set_cphs_mbdn(struct ofono_message_=
waiting *mw,
 	sim_adn_build(efmbdn, req->mw->ef_cphs_mbdn_length,
 			&req->number, NULL);
 =

-	if (ofono_sim_write(mw->sim, SIM_EF_CPHS_MBDN_FILEID,
+	if (ofono_sim_write(mw->sim_context, SIM_EF_CPHS_MBDN_FILEID,
 			sync ? cphs_mbdn_sync_cb : mbdn_set_cb,
 			OFONO_SIM_FILE_STRUCTURE_FIXED,
 			mw_mailbox_to_cphs_record[mailbox],
@@ -300,10 +301,10 @@ static DBusMessage *set_mbdn(struct ofono_message_wai=
ting *mw, int mailbox,
 =

 	sim_adn_build(efmbdn, req->mw->efmbdn_length, &req->number, NULL);
 =

-	if (ofono_sim_write(req->mw->sim, SIM_EFMBDN_FILEID, mbdn_set_cb,
-			OFONO_SIM_FILE_STRUCTURE_FIXED,
-			req->mw->efmbdn_record_id[mailbox],
-			efmbdn, req->mw->efmbdn_length, req) =3D=3D -1) {
+	if (ofono_sim_write(req->mw->sim_context, SIM_EFMBDN_FILEID,
+				mbdn_set_cb, OFONO_SIM_FILE_STRUCTURE_FIXED,
+				req->mw->efmbdn_record_id[mailbox],
+				efmbdn, req->mw->efmbdn_length, req) =3D=3D -1) {
 		g_free(req);
 =

 		if (msg)
@@ -600,7 +601,7 @@ static void mw_mbi_read_cb(int ok, int total_length, in=
t record,
 	for (i =3D 0; i < 5 && i < record_length; i++)
 		mw->efmbdn_record_id[i] =3D data[i];
 =

-	err =3D ofono_sim_read(mw->sim, SIM_EFMBDN_FILEID,
+	err =3D ofono_sim_read(mw->sim_context, SIM_EFMBDN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				mw_mbdn_read_cb, mw);
 =

@@ -615,7 +616,7 @@ out:
 	st =3D ofono_sim_get_cphs_service_table(mw->sim);
 =

 	if (st && bit_field(st[0], 4, 2) =3D=3D 3)
-		ofono_sim_read(mw->sim, SIM_EF_CPHS_MBDN_FILEID,
+		ofono_sim_read(mw->sim_context, SIM_EF_CPHS_MBDN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				mw_cphs_mbdn_read_cb, mw);
 }
@@ -689,7 +690,8 @@ static void mw_set_indicator(struct ofono_message_waiti=
ng *mw, int profile,
 		if (mw->messages[i].indication)
 			efmwis[0] |=3D 1 << i;
 =

-	if (ofono_sim_write(mw->sim, SIM_EFMWIS_FILEID, mw_mwis_write_cb,
+	if (ofono_sim_write(mw->sim_context, SIM_EFMWIS_FILEID,
+				mw_mwis_write_cb,
 				OFONO_SIM_FILE_STRUCTURE_FIXED, 1,
 				efmwis, mw->efmwis_length, mw) !=3D 0) {
 		ofono_error("Queuing a EF-MWI write to SIM failed");
@@ -707,7 +709,8 @@ try_cphs:
 		efmwis[1] =3D mw->messages[1].indication ? 0xa : 0x5 |
 			mw->messages[3].indication ? 0xa0 : 0x50;
 =

-	if (ofono_sim_write(mw->sim, SIM_EF_CPHS_MWIS_FILEID, mw_mwis_write_cb,
+	if (ofono_sim_write(mw->sim_context, SIM_EF_CPHS_MWIS_FILEID,
+				mw_mwis_write_cb,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT, 0,
 				efmwis, mw->ef_cphs_mwis_length, mw) !=3D 0)
 		ofono_error("Queuing a EF-MWIS write to SIM failed (CPHS)");
@@ -918,6 +921,14 @@ static void message_waiting_unregister(struct ofono_at=
om *atom)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
+	struct ofono_message_waiting *mw =3D __ofono_atom_get_data(atom);
+
+	if (mw->sim_context) {
+		ofono_sim_context_free(mw->sim_context);
+		mw->sim_context =3D NULL;
+	}
+
+	mw->sim =3D NULL;
 =

 	g_dbus_unregister_interface(conn, path,
 					OFONO_MESSAGE_WAITING_INTERFACE);
@@ -956,16 +967,18 @@ void ofono_message_waiting_register(struct ofono_mess=
age_waiting *mw)
 		/* Assume that if sim atom exists, it is ready */
 		mw->sim =3D __ofono_atom_get_data(sim_atom);
 =

+		mw->sim_context =3D ofono_sim_context_create(mw->sim);
+
 		/* Loads MWI states and MBDN from SIM */
-		ofono_sim_read(mw->sim, SIM_EFMWIS_FILEID,
+		ofono_sim_read(mw->sim_context, SIM_EFMWIS_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				mw_mwis_read_cb, mw);
-		ofono_sim_read(mw->sim, SIM_EFMBI_FILEID,
+		ofono_sim_read(mw->sim_context, SIM_EFMBI_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				mw_mbi_read_cb, mw);
 =

 		/* Also read CPHS MWIS field */
-		ofono_sim_read(mw->sim, SIM_EF_CPHS_MWIS_FILEID,
+		ofono_sim_read(mw->sim_context, SIM_EF_CPHS_MWIS_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				mw_cphs_mwis_read_cb, mw);
 	}
diff --git a/src/network.c b/src/network.c
index b5450ee..400d6c3 100644
--- a/src/network.c
+++ b/src/network.c
@@ -75,6 +75,7 @@ struct ofono_netreg {
 	struct sim_spdi *spdi;
 	struct sim_eons *eons;
 	struct ofono_sim *sim;
+	struct ofono_sim_context *sim_context;
 	GKeyFile *settings;
 	char *imsi;
 	struct ofono_watchlist *status_watches;
@@ -1469,7 +1470,7 @@ check:
 	 * is present.
 	 */
 	if (netreg->eons && !sim_eons_pnn_is_empty(netreg->eons))
-		ofono_sim_read(netreg->sim, SIM_EFOPL_FILEID,
+		ofono_sim_read(netreg->sim_context, SIM_EFOPL_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				sim_opl_read_cb, netreg);
 }
@@ -1548,7 +1549,7 @@ static void sim_spn_read_cb(int ok, int length, int r=
ecord,
 	}
 =

 	netreg->spname =3D spn;
-	ofono_sim_read(netreg->sim, SIM_EFSPDI_FILEID,
+	ofono_sim_read(netreg->sim_context, SIM_EFSPDI_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_spdi_read_cb, netreg);
 =

@@ -1682,6 +1683,13 @@ static void netreg_unregister(struct ofono_atom *ato=
m)
 		netreg->settings =3D NULL;
 	}
 =

+	if (netreg->sim_context) {
+		ofono_sim_context_free(netreg->sim_context);
+		netreg->sim_context =3D NULL;
+	}
+
+	netreg->sim =3D NULL;
+
 	g_dbus_unregister_interface(conn, path,
 					OFONO_NETWORK_REGISTRATION_INTERFACE);
 	ofono_modem_remove_interface(modem,
@@ -1811,12 +1819,14 @@ void ofono_netreg_register(struct ofono_netreg *net=
reg)
 		/* Assume that if sim atom exists, it is ready */
 		netreg->sim =3D __ofono_atom_get_data(sim_atom);
 =

+		netreg->sim_context =3D ofono_sim_context_create(netreg->sim);
+
 		netreg_load_settings(netreg);
 =

-		ofono_sim_read(netreg->sim, SIM_EFPNN_FILEID,
+		ofono_sim_read(netreg->sim_context, SIM_EFPNN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				sim_pnn_read_cb, netreg);
-		ofono_sim_read(netreg->sim, SIM_EFSPN_FILEID,
+		ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_spn_read_cb, netreg);
 	}
diff --git a/src/sim.c b/src/sim.c
index 3c5db90..e4e0cab 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -96,6 +96,7 @@ struct ofono_sim {
 	struct ofono_watchlist *state_watches;
 =

 	struct sim_fs *simfs;
+	struct ofono_sim_context *context;
 =

 	unsigned char *iidf_image;
 =

@@ -495,7 +496,7 @@ static gboolean set_own_numbers(struct ofono_sim *sim,
 			efmsisdn[sim->efmsisdn_length - 14] =3D 1;
 		}
 =

-		if (ofono_sim_write(req->sim, SIM_EFMSISDN_FILEID,
+		if (ofono_sim_write(req->sim->context, SIM_EFMSISDN_FILEID,
 				msisdn_set_cb, OFONO_SIM_FILE_STRUCTURE_FIXED,
 				record, efmsisdn,
 				sim->efmsisdn_length, req) =3D=3D 0)
@@ -923,7 +924,7 @@ static void sim_iidf_read_cb(int ok, int length, int re=
cord,
 	sim->iidf_image =3D g_memdup(data, length);
 =

 	/* read the clut data */
-	ofono_sim_read_bytes(sim, iidf_id, offset, clut_len,
+	ofono_sim_read_bytes(sim->context, iidf_id, offset, clut_len,
 					sim_iidf_read_clut_cb, sim);
 }
 =

@@ -955,7 +956,7 @@ static void sim_get_image(struct ofono_sim *sim, unsign=
ed char id,
 	iidf_len =3D efimg[7] << 8 | efimg[8];
 =

 	/* read the image data */
-	ofono_sim_read_bytes(sim, iidf_id, iidf_offset, iidf_len,
+	ofono_sim_read_bytes(sim->context, iidf_id, iidf_offset, iidf_len,
 				sim_iidf_read_cb, sim);
 }
 =

@@ -1212,8 +1213,9 @@ check:
 =

 static void sim_own_numbers_update(struct ofono_sim *sim)
 {
-	ofono_sim_read(sim, SIM_EFMSISDN_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
-			sim_msisdn_read_cb, sim);
+	ofono_sim_read(sim->context, SIM_EFMSISDN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_msisdn_read_cb,
+			sim);
 }
 =

 static void sim_efimg_read_cb(int ok, int length, int record,
@@ -1266,10 +1268,10 @@ static void sim_ready(enum ofono_sim_state new_stat=
e, void *user)
 =

 	sim_own_numbers_update(sim);
 =

-	ofono_sim_read(sim, SIM_EFSDN_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
-			sim_sdn_read_cb, sim);
-	ofono_sim_read(sim, SIM_EFIMG_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
-			sim_efimg_read_cb, sim);
+	ofono_sim_read(sim->context, SIM_EFSDN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_sdn_read_cb, sim);
+	ofono_sim_read(sim->context, SIM_EFIMG_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_efimg_read_cb, sim);
 }
 =

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
@@ -1385,7 +1387,7 @@ static gboolean check_bdn_status(struct ofono_sim *si=
m)
 	 */
 	if (sim_sst_is_active(sim->efsst, sim->efsst_length,
 			SIM_SST_SERVICE_BDN)) {
-		sim_fs_read_info(sim->simfs, SIM_EFBDN_FILEID,
+		sim_fs_read_info(sim->context, SIM_EFBDN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				sim_efbdn_info_read_cb, sim);
 		return TRUE;
@@ -1439,7 +1441,7 @@ static void sim_efsst_read_cb(int ok, int length, int=
 record,
 	 */
 	if (sim_sst_is_active(sim->efsst, sim->efsst_length,
 				SIM_SST_SERVICE_FDN)) {
-		sim_fs_read_info(sim->simfs, SIM_EFADN_FILEID,
+		sim_fs_read_info(sim->context, SIM_EFADN_FILEID,
 					OFONO_SIM_FILE_STRUCTURE_FIXED,
 					sim_efadn_info_read_cb, sim);
 		return;
@@ -1529,7 +1531,7 @@ static void sim_efust_read_cb(int ok, int length, int=
 record,
 				SIM_UST_SERVICE_FDN) ||
 			sim_ust_is_available(sim->efust, sim->efust_length,
 				SIM_UST_SERVICE_BDN)) {
-		ofono_sim_read(sim, SIM_EFEST_FILEID,
+		ofono_sim_read(sim->context, SIM_EFEST_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_efest_read_cb, sim);
 =

@@ -1590,7 +1592,7 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 	if (!ok || length !=3D 1) {
 		sim->phase =3D OFONO_SIM_PHASE_3G;
 =

-		ofono_sim_read(sim, SIM_EFUST_FILEID,
+		ofono_sim_read(sim->context, SIM_EFUST_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_efust_read_cb, sim);
 =

@@ -1612,18 +1614,18 @@ static void sim_efphase_read_cb(int ok, int length,=
 int record,
 		return;
 	}
 =

-	ofono_sim_read(sim, SIM_EFSST_FILEID,
+	ofono_sim_read(sim->context, SIM_EFSST_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efsst_read_cb, sim);
 }
 =

 static void sim_initialize_after_pin(struct ofono_sim *sim)
 {
-	ofono_sim_read(sim, SIM_EFPHASE_FILEID,
+	ofono_sim_read(sim->context, SIM_EFPHASE_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efphase_read_cb, sim);
 =

-	ofono_sim_read(sim, SIM_EFAD_FILEID,
+	ofono_sim_read(sim->context, SIM_EFAD_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_ad_read_cb, sim);
 =

@@ -1631,7 +1633,7 @@ static void sim_initialize_after_pin(struct ofono_sim=
 *sim)
 	 * Read CPHS-support bits, this is still part of the SIM
 	 * initialisation but no order is specified for it.
 	 */
-	ofono_sim_read(sim, SIM_EF_CPHS_INFORMATION_FILEID,
+	ofono_sim_read(sim->context, SIM_EF_CPHS_INFORMATION_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_cphs_information_read_cb, sim);
 }
@@ -1923,7 +1925,7 @@ static void sim_initialize(struct ofono_sim *sim)
 	 */
 =

 	/* Grab the EFiccid which is always available */
-	ofono_sim_read(sim, SIM_EF_ICCID_FILEID,
+	ofono_sim_read(sim->context, SIM_EF_ICCID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_iccid_read_cb, sim);
 =

@@ -1937,47 +1939,51 @@ static void sim_initialize(struct ofono_sim *sim)
 	 * However we don't depend on the user interface and so
 	 * need to read both files now.
 	 */
-	ofono_sim_read(sim, SIM_EFLI_FILEID,
+	ofono_sim_read(sim->context, SIM_EFLI_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efli_read_cb, sim);
-	ofono_sim_read(sim, SIM_EFPL_FILEID,
+	ofono_sim_read(sim->context, SIM_EFPL_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efpl_read_cb, sim);
 }
 =

-int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
+struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL || sim->simfs =3D=3D NULL)
+		return NULL;
+
+	return sim_fs_context_new(sim->simfs);
+}
+
+void ofono_sim_context_free(struct ofono_sim_context *context)
+{
+	return sim_fs_context_free(context);
+}
+
+int ofono_sim_read_bytes(struct ofono_sim_context *context, int id,
 			unsigned short offset, unsigned short num_bytes,
 			ofono_sim_file_read_cb_t cb, void *data)
 {
-	if (sim =3D=3D NULL)
-		return -1;
-
 	if (num_bytes =3D=3D 0)
 		return -1;
 =

-	return sim_fs_read(sim->simfs, id, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+	return sim_fs_read(context, id, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				offset, num_bytes, cb, data);
 }
 =

-int ofono_sim_read(struct ofono_sim *sim, int id,
+int ofono_sim_read(struct ofono_sim_context *context, int id,
 			enum ofono_sim_file_structure expected_type,
 			ofono_sim_file_read_cb_t cb, void *data)
 {
-	if (sim =3D=3D NULL)
-		return -1;
-
-	return sim_fs_read(sim->simfs, id, expected_type, 0, 0, cb, data);
+	return sim_fs_read(context, id, expected_type, 0, 0, cb, data);
 }
 =

-int ofono_sim_write(struct ofono_sim *sim, int id,
+int ofono_sim_write(struct ofono_sim_context *context, int id,
 			ofono_sim_file_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
 			const unsigned char *data, int length, void *userdata)
 {
-	if (sim =3D=3D NULL)
-		return -1;
-
-	return sim_fs_write(sim->simfs, id, cb, structure, record, data, length,
+	return sim_fs_write(context, id, cb, structure, record, data, length,
 				userdata);
 }
 =

@@ -2264,6 +2270,11 @@ static void sim_remove(struct ofono_atom *atom)
 =

 	sim_free_state(sim);
 =

+	if (sim->context) {
+		ofono_sim_context_free(sim->context);
+		sim->context =3D NULL;
+	}
+
 	if (sim->simfs) {
 		sim_fs_free(sim->simfs);
 		sim->simfs =3D NULL;
@@ -2331,6 +2342,7 @@ void ofono_sim_register(struct ofono_sim *sim)
 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
 	sim->state_watches =3D __ofono_watchlist_new(g_free);
 	sim->simfs =3D sim_fs_new(sim, sim->driver);
+	sim->context =3D ofono_sim_context_create(sim);
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
 =

diff --git a/src/simfs.c b/src/simfs.c
index 37e801a..5c1b77b 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -69,6 +69,7 @@ struct sim_fs_op {
 	gconstpointer cb;
 	gboolean is_read;
 	void *userdata;
+	struct ofono_sim_context *context;
 };
 =

 static void sim_fs_op_free(struct sim_fs_op *node)
@@ -105,6 +106,10 @@ void sim_fs_free(struct sim_fs *fs)
 	g_free(fs);
 }
 =

+struct ofono_sim_context {
+	struct sim_fs *fs;
+};
+
 struct sim_fs *sim_fs_new(struct ofono_sim *sim,
 				const struct ofono_sim_driver *driver)
 {
@@ -121,6 +126,44 @@ struct sim_fs *sim_fs_new(struct ofono_sim *sim,
 	return fs;
 }
 =

+struct ofono_sim_context *sim_fs_context_new(struct sim_fs *fs)
+{
+	struct ofono_sim_context *context =3D
+		g_try_new0(struct ofono_sim_context, 1);
+
+	if (context =3D=3D NULL)
+		return NULL;
+
+	context->fs =3D fs;
+
+	return context;
+}
+
+void sim_fs_context_free(struct ofono_sim_context *context)
+{
+	int n =3D 0;
+	struct sim_fs_op *op;
+
+	while ((op =3D g_queue_peek_nth(context->fs->op_q, n)) !=3D NULL) {
+		if (op->context !=3D context) {
+			n +=3D 1;
+			continue;
+		}
+
+		if (n =3D=3D 0) {
+			op->cb =3D NULL;
+
+			n +=3D 1;
+			continue;
+		}
+
+		sim_fs_op_free(op);
+		g_queue_remove(context->fs->op_q, op);
+	}
+
+	g_free(context);
+}
+
 static void sim_fs_end_current(struct sim_fs *fs)
 {
 	struct sim_fs_op *op =3D g_queue_pop_head(fs->op_q);
@@ -142,6 +185,11 @@ static void sim_fs_op_error(struct sim_fs *fs)
 {
 	struct sim_fs_op *op =3D g_queue_peek_head(fs->op_q);
 =

+	if (op->cb =3D=3D NULL) {
+		sim_fs_end_current(fs);
+		return;
+	}
+
 	if (op->info_only =3D=3D TRUE)
 		((sim_fs_read_info_cb_t) op->cb)
 			(0, 0, 0, 0, op->userdata);
@@ -201,6 +249,11 @@ static void sim_fs_op_write_cb(const struct ofono_erro=
r *error, void *data)
 	struct sim_fs_op *op =3D g_queue_peek_head(fs->op_q);
 	ofono_sim_file_write_cb_t cb =3D op->cb;
 =

+	if (cb =3D=3D NULL) {
+		sim_fs_end_current(fs);
+		return;
+	}
+
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 		cb(1, op->userdata);
 	else
@@ -247,6 +300,11 @@ static void sim_fs_op_read_block_cb(const struct ofono=
_error *error,
 	memcpy(op->buffer + bufoff, data + dataoff, tocopy);
 	cache_block(fs, op->current, 256, data, len);
 =

+	if (op->cb =3D=3D NULL) {
+		sim_fs_end_current(fs);
+		return;
+	}
+
 	op->current++;
 =

 	if (op->current > end_block) {
@@ -271,6 +329,11 @@ static gboolean sim_fs_op_read_block(gpointer user_dat=
a)
 =

 	fs->op_source =3D 0;
 =

+	if (op->cb =3D=3D NULL) {
+		sim_fs_end_current(fs);
+		return FALSE;
+	}
+
 	start_block =3D op->offset / 256;
 	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
 =

@@ -357,12 +420,17 @@ static void sim_fs_op_retrieve_cb(const struct ofono_=
error *error,
 		return;
 	}
 =

-	cb(1, op->length, op->current, data, op->record_length, op->userdata);
-
 	cache_block(fs, op->current - 1, op->record_length,
 			data, op->record_length);
 =

-	if (op->current < total) {
+	if (cb =3D=3D NULL) {
+		sim_fs_end_current(fs);
+		return;
+	}
+
+	cb(1, op->length, op->current, data, op->record_length, op->userdata);
+
+  	if (op->current < total) {
 		op->current +=3D 1;
 		fs->op_source =3D g_idle_add(sim_fs_op_read_record, fs);
 	} else {
@@ -380,6 +448,11 @@ static gboolean sim_fs_op_read_record(gpointer user)
 =

 	fs->op_source =3D 0;
 =

+	if (op->cb =3D=3D NULL) {
+		sim_fs_end_current(fs);
+		return FALSE;
+	}
+
 	while (fs->fd !=3D -1 && op->current <=3D total) {
 		int offset =3D (op->current - 1) / 8;
 		int bit =3D 1 << ((op->current - 1) % 8);
@@ -520,6 +593,11 @@ static void sim_fs_op_info_cb(const struct ofono_error=
 *error, int length,
 		return;
 	}
 =

+	if (op->cb =3D=3D NULL) {
+		sim_fs_end_current(fs);
+		return;
+	}
+
 	op->structure =3D structure;
 	op->length =3D length;
 =

@@ -660,6 +738,11 @@ static gboolean sim_fs_op_next(gpointer user_data)
 =

 	op =3D g_queue_peek_head(fs->op_q);
 =

+	if (op->cb =3D=3D NULL) {
+		sim_fs_end_current(fs);
+		return FALSE;
+	}
+
 	if (op->is_read =3D=3D TRUE) {
 		if (sim_fs_op_check_cached(fs))
 			return FALSE;
@@ -694,10 +777,11 @@ static gboolean sim_fs_op_next(gpointer user_data)
 	return FALSE;
 }
 =

-int sim_fs_read_info(struct sim_fs *fs, int id,
+int sim_fs_read_info(struct ofono_sim_context *context, int id,
 			enum ofono_sim_file_structure expected_type,
 			sim_fs_read_info_cb_t cb, void *data)
 {
+	struct sim_fs *fs =3D context->fs;
 	struct sim_fs_op *op;
 =

 	if (cb =3D=3D NULL)
@@ -722,6 +806,7 @@ int sim_fs_read_info(struct sim_fs *fs, int id,
 	op->userdata =3D data;
 	op->is_read =3D TRUE;
 	op->info_only =3D TRUE;
+	op->context =3D context;
 =

 	g_queue_push_tail(fs->op_q, op);
 =

@@ -731,11 +816,12 @@ int sim_fs_read_info(struct sim_fs *fs, int id,
 	return 0;
 }
 =

-int sim_fs_read(struct sim_fs *fs, int id,
+int sim_fs_read(struct ofono_sim_context *context, int id,
 		enum ofono_sim_file_structure expected_type,
 		unsigned short offset, unsigned short num_bytes,
 		ofono_sim_file_read_cb_t cb, void *data)
 {
+	struct sim_fs *fs =3D context->fs;
 	struct sim_fs_op *op;
 =

 	if (cb =3D=3D NULL)
@@ -762,6 +848,7 @@ int sim_fs_read(struct sim_fs *fs, int id,
 	op->offset =3D offset;
 	op->num_bytes =3D num_bytes;
 	op->info_only =3D FALSE;
+	op->context =3D context;
 =

 	g_queue_push_tail(fs->op_q, op);
 =

@@ -771,10 +858,12 @@ int sim_fs_read(struct sim_fs *fs, int id,
 	return 0;
 }
 =

-int sim_fs_write(struct sim_fs *fs, int id, ofono_sim_file_write_cb_t cb,
+int sim_fs_write(struct ofono_sim_context *context, int id,
+			ofono_sim_file_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
 			const unsigned char *data, int length, void *userdata)
 {
+	struct sim_fs *fs =3D context->fs;
 	struct sim_fs_op *op;
 	gconstpointer fn =3D NULL;
 =

@@ -816,6 +905,7 @@ int sim_fs_write(struct sim_fs *fs, int id, ofono_sim_f=
ile_write_cb_t cb,
 	op->structure =3D structure;
 	op->length =3D length;
 	op->current =3D record;
+	op->context =3D context;
 =

 	g_queue_push_tail(fs->op_q, op);
 =

diff --git a/src/simfs.h b/src/simfs.h
index 8c6f761..d93d96e 100644
--- a/src/simfs.h
+++ b/src/simfs.h
@@ -27,19 +27,21 @@ typedef void (*sim_fs_read_info_cb_t)(int ok, unsigned =
char file_status,
 =

 struct sim_fs *sim_fs_new(struct ofono_sim *sim,
 				const struct ofono_sim_driver *driver);
+struct ofono_sim_context *sim_fs_context_new(struct sim_fs *fs);
 =

-int sim_fs_read(struct sim_fs *fs, int id,
+int sim_fs_read(struct ofono_sim_context *context, int id,
 		enum ofono_sim_file_structure expected_type,
 		unsigned short offset, unsigned short num_bytes,
 		ofono_sim_file_read_cb_t cb, void *data);
 =

-int sim_fs_read_info(struct sim_fs *fs, int id,
+int sim_fs_read_info(struct ofono_sim_context *context, int id,
 		enum ofono_sim_file_structure expected_type,
 		sim_fs_read_info_cb_t cb, void *data);
 =

 void sim_fs_check_version(struct sim_fs *fs);
 =

-int sim_fs_write(struct sim_fs *fs, int id, ofono_sim_file_write_cb_t cb,
+int sim_fs_write(struct ofono_sim_context *context, int id,
+			ofono_sim_file_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
 			const unsigned char *data, int length, void *userdata);
 =

@@ -53,3 +55,4 @@ void sim_fs_image_cache_flush(struct sim_fs *fs);
 void sim_fs_image_cache_flush_file(struct sim_fs *fs, int id);
 =

 void sim_fs_free(struct sim_fs *fs);
+void sim_fs_context_free(struct ofono_sim_context *context);
diff --git a/src/voicecall.c b/src/voicecall.c
index 6246787..7632c0d 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -50,6 +50,7 @@ struct ofono_voicecall {
 	GSList *new_en_list; /* Emergency numbers being read from SIM */
 	DBusMessage *pending;
 	struct ofono_sim *sim;
+	struct ofono_sim_context *sim_context;
 	unsigned int sim_watch;
 	unsigned int sim_state_watch;
 	const struct ofono_voicecall_driver *driver;
@@ -2284,17 +2285,25 @@ static void sim_state_watch(enum ofono_sim_state ne=
w_state, void *user)
 =

 	switch (new_state) {
 	case OFONO_SIM_STATE_INSERTED:
+		if (vc->sim_context =3D=3D NULL)
+			vc->sim_context =3D ofono_sim_context_create(vc->sim);
+
 		/* Try both formats, only one or none will work */
-		ofono_sim_read(vc->sim, SIM_EFECC_FILEID,
+		ofono_sim_read(vc->sim_context, SIM_EFECC_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				ecc_g2_read_cb, vc);
-		ofono_sim_read(vc->sim, SIM_EFECC_FILEID,
+		ofono_sim_read(vc->sim_context, SIM_EFECC_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				ecc_g3_read_cb, vc);
 		break;
 	case OFONO_SIM_STATE_NOT_PRESENT:
 		/* TODO: Must release all non-emergency calls */
 =

+		if (vc->sim_context) {
+			ofono_sim_context_free(vc->sim_context);
+			vc->sim_context =3D NULL;
+		}
+
 		/*
 		 * Free the currently being read EN list, just in case the
 		 * SIM is removed when we're still reading them
-- =

1.7.1.86.g0e460.dirty


--===============2634223784925010120==--

