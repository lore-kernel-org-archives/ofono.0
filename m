Content-Type: multipart/mixed; boundary="===============5903061949620829696=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Fri, 18 Mar 2011 08:33:44 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2D28A2@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <4D822082.3070302@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5903061949620829696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, =


> > Disabling IPv6 stateless address would be a bold move =

> indeed, since it is declared mandatory in both IETF and 3GPP =

> standards. Please see [RFC4294] and [3GPP 23.060]. The =

> section "Dynamic IPv6 Address Allocation" in 23.060 is very =

> clear on how IPv6 address allocation in 3GPPP networks is =

> done. See also the section about IPv6 prefix delegation =

> (relevant to IPv6 tethering) and applicable parts of 24.008.
> > =

> =

> This still needs to be figured out.  We are aware that =

> autoconfiguration
> is mandatory in 3GPP.  However, this seems to be going against 27.007.

There is no contradiction. Let me explain what I mean. The 3GPP standards m=
ostly talk about MS (mobile station) which comprises of both TE and MT (ter=
minal equipment and modem terminal). As such, 3GPP specifications place req=
uirements on both TE and MT. The 27.007 defines a TA (terminal adapter), wh=
ich is one possible interface between TE and MT. However, 27.007 is not man=
datory, vendor specific interfaces are also allowed. As a consequence other=
 interfaces, such as ISI and CAIF, also exist.

While stateless address autoconfiguration is mandatory for MS, a funky AT m=
odem could potentially have an internal IPv6 stack as part of the TA functi=
on and perform address configuration against the network and then proxy any=
 IPv6 traffic between the TE and the network. This would meet the requireme=
nts of 3GPP. The *intent* in the 3GPP standards is that TEs can behave as s=
tandard IPv6 hosts (so PCs can use a standard IPv6 stack), which means that=
 the TE is expected to run the autoconfiguration protocols against the netw=
ork in the normal case. Nothing in 27.007 specifically prevents that. The s=
tatic address configuration parameters in the AT commands are optional and =
will simply be missing, if the modem just acts as a bitpipe between TE and =
the network, allowing the TE to run its IPv6 stack in the normal way.

However, a funky AT modem that implements an IPv6 stack internally and expo=
ses static address configuration parameters towards TE is certainly possibl=
e. Such a modem would presumably also block the router advertisements comin=
g from the network, which would effectively disable stateless address autoc=
onfiguration for the TE. This is not something you need or should do in con=
nman. Standard IPv6 stack is sufficient.

> So in the end both might be required.

On this I agree. Stateless address autoconfiguration is needed because it i=
s mandatory in both IETF and 3GPP standards (sorry for the repetition). Sta=
tic configuration (optional in IETF standards) may also be needed but that =
remains to be seen. It depends on what kind of funky AT modems are and will=
 be out there.

> In the end oFono's philosophy is to always err on the side of 27.007.
> So far this strategy has never been (completely) wrong.

27.007 provides a nice checklist for the functionality of the modem, so in =
that sense you're right. In another way it also serves as a lowest common d=
enominator for the same functionality. However, what 27.007 does not do is =
specify system behaviour. It's easy to jump to conclusions just by looking =
at what AT commands are available. Most of the commands are optional, becau=
se a lot of freedom has intentionally been left for the implementors. It is=
 also why, IMO, the specification is so bad and we have to fight with all t=
hese quirky AT modem implementations.

Remember that 3GPP standards specify the behavour between MS and the nework=
. I.e., they place requirements on both TE and MT. The AT interface (TA fun=
ction) stands in between and the combination of TE+TA+MT must function in a=
ccordance to 3GPP standards. My point is, you *really* need to read other 3=
GPP specification, like 23.060 and 24.008, in order to understand what requ=
irements 3GPP places on oFono. Reading 27.007 will not tell you that.

Regards,

	MikaL

--===============5903061949620829696==--

