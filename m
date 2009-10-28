Content-Type: multipart/mixed; boundary="===============1176239522138689441=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RfC] Retry registering packet radio to home PLMN when available.
Date: Wed, 28 Oct 2009 16:21:19 -0500
Message-ID: <200910281621.19526.denkenz@gmail.com>
In-Reply-To: <fb249edb0910280030w76287e59me10ddcde2ae8f8db@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1176239522138689441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> One reason you might want to not register to network would be for power
> saving.

Sure, but remember there are two cases here:

The device oFono is managing is a proper voice + data modem.  In which case =

the likely scenario is that we want to always be registered to the voice =

network and not register to GPRS network for power reasons.

The second case is we're managing a GPRS-only data device.  In which case t=
he =

power considerations are flipped.

>
> It seems like a small gain for adding this dependency (which will seem
> especially strange to users not knowing about this quirk we're relying
> on).  The current picture is that we want to have an indication of
> when we might be able to register back to home PLMN with gprs.  We
> keep the gprs radio disabled and enable the circuit-switched radio
> possibly with the only aim being to have that (possibly weak)

For the devices that oFono is primarily targeting (e.g. voice + data device=
s) =

this behavior is exactly what we want, no?

> indication.  Couldn't we instead use the gprs radio for the same
> purpose?  We would simply prohibit activating contexts while roaming
> and we would report Attached =3D false on D-Bus.

I agree that we want to do this for data-only devices.  In which case I =

suspect we need to have the driver tell oFono that it is a data-only device=
.  =

With implications that we always auto-attach, and either ignore RoamingAllo=
wed =

setting completely or do as you suggest and refuse to activate the context. =


The tricky part is how to report the operator.  Remember that it is quite =

ambiguous what COPS=3D0 does.  On some devices it activates CSD radio.  On =
some =

GPRS, and both on others.

Regards.
=3DDemos

--===============1176239522138689441==--

