Content-Type: multipart/mixed; boundary="===============8598703700470185983=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 0/3] bluetooth: add HFP AG plugin
Date: Tue, 15 Feb 2011 16:06:30 +0100
Message-ID: <1297782393-9898-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8598703700470185983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the HFP AG plugin
Add partial support for +CIND command: currently,
only network registration part is suported
(status and roaming)

Fr=C3=A9d=C3=A9ric Danis (3):
  bluetooth: add HFP AG plugin
  emulator: add HFP emulator type
  emulator: add +CIND support

 Makefile.am        |    3 +
 include/emulator.h |    1 +
 plugins/hfp_ag.c   |  188 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/emulator.c     |  132 ++++++++++++++++++++++++++++++++++++-
 src/ofono.h        |    1 +
 5 files changed, 323 insertions(+), 2 deletions(-)
 create mode 100644 plugins/hfp_ag.c


--===============8598703700470185983==--

