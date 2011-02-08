Content-Type: multipart/mixed; boundary="===============5364025587155932275=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 6/7] nokiacdma: Add cdma-netreg Support
Date: Tue, 08 Feb 2011 13:04:59 -0800
Message-ID: <1297199100-2712-7-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5364025587155932275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/nokiacdma.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/nokiacdma.c b/plugins/nokiacdma.c
index 7bd224d..946c1f2 100644
--- a/plugins/nokiacdma.c
+++ b/plugins/nokiacdma.c
@@ -44,6 +44,7 @@
 #include <drivers/atmodem/atutil.h>
 #include <ofono/cdma-voicecall.h>
 #include <ofono/devinfo.h>
+#include <ofono/cdma-netreg.h>
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
+	ofono_cdma_netreg_create(modem, 0, "cdmamodem", data->chat);
 }
 =

 static struct ofono_modem_driver nokiacdma_driver =3D {
-- =

1.7.0.4


--===============5364025587155932275==--

