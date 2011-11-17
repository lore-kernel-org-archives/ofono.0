Content-Type: multipart/mixed; boundary="===============9031753875486776069=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 0/6] Add a parser to retrieve the CDMA network name
Date: Thu, 17 Nov 2011 17:20:58 +0100
Message-ID: <1321546864-368-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9031753875486776069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

- Fix according Denis review (remove unnecessary checking, fix coding style=
 issues).
- Add the serving system query based on the standard CDMA AT command AT+CSS=
?.
- Merge the huaweicdmamodem driver with cdmamodem driver.



Philippe Nunes (6):
  mbpi: Add mbpi_lookup_cdma_provider_name API
  tools: Add utility for looking CDMA network name from database
  Huaweicdmamodem: remove this specific driver
  huaweicdmamodem: Merge this driver with cdmamodem driver
  cdmamodem: Add CDMA network-registration support
  cdmamodem: Add serving system identifier support

 Makefile.am                                    |   19 +-
 drivers/cdmamodem/cdmamodem.c                  |    2 +
 drivers/cdmamodem/cdmamodem.h                  |    2 +
 drivers/cdmamodem/network-registration.c       |  279 ++++++++++++++++++++=
++++
 drivers/huaweicdmamodem/huaweicdmamodem.c      |   45 ----
 drivers/huaweicdmamodem/huaweicdmamodem.h      |   23 --
 drivers/huaweicdmamodem/network-registration.c |  199 -----------------
 include/cdma-netreg.h                          |    7 +
 plugins/huaweicdma.c                           |    5 +-
 plugins/mbpi.c                                 |  146 ++++++++++++
 plugins/mbpi.h                                 |    2 +
 tools/lookup-provider-name.c                   |  100 +++++++++
 12 files changed, 552 insertions(+), 277 deletions(-)
 create mode 100644 drivers/cdmamodem/network-registration.c
 delete mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.c
 delete mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.h
 delete mode 100644 drivers/huaweicdmamodem/network-registration.c
 create mode 100644 tools/lookup-provider-name.c


--===============9031753875486776069==--

