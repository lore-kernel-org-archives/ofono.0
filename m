Content-Type: multipart/mixed; boundary="===============4156579891507029645=="
MIME-Version: 1.0
From: KrzysztofX Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 8/8] phonesim: Enable Siri atom
Date: Mon, 16 Dec 2013 17:52:44 +0000
Message-ID: <1387216364-7138-9-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1387216364-7138-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4156579891507029645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c | 2 ++
 1 file changed, 2 insertions(+)
 mode change 100644 =3D> 100755 plugins/phonesim.c

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
old mode 100644
new mode 100755
index b56b3ca..918d2eb
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -60,6 +60,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/gnss.h>
 #include <ofono/handsfree.h>
+#include <ofono/siri.h>
 =

 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/atutil.h>
@@ -957,6 +958,7 @@ static void localhfp_pre_sim(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "hfpmodem", info);
 	ofono_call_volume_create(modem, 0, "hfpmodem", info);
 	ofono_handsfree_create(modem, 0, "hfpmodem", info);
+	ofono_siri_create(modem, 0, "hfpmodem", info);
 }
 =

 static struct ofono_modem_driver localhfp_driver =3D {
-- =

1.7.11.7


--===============4156579891507029645==--

