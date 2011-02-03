Content-Type: multipart/mixed; boundary="===============4095893241290756110=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/6] util: Refactor conversion table handling
Date: Thu, 03 Feb 2011 15:20:31 +0200
Message-ID: <1296739236-24391-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296739236-24391-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4095893241290756110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/util.c |  205 +++++++++++++++++++++++++++++++++++++-------------------=
----
 src/util.h |    1 -
 2 files changed, 126 insertions(+), 80 deletions(-)

diff --git a/src/util.c b/src/util.c
index f63ce67..547f38c 100644
--- a/src/util.c
+++ b/src/util.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2009-2010  Nokia Corporation and/or its subsidiary(-ies).
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -62,8 +63,7 @@
 #define GUND			0xFFFF
 =

 #define UTF8_LENGTH(c) \
-	((c) < 0x80 ? 1 : \
-	 ((c) < 0x800 ? 2 : 3))
+	((c) < 0x80 ? 1 : ((c) < 0x800 ? 2 : 3))
 =

 #define TABLE_SIZE(t) \
 	(sizeof((t)) / sizeof(struct codepoint))
@@ -73,13 +73,21 @@ struct codepoint {
 	unsigned short to;
 };
 =

-struct alphabet_conversion_table {
-	const unsigned short *togsm_locking_shift;
-	const struct codepoint *togsm_single_shift;
-	unsigned int togsm_single_shift_len;
-	const struct codepoint *tounicode_locking_shift;
-	const struct codepoint *tounicode_single_shift;
-	unsigned int tounicode_single_shift_len;
+struct conversion_table {
+	/* To unicode locking shift table */
+	const struct codepoint *locking_u;
+	unsigned int locking_len_u;
+
+	/* To unicode single shift table */
+	const struct codepoint *single_u;
+	unsigned int single_len_u;
+
+	/* To GSM locking shift table, fixed size */
+	const unsigned short *locking_g;
+
+	/* To GSM single shift table */
+	const struct codepoint *single_g;
+	unsigned int single_len_g;
 };
 =

 /* GSM to Unicode extension table, for GSM sequences starting with 0x1B */
@@ -300,6 +308,7 @@ static const unsigned short def_gsm[] =3D {
 	0x0078, 0x0079, 0x007A, 0x00E4, 0x00F6, 0x00F1, 0x00FC, 0x00E0
 };
 =

+/* Used for conversion of Unicode to GSM */
 static const struct codepoint def_unicode[] =3D {
 	{ 0x000A, 0x0A }, { 0x000D, 0x0D }, { 0x0020, 0x20 }, { 0x0021, 0x21 },
 	{ 0x0022, 0x22 }, { 0x0023, 0x23 }, { 0x0024, 0x02 }, { 0x0025, 0x25 },
@@ -445,21 +454,6 @@ static const struct codepoint por_unicode[] =3D {
 	{ 0x00FC, 0x7E }, { 0x0394, 0x10 }, { 0x20AC, 0x18 }, { 0x221E, 0x15 }
 };
 =

-static const struct alphabet_conversion_table alphabet_lookup[] =3D {
-	/* Default GSM 7 bit */
-	{ def_gsm, def_ext_gsm, TABLE_SIZE(def_ext_gsm),
-		def_unicode, def_ext_unicode, TABLE_SIZE(def_ext_unicode) },
-	/* Turkish GSM dialect */
-	{ tur_gsm, tur_ext_gsm, TABLE_SIZE(tur_ext_gsm),
-		tur_unicode, tur_ext_unicode, TABLE_SIZE(tur_ext_unicode) },
-	/* Spanish GSM dialect, note that this one only has extension table */
-	{ def_gsm, spa_ext_gsm, TABLE_SIZE(spa_ext_gsm),
-		def_unicode, spa_ext_unicode, TABLE_SIZE(spa_ext_unicode)  },
-	/* Portuguese GSM dialect */
-	{ por_gsm, por_ext_gsm, TABLE_SIZE(por_ext_gsm),
-		por_unicode, por_ext_unicode, TABLE_SIZE(por_ext_unicode) },
-};
-
 static int compare_codepoints(const void *a, const void *b)
 {
 	const struct codepoint *ca =3D (const struct codepoint *) a;
@@ -480,48 +474,102 @@ static unsigned short codepoint_lookup(struct codepo=
int *key,
 	return result ? result->to : GUND;
 }
 =

-static unsigned short gsm_locking_shift_lookup(unsigned char k,
-						unsigned char lang)
+static unsigned short gsm_locking_shift_lookup(struct conversion_table *t,
+						unsigned char k)
 {
-	return alphabet_lookup[lang].togsm_locking_shift[k];
+	return t->locking_g[k];
 }
 =

-static unsigned short gsm_single_shift_lookup(unsigned char k,
-						unsigned char lang)
+static unsigned short gsm_single_shift_lookup(struct conversion_table *t,
+						unsigned char k)
 {
 	struct codepoint key =3D { k, 0 };
-	const struct codepoint *table;
-	unsigned int len;
-
-	table =3D alphabet_lookup[lang].togsm_single_shift;
-	len =3D alphabet_lookup[lang].togsm_single_shift_len;
-
-	return codepoint_lookup(&key, table, len);
+	return codepoint_lookup(&key, t->single_g, t->single_len_g);
 }
 =

-static unsigned short unicode_locking_shift_lookup(unsigned short k,
-							unsigned char lang)
+static unsigned short unicode_locking_shift_lookup(struct conversion_table=
 *t,
+							unsigned short k)
 {
 	struct codepoint key =3D { k, 0 };
-	const struct codepoint *table;
-	unsigned int len =3D 128;
+	return codepoint_lookup(&key, t->locking_u, t->locking_len_u);
+}
 =

-	table =3D alphabet_lookup[lang].tounicode_locking_shift;
+static unsigned short unicode_single_shift_lookup(struct conversion_table =
*t,
+							unsigned short k)
+{
+	struct codepoint key =3D { k, 0 };
+	return codepoint_lookup(&key, t->single_u, t->single_len_u);
+}
 =

-	return codepoint_lookup(&key, table, len);
+static int populate_locking_shift(struct conversion_table *t,
+					enum gsm_dialect lang)
+{
+	switch (lang) {
+	case GSM_DIALECT_DEFAULT:
+	case GSM_DIALECT_SPANISH:
+		t->locking_g =3D def_gsm;
+		t->locking_u =3D def_unicode;
+		t->locking_len_u =3D TABLE_SIZE(def_unicode);
+		return 1;
+
+	case GSM_DIALECT_TURKISH:
+		t->locking_g =3D tur_gsm;
+		t->locking_u =3D tur_unicode;
+		t->locking_len_u =3D TABLE_SIZE(tur_unicode);
+		return 1;
+
+	case GSM_DIALECT_PORTUGUESE:
+		t->locking_g =3D por_gsm;
+		t->locking_u =3D por_unicode;
+		t->locking_len_u =3D TABLE_SIZE(por_unicode);
+		return 1;
+	}
+	return 0;
 }
 =

-static unsigned short unicode_single_shift_lookup(unsigned short k,
-							unsigned char lang)
+static int populate_single_shift(struct conversion_table *t,
+					enum gsm_dialect lang)
 {
-	struct codepoint key =3D { k, 0 };
-	const struct codepoint *table;
-	unsigned int len;
+	switch (lang) {
+	case GSM_DIALECT_DEFAULT:
+		t->single_g =3D def_ext_gsm;
+		t->single_len_g =3D TABLE_SIZE(def_ext_gsm);
+		t->single_u =3D def_ext_unicode;
+		t->single_len_u =3D TABLE_SIZE(def_ext_unicode);
+		return 1;
+
+	case GSM_DIALECT_TURKISH:
+		t->single_g =3D tur_ext_gsm;
+		t->single_len_g =3D TABLE_SIZE(tur_ext_gsm);
+		t->single_u =3D tur_ext_unicode;
+		t->single_len_u =3D TABLE_SIZE(tur_ext_unicode);
+		return 1;
+
+	case GSM_DIALECT_SPANISH:
+		t->single_g =3D spa_ext_gsm;
+		t->single_len_g =3D TABLE_SIZE(spa_ext_gsm);
+		t->single_u =3D spa_ext_unicode;
+		t->single_len_u =3D TABLE_SIZE(spa_ext_unicode);
+		return 1;
+
+	case GSM_DIALECT_PORTUGUESE:
+		t->single_g =3D por_ext_gsm;
+		t->single_len_g =3D TABLE_SIZE(por_ext_gsm);
+		t->single_u =3D por_ext_unicode;
+		t->single_len_u =3D TABLE_SIZE(por_ext_unicode);
+		return 1;
+	}
+	return 0;
+}
 =

-	table =3D alphabet_lookup[lang].tounicode_single_shift;
-	len =3D alphabet_lookup[lang].tounicode_single_shift_len;
+static int conversion_table_init(struct conversion_table *t,
+					enum gsm_dialect locking,
+					enum gsm_dialect single)
+{
+	memset(t, 0, sizeof(struct conversion_table));
 =

-	return codepoint_lookup(&key, table, len);
+	return populate_locking_shift(t, locking) &&
+			populate_single_shift(t, single);
 }
 =

 /*!
@@ -548,10 +596,9 @@ char *convert_gsm_to_utf8_with_lang(const unsigned cha=
r *text, long len,
 	long i =3D 0;
 	long res_length;
 =

-	if (locking_lang >=3D GSM_DIALECT_INVALID)
-		return NULL;
+	struct conversion_table t;
 =

-	if (single_lang >=3D GSM_DIALECT_INVALID)
+	if (!conversion_table_init(&t, locking_lang, single_lang))
 		return NULL;
 =

 	if (len < 0 && !terminator)
@@ -577,12 +624,12 @@ char *convert_gsm_to_utf8_with_lang(const unsigned ch=
ar *text, long len,
 			if (i >=3D len)
 				goto error;
 =

-			c =3D gsm_single_shift_lookup(text[i], single_lang);
+			c =3D gsm_single_shift_lookup(&t, text[i]);
 =

 			if (c =3D=3D GUND)
 				goto error;
 		} else {
-			c =3D gsm_locking_shift_lookup(text[i], locking_lang);
+			c =3D gsm_locking_shift_lookup(&t, text[i]);
 		}
 =

 		res_length +=3D UTF8_LENGTH(c);
@@ -599,9 +646,9 @@ char *convert_gsm_to_utf8_with_lang(const unsigned char=
 *text, long len,
 		unsigned short c;
 =

 		if (text[i] =3D=3D 0x1b)
-			c =3D gsm_single_shift_lookup(text[++i], single_lang);
+			c =3D gsm_single_shift_lookup(&t, text[++i]);
 		else
-			c =3D gsm_locking_shift_lookup(text[i], locking_lang);
+			c =3D gsm_locking_shift_lookup(&t, text[i]);
 =

 		out +=3D g_unichar_to_utf8(c, out);
 =

@@ -647,6 +694,7 @@ unsigned char *convert_utf8_to_gsm_with_lang(const char=
 *text, long len,
 					enum gsm_dialect locking_lang,
 					enum gsm_dialect single_lang)
 {
+	struct conversion_table t;
 	long nchars =3D 0;
 	const char *in;
 	unsigned char *out;
@@ -654,10 +702,7 @@ unsigned char *convert_utf8_to_gsm_with_lang(const cha=
r *text, long len,
 	long res_len;
 	long i;
 =

-	if (locking_lang >=3D GSM_DIALECT_INVALID)
-		return NULL;
-
-	if (single_lang >=3D GSM_DIALECT_INVALID)
+	if (!conversion_table_init(&t, locking_lang, single_lang))
 		return NULL;
 =

 	in =3D text;
@@ -674,10 +719,10 @@ unsigned char *convert_utf8_to_gsm_with_lang(const ch=
ar *text, long len,
 		if (c > 0xffff)
 			goto err_out;
 =

-		converted =3D unicode_locking_shift_lookup(c, locking_lang);
+		converted =3D unicode_locking_shift_lookup(&t, c);
 =

 		if (converted =3D=3D GUND)
-			converted =3D unicode_single_shift_lookup(c, single_lang);
+			converted =3D unicode_single_shift_lookup(&t, c);
 =

 		if (converted =3D=3D GUND)
 			goto err_out;
@@ -702,10 +747,10 @@ unsigned char *convert_utf8_to_gsm_with_lang(const ch=
ar *text, long len,
 =

 		gunichar c =3D g_utf8_get_char(in);
 =

-		converted =3D unicode_locking_shift_lookup(c, locking_lang);
+		converted =3D unicode_locking_shift_lookup(&t, c);
 =

 		if (converted =3D=3D GUND)
-			converted =3D unicode_single_shift_lookup(c, single_lang);
+			converted =3D unicode_single_shift_lookup(&t, c);
 =

 		if (converted & 0x1b00) {
 			*out =3D 0x1b;
@@ -1087,6 +1132,7 @@ unsigned char *pack_7bit(const unsigned char *in, lon=
g len, int byte_offset,
 =

 char *sim_string_to_utf8(const unsigned char *buffer, int length)
 {
+	struct conversion_table t;
 	int i;
 	int j;
 	int num_chars;
@@ -1096,6 +1142,9 @@ char *sim_string_to_utf8(const unsigned char *buffer,=
 int length)
 	char *utf8 =3D NULL;
 	char *out;
 =

+	if (!conversion_table_init(&t, GSM_DIALECT_DEFAULT, GSM_DIALECT_DEFAULT))
+		return NULL;
+
 	if (length < 1)
 		return NULL;
 =

@@ -1172,14 +1221,14 @@ char *sim_string_to_utf8(const unsigned char *buffe=
r, int length)
 			if (i >=3D length)
 				return NULL;
 =

-			c =3D gsm_single_shift_lookup(buffer[i++], 0);
+			c =3D gsm_single_shift_lookup(&t, buffer[i++]);
 =

 			if (c =3D=3D 0)
 				return NULL;
 =

 			j +=3D 2;
 		} else {
-			c =3D gsm_locking_shift_lookup(buffer[i++], 0);
+			c =3D gsm_locking_shift_lookup(&t, buffer[i++]);
 			j +=3D 1;
 		}
 =

@@ -1208,9 +1257,9 @@ char *sim_string_to_utf8(const unsigned char *buffer,=
 int length)
 			c =3D (buffer[i++] & 0x7f) + ucs2_offset;
 		else if (buffer[i] =3D=3D 0x1b) {
 			++i;
-			c =3D gsm_single_shift_lookup(buffer[i++], 0);
+			c =3D gsm_single_shift_lookup(&t, buffer[i++]);
 		} else
-			c =3D gsm_locking_shift_lookup(buffer[i++], 0);
+			c =3D gsm_locking_shift_lookup(&t, buffer[i++]);
 =

 		out +=3D g_unichar_to_utf8(c, out);
 	}
@@ -1220,8 +1269,8 @@ char *sim_string_to_utf8(const unsigned char *buffer,=
 int length)
 	return utf8;
 }
 =

-unsigned char *utf8_to_sim_string(const char *utf,
-					int max_length, int *out_length)
+unsigned char *utf8_to_sim_string(const char *utf, int max_length,
+					int *out_length)
 {
 	unsigned char *result;
 	unsigned char *ucs2;
@@ -1282,6 +1331,7 @@ unsigned char *convert_ucs2_to_gsm_with_lang(const un=
signed char *text,
 					enum gsm_dialect locking_lang,
 					enum gsm_dialect single_lang)
 {
+	struct conversion_table t;
 	long nchars =3D 0;
 	const unsigned char *in;
 	unsigned char *out;
@@ -1289,10 +1339,7 @@ unsigned char *convert_ucs2_to_gsm_with_lang(const u=
nsigned char *text,
 	long res_len;
 	long i;
 =

-	if (locking_lang >=3D GSM_DIALECT_INVALID)
-		return NULL;
-
-	if (single_lang >=3D GSM_DIALECT_INVALID)
+	if (!conversion_table_init(&t, locking_lang, single_lang))
 		return NULL;
 =

 	if (len < 1 || len % 2)
@@ -1308,10 +1355,10 @@ unsigned char *convert_ucs2_to_gsm_with_lang(const =
unsigned char *text,
 		if (c > 0xffff)
 			goto err_out;
 =

-		converted =3D unicode_locking_shift_lookup(c, locking_lang);
+		converted =3D unicode_locking_shift_lookup(&t, c);
 =

 		if (converted =3D=3D GUND)
-			converted =3D unicode_single_shift_lookup(c, single_lang);
+			converted =3D unicode_single_shift_lookup(&t, c);
 =

 		if (converted =3D=3D GUND)
 			goto err_out;
@@ -1335,10 +1382,10 @@ unsigned char *convert_ucs2_to_gsm_with_lang(const =
unsigned char *text,
 		gunichar c =3D (in[i] << 8) | in[i + 1];
 		unsigned short converted =3D GUND;
 =

-		converted =3D unicode_locking_shift_lookup(c, locking_lang);
+		converted =3D unicode_locking_shift_lookup(&t, c);
 =

 		if (converted =3D=3D GUND)
-			converted =3D unicode_single_shift_lookup(c, single_lang);
+			converted =3D unicode_single_shift_lookup(&t, c);
 =

 		if (converted & 0x1b00) {
 			*out =3D 0x1b;
diff --git a/src/util.h b/src/util.h
index d09d496..8e4b7f3 100644
--- a/src/util.h
+++ b/src/util.h
@@ -24,7 +24,6 @@ enum gsm_dialect {
 	GSM_DIALECT_TURKISH,
 	GSM_DIALECT_SPANISH,
 	GSM_DIALECT_PORTUGUESE,
-	GSM_DIALECT_INVALID
 };
 =

 char *convert_gsm_to_utf8(const unsigned char *text, long len, long *items=
_read,
-- =

1.7.1


--===============4095893241290756110==--

