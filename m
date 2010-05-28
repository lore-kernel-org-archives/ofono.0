Content-Type: multipart/mixed; boundary="===============1878901690276528327=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC patches 01/13] Update .gitignore to ignore cscope databases
 and backup files
Date: Fri, 28 May 2010 16:29:09 +0200
Message-ID: <1275056949.4706.82.camel@aeonflux.t-mobile.de>
In-Reply-To: <AANLkTinQ4TyOpS2HxmqEQeFTmV4It_Sx1T2AK_C6TgCW@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1878901690276528327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joao,

> >> diff --git a/.gitignore b/.gitignore
> >> index 1ce7067..d7e9254 100644
> >> --- a/.gitignore
> >> +++ b/.gitignore
> >> @@ -1,3 +1,4 @@
> >> +*~
> >
> > believe it or not, I always left that out on purpose. I like having git
> > status show me all the stupid backup files my editor creates.
> >
> >>  *.o
> >>  *.lo
> >>  *.la
> >> @@ -16,6 +17,8 @@ config.sub
> >>  configure
> >>  depcomp
> >>  compile
> >> +cscope.files
> >> +cscope.out
> >>  install-sh
> >>  libtool
> >>  ltmain.sh
> >
> > Please put the cscope stuff behind autom4te.cache since it is not part
> > of autoconf/automake.
> >
> =

> Does this makes sense since this files are not related to the project
> itself but to specific tools? I usually put those on my personal
> gitignore file.

actually I have to agree. They really don't belong in the project and
the personal gitignore configuration is a suitable place for them.

Regards

Marcel



--===============1878901690276528327==--

