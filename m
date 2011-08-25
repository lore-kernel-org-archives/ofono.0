Content-Type: multipart/mixed; boundary="===============3689242290659641885=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 0/3] Mobile broadband provider info plugin
Date: Thu, 25 Aug 2011 14:23:03 +0300
Message-ID: <1314271386-23201-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3689242290659641885==
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
  Mobile broadband provider info plugin makefile changes
  Mobile broadband provider info plugin autoconf support
  Mobile broadband provider info plugin

 Makefile.am                              |    7 +
 configure.ac                             |   19 +-
 plugins/mobile-broadband-provider-info.c |  604 ++++++++++++++++++++++++++=
++++
 3 files changed, 624 insertions(+), 6 deletions(-)
 create mode 100644 plugins/mobile-broadband-provider-info.c

-- =

1.7.4.1


--===============3689242290659641885==--

