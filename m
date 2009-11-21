Content-Type: multipart/mixed; boundary="===============8999016130358900910=="
MIME-Version: 1.0
From: morphis@gravedo.de
Subject: Re: Palm Pre modem plugin
Date: Sat, 21 Nov 2009 11:17:45 +0100
Message-ID: <20091121101745.GB4375@nirvana>
In-Reply-To: <1258723699.25879.4.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8999016130358900910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2009 at 02:28:19PM +0100, Marcel Holtmann wrote:
> Hi Morphis,
> =

> > I saw you added some time ago support for the Palm Pre MSM Modem. I am
> > working =

> > on the FSO (http://www.freesmartphone.org/) side to support this kind of
> > MSM =

> > modem as well. I am are currently stucked with the binary protocol spok=
en =

> > between modem and userland in webOS.
> > =

> > The Problem why we do this is the following: As I and some other people
> > find out, =

> > there is no support on the data channel (the one you use in oFono to sp=
eak
> > =

> > plain AT with the modem) for unsolicited responses.
> > =

> > So the only option is to support the binary protocol to get minimally t=
he =

> > response from the modem when for example a call arrives.
> > =

> > So my question is: How do you want to manage this with your plugin for =
the
> > =

> > Palm Pre modem? Do you even plan to use the serial interface on the =

> > /dev/modemuart port? =

> =

> I expect that at some point someone does a MSM plugin that talks this
> binary protocol and it will work with more Qualcomm based devices than
> the Palm Pre. We will see. However any patches are more than welcome.

No patches from me for oFono as I am a FSO fan boy :)=20

--===============8999016130358900910==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWtzSHZra0FDZ2tRcWxpNGFTWGl3TThBa3dDZmZWL2FwbEgr
a1Z6NEU3N1FieUIvaFhVSQpRUlFBb0lsWDd0UzJWOHd1VmZwaWZsYUZWRlJiUTJmbgo9RVZkagot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============8999016130358900910==--

