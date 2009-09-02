Content-Type: multipart/mixed; boundary="===============3603307973515755363=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 15:36:10 -0500
Message-ID: <200909021536.11275.denkenz@gmail.com>
In-Reply-To: <1251923864.1266.104.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3603307973515755363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
> > >> The reason is simple, Nokia modems suspend GPRS when scanning (or
> > >> registering), simply because the operation will take roughly three
> > >> times as long with GPRS attached. You will find this feature in
> > >> current phones, too.
> > >
> > > Then ideally you should have two scan modes, periodic and user
> > > initiated.  For periodic mode we don't care how long it takes.
> >
> > +1
>
> Sounds like a plan. So we do need an /etc/ofono/main.conf :)

So my current thinking is to introduce a method to NetworkRegistration =

property called 'ProposeOperatorScan' and a new property called =

'OperatorScanInterval'.  The driver api can then support a (non-standard =

*gasp*) option to say whether this scan was initiated actively or not.

Maybe the Nokia modems can use this information not to drop the GPRS link i=
f =

it isn't an active scan being performed.

Regards,
-Denis

--===============3603307973515755363==--

