Content-Type: multipart/mixed; boundary="===============1591168677130781423=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 0/3] Mobile broadband provider info plugin
Date: Fri, 15 Jul 2011 18:12:14 +0300
Message-ID: <1310742737-5254-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1591168677130781423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the mobile broadband provider info plugin ("Internet Access Pro=
vider database" TODO item).

If enabled, the plugin reads mobile-broadband-provider-info database entrie=
s (PROVIDER_DATABASE) and returns GRPS context settings to oFono provisioni=
ng module.

Regards,
Oleg

Oleg Zhurakivskyy (3):
  Mobile broadband provider info plugin
  Mobile broadband provider info plugin autoconf support
  Mobile broadband provider info plugin makefile changes

 Makefile.am                              |    8 +-
 configure.ac                             |   19 ++-
 plugins/mobile-broadband-provider-info.c |  293 ++++++++++++++++++++++++++=
++++
 3 files changed, 311 insertions(+), 9 deletions(-)
 create mode 100644 plugins/mobile-broadband-provider-info.c


--===============1591168677130781423==--

