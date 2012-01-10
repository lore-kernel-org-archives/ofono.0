Content-Type: multipart/mixed; boundary="===============8011384957305227363=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: plugins/mbpi.c compiler warnings
Date: Tue, 10 Jan 2012 11:58:33 -0800
Message-ID: <1326225513.6454.214.camel@aeonflux>
In-Reply-To: <4F09A785.4090800@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8011384957305227363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >   CC     plugins/mbpi.o
> > plugins/mbpi.c: In function =E2=80=98apn_start=E2=80=99:
> > plugins/mbpi.c:170: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c:173: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c:176: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c: In function =E2=80=98apn_handler=E2=80=99:
> > plugins/mbpi.c:263: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c:287: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c: In function =E2=80=98provider_start=E2=80=99:
> > plugins/mbpi.c:423: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c:425: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c:427: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c: In function =E2=80=98toplevel_gsm_start=E2=80=99:
> > plugins/mbpi.c:459: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c:461: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c: In function =E2=80=98toplevel_cdma_start=E2=80=99:
> > plugins/mbpi.c:493: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> > plugins/mbpi.c:495: warning: passing argument 2 of =E2=80=98g_markup_pa=
rse_context_push=E2=80=99 discards qualifiers from pointer target type
> > /usr/include/glib-2.0/glib/gmarkup.h:115: note: expected =E2=80=98struc=
t GMarkupParser *=E2=80=99 but argument is of type =E2=80=98const struct GM=
arkupParser *=E2=80=99
> >   CC     plugins/provision.o
> >   CC     plugins/cdma-provision.o
> > =

> =

> What glib version are you using? Mine defines
> g_markup_parse_context_push like this:
> =

> void                 g_markup_parse_context_push  (GMarkupParseContext
> *context,
>                                                    const GMarkupParser
> *parser,
>                                                    gpointer
> user_data);

this was a test compile on an older version and it seems that GLib broke
their API promise again. So just lets ignore these warnings since their
is nothing we can do about it anyway.

Regards

Marcel



--===============8011384957305227363==--

