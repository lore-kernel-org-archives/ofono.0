Content-Type: multipart/mixed; boundary="===============5542551186702078112=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] stkutil: convert text attributes to html
Date: Tue, 15 Jun 2010 01:10:08 +0200
Message-ID: <AANLkTilMtQ5XhZ8BXCGBQUYbR_sfD4X_n-jEvGzcy636@mail.gmail.com>
In-Reply-To: <1276528791-11458-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5542551186702078112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 14 June 2010 17:19, Kristen Carlson Accardi <kristen@linux.intel.com> =
wrote:
> ---
> =C2=A0src/stkutil.c | =C2=A0203 +++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A0src/stkutil.h | =C2=A0 21 ++++++
> =C2=A02 files changed, 224 insertions(+), 0 deletions(-)
>
> diff --git a/src/stkutil.c b/src/stkutil.c
> index 8ac1dba..dbcb6ac 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -4307,3 +4307,206 @@ const unsigned char *stk_pdu_from_envelope(const =
struct stk_envelope *envelope,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return pdu;
> =C2=A0}
> +
> +static GString *mapColourToHtml(GString *string, guint8 colour)
> +{
> + =C2=A0 =C2=A0 =C2=A0 GString *result =3D string;
> + =C2=A0 =C2=A0 =C2=A0 int fg =3D colour & 0x0f;
> + =C2=A0 =C2=A0 =C2=A0 int bg =3D (colour >> 4) & 0x0f;
> + =C2=A0 =C2=A0 =C2=A0 static const char *html_colors[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#000000", /* Black */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#808080", /* Dark Gre=
y */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#C11B17", /* Dark Red=
 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#FBB117", /* Dark Yel=
low */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#347235", /* Dark Gre=
en */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#307D7E", /* Dark Cya=
n */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#0000A0", /* Dark Blu=
e */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#C031C7", /* Dark Mag=
enta */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#C0C0C0", /* Grey */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#FFFFFF", /* White */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#FF0000", /* Bright R=
ed */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#FFFF00", /* Bright Y=
ellow */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#00FF00", /* Bright G=
reen */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#00FFFF", /* Bright C=
yan */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#0000FF", /* Bright B=
lue */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#FF00FF", /* Bright M=
agenta */
> + =C2=A0 =C2=A0 =C2=A0 };
> +
> + =C2=A0 =C2=A0 =C2=A0 if (colour =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return string;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (fg) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, "color: ");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, html_colors[fg]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend_c(result, ';');
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (bg) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, "background-color: ");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, html_colors[bg]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend_c(result, ';');
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> +
> + =C2=A0 =C2=A0 =C2=A0 return result;
> +}
> +
> +static GString *endFormat(GString *string)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return g_string_append(string, "</p>");
> +}
> +
> +static GString *mapFormatToHtml(GString *string, guint8 code, guint8 col=
our)
> +{
> + =C2=A0 =C2=A0 =C2=A0 GString *result =3D string;
> + =C2=A0 =C2=A0 =C2=A0 guint8 align =3D code & STK_TEXT_FORMAT_ALIGN_MASK;
> + =C2=A0 =C2=A0 =C2=A0 guint8 font =3D code & STK_TEXT_FORMAT_FONT_MASK;
> + =C2=A0 =C2=A0 =C2=A0 guint8 style =3D code & STK_TEXT_FORMAT_STYLE_MASK;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* formatting applies to a block of test */
> + =C2=A0 =C2=A0 =C2=A0 result =3D g_string_append(result, "<p style=3D\""=
);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (align =3D=3D STK_TEXT_FORMAT_RIGHT_ALIGN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, "text-align: right;");
> + =C2=A0 =C2=A0 =C2=A0 else if (align =3D=3D STK_TEXT_FORMAT_CENTER_ALIGN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, "text-align: center;");
> + =C2=A0 =C2=A0 =C2=A0 else if (align =3D=3D STK_TEXT_FORMAT_LEFT_ALIGN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, "text-align: left;");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_LARGE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, "font-size: big;");
> + =C2=A0 =C2=A0 =C2=A0 else if (font =3D=3D STK_TEXT_FORMAT_FONT_SIZE_SMA=
LL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, "font-size: small;");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (style =3D=3D STK_TEXT_FORMAT_STYLE_BOLD)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, "font-weight: bold;");
> + =C2=A0 =C2=A0 =C2=A0 else if (style =3D=3D STK_TEXT_FORMAT_STYLE_ITALIC)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, "font-style: italic;");
> + =C2=A0 =C2=A0 =C2=A0 else if (style =3D=3D STK_TEXT_FORMAT_STYLE_UNDERL=
INED)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result, "text-decoration: underline;");
> + =C2=A0 =C2=A0 =C2=A0 else if (style =3D=3D STK_TEXT_FORMAT_STYLE_STRIKE=
THROUGH)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_string_ap=
pend(result,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "text-decora=
tion: line-through;");
> +
> + =C2=A0 =C2=A0 =C2=A0 /* add any color */
> + =C2=A0 =C2=A0 =C2=A0 result =3D mapColourToHtml(result, colour);
> +
> + =C2=A0 =C2=A0 =C2=A0 result =3D g_string_append(result, "\">");
> +
> + =C2=A0 =C2=A0 =C2=A0 return result;
> +}
> +
> +static gboolean isSpecialChar(char c)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (c =3D=3D '\n' || c =3D=3D '\r' || c =3D=3D=
 '<' || c =3D=3D '>' || c =3D=3D '&');
> +}
> +
> +static gboolean mapCharToHtml(char *s, int pos, int len,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 GString **string)
> +{
> + =C2=A0 =C2=A0 =C2=A0 gboolean rval =3D FALSE;
> + =C2=A0 =C2=A0 =C2=A0 GString *result =3D *string;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char c =3D s[pos];
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (c) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case '\n':
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 result =3D g_string_append(result, "<br>");

It would be nice to not annoy xml parsers, <br /> instead of <br>
should be both a valid html and xml.  But there's a possible conflict,
using <p> means a new paragraph is started for every formatted piece
of text, while \n will not start a new paragraph.  Perhaps it would be
better to use <span> for formatting.  It seems that only when the
alignment mode changes, a new paragraph should start [1].

Also it seems the code won't handle nested formatting, I don't see a
place where that is allowed or disallowed in 23.040, but it's needed
if you want to handle default formatting.  For example let's say
default is set to green and in the middle of the text you have a word
in blue, then blue needs to override green for just that span.

Note the rest of stkutil.c doesn't use camelcase.

Regards,
Andrew

1. "*in case formatting text is inserted on the same line as previous
non formatting text or with a different
mode value, the alignment value shall be set to the same value as the
previous formatted predefined
object."

--===============5542551186702078112==--

