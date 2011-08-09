Content-Type: multipart/mixed; boundary="===============6938870138638426231=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/3] Add CDMA features to load/save/remove credentials
Date: Tue, 09 Aug 2011 16:48:04 +0200
Message-ID: <1312901287-30032-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6938870138638426231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Credentials can now be saved and loaded at starting.
Credentials can now be removed using new cdma_remove-credentials script.

Guillaume Zajac (3):
  cdma-connman: add feature to load/save credentials
  cdma-connman: Add D-Bus API to remove credentials
  test: Add cdma-remove-credentials script

 Makefile.am                  |    1 +
 include/cdma-connman.h       |    3 +
 src/cdma-connman.c           |   91 ++++++++++++++++++++++++++++++++++++++=
++++
 src/modem.c                  |   35 ++++++++++++++++
 test/cdma-remove-credentials |   21 ++++++++++
 5 files changed, 151 insertions(+), 0 deletions(-)
 create mode 100755 test/cdma-remove-credentials


--===============6938870138638426231==--

