Content-Type: multipart/mixed; boundary="===============3443726518530144594=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 00/11] Remove NULL check for call back data
Date: Sat, 29 Jan 2011 05:34:33 -0800
Message-ID: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3443726518530144594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Memory allocation function for callback data change from g_try_new0 to
g_new0. Due to this, NULL check done for callback data is removed.

Regards,
Jeevaka

Jeevaka Badrappan (11):
  atutil: use g_new0 for callback data memory
  atmodem: remove NULL check
  calypsomodem: remove NULL check
  hfpmodem: remove NULL check
  hsomodem: remove NULL check
  huaweimodem: remove NULL check
  ifxmodem: remove NULL check
  mbmmodem: remove NULL check
  stemodem: remove NULL check
  cdmamodem: remove NULL check
  plugins: remove NULL check

 drivers/atmodem/atutil.h                |    5 +---
 drivers/atmodem/call-barring.c          |    6 ++--
 drivers/atmodem/call-forwarding.c       |    8 -----
 drivers/atmodem/call-meter.c            |   28 -------------------
 drivers/atmodem/call-settings.c         |   36 ------------------------
 drivers/atmodem/call-volume.c           |    8 -----
 drivers/atmodem/cbs.c                   |    8 -----
 drivers/atmodem/devinfo.c               |   16 -----------
 drivers/atmodem/gprs.c                  |    8 -----
 drivers/atmodem/network-registration.c  |   24 ----------------
 drivers/atmodem/phonebook.c             |    4 ---
 drivers/atmodem/sim-auth.c              |    2 +-
 drivers/atmodem/sim.c                   |   46 ++-------------------------=
----
 drivers/atmodem/sms.c                   |   20 -------------
 drivers/atmodem/stk.c                   |    4 +-
 drivers/atmodem/ussd.c                  |    7 -----
 drivers/atmodem/voicecall.c             |    7 -----
 drivers/calypsomodem/stk.c              |    4 +-
 drivers/calypsomodem/voicecall.c        |    4 ---
 drivers/cdmamodem/devinfo.c             |   16 -----------
 drivers/cdmamodem/voicecall.c           |    4 ---
 drivers/hfpmodem/call-volume.c          |    8 -----
 drivers/hfpmodem/network-registration.c |   12 --------
 drivers/hfpmodem/voicecall.c            |    4 ---
 drivers/hsomodem/gprs-context.c         |    7 -----
 drivers/huaweimodem/gprs-context.c      |    8 -----
 drivers/huaweimodem/voicecall.c         |    4 ---
 drivers/ifxmodem/ctm.c                  |    8 -----
 drivers/ifxmodem/stk.c                  |    4 +-
 drivers/ifxmodem/voicecall.c            |    7 -----
 drivers/mbmmodem/gprs-context.c         |    7 -----
 drivers/mbmmodem/stk.c                  |    4 +-
 drivers/stemodem/gprs-context.c         |    6 ----
 drivers/stemodem/voicecall.c            |    7 -----
 plugins/gobi.c                          |    2 +-
 plugins/hso.c                           |    4 ---
 plugins/ifx.c                           |    4 ---
 plugins/mbm.c                           |    4 ---
 plugins/novatel.c                       |    2 +-
 plugins/phonesim.c                      |   12 --------
 plugins/sierra.c                        |    2 +-
 plugins/ste.c                           |    4 ---
 plugins/tc65.c                          |    4 ---
 plugins/zte.c                           |    2 +-
 44 files changed, 20 insertions(+), 371 deletions(-)


--===============3443726518530144594==--

