Content-Type: multipart/mixed; boundary="===============0176584607949288707=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] CBMs are always fixed size, so improve PDU length check
Date: Wed, 16 Mar 2011 10:12:46 +0100
Message-ID: <1300266766-14064-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0176584607949288707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/cbs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index 8cc3ef0..e2e1ca4 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -68,8 +68,8 @@ static void at_cbm_notify(GAtResult *result, gpointer use=
r_data)
 	if (!g_at_result_iter_next_number(&iter, &pdulen))
 		return;
 =

-	if (pdulen > 88) {
-		ofono_error("Got a CBM message bigger than maximum size!");
+	if (pdulen !=3D 88) {
+		ofono_error("Got a CBM message with invalid PDU size!");
 		return;
 	}
 =

-- =

1.7.1

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

--===============0176584607949288707==--

