Content-Type: multipart/mixed; boundary="===============0679306187445637818=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] atutil: put CME ERROR 10 in CPIN polling.
Date: Thu, 04 Aug 2011 18:06:32 +0200
Message-ID: <1312473992-6066-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0679306187445637818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some modem also return CME ERROR 10 during boot, until SIM is ready.

ofonod[5073]: Modem: > ATE0 +CMEE=3D1\r
ofonod[5073]: Aux: > ATE0 +CMEE=3D1\r
ofonod[5073]: Aux: < \r\nOK\r\n
ofonod[5073]: Aux: > AT+CFUN=3D1\r
ofonod[5073]: Modem: < \r\nOK\r\n
ofonod[5073]: Aux: < \r\nUSAT_OP_FINISH\r\n\r\n+STRSP:0x14\r\n\r\nOK\r\n
ofonod[5073]: plugins/speedup.c:cfun_enable()
ofonod[5073]: Aux: > AT+CPIN?\r
ofonod[5073]: Aux: < \r\n+CME ERROR: 10\r\n
ofonod[5073]: Aux: > AT+CPIN?\r
ofonod[5073]: Aux: < \r\n+CPIN: READY\r\n\r\nOK\r\n
---
 drivers/atmodem/atutil.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 63b1301..34e2d3e 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -527,11 +527,11 @@ static void cpin_check_cb(gboolean ok, GAtResult *res=
ult, gpointer userdata)
 		goto done;
 =

 	switch (error.error) {
-	case 10:
-	case 13:
+	case 13: /* SIM failure */
 		goto done;
 =

-	case 14:
+	case 10: /* SIM not inserted */
+	case 14: /* SIM Busy */
 		goto tryagain;
 =

 	default:
-- =

1.7.4.1

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

--===============0679306187445637818==--

