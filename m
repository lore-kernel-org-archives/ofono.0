Content-Type: multipart/mixed; boundary="===============9194194406523009793=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 0/8] *** SUBJECT HERE ***
Date: Thu, 07 Apr 2011 18:33:52 +0200
Message-ID: <1302194040-18811-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9194194406523009793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

*** BLURB HERE ***

Fr=C3=A9d=C3=A9ric Danis (8):
  emulator: add defines for call, callsetup and callheld indicators
  emulator: add call, callsetup and callheld indicators
  emulator: add RING for HFP AG
  emulator: add incoming call API
  emulator: add +CLIP support for HFP AG
  voicecall: add ATA support for HFP emulator
  voicecall: add +CHUP support for HFP emulator
  emulator: add +CCWA support for HFP AG

 include/emulator.h |   15 +++
 src/emulator.c     |  244 +++++++++++++++++++++++++++++++++++++++---
 src/voicecall.c    |  306 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 552 insertions(+), 13 deletions(-)


--===============9194194406523009793==--

