Content-Type: multipart/mixed; boundary="===============1300799309887507936=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Palm Pre modem plugin
Date: Sat, 21 Nov 2009 11:33:24 +0100
Message-ID: <1258799604.25879.29.camel@localhost.localdomain>
In-Reply-To: <20091121101745.GB4375@nirvana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1300799309887507936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Morphis,

> > > I saw you added some time ago support for the Palm Pre MSM Modem. I am
> > > working =

> > > on the FSO (http://www.freesmartphone.org/) side to support this kind=
 of
> > > MSM =

> > > modem as well. I am are currently stucked with the binary protocol sp=
oken =

> > > between modem and userland in webOS.
> > > =

> > > The Problem why we do this is the following: As I and some other peop=
le
> > > find out, =

> > > there is no support on the data channel (the one you use in oFono to =
speak
> > > =

> > > plain AT with the modem) for unsolicited responses.
> > > =

> > > So the only option is to support the binary protocol to get minimally=
 the =

> > > response from the modem when for example a call arrives.
> > > =

> > > So my question is: How do you want to manage this with your plugin fo=
r the
> > > =

> > > Palm Pre modem? Do you even plan to use the serial interface on the =

> > > /dev/modemuart port? =

> > =

> > I expect that at some point someone does a MSM plugin that talks this
> > binary protocol and it will work with more Qualcomm based devices than
> > the Palm Pre. We will see. However any patches are more than welcome.
> =

> No patches from me for oFono as I am a FSO fan boy :) =


I think we need to convert you :)

To be honest it would be way simpler for you to write a MSM plugin for
oFono since it is actually designed to support binary protocols like the
Nokia Phonet in the first place.

Regards

Marcel



--===============1300799309887507936==--

