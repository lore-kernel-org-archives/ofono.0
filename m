Content-Type: multipart/mixed; boundary="===============1693927253605572654=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 1/2] smsutil: <CR> is not necessarily a padding character
 in CBS message
Date: Fri, 03 Aug 2012 15:00:31 +0200
Message-ID: <1343998832-8111-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1343998832-8111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1693927253605572654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe Nunes <philippe.nunes@linux.intel.com>

---
 src/smsutil.c |  142 +++++++++++++++++++++++++++++++++++++----------------=
---
 1 files changed, 94 insertions(+), 48 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index a541964..347c9d2 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3996,6 +3996,96 @@ gboolean iso639_2_from_language(enum cbs_language la=
ng, char *iso639)
 	return FALSE;
 }
 =

+static unsigned char *decode_7bits_sms_charset(int taken, int *bufsize,
+						unsigned char *buf,
+						const guint8 *ud,
+						gboolean iso639)
+{
+	unsigned char unpacked[CBS_MAX_GSM_CHARS];
+	long written;
+	int max_chars;
+	int i, j;
+	int buf_size =3D *bufsize;
+
+	max_chars =3D sms_text_capacity_gsm(CBS_MAX_GSM_CHARS, taken);
+
+	unpack_7bit_own_buf(ud + taken, 82 - taken, taken, FALSE, max_chars,
+				&written, 0, unpacked);
+
+	i =3D iso639 ? 3 : 0;
+
+	/*
+	 * CR can be used as a padding character, which means
+	 * we can safely discard everything afterwards
+	 */
+
+	for (; i < written; i++, buf_size++) {
+		if (unpacked[i] =3D=3D '\r') {
+			/*
+			 * check if this is a padding character
+			 * or if it is a wanted <CR>
+			 */
+			for (j =3D i + 1; j < written; j++)
+				if (unpacked[j] !=3D '\r')
+					break;
+
+			if (j =3D=3D written)
+				break;
+		}
+
+
+		buf[buf_size] =3D unpacked[i];
+	}
+
+	*bufsize =3D buf_size;
+
+	return buf;
+}
+
+static unsigned char *decode_default_sms_charset(int taken, int *bufsize,
+						unsigned char *buf,
+						const guint8 *ud,
+						gboolean iso639)
+{
+	int num_ucs2_chars =3D (82 - taken) >> 1;
+	int i =3D taken;
+	int max_offset =3D taken + num_ucs2_chars * 2;
+	int buf_size =3D *bufsize;
+
+	/*
+	 * It is completely unclear how UCS2 chars are handled
+	 * especially across pages or when the UDH is present.
+	 * For now do the best we can.
+	 */
+	if (iso639) {
+		i +=3D 2;
+		num_ucs2_chars -=3D 1;
+	}
+
+	while (i < max_offset) {
+		if (ud[i] =3D=3D 0x00 && ud[i+1] =3D=3D '\r') {
+			int j =3D i + 2;
+
+			for (; j < max_offset; j =3D j + 2)
+				if (ud[j] !=3D 0x00 || ud[j + 1] !=3D '\r')
+					break;
+
+			if (j =3D=3D max_offset)
+				break;
+		}
+
+		buf[buf_size] =3D ud[i];
+		buf[buf_size + 1] =3D ud[i+1];
+
+		buf_size +=3D 2;
+		i +=3D 2;
+	}
+
+	*bufsize =3D buf_size;
+
+	return buf;
+}
+
 char *cbs_decode_text(GSList *cbs_list, char *iso639_lang)
 {
 	GSList *l;
@@ -4087,30 +4177,8 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639=
_lang)
 			taken =3D sms_udh_iter_get_udh_length(&iter) + 1;
 =

 		if (charset =3D=3D SMS_CHARSET_7BIT) {
-			unsigned char unpacked[CBS_MAX_GSM_CHARS];
-			long written;
-			int max_chars;
-			int i;
-
-			max_chars =3D
-				sms_text_capacity_gsm(CBS_MAX_GSM_CHARS, taken);
-
-			unpack_7bit_own_buf(ud + taken, 82 - taken,
-						taken, FALSE, max_chars,
-						&written, 0, unpacked);
-
-			i =3D iso639 ? 3 : 0;
-
-			/*
-			 * CR is a padding character, which means we can
-			 * safely discard everything afterwards
-			 */
-			for (; i < written; i++, bufsize++) {
-				if (unpacked[i] =3D=3D '\r')
-					break;
-
-				buf[bufsize] =3D unpacked[i];
-			}
+			decode_7bits_sms_charset(taken, &bufsize, buf, ud,
+							iso639);
 =

 			/*
 			 * It isn't clear whether extension sequences
@@ -4120,30 +4188,8 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639=
_lang)
 			 * the check here since the specification isn't clear
 			 */
 		} else {
-			int num_ucs2_chars =3D (82 - taken) >> 1;
-			int i =3D taken;
-			int max_offset =3D taken + num_ucs2_chars * 2;
-
-			/*
-			 * It is completely unclear how UCS2 chars are handled
-			 * especially across pages or when the UDH is present.
-			 * For now do the best we can.
-			 */
-			if (iso639) {
-				i +=3D 2;
-				num_ucs2_chars -=3D 1;
-			}
-
-			while (i < max_offset) {
-				if (ud[i] =3D=3D 0x00 && ud[i+1] =3D=3D '\r')
-					break;
-
-				buf[bufsize] =3D ud[i];
-				buf[bufsize + 1] =3D ud[i+1];
-
-				bufsize +=3D 2;
-				i +=3D 2;
-			}
+			decode_default_sms_charset(taken, &bufsize, buf, ud,
+							iso639);
 		}
 	}
 =

-- =

1.7.5.4


--===============1693927253605572654==--

