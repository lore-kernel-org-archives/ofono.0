Content-Type: multipart/mixed; boundary="===============6336272961611614560=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 8/9] network: Add CPHS short-SPN fallback
Date: Fri, 02 Dec 2011 13:10:36 +0200
Message-ID: <1322824237-10039-9-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322824237-10039-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6336272961611614560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/src/network.c b/src/network.c
index 1354edf..cfda2d8 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1723,7 +1723,8 @@ static void sim_spn_read_cb(int ok, int length, int r=
ecord,
 	int offset =3D 0;
 =

 	if (!ok) {
-		if (!(netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN)) {
+		if (!(netreg->flags & (NETWORK_REGISTRATION_FLAG_CPHS_SPN |
+				NETWORK_REGISTRATION_FLAG_CPHS_SPN_SHORT))) {
 =

 			netreg->flags |=3D NETWORK_REGISTRATION_FLAG_CPHS_SPN;
 =

@@ -1731,11 +1732,32 @@ static void sim_spn_read_cb(int ok, int length, int=
 record,
 					SIM_EF_CPHS_SPN_FILEID,
 					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 					sim_spn_read_cb, netreg);
+			return;
 		}
+
+		if (netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN) {
+
+			netreg->flags |=3D NETWORK_REGISTRATION_FLAG_CPHS_SPN;
+			netreg->flags |=3D
+				NETWORK_REGISTRATION_FLAG_CPHS_SPN_SHORT;
+
+			ofono_sim_read(netreg->sim_context,
+					SIM_EF_CPHS_SPN_SHORT_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					sim_spn_read_cb, netreg);
+			return;
+
+		}
+
+		if (netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN_SHORT)
+			netreg->flags |=3D
+				NETWORK_REGISTRATION_FLAG_CPHS_SPN_SHORT;
+
 		return;
 	}
 =

-	if (!(netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN)) {
+	if (!(netreg->flags & (NETWORK_REGISTRATION_FLAG_CPHS_SPN |
+			NETWORK_REGISTRATION_FLAG_CPHS_SPN_SHORT))) {
 		dcbyte =3D data;
 		offset =3D 1;
 	}
@@ -1743,7 +1765,8 @@ static void sim_spn_read_cb(int ok, int length, int r=
ecord,
 	if (!sim_spn_parse(data + offset, length - offset, &netreg->spn))
 		return;
 =

-	if (!(netreg->flags & NETWORK_REGISTRATION_FLAG_CPHS_SPN))
+	if (!(netreg->flags & (NETWORK_REGISTRATION_FLAG_CPHS_SPN |
+			NETWORK_REGISTRATION_FLAG_CPHS_SPN_SHORT)))
 		ofono_sim_read(netreg->sim_context, SIM_EFSPDI_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_spdi_read_cb, netreg);
-- =

1.7.5.4


--===============6336272961611614560==--

