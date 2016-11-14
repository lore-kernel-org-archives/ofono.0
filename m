Content-Type: multipart/mixed; boundary="===============5002782029662123245=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH v3 0/9] add LTE atom
Date: Mon, 14 Nov 2016 15:27:01 +0100
Message-ID: <1479133626-8903-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5002782029662123245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v3:
* Fixes based on v2 review.
* Fixed memory leak in lte atom when reading apn from file.
* Added a pending_info struct to forward settings to the driver. On success=
ful
callback, copy the info into the actual info structure. This is better than
the old design of writing the apn to info directly and on error rolling it
back.

Dragos Tatulea (5):
  lte: add implementation for LTE atom
  build: add lte atom support
  ubloxmodem: add lte atom driver
  build: add support for ublox lte atom driver
  plugins: ublox: enable lte driver for tobyl2

 Makefile.am                     |   8 +-
 drivers/ubloxmodem/lte.c        | 145 ++++++++++++++++
 drivers/ubloxmodem/ubloxmodem.c |   3 +
 drivers/ubloxmodem/ubloxmodem.h |   5 +
 plugins/ublox.c                 |   3 +
 src/lte.c                       | 372 ++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h                     |   1 +
 7 files changed, 534 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ubloxmodem/lte.c
 create mode 100644 src/lte.c

-- =

2.7.4


--===============5002782029662123245==--

