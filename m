Content-Type: multipart/mixed; boundary="===============5999260320155932184=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/9] sim: Implement basic Refresh.
Date: Tue, 15 Feb 2011 08:58:52 +0100
Message-ID: <1297756739-2958-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1297756739-2958-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5999260320155932184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    4 ++
 src/sim.c   |  163 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-=
---
 2 files changed, 155 insertions(+), 12 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index dbe1862..8f3b684 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -317,6 +317,10 @@ ofono_bool_t __ofono_is_valid_sim_pin(const char *pin,
 =

 ofono_bool_t __ofono_is_valid_net_pin(const char *pin);
 =

+void __ofono_sim_refresh(struct ofono_sim *sim, GSList *file_list,
+				ofono_bool_t full_file_change,
+				ofono_bool_t naa_init);
+
 #include <ofono/stk.h>
 =

 typedef void (*__ofono_sms_sim_download_cb_t)(ofono_bool_t ok,
diff --git a/src/sim.c b/src/sim.c
index c2e8631..7c2e151 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -26,6 +26,7 @@
 #define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
+#include <stdint.h>
 =

 #include <glib.h>
 #include <gdbus.h>
@@ -2078,13 +2079,27 @@ static void sim_inserted_update(struct ofono_sim *s=
im)
 						DBUS_TYPE_BOOLEAN, &present);
 }
 =

