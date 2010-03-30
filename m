Content-Type: multipart/mixed; boundary="===============6943930894714383027=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 13:05:48 -0500
Message-ID: <201003301305.49366.denkenz@gmail.com>
In-Reply-To: <a32762a21003301037t17c119afq7eec0decc772755c@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6943930894714383027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> 2010/3/30 Denis Kenzior <denkenz@gmail.com>:
> > The answer is that exposing this as a property is not going to happen
> > because it is fundamentally wrong.  And in effect it already is exposed,
> > e.g. the fact that modem object is present in oFono.  You have several
> > options here:
> =

> So I think what you are saying is that if a modem object exists, it is
> available. That is, the HW has been powered up and initialized
> properly. And that the Powered property is about whether or not the
> modem's cellular is active (RF on/off).

Powered is about whether the modem is useable.  Today we don't make a =

distinction between tx/rx off with sim, tx/rx off without sim, or fully act=
ive.

We need to look closely at whether enabling flight mode (e.g. SIM on, while =

TX/RX is off) makes sense.  It is something we should consider, but challen=
ging =

since most of the SIM attributes are exposed through atoms which won't be =

generally available when in Flight mode (e.g. SMSC address on SIM atom, MBD=
N =

on message waiting, etc)

> =

> If this is the case, then I think it'll do.
> =

> There is a corner case when the modem is borked and cannot be properly
> powered but needs to be taken to a care point (not that that ever
> happens IRL ;), and I would rather see this indicated explicitly
> rather than implicitly by ModemManager returning an empty list of
> modems.

So finally someone tells me an actual use case, how hard was that? :)  It i=
s =

still possible to expose this information on the interface provided by your =

custom plugin, I'm against exposing this as a property on Modem interface.

Regards,
-Denis

--===============6943930894714383027==--

