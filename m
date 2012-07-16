Content-Type: multipart/mixed; boundary="===============0025649044986416878=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] util: Fix GSM to UTF8 conversion mechanism
Date: Mon, 16 Jul 2012 16:34:38 +0200
Message-ID: <1342449278-26294-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0025649044986416878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/util.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/util.c b/src/util.c
index aecc790..41ef3d4 100644
--- a/src/util.c
+++ b/src/util.c
@@ -628,8 +628,16 @@ char *convert_gsm_to_utf8_with_lang(const unsigned cha=
r *text, long len,
 =

 			c =3D gsm_single_shift_lookup(&t, text[i]);
 =

+			/*
+			 * According to the 3GPP specifications 23.038
+			 * section 6.2.1.1:
+			 * In the case there is no character in the extension
+			 * table, the character of the main default alphabet
+			 * table or the character from the National Language
+			 * Locking Shift Table should be displayed.
+			 */
 			if (c =3D=3D GUND)
-				goto error;
+				c =3D gsm_locking_shift_lookup(&t, text[i]);
 		} else {
 			c =3D gsm_locking_shift_lookup(&t, text[i]);
 		}
@@ -647,9 +655,12 @@ char *convert_gsm_to_utf8_with_lang(const unsigned cha=
r *text, long len,
 	while (out < res + res_length) {
 		unsigned short c;
 =

-		if (text[i] =3D=3D 0x1b)
+		if (text[i] =3D=3D 0x1b) {
 			c =3D gsm_single_shift_lookup(&t, text[++i]);
-		else
+			/* See 3GPP 23.038 section 6.2.1.1 */
+			if (c =3D=3D GUND)
+				c =3D gsm_locking_shift_lookup(&t, text[i]);
+		} else
 			c =3D gsm_locking_shift_lookup(&t, text[i]);
 =

 		out +=3D g_unichar_to_utf8(c, out);
-- =

1.7.5.4


--===============0025649044986416878==--

