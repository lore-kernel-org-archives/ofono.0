Content-Type: multipart/mixed; boundary="===============7555389906620324797=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 00/19] Support for U-Blox Toby L2 modems
Date: Wed, 09 Mar 2016 16:44:41 +0100
Message-ID: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7555389906620324797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset adds support for Toby L2 modems in high throughput
mode.

Besides basic support, the following things are supported:
* bridged AND routed modes.
* LTE default bearers.
* Multiple primary PDP contexts.


Dongsu Park (4):
  plugins/udevng: support the U-Blox TOBY-L2 series
  plugins/udevng: support different interface strings to detect TOBY
    series
  plugins/ublox: read network mode
  ubloxmodem: add routed mode support

Dragos Tatulea (15):
  plugins/udevng: ublox: set model string
  include: vendor.h: add vendor for ublox toby
  plugins/ublox: allow enabling of TOBY L2 modems
  plugins/ublox: use vendor from structure instead of fixed
  atmodem: ublox: EPS now supported by newer ublox
  atmodem: add support for U-Blox TOBY L2 modems
  atmodem: work around CGREG issues in UBlox Toby L2
  ubloxmodem: add Toby L2 gprs context driver
  gprs-context.h: add function for setting APN
  gprs: allow APN updates from gprs-context driver
  ubloxmodem: push back APN into gprs context
  plugins/ublox: give names to model ids
  plugins/ublox: enable ubloxmodem driver when possible
  plugins/ublox: support more internet contexts
  ubloxmodem: support authentication

 Makefile.am                            |   7 +
 drivers/atmodem/gprs-context.c         |   2 +
 drivers/atmodem/gprs.c                 |  27 +-
 drivers/atmodem/network-registration.c |  12 +-
 drivers/atmodem/sim.c                  |   1 +
 drivers/atmodem/vendor.h               |   1 +
 drivers/ubloxmodem/gprs-context.c      | 714 +++++++++++++++++++++++++++++=
++++
 drivers/ubloxmodem/ubloxmodem.c        |  49 +++
 drivers/ubloxmodem/ubloxmodem.h        |  25 ++
 include/gprs-context.h                 |   3 +
 plugins/ublox.c                        | 129 +++++-
 plugins/udevng.c                       |  25 +-
 src/gprs.c                             |  25 +-
 13 files changed, 987 insertions(+), 33 deletions(-)
 create mode 100644 drivers/ubloxmodem/gprs-context.c
 create mode 100644 drivers/ubloxmodem/ubloxmodem.c
 create mode 100644 drivers/ubloxmodem/ubloxmodem.h

-- =

2.5.0


--===============7555389906620324797==--

