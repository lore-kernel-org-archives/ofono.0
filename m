Content-Type: multipart/mixed; boundary="===============4969108293623520390=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/9] stkutil: display text attributes as html
Date: Thu, 08 Jul 2010 17:49:56 -0500
Message-ID: <4C365614.3000105@gmail.com>
In-Reply-To: <1278078368-32565-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4969108293623520390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> +/* Defined in ETSI 123 40 9.2.3.24.10.1.1 */
> +enum stk_text_format_code {
> +	STK_TEXT_FORMAT_LEFT_ALIGN =3D 0x00,
> +	STK_TEXT_FORMAT_CENTER_ALIGN =3D 0x01,
> +	STK_TEXT_FORMAT_RIGHT_ALIGN =3D 0x02,
> +	STK_TEXT_FORMAT_NO_ALIGN =3D 0x03,
> +	STK_TEXT_FORMAT_FONT_SIZE_LARGE =3D 0x04,
> +	STK_TEXT_FORMAT_FONT_SIZE_SMALL =3D 0x08,
> +	STK_TEXT_FORMAT_FONT_SIZE_RESERVED =3D 0x0c,
> +	STK_TEXT_FORMAT_STYLE_BOLD =3D 0x10,
> +	STK_TEXT_FORMAT_STYLE_ITALIC =3D 0x20,
> +	STK_TEXT_FORMAT_STYLE_UNDERLINED =3D 0x40,
> +	STK_TEXT_FORMAT_STYLE_STRIKETHROUGH =3D 0x80,
> +};
> +
> +

Why the extra line?

> +static void end_format(GString *string, guint8 code, guint8 color)
> +{
> +	if ((code & ~STK_TEXT_FORMAT_ALIGN_MASK) || color)
> +		g_string_append(string, "</span>");
> +
> +	if ((code & STK_TEXT_FORMAT_ALIGN_MASK) !=3D STK_TEXT_FORMAT_NO_ALIGN)
> +		g_string_append(string, "</div>");
> +}
> +
> +static void start_format(GString *string, guint8 code, guint8 color)
> +{
> +	guint8 align =3D code & STK_TEXT_FORMAT_ALIGN_MASK;
> +	guint8 font =3D code & STK_TEXT_FORMAT_FONT_MASK;
> +	guint8 style =3D code & STK_TEXT_FORMAT_STYLE_MASK;
> +	int fg =3D color & 0x0f;
> +	int bg =3D (color >> 4) & 0x0f;
> +
> +	/* align formatting applies to a block of test */

Did you mean 'block of text' here?

> +	if (align !=3D STK_TEXT_FORMAT_NO_ALIGN)
> +		g_string_append(string, "<div style=3D\"");
> +
> +	switch (align) {
> +	case STK_TEXT_FORMAT_RIGHT_ALIGN:
> +		g_string_append(string, "text-align: right;\">");
> +		break;
> +	case STK_TEXT_FORMAT_CENTER_ALIGN:
> +		g_string_append(string, "text-align: center;\">");
> +		break;
> +	case STK_TEXT_FORMAT_LEFT_ALIGN:
> +		g_string_append(string, "text-align: left;\">");
> +		break;
> +	}
> +
> +	if (((code & ~STK_TEXT_FORMAT_ALIGN_MASK) =3D=3D 0) && (color =3D=3D 0))
> +		return;
> +

I really prefer font =3D=3D 0 && style =3D=3D 0 && color =3D=3D 0 here.

> +	/* font, style, and color are inline */
> +	g_string_append(string, "<span style=3D\"");
> +
> +	switch (font) {
> +	case STK_TEXT_FORMAT_FONT_SIZE_LARGE:
> +		g_string_append(string, "font-size: big;");
> +		break;
> +	case STK_TEXT_FORMAT_FONT_SIZE_SMALL:
> +		g_string_append(string, "font-size: small;");
> +		break;
> +	}
> +
> +	switch (style) {
> +	case STK_TEXT_FORMAT_STYLE_BOLD:
> +		g_string_append(string, "font-weight: bold;");
> +		break;
> +	case STK_TEXT_FORMAT_STYLE_ITALIC:
> +		g_string_append(string, "font-style: italic;");
> +		break;
> +	case STK_TEXT_FORMAT_STYLE_UNDERLINED:
> +		g_string_append(string, "text-decoration: underline;");
> +		break;
> +	case STK_TEXT_FORMAT_STYLE_STRIKETHROUGH:
> +		g_string_append(string, "text-decoration: line-through;");
> +		break;
> +	}

Please note that text format is actually a bitmask, not a single
selector.  So switch/case here is inappropriate.  Maybe you got confused
by some earlier feedback... :)

