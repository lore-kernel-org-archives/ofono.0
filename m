Content-Type: multipart/mixed; boundary="===============2011850317054264797=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: RAT , signal Strength indication ofono 0.23
Date: Wed, 18 Aug 2010 10:33:38 +0200
Message-ID: <20100818083338.GB9818@pc0043.bmw-carit.intra>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D401870321E1E0E@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2011850317054264797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alain,

> In fact the property like CellId or LocationAreaCode are sometimes
> updated but the property Technology (RAT) is never indicated, in the
> other hand the property Strength is not updated when the signal
> strength of the cell change. Is sound like networkregistration API
> is not fully working or implemented ?

We know that most (all?) modems have problems with exporting certain
information. See for example Denis answer on the 'Monitor current
technology' patch [1].

I don't think NetworkRegistration API itself is not working, it sounds
more like a limitation from the modems or the drivers. Did you try to
use the latest release of ofono too?

daniel

[1] http://www.mail-archive.com/ofono(a)ofono.org/msg02981.html

--===============2011850317054264797==--

