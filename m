Content-Type: multipart/mixed; boundary="===============4644139096307850359=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus 05/23] doc: explain debugging options to -d,
 add a pointer in -h to manpage
Date: Fri, 02 Jul 2010 14:19:11 -0700
Message-ID: <1278105551.2327.34.camel@localhost.localdomain>
In-Reply-To: <4C2E4F6E.3@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4644139096307850359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-02 at 13:43 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> Please remember not to go over 50 characters on your git commit
> description header and more than 72 characters on your git commit
> description body.
> =

> > @@ -110,7 +110,9 @@ static gboolean parse_debug(const char *key, const =
char *value,
> >  static GOptionEntry options[] =3D {
> >  	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
> >  				G_OPTION_ARG_CALLBACK, parse_debug,
> > -				"Specify debug options to enable", "DEBUG" },
> > +			   "Specify debug options to enable (see the "
> > +			   "man page for ofonod(8) for more information).",
> =

> I still think mentioning the man page is a bit redundant.
> =

> > +			   "DEBUG" },
> >  	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
> >  				G_OPTION_ARG_NONE, &option_detach,
> >  				"Don't run as daemon in background" },
> =

> Regards,
> -Denis

Bah, hit enter too soon, sorry -- meant drop the .c code adding that,
but keep the additions to the man page. I'll redo that one.



--===============4644139096307850359==--

