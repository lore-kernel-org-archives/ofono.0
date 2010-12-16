Content-Type: multipart/mixed; boundary="===============5017375940894232053=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 0/8] Add GPS atom
Date: Thu, 16 Dec 2010 17:30:15 -0300
Message-ID: <1292531423-22316-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5017375940894232053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches add GPS atom to ofono, and implement it for mbm modem.

Rafael Ignacio Zurita (8):
  gps: define new dbus interface
  gps: add new interface to feature map
  gps: add public header
  gps: implement interface/atom
  mbmmodem: add gps atom
  plugins: add gps atom to mbm
  plugins/udev.c: add gps comparison for add_mbm registered modem
  gps: add documentation

 Makefile.am                 |   10 +-
 doc/gps-api.txt             |   41 ++++++
 drivers/mbmmodem/gps.c      |  185 ++++++++++++++++++++++++
 drivers/mbmmodem/mbmmodem.c |    2 +
 drivers/mbmmodem/mbmmodem.h |    3 +
 include/dbus.h              |    1 +
 include/gps.h               |   65 +++++++++
 plugins/mbm.c               |   30 ++++-
 plugins/udev.c              |    5 +-
 src/gps.c                   |  333 +++++++++++++++++++++++++++++++++++++++=
++++
 src/modem.c                 |    1 +
 src/ofono.h                 |    2 +
 12 files changed, 670 insertions(+), 8 deletions(-)
 create mode 100644 doc/gps-api.txt
 create mode 100644 drivers/mbmmodem/gps.c
 create mode 100644 include/gps.h
 create mode 100644 src/gps.c

-- =

1.7.2.3


--===============5017375940894232053==--

