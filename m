Content-Type: multipart/mixed; boundary="===============4806660680132755630=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] stkutil: convert text attributes to html
Date: Mon, 14 Jun 2010 08:19:51 -0700
Message-ID: <1276528791-11458-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4806660680132755630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  203 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   21 ++++++
 2 files changed, 224 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 8ac1dba..dbcb6ac 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4307,3 +4307,206 @@ const unsigned char *stk_pdu_from_envelope(const st=
ruct stk_envelope *envelope,
 =

 	return pdu;
 }
+
+static GString *mapColourToHtml(GString *string, guint8 colour)
+{
+	GString *result =3D string;
+	int fg =3D colour & 0x0f;
+	int bg =3D (colour >> 4) & 0x0f;
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
+	if (colour =3D=3D 0)
+		return string;
+
+	if (fg) {
+		result =3D g_string_append(result, "color: ");
+		result =3D g_string_append(result, html_colors[fg]);
+		result =3D g_string_append_c(result, ';');
+	}
+	if (bg) {
+		result =3D g_string_append(result, "background-color: ");
+		result =3D g_string_append(result, html_colors[bg]);
+		result =3D g_string_append_c(result, ';');
+	}
+
+
+	return result;
+}
+
+static GString *endFormat(GString *string)
+{
+	return g_string_append(string, "</p>");
+}
+
+static GString *mapFormatToHtml(GString *string, guint8 code, guint8 colou=
r)
+{
+	GString *result =3D string;
+	guint8 align =3D code & STK_TEXT_FORMAT_ALIGN_MASK;
+	guint8 font =3D code & STK_TEXT_FORMAT_FONT_MASK;
+	guint8 style =3D code & STK_TEXT_FORMAT_STYLE_MASK;
+
+	/* formatting applies to a block of test */
+	result =3D g_string_append(result, "<p style=3D\"");
+
+	if (align =3D=3D STK_TEXT_FORMAT_RIGHT_ALIGN)
+		result =3D g_string_append(result, "text-align: right;");
+	else if (align =3D=3D STK_TEXT_FORMAT_CENTER_ALIGN)
+		result =3D g_string_append(result, "text-align: center;");
+	else if (align =3D=3D STK_TEXT_FORMAT_LEFT_ALIGN)
+		result =3D g_string_append(result, "text-align: left;");
+
+	if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_LARGE)
+		result =3D g_string_append(result, "font-size: big;");
+	else if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_SMALL)
+		result =3D g_string_append(result, "font-size: small;");
+
+	if (style =3D=3D STK_TEXT_FORMAT_STYLE_BOLD)
+		result =3D g_string_append(result, "font-weight: bold;");
+	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_ITALIC)
+		result =3D g_string_append(result, "font-style: italic;");
+	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_UNDERLINED)
+		result =3D g_string_append(result, "text-decoration: underline;");
+	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_STRIKETHROUGH)
+		result =3D g_string_append(result,
+					"text-decoration: line-through;");
+
+	/* add any color */
+	result =3D mapColourToHtml(result, colour);
+
+	result =3D g_string_append(result, "\">");
+
+	return result;
+}
+
+static gboolean isSpecialChar(char c)
+{
+	return (c =3D=3D '\n' || c =3D=3D '\r' || c =3D=3D '<' || c =3D=3D '>' ||=
 c =3D=3D '&');
+}
+
+static gboolean mapCharToHtml(char *s, int pos, int len,
+			GString **string)
+{
+	gboolean rval =3D FALSE;
+	GString *result =3D *string;
+	unsigned char c =3D s[pos];
+
+	switch (c) {
+		case '\n':
+			result =3D g_string_append(result, "<br>");
+			break;
+		case '\r':
+			result =3D g_string_append(result, "<br>");
+			if ((pos + 1 < len) && (s[pos + 1] =3D=3D '\n'))
+				rval =3D TRUE;
+			break;
+		case '<':
+			result =3D g_string_append(result, "&lt;");
+			break;
+		case '>':
+			result =3D g_string_append(result, "&gt;");
+			break;
+		case '&':
+			result =3D g_string_append(result, "&amp;");
+			break;
+	}
+	*string =3D result;
+	return rval;
+}
+
+static GString *copyText(GString *string, char *text,
+				int *start_pos, int start, int end)
+{
+	GString *result =3D string;
+	int pos =3D *start_pos;
+
+	while (pos < start && pos < end) {
+		if (isSpecialChar(text[pos])) {
+			if (mapCharToHtml(text, pos, end, &result) =3D=3D TRUE)
+				pos++;
+		}
+		else
+			result =3D g_string_append_c(result, text[pos]);
+		pos++;
+	}
+	*start_pos =3D pos;
+	return result;
+}
+
+static int extractFormat(const unsigned char *attrs, int index, int attrs_=
len,
+				int text_len, guint8 *start,
+				guint8 *end, guint8 *code, guint8 *colour)
+{
+	int i =3D index;
+
+	/* If there are no more attributes, initialize to default values */
+	if (i >=3D attrs_len) {
+		*start =3D text_len;
+		*end =3D text_len;
+		*code =3D 0;
+		*colour =3D 0;
+		return i;
+	}
+
+	*start =3D attrs[i++];
+	*end =3D attrs[i++];
+	*code =3D attrs[i++];
+
+	if (i < attrs_len)
+		*colour =3D attrs[i++];
+	else
+		*colour =3D 0;
+
+	if (*end =3D=3D 0)
+		*end =3D text_len;
+
+	return i;
+}
+
+char *textToHtml(char *text, int text_len,
+				const unsigned char *attrs, int attrs_len)
+{
+	GString *result =3D g_string_new(NULL);
+	guint8 start, end, code, colour;
+	int pos =3D 0;
+	int i =3D 0;
+
+	while (pos < text_len) {
+		/* check for an attribute */
+		i =3D extractFormat(attrs, i, attrs_len, text_len, &start,
+					&end, &code, &colour);
+
+		/* insert any non-formatted text */
+		result =3D copyText(result, text, &pos, start, text_len);
+		if (pos >=3D text_len)
+			break;
+
+		/* start formatting */
+		result =3D mapFormatToHtml(result, code, colour);
+
+		/* insert formatted text */
+		result =3D copyText(result, text, &pos, end, text_len);
+
+		/* end formatting */
+		result =3D endFormat(result);
+	}
+
+	/* return characters from result. Caller must free char data */
+	return g_string_free(result, FALSE);
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index 2da787d..2c78382 100644
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
+char *textToHtml(char *text, int text_len,
+				const unsigned char *attrs, int attrs_len);
-- =

1.6.6.1


--===============4806660680132755630==--

