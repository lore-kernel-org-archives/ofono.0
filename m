Content-Type: multipart/mixed; boundary="===============2935777055794999829=="
MIME-Version: 1.0
From: Frank Gau <fgau@gau-net.de>
Subject: Re: [PATCH] doc: New file about using the calypso modem
Date: Tue, 28 Dec 2010 18:32:49 +0100
Message-ID: <20101228173248.GB3148@fgaulaptop.gaunet.local>
In-Reply-To: <1293555680.9439.63.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2935777055794999829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Di, Dez 28, 2010 at 09:01:20 -0800, Marcel Holtmann wrote:
> Hi Neil,
> =

> >  doc/calypso-modem.txt |   22 ++++++++++++++++++++++
> >  1 files changed, 22 insertions(+), 0 deletions(-)
> >  create mode 100644 doc/calypso-modem.txt
> > =

> > diff --git a/doc/calypso-modem.txt b/doc/calypso-modem.txt
> > new file mode 100644
> > index 0000000..ea3e0bb
> > --- /dev/null
> > +++ b/doc/calypso-modem.txt
> > @@ -0,0 +1,22 @@
> > +Calypso modem usage
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +On the Openmoko Freerunner phone, the Calypso modem is presented by
> > +the kernel as serial device /dev/ttySAC0.  To allow Ofono to
> =

> it is spelled oFono.
> =

> > +autodetect and use this, a simple udev rule is needed:
> > +
> > +KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"calypso"
> > +
> > +You can put this in any file in /lib/udev/rules.d.  A logical choice
> > +is the "55-openmoko-gta01-gta02.rules" file, if it exists in your
> > +Freerunner distribution.
> > +
> > +With this rule in place:
> > +
> > +- ofono will detect the Calypso modem when it starts up, and the
> =

> Same here. It is oFono.
> =

> > +  `list-modems' test script will show this, but will not power it up
> > +
> > +- the `enable-modem' test script can be used to power it up
> > +
> > +- a subsequent `list-modems' will show lots of information, including
> > +  network registration.
> =

> Since we had this discussion on IRC. Has this rule been proven to do the
> right thing? Even in case of the weird renaming of the original serial
> port?
> =

> Regards
> =

> Marcel
>
Approved!

Regards Frank =



--===============2935777055794999829==--

