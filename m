Content-Type: multipart/mixed; boundary="===============1790085275306962563=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH v2 0/6] Add a driver for u-blox modems
Date: Thu, 26 Jun 2014 20:28:12 +0200
Message-ID: <1403807298-14588-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1790085275306962563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v1:

 o Fix coding style nits and useless casts
 o Use prefixes
 o Make enable go to CFUN=3D4 (powered but radio off)


Philip Paeps (6):
  atmodem: add vendor u-blox
  udevng: add detection logic for u-blox modems
  plugins: new driver for u-blox SARA-U270 modems
  sim: query u-blox PIN retries with AT+UPINCNT
  gprs: add support for u-blox +UREG URCs
  atmodem: set the auth method for u-blox modems

 Makefile.am                    |    3 +
 drivers/atmodem/gprs-context.c |   31 ++++-
 drivers/atmodem/gprs.c         |   44 ++++++
 drivers/atmodem/sim.c          |   45 +++++++
 drivers/atmodem/vendor.h       |    3 +-
 plugins/ublox.c                |  291 ++++++++++++++++++++++++++++++++++++=
++++
 plugins/udevng.c               |   42 ++++++
 7 files changed, 455 insertions(+), 4 deletions(-)
 create mode 100644 plugins/ublox.c

-- =

1.7.10.4


--===============1790085275306962563==--

