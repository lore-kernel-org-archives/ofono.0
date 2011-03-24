Content-Type: multipart/mixed; boundary="===============6752093430218579536=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 00/12] Basic E911 support
Date: Thu, 24 Mar 2011 15:46:24 +0200
Message-ID: <1300974396-15801-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6752093430218579536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This is third attempt to provide implementation for basic E911 support.

Br,
Jarko

Jarko Poutiainen (12):
  dbus: add gnss interface definition
  include: add gnss.h file
  src: add atom type for gnss
  src: add gnss atom and agent implementation
  gatchat: introduce send for +CPOS
  gatchat: new hint to handle +CPOS
  gatchat: implementation for +CPOS send
  gatchat: fix gatsyntax to support +CPOS
  atmodem: add gnss driver
  ste: add support for gnss
  ofono.conf: add positioning agent interface
  test: add test-gnss

 Makefile.am               |   12 +-
 drivers/atmodem/atmodem.c |    2 +
 drivers/atmodem/atmodem.h |    3 +
 drivers/atmodem/gnss.c    |  282 +++++++++++++++++++++++++++++++++
 gatchat/gatchat.c         |   37 ++++-
 gatchat/gatchat.h         |    8 +
 gatchat/gatsyntax.c       |   27 +++
 gatchat/gatsyntax.h       |    3 +-
 include/dbus.h            |    2 +
 include/gnss.h            |   69 ++++++++
 plugins/ste.c             |    8 +-
 src/gnss.c                |  386 +++++++++++++++++++++++++++++++++++++++++=
++++
 src/gnssagent.c           |  158 ++++++++++++++++++
 src/gnssagent.h           |   43 +++++
 src/ofono.conf            |    1 +
 src/ofono.h               |    2 +
 test/test-gnss            |   91 +++++++++++
 17 files changed, 1123 insertions(+), 11 deletions(-)
 create mode 100644 drivers/atmodem/gnss.c
 create mode 100644 include/gnss.h
 create mode 100644 src/gnss.c
 create mode 100644 src/gnssagent.c
 create mode 100644 src/gnssagent.h
 create mode 100755 test/test-gnss


--===============6752093430218579536==--

