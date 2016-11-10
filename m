Content-Type: multipart/mixed; boundary="===============7144799991802826457=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH v2 0/9] add LTE atom
Date: Thu, 10 Nov 2016 17:55:47 +0100
Message-ID: <1478796956-22500-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7144799991802826457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset adds a simple LTE atom. It can only set the default
APN. But it's meant to be easily extensible in the future.

The atom exposes a per modem D-Bus interface. It also uses the
oFono persistent configuration store.

The patchset contains:
* lte atom implementation
* U-Blox Toby L2 lte driver implementation
* script for setting the lte properties

The last patches contain the implementation of the TobyL2 driver.
They might sit better in a different patchset maybe.

What is not here:
* Atom is always shown, regardles of technology. This should be
  filtered out.
* No provisioning support yet.

v2 contains fixes from previous v1 review.

Dragos Tatulea (9):
  include: add LTE dbus service define
  include: add header file for lte atom
  lte: add implementation for LTE atom
  build: add lte atom support
  test: add script for setting lte atom properties
  doc: add lte atom documentation
  ubloxmodem: add lte atom driver
  build: add support for ublox lte atom driver
  plugins: ublox: enable lte driver for tobyl2

 Makefile.am                     |   8 +-
 doc/lte-api.txt                 |  35 ++++
 drivers/ubloxmodem/lte.c        | 154 +++++++++++++++++
 drivers/ubloxmodem/ubloxmodem.c |   3 +
 drivers/ubloxmodem/ubloxmodem.h |   5 +
 include/dbus.h                  |   1 +
 include/lte.h                   |  68 ++++++++
 plugins/ublox.c                 |   3 +
 src/lte.c                       | 369 ++++++++++++++++++++++++++++++++++++=
++++
 test/set-lte-property           |  26 +++
 10 files changed, 669 insertions(+), 3 deletions(-)
 create mode 100644 doc/lte-api.txt
 create mode 100644 drivers/ubloxmodem/lte.c
 create mode 100644 include/lte.h
 create mode 100644 src/lte.c
 create mode 100755 test/set-lte-property

-- =

2.7.4


--===============7144799991802826457==--