-static void sim_free_state(struct ofono_sim *sim)
+static void sim_free_early_state(struct ofono_sim *sim)
 {
 	if (sim->iccid) {
 		g_free(sim->iccid);
 		sim->iccid =3D NULL;
 	}
 =

+	if (sim->efli) {
+		g_free(sim->efli);
+		sim->efli =3D NULL;
+		sim->efli_length =3D 0;
+	}
+
+	if (sim->language_prefs) {
+		g_strfreev(sim->language_prefs);
+		sim->language_prefs =3D NULL;
+	}
+}
+
+static void sim_free_main_state(struct ofono_sim *sim)
+{
 	if (sim->imsi) {
 		g_free(sim->imsi);
 		sim->imsi =3D NULL;
@@ -2106,17 +2121,6 @@ static void sim_free_state(struct ofono_sim *sim)
 		sim->service_numbers =3D NULL;
 	}
 =

-	if (sim->efli) {
-		g_free(sim->efli);
-		sim->efli =3D NULL;
-		sim->efli_length =3D 0;
-	}
-
-	if (sim->language_prefs) {
-		g_strfreev(sim->language_prefs);
-		sim->language_prefs =3D NULL;
-	}
-
 	if (sim->efust) {
 		g_free(sim->efust);
 		sim->efust =3D NULL;
@@ -2150,6 +2154,12 @@ static void sim_free_state(struct ofono_sim *sim)
 	sim->barred_dialing =3D FALSE;
 }
 =

+static void sim_free_state(struct ofono_sim *sim)
+{
+	sim_free_early_state(sim);
+	sim_free_main_state(sim);
+}
+
 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
 {
 	ofono_sim_state_event_cb_t notify;
@@ -2442,3 +2452,132 @@ ofono_bool_t __ofono_is_valid_net_pin(const char *p=
in)
 {
 	return is_valid_pin(pin, 4, 4);
 }
+
+static void sim_file_changed_flush(struct ofono_sim *sim, int id)
+{
+	int i, imgid;
+
+	if (id =3D=3D SIM_EFIMG_FILEID)
+		/* All cached images become invalid */
+		sim_fs_image_cache_flush(sim->simfs);
+	else if (sim->efimg) {
+		/*
+		 * Data and CLUT for image instances stored in the changed
+		 * file need to be re-read.
+		 */
+		for (i =3D sim->efimg_length / 9 - 1; i >=3D 0; i--) {
+			imgid =3D (sim->efimg[i * 9 + 3] << 8) |
+				sim->efimg[i * 9 + 4];
+
+			if (imgid =3D=3D id)
+				sim_fs_image_cache_flush_file(sim->simfs, i);
+		}
+	}
+
+	sim_fs_cache_flush_file(sim->simfs, id);
+}
+
+void __ofono_sim_refresh(struct ofono_sim *sim, GSList *file_list,
+			ofono_bool_t full_file_change, ofono_bool_t naa_init)
+{
+	GSList *l;
+	ofono_sim_state_event_cb_t notify;
+	gboolean reinit_naa =3D naa_init || full_file_change;
+
+	/*
+	 * Check if any files used in SIM initialisation procedure
+	 * are affected, except EFiccid, EFpl, EFli.
+	 */
+	for (l =3D file_list; l; l =3D l->next) {
+		struct stk_file *file =3D l->data;
+		uint32_t mf, df, ef;
+
+		if (file->len !=3D 6)
+			continue;
+
+		mf =3D (file->file[0] << 8) | (file->file[1] << 0);
+		df =3D (file->file[2] << 8) | (file->file[3] << 0);
+		ef =3D (file->file[4] << 8) | (file->file[5] << 0);
+
+		if (mf !=3D 0x3f00)
+			continue;
+
+		/*
+		 * 8.18: "the path '3F007FFF' indicates the relevant
+		 * NAA Application dedicated file;".
+		 */
+		if (df =3D=3D 0x7fff)
+			df =3D 0x7f20;
+
+#define DFGSM (0x7f20 << 16)
+#define DFTEL (0x7f10 << 16)
+
+		switch ((df << 16) | ef) {
+		case DFGSM | SIM_EFEST_FILEID:
+		case DFGSM | SIM_EFUST_FILEID: /* aka. EFSST */
+		case DFGSM | SIM_EFPHASE_FILEID:
+		case DFGSM | SIM_EFAD_FILEID:
+		case DFTEL | SIM_EFBDN_FILEID:
+		case DFTEL | SIM_EFADN_FILEID:
+		case DFGSM | SIM_EF_CPHS_INFORMATION_FILEID:
+			reinit_naa =3D TRUE;
+			break;
+		}
+	}
+
+	/* Flush cached content for affected files */
+	if (full_file_change)
+		sim_fs_cache_flush(sim->simfs);
+	else {
+		for (l =3D file_list; l; l =3D l->next) {
+			struct stk_file *file =3D l->data;
+			int id =3D (file->file[file->len - 2] << 8) |
+				(file->file[file->len - 1] << 0);
+
+			sim_file_changed_flush(sim, id);
+		}
+	}
+
+	if (reinit_naa) {
+		/* Force the sim state out of READY */
+
+		sim_free_main_state(sim);
+
+		sim->state =3D OFONO_SIM_STATE_INSERTED;
+		for (l =3D sim->state_watches->items; l; l =3D l->next) {
+			struct ofono_watchlist_item *item =3D l->data;
+			notify =3D item->notify;
+
+			notify(sim->state, item->notify_data);
+		}
+	}
+
+	/*
+	 * Notify the subscribers of files that have changed and who
+	 * haven't unsubsribed during the SIM state change.
+	 */
+	if (full_file_change)
+		sim_fs_notify_file_watches(sim->simfs, -1);
+	else {
+		for (l =3D file_list; l; l =3D l->next) {
+			struct stk_file *file =3D l->data;
+			int id =3D (file->file[file->len - 2] << 8) |
+				(file->file[file->len - 1] << 0);
+
+			sim_fs_notify_file_watches(sim->simfs, id);
+		}
+	}
+
+	if (reinit_naa) {
+		/*
+		 * REVISIT: There's some concern that on re-insertion the
+		 * atoms will start to talk to the SIM before it becomes
+		 * ready, on certain SIMs.
+		 */
+		/*
+		 * Start initialization procedure from after EFiccid,
+		 * EFli and EFpl are retrieved.
+		 */
+		sim_pin_check(sim);
+	}
+}
-- =

1.7.1.86.g0e460.dirty


--===============5999260320155932184==--

