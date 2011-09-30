Content-Type: multipart/mixed; boundary="===============0010167236870305221=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv8 0/6] Provisioning plugin
Date: Fri, 30 Sep 2011 16:31:08 +0300
Message-ID: <1317389474-16566-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0010167236870305221==
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

Oleg Zhurakivskyy (6):
  plugins: Provisioning plugin autoconf support
  plugins: Provisioning plugin makefile changes
  plugins: mobile-broadband-provider-info parser changes
  plugins: mobile-broadband-provider-info parser changes
  plugins: Add provisioning plugin
  tools: lookup-apn update

 Makefile.am         |    7 +
 configure.ac        |   23 +++-
 plugins/mbpi.c      |  339 +++++++++++++++++++++++++++++++++--------------=
----
 plugins/mbpi.h      |    4 +-
 plugins/provision.c |  125 +++++++++++++++++++
 tools/lookup-apn.c  |   32 +++---
 6 files changed, 389 insertions(+), 141 deletions(-)
 create mode 100644 plugins/provision.c

-- =

1.7.4.1


--===============0010167236870305221==--

