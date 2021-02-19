Content-Type: multipart/mixed; boundary="===============2351410588126391241=="
MIME-Version: 1.0
From: ofono@market.talbothome.com
Subject: [PATCH 05/09] MMSD: Fix issue if there is an empty string in encoded
 text
Date: Fri, 19 Feb 2021 01:02:13 +0000
Message-ID: <20210219010213.2937.39094@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2351410588126391241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some carriers encode a subject with an enpty string. =

This patch enables MMSD to handle the empty string.

---
 src/mmsutil.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/mmsutil.c b/src/mmsutil.c
index ef72f20..78c05d6 100644
--- a/src/mmsutil.c
+++ b/src/mmsutil.c
@@ -297,6 +297,13 @@ static gboolean extract_encoded_text(struct wsp_header=
_iter *iter, void *user)
 	p =3D wsp_header_iter_get_val(iter);
 	l =3D wsp_header_iter_get_val_len(iter);
 =

+	if(l =3D=3D 0) {
+		DBG("Length is 0! Returning empty string");
+		dec_text =3D g_strdup("");
+		*out =3D dec_text;
+		return TRUE;
+	}
+
 	switch (wsp_header_iter_get_val_type(iter)) {
 	case WSP_VALUE_TYPE_TEXT:
 		/* Text-string */
-- =

2.30.0
--===============2351410588126391241==--

