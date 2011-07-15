Content-Type: multipart/mixed; boundary="===============5084800681705899561=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 3/3] Mobile broadband provider info plugin makefile changes
Date: Fri, 15 Jul 2011 18:12:17 +0300
Message-ID: <1310742737-5254-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1310742737-5254-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5084800681705899561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 6f5d921..f5ac225 100644
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
@@ -365,9 +370,6 @@ builtin_sources +=3D examples/history.c
 builtin_modules +=3D example_nettime
 builtin_sources +=3D examples/nettime.c
 =

-builtin_modules +=3D example_provision
-builtin_sources +=3D examples/provision.c
-
 builtin_modules +=3D example_emulator
 builtin_sources +=3D examples/emulator.c
 =

-- =

1.7.1


--===============5084800681705899561==--

