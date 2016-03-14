Content-Type: multipart/mixed; boundary="===============7074578561309480669=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH v1 00/11] Support for U-Blox Toby L2 modems
Date: Mon, 14 Mar 2016 16:50:53 +0100
Message-ID: <1457970664-20782-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7074578561309480669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset adds support for Toby L2 modems in high throughput
mode.

Besides basic support, the following things are supported:
* 2/3G bearers
* bridged AND routed modes.
* Multiple primary PDP contexts.

This version of the patches removes LTE specific hacks which will be
subsequently committed in their own patch sets:
* CREG status is no longer patched for ublox =

* The ublox-specific way of making LTE default bearers work has been
removed. This functionality needs to be supported by the core.

Dongsu Park (3):
  plugins/udevng: support different interface strings to detect TOBY
    series
  plugins/ublox: read network mode
  ubloxmodem: add routed mode support

Dragos Tatulea (8):
  plugins/ublox: allow enabling of TOBY L2 modems
  plugins/ublox: use vendor from structure instead of fixed
  atmodem: add support for U-Blox TOBY L2 modems
  plugins/ublox: give names to model ids
  ubloxmodem: add Toby L2 gprs context driver
  plugins/ublox: enable ubloxmodem driver when possible
  plugins/ublox: support more internet contexts
  ubloxmodem: support authentication

 Makefile.am                            |   7 +
 drivers/atmodem/gprs.c                 |   1 +
 drivers/atmodem/network-registration.c |  21 +-
 drivers/atmodem/sim.c                  |   1 +
 drivers/ubloxmodem/gprs-context.c      | 614 +++++++++++++++++++++++++++++=
++++
 drivers/ubloxmodem/ubloxmodem.c        |  49 +++
 drivers/ubloxmodem/ubloxmodem.h        |  25 ++
 plugins/ublox.c                        | 128 ++++++-
 plugins/udevng.c                       |  24 +-
 9 files changed, 845 insertions(+), 25 deletions(-)
 create mode 100644 drivers/ubloxmodem/gprs-context.c
 create mode 100644 drivers/ubloxmodem/ubloxmodem.c
 create mode 100644 drivers/ubloxmodem/ubloxmodem.h

-- =

2.5.0


--===============7074578561309480669==--

