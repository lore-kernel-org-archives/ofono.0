Content-Type: multipart/mixed; boundary="===============8204688965548322634=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] Fix CTLV three-byte tag parsing.
Date: Thu, 22 Apr 2010 10:11:16 +0200
Message-ID: <1271923876-3320-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8204688965548322634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 9fb111f..822938c 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -210,7 +210,7 @@ void comprehension_tlv_iter_init(struct comprehension_t=
lv_iter *iter,
 	iter->data =3D 0;
 }
 =

-/* Comprehension TLVs defined in Section 7 of ETSI TS 102.220 */
+/* Comprehension TLVs defined in Section 7 of ETSI TS 101.220 */
 gboolean comprehension_tlv_iter_next(struct comprehension_tlv_iter *iter)
 {
 	const unsigned char *pdu =3D iter->pdu + iter->pos;
@@ -230,18 +230,18 @@ gboolean comprehension_tlv_iter_next(struct comprehen=
sion_tlv_iter *iter)
 		return FALSE;
 =

 	/*
-	 * ETSI TS 102.220, Section 7.1.1.2
+	 * ETSI TS 101.220, Section 7.1.1.2
 	 * =

 	 * If byte 1 of the tag is equal to 0x7F, then the tag is encoded
-	 * on the following two bytes, with bit 8 of the 2nd byte of the tag
-	 * being the CR flag.
+	 * on the following two bytes, with bit 8 of the 1st byte of the tag
+	 * as the most significant bit.
 	 */
-	if (tag =3D=3D 0x7F) {
+	if (tag =3D=3D 0x7F && !cr) {
 		if ((pdu + 2) > end)
 			return FALSE;
 =

 		cr =3D bit_field(pdu[0], 7, 1);
-		tag =3D ((pdu[0] & 0x7f) << 7) | pdu[1];
+		tag =3D ((pdu[0] & 0x7f) << 8) | pdu[1];
 =

 		if (tag < 0x0001 || tag > 0x7fff)
 			return FALSE;
-- =

1.6.1


--===============8204688965548322634==--

