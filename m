Content-Type: multipart/mixed; boundary="===============0091284807416347763=="
MIME-Version: 1.0
From: Jesper Larsen <jesper.larsen@ixonos.com>
Subject: [PATCH 3/3] sim900: Fix order of dlc prefixes
Date: Wed, 17 Jul 2013 09:14:15 +0200
Message-ID: <1374045255-26600-4-git-send-email-jesper.larsen@ixonos.com>
In-Reply-To: <1374045255-26600-3-git-send-email-jesper.larsen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0091284807416347763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The order of the defines for the dlc prefixes does not match
the order of the array containing the strings to print.
---
 plugins/sim900.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/sim900.c b/plugins/sim900.c
index 3b4fd84..a7728cd 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -49,11 +49,11 @@
 =

 #define NUM_DLC 5
 =

-#define SETUP_DLC   0
-#define VOICE_DLC   1
-#define NETREG_DLC  2
-#define SMS_DLC     3
-#define GPRS_DLC    4
+#define VOICE_DLC   0
+#define NETREG_DLC  1
+#define SMS_DLC     2
+#define GPRS_DLC    3
+#define SETUP_DLC   4
 =

 static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "SMS: ",
 					"GPRS: " , "Setup: "};
-- =

1.7.10.4


--===============0091284807416347763==--

