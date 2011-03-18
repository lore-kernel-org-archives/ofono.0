Content-Type: multipart/mixed; boundary="===============5010882778657743508=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Fri, 18 Mar 2011 11:26:54 -0500
Message-ID: <4D8387CE.3050401@gmail.com>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC2D28A2@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5010882778657743508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 03/18/2011 03:33 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Denis, =

> =

>>> Disabling IPv6 stateless address would be a bold move =

>> indeed, since it is declared mandatory in both IETF and 3GPP =

>> standards. Please see [RFC4294] and [3GPP 23.060]. The =

>> section "Dynamic IPv6 Address Allocation" in 23.060 is very =

>> clear on how IPv6 address allocation in 3GPPP networks is =

>> done. See also the section about IPv6 prefix delegation =

>> (relevant to IPv6 tethering) and applicable parts of 24.008.
>>>
>>
>> This still needs to be figured out.  We are aware that =

>> autoconfiguration
>> is mandatory in 3GPP.  However, this seems to be going against 27.007.
> =

> There is no contradiction. Let me explain what I mean. The 3GPP standards=
 mostly talk about MS (mobile station) which comprises of both TE and MT (t=
erminal equipment and modem terminal). As such, 3GPP specifications place r=
equirements on both TE and MT. The 27.007 defines a TA (terminal adapter), =
which is one possible interface between TE and MT. However, 27.007 is not m=
andatory, vendor specific interfaces are also allowed. As a consequence oth=
er interfaces, such as ISI and CAIF, also exist.
>

No arguments here

> While stateless address autoconfiguration is mandatory for MS, a funky AT=
 modem could potentially have an internal IPv6 stack as part of the TA func=
tion and perform address configuration against the network and then proxy a=
ny IPv6 traffic between the TE and the network. This would meet the require=
ments of 3GPP. The *intent* in the 3GPP standards is that TEs can behave as=
 standard IPv6 hosts (so PCs can use a standard IPv6 stack), which means th=
at the TE is expected to run the autoconfiguration protocols against the ne=
twork in the normal case. Nothing in 27.007 specifically prevents that. The=
 static address configuration parameters in the AT commands are optional an=
d will simply be missing, if the modem just acts as a bitpipe between TE an=
d the network, allowing the TE to run its IPv6 stack in the normal way.
> =

> However, a funky AT modem that implements an IPv6 stack internally and ex=
poses static address configuration parameters towards TE is certainly possi=
ble. Such a modem would presumably also block the router advertisements com=
ing from the network, which would effectively disable stateless address aut=
oconfiguration for the TE. This is not something you need or should do in c=
onnman. Standard IPv6 stack is sufficient.
> =

>> So in the end both might be required.
> =

> On this I agree. Stateless address autoconfiguration is needed because it=
 is mandatory in both IETF and 3GPP standards (sorry for the repetition). S=
tatic configuration (optional in IETF standards) may also be needed but tha=
t remains to be seen. It depends on what kind of funky AT modems are and wi=
ll be out there.
> =


So you seem to agree as well, and hence why our IPv6 API is the way it
is right now.

>> In the end oFono's philosophy is to always err on the side of 27.007.
>> So far this strategy has never been (completely) wrong.
> =

> 27.007 provides a nice checklist for the functionality of the modem, so i=
n that sense you're right. In another way it also serves as a lowest common=
 denominator for the same functionality. However, what 27.007 does not do i=
s specify system behaviour. It's easy to jump to conclusions just by lookin=
g at what AT commands are available. Most of the commands are optional, bec=
ause a lot of freedom has intentionally been left for the implementors. It =
is also why, IMO, the specification is so bad and we have to fight with all=
 these quirky AT modem implementations.
>

Unfortunately that ship has sailed.  Every vendor except Nokia uses AT
command modems, or at least implements a (somewhat) full-featured AT
backend.  oFono is not about to start inventing its own standard and
then try to merge differences between e.g. ISI 2.0, ISI 2.5, AT
commands, CAIF, QCDM, etc.  If the industry couldn't agree on a proper
standard protocol, then I doubt oFono will be able to.  And we're not
about to start switch/casing modem types in the core.  That way leads to
chaos.

We chose this path two years ago and have been pretty successful with
it.  Complaining about this now is the wrong time.  If your protocol is
different from 27.007, then it just means extra pain for the modem
driver writer.  But as you mentioned, 27.007 is the lowest common
denominator and the vendor specific protocols are richer.  So
implementing 27.007 behavior is usually workable (though not always easy)

The core tries to help you whenever possible here and deviates from
27.007 when really necessary, but I'm not tempted to stray too far from
it.  Don't get me wrong, 27.007 is a pain and you've seen me complaining
about its 'peculiarities' often, but it is the best thing we have right now.

> Remember that 3GPP standards specify the behavour between MS and the newo=
rk. I.e., they place requirements on both TE and MT. The AT interface (TA f=
unction) stands in between and the combination of TE+TA+MT must function in=
 accordance to 3GPP standards. My point is, you *really* need to read other=
 3GPP specification, like 23.060 and 24.008, in order to understand what re=
quirements 3GPP places on oFono. Reading 27.007 will not tell you that.
> =


I think everyone here knows that, but in the end 27.007 weighs in above
all others because that is what everyone implements in the end.

Regards,
-Denis

--===============5010882778657743508==--

