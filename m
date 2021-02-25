Content-Type: multipart/mixed; boundary="===============7799900527382945043=="
MIME-Version: 1.0
From: Christopher Talbot <chris@talbothome.com>
Subject: [PATCH 4/9] Fix issue if there is an empty string in encoded text
Date: Wed, 24 Feb 2021 19:45:26 -0500
Message-ID: <799fae706773af11b74f9e11d1c8b264b7642a0a.camel@talbothome.com>
In-Reply-To: <20210225003933.2871.63570@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7799900527382945043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


A swedish carrier sends an empty string in the subject line. This
patch allows mmsd to handle it
---
 src/mmsutil.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/mmsutil.c b/src/mmsutil.c
index 9430bf1..615198f 100644
--- a/src/mmsutil.c
+++ b/src/mmsutil.c
@@ -297,6 +297,13 @@ static gboolean extract_encoded_text(struct
wsp_header_iter *iter, void *user)
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

--===============7799900527382945043==--

