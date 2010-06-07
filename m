Content-Type: multipart/mixed; boundary="===============4092719449966949047=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/20] Add a "sim string" encoding utility.
Date: Mon, 07 Jun 2010 12:08:32 +0200
Message-ID: <1275905322-14768-10-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4092719449966949047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |   25 ++++++++++---------------
 src/util.c    |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/util.h    |    3 +++
 3 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index f980bf6..7291729 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1232,29 +1232,24 @@ void sim_adn_build(unsigned char *data, int length,
 			const char *identifier)
 {
 	int number_len =3D strlen(ph->number);
-	unsigned char *gsm_identifier =3D NULL;
-	long gsm_bytes;
-	long alpha_length;
+	unsigned char *alpha =3D NULL;
+	int alpha_written =3D 0;
+	int alpha_length;
 =

 	alpha_length =3D length - 14;
 =

 	/* Alpha-Identifier field */
 	if (alpha_length > 0) {
-		memset(data, 0xff, alpha_length);
-
 		if (identifier)
-			gsm_identifier =3D convert_utf8_to_gsm(identifier,
-					-1, NULL, &gsm_bytes, 0);
-
-		if (gsm_identifier) {
-			memcpy(data, gsm_identifier,
-				MIN(gsm_bytes, alpha_length));
-			g_free(gsm_identifier);
+			alpha =3D utf8_to_sim_string(identifier, alpha_length,
+							&alpha_written);
+		if (alpha) {
+			memcpy(data, alpha, alpha_written);
+			g_free(alpha);
 		}
 =

-		/* TODO: figure out when the identifier needs to
-		 * be encoded in UCS2 and do this.
-		 */
+		memset(data + alpha_written, 0xff,
+				alpha_length - alpha_written);
 		data +=3D alpha_length;
 	}
 =

diff --git a/src/util.c b/src/util.c
index e5ce7b3..fd8b305 100644
--- a/src/util.c
+++ b/src/util.c
@@ -1215,3 +1215,49 @@ char *sim_string_to_utf8(const unsigned char *buffer=
, int length)
 =

 	return utf8;
 }
+
+unsigned char *utf8_to_sim_string(const char *utf,
+					int max_length, int *out_length)
+{
+	unsigned char *result;
+	unsigned char *ucs2;
+	long gsm_bytes;
+	gsize converted;
+
+	result =3D convert_utf8_to_gsm(utf, -1, NULL, &gsm_bytes, 0);
+	if (result) {
+		if (gsm_bytes > max_length) {
+			gsm_bytes =3D max_length;
+			while (gsm_bytes && result[gsm_bytes - 1] =3D=3D 0x1b)
+				gsm_bytes -=3D 1;
+		}
+
+		*out_length =3D gsm_bytes;
+		return result;
+	}
+
+	/* NOTE: UCS2 formats with an offset are never used */
+
+	ucs2 =3D (guint8 *) g_convert(utf, -1, "UCS-2BE//TRANSLIT", "UTF-8",
+					NULL, &converted, NULL);
+
+	if (!ucs2)
+		return NULL;
+
+	if (max_length !=3D -1 && (int) converted + 1 > max_length)
+		converted =3D (max_length - 1) & ~1;
+
+	result =3D g_try_malloc(converted + 1);
+	if (!result) {
+		g_free(ucs2);
+		return NULL;
+	}
+
+	*out_length =3D converted + 1;
+
+	result[0] =3D 0x80;
+	memcpy(&result[1], ucs2, converted);
+	g_free(ucs2);
+
+	return result;
+}
diff --git a/src/util.h b/src/util.h
index 2835b76..9da81aa 100644
--- a/src/util.h
+++ b/src/util.h
@@ -77,3 +77,6 @@ unsigned char *pack_7bit(const unsigned char *in, long le=
n, int byte_offset,
 				long *items_written, unsigned char terminator);
 =

 char *sim_string_to_utf8(const unsigned char *buffer, int length);
+
+unsigned char *utf8_to_sim_string(const char *utf,
+					int max_length, int *out_length);
-- =

1.7.1.86.g0e460.dirty


--===============4092719449966949047==--

