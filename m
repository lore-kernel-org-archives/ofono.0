Content-Type: multipart/mixed; boundary="===============2092148571464572254=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v2 0/3] Create CDMA Network Registration atom
Date: Sat, 23 Jul 2011 06:09:27 +0200
Message-ID: <1311394170-7381-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2092148571464572254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create an org.ofono.cdma.NetworkRegistraiton interface

Bertrand Aygon (3):
  cdmamodem: Create org.ofono.cdma.NetworkRegistration interface.
  cdmamodem: Create network registration atom.
  speedupcdma: register to cdma network registration atom.

 Makefile.am                              |    9 +-
 drivers/cdmamodem/cdmamodem.c            |    2 +
 drivers/cdmamodem/cdmamodem.h            |    5 +
 drivers/cdmamodem/network-registration.c |  139 ++++++++++++++++++
 include/cdma-netreg.h                    |   63 ++++++++
 include/dbus.h                           |    2 +
 plugins/speedupcdma.c                    |    3 +
 src/cdma-netreg.c                        |  233 ++++++++++++++++++++++++++=
++++
 src/ofono.h                              |    2 +
 9 files changed, 454 insertions(+), 4 deletions(-)
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

--===============2092148571464572254==--

