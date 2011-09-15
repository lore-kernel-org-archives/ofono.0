Content-Type: multipart/mixed; boundary="===============6673657200017370741=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 04/12] hfp_hf: Plugin creates handsfree atom
Date: Thu, 15 Sep 2011 18:34:35 +0200
Message-ID: <1316104483-13144-5-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1316104483-13144-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6673657200017370741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 6516e75..322edf3 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -41,6 +41,7 @@
 #include <ofono/netreg.h>
 #include <ofono/voicecall.h>
 #include <ofono/call-volume.h>
+#include <ofono/handsfree.h>
 =

 #include <drivers/hfpmodem/slc.h>
 =

@@ -469,6 +470,7 @@ static void hfp_pre_sim(struct ofono_modem *modem)
 	ofono_voicecall_create(modem, 0, "hfpmodem", &data->info);
 	ofono_netreg_create(modem, 0, "hfpmodem", &data->info);
 	ofono_call_volume_create(modem, 0, "hfpmodem", &data->info);
+	ofono_handsfree_create(modem, 0, "hfpmodem", &data->info);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
-- =

1.7.6


--===============6673657200017370741==--

