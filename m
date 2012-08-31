Content-Type: multipart/mixed; boundary="===============2809096784844795014=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 2/3] smsutil: <CR> is not necessarily a CBS padding
 character
Date: Fri, 31 Aug 2012 17:03:57 +0200
Message-ID: <1346425438-12220-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346425438-12220-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2809096784844795014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index b4d129f..7569c63 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -4090,7 +4090,7 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 			unsigned char unpacked[CBS_MAX_GSM_CHARS];
 			long written;
 			int max_chars;
-			int i;
+			int i, j;
 =

 			max_chars =3D
 				sms_text_capacity_gsm(CBS_MAX_GSM_CHARS, taken);
@@ -4102,12 +4102,24 @@ char *cbs_decode_text(GSList *cbs_list, char *iso63=
9_lang)
 			i =3D iso639 ? 3 : 0;
 =

 			/*
-			 * CR is a padding character, which means we can
-			 * safely discard everything afterwards
+			 * CR can be used as a padding character, which means
+			 * we can safely discard everything afterwards
 			 */
+
 			for (; i < written; i++, bufsize++) {
-				if (unpacked[i] =3D=3D '\r')
-					break;
+				if (unpacked[i] =3D=3D '\r') {
+					/*
+					 * check if this is a padding character
+					 * or if it is a wanted <CR>
+					 */
+					for (j =3D i + 1; j < written; j++)
+						if (unpacked[j] !=3D '\r')
+							break;
+
+					if (j =3D=3D written)
+						break;
+				}
+
 =

 				buf[bufsize] =3D unpacked[i];
 			}
@@ -4135,8 +4147,18 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639=
_lang)
 			}
 =

 			while (i < max_offset) {
-				if (ud[i] =3D=3D 0x00 && ud[i+1] =3D=3D '\r')
-					break;
+				if (ud[i] =3D=3D 0x00 && ud[i+1] =3D=3D '\r') {
+					int j =3D i + 2;
+
+					for (; j < max_offset; j =3D j + 2)
+						if (ud[j] !=3D 0x00 ||
+								ud[j + 1] !=3D
+									'\r')
+							break;
+
+					if (j =3D=3D max_offset)
+						break;
+				}
 =

 				buf[bufsize] =3D ud[i];
 				buf[bufsize + 1] =3D ud[i + 1];
-- =

1.7.9.5


--===============2809096784844795014==--

