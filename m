Content-Type: multipart/mixed; boundary="===============5626230207723404952=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH] sim: use mask for check of sim file status
Date: Fri, 05 Nov 2010 13:05:05 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188135388B53@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5626230207723404952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

Is' the first bit of the sim file status who indicates if a file
is valid or not. So a mask must be used to check this.
---
 src/sim.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 02ab329..2ee2b29 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1290,7 +1290,7 @@ static void sim_efbdn_info_read_cb(int ok, unsigned c=
har file_status,
 	if (!ok)
 		goto out;
 =

-	if (file_status =3D=3D SIM_FILE_STATUS_VALID)
+	if (file_status & SIM_FILE_STATUS_VALID)
 		sim_bdn_enabled(sim);
 =

 out:
@@ -1327,7 +1327,7 @@ static void sim_efadn_info_read_cb(int ok, unsigned c=
har file_status,
 	if (!ok)
 		goto out;
 =

-	if (file_status !=3D SIM_FILE_STATUS_VALID)
+	if (!(file_status & SIM_FILE_STATUS_VALID))
 		sim_fdn_enabled(sim);
 =

 out:
-- =

1.7.0.4
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============5626230207723404952==--

