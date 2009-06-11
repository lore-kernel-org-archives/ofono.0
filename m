Content-Type: multipart/mixed; boundary="===============1148747696139474171=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 17:09:55 +0200
Message-ID: <1244732995.27363.22.camel@violet>
In-Reply-To: <1244729078.5792.187.camel@polaris>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1148747696139474171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> > > The attributes are really only for informational purposes only.  The
> > > user would not base his decision on the mcc/mnc, but on the operator
> > > name.  =

> > > =

> > > So before we start changing the D-Bus APIs, we need to answer these
> > > two questions:
> > >   - Can a country/administrative domain have both 001 and 01 MNCs such
> > > that the use of string for the MNC is actually necessary.
> > >   - What does the user find easier to use, a string or a short?
> > =

> > I wasn't aware of this and so it might be better to just expose these as
> > an operator id string. So we might not even split into MCC/MNC at all
> > since it is meaning less anyway.
> =

> This is probably the way to go...
> =

> > That said, we do want some exposure of these values since it is an easy
> > way to determine geo location help and switch timezones etc. However I
> > am now thinking that me might just add a Country property and do the
> > proper translation inside oFono. Since we mostly care about these ones
> > most.
> =

> While inferring the country from MCC sounds nice, there are some corner
> cases where is causes problems:
> =

> Digicel Bermuda uses 310/38 (or 310/038?), 310 is the US MCC:
> http://dougtoombs.com/2008/07/23/bermuda-the-iphone-and-att-beware-the-da=
ta-roaming/
> =

> Montenegro used MCC 220 (Serbia) before it switched to MCC 297.
> =

> Wikipedia has a list:
> http://en.wikipedia.org/wiki/Mobile_Network_Code
> =

> If you plan to ship such a list with ofono, maybe
> http://git.freesmartphone.org/?p=3Dframework.git;a=3Dblob;f=3Detc/freesma=
rtphone/ogsmd/networks.tab
> can be useful for you. OTOH, Nokia probably has a better list.

we will hide this minor defect inside the daemon and not bother the use
with details.

Regards

Marcel



--===============1148747696139474171==--

