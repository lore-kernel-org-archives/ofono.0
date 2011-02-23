Content-Type: multipart/mixed; boundary="===============7123742073582814132=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 00/18] wgmodem2.5 support
Date: Wed, 23 Feb 2011 12:43:11 +0100
Message-ID: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7123742073582814132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Second go on the patches for wgmodem2.5, please review.

Note that we are still working on the changes for pipe/pep and CBS, having =
some
problems with testing them so those patches are not updated in this set just
included to ensure no conflicts.

Cheers
Andreas

Jessica Nilsson (18):
  gisi: pipe and pep for wgmodem2.5
  isimodem: added codepoints for u8500
  plugins: add plugin for u8500
  plugins: add u8500 to udev
  gisi: add getter and setter for sim
  src: add missing SIM enum to simutil.h
  isimodem: code points uicc sim wgmodem2.5
  isimodem: UICC sim support for wgmodem2.5
  isimodem: clip colp clir colr wgmodem2.5
  isimodem: wgmodem2.5 added to voicecall
  isimodem: wgmodem2.5 support in USSD
  isimodem: SS_GSM_BARRING_INFO added
  isimodem: wgmodem2.5 added to call-forwarding
  isimodem: wgmodem2.5 added to ssn
  isimodem: code points for sms wgmodem2.5
  isimodem: sms updated with wgmodem2.5
  isimodem: CBS for wgmodem2.5
  isimodem: initial support for UICC phonebook

 Makefile.am                        |    7 +-
 drivers/isimodem/call-barring.c    |   99 ++-
 drivers/isimodem/call-forwarding.c |   28 +-
 drivers/isimodem/call-settings.c   |  711 ++++++++++-
 drivers/isimodem/call.h            |   89 ++
 drivers/isimodem/cbs.c             |  414 +++++-
 drivers/isimodem/debug.c           |  149 ++
 drivers/isimodem/debug.h           |    2 +
 drivers/isimodem/info.h            |    3 +
 drivers/isimodem/phonebook.c       | 1273 +++++++++++++++++-
 drivers/isimodem/sim.c             | 2678 ++++++++++++++++++++++++++++++++=
+---
 drivers/isimodem/sms.c             |  958 +++++++++++--
 drivers/isimodem/sms.h             |   41 +-
 drivers/isimodem/ss.h              |   22 +
 drivers/isimodem/ssn.c             |  406 ++++++-
 drivers/isimodem/uicc.h            |  265 ++++
 drivers/isimodem/ussd.c            |   36 +-
 drivers/isimodem/voicecall.c       |  218 +++-
 gisi/message.c                     |    8 +
 gisi/message.h                     |    1 +
 gisi/modem.c                       |   42 +
 gisi/modem.h                       |    4 +
 gisi/pep.c                         |  330 +++++
 gisi/pep.h                         |    6 +
 gisi/pipe.c                        |  180 +++-
 gisi/pipe.h                        |   17 +
 plugins/ofono.rules                |    3 +
 plugins/u8500.c                    |  708 ++++++++++
 plugins/udev.c                     |    2 +
 src/simutil.h                      |    1 +
 30 files changed, 8192 insertions(+), 509 deletions(-)
 create mode 100644 drivers/isimodem/uicc.h
 create mode 100644 plugins/u8500.c

--
1.7.3.5


--===============7123742073582814132==--

