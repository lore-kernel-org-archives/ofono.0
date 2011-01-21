Content-Type: multipart/mixed; boundary="===============5081275466894167502=="
MIME-Version: 1.0
From: christian.lam@nokia.com
Subject: [PATCH 0/7] Add CDMA Connection Manager support
Date: Fri, 21 Jan 2011 15:06:43 -0800
Message-ID: <1295651210-22922-1-git-send-email-christian.lam@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5081275466894167502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christian Lam <christian.lam@nokia.com>

This series of patches provides the support for the CDMA Connection
Manager, cdma-connman, atom. This includes Mobile Originated connection
and disconnection features of Packet Data Service over CDMA
(1xRTT and 1xEV-DO) systems. This implementation do not yet handle the
CDMA Network Registration which is future work.

These patches have been tested against the Nokia 7705 CDMA device in a
tethered mode.

Limitations
-----------
The Nokia 7705 device does not support an AT interface for reporting request
responses, such as the remote/network disconnect reasons, so these are
currently untested.

Christian Lam (7):
  dbus: add CDMA Connection Manager interface
  cdma-connman: add CDMA Connection Manager support
  src: add CDMA Connection Manager support
  nokiacdma: add CDMA Connection Manager support
  cdmamodem: add CDMA Connection Manager support
  test: add CDMA Connection Manager support scripts
  test: add Settings dict parsing for CDMA ConnMan

 Makefile.am                   |    9 +-
 drivers/cdmamodem/cdmamodem.c |    4 +-
 drivers/cdmamodem/cdmamodem.h |    4 +-
 drivers/cdmamodem/connman.c   |  283 ++++++++++++++++++++
 include/cdma-connman.h        |   79 ++++++
 include/dbus.h                |    1 +
 plugins/nokiacdma.c           |    4 +
 src/cdma-connman.c            |  571 +++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h                   |    2 +
 test/disable-cdma-connman     |   20 ++
 test/enable-cdma-connman      |   20 ++
 test/list-modems              |   10 +
 12 files changed, 1002 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cdmamodem/connman.c
 create mode 100644 include/cdma-connman.h
 create mode 100644 src/cdma-connman.c
 create mode 100755 test/disable-cdma-connman
 create mode 100755 test/enable-cdma-connman


--===============5081275466894167502==--

