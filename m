Content-Type: multipart/mixed; boundary="===============2744255355644653855=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH v3 0/2] Support for U-Blox Toby L2 modems
Date: Thu, 17 Mar 2016 16:22:08 +0100
Message-ID: <1458228130-20781-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2744255355644653855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset adds support for Toby L2 modems in high throughput
mode.

Besides basic support, the following things are supported:
* 2/3G bearers
* Multiple primary PDP contexts.

Uptated in this patchset:
* Style issues.
* Dropped routed mode until we have a way to set the mode.

Dragos Tatulea (2):
  ubloxmodem: add Toby L2 gprs context driver
  ubloxmodem: support authentication

 Makefile.am                       |   7 +
 drivers/ubloxmodem/gprs-context.c | 479 ++++++++++++++++++++++++++++++++++=
++++
 drivers/ubloxmodem/ubloxmodem.c   |  49 ++++
 drivers/ubloxmodem/ubloxmodem.h   |  25 ++
 4 files changed, 560 insertions(+)
 create mode 100644 drivers/ubloxmodem/gprs-context.c
 create mode 100644 drivers/ubloxmodem/ubloxmodem.c
 create mode 100644 drivers/ubloxmodem/ubloxmodem.h

-- =

2.5.0


--===============2744255355644653855==--

