Content-Type: multipart/mixed; boundary="===============8640509958325529445=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] CDMA ConnMan API: add username and password for PPP
 authentication.
Date: Wed, 20 Jul 2011 11:52:50 +0200
Message-ID: <1311155571.21109.193.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F05F0B@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8640509958325529445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Betrand,

> >as with the previous attempt to add these fields, are they really really
> >needed? Or is an empty username + password in CHAP also working just
> >fine?
> =

> They are really needed.
> =

> >For GPRS for example all operators are just ignoring these values. At
> >least the few I have known that required them, gave up on it by now.
> =

> We are in Indonesia, and for AHA operator, we have to give a username and=
 a password. If we do not specify them, the PPP negotiation fails.

Have you tried empty strings like "". Have you tried random values? Do
they have to be really specific ones.

Is the password checked? Or just the username? Maybe they treat the
username as pseudo APN of some sort, but the password means nothing.

> >So please try with an empty username + password and show us logs of what
> >is happening on a real network.
> =

> Which log? Pppd log?

OFONO_PPP_DEBUG for starters. And then using cdmadial to create a full
pppdump compatible log would be good idea. Something that we can open in
Wireshark.

Regards

Marcel



--===============8640509958325529445==--

