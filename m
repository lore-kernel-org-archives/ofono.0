Content-Type: multipart/mixed; boundary="===============3013990757999338961=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv4 5/8] hfp_hf_bluez5: Pass vendor on voicecall creation
Date: Thu, 28 Mar 2013 14:36:59 +0100
Message-ID: <aac717cd780a496577d592375d4cc600a5ea0e3e.1364477353.git.timo.mueller@bmw-carit.de>
In-Reply-To: <d235f3b76015757fbad2495375dac005e48d2d62.1364477353.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3013990757999338961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

---
 plugins/hfp_hf_bluez5.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index ff8afba..563bb0f 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -50,6 +50,7 @@
 #include <ofono/handsfree-audio.h>
 =

 #include <drivers/hfpmodem/slc.h>
+#include <drivers/hfpmodem/vendor.h>
 =

 #include "bluetooth.h"
 #include "bluez5.h"
@@ -283,12 +284,14 @@ static int hfp_disable(struct ofono_modem *modem)
 static void hfp_pre_sim(struct ofono_modem *modem)
 {
 	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	enum ofono_vendor vendor =3D OFONO_VENDOR_GENERIC;
+
 	char *address =3D (char *) ofono_modem_get_string(modem, "Remote");
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "hfpmodem", address);
-	ofono_voicecall_create(modem, 0, "hfpmodem", &hfp->info);
+	ofono_voicecall_create(modem, vendor, "hfpmodem", &hfp->info);
 	ofono_netreg_create(modem, 0, "hfpmodem", &hfp->info);
 	ofono_handsfree_create(modem, 0, "hfpmodem", &hfp->info);
 	ofono_call_volume_create(modem, 0, "hfpmodem", &hfp->info);
-- =

1.7.11.7


--===============3013990757999338961==--

