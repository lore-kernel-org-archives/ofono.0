Content-Type: multipart/mixed; boundary="===============9063802170149358137=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 00/16] M15 coding style fixes
Date: Wed, 12 Jan 2011 12:52:02 +0200
Message-ID: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9063802170149358137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Coding style fix patches for the whole oFono tree.

Regards,
Jeevaka

Jeevaka Badrappan (16):
  smsutil: M15 coding style fix
  core: M15 coding style fix
  include: M15 coding style fix
  mbmmodem: M15 coding style fix
  hfpmodem: M15 coding style fix
  huaweimodem: M15 coding style fix
  stemodem: M15 coding style fix
  calypsomodem: M15 coding style fix
  ifxmodem: M15 coding style fix
  hsomodem: M15 coding style fix
  nwmodem: M15 coding style fix
  isimodem: M15 coding style fix
  atmodem: M15 coding style fix
  plugins: M15 coding style fix
  unit: M15 coding style fix
  gatchat: M15 coding styles fixes

 drivers/atmodem/atmodem.h               |   68 +++++++++++++++------------=
---
 drivers/atmodem/call-barring.c          |    4 +-
 drivers/atmodem/call-forwarding.c       |    4 +-
 drivers/atmodem/call-meter.c            |    4 +-
 drivers/atmodem/call-settings.c         |    4 +-
 drivers/atmodem/call-volume.c           |    4 +-
 drivers/atmodem/cbs.c                   |    4 +-
 drivers/atmodem/gprs-context.c          |    4 +-
 drivers/atmodem/gprs.c                  |    4 +-
 drivers/atmodem/network-registration.c  |    4 +-
 drivers/atmodem/phonebook.c             |    6 +-
 drivers/atmodem/sim.c                   |    4 +-
 drivers/atmodem/sms.c                   |    4 +-
 drivers/atmodem/ssn.c                   |    4 +-
 drivers/atmodem/stk.c                   |    4 +-
 drivers/atmodem/ussd.c                  |    4 +-
 drivers/atmodem/voicecall.c             |    4 +-
 drivers/calypsomodem/calypsomodem.h     |    8 ++--
 drivers/calypsomodem/stk.c              |    4 +-
 drivers/calypsomodem/voicecall.c        |    4 +-
 drivers/hfpmodem/call-volume.c          |    4 +-
 drivers/hfpmodem/hfpmodem.h             |   12 +++---
 drivers/hfpmodem/network-registration.c |    4 +-
 drivers/hfpmodem/voicecall.c            |    4 +-
 drivers/hsomodem/gprs-context.c         |    4 +-
 drivers/hsomodem/hsomodem.h             |    8 ++--
 drivers/hsomodem/radio-settings.c       |    4 +-
 drivers/huaweimodem/audio-settings.c    |    4 +-
 drivers/huaweimodem/gprs-context.c      |    4 +-
 drivers/huaweimodem/huaweimodem.h       |   16 ++++----
 drivers/huaweimodem/radio-settings.c    |    4 +-
 drivers/huaweimodem/voicecall.c         |    4 +-
 drivers/ifxmodem/audio-settings.c       |    4 +-
 drivers/ifxmodem/gprs-context.c         |    4 +-
 drivers/ifxmodem/ifxmodem.h             |   20 +++++-----
 drivers/ifxmodem/radio-settings.c       |    4 +-
 drivers/ifxmodem/stk.c                  |    4 +-
 drivers/ifxmodem/voicecall.c            |    4 +-
 drivers/isimodem/audio-settings.c       |    4 +-
 drivers/isimodem/call-barring.c         |    4 +-
 drivers/isimodem/call-forwarding.c      |    4 +-
 drivers/isimodem/call-meter.c           |    4 +-
 drivers/isimodem/call-settings.c        |    4 +-
 drivers/isimodem/cbs.c                  |    4 +-
 drivers/isimodem/devinfo.c              |    4 +-
 drivers/isimodem/gprs-context.c         |    4 +-
 drivers/isimodem/isimodem.h             |   68 +++++++++++++++------------=
---
 drivers/isimodem/network-registration.c |    4 +-
 drivers/isimodem/phonebook.c            |    4 +-
 drivers/isimodem/radio-settings.c       |    4 +-
 drivers/isimodem/sim.c                  |    4 +-
 drivers/isimodem/sms.c                  |    4 +-
 drivers/isimodem/ssn.c                  |    4 +-
 drivers/isimodem/ussd.c                 |    4 +-
 drivers/isimodem/voicecall.c            |    4 +-
 drivers/mbmmodem/gprs-context.c         |    4 +-
 drivers/mbmmodem/mbmmodem.h             |    8 ++--
 drivers/mbmmodem/stk.c                  |    4 +-
 drivers/nwmodem/nwmodem.h               |    4 +-
 drivers/nwmodem/radio-settings.c        |    4 +-
 drivers/stemodem/gprs-context.c         |    4 +-
 drivers/stemodem/radio-settings.c       |    4 +-
 drivers/stemodem/stemodem.h             |   12 +++---
 drivers/stemodem/voicecall.c            |    4 +-
 gatchat/gatsyntax.c                     |    4 +-
 gatchat/gatsyntax.h                     |    4 +-
 gatchat/gsmdial.c                       |    4 +-
 gatchat/test-server.c                   |    4 +-
 include/dbus.h                          |    2 +-
 plugins/bluetooth.h                     |    2 +-
 plugins/hfp.c                           |    6 +-
 plugins/push-notification.c             |    4 +-
 plugins/smart-messaging.c               |    4 +-
 src/dbus.c                              |    2 +-
 src/main.c                              |    2 +-
 src/manager.c                           |    4 +-
 src/modem.c                             |    6 +-
 src/ofono.h                             |   12 +++---
 src/smsutil.c                           |    2 +-
 src/smsutil.h                           |    2 +-
 unit/test-common.c                      |    6 +-
 unit/test-idmap.c                       |    4 +-
 unit/test-mux.c                         |    8 ++--
 unit/test-simutil.c                     |   14 +++---
 unit/test-sms.c                         |   26 ++++++------
 unit/test-util.c                        |   20 +++++-----
 86 files changed, 292 insertions(+), 292 deletions(-)


--===============9063802170149358137==--

