Content-Type: multipart/mixed; boundary="===============4562839951262680602=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 0/6] Add a driver for u-blox modems
Date: Tue, 24 Jun 2014 19:10:07 +0200
Message-ID: <1403629813-62204-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4562839951262680602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patches adds basic support for u-blox modems.  It has only
been tested with a u-blox SARA U270 modem but judging from the datasheet
it should be fairly trivial to adapt to other variants of the SARA, LISA
and LEON chips.


Philip Paeps (6):
  atmodem: add vendor u-blox
  udevng: add detection logic for u-blox modems
  plugins: new driver for u-blox SARA-U270 modems
  sim: query u-blox PIN retries with AT+UPINCNT
  gprs: add support for u-blox +UREG URCs
  atmodem: set the auth method for u-blox modems

 Makefile.am                    |    3 +
 drivers/atmodem/gprs-context.c |   29 +++-
 drivers/atmodem/gprs.c         |   44 ++++++
 drivers/atmodem/sim.c          |   45 +++++++
 drivers/atmodem/vendor.h       |    3 +-
 plugins/ublox.c                |  289 ++++++++++++++++++++++++++++++++++++=
++++
 plugins/udevng.c               |   42 ++++++
 7 files changed, 452 insertions(+), 3 deletions(-)
 create mode 100644 plugins/ublox.c

-- =

1.7.10.4


--===============4562839951262680602==--

