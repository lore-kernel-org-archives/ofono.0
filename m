Content-Type: multipart/mixed; boundary="===============2252863664823184126=="
MIME-Version: 1.0
From: KrzysztofX Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 6/8] hfp_hf_bluez4: Enable Siri atom
Date: Mon, 16 Dec 2013 17:52:42 +0000
Message-ID: <1387216364-7138-7-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1387216364-7138-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2252863664823184126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez4.c | 2 ++
 1 file changed, 2 insertions(+)
 mode change 100644 =3D> 100755 plugins/hfp_hf_bluez4.c

diff --git a/plugins/hfp_hf_bluez4.c b/plugins/hfp_hf_bluez4.c
old mode 100644
new mode 100755
index 450c183..fb491a1
--- a/plugins/hfp_hf_bluez4.c
+++ b/plugins/hfp_hf_bluez4.c
@@ -44,6 +44,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/call-volume.h>
 #include <ofono/handsfree.h>
+#include <ofono/siri.h>
 =

 #include <drivers/hfpmodem/slc.h>
 =

@@ -490,6 +491,7 @@ static void hfp_pre_sim(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "hfpmodem", &data->info);
 	ofono_call_volume_create(modem, 0, "hfpmodem", &data->info);
 	ofono_handsfree_create(modem, 0, "hfpmodem", &data->info);
+	ofono_siri_create(modem, 0, "hfpmodem", &data->info);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
-- =

1.7.11.7


--===============2252863664823184126==--

