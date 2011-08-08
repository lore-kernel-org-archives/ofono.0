Content-Type: multipart/mixed; boundary="===============0175138649174528941=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 1/2] hfpmodem: fix hf features
Date: Mon, 08 Aug 2011 15:45:41 +0200
Message-ID: <1312811142-13831-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1312811142-13831-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0175138649174528941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

check audio gateway version and only set right features
---
 drivers/hfpmodem/slc.c |    7 ++++++-
 drivers/hfpmodem/slc.h |    2 +-
 plugins/hfp_hf.c       |    2 +-
 plugins/phonesim.c     |    2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index f9eca22..79b4798 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -52,7 +52,7 @@ struct slc_establish_data {
 	gpointer userdata;
 };
 =

-void hfp_slc_info_init(struct hfp_slc_info *info)
+void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version)
 {
 	info->ag_features =3D 0;
 	info->ag_mpty_features =3D 0;
@@ -60,9 +60,14 @@ void hfp_slc_info_init(struct hfp_slc_info *info)
 	info->hf_features =3D HFP_HF_FEATURE_3WAY;
 	info->hf_features |=3D HFP_HF_FEATURE_CLIP;
 	info->hf_features |=3D HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL;
+
+	if (version < 0x0105)
+		goto done;
+
 	info->hf_features |=3D HFP_HF_FEATURE_ENHANCED_CALL_STATUS;
 	info->hf_features |=3D HFP_HF_FEATURE_ENHANCED_CALL_CONTROL;
 =

+done:
 	memset(info->cind_val, 0, sizeof(info->cind_val));
 	memset(info->cind_pos, 0, sizeof(info->cind_pos));
 }
diff --git a/drivers/hfpmodem/slc.h b/drivers/hfpmodem/slc.h
index f37a59c..dd6f926 100644
--- a/drivers/hfpmodem/slc.h
+++ b/drivers/hfpmodem/slc.h
@@ -49,7 +49,7 @@ struct hfp_slc_info {
 	unsigned int cind_val[HFP_INDICATOR_LAST];
 };
 =

-void hfp_slc_info_init(struct hfp_slc_info *info);
+void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version);
 void hfp_slc_info_free(struct hfp_slc_info *info);
 =

 void hfp_slc_establish(struct hfp_slc_info *info, hfp_slc_cb_t connect_cb,
diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 5625141..52423bc 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -223,7 +223,7 @@ static int hfp_hf_probe(const char *device, const char =
*dev_addr,
 	if (data =3D=3D NULL)
 		goto free;
 =

-	hfp_slc_info_init(&data->info);
+	hfp_slc_info_init(&data->info, 0x0105);
 =

 	data->handsfree_path =3D g_strdup(device);
 	if (data->handsfree_path =3D=3D NULL)
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 2b3bcf2..3c094d3 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -880,7 +880,7 @@ static int localhfp_enable(struct ofono_modem *modem)
 =

 	g_at_chat_set_disconnect_function(chat, slc_failed, modem);
 =

-	hfp_slc_info_init(info);
+	hfp_slc_info_init(info, G_MAXUINT16);
 	info->chat =3D chat;
 	hfp_slc_establish(info, slc_established, slc_failed, modem);
 =

-- =

1.7.1


--===============0175138649174528941==--

