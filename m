Content-Type: multipart/mixed; boundary="===============5725716886942067909=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv7 0/3] Provisioning plugin
Date: Fri, 23 Sep 2011 14:41:07 +0300
Message-ID: <1316778070-3862-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5725716886942067909==
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

Oleg Zhurakivskyy (3):
  plugins: Provisioning plugin autoconf support
  plugins: Provisioning plugin makefile changes
  plugins: Add provisioning plugin

 Makefile.am         |    7 +
 configure.ac        |   19 ++-
 plugins/provision.c |  586 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 606 insertions(+), 6 deletions(-)
 create mode 100644 plugins/provision.c

-- =

1.7.4.1


--===============5725716886942067909==--

