Content-Type: multipart/mixed; boundary="===============1788925881159754526=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 5/5] Mobile broadband provider info plugin makefile changes
Date: Fri, 05 Aug 2011 15:26:02 +0300
Message-ID: <1312547162-26420-6-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1312547162-26420-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1788925881159754526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 6f5d921..7df0fd3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -358,6 +358,11 @@ builtin_libadd +=3D @BLUEZ_LIBS@
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
@@ -365,8 +370,10 @@ builtin_sources +=3D examples/history.c
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

1.7.1


--===============1788925881159754526==--

