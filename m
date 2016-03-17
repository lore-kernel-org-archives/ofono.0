Content-Type: multipart/mixed; boundary="===============7837096140633311730=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH v2 0/7] Support for U-Blox Toby L2 modems
Date: Thu, 17 Mar 2016 13:38:26 +0100
Message-ID: <1458218313-26966-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7837096140633311730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset adds support for Toby L2 modems in high throughput
mode.

Besides basic support, the following things are supported:
* 2/3G bearers
* bridged AND routed modes.
* Multiple primary PDP contexts.

Uptated in this patchset:
* Fixes based on review comments.
* More AT command based function names.
* Authentication: ofono supports larger usernames/passwords than
  Toby L2 does. Check against the Toby L2 upper limit.
* Routed mode: Merged cgcontrdp functions for routed and brieded.

Dongsu Park (2):
  plugins/ublox: read network mode
  ubloxmodem: add routed mode support

Dragos Tatulea (5):
  plugins/ublox: give names to model ids
  ubloxmodem: add Toby L2 gprs context driver
  plugins/ublox: enable ubloxmodem driver when possible
  plugins/ublox: support more internet contexts
  ubloxmodem: support authentication

 Makefile.am                       |   7 +
 drivers/ubloxmodem/gprs-context.c | 569 ++++++++++++++++++++++++++++++++++=
++++
 drivers/ubloxmodem/ubloxmodem.c   |  49 ++++
 drivers/ubloxmodem/ubloxmodem.h   |  25 ++
 plugins/ublox.c                   |  84 +++++-
 5 files changed, 722 insertions(+), 12 deletions(-)
 create mode 100644 drivers/ubloxmodem/gprs-context.c
 create mode 100644 drivers/ubloxmodem/ubloxmodem.c
 create mode 100644 drivers/ubloxmodem/ubloxmodem.h

-- =

2.5.0


--===============7837096140633311730==--

