Content-Type: multipart/mixed; boundary="===============3700998047254514545=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 0/5] Neighboring Cell Info
Date: Tue, 28 Dec 2010 15:27:22 +0200
Message-ID: <1293542847-24248-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3700998047254514545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 This series of patches implements an interface for client
 application to fetch the ECID information of neighboring
 cells using DBUS.
 =

 include/cell-info.h |  128 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/cell-info.c |  512 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/dbus.h |    1 +
 src/ofono.h    |    1 +
 Makefile.am |    8 +++++---
 doc/cell-info.txt |  124 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 =

=20

--===============3700998047254514545==--