> +
> +	/* add any color */
> +	if (fg)
> +		g_string_append_printf(string, "color: %s;", html_colors[fg]);
> +	if (bg)
> +		g_string_append_printf(string, "background-color: %s;",
> +						html_colors[bg]);
> +	g_string_append(string, "\">");
> +}
> +
> +char *stk_text_to_html(const char *utf8,
> +				const unsigned short *attrs, int num_attrs)
> +{
> +	long text_len =3D g_utf8_strlen(utf8, -1);
> +	GString *string =3D g_string_sized_new(strlen(utf8) + 1);
> +	short *formats;
> +	int pos, i, j;
> +	guint16 start, end, len, attr, prev_attr;
> +	guint8 code, color, align;
> +	const char *text =3D utf8;
> +	int attrs_len =3D num_attrs * 4;
> +
> +	formats =3D g_try_malloc0(sizeof(gint16) * (text_len + 1));

Please use g_try_new0 here, it is a bit more readable.

> +	if (formats =3D=3D NULL)
> +		return NULL;

You're leaking the GString here.

> +
> +	/* we will need formatting at the position beyond the last char */
> +	for (i =3D 0; i <=3D text_len; i++)
> +		formats[i] =3D STK_TEXT_FORMAT_INIT;
> +
> +	for (i =3D 0; i < attrs_len; i +=3D 4) {
> +		start =3D attrs[i];
> +		len =3D attrs[i + 1];
> +		code =3D attrs[i + 2] & 0xFF;
> +		color =3D attrs[i + 3] & 0xFF;
> +
> +		if (len =3D=3D 0)
> +			end =3D text_len;
> +		else
> +			end =3D start + len;
> +
> +		/* sanity check values */
> +		if (start > end || end > text_len)
> +			continue;
> +
> +		/*
> +		 * if the alignment is the same as either the default
> +		 * or the last alignment used, don't set any alignment
> +		 * value.
> +		 */
> +		if (start =3D=3D 0)
> +			align =3D STK_DEFAULT_TEXT_ALIGNMENT;
> +		else {
> +			align =3D (formats[start - 1] & 0xFF) &
> +					STK_TEXT_FORMAT_ALIGN_MASK;
> +			if (align =3D=3D STK_TEXT_FORMAT_NO_ALIGN)
> +				align =3D STK_DEFAULT_TEXT_ALIGNMENT;
> +		}
> +
> +		if ((code & STK_TEXT_FORMAT_ALIGN_MASK) =3D=3D align)
> +			code |=3D STK_TEXT_FORMAT_NO_ALIGN;
> +

So I think the above code is actually incorrect.  The spec talks about
Language dependent (default) alignment being equal to
STK_DEFAULT_TEXT_ALIGNMENT.  So if the SIM sends us a Left aligned
attribute, it really means Left aligned.

Maybe something like this is enough?

if (start =3D=3D 0)
	align =3D STK_TEXT_FORMAT_NO_ALIGN;
else
	align =3D formats[start - 1] & STK_TEXT_FORMAT_ALIGN_MASK;

Also, it would seem STK_TEXT_FORMAT_INIT should be set to 0x9003.  Black
foreground, white background, unaligned, unformatted.

> +		attr =3D code | (color << 8);
> +
> +		for (j =3D start; j < end; j++)
> +			formats[j] =3D attr;
> +	}
> +
> +	prev_attr =3D STK_TEXT_FORMAT_INIT;
> +
> +	for (pos =3D 0; pos <=3D text_len; pos++) {
> +		attr =3D formats[pos];
> +		if (attr !=3D prev_attr) {
> +			if (prev_attr !=3D STK_TEXT_FORMAT_INIT)
> +				end_format(string, prev_attr & 0xFF,
> +							(attr >> 8) & 0xFF);

Is the 3rd argument above really supposed to be attr >> 8?

Probably be more easier if end_format & start_format took the short
value instead of bitshifting everywhere.

> +
> +			if (attr !=3D STK_TEXT_FORMAT_INIT)
> +				start_format(string, attr & 0xFF,
> +							(attr >> 8) & 0xFF);
> +
> +			prev_attr =3D attr;
> +		}
> +
> +		if (pos =3D=3D text_len)
> +			break;
> +
> +		switch (g_utf8_get_char(text)) {
> +		case '\n':
> +			g_string_append(string, "<br/>");
> +			break;
> +		case '\r':
> +		{
> +			char *next =3D g_utf8_next_char(text);
> +			gunichar c =3D g_utf8_get_char(next);
> +
> +			g_string_append(string, "<br/>");
> +
> +			if ((pos + 1 < text_len) && (c =3D=3D '\n')) {
> +				text =3D g_utf8_next_char(text);
> +				pos++;
> +			}
> +			break;
> +		}
> +		case '<':
> +			g_string_append(string, "&lt;");
> +			break;
> +		case '>':
> +			g_string_append(string, "&gt;");
> +			break;
> +		case '&':
> +			g_string_append(string, "&amp;");
> +			break;
> +		default:
> +			g_string_append_unichar(string, g_utf8_get_char(text));
> +		}
> +
> +		text =3D g_utf8_next_char(text);
> +	}
> +
> +	g_free(formats);
> +
> +	/* return characters from string. Caller must free char data */
> +	return g_string_free(string, FALSE);
> +}

Regards,
-Denis

--===============4969108293623520390==--

