Content-Type: multipart/mixed; boundary="===============5357362969739985081=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 0/2] More generic support of Telit xE910 family
Date: Thu, 26 Jan 2017 17:22:51 +0100
Message-ID: <20170126162253.25442-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5357362969739985081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Telit xE910 is a family of modems from 2g (GE910) through 3.5g
(HE910, UE910, DE910) to 4g (LE910).
They share a common programming interface.
So move he910 plugin to more generic xe910
and add support for UE910 (i was able to test on it).
Also differentiate between variants in terms of voice calling
and built-in GPS.

Piotr Haber (2):
  plugins: rename he910 to xe910
  plugins: Handle HE910 and UE910 variants

 Makefile.am                  |   4 +-
 plugins/udevng.c             |   6 +-
 plugins/{he910.c =3D> xe910.c} | 237 ++++++++++++++++++++++++++++++++-----=
------
 3 files changed, 183 insertions(+), 64 deletions(-)
 rename plugins/{he910.c =3D> xe910.c} (59%)

-- =

2.11.0


--===============5357362969739985081==--

