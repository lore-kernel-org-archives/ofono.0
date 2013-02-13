Content-Type: multipart/mixed; boundary="===============5076339049514175817=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv3 2/3] hfp_hf: Add generic hfp modem vendor
Date: Wed, 13 Feb 2013 09:36:10 +0100
Message-ID: <d928220c40964749f7c79822563087cdf3af74a1.1360663430.git.timo.mueller@bmw-carit.de>
In-Reply-To: <da43e0125ebcdf570d287d3d84fbf139cc2bfa9e.1360663430.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5076339049514175817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

---
 drivers/hfpmodem/vendor.h    | 25 +++++++++++++++++++++++++
 drivers/hfpmodem/voicecall.c |  3 +++
 plugins/hfp_hf_bluez4.c      |  4 +++-
 plugins/hfp_hf_bluez5.c      |  5 ++++-
 4 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hfpmodem/vendor.h

diff --git a/drivers/hfpmodem/vendor.h b/drivers/hfpmodem/vendor.h
new file mode 100644
index 0000000..fca847a
--- /dev/null
+++ b/drivers/hfpmodem/vendor.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013  BWM Car IT GmbH. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+enum ofono_vendor {
+	OFONO_VENDOR_GENERIC =3D 0
+};
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 9b05dbc..7d2988e 100644
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
+	unsigned int vendor;
 };
 =

 struct release_id_req {
@@ -1170,6 +1172,7 @@ static int hfp_voicecall_probe(struct ofono_voicecall=
 *vc, unsigned int vendor,
 	vd->chat =3D g_at_chat_clone(info->chat);
 	vd->ag_features =3D info->ag_features;
 	vd->ag_mpty_features =3D info->ag_mpty_features;
+	vd->vendor =3D vendor;
 =

 	memcpy(vd->cind_pos, info->cind_pos, HFP_INDICATOR_LAST);
 	memcpy(vd->cind_val, info->cind_val, HFP_INDICATOR_LAST);
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
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2f4a89e..c57bb6e 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -49,6 +49,7 @@
 #include <ofono/handsfree.h>
 =

 #include <drivers/hfpmodem/slc.h>
+#include <drivers/hfpmodem/vendor.h>
 =

 #include "bluez5.h"
 =

@@ -237,12 +238,14 @@ static int hfp_disable(struct ofono_modem *modem)
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


--===============5076339049514175817==--

