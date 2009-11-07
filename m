Content-Type: multipart/mixed; boundary="===============8955375853147410606=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/3] Add multiparty call support for HFP voicecall driver
Date: Sat, 07 Nov 2009 15:26:12 +0800
Message-ID: <1257578772.2888.17.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8955375853147410606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This feature is to enable CHLD=3D2x, 3 and 4 for multiparty call.
---
 drivers/hfpmodem/voicecall.c |   37
++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 43b4c01..fabcd6d 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -613,6 +613,37 @@ static void hfp_release_specific(struct
ofono_voicecall *vc, int id,
 					swap_hold_cb, req, NULL);
 }
 =

+static void hfp_private_chat(struct ofono_voicecall *vc, int id,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	char buf[32];
+
+	sprintf(buf, "AT+CHLD=3D2%d", id);
+
+	if (check_mpty_feature(vc, AG_CHLD_2x, cb, data))
+		hfp_template(buf, vc, generic_cb, 0, cb, data);
+}
+
+static void hfp_create_multiparty(struct ofono_voicecall *vc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	if (check_mpty_feature(vc, AG_CHLD_3, cb, data))
+		hfp_template("AT+CHLD=3D3", vc, generic_cb, 0, cb, data);
+}
+
+static void hfp_transfer(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	/* Transfer can puts held & active calls together and disconnects
+	 * from both.  However, some networks support transfering of
+	 * dialing/ringing calls as well.
+	 */
+	unsigned int transfer =3D 0x1 | 0x2 | 0x4 | 0x8;
+
+	if (check_mpty_feature(vc, AG_CHLD_4, cb, data))
+		hfp_template("AT+CHLD=3D4", vc, generic_cb, transfer, cb, data);
+}
+
 static void ring_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -1014,9 +1045,9 @@ static struct ofono_voicecall_driver driver =3D {
 	.set_udub		=3D hfp_set_udub,
 	.release_all_active	=3D hfp_release_all_active,
 	.release_specific	=3D hfp_release_specific,
-	.private_chat		=3D NULL,
-	.create_multiparty	=3D NULL,
-	.transfer		=3D NULL,
+	.private_chat		=3D hfp_private_chat,
+	.create_multiparty	=3D hfp_create_multiparty,
+	.transfer		=3D hfp_transfer,
 	.deflect		=3D NULL,
 	.swap_without_accept	=3D NULL,
 	.send_tones		=3D NULL
-- =

1.6.2.5




--===============8955375853147410606==--

