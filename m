Content-Type: multipart/mixed; boundary="===============0338254029609994566=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv4 3/8] hfpmodem: Add vendor information to voicecall data
Date: Thu, 28 Mar 2013 14:36:57 +0100
Message-ID: <9338a6467cc9ba42321bed2d1036275bc15dc790.1364477353.git.timo.mueller@bmw-carit.de>
In-Reply-To: <9bde6a432e213f194801663767ac4d3aa6cfa45c.1364477353.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0338254029609994566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

---
 drivers/hfpmodem/voicecall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 33dd05e..08e13f0 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -35,6 +35,7 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/voicecall.h>
+#include "vendor.h"
 =

 #include "common.h"
 =

@@ -60,6 +61,7 @@ struct voicecall_data {
 	unsigned int clcc_source;
 	unsigned int expect_release_source;
 	unsigned int clip_source;
+	enum ofono_vendor vendor;
 };
 =

 struct release_id_req {
@@ -1135,6 +1137,7 @@ static int hfp_voicecall_probe(struct ofono_voicecall=
 *vc, unsigned int vendor,
 	vd->chat =3D g_at_chat_clone(info->chat);
 	vd->ag_features =3D info->ag_features;
 	vd->ag_mpty_features =3D info->ag_mpty_features;
+	vd->vendor =3D vendor;
 =

 	memcpy(vd->cind_pos, info->cind_pos, HFP_INDICATOR_LAST);
 	memcpy(vd->cind_val, info->cind_val, HFP_INDICATOR_LAST);
-- =

1.7.11.7


--===============0338254029609994566==--

