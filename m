Content-Type: multipart/mixed; boundary="===============3565969931874701127=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 0/5 v2] Neighbor cell info Atom
Date: Tue, 04 Jan 2011 16:36:54 +0200
Message-ID: <1294151819-3300-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3565969931874701127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 This series of patches implements an interface for client
 applications to fetch the ECID information of neighboring
 cells using DBUS. Since the 1st version the DBUS api has
 been refactored to use new naming for method and to use
 flat data format for the cell information. Also, the =

 internal datatypes have been optimized. =


Antti Paila (5):
  Cell-info: CellInfo DBUS interface definition
  Cell-info: Header file for Neighbor cell info
  Cell-info: Atom for obtaining ECID info of cells
  Cell-info: New files included in compilation
  Cell-info: Documentation

 Makefile.am         |    8 +-
 doc/cell-info.txt   |  121 +++++++++++++
 include/cell-info.h |  128 ++++++++++++++
 include/dbus.h      |    1 +
 src/cell-info.c     |  482 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h         |    1 +
 6 files changed, 738 insertions(+), 3 deletions(-)
 create mode 100644 doc/cell-info.txt
 create mode 100644 include/cell-info.h
 create mode 100644 src/cell-info.c


--===============3565969931874701127==--

