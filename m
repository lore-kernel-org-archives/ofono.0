Content-Type: multipart/mixed; boundary="===============5690614248245558585=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH v4 0/5] add LTE atom
Date: Tue, 15 Nov 2016 15:08:15 +0100
Message-ID: <1479218900-9870-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5690614248245558585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v3:
* Fixed style issues.
* Fixed double registration of LTE atom in case of success.
* Return busy if set operation on LTE atom is pending.

Dragos Tatulea (5):
  lte: add implementation for LTE atom
  build: add lte atom support
  ubloxmodem: add lte atom driver
  build: add support for ublox lte atom driver
  plugins: ublox: enable lte driver for tobyl2

 Makefile.am                     |   8 +-
 drivers/ubloxmodem/lte.c        | 142 +++++++++++++++
 drivers/ubloxmodem/ubloxmodem.c |   3 +
 drivers/ubloxmodem/ubloxmodem.h |   5 +
 plugins/ublox.c                 |   3 +
 src/lte.c                       | 375 ++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h                     |   1 +
 7 files changed, 534 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ubloxmodem/lte.c
 create mode 100644 src/lte.c

-- =

2.7.4


--===============5690614248245558585==--

