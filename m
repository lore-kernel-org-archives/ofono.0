Content-Type: multipart/mixed; boundary="===============1907238001482860024=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/5] HSP profile implementation
Date: Mon, 14 Mar 2011 16:49:16 +0100
Message-ID: <1300117761-6181-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1907238001482860024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch will start providing an HSP profile implementation
in oFono. This is work in progress, and based of what was done for
HFP profile.
Next step is to add an audio connection it will be done in a separate
patch since it must be discussed.

Fr=C3=A9d=C3=A9ric Dalleau (5):
  hsp_ag: Initial plugin commit
  hsp_ag: add modem watch
  hsp_ag: add hsp emulator type
  hsp_ag: add hsp atom type
  hsp_ag: change emulator type to hsp

 Makefile.am        |    3 +
 include/emulator.h |    1 +
 plugins/hsp_ag.c   |  199 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/emulator.c     |    4 +
 src/ofono.h        |    1 +
 5 files changed, 208 insertions(+), 0 deletions(-)
 create mode 100644 plugins/hsp_ag.c


--===============1907238001482860024==--

