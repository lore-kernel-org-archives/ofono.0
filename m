Content-Type: multipart/mixed; boundary="===============7472888337526334956=="
MIME-Version: 1.0
From: KrzysztofX Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 0/8] hfpmodem: Add Apple Siri
Date: Mon, 16 Dec 2013 17:52:36 +0000
Message-ID: <1387216364-7138-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7472888337526334956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is an integration of the extended features for Apple devices which =

are connected via Bluetooth HFP. The plugin provides the Siri availability
and the selection of Eyes Free Mode as defined in the following document:
https://developer.apple.com/hardwaredrivers/bluetoothdesignguidelines.pdf

KrzysztofX Wilk (8):
  doc: Add Siri API
  dbus: Define Siri DBUS Interface
  include: Add Siri interface definition
  siri: Add atom implementation
  siri: Add atom driver
  hfp_hf_bluez4: Enable Siri atom
  hfp_hf_bluez5: Enable Siri atom
  phonesim: Enable Siri atom

 Makefile.am                 |  10 +-
 doc/siri-api.txt            |  43 ++++++
 drivers/hfpmodem/hfpmodem.c |   2 +
 drivers/hfpmodem/hfpmodem.h |   3 +
 drivers/hfpmodem/siri.c     | 215 ++++++++++++++++++++++++++++
 include/dbus.h              |   1 +
 include/siri.h              |  65 +++++++++
 plugins/hfp_hf_bluez4.c     |   2 +
 plugins/hfp_hf_bluez5.c     |   2 +
 plugins/phonesim.c          |   2 +
 src/ofono.h                 |   1 +
 src/siri.c                  | 331 ++++++++++++++++++++++++++++++++++++++++=
++++
 12 files changed, 673 insertions(+), 4 deletions(-)
 mode change 100644 =3D> 100755 Makefile.am
 create mode 100644 doc/siri-api.txt
 mode change 100644 =3D> 100755 drivers/hfpmodem/hfpmodem.c
 mode change 100644 =3D> 100755 drivers/hfpmodem/hfpmodem.h
 create mode 100755 drivers/hfpmodem/siri.c
 create mode 100755 include/siri.h
 mode change 100644 =3D> 100755 plugins/hfp_hf_bluez4.c
 mode change 100644 =3D> 100755 plugins/hfp_hf_bluez5.c
 mode change 100644 =3D> 100755 plugins/phonesim.c
 mode change 100644 =3D> 100755 src/ofono.h
 create mode 100755 src/siri.c

-- =

1.7.11.7


--===============7472888337526334956==--

