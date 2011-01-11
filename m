Content-Type: multipart/mixed; boundary="===============8998792001449374586=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v2 0/9] Add GPS atom
Date: Tue, 11 Jan 2011 00:23:49 -0300
Message-ID: <1294716238-21218-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8998792001449374586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches add GPS atom to ofono, and implement it for mbm modem.

Changes since V1:
 - renamed ofono gps interface ".Gps" to "LocationReporting"
 - split set_gps method (in ofono_gps_driver) into enable and disable
   methods
 - additional information is sent by enable method to the core :
   device node and type
 - dropped query_gps which is not needed anymore
 - changed the port used by the gps driver to the proper one (dev port)
 - additional properties is emitted once Powered=3DTrue inside a =

   Settings dictionary

Rafael Ignacio Zurita (9):
  gps: define new dbus interface
  gps: add new interface to feature map
  gps: add public header
  gps: implement interface/atom
  mbmmodem: add gps atom
  plugins: add gps atom to mbm
  plugins/udev.c: add gps comparison for add_mbm registered modem
  gps: add test scripts
  gps: add documentation

 Makefile.am                 |   13 +-
 doc/gps-api.txt             |   54 ++++++
 drivers/mbmmodem/gps.c      |  229 +++++++++++++++++++++++++
 drivers/mbmmodem/mbmmodem.c |    2 +
 drivers/mbmmodem/mbmmodem.h |    3 +
 include/dbus.h              |    1 +
 include/gps.h               |   74 ++++++++
 plugins/mbm.c               |    8 +
 plugins/udev.c              |    5 +-
 src/gps.c                   |  389 +++++++++++++++++++++++++++++++++++++++=
++++
 src/modem.c                 |    1 +
 src/ofono.h                 |    2 +
 test/disable-gps            |   20 +++
 test/enable-gps             |   20 +++
 14 files changed, 814 insertions(+), 7 deletions(-)
 create mode 100644 doc/gps-api.txt
 create mode 100644 drivers/mbmmodem/gps.c
 create mode 100644 include/gps.h
 create mode 100644 src/gps.c
 create mode 100755 test/disable-gps
 create mode 100755 test/enable-gps

-- =

1.7.2.3


--===============8998792001449374586==--

