Content-Type: multipart/mixed; boundary="===============6205180107790289316=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 0/7] Support for mtk modems
Date: Fri, 13 Nov 2015 13:25:03 +0100
Message-ID: <1447417510-9368-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6205180107790289316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series add support for MediaTek modems. The mtkmodem driver
is heavily based on rilmodem.

Alfonso Sanchez-Beato (7):
  gitignore: Ignore rilmodem-cs test binary
  include: Add flag for drivers that watch SIM state
  modem: Add flag for drivers that watch SIM state
  rilmodem: Export functions needed by mtkmodem
  mtkmodem: Add mtkmodem driver
  mtk: Plugin for mtkmodems
  build: Add mtkmodem driver and mtk plugin

 .gitignore                        |    1 +
 Makefile.am                       |   19 +
 drivers/mtkmodem/gprs.c           |  188 ++++
 drivers/mtkmodem/mtk_constants.h  |   84 ++
 drivers/mtkmodem/mtkmodem.c       |   58 ++
 drivers/mtkmodem/mtkmodem.h       |   32 +
 drivers/mtkmodem/mtkreply.c       |   98 +++
 drivers/mtkmodem/mtkreply.h       |   43 +
 drivers/mtkmodem/mtkrequest.c     |  163 ++++
 drivers/mtkmodem/mtkrequest.h     |  143 ++++
 drivers/mtkmodem/mtksettings.c    |  261 ++++++
 drivers/mtkmodem/mtksettings.h    |   43 +
 drivers/mtkmodem/mtkunsol.c       |  199 +++++
 drivers/mtkmodem/mtkunsol.h       |   59 ++
 drivers/mtkmodem/mtkutil.c        |  143 ++++
 drivers/mtkmodem/mtkutil.h        |   47 +
 drivers/mtkmodem/radio-settings.c |  193 +++++
 drivers/mtkmodem/voicecall.c      |  155 ++++
 drivers/rilmodem/radio-settings.c |   21 +-
 drivers/rilmodem/radio-settings.h |   46 +
 drivers/rilmodem/voicecall.c      |   18 +-
 drivers/rilmodem/voicecall.h      |    4 +
 include/modem.h                   |    4 +
 plugins/mtk.c                     | 1704 +++++++++++++++++++++++++++++++++=
++++
 src/modem.c                       |   38 +-
 25 files changed, 3735 insertions(+), 29 deletions(-)
 create mode 100644 drivers/mtkmodem/gprs.c
 create mode 100644 drivers/mtkmodem/mtk_constants.h
 create mode 100644 drivers/mtkmodem/mtkmodem.c
 create mode 100644 drivers/mtkmodem/mtkmodem.h
 create mode 100644 drivers/mtkmodem/mtkreply.c
 create mode 100644 drivers/mtkmodem/mtkreply.h
 create mode 100644 drivers/mtkmodem/mtkrequest.c
 create mode 100644 drivers/mtkmodem/mtkrequest.h
 create mode 100644 drivers/mtkmodem/mtksettings.c
 create mode 100644 drivers/mtkmodem/mtksettings.h
 create mode 100644 drivers/mtkmodem/mtkunsol.c
 create mode 100644 drivers/mtkmodem/mtkunsol.h
 create mode 100644 drivers/mtkmodem/mtkutil.c
 create mode 100644 drivers/mtkmodem/mtkutil.h
 create mode 100644 drivers/mtkmodem/radio-settings.c
 create mode 100644 drivers/mtkmodem/voicecall.c
 create mode 100644 drivers/rilmodem/radio-settings.h
 create mode 100644 plugins/mtk.c

-- =

2.5.0


--===============6205180107790289316==--

