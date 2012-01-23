Content-Type: multipart/mixed; boundary="===============8610728256774495634=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH] sim: Make SPN change atomic for consumers
Date: Mon, 23 Jan 2012 11:41:36 +0200
Message-ID: <1327311696-11195-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8610728256774495634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Due to new spn watch semantics, ofono_sim_get_spn()
will report the absence of SPN while reading it,
which is probably incorrect.
---
 src/sim.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index e4bd378..703e0db 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2398,7 +2398,14 @@ static inline void spn_watches_notify(struct ofono_s=
im *sim)
 static void sim_spn_set(struct ofono_sim *sim, const void *data, int lengt=
h,
 						const unsigned char *dc)
 {
-	char *spn;
+	g_free(sim->spn);
+	sim->spn =3D NULL;
+
+	g_free(sim->spn_dc);
+	sim->spn_dc =3D NULL;
+
+	if (data =3D=3D NULL)
+		goto notify;
 =

 	/*
 	 * TS 31.102 says:
@@ -2416,19 +2423,18 @@ static void sim_spn_set(struct ofono_sim *sim, cons=
t void *data, int length,
 	 * itself which is not there either.  11.11 contains the same
 	 * paragraph as 51.101 and has an Annex B which we implement.
 	 */
-	spn =3D sim_string_to_utf8(data, length);
-	if (spn =3D=3D NULL) {
+	sim->spn =3D sim_string_to_utf8(data, length);
+	if (sim->spn =3D=3D NULL) {
 		ofono_error("EFspn read successfully, but couldn't parse");
 		goto notify;
 	}
 =

-	if (strlen(spn) =3D=3D 0) {
-		g_free(spn);
+	if (strlen(sim->spn) =3D=3D 0) {
+		g_free(sim->spn);
+		sim->spn =3D NULL;
 		goto notify;
 	}
 =

-	sim->spn =3D spn;
-
 	if (dc)
 		sim->spn_dc =3D g_memdup(dc, 1);
 =

@@ -2443,7 +2449,7 @@ static void sim_cphs_spn_short_read_cb(int ok, int le=
ngth, int record,
 	struct ofono_sim *sim =3D user_data;
 =

 	if (!ok) {
-		spn_watches_notify(sim);
+		sim_spn_set(sim, NULL, 0, NULL);
 		return;
 	}
 =

@@ -2464,7 +2470,7 @@ static void sim_cphs_spn_read_cb(int ok, int length, =
int record,
 					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 					sim_cphs_spn_short_read_cb, sim);
 		else
-			spn_watches_notify(sim);
+			sim_spn_set(sim, NULL, 0, NULL);
 =

 		return;
 	}
@@ -2496,12 +2502,6 @@ static void sim_spn_changed(int id, void *userdata)
 	if (sim->flags & SIM_FLAG_READING_SPN)
 		return;
 =

-	g_free(sim->spn);
-	sim->spn =3D NULL;
-
-	g_free(sim->spn_dc);
-	sim->spn_dc =3D NULL;
-
 	sim->flags |=3D SIM_FLAG_READING_SPN;
 	ofono_sim_read(sim->context, SIM_EFSPN_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-- =

1.7.5.4


--===============8610728256774495634==--

