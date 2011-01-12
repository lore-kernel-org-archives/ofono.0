Content-Type: multipart/mixed; boundary="===============1119377227299702575=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 0/5 v3] Neighbor Cell Info Atom
Date: Wed, 12 Jan 2011 14:05:14 +0200
Message-ID: <1294833919-1510-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1119377227299702575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 This series of patches implements an interface for client
 applications to fetch the ECID information of neighboring
 cells using DBUS. Since the 1st version the DBUS api has
 been refactored to use new naming for method and to use
 flat data format for the cell information. Also, the
 internal datatypes have been optimized. Since the 2nd
 version MNC and MCC are converted to strings and CPICH-RSCP
 re-typed.

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
 src/cell-info.c     |  485 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h         |    1 +
 6 files changed, 741 insertions(+), 3 deletions(-)
 create mode 100644 doc/cell-info.txt
 create mode 100644 include/cell-info.h
 create mode 100644 src/cell-info.c


--===============1119377227299702575==--

