Content-Type: multipart/mixed; boundary="===============5167882805536781437=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] sim: fix num_params in ril_query_facility_lock_cb
Date: Sat, 06 Aug 2016 10:03:59 +0530
Message-ID: <1470458039-11171-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5167882805536781437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/sim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index 74f9d6b..b34723f 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -1424,12 +1424,17 @@ static void ril_query_facility_lock_cb(struct ril_m=
sg *message,
 	struct sim_data *sd =3D cbd->user;
 	struct parcel rilp;
 	ofono_bool_t status;
+	int numparams;
 =

 	if (message->error !=3D RIL_E_SUCCESS)
 		goto error;
 =

 	g_ril_init_parcel(message, &rilp);
 =

+	numparams =3D parcel_r_int32(&rilp);
+	if (numparams < 1)
+		goto error;
+
 	status =3D (ofono_bool_t) parcel_r_int32(&rilp);
 =

 	g_ril_append_print_buf(sd->ril, "{%d}", status);
-- =

1.9.1


--===============5167882805536781437==--

