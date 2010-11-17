Content-Type: multipart/mixed; boundary="===============0505736546349717040=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC] plugin/ste: Use D-Bus API from Modem Init Daemon for
 autoconfig.
Date: Wed, 17 Nov 2010 19:06:40 +0100
Message-ID: <AANLkTikLKPhtL6__Yqzhp89+X1t_fzuXpHAx2UP86qLj@mail.gmail.com>
In-Reply-To: <1289998849.29148.10.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0505736546349717040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.
> so how to you handle the case if you have two or more CAIF based modems
> in the system? oFono does not impose a limit here.

I guess there are at least two different scenarios here:

a) DualSim - In this case the Modem Init Daemon is working with one
   piece of HW, and will expose one instance in the Dbus API.
   We would have only one CAIF Link Layer interface.
   The concept of two virtual modems should probably be handled
   by the STE plugin that would have to register two modem instances
   with two sets of AT channels to the different virtual modem instances.

b) Testing - In some test setups it might be interesting having two or more
   STE modems. In this scenario we should probably be able to support
   multiple instances of modems and multiple CAIF Link Layer instances.
   oFono would then need to know the CAIF Link Layer instance to bind to.

There might be other scenarios I haven't thought of. Did you have anything
particular in mind Marcel?

I would really prefer if we could get the basics implemented with one modem
instance, and then look at the scenario with multiple modem instances as the
next step. For now I think we should only update the Dbus-API so that more
than one object path can be handled. Would this be acceptable to you Marcel?


Regards,
Sjur

--===============0505736546349717040==--

