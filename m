Content-Type: multipart/mixed; boundary="===============0479600640831959292=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 0/9] RFC: add LTE atom
Date: Wed, 09 Nov 2016 18:43:13 +0100
Message-ID: <1478713402-30780-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0479600640831959292==
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

Dragos Tatulea (9):
  include: add header file for lte atom
  src: ofono.h: add LTE atom define
  lte: add implementation for LTE atom
  build: add lte atom support
  test: add script for setting lte atom properties
  doc: add lte atom documentation
  ubloxmodem: add lte atom driver
  build: add support for ublox lte atom driver
  plugins: ublox: enable lte driver for tobyl2

 Makefile.am                     |   8 +-
 doc/lte-api.txt                 |  35 +++++
 drivers/ubloxmodem/lte.c        | 125 +++++++++++++++
 drivers/ubloxmodem/ubloxmodem.c |   3 +
 drivers/ubloxmodem/ubloxmodem.h |   5 +
 include/lte.h                   |  69 ++++++++
 plugins/ublox.c                 |   3 +
 src/lte.c                       | 341 ++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h                     |   1 +
 test/set-lte-property           |  25 +++
 10 files changed, 612 insertions(+), 3 deletions(-)
 create mode 100644 doc/lte-api.txt
 create mode 100644 drivers/ubloxmodem/lte.c
 create mode 100644 include/lte.h
 create mode 100644 src/lte.c
 create mode 100755 test/set-lte-property

-- =

2.7.4


--===============0479600640831959292==--

