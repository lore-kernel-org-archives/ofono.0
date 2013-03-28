Content-Type: multipart/mixed; boundary="===============7475546121125137390=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv4 4/8] hfp_hf_bluez4: Pass vendor on voicecall creation
Date: Thu, 28 Mar 2013 14:36:58 +0100
Message-ID: <d235f3b76015757fbad2495375dac005e48d2d62.1364477353.git.timo.mueller@bmw-carit.de>
In-Reply-To: <9338a6467cc9ba42321bed2d1036275bc15dc790.1364477353.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7475546121125137390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

---
 plugins/hfp_hf_bluez4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez4.c b/plugins/hfp_hf_bluez4.c
index 450c183..e90410c 100644
--- a/plugins/hfp_hf_bluez4.c
+++ b/plugins/hfp_hf_bluez4.c
@@ -46,6 +46,7 @@
 #include <ofono/handsfree.h>
 =

 #include <drivers/hfpmodem/slc.h>
+#include <drivers/hfpmodem/vendor.h>
 =

 #include "bluez4.h"
 =

@@ -482,11 +483,12 @@ static int hfp_disable(struct ofono_modem *modem)
 static void hfp_pre_sim(struct ofono_modem *modem)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	enum ofono_vendor vendor =3D OFONO_VENDOR_GENERIC;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "hfpmodem", data->handsfree_address);
-	ofono_voicecall_create(modem, 0, "hfpmodem", &data->info);
+	ofono_voicecall_create(modem, vendor, "hfpmodem", &data->info);
 	ofono_netreg_create(modem, 0, "hfpmodem", &data->info);
 	ofono_call_volume_create(modem, 0, "hfpmodem", &data->info);
 	ofono_handsfree_create(modem, 0, "hfpmodem", &data->info);
-- =

1.7.11.7


--===============7475546121125137390==--

