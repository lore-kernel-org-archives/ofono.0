Content-Type: multipart/mixed; boundary="===============4746935244572615560=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 0/5] Mobile broadband provider info plugin
Date: Fri, 05 Aug 2011 15:25:57 +0300
Message-ID: <1312547162-26420-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4746935244572615560==
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

Oleg Zhurakivskyy (5):
  Mobile broadband provider info plugin
  GPRS context plan support
  GPRS provisioning data plan support
  Mobile broadband provider info plugin autoconf support
  Mobile broadband provider info plugin makefile changes

 Makefile.am                              |    7 +
 configure.ac                             |   19 +-
 include/gprs-context.h                   |    5 +
 include/gprs-provision.h                 |    1 +
 plugins/mobile-broadband-provider-info.c |  470 ++++++++++++++++++++++++++=
++++
 5 files changed, 496 insertions(+), 6 deletions(-)
 create mode 100644 plugins/mobile-broadband-provider-info.c


--===============4746935244572615560==--

