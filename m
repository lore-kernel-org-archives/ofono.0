Content-Type: multipart/mixed; boundary="===============1616438603650434322=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: Port ofono-phonesim to Qt5
Date: Sun, 27 Oct 2019 02:04:18 +0200
Message-ID: <20191027000425.14022-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1616438603650434322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear ofono maintainers,

This is the minimal set of patches required to port ofono phonesim to Qt5,
based on previous work from openembedded (https://layers.openembedded.org/l=
ayerindex/recipe

The original patches from openembedded have been preserved in order to keep
authorship information.

In order to ease porting to the upcoming Qt6, I have prepared additional
refactoring patches, which port away from deprecated APIs and make use
of c++11 features like override to make finding porting issues less difficu=
lt.
I'll send those in a seperate email if there is interest.

Kind regards,
Jonah



--===============1616438603650434322==--

