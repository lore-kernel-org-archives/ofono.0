Content-Type: multipart/mixed; boundary="===============2273154693223931812=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [RfC] SIM file watch support.
Date: Fri, 05 Nov 2010 13:13:39 +0100
Message-ID: <1288959219-3598-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2273154693223931812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to support the Refresh STK command we need to implement at
least two types of reset: UICC reset (manufacturer specific) and NAA
application reset.  Other types can fall back to application reset
which can be implemented by removing all atoms and reinitialising them.

When we get a Refresh with "File Change Notification" we should first
check if we're even interested in the file.  We check if the file is
being watched by any atom and whether the atom can deal with the change
dynamically.  If not, we fall back to NAA application reset.

The proposed api lets the users of sim_fs_read register to
notifications of file change by adding a watch.  In the simplest case
they can add a "null" watch for a file ID that they care about
(callback address is NULL), to indicate that the file is important to
us, but we haven't implemented a way to deal with the contents change
dynamically, or we can not.
(Maybe all files being read should automatically become watched, but
some files might be read only on some user action, in that case we
don't need to watch them)

stk.c will check if any of the file IDs supplied in the command have
any watches on them.  If there are only watches with non-NULL
callback, it'll call all of them and not reset application.  If
there are any NULL notifiers, then stk.c will fall back to full
application reset.  If any of the files were cached, they need to
be re-read.
---
 src/simfs.h |   12 ++++++++++++
 src/sim.c   |   21 ++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/src/simfs.h b/src/simfs.h
index ef962db..679955a 100644
--- a/src/simfs.h
+++ b/src/simfs.h
@@ -25,6 +25,8 @@ typedef void (*sim_fs_read_info_cb_t)(int ok, unsigned ch=
ar file_status,
 					int total_length, int record_length,
 					void *userdata);
 =

+typedef void (*sim_fs_ef_notify_t)(int id, void *userdata);
+
 struct sim_fs *sim_fs_new(struct ofono_sim *sim,
 				const struct ofono_sim_driver *driver);
 =

@@ -48,3 +50,13 @@ char *sim_fs_get_cached_image(struct sim_fs *fs, int id);
 void sim_fs_cache_image(struct sim_fs *fs, const char *image, int id);
 =

 void sim_fs_free(struct sim_fs *fs);
+
+int sim_fs_add_ef_watch(struct sim_fs *fs, int id,
+			sim_fs_ef_notify_t *notify, void *userdata);
+
+int sim_fs_remove_ef_watch(struct sim_fs *fs, int id,
+			sim_fs_ef_notify_t *notify, void *userdata);
+
+ofono_bool_t sim_fs_has_empty_watches(struct sim_fs *fs, int id);
+
+int sim_fs_notify_file_change(struct sim_fs *fs, int id);
diff --git a/src/sim.c b/src/sim.c
index 02ab329..ea36756 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1184,15 +1184,23 @@ static void sim_ready(enum ofono_sim_state new_stat=
e, void *user)
 {
 	struct ofono_sim *sim =3D user;
 =

-	if (new_state !=3D OFONO_SIM_STATE_READY)
+	if (new_state !=3D OFONO_SIM_STATE_READY) {
+		sim_fs_remove_ef_watch(sim->simfs, SIM_EFMSISDN_FILEID,
+					NULL, sim);
+
 		return;
+	}
 =

 	sim_own_numbers_update(sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EFMSISDN_FILEID, NULL, sim);
 =

 	ofono_sim_read(sim, SIM_EFSDN_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
 			sim_sdn_read_cb, sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EFSDN_FILEID, NULL, sim);
+
 	ofono_sim_read(sim, SIM_EFIMG_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
 			sim_efimg_read_cb, sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EFIMG_FILEID, NULL, sim);
 }
 =

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
@@ -1437,6 +1445,7 @@ static void sim_efust_read_cb(int ok, int length, int=
 record,
 	ofono_sim_read(sim, SIM_EFEST_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efest_read_cb, sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EFEST_FILEID, NULL, sim);
 =

 	return;
 =

@@ -1497,6 +1506,7 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 		ofono_sim_read(sim, SIM_EFUST_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_efust_read_cb, sim);
+		sim_fs_add_ef_watch(sim->simfs, SIM_EFUST_FILEID, NULL, sim);
 =

 		return;
 	}
@@ -1519,6 +1529,7 @@ static void sim_efphase_read_cb(int ok, int length, i=
nt record,
 	ofono_sim_read(sim, SIM_EFSST_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efsst_read_cb, sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EFSST_FILEID, NULL, sim);
 }
 =

 static void sim_initialize_after_pin(struct ofono_sim *sim)
@@ -1526,10 +1537,12 @@ static void sim_initialize_after_pin(struct ofono_s=
im *sim)
 	ofono_sim_read(sim, SIM_EFPHASE_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efphase_read_cb, sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EFPHASE_FILEID, NULL, sim);
 =

 	ofono_sim_read(sim, SIM_EFAD_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_ad_read_cb, sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EFAD_FILEID, NULL, sim);
 =

 	/*
 	 * Read CPHS-support bits, this is still part of the SIM
@@ -1538,6 +1551,8 @@ static void sim_initialize_after_pin(struct ofono_sim=
 *sim)
 	ofono_sim_read(sim, SIM_EF_CPHS_INFORMATION_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_cphs_information_read_cb, sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EF_CPHS_INFORMATION_FILEID,
+				NULL, sim);
 }
 =

 static void sim_pin_query_cb(const struct ofono_error *error,
@@ -1828,6 +1843,7 @@ static void sim_initialize(struct ofono_sim *sim)
 	ofono_sim_read(sim, SIM_EF_ICCID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_iccid_read_cb, sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EF_ICCID_FILEID, NULL, sim);
 =

 	/* EFecc is read by the voicecall atom */
 =

@@ -1842,9 +1858,12 @@ static void sim_initialize(struct ofono_sim *sim)
 	ofono_sim_read(sim, SIM_EFLI_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efli_read_cb, sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EFLI_FILEID, NULL, sim);
+
 	ofono_sim_read(sim, SIM_EFPL_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efpl_read_cb, sim);
+	sim_fs_add_ef_watch(sim->simfs, SIM_EFPL_FILEID, NULL, sim);
 }
 =

 int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
-- =

1.7.1.86.g0e460.dirty


--===============2273154693223931812==--

