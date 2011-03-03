Content-Type: multipart/mixed; boundary="===============0033050675334561680=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [PATCH 0/3] Voice call SS notifications (3rd version)
Date: Thu, 03 Mar 2011 18:47:53 +0200
Message-ID: <cover.1299168583.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0033050675334561680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implementation proposal for handling some of the voice call
related Supplementary Services (SS) notifications.

Implementation details:
- removed SSN atom
- (re)implemented voice call SS notification handling framework
- added voice call SS notification handling to AT modem driver
  (+CSSU and +CSSI notifications) =


Andras Domokos (3):
  ssn: remove SSN atom completely
  voicecall: add SSN handling functions
  atmodem: add SSN handling

 Makefile.am                 |    6 +-
 drivers/atmodem/atmodem.c   |    2 -
 drivers/atmodem/atmodem.h   |    3 -
 drivers/atmodem/ssn.c       |  147 -------------------------
 drivers/atmodem/voicecall.c |   61 +++++++++++
 drivers/isimodem/isimodem.c |    2 -
 drivers/isimodem/isimodem.h |    3 -
 drivers/isimodem/ssn.c      |   95 -----------------
 include/ssn.h               |   61 -----------
 include/types.h             |    2 +
 include/voicecall.h         |    6 +
 plugins/calypso.c           |    2 -
 plugins/g1.c                |    2 -
 plugins/huawei.c            |    2 -
 plugins/ifx.c               |    2 -
 plugins/isiusb.c            |    2 -
 plugins/linktop.c           |    2 -
 plugins/n900.c              |    2 -
 plugins/phonesim.c          |    2 -
 plugins/ste.c               |    2 -
 plugins/tc65.c              |    2 -
 plugins/u8500.c             |    2 -
 plugins/wavecom.c           |    2 -
 src/ofono.h                 |   17 ---
 src/ssn.c                   |  247 ---------------------------------------=
----
 src/voicecall.c             |  156 +++++++++++++++++++++++++++
 26 files changed, 227 insertions(+), 605 deletions(-)
 delete mode 100644 drivers/atmodem/ssn.c
 delete mode 100644 drivers/isimodem/ssn.c
 delete mode 100644 include/ssn.h
 delete mode 100644 src/ssn.c


--===============0033050675334561680==--

