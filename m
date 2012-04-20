Content-Type: multipart/mixed; boundary="===============6188742681901583365=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: scan problem
Date: Fri, 20 Apr 2012 08:01:00 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E18AA282F@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <4F910B54.2020103@fairwaves.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6188742681901583365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > Can you please give more details?
> =

> Sure thing but I'll need some guidance on how obtain relevant information=
 since
> I'm complete newbie to ofono stack.

No problem.

> Btw, I'm trying to use this monstrous http://shop.sysmocom.de/products/lo=
ad-
> tester16
> assembly :)
> =

> > Is your modem enabled and online?
> =

> I think so - at least "./enable-modem /wavecom_q_0" returned no errors and
> changed modem status to following:
> =

> [ /wavecom_q_0 ]
>     Features =3D sim
>     Emergency =3D 0
>     Powered =3D 1
>     Lockdown =3D 0
>     Interfaces =3D org.ofono.SimManager
>     Online =3D 0
>     Type =3D hardware
>     [ org.ofono.SimManager ]
>         Retries =3D
>         FixedDialing =3D 0
>         SubscriberNumbers =3D
>         BarredDialing =3D 0
>         LockedPins =3D
>         PinRequired =3D none
>         Present =3D 1

Ok,  so your modem is enabled, but not online (Online =3D 0).

You should online it by doing "./online-modem /wavecom_q_0"

> > Can you please attach a log?
> =

> Adding -n -d to ofonod revealed nothing interesting besides absence of
> /etc/ofono/phonesim.conf - which seems unlikely to be the culprit. What's=
 the
> recommended procedure for log collection?

You can add a var arg OFONO_AT_DEBUG=3D1 to enable AT logging.

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============6188742681901583365==--

