Content-Type: multipart/mixed; boundary="===============6348010857544882149=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/9] stkutil: display text attributes as html
Date: Tue, 13 Jul 2010 05:40:47 -0700
Message-ID: <1279024855-10586-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1279024855-10586-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6348010857544882149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  225 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |    2 +
 2 files changed, 227 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c45f985..522021c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -5853,3 +5853,228 @@ const unsigned char *stk_pdu_from_envelope(const st=
ruct stk_envelope *envelope,
 =

 	return pdu;
 }
+
+static const char *html_colors[] =3D {
+	"#000000", /* Black */
+	"#808080", /* Dark Grey */
+	"#C11B17", /* Dark Red */
+	"#FBB117", /* Dark Yellow */
+	"#347235", /* Dark Green */
+	"#307D7E", /* Dark Cyan */
+	"#0000A0", /* Dark Blue */
+	"#C031C7", /* Dark Magenta */
+	"#C0C0C0", /* Grey */
+	"#FFFFFF", /* White */
+	"#FF0000", /* Bright Red */
+	"#FFFF00", /* Bright Yellow */
+	"#00FF00", /* Bright Green */
+	"#00FFFF", /* Bright Cyan */
+	"#0000FF", /* Bright Blue */
+	"#FF00FF", /* Bright Magenta */
+};
+
+#define STK_TEXT_FORMAT_ALIGN_MASK 0x03
+#define STK_TEXT_FORMAT_FONT_MASK 0x0C
+#define STK_TEXT_FORMAT_STYLE_MASK 0xF0
+#define STK_DEFAULT_TEXT_ALIGNMENT 0x00
+#define STK_TEXT_FORMAT_INIT 0x9003
+
+/* Defined in ETSI 123 40 9.2.3.24.10.1.1 */
+enum stk_text_format_code {
+	STK_TEXT_FORMAT_LEFT_ALIGN =3D 0x00,
+	STK_TEXT_FORMAT_CENTER_ALIGN =3D 0x01,
+	STK_TEXT_FORMAT_RIGHT_ALIGN =3D 0x02,
+	STK_TEXT_FORMAT_NO_ALIGN =3D 0x03,
+	STK_TEXT_FORMAT_FONT_SIZE_LARGE =3D 0x04,
+	STK_TEXT_FORMAT_FONT_SIZE_SMALL =3D 0x08,
+	STK_TEXT_FORMAT_FONT_SIZE_RESERVED =3D 0x0c,
+	STK_TEXT_FORMAT_STYLE_BOLD =3D 0x10,
+	STK_TEXT_FORMAT_STYLE_ITALIC =3D 0x20,
+	STK_TEXT_FORMAT_STYLE_UNDERLINED =3D 0x40,
+	STK_TEXT_FORMAT_STYLE_STRIKETHROUGH =3D 0x80,
+};
+
+static void end_format(GString *string, guint16 attr)
+{
+	guint code =3D attr & 0xFF;
+	guint color =3D (attr >> 8) & 0xFF;
+
+	if ((code & ~STK_TEXT_FORMAT_ALIGN_MASK) || color)
+		g_string_append(string, "</span>");
+
+	if ((code & STK_TEXT_FORMAT_ALIGN_MASK) !=3D STK_TEXT_FORMAT_NO_ALIGN)
+		g_string_append(string, "</div>");
+}
+
+static void start_format(GString *string, guint16 attr)
+{
+	guint8 code =3D attr & 0xFF;
+	guint8 color =3D (attr >> 8) & 0xFF;
+	guint8 align =3D code & STK_TEXT_FORMAT_ALIGN_MASK;
+	guint8 font =3D code & STK_TEXT_FORMAT_FONT_MASK;
+	guint8 style =3D code & STK_TEXT_FORMAT_STYLE_MASK;
+	int fg =3D color & 0x0f;
+	int bg =3D (color >> 4) & 0x0f;
+
+	/* align formatting applies to a block of text */
+	if (align !=3D STK_TEXT_FORMAT_NO_ALIGN)
+		g_string_append(string, "<div style=3D\"");
+
+	switch (align) {
+	case STK_TEXT_FORMAT_RIGHT_ALIGN:
+		g_string_append(string, "text-align: right;\">");
+		break;
+	case STK_TEXT_FORMAT_CENTER_ALIGN:
+		g_string_append(string, "text-align: center;\">");
+		break;
+	case STK_TEXT_FORMAT_LEFT_ALIGN:
+		g_string_append(string, "text-align: left;\">");
+		break;
+	}
+
+	if ((font =3D=3D 0) && (style =3D=3D 0) && (color =3D=3D 0))
+		return;
+
+	/* font, style, and color are inline */
+	g_string_append(string, "<span style=3D\"");
+
+	switch (font) {
+	case STK_TEXT_FORMAT_FONT_SIZE_LARGE:
+		g_string_append(string, "font-size: big;");
+		break;
+	case STK_TEXT_FORMAT_FONT_SIZE_SMALL:
+		g_string_append(string, "font-size: small;");
+		break;
+	}
+
+	if (style & STK_TEXT_FORMAT_STYLE_BOLD)
+		g_string_append(string, "font-weight: bold;");
+	if (style & STK_TEXT_FORMAT_STYLE_ITALIC)
+		g_string_append(string, "font-style: italic;");
+	if (style & STK_TEXT_FORMAT_STYLE_UNDERLINED)
+		g_string_append(string, "text-decoration: underline;");
+	if (style & STK_TEXT_FORMAT_STYLE_STRIKETHROUGH)
+		g_string_append(string, "text-decoration: line-through;");
+
+	/* add any color */
+	if (fg)
+		g_string_append_printf(string, "color: %s;", html_colors[fg]);
+	if (bg)
+		g_string_append_printf(string, "background-color: %s;",
+						html_colors[bg]);
+	g_string_append(string, "\">");
+}
+
+char *stk_text_to_html(const char *utf8,
+				const unsigned short *attrs, int num_attrs)
+{
+	long text_len =3D g_utf8_strlen(utf8, -1);
+	GString *string =3D g_string_sized_new(strlen(utf8) + 1);
+	short *formats;
+	int pos, i, j;
+	guint16 start, end, len, attr, prev_attr;
+	guint8 code, color, align;
+	const char *text =3D utf8;
+	int attrs_len =3D num_attrs * 4;
+
+	formats =3D g_try_new0(gint16, (text_len + 1));
+	if (formats =3D=3D NULL) {
+		g_string_free(string, TRUE);
+		return NULL;
+	}
+
+	/* we will need formatting at the position beyond the last char */
+	for (i =3D 0; i <=3D text_len; i++)
+		formats[i] =3D STK_TEXT_FORMAT_INIT;
+
+	for (i =3D 0; i < attrs_len; i +=3D 4) {
+		start =3D attrs[i];
+		len =3D attrs[i + 1];
+		code =3D attrs[i + 2] & 0xFF;
+		color =3D attrs[i + 3] & 0xFF;
+
+		if (len =3D=3D 0)
+			end =3D text_len;
+		else
+			end =3D start + len;
+
+		/* sanity check values */
+		if (start > end || end > text_len)
+			continue;
+
+		/*
+		 * if the alignment is the same as either the default
+		 * or the last alignment used, don't set any alignment
+		 * value.
+		 */
+		if (start =3D=3D 0)
+			align =3D STK_TEXT_FORMAT_NO_ALIGN;
+		else {
+			align =3D formats[start - 1] &
+					STK_TEXT_FORMAT_ALIGN_MASK;
+		}
+
+		if ((code & STK_TEXT_FORMAT_ALIGN_MASK) =3D=3D align)
+			code |=3D STK_TEXT_FORMAT_NO_ALIGN;
+
+		attr =3D code | (color << 8);
+
+		for (j =3D start; j < end; j++)
+			formats[j] =3D attr;
+	}
+
+	prev_attr =3D STK_TEXT_FORMAT_INIT;
+
+	for (pos =3D 0; pos <=3D text_len; pos++) {
+		attr =3D formats[pos];
+		if (attr !=3D prev_attr) {
+			if (prev_attr !=3D STK_TEXT_FORMAT_INIT)
+				end_format(string, prev_attr);
+
+			if (attr !=3D STK_TEXT_FORMAT_INIT)
+				start_format(string, attr);
+
+			prev_attr =3D attr;
+		}
+
+		if (pos =3D=3D text_len)
+			break;
+
+		switch (g_utf8_get_char(text)) {
+		case '\n':
+			g_string_append(string, "<br/>");
+			break;
+		case '\r':
+		{
+			char *next =3D g_utf8_next_char(text);
+			gunichar c =3D g_utf8_get_char(next);
+
+			g_string_append(string, "<br/>");
+
+			if ((pos + 1 < text_len) && (c =3D=3D '\n')) {
+				text =3D g_utf8_next_char(text);
+				pos++;
+			}
+			break;
+		}
+		case '<':
+			g_string_append(string, "&lt;");
+			break;
+		case '>':
+			g_string_append(string, "&gt;");
+			break;
+		case '&':
+			g_string_append(string, "&amp;");
+			break;
+		default:
+			g_string_append_unichar(string, g_utf8_get_char(text));
+		}
+
+		text =3D g_utf8_next_char(text);
+	}
+
+	g_free(formats);
+
+	/* return characters from string. Caller must free char data */
+	return g_string_free(string, FALSE);
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index 978a229..1fbd68b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1642,3 +1642,5 @@ const unsigned char *stk_pdu_from_response(const stru=
ct stk_response *response,
 						unsigned int *out_length);
 const unsigned char *stk_pdu_from_envelope(const struct stk_envelope *enve=
lope,
 						unsigned int *out_length);
+char *stk_text_to_html(const char *text,
+				const unsigned short *attrs, int num_attrs);
-- =

1.6.6.1


--===============6348010857544882149==--

