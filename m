Content-Type: multipart/mixed; boundary="===============1493390109754739532=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3 0/6] emulator: add simple incoming call support
Date: Wed, 13 Apr 2011 18:05:28 +0200
Message-ID: <1302710734-6103-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1493390109754739532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add +CLIP, +CCWA, RING to signal incoming call,
ATA to allow reception and AT+CHUP to reject or finish
of an incoming call in HFP AG

Fr=C3=A9d=C3=A9ric Danis (6):
  emulator: add RING for HFP AG
  voicecall: add API to find call by status
  emulator: add +CLIP support for HFP AG
  emulator: add +CCWA support for HFP AG
  voicecall: add ATA support for HFP emulator
  voicecall: add +CHUP support for HFP emulator

 src/emulator.c  |  244 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 src/ofono.h     |    3 +
 src/voicecall.c |  188 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 411 insertions(+), 24 deletions(-)


--===============1493390109754739532==--

