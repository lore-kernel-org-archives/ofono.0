Content-Type: multipart/mixed; boundary="===============3263223449065589052=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] stkutil: convert text attributes to html
Date: Tue, 15 Jun 2010 16:32:32 -0700
Message-ID: <20100615163232.65ba3025@kcaccard-MOBL3>
In-Reply-To: <AANLkTilMtQ5XhZ8BXCGBQUYbR_sfD4X_n-jEvGzcy636@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3263223449065589052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From c9f4c7a0a605ef304e40ee6589f300469e7fc9f1 Mon Sep 17 00:00:00 2001
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Date: Mon, 14 Jun 2010 14:27:25 -0700
Subject: [PATCH] stkutil: convert text attribute to HTML

---
 src/stkutil.c |  195 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   21 ++++++
 2 files changed, 216 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 8ac1dba..6244d03 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4307,3 +4307,198 @@ const unsigned char *stk_pdu_from_envelope(const st=
ruct stk_envelope *envelope,
 =

 	return pdu;
 }
+
+static void map_color_to_html(GString *string, guint8 color)
+{
+	int fg =3D color & 0x0f;
+	int bg =3D (color >> 4) & 0x0f;
+	static const char *html_colors[] =3D {
+		"#000000", /* Black */
+		"#808080", /* Dark Grey */
+		"#C11B17", /* Dark Red */
+		"#FBB117", /* Dark Yellow */
+		"#347235", /* Dark Green */
+		"#307D7E", /* Dark Cyan */
+		"#0000A0", /* Dark Blue */
+		"#C031C7", /* Dark Magenta */
+		"#C0C0C0", /* Grey */
+		"#FFFFFF", /* White */
+		"#FF0000", /* Bright Red */
+		"#FFFF00", /* Bright Yellow */
+		"#00FF00", /* Bright Green */
+		"#00FFFF", /* Bright Cyan */
+		"#0000FF", /* Bright Blue */
+		"#FF00FF", /* Bright Magenta */
+	};
+
+	if (color =3D=3D 0)
+		return;
+
+	if (fg)
+		g_string_append_printf(string, "color: %s;", html_colors[fg]);
+	if (bg)
+		g_string_append_printf(string,
+				"background-color: %s;", html_colors[bg]);
+
+	return;
+}
+
+static void end_format(GString *string, guint8 code)
+{
+	g_string_append_printf(string, "</span>");
+
+	if ((code & STK_TEXT_FORMAT_ALIGN_MASK) !=3D STK_TEXT_FORMAT_NO_ALIGN)
+		g_string_append_printf(string, "</div>");
+}
+
+static void map_format_to_html(GString *string, guint8 code, guint8 color)
+{
+	guint8 align =3D code & STK_TEXT_FORMAT_ALIGN_MASK;
+	guint8 font =3D code & STK_TEXT_FORMAT_FONT_MASK;
+	guint8 style =3D code & STK_TEXT_FORMAT_STYLE_MASK;
+
+	/* align formatting applies to a block of test */
+	if (align !=3D STK_TEXT_FORMAT_NO_ALIGN)
+		g_string_append_printf(string, "<div style=3D\"");
+
+	if (align =3D=3D STK_TEXT_FORMAT_RIGHT_ALIGN)
+		g_string_append_printf(string, "text-align: right;>\"");
+	else if (align =3D=3D STK_TEXT_FORMAT_CENTER_ALIGN)
+		g_string_append_printf(string, "text-align: center;>\"");
+	else if (align =3D=3D STK_TEXT_FORMAT_LEFT_ALIGN)
+		g_string_append_printf(string, "text-align: left;>\"");
+
+	/* font, style, and color are inline */
+	g_string_append_printf(string, "<span style=3D\"");
+
+	if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_LARGE)
+		g_string_append_printf(string, "font-size: big;");
+	else if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_SMALL)
+		g_string_append_printf(string, "font-size: small;");
+
+	if (style =3D=3D STK_TEXT_FORMAT_STYLE_BOLD)
+		g_string_append_printf(string, "font-weight: bold;");
+	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_ITALIC)
+		g_string_append_printf(string, "font-style: italic;");
+	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_UNDERLINED)
+		g_string_append_printf(string, "text-decoration: underline;");
+	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_STRIKETHROUGH)
+		g_string_append_printf(string,
+					"text-decoration: line-through;");
+
+	/* add any color */
+	map_color_to_html(string, color);
+
+	g_string_append_printf(string, "\">");
+}
+
+static gboolean is_special_char(char c)
+{
+	return (c =3D=3D '\n' || c =3D=3D '\r' || c =3D=3D '<' || c =3D=3D '>' ||=
 c =3D=3D '&');
+}
+
+static gboolean map_char_to_html(char *s, int pos, int len, GString *strin=
g)
+{
+	gboolean rval =3D FALSE;
+	unsigned char c =3D s[pos];
+
+	switch (c) {
+		case '\n':
+			g_string_append_printf(string, "<br/>");
+			break;
+		case '\r':
+			g_string_append_printf(string, "<br/>");
+			if ((pos + 1 < len) && (s[pos + 1] =3D=3D '\n'))
+				rval =3D TRUE;
+			break;
+		case '<':
+			g_string_append_printf(string, "&lt;");
+			break;
+		case '>':
+			g_string_append_printf(string, "&gt;");
+			break;
+		case '&':
+			g_string_append_printf(string, "&amp;");
+			break;
+	}
+	return rval;
+}
+
+static void copy_text(GString *string, char *text,
+				int *start_pos, int start, int end)
+{
+	int pos =3D *start_pos;
+
+	while (pos < start && pos < end) {
+		if (is_special_char(text[pos])) {
+			if (map_char_to_html(text, pos, end, string) =3D=3D TRUE)
+				pos++;
+		}
+		else
+			g_string_append_printf(string, "%c", text[pos]);
+		pos++;
+	}
+	*start_pos =3D pos;
+}
+
+static int extract_format(const unsigned char *attrs, int index, int attrs=
_len,
+				int text_len, guint8 *start,
+				guint8 *end, guint8 *code, guint8 *color)
+{
+	int i =3D index;
+
+	/* If there are no more attributes, initialize to default values */
+	if (i >=3D attrs_len) {
+		*start =3D text_len;
+		*end =3D text_len;
+		*code =3D 0;
+		*color =3D 0;
+		return i;
+	}
+
+	*start =3D attrs[i++];
+	*end =3D attrs[i++];
+	*code =3D attrs[i++];
+
+	if (i < attrs_len)
+		*color =3D attrs[i++];
+	else
+		*color =3D 0;
+
+	if (*end =3D=3D 0)
+		*end =3D text_len;
+
+	return i;
+}
+
+char *text_to_html(char *text, int text_len,
+				const unsigned char *attrs, int attrs_len)
+{
+	GString *string =3D g_string_new(NULL);
+	guint8 start, end, code, color;
+	int pos =3D 0;
+	int i =3D 0;
+
+	while (pos < text_len) {
+		/* check for an attribute */
+		i =3D extract_format(attrs, i, attrs_len, text_len, &start,
+					&end, &code, &color);
+
+		/* insert any non-formatted text */
+		copy_text(string, text, &pos, start, text_len);
+		if (pos >=3D text_len)
+			break;
+
+		/* start formatting */
+		map_format_to_html(string, code, color);
+
+		/* insert formatted text */
+		copy_text(string, text, &pos, end, text_len);
+
+		/* end formatting */
+		end_format(string, code);
+	}
+
+	/* return characters from string. Caller must free char data */
+	return g_string_free(string, FALSE);
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index 2da787d..2b714dd 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -447,6 +447,25 @@ enum stk_broadcast_network_technology {
 	STK_BROADCAST_NETWORK_T_DMB =3D 0x03
 };
 =

+#define STK_TEXT_FORMAT_ALIGN_MASK 0x03
+#define STK_TEXT_FORMAT_FONT_MASK 0x0C
+#define STK_TEXT_FORMAT_STYLE_MASK 0xF0
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
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -1213,3 +1232,5 @@ const unsigned char *stk_pdu_from_response(const stru=
ct stk_response *response,
 						unsigned int *out_length);
 const unsigned char *stk_pdu_from_envelope(const struct stk_envelope *enve=
lope,
 						unsigned int *out_length);
+char *text_to_html(char *text, int text_len,
+				const unsigned char *attrs, int attrs_len);
-- =

1.6.6.1



--===============3263223449065589052==--

