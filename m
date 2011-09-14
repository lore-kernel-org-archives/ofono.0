Content-Type: multipart/mixed; boundary="===============0002496951768916939=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv6 0/3] Mobile broadband provider info plugin
Date: Wed, 14 Sep 2011 16:16:41 +0300
Message-ID: <1316006204-11390-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0002496951768916939==
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
 plugins/mobile-broadband-provider-info.c |  804 ++++++++++++++++++++++++++=
++++
 3 files changed, 824 insertions(+), 6 deletions(-)
 create mode 100644 plugins/mobile-broadband-provider-info.c

-- =

1.7.4.1


--===============0002496951768916939==--

