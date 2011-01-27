Content-Type: multipart/mixed; boundary="===============4294888437210137726=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 2/3] sim: add ofono_sim_get_spn API implementation
Date: Thu, 27 Jan 2011 15:22:16 +0200
Message-ID: <1296134537-16133-3-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1296134537-16133-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4294888437210137726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 3c5db90..2c09c11 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -80,6 +80,8 @@ struct ofono_sim {
 	char *imsi;
 	char mcc[OFONO_MAX_MCC_LENGTH + 1];
 	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	char *spn;
+	unsigned char spn_dc;
 =

 	GSList *own_numbers;
 	GSList *new_numbers;
@@ -1257,6 +1259,49 @@ static void sim_efimg_read_cb(int ok, int length, in=
t record,
 	memcpy(efimg, &data[1], 9);
 }
 =

+static void sim_spn_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	if (!ok)
+		goto finish;
+
+	sim->spn_dc =3D data[0];
+
+	/*
+	 * TS 31.102 says:
+	 *
+	 * the string shall use:
+	 *
+	 * - either the SMS default 7-bit coded alphabet as defined in
+	 *   TS 23.038 [5] with bit 8 set to 0. The string shall be left
+	 *   justified. Unused bytes shall be set to 'FF'.
+	 *
+	 * - or one of the UCS2 code options defined in the annex of TS
+	 *   31.101 [11].
+	 *
+	 * 31.101 has no such annex though.  51.101 refers to Annex B of
+	 * itself which is not there either.  11.11 contains the same
+	 * paragraph as 51.101 and has an Annex B which we implement.
+	 */
+	sim->spn =3D sim_string_to_utf8(data + 1, length - 1);
+	if (sim->spn =3D=3D NULL) {
+		ofono_error("EFspn read successfully, but couldn't parse");
+		goto finish;
+	}
+
+	if (strlen(sim->spn) =3D=3D 0) {
+		g_free(sim->spn);
+		sim->spn =3D NULL;
+	}
+
+finish:
+	sim_set_ready(sim);
+}
+
+
 static void sim_ready(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_sim *sim =3D user;
@@ -1313,7 +1358,10 @@ static void sim_imsi_cb(const struct ofono_error *er=
ror, const char *imsi,
 						DBUS_TYPE_STRING, &str);
 	}
 =

-	sim_set_ready(sim);
+	/* Try to get SPN before declaring SIM ready */
+	ofono_sim_read(sim, SIM_EFSPN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_spn_read_cb, sim);
 }
 =

 static void sim_retrieve_imsi(struct ofono_sim *sim)
@@ -2005,6 +2053,22 @@ const char *ofono_sim_get_mnc(struct ofono_sim *sim)
 	return sim->mnc;
 }
 =

+const char *ofono_sim_get_spn(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return NULL;
+
+	return sim->spn;
+}
+
+unsigned char ofono_sim_get_spn_dc(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return 0;
+
+	return sim->spn_dc;
+}
+
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
@@ -2071,6 +2135,13 @@ static void sim_free_state(struct ofono_sim *sim)
 	sim->mcc[0] =3D '\0';
 	sim->mnc[0] =3D '\0';
 =

+	if (sim->spn) {
+		g_free(sim->spn);
+		sim->spn =3D NULL;
+	}
+
+	sim->spn_dc =3D 0;
+
 	if (sim->own_numbers) {
 		g_slist_foreach(sim->own_numbers, (GFunc)g_free, NULL);
 		g_slist_free(sim->own_numbers);
-- =

1.7.1


--===============4294888437210137726==--

