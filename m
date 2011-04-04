Content-Type: multipart/mixed; boundary="===============7574921577348158423=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: Trouble using Huwei E160G
Date: Mon, 04 Apr 2011 09:12:45 +0100
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75BFE7220E@irsmsx503.ger.corp.intel.com>
In-Reply-To: <4D9577BC.8030209@zirak.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7574921577348158423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>We work in a zone with limited utms coverage, some times it use gprs
>(green blinking led). The test 1 is the normal case with good umts coverag=
e, for test 2 i force gprs using for
>example a simple Faraday Cage.

If you use a Faraday Cage, you will lose all network capabilities, and not =
just UMTS.

According to oFono source code, Huwei modem doesn't support the radio setti=
ngs, so there is no way to 'force' UMTS or GPRS. So you will have what the =
network will assign to you, based on your coverage, and the network capabil=
ities.

So please do not use a Faraday Cage, this will not help at all.

Regards,

Bertrand.
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


--===============7574921577348158423==--

