Content-Type: multipart/mixed; boundary="===============5116551349710796831=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [RFC PATCH 1/1] ublox: create only 1 gprs context
Date: Sat, 16 Mar 2019 07:41:46 +0100
Message-ID: <398bcef8-2d47-3bed-5d7b-223d016180c7@norrbonn.se>
In-Reply-To: <e3343eef-12ff-4f9f-10dd-5ec0a3392e21@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5116551349710796831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 15/03/2019 17:28, Denis Kenzior wrote:

<snip>

> =

> uBlox is just being too smart here.=C2=A0 The whole bridged vs router stu=
ff =

> was never intended by 27.007.=C2=A0 They made this all up themselves. Nei=
ther =

> oFono nor ConnMan were designed to handle such a setup.
> =

> The main issue will be for contexts used for MMS / OMA DM.=C2=A0 My memor=
y =

> from the Meego / Tizen days is fuzzy, but from what I recall we designed =

> oFono with the assumption that we will always get an IP address and a =

> separate interface for the MMS context.
> =

> There's also the proxy.=C2=A0 MMS contexts frequently have a proxy associ=
ated =

> with them.=C2=A0 Again, we assumed that if a proxy is set, then it is als=
o in =

> a form of an IP address.=C2=A0 The proxy is then added as a route on the =

> interface by oFono (see pri_setproxy for details).=C2=A0 And in practical =

> terms there is no domain name resolution for these contexts.=C2=A0 Everyt=
hing =

> just goes to the proxy.
> =

> This was how e.g. mmsd was designed to work.=C2=A0 See =

> https://git.kernel.org/pub/scm/network/ofono/mmsd.git.=C2=A0 That project=
 has =

> not been touched in some time though, but there are others that act very =

> similar.
> =


OK, thanks for digging that out despite the cobwebs!

So, this is where I end up then:

i)  MMS (and other) contexts are just IP endpoints, but they are all =

identified by a "type"
ii)  connman handles "Internet" contexts and ignores everything else...
iii) other applications (like mmsd) handle contexts of other types
iv)  mmsd, unlike connman, expects the network interface associated with =

the context to be fully configured... IP address, route, etc.

ofono is designed to expect a network interface for each context.  For =

this reason, it's pretty heavy-handed in its setup of the interface:  it =

assumes the interface isn't shared by other contexts and isn't careful =

about maintaining settings coming from other contexts.

So the real impedance mismatch here for the case where a modem puts =

multiple contexts behind a single network interface is the way ofono is =

implemented.

ofono could be re-implemented here to add multiple IP addresses to a =

single interface and to set routing accordingly (for MMS contexts only, =

apparently... it looks like ofono does nothing currently for other =

context types).

Another alternative is to have the gprs-context driver for affected =

devices create "virtual network devices" (is this still a thing?) with =

static IP addresses for all contexts.  For the u-blox "router mode" =

case, though, I can't figure out who runs the DHCP client... (and the =

TOBY L4 is router-mode-only, so requiring bridge-mode is not an option).

Either way, this is a reasonably big undertaking.  I don't think I want =

to take this on without a concrete use-case presenting itself, first! :)

So given that, the right thing to do here is probably to just drop =

multiple context support from the u-blox driver until ofono is modified =

(someday) to handle multiple contexts behind a single network interface. =

  I will send a patch.

/Jonas

--===============5116551349710796831==--

