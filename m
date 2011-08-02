Content-Type: multipart/mixed; boundary="===============4113953113090017369=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v4 0/6] Create CDMA Network Registration atom
Date: Tue, 02 Aug 2011 14:45:16 +0200
Message-ID: <1312289122-22845-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4113953113090017369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create an org.ofono.cdma.NetworkRegistration interface.
Create the skeleton for the new interface.
Modify SpeedUpCDMA driver to register this atom.
Add status information to the CDMA Network registration atom.
Register to ^MODE notification to be informed when network change.
Send ^SYSINFO to get network status information.

Bertrand Aygon (6):
  cdmamodem: Define CDMA Network Registration atom.
  cdmamodem: Create org.ofono.cdma.NetworkRegistration interface.
  cdmamodem: Create CDMA network registration atom.
  speedupcdma: register to CDMA network registration atom.
  cdmamodem: add status info to cdma network atom.
  cdmamodem: register for network status notification.

 Makefile.am                              |    9 +-
 drivers/cdmamodem/cdmamodem.c            |    2 +
 drivers/cdmamodem/cdmamodem.h            |    2 +
 drivers/cdmamodem/network-registration.c |  156 +++++++++++++++++++
 include/cdma-netreg.h                    |   69 +++++++++
 include/dbus.h                           |    2 +
 plugins/speedupcdma.c                    |    3 +
 src/cdma-netreg.c                        |  244 ++++++++++++++++++++++++++=
++++
 src/ofono.h                              |    2 +
 9 files changed, 485 insertions(+), 4 deletions(-)
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

--===============4113953113090017369==--

