Content-Type: multipart/mixed; boundary="===============3640787171921714497=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Palm Pre modem plugin
Date: Sat, 21 Nov 2009 19:12:36 +0100
Message-ID: <1258827156.22343.26.camel@localhost.localdomain>
In-Reply-To: <20091121110548.GA31278@nirvana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3640787171921714497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Morphis,

> > > > > I saw you added some time ago support for the Palm Pre MSM Modem.=
 I am
> > > > > working =

> > > > > on the FSO (http://www.freesmartphone.org/) side to support this =
kind of
> > > > > MSM =

> > > > > modem as well. I am are currently stucked with the binary protoco=
l spoken =

> > > > > between modem and userland in webOS.
> > > > > =

> > > > > The Problem why we do this is the following: As I and some other =
people
> > > > > find out, =

> > > > > there is no support on the data channel (the one you use in oFono=
 to speak
> > > > > =

> > > > > plain AT with the modem) for unsolicited responses.
> > > > > =

> > > > > So the only option is to support the binary protocol to get minim=
ally the =

> > > > > response from the modem when for example a call arrives.
> > > > > =

> > > > > So my question is: How do you want to manage this with your plugi=
n for the
> > > > > =

> > > > > Palm Pre modem? Do you even plan to use the serial interface on t=
he =

> > > > > /dev/modemuart port? =

> > > > =

> > > > I expect that at some point someone does a MSM plugin that talks th=
is
> > > > binary protocol and it will work with more Qualcomm based devices t=
han
> > > > the Palm Pre. We will see. However any patches are more than welcom=
e.
> > > =

> > > No patches from me for oFono as I am a FSO fan boy :) =

> > =

> > I think we need to convert you :)
> =

> You can try but I think it's currently impossible :)

for oFono we have a pretty much brought spectrum and if the Qualcomm
GOBI cards use a similar protocol to what we find in the Palm Pre, then
you might wanna actually consider going for oFono. Since we will be
pushing oFono as the main telephony stack for desktops, laptops and
netbooks. Using it on actual mobile phones is just a side product.

And I did see FSO using the SMS PDU engine from oFono already, so you
might switch over ;)

> > To be honest it would be way simpler for you to write a MSM plugin for
> > oFono since it is actually designed to support binary protocols like the
> > Nokia Phonet in the first place.
> =

> What do mean with that? If I look at fsogsmd (the vala implementation of
> the fso gsm daemon) it's even abstracted so I can easily implement a
> binary protocol as we found in the Palm Pre modem.

If you wanna go for FSO, then by all means go for it. If they finally
have a proper abstraction layer then all the better. With all the weird
integration work we have done so far, we are pretty happy with our
current design and have the flexibility we need and it worked out better
for us than we ever dreamed it would.

Regards

Marcel



--===============3640787171921714497==--

