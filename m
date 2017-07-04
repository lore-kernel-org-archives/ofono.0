Content-Type: multipart/mixed; boundary="===============0154417602642675861=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: ofono 1.20 issues found with valgrind
Date: Tue, 04 Jul 2017 11:17:40 +0200
Message-ID: <0896852b-f519-1932-88a5-bc43e8311447@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0154417602642675861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

When we started using ofono 1.20 for osmo-gsm-tester a few month ago me =

noticed it often crashed due to some memory corruption, so I started =

running ofono for a while with valgrind to see if I could see potential =

issues. It indeed helped us solve the issue (fixed in =

2d6c4f9d02152a3a3907ddb93e2a5d2791a15710). Since then, ofono seems to be =

more stable and crashing only on occasional times.

While fixing the above issue, I run into a lot of other valgrind issues =

which I recorded in [1]. I don't think we are going to solve them soon =

because they are not critical to us unless they prevent us to run ofono. =

However, if someone with good knowledge on the code is willing to have a =

look and fix them, please feel free to do it.

[1] https://osmocom.org/issues/2236


-- =

- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte

--===============0154417602642675861==--

