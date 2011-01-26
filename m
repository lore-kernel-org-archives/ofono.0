Content-Type: multipart/mixed; boundary="===============1046517931454874366=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v3 0/7] Add GPS atom
Date: Wed, 26 Jan 2011 12:32:47 -0300
Message-ID: <1296055974-9640-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1046517931454874366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches add GPS atom to ofono, and implement it for mbm modem.

Changes since V2: there is a new API
 - removed Settings property
 - added gpsagent
 - removed additional properties emitted once Powered=3DTrue
 - removed gps_set_property and gps_signal_ which are not needed
   anymore
 - removed enable-gps and disable-gps scripts. Add
   test-location-reporting script
 - adapted gps atom, gps mbm driver, and documentation to the new API
 =

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

Rafael Ignacio Zurita (7):
  gps: add public header
  gps: add gps atom and gpsagent implementations
  mbmmodem: add gps atom
  plugins: add gps atom to mbm
  plugins/udev.c: add gps comparison for add_mbm registered modem
  gps: add test script
  gps: add documentation

 Makefile.am                  |   14 ++-
 doc/gps-api.txt              |   49 +++++++
 drivers/mbmmodem/gps.c       |  247 ++++++++++++++++++++++++++++++++
 drivers/mbmmodem/mbmmodem.c  |    2 +
 drivers/mbmmodem/mbmmodem.h  |    3 +
 include/gps.h                |   76 ++++++++++
 plugins/mbm.c                |    8 +
 plugins/udev.c               |    5 +-
 src/gps.c                    |  326 ++++++++++++++++++++++++++++++++++++++=
++++
 src/gpsagent.c               |  145 +++++++++++++++++++
 src/gpsagent.h               |   37 +++++
 src/ofono.conf               |    1 +
 src/ofono.h                  |    2 +
 test/test-location-reporting |   49 +++++++
 14 files changed, 957 insertions(+), 7 deletions(-)
 create mode 100644 doc/gps-api.txt
 create mode 100644 drivers/mbmmodem/gps.c
 create mode 100644 include/gps.h
 create mode 100644 src/gps.c
 create mode 100644 src/gpsagent.c
 create mode 100644 src/gpsagent.h
 create mode 100644 test/test-location-reporting

-- =

1.7.2.3


--===============1046517931454874366==--

