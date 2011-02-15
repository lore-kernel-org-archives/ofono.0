Content-Type: multipart/mixed; boundary="===============1060720498543949673=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 00/18] wgmodem2.5 support
Date: Tue, 15 Feb 2011 13:30:54 +0100
Message-ID: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1060720498543949673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series of patches adds wgmodem2.5 support to isimodem and provides a p=
lugin
for the ST-Ericsson u8500 platform. I'm sending these on Jessica's behalf.

After discussions with Aki about how to handle the 2 versions of ISI we have
implemented 2 methods to handle this, first in case the resource IDs differ
between the 2 version we use this as a way to tell them apart, otherwise we
check the version information from the modem server.

Caveat: We haven't found any good way of integrating the u8500 IMEI specific
handling into the u8500 plugin, it currently resides in devinfo.

Jessica Nilsson (18):
  gisi: pipe and pep for wgmodem2.5
  gisi: modem version detection
  isimodem: general build updates for wgmodem2.5
  gisi: fix subscription for wgmodem2.5
  plugins: add plugin for u8500
  plugins: add u8500 to udev
  isimodem: add wgmodem2.5 to devinfo
  isimodem: UICC sim support for wgmodem2.5
  isimodem: clip colp clir colr wgmodem2.5
  isimodem: wgmodem2.5 added to voicecall
  isimodem: gprs-context updates wgmodem2.5
  isimodem: wgmodem2.5 support in USSD
  isimodem: SS_GSM_BARRING_INFO added
  isimodem: wgmodem2.5 added to call-forwarding
  isimodem: wgmodem2.5 added to ssn
  isimodem: sms updated with wgmodem2.5
  isimodem: CBS for wgmodem2.5
  isimodem: initial support for UICC phonebook

 Makefile.am                        |    7 +-
 drivers/isimodem/call-barring.c    |   99 ++-
 drivers/isimodem/call-forwarding.c |   30 +-
 drivers/isimodem/call-settings.c   |  697 ++++++++++-
 drivers/isimodem/call.h            |   89 ++
 drivers/isimodem/cbs.c             |  425 ++++++-
 drivers/isimodem/debug.c           |  197 +++
 drivers/isimodem/debug.h           |   10 +
 drivers/isimodem/devinfo.c         |  161 ++-
 drivers/isimodem/gprs-context.c    |   95 +-
 drivers/isimodem/info.h            |    3 +
 drivers/isimodem/mtc.h             |   38 +
 drivers/isimodem/phonebook.c       | 1241 ++++++++++++++++++-
 drivers/isimodem/sim.c             | 2381 ++++++++++++++++++++++++++++++++=
++--
 drivers/isimodem/sms.c             |  972 +++++++++++++--
 drivers/isimodem/sms.h             |   41 +-
 drivers/isimodem/ss.h              |   22 +
 drivers/isimodem/ssn.c             |  382 ++++++-
 drivers/isimodem/uicc.h            |  268 ++++
 drivers/isimodem/ussd.c            |   36 +-
 drivers/isimodem/voicecall.c       |  218 +++-
 gisi/message.c                     |    8 +
 gisi/message.h                     |    1 +
 gisi/modem.c                       |   51 +-
 gisi/modem.h                       |    7 +
 gisi/pep.c                         |  330 +++++
 gisi/pep.h                         |    6 +
 gisi/pipe.c                        |  180 +++-
 gisi/pipe.h                        |   17 +
 plugins/ofono.rules                |    3 +
 plugins/u8500.c                    |  506 ++++++++
 plugins/udev.c                     |    2 +
 32 files changed, 8073 insertions(+), 450 deletions(-)
 create mode 100644 drivers/isimodem/uicc.h
 create mode 100644 plugins/u8500.c

--
1.7.3.5


--===============1060720498543949673==--

