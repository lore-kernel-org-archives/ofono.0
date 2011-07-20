Content-Type: multipart/mixed; boundary="===============8218034375159341208=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] CDMA ConnMan API: add username and password for PPP
 authentication.
Date: Wed, 20 Jul 2011 10:47:40 +0100
Message-ID: <568DE01DA537804BA73470071BAC288938F05F0B@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1311154809.21109.184.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8218034375159341208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>as with the previous attempt to add these fields, are they really really
>needed? Or is an empty username + password in CHAP also working just
>fine?

They are really needed.

>For GPRS for example all operators are just ignoring these values. At
>least the few I have known that required them, gave up on it by now.

We are in Indonesia, and for AHA operator, we have to give a username and a=
 password. If we do not specify them, the PPP negotiation fails.

>So please try with an empty username + password and show us logs of what
>is happening on a real network.

Which log? Pppd log?

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


--===============8218034375159341208==--

