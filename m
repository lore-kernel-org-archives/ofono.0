Content-Type: multipart/mixed; boundary="===============6470043157886174594=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: plugins/mbpi.c compiler warnings
Date: Sun, 08 Jan 2012 08:26:13 -0600
Message-ID: <4F09A785.4090800@gmail.com>
In-Reply-To: <1326210062.6454.209.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6470043157886174594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 01/10/2012 09:41 AM, Marcel Holtmann wrote:
>   CC     plugins/mbpi.o
> plugins/mbpi.c: In function =E2=80=98apn_start=E2=80=99:
> plugins/mbpi.c:170: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c:173: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c:176: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c: In function =E2=80=98apn_handler=E2=80=99:
> plugins/mbpi.c:263: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c:287: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c: In function =E2=80=98provider_start=E2=80=99:
> plugins/mbpi.c:423: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c:425: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c:427: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c: In function =E2=80=98toplevel_gsm_start=E2=80=99:
> plugins/mbpi.c:459: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c:461: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c: In function =E2=80=98toplevel_cdma_start=E2=80=99:
> plugins/mbpi.c:493: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
> plugins/mbpi.c:495: warning: passing argument 2 of =E2=80=98g_markup_pars=
e_context_push=E2=80=99 discards qualifiers from pointer target type
> /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struct =
GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GMar=
kupParser *=E2=80=99
>   CC     plugins/provision.o
>   CC     plugins/cdma-provision.o
> =


What glib version are you using? Mine defines
g_markup_parse_context_push like this:

void                 g_markup_parse_context_push  (GMarkupParseContext
*context,
                                                   const GMarkupParser
*parser,
                                                   gpointer
user_data);


Regards,
-Denis

--===============6470043157886174594==--

