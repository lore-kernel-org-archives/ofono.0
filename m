Content-Type: multipart/mixed; boundary="===============4148236231873216931=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/2] stkutil: convert img to xpm
Date: Mon, 26 Jul 2010 11:27:33 -0700
Message-ID: <1280168854-4151-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1280168854-4151-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4148236231873216931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |    9 ++++
 2 files changed, 156 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 9cac850..ae4cc32 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -6076,3 +6076,150 @@ char *stk_text_to_html(const char *utf8,
 	/* return characters from string. Caller must free char data */
 	return g_string_free(string, FALSE);
 }
+
+static const char chars_table[] =3D {
+	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C',
+	'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
+	'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c',
+	'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
+	'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '+', '.' };
+
+char *stk_image_to_xpm(const unsigned char *img, unsigned int len,
+			enum stk_img_scheme scheme, const unsigned char *clut,
+			unsigned short clut_len)
+{
+	guint8 width, height;
+	unsigned int ncolors, nbits, entry, cpp;
+	unsigned int i, j;
+	int bit, k;
+	GString *xpm;
+	unsigned int pos =3D 0;
+	const char xpm_header[] =3D "/* XPM */\n";
+	const char declaration[] =3D "static char *xpm[] =3D {\n";
+	char c[3];
+
+	if (img =3D=3D NULL)
+		return NULL;
+
+	/* sanity check length */
+	if (len < 3)
+		return NULL;
+
+	width =3D img[pos++];
+	height =3D img[pos++];
+
+	if (scheme =3D=3D STK_IMG_SCHEME_BASIC) {
+		nbits =3D 1;
+		ncolors =3D 2;
+	} else {
+		/* sanity check length */
+		if ((pos + 4 > len) || (clut =3D=3D NULL))
+			return NULL;
+
+		nbits =3D img[pos++];
+		ncolors =3D img[pos++];
+
+		/* the value of zero should be interpreted as 256 */
+		if (ncolors =3D=3D 0)
+			ncolors =3D 256;
+
+		/* skip clut offset bytes */
+		pos +=3D 2;
+
+		if ((ncolors * 3) > clut_len)
+			return NULL;
+	}
+
+	if (pos + ((width * height + 7) / 8) > len)
+		return NULL;
+
+	/* determine the number of chars need to represent the pixel */
+	cpp =3D ncolors > 64 ? 2 : 1;
+
+	/*
+	 * space needed:
+	 * 	header line
+	 *	declaration and beginning of assignment line
+	 *	values - max length of 19
+	 *	colors - ncolors * (cpp + whitespace + deliminators + color)
+	 *	pixels - width * height * cpp + height deliminators "",\n
+	 *	end of assignment - 2 chars "};"
+	 */
+	xpm =3D g_string_sized_new(strlen(xpm_header) + strlen(declaration) +
+				19 + ((cpp + 14) * ncolors) +
+				(width * height * cpp) + (4 * height) + 2);
+	if (xpm =3D=3D NULL)
+		return NULL;
+
+	/* add header, declaration, values */
+	g_string_append(xpm, xpm_header);
+	g_string_append(xpm, declaration);
+	g_string_append_printf(xpm, "\"%d %d %d %d\",\n", width, height,
+				ncolors, cpp);
+
+	/* create colors */
+	if (scheme =3D=3D STK_IMG_SCHEME_BASIC) {
+		g_string_append(xpm, "\"0\tc #000000\",\n");
+		g_string_append(xpm, "\"1\tc #FFFFFF\",\n");
+	} else {
+		for (i =3D 0; i < ncolors; i++) {
+			/* lookup char representation of this number */
+			if (ncolors > 64) {
+				c[0] =3D chars_table[i / 64];
+				c[1] =3D chars_table[i % 64];
+				c[2] =3D '\0';
+			} else {
+				c[0] =3D chars_table[i % 64];
+				c[1] =3D '\0';
+			}
+
+			if ((i =3D=3D (ncolors - 1)) &&
+					scheme =3D=3D STK_IMG_SCHEME_TRANSPARENCY)
+				g_string_append_printf(xpm,
+					"\"%s\tc None\",\n", c);
+			else
+				g_string_append_printf(xpm,
+					"\"%s\tc #%02hhX%02hhX%02hhX\",\n",
+					c, clut[0], clut[1], clut[2]);
+			clut +=3D 3;
+		}
+	}
+
+	/* height rows of width pixels */
+	k =3D 7;
+	for (i =3D 0; i < height; i++) {
+		g_string_append(xpm, "\"");
+		for (j =3D 0; j < width; j++) {
+			entry =3D 0;
+			for (bit =3D nbits - 1; bit >=3D 0; bit--) {
+				entry |=3D (img[pos] >> k & 0x1) << bit;
+				k--;
+
+				/* see if we crossed a byte boundary */
+				if (k < 0) {
+					k =3D 7;
+					pos++;
+				}
+			}
+
+			/* lookup char representation of this number */
+			if (ncolors > 64) {
+				c[0] =3D chars_table[entry / 64];
+				c[1] =3D chars_table[entry % 64];
+				c[2] =3D '\0';
+			} else {
+				c[0] =3D chars_table[entry % 64];
+				c[1] =3D '\0';
+			}
+
+			g_string_append_printf(xpm, "%s", c);
+		}
+
+		g_string_append(xpm, "\",\n");
+	}
+
+	g_string_append(xpm, "};");
+
+	/* Caller must free char data */
+	return g_string_free(xpm, FALSE);
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index 1fbd68b..ea9294c 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -557,6 +557,12 @@ enum stk_me_status {
 	STK_ME_STATUS_NOT_IDLE =3D 	0x01
 };
 =

+enum stk_img_scheme {
+	STK_IMG_SCHEME_BASIC =3D		0x11,
+	STK_IMG_SCHEME_COLOR =3D		0x21,
+	STK_IMG_SCHEME_TRANSPARENCY =3D	0x22,
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -1644,3 +1650,6 @@ const unsigned char *stk_pdu_from_envelope(const stru=
ct stk_envelope *envelope,
 						unsigned int *out_length);
 char *stk_text_to_html(const char *text,
 				const unsigned short *attrs, int num_attrs);
+char *stk_image_to_xpm(const unsigned char *img, unsigned int len,
+			enum stk_img_scheme scheme, const unsigned char *clut,
+			unsigned short clut_len);
-- =

1.6.6.1


--===============4148236231873216931==--

