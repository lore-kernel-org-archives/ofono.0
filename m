Content-Type: multipart/mixed; boundary="===============0716585301016415491=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: oFono status?
Date: Wed, 05 May 2010 12:16:55 +0300
Message-ID: <1273051015.31935.24.camel@tucson.research.nokia.com>
In-Reply-To: <60A0044626BD4F4B98AFAA96AB19D35E3B5FAE9709@EXDCVYMBSTM006.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0716585301016415491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-04 at 13:41 +0200, ext Mats BERGSTROM wrote:
> What is the plans for the oFono in conjunction with the MeeGo project?

It's clear that oFono is the host telephony stack on MeeGo. Details are
still open, though. For instance, which version of oFono will ship with
which version of MeeGo has not been decided yet.

> Being one of the basic components of the MeeGo, what is the current
> status today and are there any components lacking for it to be
> production level?  If so, what do the plans look like for bringing it
> to that?

This depends a bit on the modem. In general AT modem support is in a
better shape than the ISI modem support at the moment. Some AT modems
are better supported than others.

As to "production level", I think there may be minor bits and pieces
missing, but overall a lot of the standard features are present. Apart
from the code itself, there's quite a bit of testing and validation,
including official certification that one would need to do in order to
use oFono in products.

Cheers,
Aki



--===============0716585301016415491==--

