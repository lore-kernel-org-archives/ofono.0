Content-Type: multipart/mixed; boundary="===============7946786458757372564=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/4] Add so called reduced charset support to SMS
Date: Thu, 02 Sep 2010 10:52:37 +0300
Message-ID: <1283413960-31490-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7946786458757372564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This "reduced" charset support is available in some current phones to
reduce the number of segments that a message takes.

Normally, when characters are encountered that don't have a
representation in the GSM 7 bit alphabet, the encoding switches to
UCS-2 that takes roughly twice as much space.

This reduced charset feature transliterates the input string, so that
more unicode characters fit the GSM alphabet. The obvious downside is
that transliterating loses information, i.e., the text gets dumbed
down, and what the recipient receives is not the original text.

Nevertheless, in some regions, this is a must-have feature.
---
 src/util.c       |  137 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 src/util.h       |    4 ++
 unit/test-util.c |   18 +++++++
 3 files changed, 152 insertions(+), 7 deletions(-)

diff --git a/src/util.c b/src/util.c
index fd8b305..4eeb060 100644
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
@@ -78,6 +79,7 @@ struct alphabet_conversion_table {
 	const struct codepoint *togsm_single_shift;
 	unsigned int togsm_single_shift_len;
 	const struct codepoint *tounicode_locking_shift;
+	unsigned int tounicode_locking_shift_len;
 	const struct codepoint *tounicode_single_shift;
 	unsigned int tounicode_single_shift_len;
 };
@@ -300,6 +302,7 @@ static const unsigned short def_gsm[] =3D {
 	0x0078, 0x0079, 0x007A, 0x00E4, 0x00F6, 0x00F1, 0x00FC, 0x00E0  /* 0x7F */
 };
 =

