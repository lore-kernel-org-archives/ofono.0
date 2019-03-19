Content-Type: multipart/mixed; boundary="===============5489449006725965442=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/1] ublox: create only 1 gprs context
Date: Tue, 19 Mar 2019 10:26:38 -0500
Message-ID: <0fa17476-69a4-71bc-6ccb-2a7aaffba701@gmail.com>
In-Reply-To: <398bcef8-2d47-3bed-5d7b-223d016180c7@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5489449006725965442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

> OK, thanks for digging that out despite the cobwebs!

No worries.  Sorry I forgot to reply to this earlier.

> =

> So, this is where I end up then:
> =

> i)=C2=A0 MMS (and other) contexts are just IP endpoints, but they are all =

> identified by a "type"

Right now yes.  In theory you could have a DNS, routing, etc for these =

contexts as well.  In fact, once we introduce IMS contexts, this has to =

be done anyway.

> ii)=C2=A0 connman handles "Internet" contexts and ignores everything else=
...

Correct.

> iii) other applications (like mmsd) handle contexts of other types
> iv)=C2=A0 mmsd, unlike connman, expects the network interface associated =
with =

> the context to be fully configured... IP address, route, etc.

Correct, at least at the moment

> =

> ofono is designed to expect a network interface for each context.=C2=A0 F=
or =

> this reason, it's pretty heavy-handed in its setup of the interface:=C2=
=A0 it =

> assumes the interface isn't shared by other contexts and isn't careful =

> about maintaining settings coming from other contexts.

This is also what 3GPP intended, at least back in the multiplexing / =

27.010 days.  Now things become a bit more complex as you can tell. =

Intel modems do actually expose multiple pseudo-ethernet devices for this.

> =

> So the real impedance mismatch here for the case where a modem puts =

> multiple contexts behind a single network interface is the way ofono is =

> implemented.

Correct.

> =

> ofono could be re-implemented here to add multiple IP addresses to a =

> single interface and to set routing accordingly (for MMS contexts only, =

> apparently... it looks like ofono does nothing currently for other =

> context types).

This gets tricky, but I assume that for 'bridged' mode we would need to =

do this yes.

With router mode things become a bit simpler.  Likely the only thing =

needed on these is to just automagically setup routing for MMS/SIP =

proxies.  The only difference from what we have today would be that we =

need to remove the corresponding routes when the MMS context goes down =

(today oFono assumes that the entire interface is brought down) So it =

wouldn't be that hard to implement actually.  And since ConnMan ignores =

non-Internet contexts, things would probably just work.

Someone needs to test that theory though.  I don't have any ublox devices.

> =

> Another alternative is to have the gprs-context driver for affected =

> devices create "virtual network devices" (is this still a thing?) with =

> static IP addresses for all contexts.=C2=A0 For the u-blox "router mode" =

> case, though, I can't figure out who runs the DHCP client... (and the =

> TOBY L4 is router-mode-only, so requiring bridge-mode is not an option).

We have been contemplating for a long time that DHCP needs to move out =

of ConnMan and into the individual daemons, e.g. BlueZ, iwd, oFono.  I =

already started moving bits of DHCP into ell, but higher priority tasks =

came up.

There was an earlier thread where weird device behaviors were described =

(by Giacinto, I think?).  E.g. a device would not succeed in context =

activation until DHCP was run against the interface.  So supporting such =

devices with DHCP in ConnMan is a bit problematic and we have a fighting =

chance with DHCP in oFono.

> =

> Either way, this is a reasonably big undertaking.=C2=A0 I don't think I w=
ant =

> to take this on without a concrete use-case presenting itself, first! :)
> =


Device Provisioning, Firmware update, MMS, IMS :)

> So given that, the right thing to do here is probably to just drop =

> multiple context support from the u-blox driver until ofono is modified =

> (someday) to handle multiple contexts behind a single network interface. =

>  =C2=A0I will send a patch.

For now I think that is the right approach.

Regards,
-Denis

--===============5489449006725965442==--

