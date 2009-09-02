Content-Type: multipart/mixed; boundary="===============4854813392261393009=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 14:09:33 -0700
Message-ID: <1251925773.1266.126.camel@localhost.localdomain>
In-Reply-To: <200909021536.11275.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4854813392261393009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > > >> The reason is simple, Nokia modems suspend GPRS when scanning (or
> > > >> registering), simply because the operation will take roughly three
> > > >> times as long with GPRS attached. You will find this feature in
> > > >> current phones, too.
> > > >
> > > > Then ideally you should have two scan modes, periodic and user
> > > > initiated.  For periodic mode we don't care how long it takes.
> > >
> > > +1
> >
> > Sounds like a plan. So we do need an /etc/ofono/main.conf :)
> =

> So my current thinking is to introduce a method to NetworkRegistration =

> property called 'ProposeOperatorScan' and a new property called =

> 'OperatorScanInterval'.  The driver api can then support a (non-standard =

> *gasp*) option to say whether this scan was initiated actively or not.
> =

> Maybe the Nokia modems can use this information not to drop the GPRS link=
 if =

> it isn't an active scan being performed.

I really prefer if we put this into /etc/ofono/main.conf since the UI
should not configure this at all. It is more a one time setting based on
what the integrator expects as a behavior.

Regards

Marcel



--===============4854813392261393009==--

