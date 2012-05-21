Content-Type: multipart/mixed; boundary="===============0575905549068058201=="
MIME-Version: 1.0
From: Jens Rehsack <jr_extern@vfnet.de>
Subject: [PATCH] Add WSP_VALUE_TYPE_TEXT support in wsp_decode_application_id()
Date: Mon, 21 May 2012 12:54:14 +0200
Message-ID: <1337597654-26049-1-git-send-email-jr_extern@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0575905549068058201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jens Rehsack <sno@NetBSD.org>

---
 src/wsputil.c |   43 ++++++++++++++++++++++++++-----------------
 1 Datei ge=C3=A4ndert, 26 Zeilen hinzugef=C3=BCgt(+), 17 Zeilen entfernt(-)

diff --git a/src/wsputil.c b/src/wsputil.c
index 1b2b2b7..5611ed2 100644
--- a/src/wsputil.c
+++ b/src/wsputil.c
@@ -486,28 +486,37 @@ gboolean wsp_decode_application_id(struct wsp_header_=
iter *iter,
 							const void **out_value)
 {
 	const unsigned char *pdu_val =3D wsp_header_iter_get_val(iter);
-	unsigned int val;
-	unsigned int val_len;
-	unsigned int i;
 =

-	/*
-	 * Well-known field values MUST be encoded using the
-	 * compact binary formats
-	 */
-	if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHORT) {
-		val =3D *pdu_val & 0x7f;
+	if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_TEXT) {
+		wsp_header_iter_get_val_len(iter);
+
+		if (out_value)
+			*out_value =3D pdu_val;
 	} else {
-		val_len =3D wsp_header_iter_get_val_len(iter);
+		unsigned int val;
 =

-		if (val_len > 2)
-			return FALSE;
+		/*
+		 * Well-known field values MUST be encoded using the
+		 * compact binary formats
+		 */
+		if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHORT) {
+			val =3D *pdu_val & 0x7f;
+		} else  {
+			unsigned int val_len;
+			unsigned int i;
 =

-		for (i =3D 0, val =3D 0; i < val_len && i < sizeof(val); i++)
-			val =3D (val << 8) | pdu_val[i];
-	}
+			val_len =3D wsp_header_iter_get_val_len(iter);
 =

-	if (out_value)
-		*out_value =3D get_text_entry(val, app_id);
+			if (val_len > 2)
+				return FALSE;
+
+			for (i =3D 0, val =3D 0; i < val_len && i < sizeof(val); i++)
+				val =3D (val << 8) | pdu_val[i];
+		}
+
+		if (out_value)
+			*out_value =3D get_text_entry(val, app_id);
+	}
 =

 	return TRUE;
 }
-- =

1.7.10.1


--===============0575905549068058201==--

