Content-Type: multipart/mixed; boundary="===============8149080044835333824=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv8 2/6] plugins: Provisioning plugin makefile changes
Date: Fri, 30 Sep 2011 16:31:10 +0300
Message-ID: <1317389474-16566-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317389474-16566-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8149080044835333824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8771cb2..2704c75 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -381,6 +381,11 @@ builtin_libadd +=3D @BLUEZ_LIBS@
 endif
 endif
 =

+if PROVISION
+builtin_modules +=3D provision
+builtin_sources +=3D plugins/mbpi.c plugins/mbpi.h plugins/provision.c
+endif
+
 if MAINTAINER_MODE
 builtin_modules +=3D example_history
 builtin_sources +=3D examples/history.c
@@ -388,8 +393,10 @@ builtin_sources +=3D examples/history.c
 builtin_modules +=3D example_nettime
 builtin_sources +=3D examples/nettime.c
 =

+if !PROVISION
 builtin_modules +=3D example_provision
 builtin_sources +=3D examples/provision.c
+endif
 =

 builtin_modules +=3D example_emulator
 builtin_sources +=3D examples/emulator.c
-- =

1.7.4.1


--===============8149080044835333824==--

