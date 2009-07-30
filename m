Content-Type: multipart/mixed; boundary="===============0480152507583978310=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Network information can't be updated dynamically
Date: Wed, 29 Jul 2009 21:45:40 -0500
Message-ID: <200907292145.40433.denkenz@gmail.com>
In-Reply-To: <B94C62E7C2870743865418621F040C1302053C502B@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0480152507583978310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> No, if ofono don't request it and the modem can't send the response

I think you have no idea what you're talking about.  The 'spec' way of doin=
g =

this is sending AT+CREG=3D2, at which point the modem will send a +CREG: =

unsolicited result code whenever the registration state changes (e.g. roami=
ng, =

searching, home, etc).  See 27.007 Section 7.2.  =


oFono also requests the registration status whenever any registration =

operation is performed.  This works, you can even test it on phonesim if yo=
u =

like.

>
> >> Suppose UI want to show the status, which interface can be used?
> >
> >You use the NetworkRegistration interface, 'Status' property.
>
> That's the point; the status can't be changed because ofono only get the
> status at modem/networking initialization, during registered to roaming
> ofono don't know the changing even modem update the information correctly

Again, you're wrong.  Take a look at ofono_network_registration_notify in =

src/network.c and and creg_notify in drivers/atmodem/network-registration.c.

I ask you again, are you sure your modem is actually switching its status, =
and =

if so, can you provide a debug trace?

Regards,
-Denis

--===============0480152507583978310==--

