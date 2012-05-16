Content-Type: multipart/mixed; boundary="===============8893045347821185162=="
MIME-Version: 1.0
From: Jens Rehsack <jr_extern@vfnet.de>
Subject: [PATCH] Add WSP_VALUE_TYPE_TEXT support in wsp_decode_application_id()
Date: Wed, 16 May 2012 16:03:25 +0200
Message-ID: <1337177005-7385-1-git-send-email-jr_extern@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8893045347821185162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jens Rehsack <sno@NetBSD.org>

---
 src/wsputil.c |    6 ++++++
 1 Datei ge=C3=A4ndert, 6 Zeilen hinzugef=C3=BCgt(+)

diff --git a/src/wsputil.c b/src/wsputil.c
index 1b2b2b7..c4c9d62 100644
--- a/src/wsputil.c
+++ b/src/wsputil.c
@@ -496,6 +496,12 @@ gboolean wsp_decode_application_id(struct wsp_header_i=
ter *iter,
 	 */
 	if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHORT) {
 		val =3D *pdu_val & 0x7f;
+	} else if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_TEXT)=
 {
+		val_len =3D wsp_header_iter_get_val_len(iter);
+		val =3D -1;
+
+		if (out_value)
+			*out_value =3D pdu_val;
 	} else {
 		val_len =3D wsp_header_iter_get_val_len(iter);
 =

-- =

1.7.10.1


--===============8893045347821185162==--

