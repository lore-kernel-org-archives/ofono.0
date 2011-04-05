Content-Type: multipart/mixed; boundary="===============3672428655738659215=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 0/7] emulator: add simple incoming call support
Date: Tue, 05 Apr 2011 17:40:24 +0200
Message-ID: <1302018031-12401-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3672428655738659215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add call related indicators, +CLIP, RING to signal incoming call,
ATA to allow reception and AT+CHUP to reject or finish
of an incoming call in HFP AG

Fr=C3=A9d=C3=A9ric Danis (7):
  emulator: add defines for call, callsetup and callheld indicators
  emulator: add call, callsetup and callheld indicators
  emulator: add RING for HFP AG
  emulator: add incoming call API
  emulator: add +CLIP support for HFP AG
  voicecall: add ATA support for HFP emulator
  voicecall: add +CHUP support for HFP emulator

 include/emulator.h |   15 +++
 src/emulator.c     |  106 ++++++++++++++++++
 src/voicecall.c    |  306 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 427 insertions(+), 0 deletions(-)


--===============3672428655738659215==--

