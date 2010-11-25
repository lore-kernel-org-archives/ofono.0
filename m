Content-Type: multipart/mixed; boundary="===============5113865539357528894=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [RFC] [PATCH 0/6] GPRS registration and bearer technology
Date: Thu, 25 Nov 2010 17:14:19 +0200
Message-ID: <201011251714.19241.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5113865539357528894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

	Hello,

The following patch series adds oFono core support to report the network
advertized data technology, and the per-context actual packet bearers.

R=C3=A9mi Denis-Courmont (6):
      Distinguish HSDPA, HSUPA or both as access technologies
      ConnectionManager: expose available data technology
      Update documentation for GPRS technology
      Define packet switched bearers
      Core support for packet switched bearer reporting
      Bearer documentation

 doc/connman-api.txt     |   18 +++++++++++++
 drivers/atmodem/gprs.c  |   18 ++++++------
 drivers/isimodem/gprs.c |    6 ++--
 include/gprs.h          |    4 +-
 src/common.c            |   18 ++++++++++++-
 src/common.h            |   13 +++++++++
 src/gprs.c              |   63 +++++++++++++++++++++++++++++++++++++++++++=
+--
 7 files changed, 121 insertions(+), 19 deletions(-)

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============5113865539357528894==--

