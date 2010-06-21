Content-Type: multipart/mixed; boundary="===============8760270327043001739=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 1/2] stkutil: convert text attributes to html
Date: Tue, 22 Jun 2010 00:45:39 +0200
Message-ID: <AANLkTinZvOfO4tH1KWkCwob2aL4SLeIz_6N42BQlETpW@mail.gmail.com>
In-Reply-To: <1277125602-3996-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8760270327043001739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 21 June 2010 15:06, Kristen Carlson Accardi <kristen@linux.intel.com> =
wrote:
> ---
> =C2=A0src/stkutil.c | =C2=A0165 +++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A0src/stkutil.h | =C2=A0 22 ++++++++
> =C2=A02 files changed, 187 insertions(+), 0 deletions(-)
>
> diff --git a/src/stkutil.c b/src/stkutil.c
> index 642081e..1c8bac9 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -26,6 +26,7 @@
> =C2=A0#include <string.h>
> =C2=A0#include <stdlib.h>
> =C2=A0#include <stdint.h>
> +#include <stdio.h>
>
> =C2=A0#include <glib.h>
>
> @@ -5978,3 +5979,167 @@ const unsigned char *stk_pdu_from_envelope(const =
struct stk_envelope *envelope,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return pdu;
> =C2=A0}
> +
> +static const char *html_colors[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 "#000000", /* Black */
> + =C2=A0 =C2=A0 =C2=A0 "#808080", /* Dark Grey */
> + =C2=A0 =C2=A0 =C2=A0 "#C11B17", /* Dark Red */
> + =C2=A0 =C2=A0 =C2=A0 "#FBB117", /* Dark Yellow */
> + =C2=A0 =C2=A0 =C2=A0 "#347235", /* Dark Green */
> + =C2=A0 =C2=A0 =C2=A0 "#307D7E", /* Dark Cyan */
> + =C2=A0 =C2=A0 =C2=A0 "#0000A0", /* Dark Blue */
> + =C2=A0 =C2=A0 =C2=A0 "#C031C7", /* Dark Magenta */
> + =C2=A0 =C2=A0 =C2=A0 "#C0C0C0", /* Grey */
> + =C2=A0 =C2=A0 =C2=A0 "#FFFFFF", /* White */
> + =C2=A0 =C2=A0 =C2=A0 "#FF0000", /* Bright Red */
> + =C2=A0 =C2=A0 =C2=A0 "#FFFF00", /* Bright Yellow */
> + =C2=A0 =C2=A0 =C2=A0 "#00FF00", /* Bright Green */
> + =C2=A0 =C2=A0 =C2=A0 "#00FFFF", /* Bright Cyan */
> + =C2=A0 =C2=A0 =C2=A0 "#0000FF", /* Bright Blue */
> + =C2=A0 =C2=A0 =C2=A0 "#FF00FF", /* Bright Magenta */
> +};
> +
> +static void end_format(GString *string, guint8 code)
> +{
> + =C2=A0 =C2=A0 =C2=A0 g_string_append(string, "</span>");
> +
> + =C2=A0 =C2=A0 =C2=A0 if ((code & STK_TEXT_FORMAT_ALIGN_MASK) !=3D STK_T=
EXT_FORMAT_NO_ALIGN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "</div>");
> +}
> +
> +static void start_format(GString *string, guint8 code, guint8 color)
> +{
> + =C2=A0 =C2=A0 =C2=A0 guint8 align =3D code & STK_TEXT_FORMAT_ALIGN_MASK;
> + =C2=A0 =C2=A0 =C2=A0 guint8 font =3D code & STK_TEXT_FORMAT_FONT_MASK;
> + =C2=A0 =C2=A0 =C2=A0 guint8 style =3D code & STK_TEXT_FORMAT_STYLE_MASK;
> + =C2=A0 =C2=A0 =C2=A0 int fg =3D color & 0x0f;
> + =C2=A0 =C2=A0 =C2=A0 int bg =3D (color >> 4) & 0x0f;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* align formatting applies to a block of test */
> + =C2=A0 =C2=A0 =C2=A0 if (align !=3D STK_TEXT_FORMAT_NO_ALIGN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "<div style=3D\"");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (align =3D=3D STK_TEXT_FORMAT_RIGHT_ALIGN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "text-align: right;\">");
> + =C2=A0 =C2=A0 =C2=A0 else if (align =3D=3D STK_TEXT_FORMAT_CENTER_ALIGN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "text-align: center;\">");
> + =C2=A0 =C2=A0 =C2=A0 else if (align =3D=3D STK_TEXT_FORMAT_LEFT_ALIGN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "text-align: left;\">");
> +
> + =C2=A0 =C2=A0 =C2=A0 /* font, style, and color are inline */
> + =C2=A0 =C2=A0 =C2=A0 g_string_append(string, "<span style=3D\"");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_LARGE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "font-size: big;");
> + =C2=A0 =C2=A0 =C2=A0 else if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_SMA=
LL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "font-size: small;");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (style =3D=3D STK_TEXT_FORMAT_STYLE_BOLD)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "font-weight: bold;");
> + =C2=A0 =C2=A0 =C2=A0 else if (style =3D=3D STK_TEXT_FORMAT_STYLE_ITALIC)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "font-style: italic;");
> + =C2=A0 =C2=A0 =C2=A0 else if (style =3D=3D STK_TEXT_FORMAT_STYLE_UNDERL=
INED)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "text-decoration: underline;");
> + =C2=A0 =C2=A0 =C2=A0 else if (style =3D=3D STK_TEXT_FORMAT_STYLE_STRIKE=
THROUGH)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append(string=
, "text-decoration: line-through;");
> +
> + =C2=A0 =C2=A0 =C2=A0 /* add any color */
> + =C2=A0 =C2=A0 =C2=A0 if (fg)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append_printf=
(string, "color: %s;", html_colors[fg]);
> + =C2=A0 =C2=A0 =C2=A0 if (bg)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append_printf=
(string, "background-color: %s;",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 html_colors[bg]);
> + =C2=A0 =C2=A0 =C2=A0 g_string_append(string, "\">");
> +}
> +
> +char *stk_text_to_html(char *text, int text_len,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *attrs, int attrs_le=
n)
> +{
> + =C2=A0 =C2=A0 =C2=A0 GString *string =3D g_string_sized_new(text_len + =
1);
> + =C2=A0 =C2=A0 =C2=A0 GQueue formats[241]; =C2=A0/* maximum number of ch=
ars in text + 1 */
> + =C2=A0 =C2=A0 =C2=A0 int pos =3D 0, attr, i;
> + =C2=A0 =C2=A0 =C2=A0 guint8 start, end, code, color, len;
> + =C2=A0 =C2=A0 =C2=A0 guint8 align =3D STK_DEFAULT_TEXT_ALIGNMENT; /* ha=
rdcoded to left */
> +
> + =C2=A0 =C2=A0 =C2=A0 /* we may need formatting at the position beyond t=
he last char */
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i <=3D text_len; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_queue_init(&formats[=
i]);
> +
> + =C2=A0 =C2=A0 =C2=A0 i =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* each position in the text may have multipl=
e attributes.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* store each attribute in a queue for that p=
osition in the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* order in which it was sent. =C2=A0This wil=
l cause the last
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* attribute sent for that position to take p=
riority.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 while (i < attrs_len) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TBD - check for bad=
 values */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D attrs[i++];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D attrs[i++];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code =3D attrs[i++];
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* if the alignme=
nt is the same as either the default
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* or the last al=
ignment used, don't set any alignment
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* value.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((code & STK_TEXT_F=
ORMAT_ALIGN_MASK) =3D=3D align)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 code |=3D 0x3;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 align =3D code & STK_TEXT_FORMAT_ALIGN_MASK;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i < attrs_len)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 color =3D attrs[i++];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 color =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 end =3D text_len;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 end =3D start + len;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 attr =3D start | (code=
 << 16) | (color << 24);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_queue_push_tail(&for=
mats[start], GINT_TO_POINTER(attr));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_queue_push_tail(&for=
mats[end], GINT_TO_POINTER(attr));
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 while (pos <=3D text_len) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GQueue *q =3D &formats=
[pos];
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* there may be multip=
le formats per position */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while ((attr =3D GPOIN=
TER_TO_INT(g_queue_pop_head(q)))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 start =3D attr & 0xff;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 code =3D attr >> 16 & 0xff;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 color =3D attr >> 24 & 0xff;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (pos =3D=3D start)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start_format(string, code, color);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end_format(string, code);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

Can we always end_format() and start_format() when the formatting
changes, and just once instead of in a loop?  Here's a test case that
I'm worried about:

text is "abc"
attribute 1 (red text) starts at 0, len 2
attribute 2 (blue text) starts at 1, len 2

the generated html, by my reading will look like this:
<span style=3D"color: red;">a<span style=3D"color: blue;">b</span>c</span>

The end result is that c is red, while it should be blue.  But the
real problem is if one of them was a div, then you would have badly
balanced xml and it wouldn't parse. (I mentioned this on IRC)

> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pos =3D=3D text_le=
n)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (text[pos] =3D=3D '=
\n')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_string_append(string, "<br/>");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (text[pos] =3D=
=3D '\r') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_string_append(string, "<br/>");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if ((pos + 1 < text_len) && (text[pos + 1] =3D=3D '\n'))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pos++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (text[pos] =
=3D=3D '<')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_string_append(string, "&lt;");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (text[pos] =3D=
=3D '>')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_string_append(string, "&gt;");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (text[pos] =3D=
=3D '&')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_string_append(string, "&amp;");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_string_append_c(string, text[pos]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pos++;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* return characters from string. Caller must free=
 char data */
> + =C2=A0 =C2=A0 =C2=A0 return g_string_free(string, FALSE);
> +}

