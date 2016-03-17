Content-Type: multipart/mixed; boundary="===============1929879224201233653=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH v4 0/2] Support for U-Blox Toby L2 modems
Date: Thu, 17 Mar 2016 16:43:48 +0100
Message-ID: <1458229430-31435-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1929879224201233653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset adds support for Toby L2 modems in high throughput
mode.

Besides basic support, the following things are supported:
* 2/3G bearers
* Multiple primary PDP contexts.

Uptated in this patchset:
* Simplified authentication handling.

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


--===============1929879224201233653==--

