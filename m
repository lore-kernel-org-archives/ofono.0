Content-Type: multipart/mixed; boundary="===============4314338231905054427=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 0/3] Attach GPRS on demand
Date: Thu, 09 Dec 2010 09:57:29 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC030131@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <4D009FC1.2050909@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4314338231905054427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > I'm not quite sure what you mean here. There are many =

> different cases, where the network can detach a UE from GPRS =

> service. See possible detach causes in 24.008. Currently, =

> oFono does not recover at all. Trying to figure out when GPRS =

> is again available can get pretty complicated and the =

> different detach causes require different handling. IMO, the =

> simplest approach by far is to retry GPRS attach when someone =

> actually needs a PDP context. =

> =

> So here's the problem, ConnMan is in charge of activating the =

> context on
> Meego.  ConnMan activates the context once we're attached.  So how do
> you expect your 'on-demand' re-attach to work exactly?

ConnMan really should not care whether we are attached or not. Why do you n=
eed a trigger in ConnMan, anyway? As far as I can see, a GPRS connection sh=
ould only be activated if some client of ConnMan requests it.

> Besides, 24.008 cause codes give us plenty of hints of =

> whether / when to
> re-attach, and only a few of them require 'special' handling.
> =

> I still think that we should come up with some strategy to re-attach
> automatically when detached by the network.

Even if you can come up with an algorithm, testing it is very very challeng=
ing. There are plenty of differences in operator networks and it is very di=
fficult to cover all cases. Making sure that the algorithm works requires e=
xtensive IOT and Field testing. We really don't want a case, where oFono fa=
ils to re-attach for whatever reason. We also don't want the case where oFo=
no has not yet attempted to re-attach (e.g. on a timer) and a PDP context a=
ctivation fails, even though GPRS would actually be available.

For the above reasons, retrying attach on PDP context activation makes sens=
e as a safe-guard, regardless of whether we have a re-attach algorithm or n=
ot. We use on-demand attach in pretty much all our products (except for cer=
tain operator specific variants) precisely because it is certain to work. N=
o funny business. If there is GPRS service, you get a connection. It is als=
o an approach that should work with any AT modem as well.

Br,

	MikaL

--===============4314338231905054427==--

