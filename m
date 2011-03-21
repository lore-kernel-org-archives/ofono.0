Content-Type: multipart/mixed; boundary="===============8323612137154952877=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 0/3] Emulator CGDCONT
Date: Mon, 21 Mar 2011 14:45:11 +0100
Message-ID: <1300715114-5790-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8323612137154952877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This first set of patches proposes an partial implementation =

of AT+CGDCONT command (for the AT Emulator), as specified in the =

dialup-command-set.txt doc file. The current code handles only
list parameters and list existing contexts.

Olivier Guiter (3):
  gprs.c: add emulator CGDCONT handler
  idmap.c: add get size function
  gprs.c: add list contexts for emulator

 src/gprs.c  |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/idmap.c |    5 +++
 src/idmap.h |    1 +
 3 files changed, 91 insertions(+), 1 deletions(-)


--===============8323612137154952877==--

