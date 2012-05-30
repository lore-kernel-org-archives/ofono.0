Content-Type: multipart/mixed; boundary="===============2225910947378056897=="
MIME-Version: 1.0
From: Jens Rehsack <jr_extern@vfnet.de>
Subject: [PATCH] Add WSP_VALUE_TYPE_TEXT support in wsp_decode_application_id()
Date: Wed, 30 May 2012 10:59:19 +0200
Message-ID: <1338368359-28724-1-git-send-email-jr_extern@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2225910947378056897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jens Rehsack <sno@NetBSD.org>

---
 src/wsputil.c |   24 ++++++++++++++++++++----
 1 Datei ge=C3=A4ndert, 20 Zeilen hinzugef=C3=BCgt(+), 4 Zeilen entfernt(-)

diff --git a/src/wsputil.c b/src/wsputil.c
index 1b2b2b7..ece58e6 100644
--- a/src/wsputil.c
+++ b/src/wsputil.c
@@ -490,13 +490,26 @@ gboolean wsp_decode_application_id(struct wsp_header_=
iter *iter,
 	unsigned int val_len;
 	unsigned int i;
 =

+	switch (wsp_header_iter_get_val_type(iter)) {
+	case WSP_VALUE_TYPE_TEXT:
+		if (out_value)
+			*out_value =3D pdu_val;
+
+		break;
+
 	/*
 	 * Well-known field values MUST be encoded using the
 	 * compact binary formats
 	 */
-	if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHORT) {
+	case WSP_VALUE_TYPE_SHORT:
 		val =3D *pdu_val & 0x7f;
-	} else {
+
+		if (out_value)
+			*out_value =3D get_text_entry(val, app_id);
+
+		break;
+
+	case WSP_VALUE_TYPE_LONG:
 		val_len =3D wsp_header_iter_get_val_len(iter);
 =

 		if (val_len > 2)
@@ -504,10 +517,13 @@ gboolean wsp_decode_application_id(struct wsp_header_=
iter *iter,
 =

 		for (i =3D 0, val =3D 0; i < val_len && i < sizeof(val); i++)
 			val =3D (val << 8) | pdu_val[i];
+
+		if (out_value)
+			*out_value =3D get_text_entry(val, app_id);
+
+		break;
 	}
 =

-	if (out_value)
-		*out_value =3D get_text_entry(val, app_id);
 =

 	return TRUE;
 }
-- =

1.7.10.1


--===============2225910947378056897==--

