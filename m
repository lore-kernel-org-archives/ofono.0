Content-Type: multipart/mixed; boundary="===============5166290192709963584=="
MIME-Version: 1.0
From: Remi.Denis-Courmont@nokia.com
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Tue, 30 Nov 2010 12:17:43 +0100
Message-ID: <1291115863.15568.2.camel@Nokia-N900-51-1>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5166290192709963584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

----- Message d'origine -----
> do me a favor and try not to break the threading next time.

When I am away from my laptop, I use whatever MUA I can. This is obviously =
not deliberate a choice.

> I am getting a bit sick of this secrecy. oFono is for all intense and
> purposes open source.

And I am sick of arguing for something as simple and obvious as exposing th=
e call direction in the calls list.

> So if you want a proper discussion here then
> please list the AT command in question.

Operator requirements are typically confidential. Since they are copyighted=
 by their originator, not by me or my employer, I cannot fix that. Or rathe=
r, I can try (it is ongoing) but I cannot promise anything.

But this is only a side issue. We have a working AT commands DCE implementa=
tion that supports both cellular/oFono stuff and all the other that we need=
. Open-sourcing as much as we can is an ongoing process. I am not intereste=
d in rewriting that (and the BlueZ HFP code) into oFono just for the heck o=
f it.

Furthermore providing some useful features (like call direction) only via a=
 would-be oFono AT commands but not via the _preferred_ D-Bus interface see=
ms silly and counter-productive to me.

-- =

R=C3=A9mi
--===============5166290192709963584==--

