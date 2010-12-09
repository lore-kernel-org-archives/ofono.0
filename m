Content-Type: multipart/mixed; boundary="===============2395436818875982460=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH 0/5] Add CDMA SMS Support
Date: Wed, 08 Dec 2010 16:35:46 -0800
Message-ID: <1291854951-2378-1-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2395436818875982460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patches introduces the foundation for CDMA SMS support in oFono.
The pathes cover support of receiving simple CDMA SMS WMT DELIVER message.
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

Limitations
-----------
Due to the limitation that we can not find any CDMA hardware supporting CDMA
SMS over AT interface in PDU mode, we are not able to test this patch =

against any actual hardware. Still, we feel that the patch will be useful
as foundation for introducing CDMA SMS support in oFono.

Lei Yu (5):
  cdma-sms: Add CDMA SMS Support
  cdma-sms: Add CDMA SMS Support
  cdma-atmodem: Add CDMA SMS Support
  cdmaphonesim: Add CDMA SMS Support
  test: Add CDMA SMS unit test code

 Makefile.am                    |   27 ++-
 configure.ac                   |   11 +
 drivers/cdma-atmodem/atmodem.c |   47 ++++
 drivers/cdma-atmodem/atmodem.h |   23 ++
 drivers/cdma-atmodem/atutil.c  |   45 ++++
 drivers/cdma-atmodem/atutil.h  |   64 ++++++
 drivers/cdma-atmodem/sms.c     |  151 +++++++++++++
 include/cdma-sms.h             |   69 ++++++
 include/dbus.h                 |    4 +
 plugins/cdmaphonesim.c         |  344 +++++++++++++++++++++++++++++
 plugins/cdmaphonesim.conf      |   14 ++
 src/cdma-sms.c                 |  342 +++++++++++++++++++++++++++++
 src/cdma-smsutil.c             |  467 ++++++++++++++++++++++++++++++++++++=
++++
 src/cdma-smsutil.h             |  264 +++++++++++++++++++++++
 src/ofono.h                    |    2 +
 unit/test-cdmasms.c            |  134 ++++++++++++
 16 files changed, 2005 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cdma-atmodem/atmodem.c
 create mode 100644 drivers/cdma-atmodem/atmodem.h
 create mode 100644 drivers/cdma-atmodem/atutil.c
 create mode 100644 drivers/cdma-atmodem/atutil.h
 create mode 100644 drivers/cdma-atmodem/sms.c
 create mode 100644 include/cdma-sms.h
 create mode 100644 plugins/cdmaphonesim.c
 create mode 100644 plugins/cdmaphonesim.conf
 create mode 100644 src/cdma-sms.c
 create mode 100644 src/cdma-smsutil.c
 create mode 100644 src/cdma-smsutil.h
 create mode 100644 unit/test-cdmasms.c


--===============2395436818875982460==--

