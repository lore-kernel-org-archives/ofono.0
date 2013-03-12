Content-Type: multipart/mixed; boundary="===============7016037638208369358=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 06/15] hfp_hf_bluez5: Add version to HFP 1.5 card driver
Date: Tue, 12 Mar 2013 09:42:04 -0300
Message-ID: <1363092133-1092-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7016037638208369358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index f201b05..1b3b7bc 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -326,6 +326,7 @@ static int card_audio_connect15(const char *remote, con=
st char *local)
 }
 =

 static struct ofono_handsfree_card_driver card_driver15 =3D {
+	.version	=3D HFP_VERSION_1_5,
 	.probe		=3D card_probe,
 	.remove		=3D card_remove,
 	.audio_connect	=3D card_audio_connect15,
-- =

1.7.11.7


--===============7016037638208369358==--

