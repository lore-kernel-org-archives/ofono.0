Content-Type: multipart/mixed; boundary="===============2294073559428147009=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 00/10] Provider name and SID
Date: Wed, 14 Dec 2011 18:56:02 +0100
Message-ID: <1323885372-3574-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2294073559428147009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This version is mainly focused by naming changes for consistency.

Philippe.

Philippe Nunes (10):
  cdma-provision: Add driver APIs header
  ofono.h: add API to get cdma provider name
  cdma-provision: Add driver APIs implementation
  cdma-provision: Add cdma provisioning plugin
  cdma-netreg: Add provider name and SID support
  gatchat: Add g_at_chat_set_slave_qcdm / g_at_chat_get_slave_qcdm
  huaweicdma: Open qcdm port to be used for network status and cell
    location
  huaweicdmamodem: Probe the QCDM port with the version info request
  huaweicdmamodem: Add 'serving_system' entry point to get SID
  udevng: Add a default assignment for Huawei QCDM port

 Makefile.am                                    |    4 +-
 drivers/huaweicdmamodem/network-registration.c |  247 ++++++++++++++++++++=
++-
 gatchat/gatchat.c                              |   26 +++
 gatchat/gatchat.h                              |    4 +
 include/cdma-provision.h                       |   44 +++++
 plugins/cdma-provision.c                       |   79 ++++++++
 plugins/huaweicdma.c                           |   44 +++++
 plugins/udevng.c                               |   30 ++-
 src/cdma-netreg.c                              |   40 ++++
 src/cdma-provision.c                           |   80 ++++++++
 src/ofono.h                                    |    4 +
 11 files changed, 580 insertions(+), 22 deletions(-)
 create mode 100644 include/cdma-provision.h
 create mode 100644 plugins/cdma-provision.c
 create mode 100644 src/cdma-provision.c


--===============2294073559428147009==--

