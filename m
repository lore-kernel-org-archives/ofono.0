Content-Type: multipart/mixed; boundary="===============6879230982946431493=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/2] hfpmodem: Fix ECNR HF feature
Date: Thu, 27 Jun 2013 14:45:57 +0200
Message-ID: <1372337158-20173-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6879230982946431493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/slc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 40b22a1..38a9b2e 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -59,7 +59,8 @@ void hfp_slc_info_init(struct hfp_slc_info *info, guint16=
 version)
 	info->ag_features =3D 0;
 	info->ag_mpty_features =3D 0;
 =

-	info->hf_features =3D HFP_HF_FEATURE_3WAY;
+	info->hf_features =3D HFP_HF_FEATURE_ECNR;
+	info->hf_features |=3D HFP_HF_FEATURE_3WAY;
 	info->hf_features |=3D HFP_HF_FEATURE_CLIP;
 	info->hf_features |=3D HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL;
 =

-- =

1.7.9.5


--===============6879230982946431493==--

