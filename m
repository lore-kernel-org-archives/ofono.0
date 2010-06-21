Content-Type: multipart/mixed; boundary="===============8959389769624584308=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/2] stkutil: convert text attributes to html
Date: Mon, 21 Jun 2010 06:06:41 -0700
Message-ID: <1277125602-3996-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277125602-3996-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8959389769624584308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  165 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   22 ++++++++
 2 files changed, 187 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 642081e..1c8bac9 100644
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

@@ -5978,3 +5979,167 @@ const unsigned char *stk_pdu_from_envelope(const st=
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
+	if (align =3D=3D STK_TEXT_FORMAT_RIGHT_ALIGN)
+		g_string_append(string, "text-align: right;\">");
+	else if (align =3D=3D STK_TEXT_FORMAT_CENTER_ALIGN)
+		g_string_append(string, "text-align: center;\">");
+	else if (align =3D=3D STK_TEXT_FORMAT_LEFT_ALIGN)
+		g_string_append(string, "text-align: left;\">");
+
+	/* font, style, and color are inline */
+	g_string_append(string, "<span style=3D\"");
+
+	if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_LARGE)
+		g_string_append(string, "font-size: big;");
+	else if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_SMALL)
+		g_string_append(string, "font-size: small;");
+
+	if (style =3D=3D STK_TEXT_FORMAT_STYLE_BOLD)
+		g_string_append(string, "font-weight: bold;");
+	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_ITALIC)
+		g_string_append(string, "font-style: italic;");
+	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_UNDERLINED)
+		g_string_append(string, "text-decoration: underline;");
+	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_STRIKETHROUGH)
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
+char *stk_text_to_html(char *text, int text_len,
+				const unsigned char *attrs, int attrs_len)
+{
+	GString *string =3D g_string_sized_new(text_len + 1);
+	GQueue formats[241];  /* maximum number of chars in text + 1 */
+	int pos =3D 0, attr, i;
+	guint8 start, end, code, color, len;
+	guint8 align =3D STK_DEFAULT_TEXT_ALIGNMENT; /* hardcoded to left */
+
+	/* we may need formatting at the position beyond the last char */
+	for (i =3D 0; i <=3D text_len; i++)
+		g_queue_init(&formats[i]);
+
+	i =3D 0;
+
+	/*
+	 * each position in the text may have multiple attributes.
+	 * store each attribute in a queue for that position in the
+	 * order in which it was sent.  This will cause the last
+	 * attribute sent for that position to take priority.
+	 */
+	while (i < attrs_len) {
+		/* TBD - check for bad values */
+		start =3D attrs[i++];
+		len =3D attrs[i++];
+		code =3D attrs[i++];
+
+		/*
+		 * if the alignment is the same as either the default
+		 * or the last alignment used, don't set any alignment
+		 * value.
+		 */
+		if ((code & STK_TEXT_FORMAT_ALIGN_MASK) =3D=3D align)
+			code |=3D 0x3;
+		else
+			align =3D code & STK_TEXT_FORMAT_ALIGN_MASK;
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
+		attr =3D start | (code << 16) | (color << 24);
+
+		g_queue_push_tail(&formats[start], GINT_TO_POINTER(attr));
+		g_queue_push_tail(&formats[end], GINT_TO_POINTER(attr));
+	}
+
+	while (pos <=3D text_len) {
+		GQueue *q =3D &formats[pos];
+
+		/* there may be multiple formats per position */
+		while ((attr =3D GPOINTER_TO_INT(g_queue_pop_head(q)))) {
+			start =3D attr & 0xff;
+			code =3D attr >> 16 & 0xff;
+			color =3D attr >> 24 & 0xff;
+
+			if (pos =3D=3D start)
+				start_format(string, code, color);
+			else
+				end_format(string, code);
+		}
+
+		if (pos =3D=3D text_len)
+			break;
+
+		if (text[pos] =3D=3D '\n')
+			g_string_append(string, "<br/>");
+		else if (text[pos] =3D=3D '\r') {
+			g_string_append(string, "<br/>");
+			if ((pos + 1 < text_len) && (text[pos + 1] =3D=3D '\n'))
+				pos++;
+		} else if (text[pos] =3D=3D '<')
+			g_string_append(string, "&lt;");
+		else if (text[pos] =3D=3D '>')
+			g_string_append(string, "&gt;");
+		else if (text[pos] =3D=3D '&')
+			g_string_append(string, "&amp;");
+		else
+			g_string_append_c(string, text[pos]);
+		pos++;
+	}
+
+	/* return characters from string. Caller must free char data */
+	return g_string_free(string, FALSE);
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index ea0f77a..50e594d 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -557,6 +557,26 @@ enum stk_me_status {
 	STK_ME_STATUS_NOT_IDLE =3D 	0x01
 };
 =

+#define STK_TEXT_FORMAT_ALIGN_MASK 0x03
+#define STK_TEXT_FORMAT_FONT_MASK 0x0C
+#define STK_TEXT_FORMAT_STYLE_MASK 0xF0
+#define STK_DEFAULT_TEXT_ALIGNMENT 0x00
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
@@ -1635,3 +1655,5 @@ const unsigned char *stk_pdu_from_response(const stru=
ct stk_response *response,
 						unsigned int *out_length);
 const unsigned char *stk_pdu_from_envelope(const struct stk_envelope *enve=
lope,
 						unsigned int *out_length);
+char *stk_text_to_html(char *text, int text_len,
+				const unsigned char *attrs, int attrs_len);
-- =

1.6.6.1


--===============8959389769624584308==--

