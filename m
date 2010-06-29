Content-Type: multipart/mixed; boundary="===============4284009561964748743=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/3] stkutil: display text attributes as html
Date: Tue, 29 Jun 2010 04:22:12 -0700
Message-ID: <1277810534-25450-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277810534-25450-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4284009561964748743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  190 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   23 +++++++
 2 files changed, 213 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 6f072e7..843e06b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -5819,3 +5819,193 @@ const unsigned char *stk_pdu_from_envelope(const st=
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
+static void end_format(GString *string, guint8 code)
+{
+	g_string_append(string, "</span>");
+
+	if ((code & STK_TEXT_FORMAT_ALIGN_MASK) !=3D STK_TEXT_FORMAT_NO_ALIGN)
+		g_string_append(string, "</div>");
+}
+
+static void start_format(GString *string, guint8 code, guint8 color)
+{
+	guint8 align =3D code & STK_TEXT_FORMAT_ALIGN_MASK;
+	guint8 font =3D code & STK_TEXT_FORMAT_FONT_MASK;
+	guint8 style =3D code & STK_TEXT_FORMAT_STYLE_MASK;
+	int fg =3D color & 0x0f;
+	int bg =3D (color >> 4) & 0x0f;
+
+	/* align formatting applies to a block of test */
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
+	switch (style) {
+	case STK_TEXT_FORMAT_STYLE_BOLD:
+		g_string_append(string, "font-weight: bold;");
+		break;
+	case STK_TEXT_FORMAT_STYLE_ITALIC:
+		g_string_append(string, "font-style: italic;");
+		break;
+	case STK_TEXT_FORMAT_STYLE_UNDERLINED:
+		g_string_append(string, "text-decoration: underline;");
+		break;
+	case STK_TEXT_FORMAT_STYLE_STRIKETHROUGH:
+		g_string_append(string, "text-decoration: line-through;");
+		break;
+	}
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
+char *stk_text_to_html(char *text, int text_len,
+				const unsigned char *attrs, int attrs_len)
+{
+	GString *string =3D g_string_sized_new(text_len + 1);
+	int formats[257];  /* maximum number of chars in text + 1 */
+	int pos =3D 0, i, j, attr, prev_attr;
+	guint8 start, end, code, color, len, align;
+
+	/* we will need formatting at the position beyond the last char */
+	for (i =3D 0; i <=3D text_len; i++)
+		formats[i] =3D STK_TEXT_FORMAT_INIT;
+
+	i =3D 0;
+
+	while (i < attrs_len) {
+		start =3D attrs[i++];
+		len =3D attrs[i++];
+		code =3D attrs[i++];
+
+		if (i < attrs_len)
+			color =3D attrs[i++];
+		else
+			color =3D 0;
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
+			align =3D STK_DEFAULT_TEXT_ALIGNMENT;
+		else {
+			align =3D (formats[start -1] & 0xFF) &
+					STK_TEXT_FORMAT_ALIGN_MASK;
+			if (align =3D=3D STK_TEXT_FORMAT_NO_ALIGN)
+				align =3D STK_DEFAULT_TEXT_ALIGNMENT;
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
+	while (pos <=3D text_len) {
+		attr =3D formats[pos];
+		if (attr !=3D prev_attr) {
+			if (prev_attr !=3D STK_TEXT_FORMAT_INIT)
+				end_format(string, prev_attr & 0xFF);
+
+			if (attr !=3D STK_TEXT_FORMAT_INIT)
+				start_format(string, attr & 0xFF,
+							(attr >> 8) & 0xFF);
+
+			prev_attr =3D attr;
+		}
+
+		if (pos =3D=3D text_len)
+			break;
+
+		switch (text[pos]) {
+		case '\n':
+			g_string_append(string, "<br/>");
+			break;
+		case '\r':
+		{
+			g_string_append(string, "<br/>");
+			if ((pos + 1 < text_len) && (text[pos + 1] =3D=3D '\n'))
+				pos++;
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
+			g_string_append_c(string, text[pos]);
+		}
+		pos++;
+	}
+
+	/* return characters from string. Caller must free char data */
+	return g_string_free(string, FALSE);
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index ca4817e..5b3a679 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1635,6 +1635,27 @@ struct stk_envelope {
 	};
 };
 =

+#define STK_TEXT_FORMAT_ALIGN_MASK 0x03
+#define STK_TEXT_FORMAT_FONT_MASK 0x0C
+#define STK_TEXT_FORMAT_STYLE_MASK 0xF0
+#define STK_DEFAULT_TEXT_ALIGNMENT 0x00
+#define STK_TEXT_FORMAT_INIT -1
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
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len);
 void stk_command_free(struct stk_command *command);
@@ -1643,3 +1664,5 @@ const unsigned char *stk_pdu_from_response(const stru=
ct stk_response *response,
 						unsigned int *out_length);
 const unsigned char *stk_pdu_from_envelope(const struct stk_envelope *enve=
lope,
 						unsigned int *out_length);
+char *stk_text_to_html(char *text, int text_len,
+				const unsigned char *attrs, int attrs_len);
-- =

1.6.6.1


--===============4284009561964748743==--

