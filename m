Content-Type: multipart/mixed; boundary="===============2320691052585746374=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] sim: fix issue in triggering EFest read
Date: Mon, 29 Nov 2010 08:57:39 -0800
Message-ID: <1291049859-28702-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1291042247-27477-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2320691052585746374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index e5e304c..30a6ac2 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1441,11 +1441,18 @@ static void sim_efust_read_cb(int ok, int length, i=
nt record,
 =

 	/*
 	 * Check whether the SIM provides EFest file
-	 * According to 31.102, section 4.2.24 and 4.2.44 the EFest file
-	 * must be present if EFfdn or EFbdn are present
+	 * According to 3GPP TS 31.102 section 4.2.47, EFest file
+	 * shall be present if FDN or BDN or EST is available
+	 * Lets be paranoid and check for the special cases as well
+	 * where EST is not available(FDN or BDN available), but EFest
+	 * is present
 	 */
 	if (sim_ust_is_available(sim->efust, sim->efust_length,
-				SIM_UST_SERVICE_ENABLED_SERVICE_TABLE)) {
+				SIM_UST_SERVICE_ENABLED_SERVICE_TABLE) ||
+			sim_ust_is_available(sim->efust, sim->efust_length,
+				SIM_UST_SERVICE_FDN) ||
+			sim_ust_is_available(sim->efust, sim->efust_length,
+				SIM_UST_SERVICE_BDN)) {
 		ofono_sim_read(sim, SIM_EFEST_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_efest_read_cb, sim);
-- =

1.7.0.4


--===============2320691052585746374==--

