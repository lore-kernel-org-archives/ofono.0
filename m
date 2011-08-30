Content-Type: multipart/mixed; boundary="===============4212022647843952778=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv5 0/3] Mobile broadband provider info plugin
Date: Tue, 30 Aug 2011 15:56:07 +0300
Message-ID: <1314708970-6521-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4212022647843952778==
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
 plugins/mobile-broadband-provider-info.c |  695 ++++++++++++++++++++++++++=
++++
 3 files changed, 715 insertions(+), 6 deletions(-)
 create mode 100644 plugins/mobile-broadband-provider-info.c

-- =

1.7.4.1


--===============4212022647843952778==--

