Content-Type: multipart/mixed; boundary="===============1350863745742383823=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 06/13] hfp_hf_bluez5: Add version to HFP 1.5 card driver
Date: Fri, 08 Mar 2013 20:11:18 -0300
Message-ID: <1362784285-22731-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362784285-22731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1350863745742383823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 4524e13..00159fa 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -326,6 +326,7 @@ static int card_audio_connect(const char *remote, const=
 char *local)
 }
 =

 static struct ofono_handsfree_card_driver card_driver15 =3D {
+	.version	=3D HFP_VERSION_1_5,
 	.probe		=3D card_probe,
 	.remove		=3D card_remove,
 	.audio_connect	=3D card_audio_connect,
-- =

1.7.11.7


--===============1350863745742383823==--

