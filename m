Content-Type: multipart/mixed; boundary="===============0489976540793185219=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v5 0/8] Create CDMA Network Registration atom
Date: Wed, 03 Aug 2011 15:50:44 +0200
Message-ID: <1312379452-821-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0489976540793185219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create an org.ofono.cdma.NetworkRegistration interface.
Create the skeleton for the new interface.
Add status information to the CDMA Network registration atom.
Create a Huawei CDMA driver with a dedicated CDMA netreg atom. =

Modify Huawei CDMA driver to register this atom.

Bertrand Aygon (8):
  cdmamodem: Define CDMA Network Registration atom.
  cdmamodem: define CDMA netreg atom.
  cdmamodem: create include file for CDMA netreg.
  cdmamodem: create the interface for CDMA netreg.
  cdmamodem: define cdma network status.
  cdmamodem: implement cdma network status.
  huaweicdmamodem: create a huawei cdma driver.
  huaweicdma: register to CDMA netreg atom.

 Makefile.am                                    |   10 +-
 drivers/huaweicdmamodem/huaweicdmamodem.c      |   45 +++++
 drivers/huaweicdmamodem/huaweicdmamodem.h      |   23 +++
 drivers/huaweicdmamodem/network-registration.c |  159 ++++++++++++++++
 include/cdma-netreg.h                          |   67 +++++++
 include/dbus.h                                 |    2 +
 plugins/huaweicdma.c                           |    3 +
 src/cdma-netreg.c                              |  238 ++++++++++++++++++++=
++++
 src/ofono.h                                    |    2 +
 9 files changed, 547 insertions(+), 2 deletions(-)
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

--===============0489976540793185219==--

