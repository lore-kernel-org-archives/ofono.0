Content-Type: multipart/mixed; boundary="===============7400800440535698501=="
MIME-Version: 1.0
From: Frank Gau <fgau@gau-net.de>
Subject: [PATCH] calypso: update power and reset path
Date: Mon, 27 Sep 2010 16:05:14 +0200
Message-ID: <1285596314-3186-1-git-send-email-fgau@gau-net.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7400800440535698501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/calypso.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/calypso.c b/plugins/calypso.c
index ea55ed4..130fa6e 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -58,8 +58,8 @@
 =

 #include <drivers/atmodem/vendor.h>
 =

-#define CALYPSO_POWER_PATH "/sys/bus/platform/devices/neo1973-pm-gsm.0/pow=
er_on"
-#define CALYPSO_RESET_PATH "/sys/bus/platform/devices/neo1973-pm-gsm.0/res=
et"
+#define CALYPSO_POWER_PATH "/sys/bus/platform/devices/gta02-pm-gsm.0/power=
_on"
+#define CALYPSO_RESET_PATH "/sys/bus/platform/devices/gta02-pm-gsm.0/reset"
 =

 enum powercycle_state {
 	POWERCYCLE_STATE_POWER0 =3D 0,
-- =

1.7.1



--===============7400800440535698501==--

