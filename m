Content-Type: multipart/mixed; boundary="===============4643469594029990129=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/4] CDMA-connman add username and password properties
Date: Wed, 20 Jul 2011 11:26:36 +0200
Message-ID: <1311154000-32353-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4643469594029990129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

These patches will be used to set PPP credentials when CDMA network will ne=
ed them.
It contains a test script based on create-internet-context script.

Guillaume Zajac (4):
  cdma-connman: add prototype to retrieve username and password
  cdma-connman: add possibility to set a username and a password
  driver cdma-connman: add credential while setting up PPP if required
  test: add script to set credentials for cdma connection

 drivers/cdmamodem/connman.c  |    8 +++++++
 include/cdma-connman.h       |    4 +++
 src/cdma-connman.c           |   44 ++++++++++++++++++++++++++++++++++++++=
+++-
 test/create-cdma-credentials |   29 +++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 1 deletions(-)
 create mode 100755 test/create-cdma-credentials


--===============4643469594029990129==--