This approach with having so many queues seems a little heavy.  On irc
I proposed that probably we don't need to implement this behaviour
fully and maybe could make some assumptions to simplify it.  But if
you want a full implementation here's what I'd do:

Make a list of all starts and ends of attributes, and sort it by
position in the text, for example for the abc case above, that list
would contain:
position 0, pointer to attribute 1
position 1, pointer to attribute 2
position 2, pointer to attribute 1
position 3, pointer to attribute 2

Each attribute has a .start, a .end (.start + .len) and a rank which
is just its position in the original array.

Then I'd loop through the text like this:

while (pos <=3D text_len) {
    if anything to do on current position {
        close previous <span>;

        foreach (attributes that start here) {
            if attribute->start >=3D attribute.end
                continue
            if attribute->rank > current_attribute->rank {
                current_attribute->start =3D attribute->end;
                current_attribute =3D attribute;
            } else
                attribute->start =3D current_attribute->end;
        }

        open new span(current_attribute);
    }

    append chunk of text up to next interesting position;
}

I'm not sure if this is enough (would have to try it) but it seems to
work, provided the list is maintained sorted.  That way whenever one
attibute ends, another is going to start at the same position, so
maybe it's unnecessary to keep the end positions in that list.

Regards

--===============8760270327043001739==--

