Content-Type: multipart/mixed; boundary="===============7725558282540518545=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] cbs: Allow the last CBS fragment to be truncated
Date: Wed, 17 Jun 2020 01:31:06 +0300
Message-ID: <1592346666-27113-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7725558282540518545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

That does happen in real life.
---
 src/smsutil.c | 23 +++++++++++++++--------
 src/smsutil.h |  1 +
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 8c084d4..450a1d3 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -1756,7 +1756,7 @@ gboolean sms_udh_iter_init_from_cbs(const struct cbs =
*cbs,
 		return FALSE;
 =

 	hdr =3D cbs->ud;
-	max_ud_len =3D 82;
+	max_ud_len =3D cbs->udlen;
 =

 	/* Must have at least one information-element if udhi is true */
 	if (hdr[0] < 2)
@@ -3862,8 +3862,8 @@ gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, e=
num sms_class *cls,
 =

 gboolean cbs_decode(const unsigned char *pdu, int len, struct cbs *out)
 {
-	/* CBS is always a fixed length of 88 bytes */
-	if (len !=3D 88)
+	/* CBS is (almost) always a fixed length of 88 bytes */
+	if (len < 6 || len > 88)
 		return FALSE;
 =

 	out->gs =3D (enum cbs_geo_scope) ((pdu[0] >> 6) & 0x03);
@@ -3874,6 +3874,10 @@ gboolean cbs_decode(const unsigned char *pdu, int le=
n, struct cbs *out)
 	out->max_pages =3D pdu[5] & 0xf;
 	out->page =3D (pdu[5] >> 4) & 0xf;
 =

+	/* Allow the last fragment to be truncated */
+	if (len !=3D 88 && out->max_pages !=3D out->page)
+		return FALSE;
+
 	/*
 	 * If a mobile receives the code 0000 in either the first field or
 	 * the second field then it shall treat the CBS message exactly the
@@ -3885,7 +3889,10 @@ gboolean cbs_decode(const unsigned char *pdu, int le=
n, struct cbs *out)
 		out->page =3D 1;
 	}
 =

-	memcpy(out->ud, pdu + 6, 82);
+	out->udlen =3D (guint8)(len - 6);
+	memcpy(out->ud, pdu + 6, out->udlen);
+	if (out->udlen < 82)
+		memset(out->ud + out->udlen, 0, 82 - out->udlen);
 =

 	return TRUE;
 }
@@ -4078,7 +4085,7 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 			if (iso639)
 				bufsize -=3D 3;
 		} else {
-			bufsize +=3D 82;
+			bufsize +=3D cbs->udlen;
 =

 			if (iso639)
 				bufsize -=3D 2;
@@ -4095,7 +4102,7 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 			if (sms_udh_iter_init_from_cbs(cbs, &iter))
 				taken =3D sms_udh_iter_get_udh_length(&iter) + 1;
 =

-			unpack_7bit_own_buf(cbs->ud + taken, 82 - taken,
+			unpack_7bit_own_buf(cbs->ud + taken, cbs->udlen - taken,
 						taken, false, 2,
 						NULL, 0,
 						(unsigned char *)iso639_lang);
@@ -4128,7 +4135,7 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 			max_chars =3D
 				sms_text_capacity_gsm(CBS_MAX_GSM_CHARS, taken);
 =

-			unpack_7bit_own_buf(ud + taken, 82 - taken,
+			unpack_7bit_own_buf(ud + taken, cbs->udlen - taken,
 						taken, false, max_chars,
 						&written, 0, unpacked);
 =

@@ -4162,7 +4169,7 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 			 * the check here since the specification isn't clear
 			 */
 		} else {
-			int num_ucs2_chars =3D (82 - taken) >> 1;
+			int num_ucs2_chars =3D (cbs->udlen - taken) >> 1;
 			int i =3D taken;
 			int max_offset =3D taken + num_ucs2_chars * 2;
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index 0adba51..01487de 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -408,6 +408,7 @@ struct cbs {
 	guint8 dcs;				/* 8 bits */
 	guint8 max_pages;			/* 4 bits */
 	guint8 page;				/* 4 bits */
+	guint8 udlen;
 	guint8 ud[82];
 };
 =

-- =

1.9.1

--===============7725558282540518545==--

