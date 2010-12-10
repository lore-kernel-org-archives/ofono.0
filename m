Content-Type: multipart/mixed; boundary="===============3998629007397978505=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5][RfC] sim: Watch files we keep in memory.
Date: Fri, 10 Dec 2010 14:59:23 +0100
Message-ID: <1291989564-28694-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1291989564-28694-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3998629007397978505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These are dummy watches on files who's state is kept in memory, just
to ensure that on a refresh affecting any of those files ofono
re-reads them from SIM.  The flow of the code in sim.c has become
a little complicated, maybe watches should be automatically set for
files that are being read and removed when the sim state changes to
a lower state or atom is removed, for example, but this wouldn't be
flexible enough for some of the corner cases.
---
 src/sim.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index da098b7..2368b3d 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1192,15 +1192,28 @@ static void sim_ready(enum ofono_sim_state new_stat=
e, void *user)
 {
 	struct ofono_sim *sim =3D user;
 =

-	if (new_state !=3D OFONO_SIM_STATE_READY)
+	if (new_state !=3D OFONO_SIM_STATE_READY) {
+		ofono_sim_remove_file_watch(sim, SIM_EFMSISDN_FILEID,
+						NULL, sim);
+		ofono_sim_remove_file_watch(sim, SIM_EFSDN_FILEID, NULL, sim);
+		ofono_sim_remove_file_watch(sim, SIM_EFIMG_FILEID, NULL, sim);
+
 		return;
+	}
 =

 	sim_own_numbers_update(sim);
+	ofono_sim_add_file_watch(sim, SIM_EFMSISDN_FILEID,
+					OFONO_SIM_STATE_READY, NULL, sim);
 =

 	ofono_sim_read(sim, SIM_EFSDN_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
 			sim_sdn_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFSDN_FILEID,
+					OFONO_SIM_STATE_READY, NULL, sim);
+
 	ofono_sim_read(sim, SIM_EFIMG_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
 			sim_efimg_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFIMG_FILEID,
+					OFONO_SIM_STATE_READY, NULL, sim);
 }
 =

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
@@ -1464,6 +1477,9 @@ static void sim_efust_read_cb(int ok, int length, int=
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
@@ -1525,6 +1541,9 @@ static void sim_efphase_read_cb(int ok, int length, i=
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
@@ -1547,6 +1566,8 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 	ofono_sim_read(sim, SIM_EFSST_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efsst_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EFSST_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 }
 =

 static void sim_initialize_after_pin(struct ofono_sim *sim)
@@ -1554,10 +1575,14 @@ static void sim_initialize_after_pin(struct ofono_s=
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
@@ -1566,6 +1591,8 @@ static void sim_initialize_after_pin(struct ofono_sim=
 *sim)
 	ofono_sim_read(sim, SIM_EF_CPHS_INFORMATION_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_cphs_information_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EF_CPHS_INFORMATION_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 }
 =

 static void sim_pin_query_cb(const struct ofono_error *error,
@@ -1856,6 +1883,8 @@ static void sim_initialize(struct ofono_sim *sim)
 	ofono_sim_read(sim, SIM_EF_ICCID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_iccid_read_cb, sim);
+	ofono_sim_add_file_watch(sim, SIM_EF_ICCID_FILEID,
+					OFONO_SIM_STATE_INSERTED, NULL, sim);
 =

 	/* EFecc is read by the voicecall atom */
 =

@@ -1870,9 +1899,14 @@ static void sim_initialize(struct ofono_sim *sim)
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
@@ -2037,6 +2071,17 @@ static void sim_free_state(struct ofono_sim *sim)
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


--===============3998629007397978505==--

