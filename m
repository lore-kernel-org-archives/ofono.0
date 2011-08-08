Content-Type: multipart/mixed; boundary="===============6471296186758762899=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v7 0/4] Create CDMA netreg atom
Date: Mon, 08 Aug 2011 13:53:25 +0200
Message-ID: <1312804409-6913-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6471296186758762899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Bertrand will not be availaible for some time, he asked me to continue on t=
his
set of patches. This v7 concerns not applied patch 7, 8, 11 and 13 of v6.

Changelog is:
	- Print ofono_error() when AT^SYSINFO or AT^RSSILVL result is invalid.
	- Use GAtChat as driver_data instead of a huaweicdma_netreg_data
	  structure.
	- Register status/signal_strength notification callbacks only if probe
	  succeeded.
	- Simplify cdma_netreg strength notification APIs


Bertrand Aygon (4):
  huaweicdma: create a dedicated netreg atom.
  huaweicdma: register to CDMA netreg atom.
  huaweicdma: register to ^RSSILVL to update signal strength.
  cdmamodem: add data strength to CDMA netreg atom.

 Makefile.am                                    |    3 +-
 drivers/huaweicdmamodem/huaweicdmamodem.c      |    3 +
 drivers/huaweicdmamodem/huaweicdmamodem.h      |    3 +
 drivers/huaweicdmamodem/network-registration.c |  199 ++++++++++++++++++++=
++++
 plugins/huaweicdma.c                           |    3 +
 src/cdma-netreg.c                              |   48 +++++-
 6 files changed, 249 insertions(+), 10 deletions(-)
 create mode 100644 drivers/huaweicdmamodem/network-registration.c


--===============6471296186758762899==--

