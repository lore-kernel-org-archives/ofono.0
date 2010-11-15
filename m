Content-Type: multipart/mixed; boundary="===============3487050488069916622=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH] stkutil: mask the DCS value to keep only the intersting bits
Date: Mon, 15 Nov 2010 14:17:01 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D401881353DCF1D@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3487050488069916622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

For SIM tool kit only the bits 2 and 3 are interesting
for the DCS value. The others ones sould be masked. The
masking is necessary because some SIM car set the
upper bits to 1.
---
 src/stkutil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index cdd66bd..a54dd02 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -78,7 +78,7 @@ static char *decode_text(unsigned char dcs, int len, cons=
t unsigned char *data)
 {
 	char *utf8;
 =

-	switch (dcs) {
+	switch (dcs & 0x06) {
 	case 0x00:
 	{
 		long written;
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


--===============3487050488069916622==--

