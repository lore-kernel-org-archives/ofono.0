Content-Type: multipart/mixed; boundary="===============3740529426386490646=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono - Quering PIN authentication state failed
Date: Wed, 26 May 2010 11:56:04 -0500
Message-ID: <201005261156.04279.denkenz@gmail.com>
In-Reply-To: <AANLkTilrDCmb5s735_01prvlHfsT-qS5GNZ2Q6_QexiY@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3740529426386490646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

> phonesim working, mainly had to guess the argument list. But now that
> things are rolling I am a bit more confident going ahead with my
> experiments. I am thinking of writing a README for phonesim. Do you
> think it will help somehow?

Patches of all kinds are always welcome.  Updated README / HACKING for =

phonesim would be excellent.

> =

> BTW, all the test scripts by default activate the modem[0] config so
> it is not possible to have 2 modems connected and tested through those
> scripts.
> =

> Do you think it might be an addition to modify the scripts to act
> interactively for modem selection?
> =


Some scripts already support giving the modem path on the command line (e.g=
. =

enable-modem).  You'd have to check if all of them do this or not.  But in =

general this behavior (and patches) would be desirable :)

Regards,
-Denis

--===============3740529426386490646==--

