Content-Type: multipart/mixed; boundary="===============1156693873424693646=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v2 0/5] lte atom proto and authentication
Date: Fri, 12 Oct 2018 10:14:47 +0200
Message-ID: <20181012081452.19086-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1156693873424693646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Second version of the lte atom, with selection of protocol and authenticati=
on.
In this version the settings are applied as soon as a property is changed.

Giacinto Cifelli (5):
  lte-api: protocol and authentication properties
  lte.h: added proto and authentication handling
  src/lte: added proto and authentication handling
  atmodem/lte: proto and authentication handling
  Gemalto contributors so far

 AUTHORS               |   2 +
 doc/lte-api.txt       |  39 +++++++
 drivers/atmodem/lte.c |  92 ++++++++++++++--
 include/lte.h         |   5 +
 src/lte.c             | 236 ++++++++++++++++++++++++++++++++----------
 5 files changed, 307 insertions(+), 67 deletions(-)

-- =

2.17.1


--===============1156693873424693646==--

