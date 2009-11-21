Content-Type: multipart/mixed; boundary="===============3893354076461305915=="
MIME-Version: 1.0
From: morphis@gravedo.de
Subject: Re: Palm Pre modem plugin
Date: Sat, 21 Nov 2009 12:05:48 +0100
Message-ID: <20091121110548.GA31278@nirvana>
In-Reply-To: <1258799604.25879.29.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3893354076461305915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2009 at 11:33:24AM +0100, Marcel Holtmann wrote:
> Hi Morphis,
> =

> > > > I saw you added some time ago support for the Palm Pre MSM Modem. I=
 am
> > > > working =

> > > > on the FSO (http://www.freesmartphone.org/) side to support this ki=
nd of
> > > > MSM =

> > > > modem as well. I am are currently stucked with the binary protocol =
spoken =

> > > > between modem and userland in webOS.
> > > > =

> > > > The Problem why we do this is the following: As I and some other pe=
ople
> > > > find out, =

> > > > there is no support on the data channel (the one you use in oFono t=
o speak
> > > > =

> > > > plain AT with the modem) for unsolicited responses.
> > > > =

> > > > So the only option is to support the binary protocol to get minimal=
ly the =

> > > > response from the modem when for example a call arrives.
> > > > =

> > > > So my question is: How do you want to manage this with your plugin =
for the
> > > > =

> > > > Palm Pre modem? Do you even plan to use the serial interface on the =

> > > > /dev/modemuart port? =

> > > =

> > > I expect that at some point someone does a MSM plugin that talks this
> > > binary protocol and it will work with more Qualcomm based devices than
> > > the Palm Pre. We will see. However any patches are more than welcome.
> > =

> > No patches from me for oFono as I am a FSO fan boy :) =

> =

> I think we need to convert you :)

You can try but I think it's currently impossible :)

> =

> To be honest it would be way simpler for you to write a MSM plugin for
> oFono since it is actually designed to support binary protocols like the
> Nokia Phonet in the first place.

What do mean with that? If I look at fsogsmd (the vala implementation of
the fso gsm daemon) it's even abstracted so I can easily implement a
binary protocol as we found in the Palm Pre modem.

> =

> Regards
>=20

--===============3893354076461305915==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWtzSHlZd0FDZ2tRcWxpNGFTWGl3TThxSkFDZlRVZjI3RHZs
Yjh3Q01YQlgrNG5Mb0JJSQoyNGdBb0k5SWprdjNVNU1kdmxSZ1JzYVRTS2JKQmhmWAo9WmhSagot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============3893354076461305915==--

