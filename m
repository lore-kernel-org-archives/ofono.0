Content-Type: multipart/mixed; boundary="===============4559026410893474966=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v2, 2/2] nokiacdma: Add CDMA devinfo support
Date: Thu, 13 Jan 2011 12:52:16 -0800
Message-ID: <1294951936-23868-3-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4559026410893474966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/nokiacdma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/nokiacdma.c b/plugins/nokiacdma.c
index e05c012..7bd224d 100644
--- a/plugins/nokiacdma.c
+++ b/plugins/nokiacdma.c
@@ -43,6 +43,7 @@
 =

 #include <drivers/atmodem/atutil.h>
 #include <ofono/cdma-voicecall.h>
+#include <ofono/devinfo.h>
 =

 #include "common.h"
 =

@@ -137,6 +138,7 @@ static void nokiacdma_pre_sim(struct ofono_modem *modem)
 	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
 =

 	ofono_cdma_voicecall_create(modem, 0, "cdmamodem", data->chat);
+	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
 }
 =

 static void nokiacdma_post_sim(struct ofono_modem *modem)
-- =

1.7.0.4


--===============4559026410893474966==--

