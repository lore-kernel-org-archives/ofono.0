Content-Type: multipart/mixed; boundary="===============4521133892761807082=="
MIME-Version: 1.0
From: Anthony CROLAIS <anthony.crolais.yw@rdf.renesas.com>
Subject: RE: support of "emergency call when SIM not inserted" ?
Date: Thu, 23 Sep 2010 17:27:13 +0200
Message-ID: <A9AC1023FCA4654D92AC24C2A8F6A09201B0155B@renesas4bis.renesas-rdf.local>
In-Reply-To: <4C9B6ED0.5010607@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4521133892761807082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,

It is Ok for me, thanks. =

I read the Emergency Calls section in the TODO but I though the scope was l=
imited to a "SIM lock". As you suggest, it can also be applied to the case =
when no sim is inserted.

Regards,
Anthony


-----Message d'origine-----
De=C2=A0: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Envoy=C3=A9=C2=A0: jeudi 23 septembre 2010 17:14
=C3=80=C2=A0: ofono(a)ofono.org
Cc=C2=A0: Anthony CROLAIS
Objet=C2=A0: Re: support of "emergency call when SIM not inserted" ?

Hi Anthony,

> =

> I need a clarification about SIM:
> =

> Most GSM mobile phones can dial emergency calls even when the phone is wi=
thout a SIM card.
> =

> But it seems that oFono does not support an emergency call if the sim dri=
ver is present but no SIM is inserted:
> =


This used to be supported, but was broken by the new Online state
changes.  Basically we need a way to trigger Online state when an
emergency call is dialed, but remain in Offline state if the SIM is not
inserted / locked.

Please see the Emergency Calls section in the TODO list.

Regards,
-Denis

--===============4521133892761807082==--

