Content-Type: multipart/mixed; boundary="===============5199890909950599781=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v9 0/4] Create CDMA netreg atom
Date: Mon, 08 Aug 2011 14:13:16 +0200
Message-ID: <1312805600-20043-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5199890909950599781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Already v9, cause of some issues.

Changelog from v8 is:
	- Remove struct cdma_netreg_data creating compilation issue
	- Use correct name "DataStrength" for data signal


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
 src/cdma-netreg.c                              |   54 +++++--
 6 files changed, 254 insertions(+), 11 deletions(-)
 create mode 100644 drivers/huaweicdmamodem/network-registration.c


--===============5199890909950599781==--

