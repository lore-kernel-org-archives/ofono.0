Content-Type: multipart/mixed; boundary="===============3935467328456273860=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v3 0/4] Create CDMA Network Registration atom
Date: Thu, 28 Jul 2011 13:37:52 +0200
Message-ID: <1311853076-15878-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3935467328456273860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create an org.ofono.cdma.NetworkRegistration interface.
Just create a skeleton for now.
Modify SpeedUpCDMA driver to use this new atom.

Bertrand Aygon (4):
  cdmamodem: Define CDMA Network Registration atom.
  cdmamodem: Create org.ofono.cdma.NetworkRegistration interface.
  cdmamodem: Create CDMA network registration atom.
  speedupcdma: register to CDMA network registration atom.

 Makefile.am                              |    9 +-
 drivers/cdmamodem/cdmamodem.c            |    2 +
 drivers/cdmamodem/cdmamodem.h            |    2 +
 drivers/cdmamodem/network-registration.c |   81 +++++++++++++
 include/cdma-netreg.h                    |   61 ++++++++++
 include/dbus.h                           |    2 +
 plugins/speedupcdma.c                    |    3 +
 src/cdma-netreg.c                        |  188 ++++++++++++++++++++++++++=
++++
 src/ofono.h                              |    2 +
 9 files changed, 346 insertions(+), 4 deletions(-)
 create mode 100644 drivers/cdmamodem/network-registration.c
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

--===============3935467328456273860==--

