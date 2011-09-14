Content-Type: multipart/mixed; boundary="===============8518123614190683001=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv6 1/3] Mobile broadband provider info plugin makefile changes
Date: Wed, 14 Sep 2011 16:16:42 +0300
Message-ID: <1316006204-11390-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1316006204-11390-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8518123614190683001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 832c8ac..d0fd056 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -376,6 +376,11 @@ builtin_libadd +=3D @BLUEZ_LIBS@
 endif
 endif
 =

+if PROVIDER_INFO
+builtin_modules +=3D mobile_broadband_provider_info
+builtin_sources +=3D plugins/mobile-broadband-provider-info.c
+endif
+
 if MAINTAINER_MODE
 builtin_modules +=3D example_history
 builtin_sources +=3D examples/history.c
@@ -383,8 +388,10 @@ builtin_sources +=3D examples/history.c
 builtin_modules +=3D example_nettime
 builtin_sources +=3D examples/nettime.c
 =

+if !PROVIDER_INFO
 builtin_modules +=3D example_provision
 builtin_sources +=3D examples/provision.c
+endif
 =

 builtin_modules +=3D example_emulator
 builtin_sources +=3D examples/emulator.c
-- =

1.7.4.1


--===============8518123614190683001==--

