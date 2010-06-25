Content-Type: multipart/mixed; boundary="===============6401508137103871651=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] stkutil: display text attributes as html
Date: Fri, 25 Jun 2010 02:10:11 +0200
Message-ID: <1277424611.2330.135.camel@localhost.localdomain>
In-Reply-To: <1277388032-13901-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6401508137103871651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

>  src/stkutil.c |  167 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/stkutil.h |   32 +++++++++++
>  2 files changed, 199 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index 6f072e7..73449e2 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -26,6 +26,7 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <stdint.h>
> +#include <stdio.h>
>  =

>  #include <glib.h>
>  =

> @@ -5819,3 +5820,169 @@ const unsigned char *stk_pdu_from_envelope(const =
struct stk_envelope *envelope,
>  =

>  	return pdu;
>  }
> +
> +static const char *html_colors[] =3D {
> +	"#000000", /* Black */
> +	"#808080", /* Dark Grey */
> +	"#C11B17", /* Dark Red */
> +	"#FBB117", /* Dark Yellow */
> +	"#347235", /* Dark Green */
> +	"#307D7E", /* Dark Cyan */
> +	"#0000A0", /* Dark Blue */
> +	"#C031C7", /* Dark Magenta */
> +	"#C0C0C0", /* Grey */
> +	"#FFFFFF", /* White */
> +	"#FF0000", /* Bright Red */
> +	"#FFFF00", /* Bright Yellow */
> +	"#00FF00", /* Bright Green */
> +	"#00FFFF", /* Bright Cyan */
> +	"#0000FF", /* Bright Blue */
> +	"#FF00FF", /* Bright Magenta */
> +};
> +
> +static void end_format(GString *string, guint8 code)
> +{
> +	g_string_append(string, "</span>");
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
> +	if (align !=3D STK_TEXT_FORMAT_NO_ALIGN)
> +		g_string_append(string, "<div style=3D\"");
> +
> +	if (align =3D=3D STK_TEXT_FORMAT_RIGHT_ALIGN)
> +		g_string_append(string, "text-align: right;\">");
> +	else if (align =3D=3D STK_TEXT_FORMAT_CENTER_ALIGN)
> +		g_string_append(string, "text-align: center;\">");
> +	else if (align =3D=3D STK_TEXT_FORMAT_LEFT_ALIGN)
> +		g_string_append(string, "text-align: left;\">");

using a switch {} statement seems more appropriate here.

> +
> +	/* font, style, and color are inline */
> +	g_string_append(string, "<span style=3D\"");
> +
> +	if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_LARGE)
> +		g_string_append(string, "font-size: big;");
> +	else if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_SMALL)
> +		g_string_append(string, "font-size: small;");

Same here. I prefer switch {} since it is more readable.

> +
> +	if (style =3D=3D STK_TEXT_FORMAT_STYLE_BOLD)
> +		g_string_append(string, "font-weight: bold;");
> +	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_ITALIC)
> +		g_string_append(string, "font-style: italic;");
> +	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_UNDERLINED)
> +		g_string_append(string, "text-decoration: underline;");
> +	else if (style =3D=3D STK_TEXT_FORMAT_STYLE_STRIKETHROUGH)
> +		g_string_append(string, "text-decoration: line-through;");

And also here please.

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
> +char *stk_text_to_html(char *text, int text_len,
> +				const unsigned char *attrs, int attrs_len)
> +{
> +	GString *string =3D g_string_sized_new(text_len + 1);
> +	gint formats[257];  /* maximum number of chars in text + 1 */
> +	int pos =3D 0, attr, i, j, prev_attr;
> +	guint8 start, end, code, color, len, align;
> +
> +	/* we will need formatting at the position beyond the last char */
> +	for (i =3D 0; i <=3D text_len; i++)
> +		formats[i] =3D STK_TEXT_FORMAT_INIT;
> +
> +	i =3D 0;
> +
> +	while (i < attrs_len) {
> +		start =3D attrs[i++];
> +		len =3D attrs[i++];
> +		code =3D attrs[i++];
> +
> +		if (i < attrs_len)
> +			color =3D attrs[i++];
> +		else
> +			color =3D 0;
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
> +			align =3D get_align(formats[start - 1]);
> +			if (align =3D=3D STK_TEXT_FORMAT_NO_ALIGN)
> +				align =3D STK_DEFAULT_TEXT_ALIGNMENT;
> +		}
> +
> +		if ((code & STK_TEXT_FORMAT_ALIGN_MASK) =3D=3D align)
> +			code |=3D STK_TEXT_FORMAT_NO_ALIGN;
> +
> +		attr =3D make_attr(start, code, color);
> +
> +		for (j =3D start; j < end; j++)
> +			formats[j] =3D attr;
> +	}
> +
> +	prev_attr =3D STK_TEXT_FORMAT_INIT;
> +
> +	while (pos <=3D text_len) {
> +		attr =3D formats[pos];
> +		if (attr !=3D prev_attr) {
> +			if (prev_attr !=3D STK_TEXT_FORMAT_INIT)
> +				end_format(string, get_code(attr));
> +
> +			if (attr !=3D STK_TEXT_FORMAT_INIT)
> +				start_format(string, get_code(attr),
> +						get_color(attr));
> +
> +			prev_attr =3D attr;
> +		}
> +
> +		if (pos =3D=3D text_len)
> +			break;
> +
> +		if (text[pos] =3D=3D '\n')
> +			g_string_append(string, "<br/>");
> +		else if (text[pos] =3D=3D '\r') {
> +			g_string_append(string, "<br/>");
> +			if ((pos + 1 < text_len) && (text[pos + 1] =3D=3D '\n'))
> +				pos++;
> +		} else if (text[pos] =3D=3D '<')
> +			g_string_append(string, "&lt;");
> +		else if (text[pos] =3D=3D '>')
> +			g_string_append(string, "&gt;");
> +		else if (text[pos] =3D=3D '&')
> +			g_string_append(string, "&amp;");
> +		else
> +			g_string_append_c(string, text[pos]);

Also this one is better done as a switch {} statement. It becomes way
more easier to read that way.

> +		pos++;
> +	}
> +
> +	/* return characters from string. Caller must free char data */
> +	return g_string_free(string, FALSE);
> +}
> diff --git a/src/stkutil.h b/src/stkutil.h
> index ca4817e..fbdbc21 100644
> --- a/src/stkutil.h
> +++ b/src/stkutil.h
> @@ -1635,6 +1635,36 @@ struct stk_envelope {
>  	};
>  };
>  =

> +#define STK_TEXT_FORMAT_ALIGN_MASK 0x03
> +#define STK_TEXT_FORMAT_FONT_MASK 0x0C
> +#define STK_TEXT_FORMAT_STYLE_MASK 0xF0
> +#define STK_DEFAULT_TEXT_ALIGNMENT 0x00
> +#define STK_TEXT_FORMAT_INIT -1
> +
> +#define get_code(attr) \
> +	((attr >> 16) & 0xFF)
> +#define get_align(attr) \
> +	((attr >> 16) & STK_TEXT_FORMAT_ALIGN_MASK)
> +#define get_color(attr) \
> +	((attr >> 24) & 0xFF)
> +#define make_attr(start, code, color) \
> +	(start | (code << 16) | (color << 24))

Please put these defines inside the C file right before the function
where you actually use them. Not namespaced defines in a header file are
a bad idea.

Also do we have that many users of these defines that it makes sense to
create defines for it. They all lock pretty simple anyway. And in case
of 1 or 2 users, then sometimes it is better to just put a comment there
and repeat the code. I haven't actually counted.

Regards

Marcel



--===============6401508137103871651==--

