Content-Type: multipart/mixed; boundary="===============8677293821588089861=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH] stkutil: Use sms_dcs_decode to retrieve the STK character set.
Date: Thu, 25 Nov 2010 16:15:04 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813547D20B@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8677293821588089861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

---
 src/stkutil.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 377ceff..78efbf0 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -77,9 +77,13 @@ struct gsm_sms_tpdu {
 static char *decode_text(unsigned char dcs, int len, const unsigned char *=
data)
 {
 	char *utf8;
+	enum sms_charset charset;
 =

-	switch (dcs) {
-	case 0x00:
+	if (!sms_dcs_decode(dcs, NULL, &charset, NULL, NULL))
+		return NULL;
+
+	switch (charset) {
+	case SMS_CHARSET_7BIT:
 	{
 		long written;
 		unsigned long max_to_unpack =3D len * 8 / 7;
@@ -94,10 +98,10 @@ static char *decode_text(unsigned char dcs, int len, co=
nst unsigned char *data)
 		g_free(unpacked);
 		break;
 	}
-	case 0x04:
+	case SMS_CHARSET_8BIT:
 		utf8 =3D convert_gsm_to_utf8(data, len, NULL, NULL, 0);
 		break;
-	case 0x08:
+	case SMS_CHARSET_UCS2:
 		utf8 =3D g_convert((const gchar *) data, len,
 					"UTF-8//TRANSLIT", "UCS-2BE",
 					NULL, NULL, NULL);
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


--===============8677293821588089861==--

