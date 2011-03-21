Content-Type: multipart/mixed; boundary="===============9100306537760869369=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Mon, 21 Mar 2011 08:44:14 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2D2FFD@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <4D8387CE.3050401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9100306537760869369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> On 03/18/2011 03:33 AM, Mika.Liljeberg(a)nokia.com wrote:
> > On this I agree. Stateless address autoconfiguration is =

> needed because it is mandatory in both IETF and 3GPP =

> standards (sorry for the repetition). Static configuration =

> (optional in IETF standards) may also be needed but that =

> remains to be seen. It depends on what kind of funky AT =

> modems are and will be out there.
> > =

> =

> So you seem to agree as well, and hence why our IPv6 API is the way it
> is right now.

The plugin API is ok'ish. I made a few improvement proposals and they still=
 stand. No major objections, though.

The motive for this discussion was your and Marcel's comments that you were=
 planning to disable IPv6 stateles address autoconfiguration. On that I mos=
t definitely disagree. I hope I've managed to talk you out of it.

> >> In the end oFono's philosophy is to always err on the side =

> of 27.007.
> >> So far this strategy has never been (completely) wrong.
> > =

> > 27.007 provides a nice checklist for the functionality of =

> the modem, so in that sense you're right. In another way it =

> also serves as a lowest common denominator for the same =

> functionality. However, what 27.007 does not do is specify =

> system behaviour. It's easy to jump to conclusions just by =

> looking at what AT commands are available. Most of the =

> commands are optional, because a lot of freedom has =

> intentionally been left for the implementors. It is also why, =

> IMO, the specification is so bad and we have to fight with =

> all these quirky AT modem implementations.
> >
> =

> Unfortunately that ship has sailed.  Every vendor except Nokia uses AT
> command modems, or at least implements a (somewhat) full-featured AT
> backend.  oFono is not about to start inventing its own standard and
> then try to merge differences between e.g. ISI 2.0, ISI 2.5, AT
> commands, CAIF, QCDM, etc.  If the industry couldn't agree on a proper
> standard protocol, then I doubt oFono will be able to.  And we're not
> about to start switch/casing modem types in the core.  That =

> way leads to
> chaos.
> =

> We chose this path two years ago and have been pretty successful with
> it.  Complaining about this now is the wrong time.  If your =

> protocol is
> different from 27.007, then it just means extra pain for the modem
> driver writer.  But as you mentioned, 27.007 is the lowest common
> denominator and the vendor specific protocols are richer.  So
> implementing 27.007 behavior is usually workable (though not =

> always easy)

I believe you completely missed the thrust of my comments there. This is no=
t about 27.007 vs some other modem interface. My point, again, is that 27.0=
07 does not specify system behaviour. You need to read a bunch of other 3GP=
P specs as well in order to understand the requirements for oFono. Otherwis=
e you will come up with weird and disturbing ideas like "let's disable stat=
eless IPv6 address autoconfiguration", which are completely against 3GPP st=
andards.

As for being successful, I don't think that has been put to the test yet. T=
here's an implementation out there and the oFono project has gained decent =
momentum, which is good. However, oFono can only be called mature when ther=
e are more than a few oFono based smart phones on the marked, having passed=
 all the certification tests, having met operator requirements and gained o=
perator approvals for their sales channels, as well as having gained custom=
er approval. That's a long road still. Not that it couldn't be done.

> The core tries to help you whenever possible here and deviates from
> 27.007 when really necessary, but I'm not tempted to stray =

> too far from
> it.  Don't get me wrong, 27.007 is a pain and you've seen me =

> complaining
> about its 'peculiarities' often, but it is the best thing we =

> have right now.

I think it's natural that you use 27.007 as a guideline for the plugin inte=
rface, for the reasons you mention. It is not a sufficient guideline for oF=
ono core behavour, however. For that you also need to understand the signal=
ling protocols between MS and core network. Understanding the protocols wil=
l help you understand how the MT behaves and how oFono core should behave.

> > Remember that 3GPP standards specify the behavour between =

> MS and the nework. I.e., they place requirements on both TE =

> and MT. The AT interface (TA function) stands in between and =

> the combination of TE+TA+MT must function in accordance to =

> 3GPP standards. My point is, you *really* need to read other =

> 3GPP specification, like 23.060 and 24.008, in order to =

> understand what requirements 3GPP places on oFono. Reading =

> 27.007 will not tell you that.
> > =

> =

> I think everyone here knows that, but in the end 27.007 =

> weighs in above
> all others because that is what everyone implements in the end.

Perhaps everyone knows it but has everyone actually read the other standard=
s I mentioned? Sometimes I wonder. What everyone is required to implement i=
n the end is 3GPP standards, only one of which is 27.007. =


Br,

	MikaL

--===============9100306537760869369==--

