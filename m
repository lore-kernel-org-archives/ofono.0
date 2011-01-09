Content-Type: multipart/mixed; boundary="===============3123086433712310963=="
MIME-Version: 1.0
From: Wei, Jun <jun.wei@intel.com>
Subject: [PATCH v2 4/4] Cell-info: New file included in compilation
Date: Sun, 09 Jan 2011 22:06:23 +0800
Message-ID: <1A42CE6F5F474C41B63392A5F80372B231DCEE46@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1294490472-26637-1-git-send-email-jun.wei@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3123086433712310963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Wei, Jun =

Sent: Saturday, January 08, 2011 8:41 PM
To: ofono(a)ofono.org
Cc: Wei, Jun
Subject: [PATCH v2 4/4] Cell-info: New file included in compilation

From: Jun Wei <jun.wei@intel.com>

---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 679e4bf..2393c53 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -222,7 +222,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/ifxmodem/audio-settings.c \
 			drivers/ifxmodem/radio-settings.c \
 			drivers/ifxmodem/gprs-context.c \
-			drivers/ifxmodem/stk.c
+			drivers/ifxmodem/stk.c \
+			drivers/ifxmodem/cell-info.c
 =

 builtin_modules +=3D stemodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
-- =

1.7.2.3


--===============3123086433712310963==--