+/* Used for conversion of Unicode to GSM */
 static const struct codepoint def_unicode[] =3D {
 	{ 0x000A, 0x0A }, { 0x000D, 0x0D }, { 0x0020, 0x20 }, { 0x0021, 0x21 },
 	{ 0x0022, 0x22 }, { 0x0023, 0x23 }, { 0x0024, 0x02 }, { 0x0025, 0x25 },
@@ -445,19 +448,127 @@ static const struct codepoint por_unicode[] =3D {
 	{ 0x00FC, 0x7E }, { 0x0394, 0x10 }, { 0x20AC, 0x18 }, { 0x221E, 0x15 }
 };
 =

+/* Reduced character set pseudo dialect.
+ *
+ * This table includes the default Unicode to GSM table, and in
+ * addition entries for transliterating additional unicode characters
+ * to the GSM alphabet.  Certain mathematical symbols and accented
+ * characters are mapped to their closest-looking GSM 7bit character.
+ */
+static const struct codepoint reduced_unicode[] =3D {
+	{ 0x000A, 0x0A }, { 0x000D, 0x0D }, { 0x0020, 0x20 }, { 0x0021, 0x21 },
+	{ 0x0022, 0x22 }, { 0x0023, 0x23 }, { 0x0024, 0x02 }, { 0x0025, 0x25 },
+	{ 0x0026, 0x26 }, { 0x0027, 0x27 }, { 0x0028, 0x28 }, { 0x0029, 0x29 },
+	{ 0x002A, 0x2A }, { 0x002B, 0x2B }, { 0x002C, 0x2C }, { 0x002D, 0x2D },
+	{ 0x002E, 0x2E }, { 0x002F, 0x2F }, { 0x0030, 0x30 }, { 0x0031, 0x31 },
+	{ 0x0032, 0x32 }, { 0x0033, 0x33 }, { 0x0034, 0x34 }, { 0x0035, 0x35 },
+	{ 0x0036, 0x36 }, { 0x0037, 0x37 }, { 0x0038, 0x38 }, { 0x0039, 0x39 },
+	{ 0x003A, 0x3A }, { 0x003B, 0x3B }, { 0x003C, 0x3C }, { 0x003D, 0x3D },
+	{ 0x003E, 0x3E }, { 0x003F, 0x3F }, { 0x0040, 0x00 }, { 0x0041, 0x41 },
+	{ 0x0042, 0x42 }, { 0x0043, 0x43 }, { 0x0044, 0x44 }, { 0x0045, 0x45 },
+	{ 0x0046, 0x46 }, { 0x0047, 0x47 }, { 0x0048, 0x48 }, { 0x0049, 0x49 },
+	{ 0x004A, 0x4A }, { 0x004B, 0x4B }, { 0x004B, 0x4B }, { 0x004C, 0x4C },
+	{ 0x004D, 0x4D }, { 0x004E, 0x4E }, { 0x004F, 0x4F }, { 0x0050, 0x50 },
+	{ 0x0051, 0x51 }, { 0x0052, 0x52 }, { 0x0053, 0x53 }, { 0x0054, 0x54 },
+	{ 0x0055, 0x55 }, { 0x0056, 0x56 }, { 0x0057, 0x57 }, { 0x0058, 0x58 },
+	{ 0x0059, 0x59 }, { 0x005A, 0x5A }, { 0x005F, 0x11 }, { 0x005F, 0x11 },
+	{ 0x0061, 0x61 }, { 0x0062, 0x62 }, { 0x0063, 0x63 }, { 0x0064, 0x64 },
+	{ 0x0065, 0x65 }, { 0x0066, 0x66 }, { 0x0067, 0x67 }, { 0x0068, 0x68 },
+	{ 0x0069, 0x69 }, { 0x006A, 0x6A }, { 0x006B, 0x6B }, { 0x006C, 0x6C },
+	{ 0x006D, 0x6D }, { 0x006E, 0x6E }, { 0x006F, 0x6F }, { 0x0070, 0x70 },
+	{ 0x0071, 0x71 }, { 0x0072, 0x72 }, { 0x0072, 0x72 }, { 0x0073, 0x73 },
+	{ 0x0074, 0x74 }, { 0x0075, 0x75 }, { 0x0076, 0x76 }, { 0x0077, 0x77 },
+	{ 0x0078, 0x78 }, { 0x0079, 0x79 }, { 0x007A, 0x7A }, { 0x00A0, 0x20 },
+	{ 0x00A1, 0x40 }, { 0x00A3, 0x01 }, { 0x00A4, 0x24 }, { 0x00A5, 0x03 },
+	{ 0x00A7, 0x5F }, { 0x00BF, 0x60 }, { 0x00C0, 0x41 }, { 0x00C1, 0x41 },
+	{ 0x00C2, 0x41 }, { 0x00C3, 0x41 }, { 0x00C4, 0x5B }, { 0x00C5, 0x0E },
+	{ 0x00C6, 0x1C }, { 0x00C7, 0x09 }, { 0x00C8, 0x45 }, { 0x00C9, 0x1F },
+	{ 0x00CA, 0x45 }, { 0x00CB, 0x45 }, { 0x00CC, 0x49 }, { 0x00CD, 0x49 },
+	{ 0x00CE, 0x49 }, { 0x00CF, 0x49 }, { 0x00D0, 0x44 }, { 0x00D1, 0x5D },
+	{ 0x00D2, 0x4F }, { 0x00D3, 0x4F }, { 0x00D4, 0x4F }, { 0x00D5, 0x4F },
+	{ 0x00D6, 0x5C }, { 0x00D7, 0x2A }, { 0x00D8, 0x0B }, { 0x00D9, 0x55 },
+	{ 0x00DA, 0x55 }, { 0x00DB, 0x55 }, { 0x00DC, 0x5E }, { 0x00DD, 0x59 },
+	{ 0x00DE, 0x54 }, { 0x00DF, 0x1E }, { 0x00E0, 0x7F }, { 0x00E1, 0x61 },
+	{ 0x00E2, 0x61 }, { 0x00E3, 0x61 }, { 0x00E4, 0x7B }, { 0x00E5, 0x0F },
+	{ 0x00E6, 0x1D }, { 0x00E7, 0x63 }, { 0x00E8, 0x04 }, { 0x00E9, 0x05 },
+	{ 0x00EA, 0x65 }, { 0x00EB, 0x65 }, { 0x00EC, 0x07 }, { 0x00ED, 0x69 },
+	{ 0x00EE, 0x69 }, { 0x00EF, 0x69 }, { 0x00F0, 0x64 }, { 0x00F1, 0x7D },
+	{ 0x00F2, 0x08 }, { 0x00F3, 0x6F }, { 0x00F4, 0x6F }, { 0x00F5, 0x6F },
+	{ 0x00F6, 0x7C }, { 0x00F7, 0x6F }, { 0x00F8, 0x0C }, { 0x00F9, 0x06 },
+	{ 0x00FA, 0x75 }, { 0x00FB, 0x75 }, { 0x00FC, 0x7E }, { 0x00FD, 0x79 },
+	{ 0x00FE, 0x74 }, { 0x00FF, 0x79 }, { 0x0100, 0x41 }, { 0x0101, 0x61 },
+	{ 0x0102, 0x41 }, { 0x0103, 0x61 }, { 0x0104, 0x41 }, { 0x0105, 0x61 },
+	{ 0x0106, 0x43 }, { 0x0107, 0x63 }, { 0x0108, 0x43 }, { 0x0109, 0x63 },
+	{ 0x010A, 0x43 }, { 0x010B, 0x63 }, { 0x010C, 0x43 }, { 0x010D, 0x63 },
+	{ 0x010E, 0x44 }, { 0x010F, 0x64 }, { 0x0110, 0x44 }, { 0x0111, 0x64 },
+	{ 0x0112, 0x45 }, { 0x0113, 0x65 }, { 0x0114, 0x45 }, { 0x0115, 0x65 },
+	{ 0x0116, 0x45 }, { 0x0117, 0x65 }, { 0x0118, 0x45 }, { 0x0119, 0x65 },
+	{ 0x011A, 0x45 }, { 0x011B, 0x65 }, { 0x011C, 0x47 }, { 0x011D, 0x67 },
+	{ 0x011E, 0x47 }, { 0x011F, 0x67 }, { 0x0120, 0x47 }, { 0x0121, 0x67 },
+	{ 0x0122, 0x47 }, { 0x0123, 0x67 }, { 0x0124, 0x48 }, { 0x0125, 0x68 },
+	{ 0x0126, 0x48 }, { 0x0127, 0x68 }, { 0x0128, 0x49 }, { 0x0129, 0x69 },
+	{ 0x012A, 0x49 }, { 0x012B, 0x69 }, { 0x012C, 0x49 }, { 0x012D, 0x69 },
+	{ 0x012E, 0x49 }, { 0x012F, 0x69 }, { 0x0130, 0x49 }, { 0x0131, 0x69 },
+	{ 0x0134, 0x4A }, { 0x0135, 0x6A }, { 0x0136, 0x4B }, { 0x0137, 0x6B },
+	{ 0x0139, 0x4C }, { 0x013A, 0x6C }, { 0x013B, 0x4C }, { 0x013C, 0x6C },
+	{ 0x013D, 0x4C }, { 0x013E, 0x6C }, { 0x013F, 0x4C }, { 0x0140, 0x6C },
+	{ 0x0141, 0x4C }, { 0x0142, 0x6C }, { 0x0143, 0x4E }, { 0x0144, 0x6E },
+	{ 0x0145, 0x4E }, { 0x0146, 0x6E }, { 0x0147, 0x4E }, { 0x0148, 0x6E },
+	{ 0x014C, 0x4F }, { 0x014D, 0x6F }, { 0x014E, 0x4F }, { 0x014F, 0x6F },
+	{ 0x0150, 0x4F }, { 0x0151, 0x6F }, { 0x0154, 0x52 }, { 0x0155, 0x72 },
+	{ 0x0156, 0x52 }, { 0x0157, 0x72 }, { 0x0158, 0x52 }, { 0x0159, 0x72 },
+	{ 0x015A, 0x53 }, { 0x015B, 0x73 }, { 0x015C, 0x53 }, { 0x015D, 0x73 },
+	{ 0x015E, 0x53 }, { 0x015F, 0x73 }, { 0x0160, 0x53 }, { 0x0161, 0x73 },
+	{ 0x0162, 0x54 }, { 0x0163, 0x74 }, { 0x0164, 0x54 }, { 0x0165, 0x74 },
+	{ 0x0166, 0x54 }, { 0x0167, 0x74 }, { 0x0168, 0x55 }, { 0x0169, 0x75 },
+	{ 0x016A, 0x55 }, { 0x016B, 0x75 }, { 0x016C, 0x55 }, { 0x016D, 0x75 },
+	{ 0x016E, 0x55 }, { 0x016F, 0x75 }, { 0x0170, 0x55 }, { 0x0171, 0x75 },
+	{ 0x0172, 0x55 }, { 0x0173, 0x75 }, { 0x0179, 0x5A }, { 0x017A, 0x7A },
+	{ 0x017B, 0x5A }, { 0x017C, 0x7A }, { 0x017D, 0x5A }, { 0x017E, 0x7A },
+	{ 0x0386, 0x41 }, { 0x0388, 0x45 }, { 0x0389, 0x48 }, { 0x038A, 0x49 },
+	{ 0x038C, 0x4F }, { 0x038E, 0x59 }, { 0x038F, 0x15 }, { 0x0390, 0x49 },
+	{ 0x0391, 0x41 }, { 0x0392, 0x42 }, { 0x0393, 0x13 }, { 0x0394, 0x10 },
+	{ 0x0395, 0x45 }, { 0x0396, 0x5A }, { 0x0397, 0x48 }, { 0x0398, 0x19 },
+	{ 0x0399, 0x49 }, { 0x039A, 0x4B }, { 0x039B, 0x14 }, { 0x039C, 0x4D },
+	{ 0x039D, 0x4E }, { 0x039E, 0x1A }, { 0x039F, 0x4F }, { 0x03A0, 0x16 },
+	{ 0x03A1, 0x50 }, { 0x03A3, 0x18 }, { 0x03A4, 0x54 }, { 0x03A5, 0x59 },
+	{ 0x03A6, 0x12 }, { 0x03A7, 0x58 }, { 0x03A8, 0x17 }, { 0x03A9, 0x15 },
+	{ 0x03AA, 0x49 }, { 0x03AB, 0x59 }, { 0x03AC, 0x41 }, { 0x03AD, 0x45 },
+	{ 0x03AE, 0x48 }, { 0x03AF, 0x49 }, { 0x03B0, 0x59 }, { 0x03B1, 0x41 },
+	{ 0x03B2, 0x42 }, { 0x03B3, 0x13 }, { 0x03B4, 0x10 }, { 0x03B5, 0x45 },
+	{ 0x03B6, 0x5A }, { 0x03B7, 0x48 }, { 0x03B8, 0x19 }, { 0x03B9, 0x49 },
+	{ 0x03BA, 0x4B }, { 0x03BB, 0x14 }, { 0x03BC, 0x4D }, { 0x03BD, 0x4E },
+	{ 0x03BE, 0x1A }, { 0x03BF, 0x4F }, { 0x03C0, 0x16 }, { 0x03C1, 0x50 },
+	{ 0x03C2, 0x18 }, { 0x03C3, 0x18 }, { 0x03C4, 0x54 }, { 0x03C5, 0x59 },
+	{ 0x03C6, 0x12 }, { 0x03C7, 0x58 }, { 0x03C8, 0x17 }, { 0x03C9, 0x15 },
+	{ 0x03CA, 0x49 }, { 0x03CB, 0x59 }, { 0x03CC, 0x4F }, { 0x03CD, 0x59 },
+	{ 0x03CE, 0x15 }
+};
+
 static const struct alphabet_conversion_table alphabet_lookup[] =3D {
 	/* Default GSM 7 bit */
 	{ def_gsm, def_ext_gsm, TABLE_SIZE(def_ext_gsm),
-		def_unicode, def_ext_unicode, TABLE_SIZE(def_ext_unicode) },
+		def_unicode, TABLE_SIZE(def_unicode),
+		def_ext_unicode, TABLE_SIZE(def_ext_unicode) },
 	/* Turkish GSM dialect */
 	{ tur_gsm, tur_ext_gsm, TABLE_SIZE(tur_ext_gsm),
-		tur_unicode, tur_ext_unicode, TABLE_SIZE(tur_ext_unicode) },
+		tur_unicode, TABLE_SIZE(tur_unicode),
+		tur_ext_unicode, TABLE_SIZE(tur_ext_unicode) },
 	/* Spanish GSM dialect, note that this one only has extension table */
 	{ def_gsm, spa_ext_gsm, TABLE_SIZE(spa_ext_gsm),
-		def_unicode, spa_ext_unicode, TABLE_SIZE(spa_ext_unicode)  },
+		def_unicode, TABLE_SIZE(def_unicode),
+		spa_ext_unicode, TABLE_SIZE(spa_ext_unicode)  },
 	/* Portuguese GSM dialect */
 	{ por_gsm, por_ext_gsm, TABLE_SIZE(por_ext_gsm),
-		por_unicode, por_ext_unicode, TABLE_SIZE(por_ext_unicode) },
+		por_unicode, TABLE_SIZE(por_unicode),
+		por_ext_unicode, TABLE_SIZE(por_ext_unicode) },
+
+	/* End of valid real dialects */
+
+	/* Reduced character set pseudo dialect: use only for encoding */
+	{ NULL, NULL, 0,
+		reduced_unicode, TABLE_SIZE(reduced_unicode),
+		def_ext_unicode, TABLE_SIZE(def_ext_unicode) }
 };
 =

 static int compare_codepoints(const void *a, const void *b)
