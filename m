Content-Type: multipart/mixed; boundary="===============0461055593764189342=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv7 2/3] plugins: Provisioning plugin makefile changes
Date: Fri, 23 Sep 2011 14:41:09 +0300
Message-ID: <1316778070-3862-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1316778070-3862-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0461055593764189342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 71962ea..64681b9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -378,6 +378,11 @@ builtin_libadd +=3D @BLUEZ_LIBS@
 endif
 endif
 =

+if PROVISION
+builtin_modules +=3D provision
+builtin_sources +=3D plugins/provision.c
+endif
+
 if MAINTAINER_MODE
 builtin_modules +=3D example_history
 builtin_sources +=3D examples/history.c
@@ -385,8 +390,10 @@ builtin_sources +=3D examples/history.c
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


--===============0461055593764189342==--

