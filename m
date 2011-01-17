Content-Type: multipart/mixed; boundary="===============1432600918660275565=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Mon, 17 Jan 2011 19:39:13 +0100
Message-ID: <AANLkTik_iqS0+hwV5OyaENQ40mY16n3-wWEVLV2XLVU7@mail.gmail.com>
In-Reply-To: <AANLkTi=AOhqrCET83GrJ3pYHdZOSfkmEGV-qQMJyCbRS@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1432600918660275565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Pekka Pessi <ppessi@gmail.com> wrote:
> The 27.007 for release 9 (from version 9.3.0 onwards) says:
>
> NOTE 1: The <cid>s for network-initiated PDP contexts will have values
> outside the ranges indicated for the
> <cid> in the test form of the commands +CGDCONT and +CGDSCONT.
>
> The change was proposed by STE last February.
>
> This has some ramifications on how we use the CIDs within driver/core.

I'm not sure we have any problems with Network Initiated Connection in oFon=
o,
unless someone is planning to add support for Network Initiated
Primary Contexts /
PDN Connections. Because the Network Initiated Contexts we are dealing with
will be Secondary PDP Contexts / Dedicated Bearers.

If we need to expose information about the Network Initiated Dedicated Bear=
ers,
I don't think we should model this as separate Connection-Contexts (with CI=
D),
but rather as a dictionary within the primary context object containing
the necessary information about the QoS available.

I guess we need to hear from IMS-folks the minimum information they
need about the QoS, and provide just that information.

Regards,
Sjur

--===============1432600918660275565==--

