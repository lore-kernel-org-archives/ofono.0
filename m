Content-Type: multipart/mixed; boundary="===============4286542948426258317=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/20] simutil: Fix MMC MNC encoding for 2-digit MNCs.
Date: Mon, 07 Jun 2010 12:08:33 +0200
Message-ID: <1275905322-14768-11-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4286542948426258317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 7291729..3315299 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -117,6 +117,8 @@ static struct sim_ef_info ef_db[] =3D {
 {	0x6FE3, 0x0000, BINARY, 18,	PIN,	PIN	},
 };
 =

+static inline int to_semi_oct(char in);
+
 void simple_tlv_iter_init(struct simple_tlv_iter *iter,
 				const unsigned char *pdu, unsigned int len)
 {
@@ -844,19 +846,14 @@ void sim_parse_mcc_mnc(const guint8 *bcd, char *mcc, =
char *mnc)
 =

 void sim_encode_mcc_mnc(guint8 *out, const char *mcc, const char *mnc)
 {
-	char str[7] =3D "ffffff";
-
-	str[0] =3D mcc[0];
-	str[1] =3D mcc[1];
-	if (mcc[2])
-		str[2] =3D mcc[2];
+	out[0] =3D to_semi_oct(mcc[0]);
+	out[0] |=3D to_semi_oct(mcc[1]) << 4;
 =

-	str[4] =3D mnc[0];
-	str[5] =3D mnc[1];
-	if (mnc[2])
-		str[3] =3D mnc[2];
+	out[1] =3D mcc[2] ? to_semi_oct(mcc[2]) : 0xf;
+	out[1] |=3D (mnc[2] ? to_semi_oct(mnc[2]) : 0xf) << 4;
 =

-	encode_bcd_number(str, out);
+	out[2] =3D to_semi_oct(mnc[0]);
+	out[2] |=3D to_semi_oct(mnc[1]) << 4;
 }
 =

 static gint spdi_operator_compare(gconstpointer a, gconstpointer b)
-- =

1.7.1.86.g0e460.dirty


--===============4286542948426258317==--

