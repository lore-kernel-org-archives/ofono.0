Content-Type: multipart/mixed; boundary="===============4201073272338896083=="
MIME-Version: 1.0
From: christian.lam@nokia.com
Subject: [PATCH 4/7] nokiacdma: add CDMA Connection Manager support
Date: Fri, 21 Jan 2011 15:06:47 -0800
Message-ID: <1295651210-22922-5-git-send-email-christian.lam@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4201073272338896083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christian Lam <christian.lam@nokia.com>

---
 plugins/nokiacdma.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/nokiacdma.c b/plugins/nokiacdma.c
index 7bd224d..808341c 100644
--- a/plugins/nokiacdma.c
+++ b/plugins/nokiacdma.c
@@ -44,6 +44,7 @@
 #include <drivers/atmodem/atutil.h>
 #include <ofono/cdma-voicecall.h>
 #include <ofono/devinfo.h>
+#include <ofono/cdma-connman.h>
 =

 #include "common.h"
 =

@@ -147,7 +148,10 @@ static void nokiacdma_post_sim(struct ofono_modem *mod=
em)
 =

 static void nokiacdma_post_online(struct ofono_modem *modem)
 {
+	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
+	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
 }
 =

 static struct ofono_modem_driver nokiacdma_driver =3D {
-- =

1.7.0.4


--===============4201073272338896083==--

