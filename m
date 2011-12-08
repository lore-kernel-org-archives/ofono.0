Content-Type: multipart/mixed; boundary="===============0376697258244039890=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 00/12] Provider name and SID
Date: Thu, 08 Dec 2011 15:49:51 +0100
Message-ID: <1323355803-22096-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0376697258244039890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

change log from previous version:

- Fix the copyrigths.
- Add Qualcomm Diagnostic Monitor port support to get the SID with the comm=
and
'station status'. This diagnostic port is especially needed in case of EV-DO
capable hardware for which the AT command AT+CSS? may not return a valid an=
swer.
- Assign by default the huawei QCDM port to the second interface (this rule=
 is
issued from a practical observation)
- Fix the 'sysinfo' parsing. When the service domain is set to 'CDMA not su=
pported'
with EV-DO capable hardware, it doesn't mean that the network is not regist=
ered.

Regards,

Philippe.


Philippe Nunes (12):
  cdma-providers: add driver APIs header
  ofono.h: add cdma-providers
  cdma-providers: add driver APIs implementation
  providers: Add cdma provider name plugin
  cdma-netreg: Add provider name and SID support
  gatchat: Add possibility to associate a diagnostic monitor to the
    AT-capable port
  huaweicdma: Use pcui port for cdma_netreg
  huaweicdma: Open qcdm port to be used for signal quality or network
    status
  huaweicdmamodem: Probe the QCDM port with the version info request
  huaweicdmamodem: Add 'serving_system' entry point to get SID
  udevng: Add a default assignment for Huawei QCDM port
  huaweicdmamodem: Fix sysinfo parsing

 Makefile.am                                    |    4 +-
 drivers/huaweicdmamodem/network-registration.c |  247 ++++++++++++++++++++=
++-
 gatchat/gatchat.c                              |   26 +++
 gatchat/gatchat.h                              |    4 +
 include/cdma-providers.h                       |   44 +++++
 plugins/huaweicdma.c                           |   46 +++++-
 plugins/providers.c                            |   79 ++++++++
 plugins/udevng.c                               |   30 ++-
 src/cdma-netreg.c                              |   40 ++++
 src/cdma-providers.c                           |   80 ++++++++
 src/ofono.h                                    |    4 +
 11 files changed, 581 insertions(+), 23 deletions(-)
 create mode 100644 include/cdma-providers.h
 create mode 100644 plugins/providers.c
 create mode 100644 src/cdma-providers.c


--===============0376697258244039890==--

