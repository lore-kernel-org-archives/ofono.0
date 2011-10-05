Content-Type: multipart/mixed; boundary="===============4110742891929984217=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 00/16] Provisioning plugin
Date: Wed, 05 Oct 2011 16:18:23 +0300
Message-ID: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4110742891929984217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the provisioning plugin ("Internet Access Provider database" TO=
DO item).

If enabled, the plugin reads mobile-broadband-provider-info database entrie=
s (PROVIDER_DATABASE) and returns GRPS context settings to oFono provisioni=
ng module.

Regards,
Oleg

Oleg Zhurakivskyy (16):
  mbpi: Remove unused includes
  mbpi: Split gsm_start() for readability
  mbpi: Reflow gsm_end()
  mbpi: Fix handling of the usage element
  mbpi: Improve mbpi_lookup() error reporting
  lookup-apn: Remove unused includes
  lookup-apn: Fix crash on no APNs found
  provision: Add provisioning plugin
  mbpi: Add filename and line information on error
  mbpi: Add mbpi_ap_type()
  lookup-apn: Use mbpi_ap_type()
  mbpi: Rename mbpi_provision_data_free() into mbpi_ap_free()
  lookup-apn: Use mbpi_ap_free()
  mbpi: Minor style issues
  lookup-apn: Follow plugin's duplicates approach
  lookup-apn: Minor style issues

 Makefile.am         |    7 ++
 configure.ac        |   23 +++--
 plugins/mbpi.c      |  291 ++++++++++++++++++++++++++++++-----------------=
----
 plugins/mbpi.h      |    4 +-
 plugins/provision.c |  120 +++++++++++++++++++++
 tools/lookup-apn.c  |   34 +++---
 6 files changed, 336 insertions(+), 143 deletions(-)
 create mode 100644 plugins/provision.c

-- =

1.7.4.1


--===============4110742891929984217==--

