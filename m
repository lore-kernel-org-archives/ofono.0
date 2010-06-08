Content-Type: multipart/mixed; boundary="===============6064189125512935186=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [RFC patches 01/13] Update .gitignore to ignore cscope databases
 and backup files
Date: Tue, 08 Jun 2010 22:13:16 +0000
Message-ID: <1276035463.2478.54.camel@localhost.localdomain>
In-Reply-To: <1275056949.4706.82.camel@aeonflux.t-mobile.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6064189125512935186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-05-28 at 07:29 -0700, Marcel Holtmann wrote: =

> Hi Joao,
> =

> > >> diff --git a/.gitignore b/.gitignore
> > >> index 1ce7067..d7e9254 100644
> > >> --- a/.gitignore
> > >> +++ b/.gitignore
> > >> @@ -1,3 +1,4 @@
> > >> +*~
> > >
> > > believe it or not, I always left that out on purpose. I like having g=
it
> > > status show me all the stupid backup files my editor creates.
> > >
> > >>  *.o
> > >>  *.lo
> > >>  *.la
> > >> @@ -16,6 +17,8 @@ config.sub
> > >>  configure
> > >>  depcomp
> > >>  compile
> > >> +cscope.files
> > >> +cscope.out
> > >>  install-sh
> > >>  libtool
> > >>  ltmain.sh
> > >
> > > Please put the cscope stuff behind autom4te.cache since it is not part
> > > of autoconf/automake.
> > >
> > =

> > Does this makes sense since this files are not related to the project
> > itself but to specific tools? I usually put those on my personal
> > gitignore file.
> =

> actually I have to agree. They really don't belong in the project and
> the personal gitignore configuration is a suitable place for them.

ACK, I'll drop this one then


--===============6064189125512935186==--

