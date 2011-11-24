Content-Type: multipart/mixed; boundary="===============5034454745878630276=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/7] Get SID and provider name
Date: Thu, 24 Nov 2011 18:46:17 +0100
Message-ID: <1322156784-10402-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5034454745878630276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The goal of these patch is to:

- Merge the huaweicdmamodem driver with cdmamodem driver. =

- Add the serving system entry point in cdmamodem driver
- Retrieve the provider name based on the SID provided by the modem.


Philippe Nunes (7):
  Huaweicdmamodem: remove this specific driver
  huaweicdmamodem: Merge this driver with cdmamodem driver
  cdmamodem: Add CDMA network-registration support
  cdma-netreg: Add 'serving_system' entry point to cdma-netreg to get
    SID
  cdmamodem: Add serving system identifier support
  cdma-netreg: Make use of the new driver entry point serving_system
  cdma-netreg: Add provider name support

 Makefile.am                                    |   13 +-
 drivers/cdmamodem/cdmamodem.c                  |    2 +
 drivers/cdmamodem/cdmamodem.h                  |    2 +
 drivers/cdmamodem/network-registration.c       |  278 ++++++++++++++++++++=
++++
 drivers/huaweicdmamodem/huaweicdmamodem.c      |   45 ----
 drivers/huaweicdmamodem/huaweicdmamodem.h      |   23 --
 drivers/huaweicdmamodem/network-registration.c |  199 -----------------
 include/cdma-netreg.h                          |    7 +
 plugins/huaweicdma.c                           |    5 +-
 src/cdma-netreg.c                              |   55 +++++
 10 files changed, 353 insertions(+), 276 deletions(-)
 create mode 100644 drivers/cdmamodem/network-registration.c
 delete mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.c
 delete mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.h
 delete mode 100644 drivers/huaweicdmamodem/network-registration.c


--===============5034454745878630276==--

