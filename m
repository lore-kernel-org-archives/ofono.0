Content-Type: multipart/mixed; boundary="===============6000196408125179353=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv10 0/9] Provisioning plugin
Date: Tue, 18 Oct 2011 14:04:56 +0300
Message-ID: <1318935905-9087-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6000196408125179353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find corrections to the remaining parts of the provisioning plugin (=
"Internet Access Provider database" TODO item).

Regards,
Oleg

Oleg Zhurakivskyy (9):
  mbpi: Minor style tweaks
  provision: Add provisioning plugin
  mbpi: Add mbpi_ap_type()
  lookup-apn: Use mbpi_ap_type()
  lookup-apn: Add command line option to control duplicates
  mbpi: Rename mbpi_provision_data_free()
  lookup-apn: Use mbpi_ap_free()
  mbpi: Minor style issues
  lookup-apn: Minor style issues

 Makefile.am         |    7 +++
 configure.ac        |   23 +++++++---
 plugins/mbpi.c      |   68 ++++++++++++++++++-----------
 plugins/mbpi.h      |    4 +-
 plugins/provision.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tools/lookup-apn.c  |   32 ++++++++------
 6 files changed, 204 insertions(+), 48 deletions(-)
 create mode 100644 plugins/provision.c

-- =

1.7.4.1


--===============6000196408125179353==--

