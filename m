Content-Type: multipart/mixed; boundary="===============3111186506308109310=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 0/3] Attach GPRS on demand
Date: Thu, 09 Dec 2010 11:41:46 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC03025C@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <4D00AB70.10701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3111186506308109310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > ConnMan really should not care whether we are attached or =

> not. Why do you need a trigger in ConnMan, anyway? As far as =

> I can see, a GPRS connection should only be activated if some =

> client of ConnMan requests it.
> =

> Actually it should care.  We do safe-guard against attaching while
> roaming...

I don't think so. Preventing GPRS attach and GPRS context activation during=
 roaming can be done based on network registation status. Besides, oFono pr=
obably should be the component to enforce it, so that the feature cannot be=
 easily bypassed.

> Besides, ConnMan doesn't really work this way.  Maybe in the =

> future with
> the session API it would be able to, but not at the moment.  I'll let
> Marcel explain this more if he wants too..

Admittedly, I haven't really looked at ConnMan. My assumption, though, is t=
hat a PDP context is not activated by default when ConnMan starts up. I.e.,=
 someone has to request the internet connectivity. Is that correct? Activat=
ing a context by default would be very bad for power consumption and standb=
y times, unless both the handset and the network support CPC. The decision =
should be up to the user.

> >> Besides, 24.008 cause codes give us plenty of hints of =

> >> whether / when to
> >> re-attach, and only a few of them require 'special' handling.
> >>
> >> I still think that we should come up with some strategy to =

> re-attach
> >> automatically when detached by the network.
> > =

> > Even if you can come up with an algorithm, testing it is =

> very very challenging. There are plenty of differences in =

> operator networks and it is very difficult to cover all =

> cases. Making sure that the algorithm works requires =

> extensive IOT and Field testing. We really don't want a case, =

> where oFono fails to re-attach for whatever reason. We also =

> don't want the case where oFono has not yet attempted to =

> re-attach (e.g. on a timer) and a PDP context activation =

> fails, even though GPRS would actually be available.
> > =

> > For the above reasons, retrying attach on PDP context =

> activation makes sense as a safe-guard, regardless of whether =

> we have a re-attach algorithm or not. We use on-demand attach =

> in pretty much all our products (except for certain operator =

> specific variants) precisely because it is certain to work. =

> No funny business. If there is GPRS service, you get a =

> connection. It is also an approach that should work with any =

> AT modem as well.
> > =

> =

> You might be right, but I'd really like to see whether the re-attach
> algorithm would be good enough first...

But what re-attach algorithm? I sure don't have one up my sleeve...

As I said, extensive IOT and field testing (with mobility) is necessary in =
order to see how the prospective algorithm works in practise. Even then, yo=
u can't possibly cover all the angles. In practise, you end up discovering =
the rest of the glitches when the first products are already out there. Tha=
t is a very expensive road indeed for a feature that is a bit dubious to be=
gin with.

Why are we attaching to GPRS by default, anyway?

That said, various operators tend to have different requirements on this. S=
ome want autoattach, some want on-demand attach, and some want a UI for cha=
nging the mode. In practise we will probably need at least a variation poin=
t on this and possibly a setting to change the behaviour. I'd propose start=
ing by adding the on-demand attach code, to make sure that GPRS at least wo=
rks in all cases.

	MikaL

--===============3111186506308109310==--

