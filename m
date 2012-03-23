Content-Type: multipart/mixed; boundary="===============1515760018572490545=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 0/3] ZTE: Create a modem driver to enable radio settings
Date: Fri, 23 Mar 2012 12:01:07 +0100
Message-ID: <1332500470-8297-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1515760018572490545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 - Create ZTE modem driver
 - Add radio settings support to ZTE modem driver
 - Enable radio settings in ZTE plugin =


Bertrand Aygon (3):
  Add ZTE modem driver
  ztemodem: Add radio settings support
  zte: Add support for radio settings

 Makefile.am                       |    6 +
 drivers/ztemodem/radio-settings.c |  212 +++++++++++++++++++++++++++++++++=
++++
 drivers/ztemodem/ztemodem.c       |   49 +++++++++
 drivers/ztemodem/ztemodem.h       |   25 +++++
 plugins/zte.c                     |    3 +
 5 files changed, 295 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ztemodem/radio-settings.c
 create mode 100644 drivers/ztemodem/ztemodem.c
 create mode 100644 drivers/ztemodem/ztemodem.h

-- =

1.7.5.4

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

--===============1515760018572490545==--

