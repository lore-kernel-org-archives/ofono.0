Content-Type: multipart/mixed; boundary="===============7789437736377959152=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH v2 0/3] QMI NetworkMonitor
Date: Tue, 12 Sep 2017 12:52:34 +0200
Message-ID: <20170912105237.21750-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7789437736377959152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a resubmission of the network-monitor series for QMI modems.

Changes in v2:

* Fix endianess errors
* Add patch to fix out of tree build

Jonas Bonn (3):
  Fix out of tree build
  qmi: add NetworkMonitor interface
  gobi: create NetworkMonitor atom

 Makefile.am                 |   3 +-
 drivers/qmimodem/netmon.c   | 286 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/qmimodem.c |   2 +
 drivers/qmimodem/qmimodem.h |   3 +
 plugins/gobi.c              |   5 +-
 src/common.c                |   2 +-
 6 files changed, 298 insertions(+), 3 deletions(-)
 create mode 100644 drivers/qmimodem/netmon.c

-- =

2.9.3


--===============7789437736377959152==--