@@ -504,9 +615,10 @@ static unsigned short unicode_locking_shift_lookup(uns=
igned short k,
 {
 	struct codepoint key =3D { k, 0 };
 	const struct codepoint *table;
-	unsigned int len =3D 128;
+	unsigned int len;
 =

 	table =3D alphabet_lookup[lang].tounicode_locking_shift;
+	len =3D alphabet_lookup[lang].tounicode_locking_shift_len;
 =

 	return codepoint_lookup(&key, table, len);
 }
@@ -655,10 +767,10 @@ unsigned char *convert_utf8_to_gsm_with_lang(const ch=
ar *text, long len,
 	long res_len;
 	long i;
 =

-	if (locking_lang >=3D GSM_DIALECT_INVALID)
+	if (locking_lang > GSM_DIALECT_INVALID)
 		return NULL;
 =

-	if (single_lang >=3D GSM_DIALECT_INVALID)
+	if (single_lang > GSM_DIALECT_INVALID)
 		return NULL;
 =

 	in =3D text;
@@ -744,6 +856,17 @@ unsigned char *convert_utf8_to_gsm(const char *text, l=
ong len,
 						GSM_DIALECT_DEFAULT);
 }
 =

+unsigned char *convert_utf8_to_gsm_with_translit(const char *text, long le=
n,
+					long *items_read, long *items_written,
+					unsigned char terminator)
+{
+	return convert_utf8_to_gsm_with_lang(text, len, items_read,
+						items_written,
+						terminator,
+						GSM_DIALECT_INVALID,
+						GSM_DIALECT_INVALID);
+}
+
 /*!
  * Decodes the hex encoded data and converts to a byte array.  If terminat=
or
  * is not 0, the terminator character is appended to the end of the result.
diff --git a/src/util.h b/src/util.h
index 9da81aa..ddaee4e 100644
--- a/src/util.h
+++ b/src/util.h
@@ -38,6 +38,10 @@ char *convert_gsm_to_utf8_with_lang(const unsigned char =
*text, long len, long *i
 unsigned char *convert_utf8_to_gsm(const char *text, long len, long *items=
_read,
 				long *items_written, unsigned char terminator);
 =

+unsigned char *convert_utf8_to_gsm_with_translit(const char *text, long le=
n,
+				long *items_read, long *items_written,
+				unsigned char terminator);
+
 unsigned char *convert_utf8_to_gsm_with_lang(const char *text, long len, l=
ong *items_read,
 				long *items_written, unsigned char terminator,
 				enum gsm_dialect locking_shift_lang,
diff --git a/unit/test-util.c b/unit/test-util.c
index de62848..03728db 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -486,6 +486,23 @@ static void test_valid_turkish()
 	}
 }
 =

+static void test_encode_translit()
+{
+	const char *utf8 =3D "=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD";
+	const char *expect =3D "ceAAuoiOOAaoOoaUAEa";
+	long nwritten;
+	long nread;
+	unsigned char *res;
+
+	res =3D convert_utf8_to_gsm_with_translit(utf8, sizeof(utf8), &nread, &nw=
ritten, 0);
+
+	g_assert(res);
+	g_assert(nread =3D=3D sizeof(utf8));
+	g_assert(memcmp(res, expect, nwritten) =3D=3D 0);
+
+	g_free(res);
+}
+
 static const char hex_packed[] =3D "493A283D0795C3F33C88FE06C9CB6132885EC6=
D34"
 					"1EDF27C1E3E97E7207B3A0C0A5241E377BB1D"
 					"7693E72E";
@@ -912,6 +929,7 @@ int main(int argc, char **argv)
 	g_test_add_func("/testutil/Invalid Conversions", test_invalid);
 	g_test_add_func("/testutil/Valid Conversions", test_valid);
 	g_test_add_func("/testutil/Valid Turkish National Variant Conversions", t=
est_valid_turkish);
+	g_test_add_func("/testutil/Encode with transliteration", test_encode_tran=
slit);
 	g_test_add_func("/testutil/Decode Encode", test_decode_encode);
 	g_test_add_func("/testutil/Pack Size", test_pack_size);
 	g_test_add_func("/testutil/CBS CR Handling", test_cr_handling);
-- =

1.7.0.4


--===============7946786458757372564==--

