Content-Type: multipart/mixed; boundary="===============7394095532050095962=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 0/4] CDMA-connman add username and password properties
Date: Thu, 21 Jul 2011 06:40:40 +0200
Message-ID: <1311223244-26904-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7394095532050095962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change log from v1:
	- username and password storage is now very similar to gprs one.
	- rework logic flow.

Guillaume Zajac (4):
  cdma-connman: pass username and password to drivers while activating
    cdma-connman
  cdma-connman: add username and password, pass them to drivers
  driver cdma-connman: pass credentials into activate function
  test: add script to set credentials for cdma connection

 drivers/cdmamodem/connman.c  |    9 +++++++
 include/cdma-connman.h       |    5 ++++
 src/cdma-connman.c           |   48 ++++++++++++++++++++++++++++++++++++++=
+++-
 test/create-cdma-credentials |   29 +++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 1 deletions(-)
 create mode 100755 test/create-cdma-credentials


--===============7394095532050095962==--

