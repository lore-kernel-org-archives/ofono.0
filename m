Content-Type: multipart/mixed; boundary="===============2144453634069170098=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] sim: fix issue in triggering EFest read
Date: Mon, 29 Nov 2010 06:50:47 -0800
Message-ID: <1291042247-27477-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2144453634069170098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index e5e304c..5a84833 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1445,7 +1445,11 @@ static void sim_efust_read_cb(int ok, int length, in=
t record,
 	 * must be present if EFfdn or EFbdn are present
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


--===============2144453634069170098==--

