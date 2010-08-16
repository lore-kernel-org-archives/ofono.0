Content-Type: multipart/mixed; boundary="===============0896989728326291210=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCHv2 0/7] Resubmitting STE Driver patches.
Date: Mon, 16 Aug 2010 15:54:01 +0200
Message-ID: <1281966848-14553-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0896989728326291210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Resubmitting based on rebase comments from Denis K.
Changes:

o  SIM-ready and Radio-Settings are now split in two parts,
   one patch for driver and one for plugin.
o  Use MBM stk driver implementation (avoid copying code).

o  Updated error handling for Radio Settings.

o  Various Style issues (new line and tabs).

New patch:
o  Added patch for plugins/ste using Socket stream mode for CAIF,
   and adding support for specifying CAIF interface to bind to.


Sjur Br=C3=A6ndeland (7):
  stemodem: Add support for STK by including MBM implementation.
  atmodem: Enable STE usage of AT*EPEV and AT*EPEE for PIN handling.
  stemodem: Add polling for SIM ready.
  stemodem: Add Radio Settings to STE Modem
  plugins/ste: Add Radio-Settings
  stemodem: Use RTNL for creating CAIF interface
  plugins/ste: Use SOCK_STREAM for CAIF and enable interface
    specification.

 Makefile.am                       |    6 +-
 drivers/atmodem/sim.c             |    9 +-
 drivers/stemodem/gprs-context.c   |   51 +++++--
 drivers/stemodem/radio-settings.c |  225 ++++++++++++++++++++++++++
 drivers/stemodem/rtnl.c           |  318 +++++++++++++++++++++++++++++++++=
++++
 drivers/stemodem/rtnl.h           |   24 +++
 drivers/stemodem/stemodem.c       |    4 +
 drivers/stemodem/stemodem.h       |    5 +
 plugins/modem.conf                |    5 +
 plugins/modemconf.c               |    1 +
 plugins/ste.c                     |   79 +++++++++-
 11 files changed, 706 insertions(+), 21 deletions(-)
 create mode 100644 drivers/stemodem/radio-settings.c
 create mode 100644 drivers/stemodem/rtnl.c
 create mode 100644 drivers/stemodem/rtnl.h


--===============0896989728326291210==--

