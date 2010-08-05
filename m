Content-Type: multipart/mixed; boundary="===============6130748810561523551=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 3/7] sim: read EFimg
Date: Thu, 05 Aug 2010 14:32:36 -0700
Message-ID: <1281043960-9616-4-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1281043960-9616-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6130748810561523551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Read EFimg when the sim is ready, and store it in memory.
---
 src/sim.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d2ed780..6d723bb 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -88,6 +88,8 @@ struct ofono_sim {
 	unsigned char efmsisdn_records;
 	unsigned char *efli;
 	unsigned char efli_length;
+	unsigned char *efimg;
+	int efimg_length;
 	enum ofono_sim_cphs_phase cphs_phase;
 	unsigned char cphs_service_table[2];
 	struct ofono_watchlist *state_watches;
@@ -1001,6 +1003,44 @@ static void sim_own_numbers_update(struct ofono_sim =
*sim)
 			sim_msisdn_read_cb, sim);
 }
 =

+static void sim_efimg_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	unsigned char *efimg;
+	int num_records =3D length / record_length;
+
+	if (!ok)
+		return;
+
+	/*
+	 * EFimg descriptors are 9 bytes long.
+	 * Byte 1 of the record is the number of descriptors per record.
+	 */
+	if (record_length < 10)
+		return;
+
+	if (sim->efimg =3D=3D NULL) {
+		sim->efimg =3D g_try_malloc0(num_records * 9);
+
+		if (sim->efimg =3D=3D NULL)
+			return;
+
+		sim->efimg_length =3D num_records * 9;
+	}
+
+	/*
+	 * TBD - if we have more than one descriptor per record,
+	 * pick the nicest one.  For now we use the first one.
+	 */
+
+	/* copy descriptor into slot for this record */
+	efimg =3D &sim->efimg[(record - 1) * 9];
+
+	memcpy(efimg, &data[1], 9);
+}
+
 static void sim_ready(void *user, enum ofono_sim_state new_state)
 {
 	struct ofono_sim *sim =3D user;
@@ -1015,6 +1055,8 @@ static void sim_ready(void *user, enum ofono_sim_stat=
e new_state)
 			sim_ad_read_cb, sim);
 	ofono_sim_read(sim, SIM_EFSDN_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
 			sim_sdn_read_cb, sim);
+	ofono_sim_read(sim, SIM_EFIMG_FILEID, OFONO_SIM_FILE_STRUCTURE_FIXED,
+			sim_efimg_read_cb, sim);
 }
 =

 static void sim_cphs_information_read_cb(int ok, int length, int record,
@@ -1934,6 +1976,11 @@ static void sim_free_state(struct ofono_sim *sim)
 		g_strfreev(sim->language_prefs);
 		sim->language_prefs =3D NULL;
 	}
+
+	if (sim->efimg) {
+		g_free(sim->efimg);
+		sim->efimg =3D NULL;
+	}
 }
 =

 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
-- =

1.7.1.1


--===============6130748810561523551==--

