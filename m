Content-Type: multipart/mixed; boundary="===============7913848975285444727=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/2] stkutil: convert img to xpm
Date: Wed, 21 Jul 2010 22:06:21 -0700
Message-ID: <1279775182-26340-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1279775182-26340-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7913848975285444727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |    1 +
 2 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 9cac850..dfac661 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -26,6 +26,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdint.h>
+#include <stdio.h>
 =

 #include <glib.h>
 =

@@ -6076,3 +6077,110 @@ char *stk_text_to_html(const char *utf8,
 	/* return characters from string. Caller must free char data */
 	return g_string_free(string, FALSE);
 }
+
+char *stk_image_to_xpm(const unsigned char *img, guint8 scheme)
+{
+	guint8 width, height;
+	int ncolors, nbits, bit, entry, cpp;
+	int i, j, k;
+	short clut_offset =3D 0;
+	guint8 *clut;
+	GString *xpm;
+	int pos =3D 0;
+	const char xpm_header[] =3D "/* XPM */\n";
+	const char declaration[] =3D "static char *xpm[] =3D {\n";
+	char temp[17];
+
+	if (img =3D=3D NULL)
+		return NULL;
+
+	width =3D img[pos++];
+	height =3D img[pos++];
+
+	if (scheme =3D=3D 0x11) {
+		nbits =3D 1;
+		ncolors =3D 2;
+	} else {
+		nbits =3D img[pos++];
+		ncolors =3D img[pos++];
+
+		/* the value of zero should be interpreted as 256 */
+		if (ncolors =3D=3D 0)
+			ncolors =3D 256;
+
+		clut_offset =3D img[pos++] << 8;
+		clut_offset |=3D img[pos++];
+	}
+
+	/* determine the number of chars need to represent the pixel */
+	sprintf(temp, "%d", ncolors);
+	cpp =3D strlen(temp);
+
+	/* create values line */
+	sprintf(temp, "\"%d %d %d %d\",\n", width, height, ncolors, cpp);
+
+	/*
+	 * space needed:
+	 * 	header line
+	 *	declaration and beginning of assignment line
+	 *	values - strlen(values)
+	 *	colors - ncolors * (cpp + whitespace + deliminators + color)
+	 *	pixels - width * height * cpp + height deliminators "",\n
+	 *	end of assignment - 2 chars "};"
+	 */
+	xpm =3D g_string_sized_new(strlen(xpm_header) + strlen(declaration) +
+				strlen(temp) + ((cpp + 14) * ncolors) +
+				(width * height * cpp) + (4 * height) + 2);
+	if (xpm =3D=3D NULL)
+		return NULL;
+
+	/* add header, declaration, values */
+	g_string_append(xpm, xpm_header);
+	g_string_append(xpm, declaration);
+	g_string_append(xpm, temp);
+
+	/* create colors */
+	if (scheme =3D=3D 0x11) {
+		g_string_append(xpm, "\"0\tc #000000\",\n");
+		g_string_append(xpm, "\"1\tc #FFFFFF\",\n");
+	} else {
+		clut =3D (guint8 *) &img[clut_offset];
+
+		for (i =3D 0; i < ncolors; i++) {
+			if ((i =3D=3D (ncolors - 1)) && (scheme =3D=3D 0x22))
+				g_string_append_printf(xpm,
+					"\"%*d\tc None\",\n",
+					cpp, i);
+			else
+				g_string_append_printf(xpm,
+					"\"%*d\tc #%02hhX%02hhX%02hhX\",\n",
+					cpp, i, clut[0], clut[1], clut[2]);
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
+			g_string_append_printf(xpm, "%*d", cpp, entry);
+		}
+		g_string_append(xpm, "\",\n");
+	}
+	g_string_append(xpm, "};");
+
+	/* Caller must free char data */
+	return g_string_free(xpm, FALSE);
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index 1fbd68b..56ed255 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1644,3 +1644,4 @@ const unsigned char *stk_pdu_from_envelope(const stru=
ct stk_envelope *envelope,
 						unsigned int *out_length);
 char *stk_text_to_html(const char *text,
 				const unsigned short *attrs, int num_attrs);
+char *stk_image_to_xpm(const unsigned char *img, guint8 scheme);
-- =

1.6.6.1


--===============7913848975285444727==--

