Content-Type: multipart/mixed; boundary="===============5625987374316901928=="
MIME-Version: 1.0
From: KrzysztofX Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 7/8] hfp_hf_bluez5: Enable Siri atom
Date: Mon, 16 Dec 2013 17:52:43 +0000
Message-ID: <1387216364-7138-8-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1387216364-7138-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5625987374316901928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 2 ++
 1 file changed, 2 insertions(+)
 mode change 100644 =3D> 100755 plugins/hfp_hf_bluez5.c

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
old mode 100644
new mode 100755
index 18ed348..aaf779d
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -48,6 +48,7 @@
 #include <ofono/call-volume.h>
 #include <ofono/handsfree.h>
 #include <ofono/handsfree-audio.h>
+#include <ofono/siri.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/hfpmodem/slc.h>
@@ -296,6 +297,7 @@ static void hfp_pre_sim(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "hfpmodem", &hfp->info);
 	ofono_handsfree_create(modem, 0, "hfpmodem", &hfp->info);
 	ofono_call_volume_create(modem, 0, "hfpmodem", &hfp->info);
+	ofono_siri_create(modem, 0, "hfpmodem", &hfp->info);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
-- =

1.7.11.7


--===============5625987374316901928==--

