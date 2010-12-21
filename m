Content-Type: multipart/mixed; boundary="===============9190202567038037077=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 7/9] ofono-rules: Add cdmagen device
Date: Tue, 21 Dec 2010 06:23:22 -0800
Message-ID: <1292941402.2658.33.camel@aeonflux>
In-Reply-To: <4D0FA11B.3090808@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9190202567038037077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

> >>   plugins/ofono.rules |    4 ++++
> >>   1 files changed, 4 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> >> index da8a8ef..34698f0 100644
> >> --- a/plugins/ofono.rules
> >> +++ b/plugins/ofono.rules
> >> @@ -429,6 +429,10 @@ ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=
=3D"1311", ENV{OFONO_DRIVER}=3D"mbm"
> >>   # Nokia Internet Stick CS-10
> >>   ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"060e", ENV{OFONO=
_DRIVER}=3D"nokia"
> >>
> >> +# Nokia CDMA Device
> >> +ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"023e", ENV{OFONO_=
DRIVER}=3D"cdmagen"
> >> +ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b6", ENV{OFONO_=
DRIVER}=3D"cdmagen"
> >> +
> >
> > since this is Nokia specific device, then using nokiacdma would be a
> > better name. Or using OFONO_DRIVER=3Dnokia NOKIA_MODE=3Dcdma and sharin=
g the
> > driver might be useful.
> >
> > It really all depends how much they have in common.
> =

> Nothing. All Nokia CDMA devices actually contain Qualcomm modems, so =

> perhaps a better name may be along the lines of "msmcdmamodem" for CDMA =

> AT modem devices in a tethered mode?
> =

> So what kind of
> > hardware is this actually? A phone or a real USB dongle?
> >
> It is a phone.

so calling this driver "nokiacdma" sounds a bit better to me. It makes
it clear that the device is from Nokia. If you wanna shotcut it into
"nokcdma" then that is also fine with me, but it should reflect what it
is.

Even the Nokia datacard contains a Qualcomm modem btw. It is just GSM
instead of CDMA. So it is not that far away from the phone in tethered
mode than you think. If you wanna go with the NOKIA_MODE=3Dgsm|cdma, then
I would be fine with it as well.

Regards

Marcel



--===============9190202567038037077==--

