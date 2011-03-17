Content-Type: multipart/mixed; boundary="===============0756606493217666530=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 0/9] HSP profile implementation
Date: Thu, 17 Mar 2011 19:55:39 +0100
Message-ID: <1300388148-925-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0756606493217666530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch will start providing an HSP profile implementation
in oFono. This is work in progress, and based of what was done for
HFP profile. Finally added the audio connection, that will provide
a base for discussion. To avoid emulator depend upon btio, there is
a callback fom the emulator to the hsp plugin to connect audio,

Some question remains :

* How should pulse audio be notified?
* What is the behavior of hsp when receiving CKPD=3D200?

Next step will be to dial/hangup a call.

Fr=C3=A9d=C3=A9ric Dalleau (9):
  bluetooth: add functions for sco connection
  emulator: add hsp emulator type
  hsp_ag: add hsp atom type
  hsp_ag: Initial plugin commit
  hsp_ag: add modem watch
  emulator: add CKPD support
  emulator: add audio connection API
  emulator: implement audio connection API
  hsp_ag: add audio connection support

 Makefile.am         |    3 +
 include/emulator.h  |    8 ++
 plugins/bluetooth.c |  122 +++++++++++++++++++++++++++++++
 plugins/bluetooth.h |    7 ++
 plugins/hsp_ag.c    |  200 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/emulator.c      |   50 +++++++++++++
 src/ofono.h         |    1 +
 7 files changed, 391 insertions(+), 0 deletions(-)
 create mode 100644 plugins/hsp_ag.c


--===============0756606493217666530==--

