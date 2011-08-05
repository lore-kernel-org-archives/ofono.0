Content-Type: multipart/mixed; boundary="===============1846240643054159578=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v6 00/14] Create CDMA netreg atom
Date: Fri, 05 Aug 2011 15:21:01 +0200
Message-ID: <1312550475-8537-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1846240643054159578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create an org.ofono.cdma.NetworkRegistration interface
Create first the skeleton
Then add status information.
Create a Huawei CDMA network.
Add a netreg atom for this driver.
Modify Huawei CDMA plugin to use this atom.
Add signal strength support.
And data signal strength support.

Bertrand Aygon (14):
  cdmamodem: define CDMA netreg atom.
  cdmamodem: create include file for CDMA netreg.
  cdmamodem: create the interface for CDMA netreg.
  cdmamodem: define cdma network status.
  cdmamodem: implement cdma network status.
  huaweicdmamodem: create a huawei cdma driver.
  huaweicdma: create a dedicated netreg atom.
  huaweicdma: register to CDMA netreg atom.
  cdmamodem: add strength to CDMA netreg atom
  cdmamodem: add strength to CDMA netreg atom.
  huaweicdma: register to ^RSSILVL to update signal strength.
  cdmamodem: add data strength to CDMA netreg atom.
  cdmamodem: add data strength to CDMA netreg atom.
  test: update list-modem to display CDMA DataStrength info.

 Makefile.am                                    |   10 +-
 drivers/huaweicdmamodem/huaweicdmamodem.c      |   45 ++++
 drivers/huaweicdmamodem/huaweicdmamodem.h      |   23 ++
 drivers/huaweicdmamodem/network-registration.c |  198 +++++++++++++++
 include/cdma-netreg.h                          |   76 ++++++
 plugins/huaweicdma.c                           |    3 +
 src/cdma-netreg.c                              |  315 ++++++++++++++++++++=
++++
 src/ofono.h                                    |    2 +
 test/list-modems                               |    3 +-
 9 files changed, 672 insertions(+), 3 deletions(-)
 create mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.c
 create mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.h
 create mode 100644 drivers/huaweicdmamodem/network-registration.c
 create mode 100644 include/cdma-netreg.h
 create mode 100644 src/cdma-netreg.c

-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============1846240643054159578==--

