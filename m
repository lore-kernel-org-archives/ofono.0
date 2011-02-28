Content-Type: multipart/mixed; boundary="===============3156434102271866851=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [PATCH 0/3] Voice call SS notifications (2nd version)
Date: Mon, 28 Feb 2011 18:28:02 +0200
Message-ID: <cover.1298883762.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3156434102271866851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implementation proposal for handling some of the voice call
related Supplementary Services (SS) notifications.

Implementation details:
- removed SSN atom
- expanded the SS notify functions with call number info, useful
  for modems capable of delivering it in the SS notifications
- expanded the SS callback functions with call number info and
  service code, useful in demultiplexing when a common callback
  function is defined for multiple service codes
- added +CSSU and +CSSI type SS notifications handling to the
  voicecall code

Andras Domokos (3):
  ssn: remove SSN atom
  ssn: add code and call id to notifications
  voicecall: add SSN notifications handling

 drivers/atmodem/ssn.c |    6 +-
 include/ssn.h         |   12 ++--
 include/types.h       |    2 +
 plugins/calypso.c     |    1 -
 plugins/g1.c          |    1 -
 plugins/huawei.c      |    1 -
 plugins/ifx.c         |    1 -
 plugins/isiusb.c      |    1 -
 plugins/linktop.c     |    1 -
 plugins/n900.c        |    1 -
 plugins/phonesim.c    |    1 -
 plugins/ste.c         |    1 -
 plugins/tc65.c        |    1 -
 plugins/u8500.c       |    1 -
 plugins/wavecom.c     |    1 -
 src/ofono.h           |    5 +-
 src/ssn.c             |   66 +++++---------
 src/voicecall.c       |  240 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 18 files changed, 272 insertions(+), 71 deletions(-)


--===============3156434102271866851==--

