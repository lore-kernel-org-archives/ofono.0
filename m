Content-Type: multipart/mixed; boundary="===============8606250998200592206=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [RFC PATCH 0/4] Atom for Neighbour Cell Info
Date: Tue, 21 Dec 2010 16:00:20 +0200
Message-ID: <1292940024-24363-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8606250998200592206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 This series of patches implements an interface for client
 application to fetch the ECID information of neighbouring
 cells using DBUS.

 src/cell-info.c |  537 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/cell-info.h |   66 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/dbus.h |    1 +
 src/ofono.h    |    1 +
 Makefile.am |    4 ++--

--===============8606250998200592206==--

