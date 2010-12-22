Content-Type: multipart/mixed; boundary="===============7490136878807904901=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH v2, 0/7] Add CDMA SMS Support
Date: Tue, 21 Dec 2010 16:02:22 -0800
Message-ID: <1292976149-15598-1-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7490136878807904901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patches introduces the foundation for CDMA SMS support in oFono.
The patches cover support of receiving simple CDMA SMS WMT DELIVER message.
Currently, only few CDMA SMS parameters and subparameters have been support=
ed.
Support of additional features will come in future patches.

Included in the patch is also CDMA SMS unit test code. The patch also inclu=
de
simple cdmaphonesim which is based of AT modem driver. The patch has been
unit tested and also tested against phonesim. The modifications to the
phonesim will be submitted separately.

Also note that since CDMA does not define standard AT interface for SMS, we
use the same set of GSM AT commands in this patch to work with phonesim.
It is our understanding that CDMA modem vendors also uses GSM AT commands f=
or
SMS support.

Note, this serie of patch depends on following patch
   [PATCH v3, Part 1, 2/5] cdmamodem: Add cdmamodem stubs

Limitations
-----------
Due to the limitation that we can not find any CDMA hardware supporting CDMA
SMS over AT interface in PDU mode, we are not able to test this patch =

against any actual hardware. Still, we feel that the patch will be useful
as foundation for introducing CDMA SMS support in oFono.

Lei Yu (7):
  dbus: Add CDMA SMS Interface
  cdma-sms: Add CDMA SMS Support
  cdma-sms: Add CDMA SMS Support
  cdma-sms: Add CDMA SMS Support
  cdmamodem: Add CDMA SMS driver support
  test: Add CDMA SMS Support
  cdmaphonesim: Add CDMA SMS Support

 Makefile.am                   |   28 ++-
 configure.ac                  |    5 +
 drivers/cdmamodem/cdmamodem.c |   47 ++++
 drivers/cdmamodem/cdmamodem.h |   25 ++
 drivers/cdmamodem/sms.c       |  153 +++++++++++++
 include/cdma-sms.h            |   67 ++++++
 include/dbus.h                |    1 +
 plugins/cdmaphonesim.c        |  328 ++++++++++++++++++++++++++++
 plugins/cdmaphonesim.conf     |   14 ++
 src/cdma-sms.c                |  335 ++++++++++++++++++++++++++++
 src/cdma-smsutil.c            |  484 +++++++++++++++++++++++++++++++++++++=
++++
 src/cdma-smsutil.h            |  264 ++++++++++++++++++++++
 src/ofono.h                   |    3 +
 unit/test-cdmasms.c           |  137 ++++++++++++
 14 files changed, 1888 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cdmamodem/cdmamodem.c
 create mode 100644 drivers/cdmamodem/cdmamodem.h
 create mode 100644 drivers/cdmamodem/sms.c
 create mode 100644 include/cdma-sms.h
 create mode 100644 plugins/cdmaphonesim.c
 create mode 100644 plugins/cdmaphonesim.conf
 create mode 100644 src/cdma-sms.c
 create mode 100644 src/cdma-smsutil.c
 create mode 100644 src/cdma-smsutil.h
 create mode 100644 unit/test-cdmasms.c


--===============7490136878807904901==--

