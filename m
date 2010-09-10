Content-Type: multipart/mixed; boundary="===============0486621381155680349=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/4] Add Suspended property to GPRS (take 3)
Date: Fri, 10 Sep 2010 16:50:55 +0300
Message-ID: <1284126659-18741-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0486621381155680349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Comments from Denis applied.

Br,

	MikaL

[PATCH 1/4] TODO: Claim ownership of Suspended property for GPRS
[PATCH 2/4] gprs: add Suspended property
[PATCH 3/4] isimodem: implement Suspended property
[PATCH 4/4] test: add enable-gprs and disable-gprs scripts

 TODO                     |    3 +-
 doc/connman-api.txt      |   19 ++++++++++++
 drivers/isimodem/debug.c |   25 ++++++++++++++++
 drivers/isimodem/debug.h |    2 +
 drivers/isimodem/gpds.h  |   17 +++++++++++
 drivers/isimodem/gprs.c  |   56 +++++++++++++++++++++++++++++++++++-
 include/gprs.h           |   10 ++++++
 src/gprs.c               |   72 ++++++++++++++++++++++++++++++++++++++++++=
++++
 test/disable-gprs        |   20 +++++++++++++
 test/enable-gprs         |   20 +++++++++++++
 10 files changed, 242 insertions(+), 2 deletions(-)

--===============0486621381155680349==--

