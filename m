Content-Type: multipart/mixed; boundary="===============4811854312487540179=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 0/6] Packet bearers (version 6)
Date: Thu, 20 Jan 2011 10:37:31 +0200
Message-ID: <201101201037.31234.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4811854312487540179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds support for current packet switched bearers in the connect=
ion =

manager.

 doc/connman-api.txt    |   10 ++++++++++
 drivers/atmodem/gprs.c |   33 +++++++++++++++++++++++++++++++++
 include/gprs.h         |    1 +
 src/common.c           |   27 +++++++++++++++++++++++++--
 src/common.h           |   13 +++++++++++++
 src/gprs.c             |   27 +++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 2 deletions(-)

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============4811854312487540179==--

