Content-Type: multipart/mixed; boundary="===============6674248854524145143=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/8] util: Add UCS2 to GSM 7bit converion function
Date: Mon, 13 Sep 2010 16:00:11 -0700
Message-ID: <1284418817-28575-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284418817-28575-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6674248854524145143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/util.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/util.h |   10 +++++
 2 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/src/util.c b/src/util.c
index bb90f6c..b2a9321 100644
--- a/src/util.c
+++ b/src/util.c
@@ -1261,3 +1261,111 @@ unsigned char *utf8_to_sim_string(const char *utf,
 =

 	return result;
 }
+
+/*!
+ * Converts UCS2 encoded text to GSM alphabet. The result is unpacked,
+ * with the 7th bit always 0. If terminator is not 0, a terminator charact=
er
+ * is appended to the result.
+ *
+ * Returns the encoded data or NULL if the data could not be encoded. The
+ * data must be freed by the caller. If items_read is not NULL, it contains
+ * the actual number of bytes read. If items_written is not NULL, contains
+ * the number of bytes written.
+ */
+unsigned char *convert_ucs2_to_gsm_with_lang(const unsigned char *text,
+					long len, long *items_read,
+					long *items_written,
+					unsigned char terminator,
+					enum gsm_dialect locking_lang,
+					enum gsm_dialect single_lang)
+{
+	long nchars =3D 0;
+	const unsigned char *in;
+	unsigned char *out;
+	unsigned char *res =3D NULL;
+	long res_len;
+	long i;
+
+	if (locking_lang >=3D GSM_DIALECT_INVALID)
+		return NULL;
+
+	if (single_lang >=3D GSM_DIALECT_INVALID)
+		return NULL;
+
+	if (len < 1 || len % 2)
+		return NULL;
+
+	in =3D text;
+	res_len =3D 0;
+
+	for (i =3D 0; i < len; i+=3D2) {
+		gunichar c =3D (in[i] << 8) | in[i+1];
+		unsigned short converted =3D GUND;
+
+		if (c > 0xffff)
+			goto err_out;
+
+		converted =3D unicode_locking_shift_lookup(c, locking_lang);
+
+		if (converted =3D=3D GUND)
+			converted =3D unicode_single_shift_lookup(c, single_lang);
+
+		if (converted =3D=3D GUND)
+			goto err_out;
+
+		if (converted & 0x1b00)
+			res_len +=3D 2;
+		else
+			res_len +=3D 1;
+
+		nchars +=3D 1;
+	}
+
+	res =3D g_try_malloc(res_len + (terminator ? 1 : 0));
+	if (!res)
+		goto err_out;
+
+	in =3D text;
+	out =3D res;
+
+	for (i =3D 0; i < len; i+=3D2) {
+		gunichar c =3D (in[i] << 8) | in[i+1];
+		unsigned short converted =3D GUND;
+
+		converted =3D unicode_locking_shift_lookup(c, locking_lang);
+
+		if (converted =3D=3D GUND)
+			converted =3D unicode_single_shift_lookup(c, single_lang);
+
+		if (converted & 0x1b00) {
+			*out =3D 0x1b;
+			++out;
+		}
+
+		*out =3D converted;
+		++out;
+	}
+
+	if (terminator)
+		*out =3D terminator;
+
+	if (items_written)
+		*items_written =3D out - res;
+
+err_out:
+	if (items_read)
+		*items_read =3D nchars;
+
+	return res;
+}
+
+unsigned char *convert_ucs2_to_gsm(const unsigned char *text, long len,
+				long *items_read, long *items_written,
+				unsigned char terminator)
+{
+	return convert_ucs2_to_gsm_with_lang(text, len, items_read,
+						items_written,
+						terminator,
+						GSM_DIALECT_DEFAULT,
+						GSM_DIALECT_DEFAULT);
+}
diff --git a/src/util.h b/src/util.h
index 9da81aa..76498ad 100644
--- a/src/util.h
+++ b/src/util.h
@@ -80,3 +80,13 @@ char *sim_string_to_utf8(const unsigned char *buffer, in=
t length);
 =

 unsigned char *utf8_to_sim_string(const char *utf,
 					int max_length, int *out_length);
+
+unsigned char *convert_ucs2_to_gsm_with_lang(const unsigned char *text, lo=
ng len,
+					long *items_read, long *items_written,
+					unsigned char terminator,
+					enum gsm_dialect locking_lang,
+					enum gsm_dialect single_lang);
+
+unsigned char *convert_ucs2_to_gsm(const unsigned char *text, long len,
+				long *items_read, long *items_written,
+				unsigned char terminator);
-- =

1.7.0.4


--===============6674248854524145143==--

