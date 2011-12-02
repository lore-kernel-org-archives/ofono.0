Content-Type: multipart/mixed; boundary="===============2274059487364414106=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 7/9] network: Add CPHS SPN fallback
Date: Fri, 02 Dec 2011 13:10:35 +0200
Message-ID: <1322824237-10039-8-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322824237-10039-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2274059487364414106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/src/network.c b/src/network.c
index 6e08876..1354edf 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1719,21 +1719,37 @@ static void sim_spn_read_cb(int ok, int length, int=
 record,
 				int record_length, void *user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	unsigned char dcbyte;
+	const unsigned char *dcbyte =3D NULL;
+	int offset =3D 0;
 =

-	if (!ok)
+	if (!ok) {
+		if (!(netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN)) {
+
+			netreg->flags |=3D NETWORK_REGISTRATION_FLAG_CPHS_SPN;
+
+			ofono_sim_read(netreg->sim_context,
+					SIM_EF_CPHS_SPN_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					sim_spn_read_cb, netreg);
+		}
 		return;
+	}
 =

-	dcbyte =3D data[0];
+	if (!(netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN)) {
+		dcbyte =3D data;
+		offset =3D 1;
+	}
 =

-	if (!sim_spn_parse(data + 1, length - 1, &netreg->spn))
+	if (!sim_spn_parse(data + offset, length - offset, &netreg->spn))
 		return;
 =

-	ofono_sim_read(netreg->sim_context, SIM_EFSPDI_FILEID,
-			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-			sim_spdi_read_cb, netreg);
+	if (!(netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN))
+		ofono_sim_read(netreg->sim_context, SIM_EFSPDI_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				sim_spdi_read_cb, netreg);
 =

-	sim_spn_display_condition_parse(netreg, dcbyte);
+	if (dcbyte !=3D NULL)
+		sim_spn_display_condition_parse(netreg, *dcbyte);
 =

 	if (netreg->current_operator)
 		ofono_netreg_operator_display_name_notify(netreg);
-- =

1.7.5.4


--===============2274059487364414106==--

