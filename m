Content-Type: multipart/mixed; boundary="===============3125270876549865095=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 0/6] Manage Dormant property for CDMA modems
Date: Wed, 07 Dec 2011 17:05:45 +0100
Message-ID: <1323273951-24162-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3125270876549865095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This set of patches allows to configure the way CDMA modem will go into
dormant state. It can be configured in setting dormant interval, with a
new driver entry.
A callback is now registered to Dormant notification for Huawei CDMA
modems, to update Dormant value into Connection Manager.

Kind regards,
Guillaume

Guillaume Zajac (6):
  doc: Add DormantInterval property
  cdma-connman: Add dormant option configuration and notification
  cdma-connman: Add DormantInterval porperty and dormant notification
  huaweicdma: Specify vendor in creating cdma-connman atom
  cdmamodem: Add dormant notification and dormant interval setting
  test: Add script to set dormant interval

 Makefile.am                    |    1 +
 doc/cdma-connman-api.txt       |    5 ++
 drivers/cdmamodem/connman.c    |   83 ++++++++++++++++++++++++++++++++++++=
++++
 include/cdma-connman.h         |    7 +++
 plugins/huaweicdma.c           |    7 +++-
 src/cdma-connman.c             |   79 ++++++++++++++++++++++++++++++++++++=
+-
 test/cdma-set-dormant-interval |   24 +++++++++++
 7 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100755 test/cdma-set-dormant-interval


--===============3125270876549865095==--

