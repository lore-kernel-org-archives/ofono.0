Content-Type: multipart/mixed; boundary="===============0437812650873105807=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] sim: fix cbd initialization in ril_query_facility_lock
Date: Sat, 06 Aug 2016 10:07:17 +0530
Message-ID: <1470458237-11263-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0437812650873105807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index b34723f..4509693 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -1453,7 +1453,7 @@ static void ril_query_facility_lock(struct ofono_sim =
*sim,
 					void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd =3D cb_data_new(cb, data, sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sd);
 	struct parcel rilp;
 =

 	parcel_init(&rilp);
-- =

1.9.1


--===============0437812650873105807==--

