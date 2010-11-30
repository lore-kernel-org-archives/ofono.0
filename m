Content-Type: multipart/mixed; boundary="===============1807368659624392547=="
MIME-Version: 1.0
From: Remi.Denis-Courmont@nokia.com
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Tue, 30 Nov 2010 09:20:15 +0100
Message-ID: <1291105215.14343.14.camel@Nokia-N900-51-1>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1807368659624392547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

----- Message d'origine -----
> > * AT+CPBR and friends is hooked to the phonebook, which is Qt-based,
> and
> > therefore inadequate inside oFono.
>
> I am not buying into the AT+CPBR for the local and user specific
> phonebook. That one is inside Tracker anyway and also inside the user
> session. Trying to really support this is a broken idea. CPBR can not
> expose the information of modern contacts storage anyway, so just don't
> bother.

I can see how AT+CPBW could be problematic, more so than AT+CPBR. But that =
is not relevant. If a big enough customer wants it badly enough, it has to =
be done. I do not want to end up with an architecture that forbids satisfyi=
ng some of my employer's potential major customers. =


> If you really care about it then use Bluetooth PBAP via obexd which we
> have enabled already.

> > * At Nokia, we also have some non-standard commands for internal use.
> > * Some operators require some funky AT commands of their own. It might
> not be
> > possible to open-source them, even if we want to.
>
> And these should be on an engineering mode only USB CDC ACM interface
> with a different backend anyway.

I already mentioned that the same software must run in certification and in=
 user's hands for "whole device" certification to be valid. But anyway, som=
e of those commands were requested as DUN extensions, not as testing stuff.=
 So no no no.

> Only because someone wants to shoehorn this into something nasty,
> doesn't mean we should do it. And I am not going to scarifies the
> simplicity of the oFono D-Bus API for this.

We are talking about the Originated boolean call property?!

-- =

R=C3=A9mi
--===============1807368659624392547==--

