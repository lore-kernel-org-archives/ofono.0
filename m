Content-Type: multipart/mixed; boundary="===============8177265434116673484=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 0/8] Sierra Wireless CDMA modem support
Date: Fri, 28 Dec 2012 14:31:41 -0500
Message-ID: <20121228193141.GF18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8177265434116673484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

This series adds support for Sierra Wireless CDMA modems.  Tested with
the MC5728V on the Sprint CDMA network.

Forest Bond (8):
  sierramodem: Add skeleton for Sierra Wireless modem driver
  sierramodem: Add skeleton cdma netreg driver
  sierramodem: Add ERI parsing functions
  sierramodem: Report network registration status
  sierra: Create GPRS context in post_sim function
  sierra: Initialize GSM error reporting separately
  sierra: Support CDMA modems
  udevng: Support single-interface sierra devices

 Makefile.am                       |    8 +
 drivers/sierramodem/cdma-netreg.c |  385 +++++++++++++++++++++++++++++++++=
++++
 drivers/sierramodem/eri.c         |  282 +++++++++++++++++++++++++++
 drivers/sierramodem/eri.h         |   23 +++
 drivers/sierramodem/sierramodem.c |   50 +++++
 drivers/sierramodem/sierramodem.h |   26 +++
 plugins/sierra.c                  |  117 +++++++++---
 plugins/udevng.c                  |   43 ++++-
 8 files changed, 900 insertions(+), 34 deletions(-)
 create mode 100644 drivers/sierramodem/cdma-netreg.c
 create mode 100644 drivers/sierramodem/eri.c
 create mode 100644 drivers/sierramodem/eri.h
 create mode 100644 drivers/sierramodem/sierramodem.c
 create mode 100644 drivers/sierramodem/sierramodem.h

-- =

Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--===============8177265434116673484==--

