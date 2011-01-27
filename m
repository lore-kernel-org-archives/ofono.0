Content-Type: multipart/mixed; boundary="===============5675783639046832248=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 3/3] netreg: use ofono_sim_get_spn()
Date: Thu, 27 Jan 2011 15:22:17 +0200
Message-ID: <1296134537-16133-4-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1296134537-16133-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5675783639046832248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   46 +++++++---------------------------------------
 1 files changed, 7 insertions(+), 39 deletions(-)

diff --git a/src/network.c b/src/network.c
index b5450ee..f602db4 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1507,51 +1507,21 @@ static void sim_spdi_read_cb(int ok, int length, in=
t record,
 	}
 }
 =

-static void sim_spn_read_cb(int ok, int length, int record,
-				const unsigned char *data,
-				int record_length, void *user_data)
+static void get_spn(struct ofono_netreg *netreg)
 {
-	struct ofono_netreg *netreg =3D user_data;
 	unsigned char dcbyte;
-	char *spn;
-
-	if (!ok)
-		return;
-
-	dcbyte =3D data[0];
+	const char *spn =3D ofono_sim_get_spn(netreg->sim);
 =

-	/*
-	 * TS 31.102 says:
-	 *
-	 * the string shall use:
-	 *
-	 * - either the SMS default 7-bit coded alphabet as defined in
-	 *   TS 23.038 [5] with bit 8 set to 0. The string shall be left
-	 *   justified. Unused bytes shall be set to 'FF'.
-	 *
-	 * - or one of the UCS2 code options defined in the annex of TS
-	 *   31.101 [11].
-	 *
-	 * 31.101 has no such annex though.  51.101 refers to Annex B of
-	 * itself which is not there either.  11.11 contains the same
-	 * paragraph as 51.101 and has an Annex B which we implement.
-	 */
-	spn =3D sim_string_to_utf8(data + 1, length - 1);
-	if (spn =3D=3D NULL) {
-		ofono_error("EFspn read successfully, but couldn't parse");
+	if (spn =3D=3D NULL)
 		return;
-	}
 =

-	if (strlen(spn) =3D=3D 0) {
-		g_free(spn);
-		return;
-	}
-
-	netreg->spname =3D spn;
+	netreg->spname =3D g_strdup(spn);
 	ofono_sim_read(netreg->sim, SIM_EFSPDI_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_spdi_read_cb, netreg);
 =

+	dcbyte =3D ofono_sim_get_spn_dc(netreg->sim);
+
 	if (dcbyte & SIM_EFSPN_DC_HOME_PLMN_BIT)
 		netreg->flags |=3D NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN;
 =

@@ -1816,9 +1786,7 @@ void ofono_netreg_register(struct ofono_netreg *netre=
g)
 		ofono_sim_read(netreg->sim, SIM_EFPNN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				sim_pnn_read_cb, netreg);
-		ofono_sim_read(netreg->sim, SIM_EFSPN_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-				sim_spn_read_cb, netreg);
+		get_spn(netreg);
 	}
 =

 	__ofono_atom_register(netreg->atom, netreg_unregister);
-- =

1.7.1


--===============5675783639046832248==--

