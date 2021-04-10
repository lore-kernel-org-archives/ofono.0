Content-Type: multipart/mixed; boundary="===============3137830742114301524=="
MIME-Version: 1.0
From: Chris Talbot <chris@talbothome.com>
Subject: [PATCH 4/9] Fix issue if there is an empty string in encoded text
Date: Sat, 10 Apr 2021 10:21:21 -0400
Message-ID: <eee886683aa0cbf57ec3f0c8637ba02bc01600d6.camel@talbothome.com>
In-Reply-To: <178dd29027e6abb4a205e25c02f06769848cbb76.camel@talbothome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3137830742114301524==
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

2.30.2

--===============3137830742114301524==--

