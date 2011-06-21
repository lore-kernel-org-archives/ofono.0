Content-Type: multipart/mixed; boundary="===============2369802784560923704=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 2/4] hfp_hf: update to use new HFP enums
Date: Tue, 21 Jun 2011 14:49:47 +0200
Message-ID: <1308660589-2187-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1308660589-2187-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2369802784560923704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 12d3457..8a76701 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -174,7 +174,7 @@ static void cmer_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 		return;
 	}
 =

-	if (data->ag_features & AG_FEATURE_3WAY)
+	if (data->ag_features & HFP_AG_FEATURE_3WAY)
 		g_at_chat_send(data->chat, "AT+CHLD=3D?", chld_prefix,
 			chld_cb, modem, NULL);
 	else
@@ -418,11 +418,11 @@ static int hfp_create_modem(const char *device, const=
 char *dev_addr,
 	if (data =3D=3D NULL)
 		goto free;
 =

-	data->hf_features |=3D HF_FEATURE_3WAY;
-	data->hf_features |=3D HF_FEATURE_CLIP;
-	data->hf_features |=3D HF_FEATURE_REMOTE_VOLUME_CONTROL;
-	data->hf_features |=3D HF_FEATURE_ENHANCED_CALL_STATUS;
-	data->hf_features |=3D HF_FEATURE_ENHANCED_CALL_CONTROL;
+	data->hf_features |=3D HFP_HF_FEATURE_3WAY;
+	data->hf_features |=3D HFP_HF_FEATURE_CLIP;
+	data->hf_features |=3D HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL;
+	data->hf_features |=3D HFP_HF_FEATURE_ENHANCED_CALL_STATUS;
+	data->hf_features |=3D HFP_HF_FEATURE_ENHANCED_CALL_CONTROL;
 =

 	data->handsfree_path =3D g_strdup(device);
 	if (data->handsfree_path =3D=3D NULL)
-- =

1.7.1


--===============2369802784560923704==--

