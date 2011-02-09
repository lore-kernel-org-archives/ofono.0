Content-Type: multipart/mixed; boundary="===============8673675137070142841=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [PATCH 0/3] Voice call SS notifications 
Date: Wed, 09 Feb 2011 12:33:46 +0200
Message-ID: <cover.1297244229.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8673675137070142841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here are the implementation proposal for handling some of the voice call
related Supplementary Services notifications.

Implementation details:
- removed the +CSSI type SS notifications handling from the
  call-barring code
- expanded the SS notify functions with call number info, useful
  for modems capable of delivering it in the SS notifications
- expanded the SS callback functions with call number info and
  service code, useful in demultiplexing when a common callback
  function is defined for multiple service codes
- added +CSSU and +CSSI type SS notifications handling to the
  voicecall code

The API level detailed changes are explained in the doc files. =


Andras Domokos (3):
  call-barring: removed +CSSI type SS notifications
  ssn: add code and call id to notifications
  voicecall: handle voice call SS notifications

 drivers/atmodem/ssn.c |    4 +-
 include/ssn.h         |    7 +-
 include/types.h       |    2 +
 src/call-barring.c    |   74 ---------------
 src/ofono.h           |    6 +-
 src/ssn.c             |   11 +-
 src/voicecall.c       |  242 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 7 files changed, 257 insertions(+), 89 deletions(-)


--===============8673675137070142841==--

