Content-Type: multipart/mixed; boundary="===============9064597066870220063=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 0/9] Basic E911 support
Date: Tue, 08 Mar 2011 13:00:42 +0200
Message-ID: <1299582051-32701-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9064597066870220063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This set of patches provides implementation proposal for basic E911 support.

Br,
Jarko

Jarko Poutiainen (9):
  dbus: add gnss interface definition
  include: add gnss.h file
  src: add atom type for gnss
  src: add gnss atom and agent implementation
  atmodem: add gnss driver
  gatchat: fix gatsyntax to support +CPOS
  ste: add support for gnss
  ofono.conf: add positioning agent interface
  test: add test-gnss

 Makefile.am               |   11 +-
 drivers/atmodem/atmodem.c |    2 +
 drivers/atmodem/atmodem.h |    3 +
 drivers/atmodem/gnss.c    |  278 +++++++++++++++++++++++++++++++++++
 gatchat/gatsyntax.c       |   10 +-
 include/dbus.h            |    2 +
 include/gnss.h            |   76 ++++++++++
 plugins/ste.c             |    8 +-
 src/gnss.c                |  357 +++++++++++++++++++++++++++++++++++++++++=
++++
 src/gnssagent.c           |  152 +++++++++++++++++++
 src/gnssagent.h           |   40 +++++
 src/ofono.conf            |    1 +
 src/ofono.h               |    2 +
 test/test-gnss            |   91 ++++++++++++
 14 files changed, 1025 insertions(+), 8 deletions(-)
 create mode 100644 drivers/atmodem/gnss.c
 create mode 100644 include/gnss.h
 create mode 100644 src/gnss.c
 create mode 100644 src/gnssagent.c
 create mode 100644 src/gnssagent.h
 create mode 100755 test/test-gnss


--===============9064597066870220063==--

